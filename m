Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265054AbSJWP2L>; Wed, 23 Oct 2002 11:28:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265055AbSJWP2L>; Wed, 23 Oct 2002 11:28:11 -0400
Received: from ztxmail04.ztx.compaq.com ([161.114.1.208]:30224 "EHLO
	ztxmail04.ztx.compaq.com") by vger.kernel.org with ESMTP
	id <S265054AbSJWP2J>; Wed, 23 Oct 2002 11:28:09 -0400
Date: Wed, 23 Oct 2002 09:30:24 -0600
From: Stephen Cameron <steve.cameron@hp.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 5/10] 2.5.44 cciss kill bogus scsi code
Message-ID: <20021023093024.E14917@zuul.cca.cpqcorp.net>
Reply-To: steve.cameron@hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

patch 5 of 10
The whole set can be grabbed via anonymous cvs (empty password):
cvs -d:pserver:anonymous@cvs.cciss.sourceforge.net:/cvsroot/cciss login
cvs -z3 -d:pserver:anonymous@cvs.cciss.sourceforge.net:/cvsroot/cciss co 2.5.44

DESC
Remove unneeded cciss_scsi init code


 drivers/block/cciss.c      |    3 ---
 drivers/block/cciss_scsi.c |   21 +++++++++------------
 2 files changed, 9 insertions, 15 deletions

--- linux-2.5.44/drivers/block/cciss.c~kill_bogus_scsi_code	Mon Oct 21 12:05:54 2002
+++ linux-2.5.44-root/drivers/block/cciss.c	Mon Oct 21 12:05:54 2002
@@ -2446,9 +2446,6 @@ static int __init cciss_init_one(struct 
 		set_capacity(disk, drv->nr_blocks);
 		add_disk(disk);
 	}
-
-	cciss_register_scsi(i, 1);  /* hook ourself into SCSI subsystem */
-
 	return(1);
 }
 
--- linux-2.5.44/drivers/block/cciss_scsi.c~kill_bogus_scsi_code	Mon Oct 21 12:05:54 2002
+++ linux-2.5.44-root/drivers/block/cciss_scsi.c	Mon Oct 21 12:05:54 2002
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
@@ -1531,7 +1533,7 @@ cciss_unregister_scsi(int ctlr)
 }
 
 static int 
-cciss_register_scsi(int ctlr, int this_is_init_time)
+cciss_register_scsi(int ctlr)
 {
 	unsigned long flags;
 
@@ -1541,15 +1543,10 @@ cciss_register_scsi(int ctlr, int this_i
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
@@ -1583,7 +1580,7 @@ cciss_engage_scsi(int ctlr)
 	}
 	spin_unlock_irqrestore(CCISS_LOCK(ctlr), flags);
 	cciss_update_non_disk_devices(ctlr, -1);
-	cciss_register_scsi(ctlr, 0);
+	cciss_register_scsi(ctlr);
 	return 0;
 }
 
@@ -1609,7 +1606,7 @@ cciss_proc_tape_report(int ctlr, unsigne
 
 #define cciss_find_non_disk_devices(cntl_num)
 #define cciss_unregister_scsi(ctlr)
-#define cciss_register_scsi(ctlr, this_is_init_time)
+#define cciss_register_scsi(ctlr)
 #define cciss_proc_tape_report(ctlr, buffer, pos, len)
 
 #endif /* CONFIG_CISS_SCSI_TAPE */

.
