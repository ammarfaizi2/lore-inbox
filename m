Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261785AbSJIOde>; Wed, 9 Oct 2002 10:33:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261788AbSJIOde>; Wed, 9 Oct 2002 10:33:34 -0400
Received: from ztxmail04.ztx.compaq.com ([161.114.1.208]:783 "EHLO
	ztxmail04.ztx.compaq.com") by vger.kernel.org with ESMTP
	id <S261785AbSJIOdc>; Wed, 9 Oct 2002 10:33:32 -0400
Date: Wed, 9 Oct 2002 08:35:21 -0600
From: Stephen Cameron <steve.cameron@hp.com>
To: linux-kernel@vger.kernel.org
Cc: axboe@suse.de
Subject: [PATCH] 2.5.41, cciss, tape code cleanup (3 of 5)
Message-ID: <20021009083521.C6746@zuul.cca.cpqcorp.net>
Reply-To: steve.cameron@hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch removes a bit of bogus code that doesn't actually do 
anything anymore.  (Was related to cciss tape drive code which
once upon a time tried to engage the scsi subsystem at init time, 
which can't be done as block drivers load before the scsi
subsystem is ready.) -- steve

diff -urN linux-2.5.41-0/drivers/block/cciss.c linux-2.5.41-b/drivers/block/cciss.c
--- linux-2.5.41-0/drivers/block/cciss.c	Mon Oct  7 14:35:37 2002
+++ linux-2.5.41-b/drivers/block/cciss.c	Mon Oct  7 14:59:31 2002
@@ -2454,9 +2454,6 @@
 		set_capacity(disk, drv->nr_blocks);
 		add_disk(disk);
 	}
-
-	cciss_register_scsi(i, 1);  /* hook ourself into SCSI subsystem */
-
 	return(1);
 }
 
diff -urN linux-2.5.41-0/drivers/block/cciss_scsi.c linux-2.5.41-b/drivers/block/cciss_scsi.c
--- linux-2.5.41-0/drivers/block/cciss_scsi.c	Fri Sep 27 16:49:15 2002
+++ linux-2.5.41-b/drivers/block/cciss_scsi.c	Mon Oct  7 14:59:11 2002
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
