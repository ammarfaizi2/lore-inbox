Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267682AbTBLTKi>; Wed, 12 Feb 2003 14:10:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267683AbTBLTKh>; Wed, 12 Feb 2003 14:10:37 -0500
Received: from mailin.zma.compaq.com ([161.114.64.101]:64529 "EHLO
	zmamail01.zma.compaq.com") by vger.kernel.org with ESMTP
	id <S267682AbTBLTKf>; Wed, 12 Feb 2003 14:10:35 -0500
Date: Wed, 12 Feb 2003 13:21:02 +0600
From: steve cameron <steve.cameron@hp.com>
To: linux-kernel@vger.kernel.org
Cc: axboe@suse.de
Subject: Re: [PATCH] 2.5.60 make cciss driver compile
Message-ID: <20030212072102.GH1032@zuul.cca.cpqcorp.net>
Reply-To: steve.cameron@hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Remove unneeded cciss_scsi init code from cciss driver.
(patch 8 of 11)
-- steve 

--- linux-2.5.60/drivers/block/cciss.c~kill_bogus_scsi_code	2003-02-12 10:13:08.000000000 +0600
+++ linux-2.5.60-scameron/drivers/block/cciss.c	2003-02-12 10:13:08.000000000 +0600
@@ -2440,9 +2440,6 @@ static int __init cciss_init_one(struct 
 		set_capacity(disk, drv->nr_blocks);
 		add_disk(disk);
 	}
-
-	cciss_register_scsi(i, 1);  /* hook ourself into SCSI subsystem */
-
 	return(1);
 }
 
--- linux-2.5.60/drivers/block/cciss_scsi.c~kill_bogus_scsi_code	2003-02-12 10:13:08.000000000 +0600
+++ linux-2.5.60-scameron/drivers/block/cciss_scsi.c	2003-02-12 10:13:08.000000000 +0600
@@ -89,8 +89,10 @@ static struct cciss_scsi_hba_t ccissscsi
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
@@ -1530,7 +1532,7 @@ cciss_unregister_scsi(int ctlr)
 }
 
 static int 
-cciss_register_scsi(int ctlr, int this_is_init_time)
+cciss_register_scsi(int ctlr)
 {
 	unsigned long flags;
 
@@ -1540,15 +1542,10 @@ cciss_register_scsi(int ctlr, int this_i
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
@@ -1582,7 +1579,7 @@ cciss_engage_scsi(int ctlr)
 	}
 	spin_unlock_irqrestore(CCISS_LOCK(ctlr), flags);
 	cciss_update_non_disk_devices(ctlr, -1);
-	cciss_register_scsi(ctlr, 0);
+	cciss_register_scsi(ctlr);
 	return 0;
 }
 
@@ -1608,7 +1605,7 @@ cciss_proc_tape_report(int ctlr, unsigne
 
 #define cciss_find_non_disk_devices(cntl_num)
 #define cciss_unregister_scsi(ctlr)
-#define cciss_register_scsi(ctlr, this_is_init_time)
+#define cciss_register_scsi(ctlr)
 #define cciss_proc_tape_report(ctlr, buffer, pos, len)
 
 #endif /* CONFIG_CISS_SCSI_TAPE */

_
