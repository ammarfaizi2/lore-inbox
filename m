Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263958AbTD0MnT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Apr 2003 08:43:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263978AbTD0MnT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Apr 2003 08:43:19 -0400
Received: from dp.samba.org ([66.70.73.150]:26561 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263958AbTD0MnH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Apr 2003 08:43:07 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16043.53682.887962.683181@nanango.paulus.ozlabs.org>
Date: Sun, 27 Apr 2003 22:48:50 +1000 (EST)
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/macintosh irq handler type
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch changes the interrupt handler routines in four of the
macintosh-specific drivers to return an irqreturn_t value.

Please apply.

Thanks,
Paul.

diff -urN linux-2.5/drivers/macintosh/macio-adb.c pmac-2.5/drivers/macintosh/macio-adb.c
--- linux-2.5/drivers/macintosh/macio-adb.c	2003-04-03 12:12:13.000000000 +1000
+++ pmac-2.5/drivers/macintosh/macio-adb.c	2003-04-23 23:08:25.000000000 +1000
@@ -63,7 +63,7 @@
 
 static int macio_probe(void);
 static int macio_init(void);
-static void macio_adb_interrupt(int irq, void *arg, struct pt_regs *regs);
+static irqreturn_t macio_adb_interrupt(int irq, void *arg, struct pt_regs *regs);
 static int macio_send_request(struct adb_request *req, int sync);
 static int macio_adb_autopoll(int devs);
 static void macio_adb_poll(void);
@@ -198,7 +198,8 @@
 	return 0;
 }
 
-static void macio_adb_interrupt(int irq, void *arg, struct pt_regs *regs)
+static irqreturn_t macio_adb_interrupt(int irq, void *arg,
+				       struct pt_regs *regs)
 {
 	int i, n, err;
 	struct adb_request *req;
@@ -206,9 +207,11 @@
 	int ibuf_len = 0;
 	int complete = 0;
 	int autopoll = 0;
-	
+	int handled = 0;
+
 	spin_lock(&macio_lock);
 	if (in_8(&adb->intr.r) & TAG) {
+		handled = 1;
 		if ((req = current_req) != 0) {
 			/* put the current request in */
 			for (i = 0; i < req->nbytes; ++i)
@@ -229,6 +232,7 @@
 	}
 
 	if (in_8(&adb->intr.r) & DFB) {
+		handled = 1;
 		err = in_8(&adb->error.r);
 		if (current_req && current_req->sent) {
 			/* this is the response to a command */
@@ -266,6 +270,8 @@
 	}
 	if (ibuf_len)
 		adb_input(ibuf, ibuf_len, regs, autopoll);
+
+	return IRQ_RETVAL(handled);
 }
 
 static void macio_adb_poll(void)
diff -urN linux-2.5/drivers/macintosh/macserial.c pmac-2.5/drivers/macintosh/macserial.c
--- linux-2.5/drivers/macintosh/macserial.c	2003-04-25 22:19:44.000000000 +1000
+++ pmac-2.5/drivers/macintosh/macserial.c	2003-04-27 17:48:26.000000000 +1000
@@ -154,8 +154,8 @@
 static int setup_scc(struct mac_serial * info);
 static void dbdma_reset(volatile struct dbdma_regs *dma);
 static void dbdma_flush(volatile struct dbdma_regs *dma);
-static void rs_txdma_irq(int irq, void *dev_id, struct pt_regs *regs);
-static void rs_rxdma_irq(int irq, void *dev_id, struct pt_regs *regs);
+static irqreturn_t rs_txdma_irq(int irq, void *dev_id, struct pt_regs *regs);
+static irqreturn_t rs_rxdma_irq(int irq, void *dev_id, struct pt_regs *regs);
 static void dma_init(struct mac_serial * info);
 static void rxdma_start(struct mac_serial * info, int current);
 static void rxdma_to_tty(struct mac_serial * info);
@@ -558,18 +558,19 @@
 /*
  * This is the serial driver's generic interrupt routine
  */
-static void rs_interrupt(int irq, void *dev_id, struct pt_regs * regs)
+static irqreturn_t rs_interrupt(int irq, void *dev_id, struct pt_regs * regs)
 {
 	struct mac_serial *info = (struct mac_serial *) dev_id;
 	unsigned char zs_intreg;
 	int shift;
 	unsigned long flags;
+	int handled = 0;
 
 	if (!(info->flags & ZILOG_INITIALIZED)) {
 		printk(KERN_WARNING "rs_interrupt: irq %d, port not "
 				    "initialized\n", irq);
 		disable_irq(irq);
-		return;
+		return IRQ_NONE;
 	}
 
 	/* NOTE: The read register 3, which holds the irq status,
@@ -595,6 +596,7 @@
 
 		if ((zs_intreg & CHAN_IRQMASK) == 0)
 			break;
+		handled = 1;
 
 		if (zs_intreg & CHBRxIP) {
 			/* If we are doing DMA, we only ask for interrupts
@@ -610,30 +612,32 @@
 			status_handle(info);
 	}
 	spin_unlock_irqrestore(&info->lock, flags);
+	return IRQ_RETVAL(handled);
 }
 
 /* Transmit DMA interrupt - not used at present */
-static void rs_txdma_irq(int irq, void *dev_id, struct pt_regs *regs)
+static irqreturn_t rs_txdma_irq(int irq, void *dev_id, struct pt_regs *regs)
 {
+	return IRQ_HANDLED;
 }
 
 /*
  * Receive DMA interrupt.
  */
-static void rs_rxdma_irq(int irq, void *dev_id, struct pt_regs *regs)
+static irqreturn_t rs_rxdma_irq(int irq, void *dev_id, struct pt_regs *regs)
 {
 	struct mac_serial *info = (struct mac_serial *) dev_id;
 	volatile struct dbdma_cmd *cd;
 
 	if (!info->dma_initted)
-		return;
+		return IRQ_NONE;
 	spin_lock(&info->rx_dma_lock);
 	/* First, confirm that this interrupt is, indeed, coming */
 	/* from Rx DMA */
 	cd = info->rx_cmds[info->rx_cbuf] + 2;
 	if ((in_le16(&cd->xfer_status) & (RUN | ACTIVE)) != (RUN | ACTIVE)) {
 		spin_unlock(&info->rx_dma_lock);
-		return;
+		return IRQ_NONE;
 	}
 	if (info->rx_fbuf != RX_NO_FBUF) {
 		info->rx_cbuf = info->rx_fbuf;
@@ -643,6 +647,7 @@
 			info->rx_fbuf = RX_NO_FBUF;
 	}
 	spin_unlock(&info->rx_dma_lock);
+	return IRQ_HANDLED;
 }
 
 /*
@@ -2660,9 +2665,9 @@
 	callout_driver.proc_entry = 0;
 
 	if (tty_register_driver(&serial_driver))
-		panic("Couldn't register serial driver\n");
+		printk(KERN_ERR "Error: couldn't register serial driver\n");
 	if (tty_register_driver(&callout_driver))
-		panic("Couldn't register callout driver\n");
+		printk(KERN_ERR "Error: couldn't register callout driver\n");
 
 	for (channel = 0; channel < zs_channels_found; ++channel) {
 #ifdef CONFIG_KGDB
diff -urN linux-2.5/drivers/macintosh/via-cuda.c pmac-2.5/drivers/macintosh/via-cuda.c
--- linux-2.5/drivers/macintosh/via-cuda.c	2003-03-23 18:24:16.000000000 +1100
+++ pmac-2.5/drivers/macintosh/via-cuda.c	2003-04-23 23:08:08.000000000 +1000
@@ -107,7 +107,7 @@
 
 static int cuda_init_via(void);
 static void cuda_start(void);
-static void cuda_interrupt(int irq, void *arg, struct pt_regs *regs);
+static irqreturn_t cuda_interrupt(int irq, void *arg, struct pt_regs *regs);
 static void cuda_input(unsigned char *buf, int nb, struct pt_regs *regs);
 void cuda_poll(void);
 static int cuda_write(struct adb_request *req);
@@ -441,7 +441,7 @@
     local_irq_restore(flags);
 }
 
-static void
+static irqreturn_t
 cuda_interrupt(int irq, void *arg, struct pt_regs *regs)
 {
     int status;
@@ -457,7 +457,7 @@
     out_8(&via[IFR], virq);   
     if ((virq & SR_INT) == 0) {
         spin_unlock(&cuda_lock);
-	return;
+	return IRQ_NONE;
     }
     
     status = (~in_8(&via[B]) & (TIP|TREQ)) | (in_8(&via[ACR]) & SR_OUT);
@@ -595,6 +595,7 @@
     }
     if (ibuf_len)
 	cuda_input(ibuf, ibuf_len, regs);
+    return IRQ_HANDLED;
 }
 
 static void
diff -urN linux-2.5/drivers/macintosh/via-pmu.c pmac-2.5/drivers/macintosh/via-pmu.c
--- linux-2.5/drivers/macintosh/via-pmu.c	2003-03-24 09:18:49.000000000 +1100
+++ pmac-2.5/drivers/macintosh/via-pmu.c	2003-04-23 21:42:40.000000000 +1000
@@ -180,8 +180,8 @@
 static int init_pmu(void);
 static int pmu_queue_request(struct adb_request *req);
 static void pmu_start(void);
-static void via_pmu_interrupt(int irq, void *arg, struct pt_regs *regs);
-static void gpio1_interrupt(int irq, void *arg, struct pt_regs *regs);
+static irqreturn_t via_pmu_interrupt(int irq, void *arg, struct pt_regs *regs);
+static irqreturn_t gpio1_interrupt(int irq, void *arg, struct pt_regs *regs);
 static int proc_get_info(char *page, char **start, off_t off,
 			  int count, int *eof, void *data);
 #ifdef CONFIG_PMAC_BACKLIGHT
@@ -1393,7 +1393,7 @@
 	return NULL;
 }
 
-static void __pmac
+static irqreturn_t __pmac
 via_pmu_interrupt(int irq, void *arg, struct pt_regs *regs)
 {
 	unsigned long flags;
@@ -1401,7 +1401,8 @@
 	int nloop = 0;
 	int int_data = -1;
 	struct adb_request *req = NULL;
-	
+	int handled = 0;
+
 	/* This is a bit brutal, we can probably do better */
 	spin_lock_irqsave(&pmu_lock, flags);
 	++disable_poll;
@@ -1410,6 +1411,7 @@
 		intr = in_8(&via[IFR]) & (SR_INT | CB1_INT);
 		if (intr == 0)
 			break;
+		handled = 1;
 		if (++nloop > 1000) {
 			printk(KERN_DEBUG "PMU: stuck in intr loop, "
 			       "intr=%x, ier=%x pmu_state=%d\n",
@@ -1473,15 +1475,19 @@
 		int_data = -1;
 		goto recheck;
 	}
+
+	return IRQ_RETVAL(handled);
 }
 
-static void __pmac
+static irqreturn_t __pmac
 gpio1_interrupt(int irq, void *arg, struct pt_regs *regs)
 {
 	if ((in_8(gpio_reg + 0x9) & 0x02) == 0) {
 		adb_int_pending = 1;
 		via_pmu_interrupt(0, 0, 0);
+		return IRQ_HANDLED;
 	}
+	return IRQ_NONE;
 }
 
 #ifdef CONFIG_PMAC_BACKLIGHT
