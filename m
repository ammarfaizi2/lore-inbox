Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266316AbUHMRyg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266316AbUHMRyg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 13:54:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266366AbUHMRyg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 13:54:36 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:25541 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S266316AbUHMRxO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 13:53:14 -0400
Date: Fri, 13 Aug 2004 12:53:09 -0500
From: Greg Howard <ghoward@sgi.com>
X-X-Sender: ghoward@gallifrey.americas.sgi.com
To: Andrew Morton <akpm@osdl.org>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] [2.6.8-rc4-mm1] Altix system controller fixes
Message-ID: <Pine.SGI.4.58.0408131234380.6409@gallifrey.americas.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

This patch corrects some problems that you and Jesse Barnes spotted in
my last patch to the Altix system controller communication driver.

Thanks - Greg

Changelog:
The Altix system controller communication driver currently exits the
read and write routines with semaphores still held in some error
conditions; fix this.  Also remove an unnecessary typecast, and use
wake_up() instead of wake_up_all() for waking up processes waiting to
send or receive data.  Update drivers/char/Kconfig to enable this
driver for IA64_GENERIC kernels, and update the generic_defconfig to
include it in kernel builds.

 arch/ia64/configs/generic_defconfig |    1 +
 drivers/char/Kconfig                |    2 +-
 drivers/char/snsc.c                 |   14 ++++++++++----
 3 files changed, 12 insertions(+), 5 deletions(-)

diff -uprN -X dontdiff original/arch/ia64/configs/generic_defconfig changed/arch/ia64/configs/generic_defconfig
--- original/arch/ia64/configs/generic_defconfig	2004-08-09 21:22:51.000000000 -0500
+++ changed/arch/ia64/configs/generic_defconfig	2004-08-12 17:17:57.000000000 -0500
@@ -576,6 +576,7 @@ CONFIG_SERIAL_NONSTANDARD=y
 # CONFIG_SYNCLINKMP is not set
 # CONFIG_N_HDLC is not set
 # CONFIG_STALDRV is not set
+CONFIG_SGI_SNSC=y

 #
 # Serial drivers
diff -uprN -X dontdiff original/drivers/char/Kconfig changed/drivers/char/Kconfig
--- original/drivers/char/Kconfig	2004-08-12 17:14:23.000000000 -0500
+++ changed/drivers/char/Kconfig	2004-08-12 17:17:57.000000000 -0500
@@ -426,7 +426,7 @@ config A2232

 config SGI_SNSC
 	bool "SGI Altix system controller communication support"
-	depends on IA64_SGI_SN2
+	depends on (IA64_SGI_SN2 || IA64_GENERIC)
 	help
 	  If you have an SGI Altix and you want to enable system
 	  controller communication from user space (you want this!),
diff -uprN -X dontdiff original/drivers/char/snsc.c changed/drivers/char/snsc.c
--- original/drivers/char/snsc.c	2004-08-12 17:14:23.000000000 -0500
+++ changed/drivers/char/snsc.c	2004-08-12 17:17:57.000000000 -0500
@@ -33,7 +33,7 @@
 static irqreturn_t
 scdrv_interrupt(int irq, void *subch_data, struct pt_regs *regs)
 {
-	struct subch_data_s *sd = (struct subch_data_s *) subch_data;
+	struct subch_data_s *sd = subch_data;
 	unsigned long flags;
 	int status;

@@ -43,13 +43,13 @@ scdrv_interrupt(int irq, void *subch_dat

 	if (status > 0) {
 		if (status & SAL_IROUTER_INTR_RECV) {
-			wake_up_all(&sd->sd_rq);
+			wake_up(&sd->sd_rq);
 		}
 		if (status & SAL_IROUTER_INTR_XMIT) {
 			ia64_sn_irtr_intr_disable
 			    (sd->sd_nasid, sd->sd_subch,
 			     SAL_IROUTER_INTR_XMIT);
-			wake_up_all(&sd->sd_wq);
+			wake_up(&sd->sd_wq);
 		}
 	}
 	spin_unlock(&sd->sd_wlock);
@@ -184,6 +184,7 @@ scdrv_read(struct file *file, char __use

 		if (file->f_flags & O_NONBLOCK) {
 			spin_unlock_irqrestore(&sd->sd_rlock, flags);
+			up(&sd->sd_rbs);
 			return -EAGAIN;
 		}

@@ -197,6 +198,7 @@ scdrv_read(struct file *file, char __use
 		remove_wait_queue(&sd->sd_rq, &wait);
 		if (signal_pending(current)) {
 			/* wait was interrupted */
+			up(&sd->sd_rbs);
 			return -ERESTARTSYS;
 		}

@@ -264,8 +266,10 @@ scdrv_write(struct file *file, const cha
 	}

 	count = min((int) count, CHUNKSIZE);
-	if (copy_from_user(sd->sd_wb, buf, count))
+	if (copy_from_user(sd->sd_wb, buf, count)) {
+		up(&sd->sd_wbs);
 		return -EFAULT;
+	}

 	/* try to send the buffer */
 	spin_lock_irqsave(&sd->sd_wlock, flags);
@@ -277,6 +281,7 @@ scdrv_write(struct file *file, const cha

 		if (file->f_flags & O_NONBLOCK) {
 			spin_unlock(&sd->sd_wlock);
+			up(&sd->sd_wbs);
 			return -EAGAIN;
 		}

@@ -289,6 +294,7 @@ scdrv_write(struct file *file, const cha
 		remove_wait_queue(&sd->sd_wq, &wait);
 		if (signal_pending(current)) {
 			/* wait was interrupted */
+			up(&sd->sd_wbs);
 			return -ERESTARTSYS;
 		}

