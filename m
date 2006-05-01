Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932193AbWEATR0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932193AbWEATR0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 15:17:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932195AbWEATR0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 15:17:26 -0400
Received: from sj-iport-4.cisco.com ([171.68.10.86]:51127 "EHLO
	sj-iport-4.cisco.com") by vger.kernel.org with ESMTP
	id S932193AbWEATRZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 15:17:25 -0400
X-IronPort-AV: i="4.04,169,1144047600"; 
   d="scan'208"; a="1800287445:sNHT37693414"
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [GIT PULL] InfiniBand driver fixes for 2.6.17
X-Message-Flag: Warning: May contain useful information
From: Roland Dreier <rdreier@cisco.com>
Date: Mon, 01 May 2006 12:17:23 -0700
Message-ID: <adamze1tv0c.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 01 May 2006 19:17:24.0528 (UTC) FILETIME=[E0A54B00:01C66D53]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please pull from

    master.kernel.org:/pub/scm/linux/kernel/git/roland/infiniband.git for-linus

This tree is also available from kernel.org mirrors at:

    git://git.kernel.org/pub/scm/linux/kernel/git/roland/infiniband.git for-linus

This is mostly fixes for the ipath driver, with one mthca driver fix
thrown in.

The exact changes and patch are:

Bryan O'Sullivan:
      IB/ipath: fix race with exposing reset file
      IB/ipath: set up 32-bit DMA mask if 64-bit setup fails
      IB/ipath: iterate over correct number of ports during reset
      IB/ipath: change handling of PIO buffers
      IB/ipath: fix verbs registration
      IB/ipath: prevent hardware from being accessed during reset
      IB/ipath: simplify RC send posting
      IB/ipath: simplify IB timer usage
      IB/ipath: improve sparse annotation
      IB/ipath: fix label name in interrupt handler
      IB/ipath: tidy up white space in a few files

Roland Dreier:
      IB/mthca: Fix offset in query_gid method

 drivers/infiniband/hw/ipath/ipath_debug.h     |   15 +++++-----
 drivers/infiniband/hw/ipath/ipath_diag.c      |    3 +-
 drivers/infiniband/hw/ipath/ipath_driver.c    |   18 +++++++++---
 drivers/infiniband/hw/ipath/ipath_init_chip.c |   36 ++++++++++++++---------
 drivers/infiniband/hw/ipath/ipath_intr.c      |   21 +++++++++++--
 drivers/infiniband/hw/ipath/ipath_kernel.h    |   10 +++---
 drivers/infiniband/hw/ipath/ipath_layer.c     |    6 +++-
 drivers/infiniband/hw/ipath/ipath_pe800.c     |    4 +++
 drivers/infiniband/hw/ipath/ipath_registers.h |   31 ++++++++++++--------
 drivers/infiniband/hw/ipath/ipath_ruc.c       |   15 +++-------
 drivers/infiniband/hw/ipath/ipath_sysfs.c     |   14 ++++++++-
 drivers/infiniband/hw/ipath/ipath_ud.c        |    6 +++-
 drivers/infiniband/hw/ipath/ipath_verbs.c     |   39 ++++++-------------------
 drivers/infiniband/hw/ipath/ipath_verbs.h     |    3 +-
 drivers/infiniband/hw/ipath/ips_common.h      |    2 +
 drivers/infiniband/hw/mthca/mthca_provider.c  |    2 +
 16 files changed, 131 insertions(+), 94 deletions(-)


diff --git a/drivers/infiniband/hw/ipath/ipath_debug.h b/drivers/infiniband/hw/ipath/ipath_debug.h
index 593e289..4676238 100644
--- a/drivers/infiniband/hw/ipath/ipath_debug.h
+++ b/drivers/infiniband/hw/ipath/ipath_debug.h
@@ -60,11 +60,11 @@
 #define __IPATH_KERNEL_SEND 0x2000	/* use kernel mode send */
 #define __IPATH_EPKTDBG     0x4000	/* print ethernet packet data */
 #define __IPATH_SMADBG      0x8000	/* sma packet debug */
-#define __IPATH_IPATHDBG    0x10000	/* Ethernet (IPATH) general debug on */
-#define __IPATH_IPATHWARN   0x20000	/* Ethernet (IPATH) warnings on */
-#define __IPATH_IPATHERR    0x40000	/* Ethernet (IPATH) errors on */
-#define __IPATH_IPATHPD     0x80000	/* Ethernet (IPATH) packet dump on */
-#define __IPATH_IPATHTABLE  0x100000	/* Ethernet (IPATH) table dump on */
+#define __IPATH_IPATHDBG    0x10000	/* Ethernet (IPATH) gen debug */
+#define __IPATH_IPATHWARN   0x20000	/* Ethernet (IPATH) warnings */
+#define __IPATH_IPATHERR    0x40000	/* Ethernet (IPATH) errors */
+#define __IPATH_IPATHPD     0x80000	/* Ethernet (IPATH) packet dump */
+#define __IPATH_IPATHTABLE  0x100000	/* Ethernet (IPATH) table dump */
 
 #else				/* _IPATH_DEBUGGING */
 
@@ -79,11 +79,12 @@
 #define __IPATH_TRSAMPLE  0x0	/* generate trace buffer sample entries */
 #define __IPATH_VERBDBG   0x0	/* very verbose debug */
 #define __IPATH_PKTDBG    0x0	/* print packet data */
-#define __IPATH_PROCDBG   0x0	/* print process startup (init)/exit messages */
+#define __IPATH_PROCDBG   0x0	/* process startup (init)/exit messages */
 /* print mmap/nopage stuff, not using VDBG any more */
 #define __IPATH_MMDBG     0x0
 #define __IPATH_EPKTDBG   0x0	/* print ethernet packet data */
-#define __IPATH_SMADBG    0x0   /* print process startup (init)/exit messages */#define __IPATH_IPATHDBG  0x0	/* Ethernet (IPATH) table dump on */
+#define __IPATH_SMADBG    0x0   /* process startup (init)/exit messages */
+#define __IPATH_IPATHDBG  0x0	/* Ethernet (IPATH) table dump on */
 #define __IPATH_IPATHWARN 0x0	/* Ethernet (IPATH) warnings on   */
 #define __IPATH_IPATHERR  0x0	/* Ethernet (IPATH) errors on   */
 #define __IPATH_IPATHPD   0x0	/* Ethernet (IPATH) packet dump on   */
diff --git a/drivers/infiniband/hw/ipath/ipath_diag.c b/drivers/infiniband/hw/ipath/ipath_diag.c
index 7d3fb69..28ddceb 100644
--- a/drivers/infiniband/hw/ipath/ipath_diag.c
+++ b/drivers/infiniband/hw/ipath/ipath_diag.c
@@ -277,13 +277,14 @@ static int ipath_diag_open(struct inode 
 
 bail:
 	spin_unlock_irqrestore(&ipath_devs_lock, flags);
-	mutex_unlock(&ipath_mutex);
 
 	/* Only expose a way to reset the device if we
 	   make it into diag mode. */
 	if (ret == 0)
 		ipath_expose_reset(&dd->pcidev->dev);
 
+	mutex_unlock(&ipath_mutex);
+
 	return ret;
 }
 
diff --git a/drivers/infiniband/hw/ipath/ipath_driver.c b/drivers/infiniband/hw/ipath/ipath_driver.c
index e7617c3..398add4 100644
--- a/drivers/infiniband/hw/ipath/ipath_driver.c
+++ b/drivers/infiniband/hw/ipath/ipath_driver.c
@@ -418,9 +418,19 @@ static int __devinit ipath_init_one(stru
 
 	ret = pci_set_dma_mask(pdev, DMA_64BIT_MASK);
 	if (ret) {
-		dev_info(&pdev->dev, "pci_set_dma_mask unit %u "
-			 "fails: %d\n", dd->ipath_unit, ret);
-		goto bail_regions;
+		/*
+		 * if the 64 bit setup fails, try 32 bit.  Some systems
+		 * do not setup 64 bit maps on systems with 2GB or less
+		 * memory installed.
+		 */
+		ret = pci_set_dma_mask(pdev, DMA_32BIT_MASK);
+		if (ret) {
+			dev_info(&pdev->dev, "pci_set_dma_mask unit %u "
+				 "fails: %d\n", dd->ipath_unit, ret);
+			goto bail_regions;
+		}
+		else
+			ipath_dbg("No 64bit DMA mask, used 32 bit mask\n");
 	}
 
 	pci_set_master(pdev);
@@ -1949,7 +1959,7 @@ int ipath_reset_device(int unit)
 	}
 
 	if (dd->ipath_pd)
-		for (i = 1; i < dd->ipath_portcnt; i++) {
+		for (i = 1; i < dd->ipath_cfgports; i++) {
 			if (dd->ipath_pd[i] && dd->ipath_pd[i]->port_cnt) {
 				ipath_dbg("unit %u port %d is in use "
 					  "(PID %u cmd %s), can't reset\n",
diff --git a/drivers/infiniband/hw/ipath/ipath_init_chip.c b/drivers/infiniband/hw/ipath/ipath_init_chip.c
index 2823ff9..16f640e 100644
--- a/drivers/infiniband/hw/ipath/ipath_init_chip.c
+++ b/drivers/infiniband/hw/ipath/ipath_init_chip.c
@@ -53,13 +53,19 @@ MODULE_PARM_DESC(cfgports, "Set max numb
 
 /*
  * Number of buffers reserved for driver (layered drivers and SMA
- * send).  Reserved at end of buffer list.
+ * send).  Reserved at end of buffer list.   Initialized based on
+ * number of PIO buffers if not set via module interface.
+ * The problem with this is that it's global, but we'll use different
+ * numbers for different chip types.  So the default value is not
+ * very useful.  I've redefined it for the 1.3 release so that it's
+ * zero unless set by the user to something else, in which case we
+ * try to respect it.
  */
-static ushort ipath_kpiobufs = 32;
+static ushort ipath_kpiobufs;
 
 static int ipath_set_kpiobufs(const char *val, struct kernel_param *kp);
 
-module_param_call(kpiobufs, ipath_set_kpiobufs, param_get_uint,
+module_param_call(kpiobufs, ipath_set_kpiobufs, param_get_ushort,
 		  &ipath_kpiobufs, S_IWUSR | S_IRUGO);
 MODULE_PARM_DESC(kpiobufs, "Set number of PIO buffers for driver");
 
@@ -531,8 +537,11 @@ static int init_housekeeping(struct ipat
 	 * Don't clear ipath_flags as 8bit mode was set before
 	 * entering this func. However, we do set the linkstate to
 	 * unknown, so we can watch for a transition.
+	 * PRESENT is set because we want register reads to work,
+	 * and the kernel infrastructure saw it in config space;
+	 * We clear it if we have failures.
 	 */
-	dd->ipath_flags |= IPATH_LINKUNK;
+	dd->ipath_flags |= IPATH_LINKUNK | IPATH_PRESENT;
 	dd->ipath_flags &= ~(IPATH_LINKACTIVE | IPATH_LINKARMED |
 			     IPATH_LINKDOWN | IPATH_LINKINIT);
 
@@ -560,6 +569,7 @@ static int init_housekeeping(struct ipat
 	    || (dd->ipath_uregbase & 0xffffffff) == 0xffffffff) {
 		ipath_dev_err(dd, "Register read failures from chip, "
 			      "giving up initialization\n");
+		dd->ipath_flags &= ~IPATH_PRESENT;
 		ret = -ENODEV;
 		goto done;
 	}
@@ -682,16 +692,14 @@ int ipath_init_chip(struct ipath_devdata
 	 */
 	dd->ipath_pioavregs = ALIGN(val, sizeof(u64) * BITS_PER_BYTE / 2)
 		/ (sizeof(u64) * BITS_PER_BYTE / 2);
-	if (!ipath_kpiobufs)	/* have to have at least 1, for SMA */
-		kpiobufs = ipath_kpiobufs = 1;
-	else if ((dd->ipath_piobcnt2k + dd->ipath_piobcnt4k) <
-		 (dd->ipath_cfgports * IPATH_MIN_USER_PORT_BUFCNT)) {
-		dev_info(&dd->pcidev->dev, "Too few PIO buffers (%u) "
-			 "for %u ports to have %u each!\n",
-			 dd->ipath_piobcnt2k + dd->ipath_piobcnt4k,
-			 dd->ipath_cfgports, IPATH_MIN_USER_PORT_BUFCNT);
-		kpiobufs = 1;	/* reserve just the minimum for SMA/ether */
-	} else
+	if (ipath_kpiobufs == 0) {
+		/* not set by user, or set explictly to default  */
+		if ((dd->ipath_piobcnt2k + dd->ipath_piobcnt4k) > 128)
+			kpiobufs = 32;
+		else
+			kpiobufs = 16;
+	}
+	else
 		kpiobufs = ipath_kpiobufs;
 
 	if (kpiobufs >
diff --git a/drivers/infiniband/hw/ipath/ipath_intr.c b/drivers/infiniband/hw/ipath/ipath_intr.c
index 0bcb428..3e72a1f 100644
--- a/drivers/infiniband/hw/ipath/ipath_intr.c
+++ b/drivers/infiniband/hw/ipath/ipath_intr.c
@@ -665,14 +665,14 @@ static void handle_layer_pioavail(struct
 
 	ret = __ipath_layer_intr(dd, IPATH_LAYER_INT_SEND_CONTINUE);
 	if (ret > 0)
-		goto clear;
+		goto set;
 
 	ret = __ipath_verbs_piobufavail(dd);
 	if (ret > 0)
-		goto clear;
+		goto set;
 
 	return;
-clear:
+set:
 	set_bit(IPATH_S_PIOINTBUFAVAIL, &dd->ipath_sendctrl);
 	ipath_write_kreg(dd, dd->ipath_kregs->kr_sendctrl,
 			 dd->ipath_sendctrl);
@@ -719,11 +719,24 @@ static void handle_rcv(struct ipath_devd
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
diff --git a/drivers/infiniband/hw/ipath/ipath_kernel.h b/drivers/infiniband/hw/ipath/ipath_kernel.h
index 0ce5f19..e6507f8 100644
--- a/drivers/infiniband/hw/ipath/ipath_kernel.h
+++ b/drivers/infiniband/hw/ipath/ipath_kernel.h
@@ -731,7 +731,7 @@ u64 ipath_read_kreg64_port(const struct 
 static inline u32 ipath_read_ureg32(const struct ipath_devdata *dd,
 				    ipath_ureg regno, int port)
 {
-	if (!dd->ipath_kregbase)
+	if (!dd->ipath_kregbase || !(dd->ipath_flags & IPATH_PRESENT))
 		return 0;
 
 	return readl(regno + (u64 __iomem *)
@@ -762,7 +762,7 @@ static inline void ipath_write_ureg(cons
 static inline u32 ipath_read_kreg32(const struct ipath_devdata *dd,
 				    ipath_kreg regno)
 {
-	if (!dd->ipath_kregbase)
+	if (!dd->ipath_kregbase || !(dd->ipath_flags & IPATH_PRESENT))
 		return -1;
 	return readl((u32 __iomem *) & dd->ipath_kregbase[regno]);
 }
@@ -770,7 +770,7 @@ static inline u32 ipath_read_kreg32(cons
 static inline u64 ipath_read_kreg64(const struct ipath_devdata *dd,
 				    ipath_kreg regno)
 {
-	if (!dd->ipath_kregbase)
+	if (!dd->ipath_kregbase || !(dd->ipath_flags & IPATH_PRESENT))
 		return -1;
 
 	return readq(&dd->ipath_kregbase[regno]);
@@ -786,7 +786,7 @@ static inline void ipath_write_kreg(cons
 static inline u64 ipath_read_creg(const struct ipath_devdata *dd,
 				  ipath_sreg regno)
 {
-	if (!dd->ipath_kregbase)
+	if (!dd->ipath_kregbase || !(dd->ipath_flags & IPATH_PRESENT))
 		return 0;
 
 	return readq(regno + (u64 __iomem *)
@@ -797,7 +797,7 @@ static inline u64 ipath_read_creg(const 
 static inline u32 ipath_read_creg32(const struct ipath_devdata *dd,
 					 ipath_sreg regno)
 {
-	if (!dd->ipath_kregbase)
+	if (!dd->ipath_kregbase || !(dd->ipath_flags & IPATH_PRESENT))
 		return 0;
 	return readl(regno + (u64 __iomem *)
 		     (dd->ipath_cregbase +
diff --git a/drivers/infiniband/hw/ipath/ipath_layer.c b/drivers/infiniband/hw/ipath/ipath_layer.c
index 69ed110..9cb5258 100644
--- a/drivers/infiniband/hw/ipath/ipath_layer.c
+++ b/drivers/infiniband/hw/ipath/ipath_layer.c
@@ -46,13 +46,15 @@
 /* Acquire before ipath_devs_lock. */
 static DEFINE_MUTEX(ipath_layer_mutex);
 
+static int ipath_verbs_registered;
+
 u16 ipath_layer_rcv_opcode;
+
 static int (*layer_intr)(void *, u32);
 static int (*layer_rcv)(void *, void *, struct sk_buff *);
 static int (*layer_rcv_lid)(void *, void *);
 static int (*verbs_piobufavail)(void *);
 static void (*verbs_rcv)(void *, void *, void *, u32);
-static int ipath_verbs_registered;
 
 static void *(*layer_add_one)(int, struct ipath_devdata *);
 static void (*layer_remove_one)(void *);
@@ -586,6 +588,8 @@ void ipath_verbs_unregister(void)
 	verbs_rcv = NULL;
 	verbs_timer_cb = NULL;
 
+	ipath_verbs_registered = 0;
+
 	mutex_unlock(&ipath_layer_mutex);
 }
 
diff --git a/drivers/infiniband/hw/ipath/ipath_pe800.c b/drivers/infiniband/hw/ipath/ipath_pe800.c
index e1dc4f7..6318067 100644
--- a/drivers/infiniband/hw/ipath/ipath_pe800.c
+++ b/drivers/infiniband/hw/ipath/ipath_pe800.c
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
diff --git a/drivers/infiniband/hw/ipath/ipath_registers.h b/drivers/infiniband/hw/ipath/ipath_registers.h
index 1e59750..402126e 100644
--- a/drivers/infiniband/hw/ipath/ipath_registers.h
+++ b/drivers/infiniband/hw/ipath/ipath_registers.h
@@ -34,8 +34,9 @@
 #define _IPATH_REGISTERS_H
 
 /*
- * This file should only be included by kernel source, and by the diags.
- * It defines the registers, and their contents, for the InfiniPath HT-400 chip
+ * This file should only be included by kernel source, and by the diags.  It
+ * defines the registers, and their contents, for the InfiniPath HT-400
+ * chip.
  */
 
 /*
@@ -156,8 +157,10 @@
 #define INFINIPATH_IBCC_FLOWCTRLWATERMARK_SHIFT 8
 #define INFINIPATH_IBCC_LINKINITCMD_MASK 0x3ULL
 #define INFINIPATH_IBCC_LINKINITCMD_DISABLE 1
-#define INFINIPATH_IBCC_LINKINITCMD_POLL 2	/* cycle through TS1/TS2 till OK */
-#define INFINIPATH_IBCC_LINKINITCMD_SLEEP 3	/* wait for TS1, then go on */
+/* cycle through TS1/TS2 till OK */
+#define INFINIPATH_IBCC_LINKINITCMD_POLL 2
+/* wait for TS1, then go on */
+#define INFINIPATH_IBCC_LINKINITCMD_SLEEP 3
 #define INFINIPATH_IBCC_LINKINITCMD_SHIFT 16
 #define INFINIPATH_IBCC_LINKCMD_MASK 0x3ULL
 #define INFINIPATH_IBCC_LINKCMD_INIT 1	/* move to 0x11 */
@@ -182,7 +185,8 @@
 #define INFINIPATH_IBCS_LINKSTATE_SHIFT 4
 #define INFINIPATH_IBCS_TXREADY       0x40000000
 #define INFINIPATH_IBCS_TXCREDITOK    0x80000000
-/* link training states (shift by INFINIPATH_IBCS_LINKTRAININGSTATE_SHIFT) */
+/* link training states (shift by
+   INFINIPATH_IBCS_LINKTRAININGSTATE_SHIFT) */
 #define INFINIPATH_IBCS_LT_STATE_DISABLED	0x00
 #define INFINIPATH_IBCS_LT_STATE_LINKUP		0x01
 #define INFINIPATH_IBCS_LT_STATE_POLLACTIVE	0x02
@@ -267,10 +271,12 @@
 /* kr_serdesconfig0 bits */
 #define INFINIPATH_SERDC0_RESET_MASK  0xfULL	/* overal reset bits */
 #define INFINIPATH_SERDC0_RESET_PLL   0x10000000ULL	/* pll reset */
-#define INFINIPATH_SERDC0_TXIDLE      0xF000ULL	/* tx idle enables (per lane) */
-#define INFINIPATH_SERDC0_RXDETECT_EN 0xF0000ULL	/* rx detect enables (per lane) */
-#define INFINIPATH_SERDC0_L1PWR_DN	 0xF0ULL	/* L1 Power down; use with RXDETECT,
-							   Otherwise not used on IB side */
+/* tx idle enables (per lane) */
+#define INFINIPATH_SERDC0_TXIDLE      0xF000ULL
+/* rx detect enables (per lane) */
+#define INFINIPATH_SERDC0_RXDETECT_EN 0xF0000ULL
+/* L1 Power down; use with RXDETECT, Otherwise not used on IB side */
+#define INFINIPATH_SERDC0_L1PWR_DN	 0xF0ULL
 
 /* kr_xgxsconfig bits */
 #define INFINIPATH_XGXS_RESET          0x7ULL
@@ -390,12 +396,13 @@ struct ipath_kregs {
 	ipath_kreg kr_txintmemsize;
 	ipath_kreg kr_xgxsconfig;
 	ipath_kreg kr_ibpllcfg;
-	/* use these two (and the following N ports) only with ipath_k*_kreg64_port();
-	 * not *kreg64() */
+	/* use these two (and the following N ports) only with
+	 * ipath_k*_kreg64_port(); not *kreg64() */
 	ipath_kreg kr_rcvhdraddr;
 	ipath_kreg kr_rcvhdrtailaddr;
 
-	/* remaining registers are not present on all types of infinipath chips  */
+	/* remaining registers are not present on all types of infinipath
+	   chips  */
 	ipath_kreg kr_rcvpktledcnt;
 	ipath_kreg kr_pcierbuftestreg0;
 	ipath_kreg kr_pcierbuftestreg1;
diff --git a/drivers/infiniband/hw/ipath/ipath_ruc.c b/drivers/infiniband/hw/ipath/ipath_ruc.c
index f232e77..eb81424 100644
--- a/drivers/infiniband/hw/ipath/ipath_ruc.c
+++ b/drivers/infiniband/hw/ipath/ipath_ruc.c
@@ -531,19 +531,12 @@ int ipath_post_rc_send(struct ipath_qp *
 	}
 	wqe->wr.num_sge = j;
 	qp->s_head = next;
-	/*
-	 * Wake up the send tasklet if the QP is not waiting
-	 * for an RNR timeout.
-	 */
-	next = qp->s_rnr_timeout;
 	spin_unlock_irqrestore(&qp->s_lock, flags);
 
-	if (next == 0) {
-		if (qp->ibqp.qp_type == IB_QPT_UC)
-			ipath_do_uc_send((unsigned long) qp);
-		else
-			ipath_do_rc_send((unsigned long) qp);
-	}
+	if (qp->ibqp.qp_type == IB_QPT_UC)
+		ipath_do_uc_send((unsigned long) qp);
+	else
+		ipath_do_rc_send((unsigned long) qp);
 
 	ret = 0;
 
diff --git a/drivers/infiniband/hw/ipath/ipath_sysfs.c b/drivers/infiniband/hw/ipath/ipath_sysfs.c
index 32acd80..f323791 100644
--- a/drivers/infiniband/hw/ipath/ipath_sysfs.c
+++ b/drivers/infiniband/hw/ipath/ipath_sysfs.c
@@ -711,10 +711,22 @@ static struct attribute_group dev_attr_g
  * enters diag mode.  A device reset is quite likely to crash the
  * machine entirely, so we don't want to normally make it
  * available.
+ *
+ * Called with ipath_mutex held.
  */
 int ipath_expose_reset(struct device *dev)
 {
-	return device_create_file(dev, &dev_attr_reset);
+	static int exposed;
+	int ret;
+
+	if (!exposed) {
+		ret = device_create_file(dev, &dev_attr_reset);
+		exposed = 1;
+	}
+	else
+		ret = 0;
+
+	return ret;
 }
 
 int ipath_driver_create_group(struct device_driver *drv)
diff --git a/drivers/infiniband/hw/ipath/ipath_ud.c b/drivers/infiniband/hw/ipath/ipath_ud.c
index 01cfb30..e606daf 100644
--- a/drivers/infiniband/hw/ipath/ipath_ud.c
+++ b/drivers/infiniband/hw/ipath/ipath_ud.c
@@ -46,8 +46,10 @@
  * This is called from ipath_post_ud_send() to forward a WQE addressed
  * to the same HCA.
  */
-static void ipath_ud_loopback(struct ipath_qp *sqp, struct ipath_sge_state *ss,
-			      u32 length, struct ib_send_wr *wr, struct ib_wc *wc)
+static void ipath_ud_loopback(struct ipath_qp *sqp,
+			      struct ipath_sge_state *ss,
+			      u32 length, struct ib_send_wr *wr,
+			      struct ib_wc *wc)
 {
 	struct ipath_ibdev *dev = to_idev(sqp->ibqp.device);
 	struct ipath_qp *qp;
diff --git a/drivers/infiniband/hw/ipath/ipath_verbs.c b/drivers/infiniband/hw/ipath/ipath_verbs.c
index 8d2558a..cb9e387 100644
--- a/drivers/infiniband/hw/ipath/ipath_verbs.c
+++ b/drivers/infiniband/hw/ipath/ipath_verbs.c
@@ -449,7 +449,6 @@ static void ipath_ib_timer(void *arg)
 {
 	struct ipath_ibdev *dev = (struct ipath_ibdev *) arg;
 	struct ipath_qp *resend = NULL;
-	struct ipath_qp *rnr = NULL;
 	struct list_head *last;
 	struct ipath_qp *qp;
 	unsigned long flags;
@@ -465,32 +464,18 @@ static void ipath_ib_timer(void *arg)
 	last = &dev->pending[dev->pending_index];
 	while (!list_empty(last)) {
 		qp = list_entry(last->next, struct ipath_qp, timerwait);
-		if (last->next == LIST_POISON1 ||
-		    last->next != &qp->timerwait ||
-		    qp->timerwait.prev != last) {
-			INIT_LIST_HEAD(last);
-		} else {
-			list_del(&qp->timerwait);
-			qp->timerwait.prev = (struct list_head *) resend;
-			resend = qp;
-			atomic_inc(&qp->refcount);
-		}
+		list_del(&qp->timerwait);
+		qp->timer_next = resend;
+		resend = qp;
+		atomic_inc(&qp->refcount);
 	}
 	last = &dev->rnrwait;
 	if (!list_empty(last)) {
 		qp = list_entry(last->next, struct ipath_qp, timerwait);
 		if (--qp->s_rnr_timeout == 0) {
 			do {
-				if (last->next == LIST_POISON1 ||
-				    last->next != &qp->timerwait ||
-				    qp->timerwait.prev != last) {
-					INIT_LIST_HEAD(last);
-					break;
-				}
 				list_del(&qp->timerwait);
-				qp->timerwait.prev =
-					(struct list_head *) rnr;
-				rnr = qp;
+				tasklet_hi_schedule(&qp->s_task);
 				if (list_empty(last))
 					break;
 				qp = list_entry(last->next, struct ipath_qp,
@@ -530,8 +515,7 @@ static void ipath_ib_timer(void *arg)
 	spin_unlock_irqrestore(&dev->pending_lock, flags);
 
 	/* XXX What if timer fires again while this is running? */
-	for (qp = resend; qp != NULL;
-	     qp = (struct ipath_qp *) qp->timerwait.prev) {
+	for (qp = resend; qp != NULL; qp = qp->timer_next) {
 		struct ib_wc wc;
 
 		spin_lock_irqsave(&qp->s_lock, flags);
@@ -545,9 +529,6 @@ static void ipath_ib_timer(void *arg)
 		if (atomic_dec_and_test(&qp->refcount))
 			wake_up(&qp->wait);
 	}
-	for (qp = rnr; qp != NULL;
-	     qp = (struct ipath_qp *) qp->timerwait.prev)
-		tasklet_hi_schedule(&qp->s_task);
 }
 
 /**
@@ -556,9 +537,9 @@ static void ipath_ib_timer(void *arg)
  *
  * This is called from ipath_intr() at interrupt level when a PIO buffer is
  * available after ipath_verbs_send() returned an error that no buffers were
- * available.  Return 0 if we consumed all the PIO buffers and we still have
+ * available.  Return 1 if we consumed all the PIO buffers and we still have
  * QPs waiting for buffers (for now, just do a tasklet_hi_schedule and
- * return one).
+ * return zero).
  */
 static int ipath_ib_piobufavail(void *arg)
 {
@@ -579,7 +560,7 @@ static int ipath_ib_piobufavail(void *ar
 	spin_unlock_irqrestore(&dev->pending_lock, flags);
 
 bail:
-	return 1;
+	return 0;
 }
 
 static int ipath_query_device(struct ib_device *ibdev,
@@ -1159,7 +1140,7 @@ static ssize_t show_stats(struct class_d
 
 	len = sprintf(buf,
 		      "RC resends  %d\n"
-		      "RC QACKs    %d\n"
+		      "RC no QACK  %d\n"
 		      "RC ACKs     %d\n"
 		      "RC SEQ NAKs %d\n"
 		      "RC RDMA seq %d\n"
diff --git a/drivers/infiniband/hw/ipath/ipath_verbs.h b/drivers/infiniband/hw/ipath/ipath_verbs.h
index fcafbc7..4f8d593 100644
--- a/drivers/infiniband/hw/ipath/ipath_verbs.h
+++ b/drivers/infiniband/hw/ipath/ipath_verbs.h
@@ -282,7 +282,8 @@ struct ipath_srq {
  */
 struct ipath_qp {
 	struct ib_qp ibqp;
-	struct ipath_qp *next;	/* link list for QPN hash table */
+	struct ipath_qp *next;		/* link list for QPN hash table */
+	struct ipath_qp *timer_next;	/* link list for ipath_ib_timer() */
 	struct list_head piowait;	/* link for wait PIO buf */
 	struct list_head timerwait;	/* link for waiting for timeouts */
 	struct ib_ah_attr remote_ah_attr;
diff --git a/drivers/infiniband/hw/ipath/ips_common.h b/drivers/infiniband/hw/ipath/ips_common.h
index 410a764..ab7cbbb 100644
--- a/drivers/infiniband/hw/ipath/ips_common.h
+++ b/drivers/infiniband/hw/ipath/ips_common.h
@@ -95,7 +95,7 @@ struct ether_header {
 	__u8 seq_num;
 	__le32 len;
 	/* MUST be of word size due to PIO write requirements */
-	__u32 csum;
+	__le32 csum;
 	__le16 csum_offset;
 	__le16 flags;
 	__u16 first_2_bytes;
diff --git a/drivers/infiniband/hw/mthca/mthca_provider.c b/drivers/infiniband/hw/mthca/mthca_provider.c
index 565a24b..a2eae8a 100644
--- a/drivers/infiniband/hw/mthca/mthca_provider.c
+++ b/drivers/infiniband/hw/mthca/mthca_provider.c
@@ -306,7 +306,7 @@ static int mthca_query_gid(struct ib_dev
 		goto out;
 	}
 
-	memcpy(gid->raw + 8, out_mad->data + (index % 8) * 16, 8);
+	memcpy(gid->raw + 8, out_mad->data + (index % 8) * 8, 8);
 
  out:
 	kfree(in_mad);
