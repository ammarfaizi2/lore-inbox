Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263430AbTIWTMA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 15:12:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263427AbTIWTKo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 15:10:44 -0400
Received: from ivoti.terra.com.br ([200.176.3.20]:32207 "EHLO
	ivoti.terra.com.br") by vger.kernel.org with ESMTP id S263410AbTIWTJr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 15:09:47 -0400
Message-ID: <3F709719.6030107@terra.com.br>
Date: Tue, 23 Sep 2003 15:55:21 -0300
From: Felipe W Damasio <felipewd@terra.com.br>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
MIME-Version: 1.0
To: Felipe W Damasio <felipewd@terra.com.br>
Cc: James.Bottomley@SteelEye.com, linux-scsi@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Memory leak in scsi_debug found by checker
References: <3F7096EE.8080105@terra.com.br>
In-Reply-To: <3F7096EE.8080105@terra.com.br>
Content-Type: multipart/mixed;
 boundary="------------090306080801020104080500"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090306080801020104080500
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

	Forgot the patch :)

Felipe W Damasio wrote:
>     Hi James,
> 
>     Patch against 2.6-test5.
> 
>     If in the middle of loop a kmalloc failed, that means that the 
> previous calls succeeded..so they must be also be freed (and removed 
> from the dev_info_list).
> 
>     Please review and consider applying.
> 
>     Cheers,
> 
> Felipe
> 

--------------090306080801020104080500
Content-Type: text/plain;
 name="scsi_debug-leak.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="scsi_debug-leak.patch"

--- linux-2.6.0-test5/drivers/scsi/scsi_debug.c.orig	2003-09-23 15:46:57.000000000 -0300
+++ linux-2.6.0-test5/drivers/scsi/scsi_debug.c	2003-09-23 15:43:39.000000000 -0300
@@ -1614,7 +1614,7 @@
                         printk(KERN_ERR "%s: out of memory at line %d\n",
                                __FUNCTION__, __LINE__);
                         error = -ENOMEM;
-			goto clean1;
+			goto clean;
                 }
                 memset(sdbg_devinfo, 0, sizeof(*sdbg_devinfo));
                 sdbg_devinfo->sdbg_host = sdbg_host;
@@ -1634,12 +1634,12 @@
         error = device_register(&sdbg_host->dev);
 
         if (error)
-		goto clean2;
+		goto clean;
 
 	++scsi_debug_add_host;
         return error;
 
-clean2:
+clean:
 	list_for_each_safe(lh, lh_sf, &sdbg_host->dev_info_list) {
 		sdbg_devinfo = list_entry(lh, struct sdebug_dev_info,
 					  dev_list);
@@ -1647,7 +1647,6 @@
 		kfree(sdbg_devinfo);
 	}
 
-clean1:
 	kfree(sdbg_host);
         return error;
 }

--------------090306080801020104080500--

