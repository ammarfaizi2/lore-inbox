Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262210AbSJNVH0>; Mon, 14 Oct 2002 17:07:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262230AbSJNVH0>; Mon, 14 Oct 2002 17:07:26 -0400
Received: from mailout.zma.compaq.com ([161.114.64.105]:14604 "EHLO
	zmamail05.zma.compaq.com") by vger.kernel.org with ESMTP
	id <S262210AbSJNVHN>; Mon, 14 Oct 2002 17:07:13 -0400
Date: Mon, 14 Oct 2002 15:09:23 -0600
From: Stephen Cameron <steve.cameron@hp.com>
To: linux-kernel@vger.kernel.org
Cc: axboe@suse.de
Subject: [PATCH] 2.5.42, cciss, kill bogus cciss_scsi code (3 of 7)
Message-ID: <20021014150923.C1257@zuul.cca.cpqcorp.net>
Reply-To: steve.cameron@hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


patch 3 of 7
kill some bogus code in cciss_scsi.c that doesn't do anything useful.
Applies to 2.5.42

diff -urN linux-2.5.42-c/drivers/block/cciss.c linux-2.5.42-d/drivers/block/cciss.c
--- linux-2.5.42-c/drivers/block/cciss.c	Mon Oct 14 10:19:07 2002
+++ linux-2.5.42-d/drivers/block/cciss.c	Mon Oct 14 10:28:19 2002
@@ -2455,9 +2455,6 @@
 		set_capacity(disk, drv->nr_blocks);
 		add_disk(disk);
 	}
-
-	cciss_register_scsi(i, 1);  /* hook ourself into SCSI subsystem */
-
 	return(1);
 }
 
diff -urN linux-2.5.42-c/drivers/block/cciss_scsi.c linux-2.5.42-d/drivers/block/cciss_scsi.c
--- linux-2.5.42-c/drivers/block/cciss_scsi.c	Mon Oct 14 10:18:56 2002
+++ linux-2.5.42-d/drivers/block/cciss_scsi.c	Mon Oct 14 10:28:19 2002
@@ -89,8 +89,10 @@
    working even with the SCSI system.  It's so 
    scsi_unregister_host will differentiate the controllers. 
    When register_scsi_module is called, each host template is 
-   customized (name change) in cciss_register_scsi() 
-   (that's called from cciss.c:cciss_init_one()) */
+   customized (name change) in cciss_register_scsi() (that's
+   called from cciss_engage_scsi, called from
+   cciss.c:cciss_proc_write(), on "engage scsi" being received
+   from user space.) */
 
 static 
 Scsi_Host_Template driver_template[MAX_CTLR] =
@@ -1549,7 +1551,7 @@
 }
 
 static int 
-cciss_register_scsi(int ctlr, int this_is_init_time)
+cciss_register_scsi(int ctlr)
 {
 	unsigned long flags;
 
@@ -1559,15 +1561,10 @@
 	driver_template[ctlr].module = THIS_MODULE;;
 
 	/* Since this is really a block driver, the SCSI core may not be 
-	   initialized yet, in which case, calling scsi_register_host
-	   would hang.  instead, we will do it later, via /proc filesystem 
+	   initialized at init time, in which case, calling scsi_register_host
+	   would hang.  Instead, we do it later, via /proc filesystem
 	   and rc scripts, when we know SCSI core is good to go. */
 
-	if (this_is_init_time) {
-		CPQ_TAPE_UNLOCK(ctlr, flags);
-		return 0;
-	}
-
 	/* Only register if SCSI devices are detected. */
 	if (ccissscsi[ctlr].ndevices != 0) {
 		((struct cciss_scsi_adapter_data_t *) 
@@ -1601,7 +1598,7 @@
 	}
 	spin_unlock_irqrestore(CCISS_LOCK(ctlr), flags);
 	cciss_update_non_disk_devices(ctlr, -1);
-	cciss_register_scsi(ctlr, 0);
+	cciss_register_scsi(ctlr);
 	return 0;
 }
 
@@ -1627,7 +1624,7 @@
 
 #define cciss_find_non_disk_devices(cntl_num)
 #define cciss_unregister_scsi(ctlr)
-#define cciss_register_scsi(ctlr, this_is_init_time)
+#define cciss_register_scsi(ctlr)
 #define cciss_proc_tape_report(ctlr, buffer, pos, len)
 
 #endif /* CONFIG_CISS_SCSI_TAPE */
