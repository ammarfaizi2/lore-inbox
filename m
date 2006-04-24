Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751295AbWDXVYQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751295AbWDXVYQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 17:24:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751291AbWDXVX5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 17:23:57 -0400
Received: from mx.pathscale.com ([64.160.42.68]:35267 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1751290AbWDXVXl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 17:23:41 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 7 of 13] ipath - prevent hardware from being accessed during
	reset
X-Mercurial-Node: ee2f95e99c27a4c5ae9e6b4ae6ca22e3bb8f5211
Message-Id: <ee2f95e99c27a4c5ae9e.1145913783@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1145913776@eng-12.pathscale.com>
Date: Mon, 24 Apr 2006 14:23:03 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rdreier@cisco.com
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The reset code now turns off the PRESENT flag during a reset, so that
other code won't attempt to access a device that's in mid-reset.

Signed-off-by: Bryan O'Sullivan <bos@pathscale.com>

diff -r 3ff1e5ae1c60 -r ee2f95e99c27 drivers/infiniband/hw/ipath/ipath_intr.c
--- a/drivers/infiniband/hw/ipath/ipath_intr.c	Wed Apr 19 15:24:36 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_intr.c	Wed Apr 19 15:24:36 2006 -0700
@@ -719,11 +719,24 @@ irqreturn_t ipath_intr(int irq, void *da
 irqreturn_t ipath_intr(int irq, void *data, struct pt_regs *regs)
 {
 	struct ipath_devdata *dd = data;
-	u32 istat = ipath_read_kreg32(dd, dd->ipath_kregs->kr_intstatus);
+	u32 istat;
 	ipath_err_t estat = 0;
 	static unsigned unexpected = 0;
 	irqreturn_t ret;
 
+	if(!(dd->ipath_flags & IPATH_PRESENT)) {
+		/* this is mostly so we don't try to touch the chip while
+		 * it is being reset */
+		/*
+		 * This return value is perhaps odd, but we do not want the
+		 * interrupt core code to remove our interrupt handler
+		 * because we don't appear to be handling an interrupt
+		 * during a chip reset.
+		 */
+		return IRQ_HANDLED;
+	}
+
+	istat = ipath_read_kreg32(dd, dd->ipath_kregs->kr_intstatus);
 	if (unlikely(!istat)) {
 		ipath_stats.sps_nullintr++;
 		ret = IRQ_NONE; /* not our interrupt, or already handled */
diff -r 3ff1e5ae1c60 -r ee2f95e99c27 drivers/infiniband/hw/ipath/ipath_kernel.h
--- a/drivers/infiniband/hw/ipath/ipath_kernel.h	Wed Apr 19 15:24:36 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_kernel.h	Wed Apr 19 15:24:36 2006 -0700
@@ -731,7 +731,7 @@ static inline u32 ipath_read_ureg32(cons
 static inline u32 ipath_read_ureg32(const struct ipath_devdata *dd,
 				    ipath_ureg regno, int port)
 {
-	if (!dd->ipath_kregbase)
+	if (!dd->ipath_kregbase || !(dd->ipath_flags & IPATH_PRESENT))
 		return 0;
 
 	return readl(regno + (u64 __iomem *)
@@ -762,7 +762,7 @@ static inline u32 ipath_read_kreg32(cons
 static inline u32 ipath_read_kreg32(const struct ipath_devdata *dd,
 				    ipath_kreg regno)
 {
-	if (!dd->ipath_kregbase)
+	if (!dd->ipath_kregbase || !(dd->ipath_flags & IPATH_PRESENT))
 		return -1;
 	return readl((u32 __iomem *) & dd->ipath_kregbase[regno]);
 }
@@ -770,7 +770,7 @@ static inline u64 ipath_read_kreg64(cons
 static inline u64 ipath_read_kreg64(const struct ipath_devdata *dd,
 				    ipath_kreg regno)
 {
-	if (!dd->ipath_kregbase)
+	if (!dd->ipath_kregbase || !(dd->ipath_flags & IPATH_PRESENT))
 		return -1;
 
 	return readq(&dd->ipath_kregbase[regno]);
@@ -786,7 +786,7 @@ static inline u64 ipath_read_creg(const 
 static inline u64 ipath_read_creg(const struct ipath_devdata *dd,
 				  ipath_sreg regno)
 {
-	if (!dd->ipath_kregbase)
+	if (!dd->ipath_kregbase || !(dd->ipath_flags & IPATH_PRESENT))
 		return 0;
 
 	return readq(regno + (u64 __iomem *)
@@ -797,7 +797,7 @@ static inline u32 ipath_read_creg32(cons
 static inline u32 ipath_read_creg32(const struct ipath_devdata *dd,
 					 ipath_sreg regno)
 {
-	if (!dd->ipath_kregbase)
+	if (!dd->ipath_kregbase || !(dd->ipath_flags & IPATH_PRESENT))
 		return 0;
 	return readl(regno + (u64 __iomem *)
 		     (dd->ipath_cregbase +
diff -r 3ff1e5ae1c60 -r ee2f95e99c27 drivers/infiniband/hw/ipath/ipath_pe800.c
--- a/drivers/infiniband/hw/ipath/ipath_pe800.c	Wed Apr 19 15:24:36 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_pe800.c	Wed Apr 19 15:24:36 2006 -0700
@@ -972,6 +972,8 @@ static int ipath_setup_pe_reset(struct i
 	/* Use ERROR so it shows up in logs, etc. */
 	ipath_dev_err(dd, "Resetting PE-800 unit %u\n",
 		      dd->ipath_unit);
+	/* keep chip from being accessed in a few places */
+	dd->ipath_flags &= ~(IPATH_INITTED|IPATH_PRESENT);
 	val = dd->ipath_control | INFINIPATH_C_RESET;
 	ipath_write_kreg(dd, dd->ipath_kregs->kr_control, val);
 	mb();
@@ -997,6 +999,8 @@ static int ipath_setup_pe_reset(struct i
 		if ((r = pci_enable_device(dd->pcidev)))
 			ipath_dev_err(dd, "pci_enable_device failed after "
 				      "reset: %d\n", r);
+		/* whether it worked or not, mark as present, again */
+		dd->ipath_flags |= IPATH_PRESENT;
 		val = ipath_read_kreg64(dd, dd->ipath_kregs->kr_revision);
 		if (val == dd->ipath_revision) {
 			ipath_cdbg(VERBOSE, "Got matching revision "
