Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030242AbWI1QLj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030242AbWI1QLj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 12:11:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932517AbWI1QLS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 12:11:18 -0400
Received: from mx.pathscale.com ([64.160.42.68]:59061 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1751600AbWI1QBW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 12:01:22 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 4 of 28] IB/ipath - support revision 2 InfiniPath PCIE devices
X-Mercurial-Node: a69f8b7a8a04a8742e0f6f5e8f501826670dbff3
Message-Id: <a69f8b7a8a04a8742e0f.1159459200@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1159459196@eng-12.pathscale.com>
Date: Thu, 28 Sep 2006 09:00:00 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rdreier@cisco.com
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This also entailed a little GPIO-interrupt general cleanup.

Signed-off-by: Bryan O'Sullivan <bryan.osullivan@qlogic.com>

diff -r 7f5b6127be15 -r a69f8b7a8a04 drivers/infiniband/hw/ipath/ipath_common.h
--- a/drivers/infiniband/hw/ipath/ipath_common.h	Thu Sep 28 08:57:12 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_common.h	Thu Sep 28 08:57:12 2006 -0700
@@ -186,6 +186,8 @@ typedef enum _ipath_ureg {
 #define IPATH_RUNTIME_FORCE_WC_ORDER	0x4
 #define IPATH_RUNTIME_RCVHDR_COPY	0x8
 #define IPATH_RUNTIME_MASTER	0x10
+#define IPATH_RUNTIME_PBC_REWRITE 0x20
+#define IPATH_RUNTIME_LOOSE_DMA_ALIGN 0x40
 
 /*
  * This structure is returned by ipath_userinit() immediately after
diff -r 7f5b6127be15 -r a69f8b7a8a04 drivers/infiniband/hw/ipath/ipath_iba6120.c
--- a/drivers/infiniband/hw/ipath/ipath_iba6120.c	Thu Sep 28 08:57:12 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_iba6120.c	Thu Sep 28 08:57:12 2006 -0700
@@ -294,6 +294,13 @@ static const struct ipath_cregs ipath_pe
 #define IPATH_GPIO_SCL (1ULL << \
 	(_IPATH_GPIO_SCL_NUM+INFINIPATH_EXTC_GPIOOE_SHIFT))
 
+/*
+ * Rev2 silicon allows suppressing check for ArmLaunch errors.
+ * this can speed up short packet sends on systems that do
+ * not guaranteee write-order.
+ */
+#define INFINIPATH_XGXS_SUPPRESS_ARMLAUNCH_ERR (1ULL<<63)
+
 /**
  * ipath_pe_handle_hwerrors - display hardware errors.
  * @dd: the infinipath device
@@ -571,9 +578,12 @@ static void ipath_pe_init_hwerrors(struc
 	if (!dd->ipath_boardrev)	// no PLL for Emulator
 		val &= ~INFINIPATH_HWE_SERDESPLLFAILED;
 
-	/* workaround bug 9460 in internal interface bus parity checking */
-	val &= ~INFINIPATH_HWE_PCIEBUSPARITYRADM;
-
+	if (dd->ipath_minrev < 2) {
+		/* workaround bug 9460 in internal interface bus parity
+		 * checking. Fixed (HW bug 9490) in Rev2.
+		 */
+		val &= ~INFINIPATH_HWE_PCIEBUSPARITYRADM;
+	}
 	dd->ipath_hwerrmask = val;
 }
 
@@ -583,8 +593,8 @@ static void ipath_pe_init_hwerrors(struc
  */
 static int ipath_pe_bringup_serdes(struct ipath_devdata *dd)
 {
-	u64 val, tmp, config1;
-	int ret = 0, change = 0;
+	u64 val, tmp, config1, prev_val;
+	int ret = 0;
 
 	ipath_dbg("Trying to bringup serdes\n");
 
@@ -641,6 +651,7 @@ static int ipath_pe_bringup_serdes(struc
 	val = ipath_read_kreg64(dd, dd->ipath_kregs->kr_scratch);
 
 	val = ipath_read_kreg64(dd, dd->ipath_kregs->kr_xgxsconfig);
+	prev_val = val;
 	if (((val >> INFINIPATH_XGXS_MDIOADDR_SHIFT) &
 	     INFINIPATH_XGXS_MDIOADDR_MASK) != 3) {
 		val &=
@@ -648,11 +659,9 @@ static int ipath_pe_bringup_serdes(struc
 			  INFINIPATH_XGXS_MDIOADDR_SHIFT);
 		/* MDIO address 3 */
 		val |= 3ULL << INFINIPATH_XGXS_MDIOADDR_SHIFT;
-		change = 1;
 	}
 	if (val & INFINIPATH_XGXS_RESET) {
 		val &= ~INFINIPATH_XGXS_RESET;
-		change = 1;
 	}
 	if (((val >> INFINIPATH_XGXS_RX_POL_SHIFT) &
 	     INFINIPATH_XGXS_RX_POL_MASK) != dd->ipath_rx_pol_inv ) {
@@ -661,9 +670,19 @@ static int ipath_pe_bringup_serdes(struc
 		         INFINIPATH_XGXS_RX_POL_SHIFT);
 		val |= dd->ipath_rx_pol_inv <<
 			INFINIPATH_XGXS_RX_POL_SHIFT;
-		change = 1;
-	}
-	if (change)
+	}
+	if (dd->ipath_minrev >= 2) {
+		/* Rev 2. can tolerate multiple writes to PBC, and
+		 * allowing them can provide lower latency on some
+		 * CPUs, but this feature is off by default, only
+		 * turned on by setting D63 of XGXSconfig reg.
+		 * May want to make this conditional more
+		 * fine-grained in future. This is not exactly
+		 * related to XGXS, but where the bit ended up.
+		 */
+		val |= INFINIPATH_XGXS_SUPPRESS_ARMLAUNCH_ERR;
+	}
+	if (val != prev_val)
 		ipath_write_kreg(dd, dd->ipath_kregs->kr_xgxsconfig, val);
 
 	val = ipath_read_kreg64(dd, dd->ipath_kregs->kr_serdesconfig0);
@@ -717,9 +736,25 @@ static void ipath_pe_quiet_serdes(struct
 	ipath_write_kreg(dd, dd->ipath_kregs->kr_serdesconfig0, val);
 }
 
-/* this is not yet needed on this chip, so just return 0. */
 static int ipath_pe_intconfig(struct ipath_devdata *dd)
 {
+	u64 val;
+	u32 chiprev;
+
+	/* 
+	 * If the chip supports added error indication via GPIO pins,
+	 * enable interrupts on those bits so the interrupt routine
+	 * can count the events. Also set flag so interrupt routine
+	 * can know they are expected.
+	 */
+	chiprev = dd->ipath_revision >> INFINIPATH_R_CHIPREVMINOR_SHIFT;
+	if ((chiprev & INFINIPATH_R_CHIPREVMINOR_MASK) > 1) {
+		/* Rev2+ reports extra errors via internal GPIO pins */
+		dd->ipath_flags |= IPATH_GPIO_ERRINTRS;
+		val = ipath_read_kreg64(dd, dd->ipath_kregs->kr_gpio_mask);
+		val |= IPATH_GPIO_ERRINTR_MASK;
+		ipath_write_kreg( dd, dd->ipath_kregs->kr_gpio_mask, val);
+	}
 	return 0;
 }
 
@@ -1082,6 +1117,45 @@ static void ipath_pe_put_tid(struct ipat
 	mmiowb();
 	spin_unlock_irqrestore(&dd->ipath_tid_lock, flags);
 }
+/**
+ * ipath_pe_put_tid_2 - write a TID in chip, Revision 2 or higher
+ * @dd: the infinipath device
+ * @tidptr: pointer to the expected TID (in chip) to udpate
+ * @tidtype: 0 for eager, 1 for expected
+ * @pa: physical address of in memory buffer; ipath_tidinvalid if freeing
+ *
+ * This exists as a separate routine to allow for selection of the
+ * appropriate "flavor". The static calls in cleanup just use the
+ * revision-agnostic form, as they are not performance critical.
+ */
+static void ipath_pe_put_tid_2(struct ipath_devdata *dd, u64 __iomem *tidptr,
+			     u32 type, unsigned long pa)
+{
+	u32 __iomem *tidp32 = (u32 __iomem *)tidptr;
+
+	if (pa != dd->ipath_tidinvalid) {
+		if (pa & ((1U << 11) - 1)) {
+			dev_info(&dd->pcidev->dev, "BUG: physaddr %lx "
+				 "not 4KB aligned!\n", pa);
+			return;
+		}
+		pa >>= 11;
+		/* paranoia check */
+		if (pa & (7<<29))
+			ipath_dev_err(dd,
+				      "BUG: Physical page address 0x%lx "
+				      "has bits set in 31-29\n", pa);
+
+		if (type == 0)
+			pa |= dd->ipath_tidtemplate;
+		else /* for now, always full 4KB page */
+			pa |= 2 << 29;
+	}
+	if (dd->ipath_kregbase)
+		writel(pa, tidp32);
+	mmiowb();
+}
+
 
 /**
  * ipath_pe_clear_tid - clear all TID entries for a port, expected and eager
@@ -1203,7 +1277,7 @@ int __attribute__((weak)) ipath_unordere
 
 /**
  * ipath_init_pe_get_base_info - set chip-specific flags for user code
- * @dd: the infinipath device
+ * @pd: the infinipath port
  * @kbase: ipath_base_info pointer
  *
  * We set the PCIE flag because the lower bandwidth on PCIe vs
@@ -1212,6 +1286,7 @@ static int ipath_pe_get_base_info(struct
 static int ipath_pe_get_base_info(struct ipath_portdata *pd, void *kbase)
 {
 	struct ipath_base_info *kinfo = kbase;
+	struct ipath_devdata *dd;
 
 	if (ipath_unordered_wc()) {
 		kinfo->spi_runtime_flags |= IPATH_RUNTIME_FORCE_WC_ORDER;
@@ -1220,8 +1295,20 @@ static int ipath_pe_get_base_info(struct
 	else
 		ipath_cdbg(PROC, "Not Intel processor, WC ordered\n");
 
+	if (pd == NULL)
+		goto done;
+
+	dd = pd->port_dd;
+
+	if (dd != NULL && dd->ipath_minrev >= 2) {
+		ipath_cdbg(PROC, "IBA6120 Rev2, allow multiple PBC write\n");
+		kinfo->spi_runtime_flags |= IPATH_RUNTIME_PBC_REWRITE;
+		ipath_cdbg(PROC, "IBA6120 Rev2, allow loose DMA alignment\n");
+		kinfo->spi_runtime_flags |= IPATH_RUNTIME_LOOSE_DMA_ALIGN;
+	}
+
+done:
 	kinfo->spi_runtime_flags |= IPATH_RUNTIME_PCIE;
-
 	return 0;
 }
 
@@ -1244,7 +1331,10 @@ void ipath_init_iba6120_funcs(struct ipa
 	dd->ipath_f_quiet_serdes = ipath_pe_quiet_serdes;
 	dd->ipath_f_bringup_serdes = ipath_pe_bringup_serdes;
 	dd->ipath_f_clear_tids = ipath_pe_clear_tids;
-	dd->ipath_f_put_tid = ipath_pe_put_tid;
+	if (dd->ipath_minrev >= 2)
+		dd->ipath_f_put_tid = ipath_pe_put_tid_2;
+	else
+		dd->ipath_f_put_tid = ipath_pe_put_tid;
 	dd->ipath_f_cleanup = ipath_setup_pe_cleanup;
 	dd->ipath_f_setextled = ipath_setup_pe_setextled;
 	dd->ipath_f_get_base_info = ipath_pe_get_base_info;
diff -r 7f5b6127be15 -r a69f8b7a8a04 drivers/infiniband/hw/ipath/ipath_intr.c
--- a/drivers/infiniband/hw/ipath/ipath_intr.c	Thu Sep 28 08:57:12 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_intr.c	Thu Sep 28 08:57:12 2006 -0700
@@ -808,7 +808,7 @@ irqreturn_t ipath_intr(int irq, void *da
 	if (oldhead != curtail) {
 		if (dd->ipath_flags & IPATH_GPIO_INTR) {
 			ipath_write_kreg(dd, dd->ipath_kregs->kr_gpio_clear,
-					 (u64) (1 << 2));
+					 (u64) (1 << IPATH_GPIO_PORT0_BIT));
 			istat = port0rbits | INFINIPATH_I_GPIO;
 		}
 		else
@@ -867,25 +867,79 @@ irqreturn_t ipath_intr(int irq, void *da
 
 	if (istat & INFINIPATH_I_GPIO) {
 		/*
-		 * Packets are available in the port 0 rcv queue.
-		 * Eventually this needs to be generalized to check
-		 * IPATH_GPIO_INTR, and the specific GPIO bit, if
-		 * GPIO interrupts are used for anything else.
-		 */
-		if (unlikely(!(dd->ipath_flags & IPATH_GPIO_INTR))) {
-			u32 gpiostatus;
-			gpiostatus = ipath_read_kreg32(
-				dd, dd->ipath_kregs->kr_gpio_status);
-			ipath_dbg("Unexpected GPIO interrupt bits %x\n",
-				  gpiostatus);
+		 * GPIO interrupts fall in two broad classes:
+		 * GPIO_2 indicates (on some HT4xx boards) that a packet
+		 *        has arrived for Port 0. Checking for this
+		 *        is controlled by flag IPATH_GPIO_INTR.
+		 * GPIO_3..5 on IBA6120 Rev2 chips indicate errors
+		 *        that we need to count. Checking for this
+		 *        is controlled by flag IPATH_GPIO_ERRINTRS.
+		 */
+		u32 gpiostatus;
+		u32 to_clear = 0;
+
+		gpiostatus = ipath_read_kreg32(
+			dd, dd->ipath_kregs->kr_gpio_status);
+		/* First the error-counter case.
+		 */
+		if ((gpiostatus & IPATH_GPIO_ERRINTR_MASK) &&
+		    (dd->ipath_flags & IPATH_GPIO_ERRINTRS)) {
+			/* want to clear the bits we see asserted. */
+			to_clear |= (gpiostatus & IPATH_GPIO_ERRINTR_MASK);
+
+			/*
+			 * Count appropriately, clear bits out of our copy,
+			 * as they have been "handled".
+			 */
+			if (gpiostatus & (1 << IPATH_GPIO_RXUVL_BIT)) {
+				ipath_dbg("FlowCtl on UnsupVL\n");
+				dd->ipath_rxfc_unsupvl_errs++;
+			}
+			if (gpiostatus & (1 << IPATH_GPIO_OVRUN_BIT)) {
+				ipath_dbg("Overrun Threshold exceeded\n");
+				dd->ipath_overrun_thresh_errs++;
+			}
+			if (gpiostatus & (1 << IPATH_GPIO_LLI_BIT)) {
+				ipath_dbg("Local Link Integrity error\n");
+				dd->ipath_lli_errs++;
+			}
+			gpiostatus &= ~IPATH_GPIO_ERRINTR_MASK;
+		}
+		/* Now the Port0 Receive case */
+		if ((gpiostatus & (1 << IPATH_GPIO_PORT0_BIT)) &&
+		    (dd->ipath_flags & IPATH_GPIO_INTR)) {
+			/*
+			 * GPIO status bit 2 is set, and we expected it.
+			 * clear it and indicate in p0bits.
+			 * This probably only happens if a Port0 pkt
+			 * arrives at _just_ the wrong time, and we
+			 * handle that by seting chk0rcv;
+			 */
+			to_clear |= (1 << IPATH_GPIO_PORT0_BIT);
+			gpiostatus &= ~(1 << IPATH_GPIO_PORT0_BIT);
+			chk0rcv = 1;
+		}
+		if (unlikely(gpiostatus)) {
+			/*
+			 * Some unexpected bits remain. If they could have
+			 * caused the interrupt, complain and clear.
+			 * MEA: this is almost certainly non-ideal.
+			 * we should look into auto-disable of unexpected
+			 * GPIO interrupts, possibly on a "three strikes"
+			 * basis.
+			 */
+			u32 mask;
+			mask = ipath_read_kreg32(
+				dd, dd->ipath_kregs->kr_gpio_mask);
+			if (mask & gpiostatus) {
+				ipath_dbg("Unexpected GPIO IRQ bits %x\n",
+				  gpiostatus & mask);
+				to_clear |= (gpiostatus & mask);
+			}
+		}
+		if (to_clear) {
 			ipath_write_kreg(dd, dd->ipath_kregs->kr_gpio_clear,
-					 gpiostatus);
-		}
-		else {
-			/* Clear GPIO status bit 2 */
-			ipath_write_kreg(dd, dd->ipath_kregs->kr_gpio_clear,
-					(u64) (1 << 2));
-			chk0rcv = 1;
+					(u64) to_clear);
 		}
 	}
 	chk0rcv |= istat & port0rbits;
diff -r 7f5b6127be15 -r a69f8b7a8a04 drivers/infiniband/hw/ipath/ipath_kernel.h
--- a/drivers/infiniband/hw/ipath/ipath_kernel.h	Thu Sep 28 08:57:12 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_kernel.h	Thu Sep 28 08:57:12 2006 -0700
@@ -524,6 +524,15 @@ struct ipath_devdata {
 	u32 ipath_lli_counter;
 	/* local link integrity errors */
 	u32 ipath_lli_errors;
+	/*
+	 * Above counts only cases where _successive_ LocalLinkIntegrity
+	 * errors were seen in the receive headers of kern-packets.
+	 * Below are the three (monotonically increasing) counters
+	 * maintained via GPIO interrupts on iba6120-rev2.
+	 */
+	u32 ipath_rxfc_unsupvl_errs;
+	u32 ipath_overrun_thresh_errs;
+	u32 ipath_lli_errs;
 };
 
 /* Private data for file operations */
@@ -636,6 +645,15 @@ int ipath_set_rx_pol_inv(struct ipath_de
 		/* can miss port0 rx interrupts */
 #define IPATH_POLL_RX_INTR  0x40000
 #define IPATH_DISABLED      0x80000 /* administratively disabled */
+		/* Use GPIO interrupts for new counters */    
+#define IPATH_GPIO_ERRINTRS 0x100000
+
+/* Bits in GPIO for the added interrupts */
+#define IPATH_GPIO_PORT0_BIT 2
+#define IPATH_GPIO_RXUVL_BIT 3
+#define IPATH_GPIO_OVRUN_BIT 4
+#define IPATH_GPIO_LLI_BIT 5
+#define IPATH_GPIO_ERRINTR_MASK 0x38
 
 /* portdata flag bit offsets */
 		/* waiting for a packet to arrive */
diff -r 7f5b6127be15 -r a69f8b7a8a04 drivers/infiniband/hw/ipath/ipath_verbs.c
--- a/drivers/infiniband/hw/ipath/ipath_verbs.c	Thu Sep 28 08:57:12 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_verbs.c	Thu Sep 28 08:57:12 2006 -0700
@@ -898,7 +898,8 @@ int ipath_get_counters(struct ipath_devd
 		ipath_snap_cntr(dd, dd->ipath_cregs->cr_erricrccnt) +
 		ipath_snap_cntr(dd, dd->ipath_cregs->cr_errvcrccnt) +
 		ipath_snap_cntr(dd, dd->ipath_cregs->cr_errlpcrccnt) +
-		ipath_snap_cntr(dd, dd->ipath_cregs->cr_badformatcnt);
+		ipath_snap_cntr(dd, dd->ipath_cregs->cr_badformatcnt) +
+		dd->ipath_rxfc_unsupvl_errs;
 	cntrs->port_rcv_remphys_errors =
 		ipath_snap_cntr(dd, dd->ipath_cregs->cr_rcvebpcnt);
 	cntrs->port_xmit_discards =
@@ -911,8 +912,10 @@ int ipath_get_counters(struct ipath_devd
 		ipath_snap_cntr(dd, dd->ipath_cregs->cr_pktsendcnt);
 	cntrs->port_rcv_packets =
 		ipath_snap_cntr(dd, dd->ipath_cregs->cr_pktrcvcnt);
-	cntrs->local_link_integrity_errors = dd->ipath_lli_errors;
-	cntrs->excessive_buffer_overrun_errors = 0; /* XXX */
+	cntrs->local_link_integrity_errors =
+		(dd->ipath_flags & IPATH_GPIO_ERRINTRS) ?
+		dd->ipath_lli_errs : dd->ipath_lli_errors;
+	cntrs->excessive_buffer_overrun_errors = dd->ipath_overrun_thresh_errs;
 
 	ret = 0;
 
@@ -1380,11 +1383,13 @@ static int enable_timer(struct ipath_dev
 	 * processing.
 	 */
 	if (dd->ipath_flags & IPATH_GPIO_INTR) {
+		u64 val;
 		ipath_write_kreg(dd, dd->ipath_kregs->kr_debugportselect,
 				 0x2074076542310ULL);
 		/* Enable GPIO bit 2 interrupt */
-		ipath_write_kreg(dd, dd->ipath_kregs->kr_gpio_mask,
-				 (u64) (1 << 2));
+		val = ipath_read_kreg64(dd, dd->ipath_kregs->kr_gpio_mask);
+		val |= (u64) (1 << IPATH_GPIO_PORT0_BIT);
+		ipath_write_kreg( dd, dd->ipath_kregs->kr_gpio_mask, val);
 	}
 
 	init_timer(&dd->verbs_timer);
@@ -1399,8 +1404,17 @@ static int disable_timer(struct ipath_de
 static int disable_timer(struct ipath_devdata *dd)
 {
 	/* Disable GPIO bit 2 interrupt */
-	if (dd->ipath_flags & IPATH_GPIO_INTR)
-		ipath_write_kreg(dd, dd->ipath_kregs->kr_gpio_mask, 0);
+	if (dd->ipath_flags & IPATH_GPIO_INTR) {
+                u64 val;
+                /* Disable GPIO bit 2 interrupt */
+                val = ipath_read_kreg64(dd, dd->ipath_kregs->kr_gpio_mask);
+                val &= ~((u64) (1 << IPATH_GPIO_PORT0_BIT));
+                ipath_write_kreg( dd, dd->ipath_kregs->kr_gpio_mask, val);
+		/*
+		 * We might want to undo changes to debugportselect,
+		 * but how?
+		 */
+	}
 
 	del_timer_sync(&dd->verbs_timer);
 
