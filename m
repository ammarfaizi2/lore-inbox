Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932299AbWELX4W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932299AbWELX4W (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 19:56:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932304AbWELXpB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 19:45:01 -0400
Received: from mx.pathscale.com ([64.160.42.68]:64169 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932293AbWELXoe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 19:44:34 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 47 of 53] ipath - fix problem with lost interrupts on HT-400
X-Mercurial-Node: a1615956e57f23c20a45b4b7c853b41164e80ef9
Message-Id: <a1615956e57f23c20a45.1147477412@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1147477365@eng-12.pathscale.com>
Date: Fri, 12 May 2006 16:43:32 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rdreier@cisco.com
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We can have a race clearing chip interrupt with another interrupt
about to be delivered and can clear it before it is delivered on the
GPIO workaround.  By doing the extra check here for the in-memory tail
register updating while we were doing earlier packets, we "almost"
guarantee we have covered that case.

Signed-off-by: Bryan O'Sullivan <bos@pathscale.com>

diff -r 04c86dd11b27 -r a1615956e57f drivers/infiniband/hw/ipath/ipath_driver.c
--- a/drivers/infiniband/hw/ipath/ipath_driver.c	Fri May 12 15:55:29 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_driver.c	Fri May 12 15:55:29 2006 -0700
@@ -858,7 +858,7 @@ void ipath_kreceive(struct ipath_devdata
 	const u32 maxcnt = dd->ipath_rcvhdrcnt * rsize;	/* words */
 	u32 etail = -1, l, hdrqtail;
 	struct ips_message_header *hdr;
-	u32 eflags, i, etype, tlen, pkttot = 0, updegr=0;
+	u32 eflags, i, etype, tlen, pkttot = 0, updegr=0, reloop=0;
 	static u64 totcalls;	/* stats, may eventually remove */
 	char emsg[128];
 
@@ -873,12 +873,11 @@ void ipath_kreceive(struct ipath_devdata
 		goto bail;
 
 	l = dd->ipath_port0head;
-	if(l == (u32)le64_to_cpu(*dd->ipath_hdrqtailptr))
+	hdrqtail = (u32)le64_to_cpu(*dd->ipath_hdrqtailptr);
+	if(l == hdrqtail)
 		goto done;
 
-	/* read only once at start for performance */
-	hdrqtail = (u32)le64_to_cpu(*dd->ipath_hdrqtailptr);
-
+reloop:
 	for (i = 0; l != hdrqtail; i++) {
 		u32 qp;
 		u8 *bthbytes;
@@ -1013,16 +1012,34 @@ void ipath_kreceive(struct ipath_devdata
 		 */
 		if(l == hdrqtail || (i && !(i&0xf))) {
 			u64 lval;
-			if(l == hdrqtail) /* want interrupt only on last */
+			if(l == hdrqtail) {
+				/* PE-800 interrupt only on last */
 				lval = dd->ipath_rhdrhead_intr_off | l;
+			}
 			else
 				lval = l;
 			(void)ipath_write_ureg(dd, ur_rcvhdrhead, lval, 0);
 			if(updegr) {
-				(void)ipath_write_ureg(dd, ur_rcvegrindexhead,
+				ipath_write_ureg(dd, ur_rcvegrindexhead,
 						       etail, 0);
 				updegr = 0;
 			}
+		}
+	}
+	if(!dd->ipath_rhdrhead_intr_off && !reloop) {
+		/* HT-400 workaround; we can have a race clearing chip
+		 * interrupt with another interrupt about to be delivered,
+		 * and can clear it before it is delivered on the GPIO
+		 * workaround.  By doing the extra check here for the
+		 * in-memory tail register updating while we were doing
+		 * earlier packets, we "almost" guarantee we have covered
+		 * that case.
+		 */
+		u32 hqtail = (u32)le64_to_cpu(*dd->ipath_hdrqtailptr);
+		if(hqtail != hdrqtail) {
+		    	hdrqtail = hqtail;
+			reloop = 1; /* loop 1 extra time at most */
+			goto reloop;
 		}
 	}
 
diff -r 04c86dd11b27 -r a1615956e57f drivers/infiniband/hw/ipath/ipath_intr.c
--- a/drivers/infiniband/hw/ipath/ipath_intr.c	Fri May 12 15:55:29 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_intr.c	Fri May 12 15:55:29 2006 -0700
@@ -761,13 +761,14 @@ static void handle_urcv(struct ipath_dev
 }
 
 
+
 irqreturn_t ipath_intr(int irq, void *data, struct pt_regs *regs)
 {
 	struct ipath_devdata *dd = data;
 	u32 istat, chk0rcv = 0;
 	ipath_err_t estat = 0;
 	irqreturn_t ret;
-	u32 p0bits, oldhead;
+	u32 oldhead, curtail;
 	static unsigned unexpected = 0;
 	static const u32 port0rbits = (1U<<INFINIPATH_I_RCVAVAIL_SHIFT) |
 		 (1U<<INFINIPATH_I_RCVURG_SHIFT);
@@ -810,15 +811,16 @@ irqreturn_t ipath_intr(int irq, void *da
 	 * lose intr for later packets that arrive while we are processing.
 	 */
 	oldhead = dd->ipath_port0head;
-	if (oldhead != (u32)le64_to_cpu(*dd->ipath_hdrqtailptr)) {
+	curtail = (u32)le64_to_cpu(*dd->ipath_hdrqtailptr);
+	if (oldhead != curtail) {
 		if(dd->ipath_flags & IPATH_GPIO_INTR) {
 			ipath_write_kreg(dd, dd->ipath_kregs->kr_gpio_clear,
 					 (u64) (1 << 2));
-			p0bits = port0rbits | INFINIPATH_I_GPIO;
+			istat = port0rbits | INFINIPATH_I_GPIO;
 		}
 		else
-			p0bits = port0rbits;
-		ipath_write_kreg(dd, dd->ipath_kregs->kr_intclear, p0bits);
+			istat = port0rbits;
+		ipath_write_kreg(dd, dd->ipath_kregs->kr_intclear, istat);
 		ipath_kreceive(dd);
 		if(oldhead != dd->ipath_port0head) {
 			ipath_stats.sps_fastrcvint++;
@@ -827,7 +829,6 @@ irqreturn_t ipath_intr(int irq, void *da
 	}
 
 	istat = ipath_read_kreg32(dd, dd->ipath_kregs->kr_intstatus);
-	p0bits = port0rbits;
 
 	if (unlikely(!istat)) {
 		ipath_stats.sps_nullintr++;
@@ -890,19 +891,19 @@ irqreturn_t ipath_intr(int irq, void *da
 		else {
 			/* Clear GPIO status bit 2 */
 			ipath_write_kreg(dd, dd->ipath_kregs->kr_gpio_clear,
-					 (u64) (1 << 2));
-			p0bits |= INFINIPATH_I_GPIO;
+					(u64) (1 << 2));
 			chk0rcv = 1;
 		}
 	}
-	chk0rcv |= istat & p0bits;
-
-	/*
-	 * clear the ones we will deal with on this round
-	 * We clear it early, mostly for receive interrupts, so we
-	 * know the chip will have seen this by the time we process
-	 * the queue, and will re-interrupt if necessary.  The processor
-	 * itself won't take the interrupt again until we return.
+	chk0rcv |= istat & port0rbits;
+
+	/*
+	 * Clear the interrupt bits we found set, unless they are receive
+	 * related, in which case we already cleared them above, and don't
+	 * want to clear them again, because we might lose an interrupt.
+	 * Clear it early, so we "know" know the chip will have seen this by
+	 * the time we process the queue, and will re-interrupt if necessary.
+	 * The processor itself won't take the interrupt again until we return.
 	 */
 	ipath_write_kreg(dd, dd->ipath_kregs->kr_intclear, istat);
 
