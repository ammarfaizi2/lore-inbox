Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261486AbUKODBj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261486AbUKODBj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 22:01:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261508AbUKODBN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 22:01:13 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:10251 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261487AbUKOCs2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 21:48:28 -0500
Date: Mon, 15 Nov 2004 03:37:12 +0100
From: Adrian Bunk <bunk@stusta.de>
To: matthew@wil.cx
Cc: James.Bottomley@SteelEye.com, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] SCSI sym53c8xx_2: make some code static
Message-ID: <20041115023712.GD2249@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below makes some needlessly global code static.


diffstat output:
 drivers/scsi/sym53c8xx_2/sym_glue.c |    6 +++---
 drivers/scsi/sym53c8xx_2/sym_glue.h |    1 -
 drivers/scsi/sym53c8xx_2/sym_hipd.c |    3 ++-
 drivers/scsi/sym53c8xx_2/sym_hipd.h |    1 -
 4 files changed, 5 insertions(+), 6 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm5-full/drivers/scsi/sym53c8xx_2/sym_glue.h.old	2004-11-14 01:33:22.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/drivers/scsi/sym53c8xx_2/sym_glue.h	2004-11-14 01:33:29.000000000 +0100
@@ -550,7 +550,6 @@
 #define sym_cam_target_lun(ccb)	(ccb)->lun
 #define	sym_freeze_cam_ccb(ccb)	do { ; } while (0)
 void sym_xpt_done(hcb_p np, cam_ccb_p ccb);
-void sym_xpt_done2(hcb_p np, cam_ccb_p ccb, int cam_status);
 void sym_print_addr (ccb_p cp);
 void sym_xpt_async_bus_reset(hcb_p np);
 void sym_xpt_async_sent_bdr(hcb_p np, int target);
--- linux-2.6.10-rc1-mm5-full/drivers/scsi/sym53c8xx_2/sym_glue.c.old	2004-11-14 01:32:27.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/drivers/scsi/sym53c8xx_2/sym_glue.c	2004-11-14 01:33:10.000000000 +0100
@@ -147,7 +147,7 @@
 }
 
 /* This lock protects only the memory allocation/free.  */
-spinlock_t sym53c8xx_lock = SPIN_LOCK_UNLOCKED;
+static spinlock_t sym53c8xx_lock = SPIN_LOCK_UNLOCKED;
 
 static struct scsi_transport_template *sym2_transport_template = NULL;
 
@@ -285,7 +285,7 @@
 	ccb->scsi_done(ccb);
 }
 
-void sym_xpt_done2(struct sym_hcb *np, struct scsi_cmnd *ccb, int cam_status)
+static void sym_xpt_done2(struct sym_hcb *np, struct scsi_cmnd *ccb, int cam_status)
 {
 	sym_set_cam_status(ccb, cam_status);
 	sym_xpt_done(np, ccb);
@@ -2010,7 +2010,7 @@
  * the preset SCSI ID (which may be zero) must be read in from
  * a special configuration space register of the 875.
  */
-void sym_config_pqs(struct pci_dev *pdev, struct sym_device *sym_dev)
+static void sym_config_pqs(struct pci_dev *pdev, struct sym_device *sym_dev)
 {
 	int slot;
 	u8 tmp;
--- linux-2.6.10-rc1-mm5-full/drivers/scsi/sym53c8xx_2/sym_hipd.h.old	2004-11-14 01:34:13.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/drivers/scsi/sym53c8xx_2/sym_hipd.h	2004-11-14 01:34:24.000000000 +0100
@@ -1098,7 +1098,6 @@
 #endif
 void sym_start_up (hcb_p np, int reason);
 void sym_interrupt (hcb_p np);
-void sym_flush_comp_queue(hcb_p np, int cam_status);
 int sym_clear_tasks(hcb_p np, int cam_status, int target, int lun, int task);
 ccb_p sym_get_ccb (hcb_p np, u_char tn, u_char ln, u_char tag_order);
 void sym_free_ccb (hcb_p np, ccb_p cp);
--- linux-2.6.10-rc1-mm5-full/drivers/scsi/sym53c8xx_2/sym_hipd.c.old	2004-11-14 01:34:32.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/drivers/scsi/sym53c8xx_2/sym_hipd.c	2004-11-14 01:34:58.000000000 +0100
@@ -55,6 +55,7 @@
 static void sym_complete_error (hcb_p np, ccb_p cp);
 static void sym_complete_ok (hcb_p np, ccb_p cp);
 static int sym_compute_residual(hcb_p np, ccb_p cp);
+static void sym_flush_comp_queue(hcb_p np, int cam_status);
 
 /*
  *  Returns the name of this driver.
@@ -3038,7 +3039,7 @@
  *  This function is called when all CCBs involved 
  *  in error handling/recovery have been reaped.
  */
-void sym_flush_comp_queue(hcb_p np, int cam_status)
+static void sym_flush_comp_queue(hcb_p np, int cam_status)
 {
 	SYM_QUEHEAD *qp;
 	ccb_p cp;

