Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261746AbTIVW4C (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 18:56:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261808AbTIVW4B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 18:56:01 -0400
Received: from fw.osdl.org ([65.172.181.6]:9186 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261746AbTIVWzV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 18:55:21 -0400
Date: Mon, 22 Sep 2003 15:55:13 -0700
From: Chris Wright <chrisw@osdl.org>
To: David Yu Chen <dychen@stanford.edu>
Cc: linux-kernel@vger.kernel.org, mc@cs.stanford.edu,
       James.Bottomley@SteelEye.com
Subject: Re: [CHECKER] 32 Memory Leaks on Error Paths
Message-ID: <20030922155513.F18606@osdlab.pdx.osdl.net>
References: <200309160435.h8G4ZkQM009953@elaine4.Stanford.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200309160435.h8G4ZkQM009953@elaine4.Stanford.EDU>; from dychen@stanford.edu on Mon, Sep 15, 2003 at 09:35:46PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* David Yu Chen (dychen@stanford.edu) wrote:
> [FILE:  2.6.0-test5/drivers/scsi/scsi_debug.c]
> [FUNC:  sdebug_add_adapter]
> [LINES: 1612-1652]
> [VAR:   sdbg_devinfo]
> 1607:        memset(sdbg_host, 0, sizeof(*sdbg_host));
> 1608:        INIT_LIST_HEAD(&sdbg_host->dev_info_list);
> 1609:
> 1610:	devs_per_host = scsi_debug_num_tgts * scsi_debug_max_luns;
> 1611:        for (k = 0; k < devs_per_host; k++) {
> START -->
> 1612:                sdbg_devinfo = kmalloc(sizeof(*sdbg_devinfo),GFP_KERNEL);
> 1613:                if (NULL == sdbg_devinfo) {
> 1614:                        printk(KERN_ERR "%s: out of memory at line %d\n",
> 1615:                               __FUNCTION__, __LINE__);
> 1616:                        error = -ENOMEM;
> GOTO -->
> 1617:			goto clean1;
>         ... DELETED 29 lines ...
> 1647:		kfree(sdbg_devinfo);
> 1648:	}
> 1649:
> 1650:clean1:
> 1651:	kfree(sdbg_host);
> END -->
> 1652:        return error;

Yes, this could leak sdbg_devinfo structs.  Patch below.  James, look ok?

thanks,
-chris

===== drivers/scsi/scsi_debug.c 1.44 vs edited =====
--- 1.44/drivers/scsi/scsi_debug.c	Fri Aug 15 10:07:53 2003
+++ edited/drivers/scsi/scsi_debug.c	Mon Sep 22 15:27:17 2003
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
