Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932194AbWELXpL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932194AbWELXpL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 19:45:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932203AbWELXom
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 19:44:42 -0400
Received: from mx.pathscale.com ([64.160.42.68]:53417 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932199AbWELXod (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 19:44:33 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 12 of 53] ipath - reduce overhead of receive interrupts
X-Mercurial-Node: ab2b013f1f959352a677e86716b5779e2a35dc61
Message-Id: <ab2b013f1f959352a677.1147477377@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1147477365@eng-12.pathscale.com>
Date: Fri, 12 May 2006 16:42:57 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rdreier@cisco.com
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Somewhat reduce overhead on receive interrupts, and count the number
of interrupts where that works (fastrcvint).

Signed-off-by: Bryan O'Sullivan <bos@pathscale.com>

diff -r cc6d7f2537b2 -r ab2b013f1f95 drivers/infiniband/hw/ipath/ipath_common.h
--- a/drivers/infiniband/hw/ipath/ipath_common.h	Fri May 12 15:55:28 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_common.h	Fri May 12 15:55:28 2006 -0700
@@ -96,8 +96,8 @@ struct infinipath_stats {
 	__u64 sps_hwerrs;
 	/* number of times IB link changed state unexpectedly */
 	__u64 sps_iblink;
-	/* no longer used; left for compatibility */
-	__u64 sps_unused3;
+	/* kernel receive interrupts that didn't read intstat */
+	__u64 sps_fastrcvint;
 	/* number of kernel (port0) packets received */
 	__u64 sps_port0pkts;
 	/* number of "ethernet" packets sent by driver */
diff -r cc6d7f2537b2 -r ab2b013f1f95 drivers/infiniband/hw/ipath/ipath_driver.c
--- a/drivers/infiniband/hw/ipath/ipath_driver.c	Fri May 12 15:55:28 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_driver.c	Fri May 12 15:55:28 2006 -0700
@@ -936,12 +936,7 @@ void ipath_kreceive(struct ipath_devdata
 	    (u32)le64_to_cpu(*dd->ipath_hdrqtailptr))
 		goto done;
 
-gotmore:
-	/*
-	 * read only once at start.  If in flood situation, this helps
-	 * performance slightly.  If more arrive while we are processing,
-	 * we'll come back here and do them
-	 */
+	/* read only once at start for performance */
 	hdrqtail = (u32)le64_to_cpu(*dd->ipath_hdrqtailptr);
 
 	for (i = 0, l = dd->ipath_port0head; l != hdrqtail; i++) {
@@ -1070,10 +1065,6 @@ gotmore:
 
 	dd->ipath_port0head = l;
 
-	if (hdrqtail != (u32)le64_to_cpu(*dd->ipath_hdrqtailptr))
-		/* more arrived while we handled first batch */
-		goto gotmore;
-
 	if (pkttot > ipath_stats.sps_maxpkts_call)
 		ipath_stats.sps_maxpkts_call = pkttot;
 	ipath_stats.sps_port0pkts += pkttot;
diff -r cc6d7f2537b2 -r ab2b013f1f95 drivers/infiniband/hw/ipath/ipath_intr.c
--- a/drivers/infiniband/hw/ipath/ipath_intr.c	Fri May 12 15:55:28 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_intr.c	Fri May 12 15:55:28 2006 -0700
@@ -493,10 +493,10 @@ static void handle_errors(struct ipath_d
 				continue;
 			if (hd == (tl + 1) ||
 			    (!hd && tl == dd->ipath_hdrqlast)) {
+				if (i == 0)
+					chkerrpkts = 1;
 				dd->ipath_lastrcvhdrqtails[i] = tl;
 				pd->port_hdrqfull++;
-				if (i == 0)
-					chkerrpkts = 1;
 			}
 		}
 	}
@@ -678,7 +678,12 @@ set:
 			 dd->ipath_sendctrl);
 }
 
-static void handle_rcv(struct ipath_devdata *dd, u32 istat)
+/*
+ * Handle receive interrupts for user ports; this means a user
+ * process was waiting for a packet to arrive, and didn't want
+ * to poll
+ */
+static void handle_urcv(struct ipath_devdata *dd, u32 istat)
 {
 	u64 portr;
 	int i;
@@ -688,22 +693,17 @@ static void handle_rcv(struct ipath_devd
 		 infinipath_i_rcvavail_mask)
 		| ((istat >> INFINIPATH_I_RCVURG_SHIFT) &
 		   infinipath_i_rcvurg_mask);
-	for (i = 0; i < dd->ipath_cfgports; i++) {
+	for (i = 1; i < dd->ipath_cfgports; i++) {
 		struct ipath_portdata *pd = dd->ipath_pd[i];
-		if (portr & (1 << i) && pd &&
-		    pd->port_cnt) {
-			if (i == 0)
-				ipath_kreceive(dd);
-			else if (test_bit(IPATH_PORT_WAITING_RCV,
-					  &pd->port_flag)) {
-				int rcbit;
-				clear_bit(IPATH_PORT_WAITING_RCV,
-					  &pd->port_flag);
-				rcbit = i + INFINIPATH_R_INTRAVAIL_SHIFT;
-				clear_bit(1UL << rcbit, &dd->ipath_rcvctrl);
-				wake_up_interruptible(&pd->port_wait);
-				rcvdint = 1;
-			}
+		if (portr & (1 << i) && pd && pd->port_cnt &&
+			test_bit(IPATH_PORT_WAITING_RCV, &pd->port_flag)) {
+			int rcbit;
+			clear_bit(IPATH_PORT_WAITING_RCV,
+				  &pd->port_flag);
+			rcbit = i + INFINIPATH_R_INTRAVAIL_SHIFT;
+			clear_bit(1UL << rcbit, &dd->ipath_rcvctrl);
+			wake_up_interruptible(&pd->port_wait);
+			rcvdint = 1;
 		}
 	}
 	if (rcvdint) {
@@ -721,19 +721,66 @@ irqreturn_t ipath_intr(int irq, void *da
 	struct ipath_devdata *dd = data;
 	u32 istat;
 	ipath_err_t estat = 0;
+	irqreturn_t ret;
+	u32 p0bits;
 	static unsigned unexpected = 0;
-	irqreturn_t ret;
+	static const u32 port0rbits = (1U<<INFINIPATH_I_RCVAVAIL_SHIFT) |
+		 (1U<<INFINIPATH_I_RCVURG_SHIFT);
+
+	ipath_stats.sps_ints++;
 
 	if(!(dd->ipath_flags & IPATH_PRESENT)) {
-		/* this is mostly so we don't try to touch the chip while
-		 * it is being reset */
-		/*
-		 * This return value is perhaps odd, but we do not want the
+		/*
+		 * This return value is not great, but we do not want the
 		 * interrupt core code to remove our interrupt handler
 		 * because we don't appear to be handling an interrupt
 		 * during a chip reset.
 		 */
 		return IRQ_HANDLED;
+	}
+
+	/*
+	 * this needs to be flags&initted, not statusp, so we keep
+	 * taking interrupts even after link goes down, etc.
+	 * Also, we *must* clear the interrupt at some point, or we won't
+	 * take it again, which can be real bad for errors, etc...
+	 */
+
+	if (!(dd->ipath_flags & IPATH_INITTED)) {
+		ipath_bad_intr(dd, &unexpected);
+		ret = IRQ_NONE;
+		goto bail;
+	}
+
+	/*
+	 * We try to avoid readint the interrupt status register, since
+	 * that's a PIO read, and stalls the processor for up to about
+	 * ~0.25 usec. The idea is that if we processed a port0 packet,
+	 * we blindly clear the  port 0 receive interrupt bits, and nothing
+	 * else, then return.  If other interrupts are pending, the chip
+	 * will re-interrupt us as soon as we write the intclear register.
+	 * We then won't process any more kernel packets (if not the 2nd
+	 * time, then the 3rd or 4th) and we'll then handle the other
+	 * interrupts.   We clear the interrupts first so that we don't
+	 * lose intr for later packets that arrive while we are processing.
+	 */
+	if (dd->ipath_port0head !=
+		(u32)le64_to_cpu(*dd->ipath_hdrqtailptr)) {
+		u32 oldhead = dd->ipath_port0head;
+		if(dd->ipath_flags & IPATH_GPIO_INTR) {
+			ipath_write_kreg(dd, dd->ipath_kregs->kr_gpio_clear,
+					 (u64) (1 << 2));
+			p0bits = port0rbits | INFINIPATH_I_GPIO;
+		}
+		else
+			p0bits = port0rbits;
+		ipath_write_kreg(dd, dd->ipath_kregs->kr_intclear, p0bits);
+		ipath_kreceive(dd);
+		if(oldhead != dd->ipath_port0head) {
+			ipath_stats.sps_fastrcvint++;
+			goto done;
+		}
+		istat = ipath_read_kreg32(dd, dd->ipath_kregs->kr_intstatus);
 	}
 
 	istat = ipath_read_kreg32(dd, dd->ipath_kregs->kr_intstatus);
@@ -749,31 +796,17 @@ irqreturn_t ipath_intr(int irq, void *da
 		goto bail;
 	}
 
-	ipath_stats.sps_ints++;
-
-	/*
-	 * this needs to be flags&initted, not statusp, so we keep
-	 * taking interrupts even after link goes down, etc.
-	 * Also, we *must* clear the interrupt at some point, or we won't
-	 * take it again, which can be real bad for errors, etc...
-	 */
-
-	if (!(dd->ipath_flags & IPATH_INITTED)) {
-		ipath_bad_intr(dd, &unexpected);
-		ret = IRQ_NONE;
-		goto bail;
-	}
 	if (unexpected)
 		unexpected = 0;
 
-	ipath_cdbg(VERBOSE, "intr stat=0x%x\n", istat);
-
-	if (istat & ~infinipath_i_bitsextant)
+	if(unlikely(istat & ~infinipath_i_bitsextant))
 		ipath_dev_err(dd,
 			      "interrupt with unknown interrupts %x set\n",
 			      istat & (u32) ~ infinipath_i_bitsextant);
-
-	if (istat & INFINIPATH_I_ERROR) {
+	else
+		ipath_cdbg(VERBOSE, "intr stat=0x%x\n", istat);
+
+	if(unlikely(istat & INFINIPATH_I_ERROR)) {
 		ipath_stats.sps_errints++;
 		estat = ipath_read_kreg64(dd,
 					  dd->ipath_kregs->kr_errorstatus);
@@ -791,7 +824,14 @@ irqreturn_t ipath_intr(int irq, void *da
 			handle_errors(dd, estat);
 	}
 
+	p0bits = port0rbits;
 	if (istat & INFINIPATH_I_GPIO) {
+		/*
+		 * Packets are available in the port 0 rcv queue.
+		 * Eventually this needs to be generalized to check
+		 * IPATH_GPIO_INTR, and the specific GPIO bit, if
+		 * GPIO interrupts are used for anything else.
+		 */
 		if (unlikely(!(dd->ipath_flags & IPATH_GPIO_INTR))) {
 			u32 gpiostatus;
 			gpiostatus = ipath_read_kreg32(
@@ -805,14 +845,7 @@ irqreturn_t ipath_intr(int irq, void *da
 			/* Clear GPIO status bit 2 */
 			ipath_write_kreg(dd, dd->ipath_kregs->kr_gpio_clear,
 					 (u64) (1 << 2));
-
-			/*
-			 * Packets are available in the port 0 rcv queue.
-			 * Eventually this needs to be generalized to check
-			 * IPATH_GPIO_INTR, and the specific GPIO bit, if
-			 * GPIO interrupts are used for anything else.
-			 */
-			ipath_kreceive(dd);
+			p0bits |= INFINIPATH_I_GPIO;
 		}
 	}
 
@@ -825,6 +858,25 @@ irqreturn_t ipath_intr(int irq, void *da
 	 */
 	ipath_write_kreg(dd, dd->ipath_kregs->kr_intclear, istat);
 
+	/*
+	 * we check for both transition from empty to non-empty, and urgent
+	 * packets (those with the interrupt bit set in the header), and
+	 * if enabled, the GPIO bit 2 interrupt used for port0 on some
+	 * HT-400 boards.
+	 * Do this before checking for pio buffers available, since
+	 * receives can overflow; piobuf waiters can afford a few
+	 * extra cycles, since they were waiting anyway.
+	 */
+	if(istat & p0bits) {
+		ipath_kreceive(dd);
+		istat &= ~port0rbits;
+	}
+	if (istat & ((infinipath_i_rcvavail_mask <<
+		      INFINIPATH_I_RCVAVAIL_SHIFT)
+		     | (infinipath_i_rcvurg_mask <<
+			INFINIPATH_I_RCVURG_SHIFT)))
+		handle_urcv(dd, istat);
+
 	if (istat & INFINIPATH_I_SPIOBUFAVAIL) {
 		clear_bit(IPATH_S_PIOINTBUFAVAIL, &dd->ipath_sendctrl);
 		ipath_write_kreg(dd, dd->ipath_kregs->kr_sendctrl,
@@ -836,17 +888,7 @@ irqreturn_t ipath_intr(int irq, void *da
 		handle_layer_pioavail(dd);
 	}
 
-	/*
-	 * we check for both transition from empty to non-empty, and urgent
-	 * packets (those with the interrupt bit set in the header)
-	 */
-
-	if (istat & ((infinipath_i_rcvavail_mask <<
-		      INFINIPATH_I_RCVAVAIL_SHIFT)
-		     | (infinipath_i_rcvurg_mask <<
-			INFINIPATH_I_RCVURG_SHIFT)))
-		handle_rcv(dd, istat);
-
+done:
 	ret = IRQ_HANDLED;
 
 bail:
diff -r cc6d7f2537b2 -r ab2b013f1f95 drivers/infiniband/hw/ipath/ipath_stats.c
--- a/drivers/infiniband/hw/ipath/ipath_stats.c	Fri May 12 15:55:28 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_stats.c	Fri May 12 15:55:28 2006 -0700
@@ -185,7 +185,6 @@ static void ipath_qcheck(struct ipath_de
 				   dd->ipath_port0head,
 				   (unsigned long long)
 				   ipath_stats.sps_port0pkts);
-			ipath_kreceive(dd);
 		}
 		dd->ipath_lastport0rcv_cnt = ipath_stats.sps_port0pkts;
 	}
