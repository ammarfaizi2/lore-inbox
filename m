Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932514AbWI1QG4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932514AbWI1QG4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 12:06:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932308AbWI1QGc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 12:06:32 -0400
Received: from mx.pathscale.com ([64.160.42.68]:2486 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1751884AbWI1QBY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 12:01:24 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 15 of 28] IB/ipath - support multiple simultaneous devices of
	different types
X-Mercurial-Node: dcf5ac390abd8d1302129afc7bf8045a92089310
Message-Id: <dcf5ac390abd8d130212.1159459211@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1159459196@eng-12.pathscale.com>
Date: Thu, 28 Sep 2006 09:00:11 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rdreier@cisco.com
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Prior to this change, the driver was not able to support a HT and PCIE
card simultaneously present in the same machine.

Signed-off-by: Bryan O'Sullivan <bryan.osullivan@qlogic.com>

diff -r 42f82d2c62bc -r dcf5ac390abd drivers/infiniband/hw/ipath/ipath_driver.c
--- a/drivers/infiniband/hw/ipath/ipath_driver.c	Thu Sep 28 08:57:12 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_driver.c	Thu Sep 28 08:57:12 2006 -0700
@@ -94,16 +94,6 @@ const char *ipath_ibcstatus_str[] = {
 	"RecovWaitRmt",
 	"RecovIdle",
 };
-
-/*
- * These variables are initialized in the chip-specific files
- * but are defined here.
- */
-u16 ipath_gpio_sda_num, ipath_gpio_scl_num;
-u64 ipath_gpio_sda, ipath_gpio_scl;
-u64 infinipath_i_bitsextant;
-ipath_err_t infinipath_e_bitsextant, infinipath_hwe_bitsextant;
-u32 infinipath_i_rcvavail_mask, infinipath_i_rcvurg_mask;
 
 static void __devexit ipath_remove_one(struct pci_dev *);
 static int __devinit ipath_init_one(struct pci_dev *,
diff -r 42f82d2c62bc -r dcf5ac390abd drivers/infiniband/hw/ipath/ipath_eeprom.c
--- a/drivers/infiniband/hw/ipath/ipath_eeprom.c	Thu Sep 28 08:57:12 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_eeprom.c	Thu Sep 28 08:57:12 2006 -0700
@@ -100,9 +100,9 @@ static int i2c_gpio_set(struct ipath_dev
 	gpioval = &dd->ipath_gpio_out;
 	read_val = ipath_read_kreg64(dd, dd->ipath_kregs->kr_extctrl);
 	if (line == i2c_line_scl)
-		mask = ipath_gpio_scl;
+		mask = dd->ipath_gpio_scl;
 	else
-		mask = ipath_gpio_sda;
+		mask = dd->ipath_gpio_sda;
 
 	if (new_line_state == i2c_line_high)
 		/* tri-state the output rather than force high */
@@ -119,12 +119,12 @@ static int i2c_gpio_set(struct ipath_dev
 		write_val = 0x0UL;
 
 	if (line == i2c_line_scl) {
-		write_val <<= ipath_gpio_scl_num;
-		*gpioval = *gpioval & ~(1UL << ipath_gpio_scl_num);
+		write_val <<= dd->ipath_gpio_scl_num;
+		*gpioval = *gpioval & ~(1UL << dd->ipath_gpio_scl_num);
 		*gpioval |= write_val;
 	} else {
-		write_val <<= ipath_gpio_sda_num;
-		*gpioval = *gpioval & ~(1UL << ipath_gpio_sda_num);
+		write_val <<= dd->ipath_gpio_sda_num;
+		*gpioval = *gpioval & ~(1UL << dd->ipath_gpio_sda_num);
 		*gpioval |= write_val;
 	}
 	ipath_write_kreg(dd, dd->ipath_kregs->kr_gpio_out, *gpioval);
@@ -157,9 +157,9 @@ static int i2c_gpio_get(struct ipath_dev
 	read_val = ipath_read_kreg64(dd, dd->ipath_kregs->kr_extctrl);
 	/* config line to be an input */
 	if (line == i2c_line_scl)
-		mask = ipath_gpio_scl;
+		mask = dd->ipath_gpio_scl;
 	else
-		mask = ipath_gpio_sda;
+		mask = dd->ipath_gpio_sda;
 	write_val = read_val & ~mask;
 	ipath_write_kreg(dd, dd->ipath_kregs->kr_extctrl, write_val);
 	read_val = ipath_read_kreg64(dd, dd->ipath_kregs->kr_extstatus);
diff -r 42f82d2c62bc -r dcf5ac390abd drivers/infiniband/hw/ipath/ipath_iba6110.c
--- a/drivers/infiniband/hw/ipath/ipath_iba6110.c	Thu Sep 28 08:57:12 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_iba6110.c	Thu Sep 28 08:57:12 2006 -0700
@@ -252,8 +252,8 @@ static const struct ipath_cregs ipath_ht
 };
 
 /* kr_intstatus, kr_intclear, kr_intmask bits */
-#define INFINIPATH_I_RCVURG_MASK 0x1FF
-#define INFINIPATH_I_RCVAVAIL_MASK 0x1FF
+#define INFINIPATH_I_RCVURG_MASK ((1U<<9)-1)
+#define INFINIPATH_I_RCVAVAIL_MASK ((1U<<9)-1)
 
 /* kr_hwerrclear, kr_hwerrmask, kr_hwerrstatus, bits */
 #define INFINIPATH_HWE_HTCMEMPARITYERR_SHIFT 0
@@ -457,10 +457,10 @@ static void ipath_ht_handle_hwerrors(str
 			 "(cleared)\n", (unsigned long long) hwerrs);
 	dd->ipath_lasthwerror |= hwerrs;
 
-	if (hwerrs & ~infinipath_hwe_bitsextant)
+	if (hwerrs & ~dd->ipath_hwe_bitsextant)
 		ipath_dev_err(dd, "hwerror interrupt with unknown errors "
 			      "%llx set\n", (unsigned long long)
-			      (hwerrs & ~infinipath_hwe_bitsextant));
+			      (hwerrs & ~dd->ipath_hwe_bitsextant));
 
 	ctrl = ipath_read_kreg32(dd, dd->ipath_kregs->kr_control);
 	if (ctrl & INFINIPATH_C_FREEZEMODE) {
@@ -1059,21 +1059,21 @@ static void ipath_setup_ht_setextled(str
 	ipath_write_kreg(dd, dd->ipath_kregs->kr_extctrl, extctl);
 }
 
-static void ipath_init_ht_variables(void)
-{
-	ipath_gpio_sda_num = _IPATH_GPIO_SDA_NUM;
-	ipath_gpio_scl_num = _IPATH_GPIO_SCL_NUM;
-	ipath_gpio_sda = IPATH_GPIO_SDA;
-	ipath_gpio_scl = IPATH_GPIO_SCL;
-
-	infinipath_i_bitsextant =
+static void ipath_init_ht_variables(struct ipath_devdata *dd)
+{
+	dd->ipath_gpio_sda_num = _IPATH_GPIO_SDA_NUM;
+	dd->ipath_gpio_scl_num = _IPATH_GPIO_SCL_NUM;
+	dd->ipath_gpio_sda = IPATH_GPIO_SDA;
+	dd->ipath_gpio_scl = IPATH_GPIO_SCL;
+
+	dd->ipath_i_bitsextant =
 		(INFINIPATH_I_RCVURG_MASK << INFINIPATH_I_RCVURG_SHIFT) |
 		(INFINIPATH_I_RCVAVAIL_MASK <<
 		 INFINIPATH_I_RCVAVAIL_SHIFT) |
 		INFINIPATH_I_ERROR | INFINIPATH_I_SPIOSENT |
 		INFINIPATH_I_SPIOBUFAVAIL | INFINIPATH_I_GPIO;
 
-	infinipath_e_bitsextant =
+	dd->ipath_e_bitsextant =
 		INFINIPATH_E_RFORMATERR | INFINIPATH_E_RVCRC |
 		INFINIPATH_E_RICRC | INFINIPATH_E_RMINPKTLEN |
 		INFINIPATH_E_RMAXPKTLEN | INFINIPATH_E_RLONGPKTLEN |
@@ -1091,7 +1091,7 @@ static void ipath_init_ht_variables(void
 		INFINIPATH_E_INVALIDADDR | INFINIPATH_E_RESET |
 		INFINIPATH_E_HARDWARE;
 
-	infinipath_hwe_bitsextant =
+	dd->ipath_hwe_bitsextant =
 		(INFINIPATH_HWE_HTCMEMPARITYERR_MASK <<
 		 INFINIPATH_HWE_HTCMEMPARITYERR_SHIFT) |
 		(INFINIPATH_HWE_TXEMEMPARITYERR_MASK <<
@@ -1120,8 +1120,8 @@ static void ipath_init_ht_variables(void
 		INFINIPATH_HWE_IBCBUSTOSPCPARITYERR |
 		INFINIPATH_HWE_IBCBUSFRSPCPARITYERR;
 
-	infinipath_i_rcvavail_mask = INFINIPATH_I_RCVAVAIL_MASK;
-	infinipath_i_rcvurg_mask = INFINIPATH_I_RCVURG_MASK;
+	dd->ipath_i_rcvavail_mask = INFINIPATH_I_RCVAVAIL_MASK;
+	dd->ipath_i_rcvurg_mask = INFINIPATH_I_RCVURG_MASK;
 }
 
 /**
@@ -1586,5 +1586,5 @@ void ipath_init_iba6110_funcs(struct ipa
 	 * do very early init that is needed before ipath_f_bus is
 	 * called
 	 */
-	ipath_init_ht_variables();
-}
+	ipath_init_ht_variables(dd);
+}
diff -r 42f82d2c62bc -r dcf5ac390abd drivers/infiniband/hw/ipath/ipath_iba6120.c
--- a/drivers/infiniband/hw/ipath/ipath_iba6120.c	Thu Sep 28 08:57:12 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_iba6120.c	Thu Sep 28 08:57:12 2006 -0700
@@ -263,8 +263,8 @@ static const struct ipath_cregs ipath_pe
 };
 
 /* kr_intstatus, kr_intclear, kr_intmask bits */
-#define INFINIPATH_I_RCVURG_MASK 0x1F
-#define INFINIPATH_I_RCVAVAIL_MASK 0x1F
+#define INFINIPATH_I_RCVURG_MASK ((1U<<5)-1)
+#define INFINIPATH_I_RCVAVAIL_MASK ((1U<<5)-1)
 
 /* kr_hwerrclear, kr_hwerrmask, kr_hwerrstatus, bits */
 #define INFINIPATH_HWE_PCIEMEMPARITYERR_MASK  0x000000000000003fULL
@@ -376,10 +376,10 @@ static void ipath_pe_handle_hwerrors(str
 			 "(cleared)\n", (unsigned long long) hwerrs);
 	dd->ipath_lasthwerror |= hwerrs;
 
-	if (hwerrs & ~infinipath_hwe_bitsextant)
+	if (hwerrs & ~dd->ipath_hwe_bitsextant)
 		ipath_dev_err(dd, "hwerror interrupt with unknown errors "
 			      "%llx set\n", (unsigned long long)
-			      (hwerrs & ~infinipath_hwe_bitsextant));
+			      (hwerrs & ~dd->ipath_hwe_bitsextant));
 
 	ctrl = ipath_read_kreg32(dd, dd->ipath_kregs->kr_control);
 	if (ctrl & INFINIPATH_C_FREEZEMODE) {
@@ -865,19 +865,19 @@ static int ipath_setup_pe_config(struct 
 	return 0;
 }
 
-static void ipath_init_pe_variables(void)
+static void ipath_init_pe_variables(struct ipath_devdata *dd)
 {
 	/*
 	 * bits for selecting i2c direction and values,
 	 * used for I2C serial flash
 	 */
-	ipath_gpio_sda_num = _IPATH_GPIO_SDA_NUM;
-	ipath_gpio_scl_num = _IPATH_GPIO_SCL_NUM;
-	ipath_gpio_sda = IPATH_GPIO_SDA;
-	ipath_gpio_scl = IPATH_GPIO_SCL;
+	dd->ipath_gpio_sda_num = _IPATH_GPIO_SDA_NUM;
+	dd->ipath_gpio_scl_num = _IPATH_GPIO_SCL_NUM;
+	dd->ipath_gpio_sda = IPATH_GPIO_SDA;
+	dd->ipath_gpio_scl = IPATH_GPIO_SCL;
 
 	/* variables for sanity checking interrupt and errors */
-	infinipath_hwe_bitsextant =
+	dd->ipath_hwe_bitsextant =
 		(INFINIPATH_HWE_RXEMEMPARITYERR_MASK <<
 		 INFINIPATH_HWE_RXEMEMPARITYERR_SHIFT) |
 		(INFINIPATH_HWE_PCIEMEMPARITYERR_MASK <<
@@ -895,13 +895,13 @@ static void ipath_init_pe_variables(void
 		INFINIPATH_HWE_SERDESPLLFAILED |
 		INFINIPATH_HWE_IBCBUSTOSPCPARITYERR |
 		INFINIPATH_HWE_IBCBUSFRSPCPARITYERR;
-	infinipath_i_bitsextant =
+	dd->ipath_i_bitsextant =
 		(INFINIPATH_I_RCVURG_MASK << INFINIPATH_I_RCVURG_SHIFT) |
 		(INFINIPATH_I_RCVAVAIL_MASK <<
 		 INFINIPATH_I_RCVAVAIL_SHIFT) |
 		INFINIPATH_I_ERROR | INFINIPATH_I_SPIOSENT |
 		INFINIPATH_I_SPIOBUFAVAIL | INFINIPATH_I_GPIO;
-	infinipath_e_bitsextant =
+	dd->ipath_e_bitsextant =
 		INFINIPATH_E_RFORMATERR | INFINIPATH_E_RVCRC |
 		INFINIPATH_E_RICRC | INFINIPATH_E_RMINPKTLEN |
 		INFINIPATH_E_RMAXPKTLEN | INFINIPATH_E_RLONGPKTLEN |
@@ -919,8 +919,8 @@ static void ipath_init_pe_variables(void
 		INFINIPATH_E_INVALIDADDR | INFINIPATH_E_RESET |
 		INFINIPATH_E_HARDWARE;
 
-	infinipath_i_rcvavail_mask = INFINIPATH_I_RCVAVAIL_MASK;
-	infinipath_i_rcvurg_mask = INFINIPATH_I_RCVURG_MASK;
+	dd->ipath_i_rcvavail_mask = INFINIPATH_I_RCVAVAIL_MASK;
+	dd->ipath_i_rcvurg_mask = INFINIPATH_I_RCVURG_MASK;
 }
 
 /* setup the MSI stuff again after a reset.  I'd like to just call
@@ -1326,6 +1326,6 @@ void ipath_init_iba6120_funcs(struct ipa
 	dd->ipath_kregs = &ipath_pe_kregs;
 	dd->ipath_cregs = &ipath_pe_cregs;
 
-	ipath_init_pe_variables();
-}
-
+	ipath_init_pe_variables(dd);
+}
+
diff -r 42f82d2c62bc -r dcf5ac390abd drivers/infiniband/hw/ipath/ipath_intr.c
--- a/drivers/infiniband/hw/ipath/ipath_intr.c	Thu Sep 28 08:57:12 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_intr.c	Thu Sep 28 08:57:12 2006 -0700
@@ -480,10 +480,10 @@ static int handle_errors(struct ipath_de
 		dd->ipath_f_handle_hwerrors(dd, msg, sizeof msg);
 	}
 
-	if (!noprint && (errs & ~infinipath_e_bitsextant))
+	if (!noprint && (errs & ~dd->ipath_e_bitsextant))
 		ipath_dev_err(dd, "error interrupt with unknown errors "
 			      "%llx set\n", (unsigned long long)
-			      (errs & ~infinipath_e_bitsextant));
+			      (errs & ~dd->ipath_e_bitsextant));
 
 	if (errs & E_SUM_ERRS)
 		ignore_this_time = handle_e_sum_errs(dd, errs);
@@ -805,9 +805,9 @@ static void handle_urcv(struct ipath_dev
 	int rcvdint = 0;
 
 	portr = ((istat >> INFINIPATH_I_RCVAVAIL_SHIFT) &
-		 infinipath_i_rcvavail_mask)
+		 dd->ipath_i_rcvavail_mask)
 		| ((istat >> INFINIPATH_I_RCVURG_SHIFT) &
-		   infinipath_i_rcvurg_mask);
+		   dd->ipath_i_rcvurg_mask);
 	for (i = 1; i < dd->ipath_cfgports; i++) {
 		struct ipath_portdata *pd = dd->ipath_pd[i];
 		if (portr & (1 << i) && pd && pd->port_cnt &&
@@ -914,10 +914,10 @@ irqreturn_t ipath_intr(int irq, void *da
 	if (unexpected)
 		unexpected = 0;
 
-	if (unlikely(istat & ~infinipath_i_bitsextant))
+	if (unlikely(istat & ~dd->ipath_i_bitsextant))
 		ipath_dev_err(dd,
 			      "interrupt with unknown interrupts %x set\n",
-			      istat & (u32) ~ infinipath_i_bitsextant);
+			      istat & (u32) ~ dd->ipath_i_bitsextant);
 	else
 		ipath_cdbg(VERBOSE, "intr stat=0x%x\n", istat);
 
@@ -1041,9 +1041,9 @@ irqreturn_t ipath_intr(int irq, void *da
 		istat &= ~port0rbits;
 	}
 
-	if (istat & ((infinipath_i_rcvavail_mask <<
+	if (istat & ((dd->ipath_i_rcvavail_mask <<
 		      INFINIPATH_I_RCVAVAIL_SHIFT)
-		     | (infinipath_i_rcvurg_mask <<
+		     | (dd->ipath_i_rcvurg_mask <<
 			INFINIPATH_I_RCVURG_SHIFT)))
 		handle_urcv(dd, istat);
 
diff -r 42f82d2c62bc -r dcf5ac390abd drivers/infiniband/hw/ipath/ipath_kernel.h
--- a/drivers/infiniband/hw/ipath/ipath_kernel.h	Thu Sep 28 08:57:12 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_kernel.h	Thu Sep 28 08:57:12 2006 -0700
@@ -533,6 +533,30 @@ struct ipath_devdata {
 	u32 ipath_rxfc_unsupvl_errs;
 	u32 ipath_overrun_thresh_errs;
 	u32 ipath_lli_errs;
+
+	/*
+	 * Not all devices managed by a driver instance are the same
+	 * type, so these fields must be per-device.
+	 */
+	u64 ipath_i_bitsextant;
+	ipath_err_t ipath_e_bitsextant;
+	ipath_err_t ipath_hwe_bitsextant;
+
+	/*
+	 * Below should be computable from number of ports,
+	 * since they are never modified.
+	 */
+	u32 ipath_i_rcvavail_mask;
+	u32 ipath_i_rcvurg_mask;
+
+	/*
+	 * Register bits for selecting i2c direction and values, used for
+	 * I2C serial flash.
+	 */
+	u16 ipath_gpio_sda_num;
+	u16 ipath_gpio_scl_num;
+	u64 ipath_gpio_sda;
+	u64 ipath_gpio_scl;
 };
 
 /* Private data for file operations */
diff -r 42f82d2c62bc -r dcf5ac390abd drivers/infiniband/hw/ipath/ipath_registers.h
--- a/drivers/infiniband/hw/ipath/ipath_registers.h	Thu Sep 28 08:57:12 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_registers.h	Thu Sep 28 08:57:12 2006 -0700
@@ -316,19 +316,23 @@
 
 typedef u64 ipath_err_t;
 
+/* The following change with the type of device, so
+ * need to be part of the ipath_devdata struct, or
+ * we could have problems plugging in devices of
+ * different types (e.g. one HT, one PCIE)
+ * in one system, to be managed by one driver.
+ * On the other hand, this file is may also be included
+ * by other code, so leave the declarations here
+ * temporarily. Minor footprint issue if common-model
+ * linker used, none if C89+ linker used.
+ */
+
 /* mask of defined bits for various registers */
 extern u64 infinipath_i_bitsextant;
 extern ipath_err_t infinipath_e_bitsextant, infinipath_hwe_bitsextant;
 
 /* masks that are different in various chips, or only exist in some chips */
 extern u32 infinipath_i_rcvavail_mask, infinipath_i_rcvurg_mask;
-
-/*
- * register bits for selecting i2c direction and values, used for I2C serial
- * flash
- */
-extern u16 ipath_gpio_sda_num, ipath_gpio_scl_num;
-extern u64 ipath_gpio_sda, ipath_gpio_scl;
 
 /*
  * These are the infinipath general register numbers (not offsets).
