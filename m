Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263356AbTIWT5T (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 15:57:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263394AbTIWT5T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 15:57:19 -0400
Received: from paiol.terra.com.br ([200.176.3.18]:56803 "EHLO
	paiol.terra.com.br") by vger.kernel.org with ESMTP id S263356AbTIWT5N
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 15:57:13 -0400
Message-ID: <3F709E0D.7090307@terra.com.br>
Date: Tue, 23 Sep 2003 16:25:01 -0300
From: Felipe W Damasio <felipewd@terra.com.br>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Memory leak in mtd/chips/cfi_cmdset_0020.c
Content-Type: multipart/mixed;
 boundary="------------010308070407000803010003"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010308070407000803010003
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

	Hi Andrew,

	Patch against 2.6-test5.

	If other kmallocs failed after successfully allocating a "struct 
mtd_info", it should be freed before returning NULL.

	This function is called by inter_module_register...so I'm not sure it 
should really be freed...please review :)

	Don't have the hardware, so just compilation checked.

	Found by the Stanford Checker.

	Thanks,

Felipe

--------------010308070407000803010003
Content-Type: text/plain;
 name="cfi-0020-leak.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cfi-0020-leak.patch"

--- linux-2.6.0-test5/drivers/mtd/chips/cfi_cmdset_0020.c.orig	2003-09-23 16:15:35.000000000 -0300
+++ linux-2.6.0-test5/drivers/mtd/chips/cfi_cmdset_0020.c	2003-09-23 16:18:48.000000000 -0300
@@ -208,6 +208,7 @@
 	if (!mtd->eraseregions) { 
 		printk(KERN_ERR "Failed to allocate memory for MTD erase region info\n");
 		kfree(cfi->cmdset_priv);
+		kfree(mtd);
 		return NULL;
 	}
 	
@@ -232,6 +233,7 @@
 			printk(KERN_WARNING "Sum of regions (%lx) != total size of set of interleaved chips (%lx)\n", offset, devsize);
 			kfree(mtd->eraseregions);
 			kfree(cfi->cmdset_priv);
+			kfree(mtd);
 			return NULL;
 		}
 

--------------010308070407000803010003--

