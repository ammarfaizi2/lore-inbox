Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261447AbSJPVfP>; Wed, 16 Oct 2002 17:35:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261448AbSJPVen>; Wed, 16 Oct 2002 17:34:43 -0400
Received: from ztxmail03.ztx.compaq.com ([161.114.1.207]:56848 "EHLO
	ztxmail03.ztx.compaq.com") by vger.kernel.org with ESMTP
	id <S261447AbSJPVec>; Wed, 16 Oct 2002 17:34:32 -0400
Date: Wed, 16 Oct 2002 15:36:45 -0600
From: Stephen Cameron <steve.cameron@hp.com>
To: linux-kernel@vger.kernel.org
Cc: axboe@suse.de
Subject: [PATCH 4/8] 2.5.43 cciss kill bogus cciss_scsi init code
Message-ID: <20021016153645.D2968@zuul.cca.cpqcorp.net>
Reply-To: steve.cameron@hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Remove unneeded cciss_scsi init code

diff -urN linux-2.5.43-c/drivers/block/cciss.c linux-2.5.43-d/drivers/block/cciss.c
--- linux-2.5.43-c/drivers/block/cciss.c	Wed Oct 16 08:18:43 2002
+++ linux-2.5.43-d/drivers/block/cciss.c	Wed Oct 16 08:22:21 2002
@@ -2454,9 +2454,6 @@
 		set_capacity(disk, drv->nr_blocks);
 		add_disk(disk);
 	}
-
-	cciss_register_scsi(i, 1);  /* hook ourself into SCSI subsystem */
-
 	return(1);
 }
 
diff -urN linux-2.5.43-c/drivers/block/cciss_scsi.c linux-2.5.43-d/drivers/block/cciss_scsi.c
--- linux-2.5.43-c/drivers/block/cciss_scsi.c	Wed Oct 16 08:17:57 2002
+++ linux-2.5.43-d/drivers/block/cciss_scsi.c	Wed Oct 16 08:21:44 2002
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
