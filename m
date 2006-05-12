Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932303AbWEMABm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932303AbWEMABm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 20:01:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932212AbWELX5W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 19:57:22 -0400
Received: from mx.pathscale.com ([64.160.42.68]:60073 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932277AbWELXoe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 19:44:34 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 34 of 53] ipath - fix occasional hangs in SDP
X-Mercurial-Node: 09077b2f476f80594b82e85063d63edf14c519cf
Message-Id: <09077b2f476f80594b82.1147477399@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1147477365@eng-12.pathscale.com>
Date: Fri, 12 May 2006 16:43:19 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rdreier@cisco.com
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We were updating the head register multiple times in the rcvhdrq
processing loop, and setting the counter on each update.  Since that meant
that the tail register was ahead of head for all but the last update,
we would get extra interrupts.   The fix was to not write the counter
value except on the last update.

Signed-off-by: Bryan O'Sullivan <bos@pathscale.com>

diff -r 5ddaf7c07cdf -r 09077b2f476f drivers/infiniband/hw/ipath/ipath_driver.c
--- a/drivers/infiniband/hw/ipath/ipath_driver.c	Fri May 12 15:55:28 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_driver.c	Fri May 12 15:55:28 2006 -0700
@@ -918,7 +918,7 @@ void ipath_kreceive(struct ipath_devdata
 	const u32 maxcnt = dd->ipath_rcvhdrcnt * rsize;	/* words */
 	u32 etail = -1, l, hdrqtail;
 	struct ips_message_header *hdr;
-	u32 eflags, i, etype, tlen, pkttot = 0;
+	u32 eflags, i, etype, tlen, pkttot = 0, updegr=0;
 	static u64 totcalls;	/* stats, may eventually remove */
 	char emsg[128];
 
@@ -932,14 +932,14 @@ void ipath_kreceive(struct ipath_devdata
 	if (test_and_set_bit(0, &dd->ipath_rcv_pending))
 		goto bail;
 
-	if (dd->ipath_port0head ==
-	    (u32)le64_to_cpu(*dd->ipath_hdrqtailptr))
+	l = dd->ipath_port0head;
+	if(l == (u32)le64_to_cpu(*dd->ipath_hdrqtailptr))
 		goto done;
 
 	/* read only once at start for performance */
 	hdrqtail = (u32)le64_to_cpu(*dd->ipath_hdrqtailptr);
 
-	for (i = 0, l = dd->ipath_port0head; l != hdrqtail; i++) {
+	for (i = 0; l != hdrqtail; i++) {
 		u32 qp;
 		u8 *bthbytes;
 
@@ -1050,15 +1050,26 @@ void ipath_kreceive(struct ipath_devdata
 		l += rsize;
 		if (l >= maxcnt)
 			l = 0;
+		if (etype != RCVHQ_RCV_TYPE_EXPECTED)
+		    updegr = 1;
 		/*
-		 * update for each packet, to help prevent overflows if we
-		 * have lots of packets.
+		 * update head regs on last packet, and every 16 packets.
+		 * Reduce bus traffic, while still trying to prevent
+		 * rcvhdrq overflows, for when the queue is nearly full
 		 */
-		(void)ipath_write_ureg(dd, ur_rcvhdrhead,
-				       dd->ipath_rhdrhead_intr_off | l, 0);
-		if (etype != RCVHQ_RCV_TYPE_EXPECTED)
-			(void)ipath_write_ureg(dd, ur_rcvegrindexhead,
-					       etail, 0);
+		if(l == hdrqtail || (i && !(i&0xf))) {
+			u64 lval;
+			if(l == hdrqtail) /* want interrupt only on last */
+				lval = dd->ipath_rhdrhead_intr_off | l;
+			else
+				lval = l;
+			(void)ipath_write_ureg(dd, ur_rcvhdrhead, lval, 0);
+			if(updegr) {
+				(void)ipath_write_ureg(dd, ur_rcvegrindexhead,
+						       etail, 0);
+				updegr = 0;
+			}
+		}
 	}
 
 	pkttot += i;
diff -r 5ddaf7c07cdf -r 09077b2f476f drivers/infiniband/hw/ipath/ipath_intr.c
--- a/drivers/infiniband/hw/ipath/ipath_intr.c	Fri May 12 15:55:28 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_intr.c	Fri May 12 15:55:28 2006 -0700
@@ -350,7 +350,7 @@ static unsigned handle_frequent_errors(s
 	return supp_msgs;
 }
 
-static void handle_errors(struct ipath_devdata *dd, ipath_err_t errs)
+static int handle_errors(struct ipath_devdata *dd, ipath_err_t errs)
 {
 	char msg[512];
 	u64 ignore_this_time = 0;
@@ -434,7 +434,7 @@ static void handle_errors(struct ipath_d
 			  INFINIPATH_E_IBSTATUSCHANGED);
 	}
 	if (!errs)
-		return;
+		return 0;
 
 	if (!noprint)
 		/*
@@ -558,9 +558,7 @@ static void handle_errors(struct ipath_d
 		wake_up_interruptible(&ipath_sma_state_wait);
 	}
 
-	if (chkerrpkts)
-		/* process possible error packets in hdrq */
-		ipath_kreceive(dd);
+	return chkerrpkts;
 }
 
 /* this is separate to allow for better optimization of ipath_intr() */
@@ -716,13 +714,14 @@ static void handle_urcv(struct ipath_dev
 	}
 }
 
+
 irqreturn_t ipath_intr(int irq, void *data, struct pt_regs *regs)
 {
 	struct ipath_devdata *dd = data;
-	u32 istat;
+	u32 istat, chk0rcv = 0;
 	ipath_err_t estat = 0;
 	irqreturn_t ret;
-	u32 p0bits;
+	u32 p0bits, oldhead;
 	static unsigned unexpected = 0;
 	static const u32 port0rbits = (1U<<INFINIPATH_I_RCVAVAIL_SHIFT) |
 		 (1U<<INFINIPATH_I_RCVURG_SHIFT);
@@ -764,9 +763,8 @@ irqreturn_t ipath_intr(int irq, void *da
 	 * interrupts.   We clear the interrupts first so that we don't
 	 * lose intr for later packets that arrive while we are processing.
 	 */
-	if (dd->ipath_port0head !=
-		(u32)le64_to_cpu(*dd->ipath_hdrqtailptr)) {
-		u32 oldhead = dd->ipath_port0head;
+	oldhead = dd->ipath_port0head;
+	if (oldhead != (u32)le64_to_cpu(*dd->ipath_hdrqtailptr)) {
 		if(dd->ipath_flags & IPATH_GPIO_INTR) {
 			ipath_write_kreg(dd, dd->ipath_kregs->kr_gpio_clear,
 					 (u64) (1 << 2));
@@ -783,6 +781,8 @@ irqreturn_t ipath_intr(int irq, void *da
 	}
 
 	istat = ipath_read_kreg32(dd, dd->ipath_kregs->kr_intstatus);
+	p0bits = port0rbits;
+
 	if (unlikely(!istat)) {
 		ipath_stats.sps_nullintr++;
 		ret = IRQ_NONE; /* not our interrupt, or already handled */
@@ -820,10 +820,11 @@ irqreturn_t ipath_intr(int irq, void *da
 			ipath_dev_err(dd, "Read of error status failed "
 				      "(all bits set); ignoring\n");
 		else
-			handle_errors(dd, estat);
-	}
-
-	p0bits = port0rbits;
+			if(handle_errors(dd, estat))
+				/* force calling ipath_kreceive() */
+				chk0rcv = 1;
+	}
+
 	if (istat & INFINIPATH_I_GPIO) {
 		/*
 		 * Packets are available in the port 0 rcv queue.
@@ -845,8 +846,10 @@ irqreturn_t ipath_intr(int irq, void *da
 			ipath_write_kreg(dd, dd->ipath_kregs->kr_gpio_clear,
 					 (u64) (1 << 2));
 			p0bits |= INFINIPATH_I_GPIO;
-		}
-	}
+			chk0rcv = 1;
+		}
+	}
+	chk0rcv |= istat & p0bits;
 
 	/*
 	 * clear the ones we will deal with on this round
@@ -858,18 +861,16 @@ irqreturn_t ipath_intr(int irq, void *da
 	ipath_write_kreg(dd, dd->ipath_kregs->kr_intclear, istat);
 
 	/*
-	 * we check for both transition from empty to non-empty, and urgent
-	 * packets (those with the interrupt bit set in the header), and
-	 * if enabled, the GPIO bit 2 interrupt used for port0 on some
-	 * HT-400 boards.
-	 * Do this before checking for pio buffers available, since
-	 * receives can overflow; piobuf waiters can afford a few
-	 * extra cycles, since they were waiting anyway.
-	 */
-	if(istat & p0bits) {
+	 * handle port0 receive  before checking for pio buffers available,
+	 * since receives can overflow; piobuf waiters can afford a few
+	 * extra cycles, since they were waiting anyway, and user's waiting
+	 * for receive are at the bottom.
+	 */
+	if(chk0rcv) {
 		ipath_kreceive(dd);
 		istat &= ~port0rbits;
 	}
+
 	if (istat & ((infinipath_i_rcvavail_mask <<
 		      INFINIPATH_I_RCVAVAIL_SHIFT)
 		     | (infinipath_i_rcvurg_mask <<
