Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264072AbUDQWN3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 18:13:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264060AbUDQWN3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 18:13:29 -0400
Received: from verein.lst.de ([212.34.189.10]:43455 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S263125AbUDQWJv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 18:09:51 -0400
Date: Sun, 18 Apr 2004 00:09:46 +0200
From: Christoph Hellwig <hch@lst.de>
To: jejb@steeleye.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] convert imm and ppa to modern scsi types
Message-ID: <20040417220946.GA2719@lst.de>
Mail-Followup-To: Christoph Hellwig <hch>, jejb@steeleye.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just saw I had this still lying around here.  No functional changes.


--- 1.35/drivers/scsi/imm.c	Sun Feb  8 08:41:26 2004
+++ edited/drivers/scsi/imm.c	Sun Feb 22 21:34:11 2004
@@ -12,6 +12,18 @@
  */
 
 #include <linux/config.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/blkdev.h>
+#include <linux/parport.h>
+#include <linux/workqueue.h>
+#include <asm/io.h>
+
+#include <scsi/scsi.h>
+#include <scsi/scsi_cmnd.h>
+#include <scsi/scsi_device.h>
+#include <scsi/scsi_host.h>
 
 /* The following #define is to avoid a clash with hosts.c */
 #define IMM_PROBE_SPP   0x0001
@@ -20,22 +32,13 @@
 #define IMM_PROBE_EPP17 0x0100
 #define IMM_PROBE_EPP19 0x0200
 
-#include <linux/init.h>
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/blkdev.h>
-#include <asm/io.h>
-#include <linux/parport.h>
-#include <linux/workqueue.h>
-#include "scsi.h"
-#include "hosts.h"
 
 typedef struct {
 	struct pardevice *dev;	/* Parport device entry         */
 	int base;		/* Actual port address          */
 	int base_hi;		/* Hi Base address for ECP-ISA chipset */
 	int mode;		/* Transfer mode                */
-	Scsi_Cmnd *cur_cmd;	/* Current queued command       */
+	struct scsi_cmnd *cur_cmd;	/* Current queued command       */
 	struct work_struct imm_tq;	/* Polling interrupt stuff       */
 	unsigned long jstart;	/* Jiffies at start             */
 	unsigned failed:1;	/* Failure flag                 */
@@ -613,7 +616,7 @@
 	return device_check(dev);
 }
 
-static inline int imm_send_command(Scsi_Cmnd *cmd)
+static inline int imm_send_command(struct scsi_cmnd *cmd)
 {
 	imm_struct *dev = imm_dev(cmd->device->host);
 	int k;
@@ -633,7 +636,7 @@
  * The driver appears to remain stable if we speed up the parallel port
  * i/o in this function, but not elsewhere.
  */
-static int imm_completion(Scsi_Cmnd *cmd)
+static int imm_completion(struct scsi_cmnd *cmd)
 {
 	/* Return codes:
 	 * -1     Error
@@ -736,7 +739,7 @@
 static void imm_interrupt(void *data)
 {
 	imm_struct *dev = (imm_struct *) data;
-	Scsi_Cmnd *cmd = dev->cur_cmd;
+	struct scsi_cmnd *cmd = dev->cur_cmd;
 	struct Scsi_Host *host = cmd->device->host;
 	unsigned long flags;
 
@@ -796,7 +799,7 @@
 	return;
 }
 
-static int imm_engine(imm_struct *dev, Scsi_Cmnd *cmd)
+static int imm_engine(imm_struct *dev, struct scsi_cmnd *cmd)
 {
 	unsigned short ppb = dev->base;
 	unsigned char l = 0, h = 0;
@@ -937,7 +940,8 @@
 	return 0;
 }
 
-static int imm_queuecommand(Scsi_Cmnd *cmd, void (*done)(Scsi_Cmnd *))
+static int imm_queuecommand(struct scsi_cmnd *cmd,
+		void (*done)(struct scsi_cmnd *))
 {
 	imm_struct *dev = imm_dev(cmd->device->host);
 
@@ -980,7 +984,7 @@
 	return 0;
 }
 
-static int imm_abort(Scsi_Cmnd *cmd)
+static int imm_abort(struct scsi_cmnd *cmd)
 {
 	imm_struct *dev = imm_dev(cmd->device->host);
 	/*
@@ -1012,7 +1016,7 @@
 	w_ctr(base, 0x04);
 }
 
-static int imm_reset(Scsi_Cmnd *cmd)
+static int imm_reset(struct scsi_cmnd *cmd)
 {
 	imm_struct *dev = imm_dev(cmd->device->host);
 
@@ -1114,7 +1118,7 @@
 	return -ENODEV;
 }
 
-static Scsi_Host_Template imm_template = {
+static struct scsi_host_template imm_template = {
 	.module			= THIS_MODULE,
 	.proc_name		= "imm",
 	.proc_info		= imm_proc_info,
===== drivers/scsi/imm.h 1.19 vs edited =====
--- 1.19/drivers/scsi/imm.h	Thu Feb  5 09:53:11 2004
+++ edited/drivers/scsi/imm.h	Sun Feb 22 21:38:29 2004
@@ -139,6 +139,6 @@
 #define w_ctr(x,y)      outb(y, (x)+2)
 #endif
 
-static int imm_engine(imm_struct *, Scsi_Cmnd *);
+static int imm_engine(imm_struct *, struct scsi_cmnd *);
 
 #endif				/* _IMM_H */
===== drivers/scsi/ppa.c 1.37 vs edited =====
--- 1.37/drivers/scsi/ppa.c	Sun Feb  8 08:41:26 2004
+++ edited/drivers/scsi/ppa.c	Sun Feb 22 21:36:06 2004
@@ -15,18 +15,23 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/blkdev.h>
-#include <asm/io.h>
 #include <linux/parport.h>
 #include <linux/workqueue.h>
-#include "scsi.h"
-#include "hosts.h"
+#include <asm/io.h>
+
+#include <scsi/scsi.h>
+#include <scsi/scsi_cmnd.h>
+#include <scsi/scsi_device.h>
+#include <scsi/scsi_host.h>
+
+
 static void ppa_reset_pulse(unsigned int base);
 
 typedef struct {
 	struct pardevice *dev;	/* Parport device entry         */
 	int base;		/* Actual port address          */
 	int mode;		/* Transfer mode                */
-	Scsi_Cmnd *cur_cmd;	/* Current queued command       */
+	struct scsi_cmnd *cur_cmd;	/* Current queued command       */
 	struct work_struct ppa_tq;	/* Polling interrupt stuff       */
 	unsigned long jstart;	/* Jiffies at start             */
 	unsigned long recon_tmo;	/* How many usecs to wait for reconnection (6th bit) */
@@ -501,7 +506,7 @@
 	return device_check(dev);
 }
 
-static inline int ppa_send_command(Scsi_Cmnd *cmd)
+static inline int ppa_send_command(struct scsi_cmnd *cmd)
 {
 	ppa_struct *dev = ppa_dev(cmd->device->host);
 	int k;
@@ -522,7 +527,7 @@
  * The driver appears to remain stable if we speed up the parallel port
  * i/o in this function, but not elsewhere.
  */
-static int ppa_completion(Scsi_Cmnd *cmd)
+static int ppa_completion(struct scsi_cmnd *cmd)
 {
 	/* Return codes:
 	 * -1     Error
@@ -626,7 +631,7 @@
 static void ppa_interrupt(void *data)
 {
 	ppa_struct *dev = (ppa_struct *) data;
-	Scsi_Cmnd *cmd = dev->cur_cmd;
+	struct scsi_cmnd *cmd = dev->cur_cmd;
 
 	if (!cmd) {
 		printk("PPA: bug in ppa_interrupt\n");
@@ -682,7 +687,7 @@
 	cmd->scsi_done(cmd);
 }
 
-static int ppa_engine(ppa_struct *dev, Scsi_Cmnd *cmd)
+static int ppa_engine(ppa_struct *dev, struct scsi_cmnd *cmd)
 {
 	unsigned short ppb = dev->base;
 	unsigned char l = 0, h = 0;
@@ -802,7 +807,8 @@
 	return 0;
 }
 
-static int ppa_queuecommand(Scsi_Cmnd *cmd, void (*done) (Scsi_Cmnd *))
+static int ppa_queuecommand(struct scsi_cmnd *cmd,
+		void (*done) (struct scsi_cmnd *))
 {
 	ppa_struct *dev = ppa_dev(cmd->device->host);
 
@@ -847,7 +853,7 @@
 	return 0;
 }
 
-static int ppa_abort(Scsi_Cmnd *cmd)
+static int ppa_abort(struct scsi_cmnd *cmd)
 {
 	ppa_struct *dev = ppa_dev(cmd->device->host);
 	/*
@@ -875,7 +881,7 @@
 	w_ctr(base, 0xc);
 }
 
-static int ppa_reset(Scsi_Cmnd *cmd)
+static int ppa_reset(struct scsi_cmnd *cmd)
 {
 	ppa_struct *dev = ppa_dev(cmd->device->host);
 
@@ -974,7 +980,7 @@
 	return -ENODEV;
 }
 
-static Scsi_Host_Template ppa_template = {
+static struct scsi_host_template ppa_template = {
 	.module			= THIS_MODULE,
 	.proc_name		= "ppa",
 	.proc_info		= ppa_proc_info,
===== drivers/scsi/ppa.h 1.14 vs edited =====
--- 1.14/drivers/scsi/ppa.h	Thu Feb  5 09:53:58 2004
+++ edited/drivers/scsi/ppa.h	Sun Feb 22 21:38:12 2004
@@ -146,6 +146,6 @@
 #define w_ctr(x,y)      outb(y, (x)+2)
 #endif
 
-static int ppa_engine(ppa_struct *, Scsi_Cmnd *);
+static int ppa_engine(ppa_struct *, struct scsi_cmnd *);
 
 #endif				/* _PPA_H */
