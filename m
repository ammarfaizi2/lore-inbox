Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422797AbWHYS3L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422797AbWHYS3L (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 14:29:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964879AbWHYSZa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 14:25:30 -0400
Received: from mx.pathscale.com ([64.160.42.68]:43650 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1422766AbWHYSZT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 14:25:19 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 14 of 23] IB/ipath - support new QLogic product naming scheme
X-Mercurial-Node: a5b85bd0badcefcee95f642f63328979d35ec6da
Message-Id: <a5b85bd0badcefcee95f.1156530279@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1156530265@eng-12.pathscale.com>
Date: Fri, 25 Aug 2006 11:24:39 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rdreier@cisco.com
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch only renames files, fixes product names, and updates
comments.

Signed-off-by: Bryan O'Sullivan <bryan.osullivan@qlogic.com>

diff --git a/drivers/infiniband/hw/ipath/Makefile b/drivers/infiniband/hw/ipath/Makefile
--- a/drivers/infiniband/hw/ipath/Makefile	Fri Aug 25 11:19:45 2006 -0700
+++ b/drivers/infiniband/hw/ipath/Makefile	Fri Aug 25 11:19:45 2006 -0700
@@ -10,7 +10,8 @@ ib_ipath-y := \
 	ipath_eeprom.o \
 	ipath_file_ops.o \
 	ipath_fs.o \
-	ipath_ht400.o \
+	ipath_iba6110.o \
+	ipath_iba6120.o \
 	ipath_init_chip.o \
 	ipath_intr.o \
 	ipath_keys.o \
@@ -18,7 +19,6 @@ ib_ipath-y := \
 	ipath_mad.o \
 	ipath_mmap.o \
 	ipath_mr.o \
-	ipath_pe800.o \
 	ipath_qp.o \
 	ipath_rc.o \
 	ipath_ruc.o \
diff --git a/drivers/infiniband/hw/ipath/ipath_driver.c b/drivers/infiniband/hw/ipath/ipath_driver.c
--- a/drivers/infiniband/hw/ipath/ipath_driver.c	Fri Aug 25 11:19:45 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_driver.c	Fri Aug 25 11:19:45 2006 -0700
@@ -401,10 +401,10 @@ static int __devinit ipath_init_one(stru
 	/* setup the chip-specific functions, as early as possible. */
 	switch (ent->device) {
 	case PCI_DEVICE_ID_INFINIPATH_HT:
-		ipath_init_ht400_funcs(dd);
+		ipath_init_iba6110_funcs(dd);
 		break;
 	case PCI_DEVICE_ID_INFINIPATH_PE800:
-		ipath_init_pe800_funcs(dd);
+		ipath_init_iba6120_funcs(dd);
 		break;
 	default:
 		ipath_dev_err(dd, "Found unknown QLogic deviceid 0x%x, "
@@ -969,7 +969,8 @@ reloop:
 		 */
 		if (l == hdrqtail || (i && !(i&0xf))) {
 			u64 lval;
-			if (l == hdrqtail) /* PE-800 interrupt only on last */
+			if (l == hdrqtail)
+				/* request IBA6120 interrupt only on last */
 				lval = dd->ipath_rhdrhead_intr_off | l;
 			else
 				lval = l;
@@ -983,7 +984,7 @@ reloop:
 	}
 
 	if (!dd->ipath_rhdrhead_intr_off && !reloop) {
-		/* HT-400 workaround; we can have a race clearing chip
+		/* IBA6110 workaround; we can have a race clearing chip
 		 * interrupt with another interrupt about to be delivered,
 		 * and can clear it before it is delivered on the GPIO
 		 * workaround.  By doing the extra check here for the
diff --git a/drivers/infiniband/hw/ipath/ipath_file_ops.c b/drivers/infiniband/hw/ipath/ipath_file_ops.c
--- a/drivers/infiniband/hw/ipath/ipath_file_ops.c	Fri Aug 25 11:19:45 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_file_ops.c	Fri Aug 25 11:19:45 2006 -0700
@@ -1110,7 +1110,7 @@ static int ipath_mmap(struct file *fp, s
 		ret = mmap_rcvegrbufs(vma, pd);
 	else if (pgaddr == (u64) pd->port_rcvhdrq_phys) {
 		/*
-		 * The rcvhdrq itself; readonly except on HT-400 (so have
+		 * The rcvhdrq itself; readonly except on HT (so have
 		 * to allow writable mapping), multiple pages, contiguous
 		 * from an i/o perspective.
 		 */
@@ -1298,14 +1298,14 @@ static int find_best_unit(struct file *f
 	 * This code is present to allow a knowledgeable person to
 	 * specify the layout of processes to processors before opening
 	 * this driver, and then we'll assign the process to the "closest"
-	 * HT-400 to that processor (we assume reasonable connectivity,
+	 * InfiniPath chip to that processor (we assume reasonable connectivity,
 	 * for now).  This code assumes that if affinity has been set
 	 * before this point, that at most one cpu is set; for now this
 	 * is reasonable.  I check for both cpus_empty() and cpus_full(),
 	 * in case some kernel variant sets none of the bits when no
 	 * affinity is set.  2.6.11 and 12 kernels have all present
 	 * cpus set.  Some day we'll have to fix it up further to handle
-	 * a cpu subset.  This algorithm fails for two HT-400's connected
+	 * a cpu subset.  This algorithm fails for two HT chips connected
 	 * in tunnel fashion.  Eventually this needs real topology
 	 * information.  There may be some issues with dual core numbering
 	 * as well.  This needs more work prior to release.
diff --git a/drivers/infiniband/hw/ipath/ipath_ht400.c b/drivers/infiniband/hw/ipath/ipath_iba6110.c
rename from drivers/infiniband/hw/ipath/ipath_ht400.c
rename to drivers/infiniband/hw/ipath/ipath_iba6110.c
--- a/drivers/infiniband/hw/ipath/ipath_iba6110.c	Fri Aug 25 11:19:45 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_iba6110.c	Fri Aug 25 11:19:45 2006 -0700
@@ -33,7 +33,7 @@
 
 /*
  * This file contains all of the code that is specific to the InfiniPath
- * HT-400 chip.
+ * HT chip.
  */
 
 #include <linux/pci.h>
@@ -43,7 +43,7 @@
 #include "ipath_registers.h"
 
 /*
- * This lists the InfiniPath HT400 registers, in the actual chip layout.
+ * This lists the InfiniPath registers, in the actual chip layout.
  * This structure should never be directly accessed.
  *
  * The names are in InterCap form because they're taken straight from
@@ -537,7 +537,7 @@ static void ipath_ht_handle_hwerrors(str
 	if (hwerrs & INFINIPATH_HWE_HTCMISCERR7)
 		strlcat(msg, "[HT core Misc7]", msgl);
 	if (hwerrs & INFINIPATH_HWE_MEMBISTFAILED) {
-		strlcat(msg, "[Memory BIST test failed, HT-400 unusable]",
+		strlcat(msg, "[Memory BIST test failed, InfiniPath hardware unusable]",
 			msgl);
 		/* ignore from now on, so disable until driver reloaded */
 		dd->ipath_hwerrmask &= ~INFINIPATH_HWE_MEMBISTFAILED;
@@ -553,7 +553,7 @@ static void ipath_ht_handle_hwerrors(str
 
 	if (hwerrs & _IPATH_PLL_FAIL) {
 		snprintf(bitsmsg, sizeof bitsmsg,
-			 "[PLL failed (%llx), HT-400 unusable]",
+			 "[PLL failed (%llx), InfiniPath hardware unusable]",
 			 (unsigned long long) (hwerrs & _IPATH_PLL_FAIL));
 		strlcat(msg, bitsmsg, msgl);
 		/* ignore from now on, so disable until driver reloaded */
@@ -610,18 +610,18 @@ static int ipath_ht_boardname(struct ipa
 		break;
 	case 5:
 		/*
-		 * HT-460 original production board; two production levels, with
+		 * original production board; two production levels, with
 		 * different serial number ranges.   See ipath_ht_early_init() for
 		 * case where we enable IPATH_GPIO_INTR for later serial # range.
 		 */
-		n = "InfiniPath_HT-460";
+		n = "InfiniPath_QHT7040";
 		break;
 	case 6:
 		n = "OEM_Board_3";
 		break;
 	case 7:
-		/* HT-460 small form factor production board */
-		n = "InfiniPath_HT-465";
+		/* small form factor production board */
+		n = "InfiniPath_QHT7140";
 		break;
 	case 8:
 		n = "LS/X-1";
@@ -633,7 +633,7 @@ static int ipath_ht_boardname(struct ipa
 		n = "OEM_Board_2";
 		break;
 	case 11:
-		n = "InfiniPath_HT-470";
+		n = "InfiniPath_HT-470"; /* obsoleted */
 		break;
 	case 12:
 		n = "OEM_Board_4";
@@ -641,7 +641,7 @@ static int ipath_ht_boardname(struct ipa
 	default:		/* don't know, just print the number */
 		ipath_dev_err(dd, "Don't yet know about board "
 			      "with ID %u\n", boardrev);
-		snprintf(name, namelen, "Unknown_InfiniPath_HT-4xx_%u",
+		snprintf(name, namelen, "Unknown_InfiniPath_QHT7xxx_%u",
 			 boardrev);
 		break;
 	}
@@ -650,11 +650,10 @@ static int ipath_ht_boardname(struct ipa
 
 	if (dd->ipath_majrev != 3 || (dd->ipath_minrev < 2 || dd->ipath_minrev > 3)) {
 		/*
-		 * This version of the driver only supports the HT-400
-		 * Rev 3.2
+		 * This version of the driver only supports Rev 3.2 and 3.3
 		 */
 		ipath_dev_err(dd,
-			      "Unsupported HT-400 revision %u.%u!\n",
+			      "Unsupported InfiniPath hardware revision %u.%u!\n",
 			      dd->ipath_majrev, dd->ipath_minrev);
 		ret = 1;
 		goto bail;
@@ -738,7 +737,7 @@ static void ipath_check_htlink(struct ip
 
 static int ipath_setup_ht_reset(struct ipath_devdata *dd)
 {
-	ipath_dbg("No reset possible for HT-400\n");
+	ipath_dbg("No reset possible for this InfiniPath hardware\n");
 	return 0;
 }
 
@@ -925,7 +924,7 @@ static int set_int_handler(struct ipath_
 
 	/*
 	 * kernels with CONFIG_PCI_MSI set the vector in the irq field of
-	 * struct pci_device, so we use that to program the HT-400 internal
+	 * struct pci_device, so we use that to program the internal
 	 * interrupt register (not config space) with that value. The BIOS
 	 * must still have done the basic MSI setup.
 	 */
@@ -1013,7 +1012,7 @@ bail:
  * @dd: the infinipath device
  *
  * Called during driver unload.
- * This is currently a nop for the HT-400, not for all chips
+ * This is currently a nop for the HT chip, not for all chips
  */
 static void ipath_setup_ht_cleanup(struct ipath_devdata *dd)
 {
@@ -1470,7 +1469,7 @@ static int ipath_ht_early_init(struct ip
 	dd->ipath_rcvhdrsize = IPATH_DFLT_RCVHDRSIZE;
 
 	/*
-	 * For HT-400, we allocate a somewhat overly large eager buffer,
+	 * For HT, we allocate a somewhat overly large eager buffer,
 	 * such that we can guarantee that we can receive the largest
 	 * packet that we can send out.  To truly support a 4KB MTU,
 	 * we need to bump this to a large value.  To date, other than
@@ -1531,7 +1530,7 @@ static int ipath_ht_early_init(struct ip
 	if(dd->ipath_boardrev == 5 && dd->ipath_serial[0] == '1' &&
 		dd->ipath_serial[1] == '2' && dd->ipath_serial[2] == '8') {
 		/*
-		 * Later production HT-460 has same changes as HT-465, so
+		 * Later production QHT7040 has same changes as QHT7140, so
 		 * can use GPIO interrupts.  They have serial #'s starting
 		 * with 128, rather than 112.
 		 */
@@ -1560,13 +1559,13 @@ static int ipath_ht_get_base_info(struct
 }
 
 /**
- * ipath_init_ht400_funcs - set up the chip-specific function pointers
+ * ipath_init_iba6110_funcs - set up the chip-specific function pointers
  * @dd: the infinipath device
  *
  * This is global, and is called directly at init to set up the
  * chip-specific function pointers for later use.
  */
-void ipath_init_ht400_funcs(struct ipath_devdata *dd)
+void ipath_init_iba6110_funcs(struct ipath_devdata *dd)
 {
 	dd->ipath_f_intrsetup = ipath_ht_intconfig;
 	dd->ipath_f_bus = ipath_setup_ht_config;
diff --git a/drivers/infiniband/hw/ipath/ipath_pe800.c b/drivers/infiniband/hw/ipath/ipath_iba6120.c
rename from drivers/infiniband/hw/ipath/ipath_pe800.c
rename to drivers/infiniband/hw/ipath/ipath_iba6120.c
--- a/drivers/infiniband/hw/ipath/ipath_iba6120.c	Fri Aug 25 11:19:45 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_iba6120.c	Fri Aug 25 11:19:45 2006 -0700
@@ -32,7 +32,7 @@
  */
 /*
  * This file contains all of the code that is specific to the
- * InfiniPath PE-800 chip.
+ * InfiniPath PCIe chip.
  */
 
 #include <linux/interrupt.h>
@@ -45,9 +45,9 @@
 
 /*
  * This file contains all the chip-specific register information and
- * access functions for the QLogic InfiniPath PE800, the PCI-Express chip.
- *
- * This lists the InfiniPath PE800 registers, in the actual chip layout.
+ * access functions for the QLogic InfiniPath PCI-Express chip.
+ *
+ * This lists the InfiniPath registers, in the actual chip layout.
  * This structure should never be directly accessed.
  */
 struct _infinipath_do_not_use_kernel_regs {
@@ -213,7 +213,6 @@ static const struct ipath_kregs ipath_pe
 	.kr_rcvhdraddr = IPATH_KREG_OFFSET(RcvHdrAddr0),
 	.kr_rcvhdrtailaddr = IPATH_KREG_OFFSET(RcvHdrTailAddr0),
 
-	/* This group is pe-800-specific; and used only in this file */
 	/* The rcvpktled register controls one of the debug port signals, so
 	 * a packet activity LED can be connected to it. */
 	.kr_rcvpktledcnt = IPATH_KREG_OFFSET(RcvPktLEDCnt),
@@ -388,7 +387,7 @@ static void ipath_pe_handle_hwerrors(str
 	*msg = '\0';
 
 	if (hwerrs & INFINIPATH_HWE_MEMBISTFAILED) {
-		strlcat(msg, "[Memory BIST test failed, PE-800 unusable]",
+		strlcat(msg, "[Memory BIST test failed, InfiniPath hardware unusable]",
 			msgl);
 		/* ignore from now on, so disable until driver reloaded */
 		*dd->ipath_statusp |= IPATH_STATUS_HWERROR;
@@ -433,7 +432,7 @@ static void ipath_pe_handle_hwerrors(str
 
 	if (hwerrs & _IPATH_PLL_FAIL) {
 		snprintf(bitsmsg, sizeof bitsmsg,
-			 "[PLL failed (%llx), PE-800 unusable]",
+			 "[PLL failed (%llx), InfiniPath hardware unusable]",
 			 (unsigned long long) hwerrs & _IPATH_PLL_FAIL);
 		strlcat(msg, bitsmsg, msgl);
 		/* ignore from now on, so disable until driver reloaded */
@@ -511,22 +510,25 @@ static int ipath_pe_boardname(struct ipa
 		n = "InfiniPath_Emulation";
 		break;
 	case 1:
-		n = "InfiniPath_PE-800-Bringup";
+		n = "InfiniPath_QLE7140-Bringup";
 		break;
 	case 2:
-		n = "InfiniPath_PE-880";
+		n = "InfiniPath_QLE7140";
 		break;
 	case 3:
-		n = "InfiniPath_PE-850";
+		n = "InfiniPath_QMI7140";
 		break;
 	case 4:
-		n = "InfiniPath_PE-860";
+		n = "InfiniPath_QEM7140";
+		break;
+	case 5:
+		n = "InfiniPath_QMH7140";
 		break;
 	default:
 		ipath_dev_err(dd,
 			      "Don't yet know about board with ID %u\n",
 			      boardrev);
-		snprintf(name, namelen, "Unknown_InfiniPath_PE-8xx_%u",
+		snprintf(name, namelen, "Unknown_InfiniPath_PCIe_%u",
 			 boardrev);
 		break;
 	}
@@ -534,7 +536,7 @@ static int ipath_pe_boardname(struct ipa
 		snprintf(name, namelen, "%s", n);
 
 	if (dd->ipath_majrev != 4 || !dd->ipath_minrev || dd->ipath_minrev>2) {
-		ipath_dev_err(dd, "Unsupported PE-800 revision %u.%u!\n",
+		ipath_dev_err(dd, "Unsupported InfiniPath hardware revision %u.%u!\n",
 			      dd->ipath_majrev, dd->ipath_minrev);
 		ret = 1;
 	} else
@@ -705,7 +707,7 @@ static void ipath_pe_quiet_serdes(struct
 	ipath_write_kreg(dd, dd->ipath_kregs->kr_serdesconfig0, val);
 }
 
-/* this is not yet needed on the PE800, so just return 0. */
+/* this is not yet needed on this chip, so just return 0. */
 static int ipath_pe_intconfig(struct ipath_devdata *dd)
 {
 	return 0;
@@ -759,8 +761,8 @@ static void ipath_setup_pe_setextled(str
  *
  * This is called during driver unload.
  * We do the pci_disable_msi here, not in generic code, because it
- * isn't used for the HT-400. If we do end up needing pci_enable_msi
- * at some point in the future for HT-400, we'll move the call back
+ * isn't used for the HT chips. If we do end up needing pci_enable_msi
+ * at some point in the future for HT, we'll move the call back
  * into the main init_one code.
  */
 static void ipath_setup_pe_cleanup(struct ipath_devdata *dd)
@@ -780,10 +782,10 @@ static void ipath_setup_pe_cleanup(struc
  * late in 2.6.16).
  * All that can be done is to edit the kernel source to remove the quirk
  * check until that is fixed.
- * We do not need to call enable_msi() for our HyperTransport chip (HT-400),
- * even those it uses MSI, and we want to avoid the quirk warning, so
- * So we call enable_msi only for the PE-800.  If we do end up needing
- * pci_enable_msi at some point in the future for HT-400, we'll move the
+ * We do not need to call enable_msi() for our HyperTransport chip,
+ * even though it uses MSI, and we want to avoid the quirk warning, so
+ * So we call enable_msi only for PCIe.  If we do end up needing
+ * pci_enable_msi at some point in the future for HT, we'll move the
  * call back into the main init_one code.
  * We save the msi lo and hi values, so we can restore them after
  * chip reset (the kernel PCI infrastructure doesn't yet handle that
@@ -971,8 +973,7 @@ static int ipath_setup_pe_reset(struct i
 	int ret;
 
 	/* Use ERROR so it shows up in logs, etc. */
-	ipath_dev_err(dd, "Resetting PE-800 unit %u\n",
-		      dd->ipath_unit);
+	ipath_dev_err(dd, "Resetting InfiniPath unit %u\n", dd->ipath_unit);
 	/* keep chip from being accessed in a few places */
 	dd->ipath_flags &= ~(IPATH_INITTED|IPATH_PRESENT);
 	val = dd->ipath_control | INFINIPATH_C_RESET;
@@ -1078,7 +1079,7 @@ static void ipath_pe_put_tid(struct ipat
  * @port: the port
  *
  * clear all TID entries for a port, expected and eager.
- * Used from ipath_close().  On PE800, TIDs are only 32 bits,
+ * Used from ipath_close().  On this chip, TIDs are only 32 bits,
  * not 64, but they are still on 64 bit boundaries, so tidbase
  * is declared as u64 * for the pointer math, even though we write 32 bits
  */
@@ -1148,9 +1149,9 @@ static int ipath_pe_early_init(struct ip
 	dd->ipath_flags |= IPATH_4BYTE_TID;
 
 	/*
-	 * For openib, we need to be able to handle an IB header of 96 bytes
-	 * or 24 dwords.  HT-400 has arbitrary sized receive buffers, so we
-	 * made them the same size as the PIO buffers.  The PE-800 does not
+	 * For openfabrics, we need to be able to handle an IB header of
+	 * 24 dwords.  HT chip has arbitrary sized receive buffers, so we
+	 * made them the same size as the PIO buffers.  This chip does not
 	 * handle arbitrary size buffers, so we need the header large enough
 	 * to handle largest IB header, but still have room for a 2KB MTU
 	 * standard IB packet.
@@ -1158,11 +1159,10 @@ static int ipath_pe_early_init(struct ip
 	dd->ipath_rcvhdrentsize = 24;
 	dd->ipath_rcvhdrsize = IPATH_DFLT_RCVHDRSIZE;
 
-	/* For HT-400, we allocate a somewhat overly large eager buffer,
-	 * such that we can guarantee that we can receive the largest packet
-	 * that we can send out.  To truly support a 4KB MTU, we need to
-	 * bump this to a larger value.  We'll do this when I get around to
-	 * testing 4KB sends on the PE-800, which I have not yet done.
+	/*
+	 * To truly support a 4KB MTU (for usermode), we need to
+	 * bump this to a larger value.  For now, we use them for
+	 * the kernel only.
 	 */
 	dd->ipath_rcvegrbufsize = 2048;
 	/*
@@ -1175,9 +1175,9 @@ static int ipath_pe_early_init(struct ip
 	dd->ipath_init_ibmaxlen = dd->ipath_ibmaxlen;
 
 	/*
-	 * For PE-800, we can request a receive interrupt for 1 or
+	 * We can request a receive interrupt for 1 or
 	 * more packets from current offset.  For now, we set this
-	 * up for a single packet, to match the HT-400 behavior.
+	 * up for a single packet.
 	 */
 	dd->ipath_rhdrhead_intr_off = 1ULL<<32;
 
@@ -1216,13 +1216,13 @@ static int ipath_pe_get_base_info(struct
 }
 
 /**
- * ipath_init_pe800_funcs - set up the chip-specific function pointers
+ * ipath_init_iba6120_funcs - set up the chip-specific function pointers
  * @dd: the infinipath device
  *
  * This is global, and is called directly at init to set up the
  * chip-specific function pointers for later use.
  */
-void ipath_init_pe800_funcs(struct ipath_devdata *dd)
+void ipath_init_iba6120_funcs(struct ipath_devdata *dd)
 {
 	dd->ipath_f_intrsetup = ipath_pe_intconfig;
 	dd->ipath_f_bus = ipath_setup_pe_config;
diff --git a/drivers/infiniband/hw/ipath/ipath_kernel.h b/drivers/infiniband/hw/ipath/ipath_kernel.h
--- a/drivers/infiniband/hw/ipath/ipath_kernel.h	Fri Aug 25 11:19:45 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_kernel.h	Fri Aug 25 11:19:45 2006 -0700
@@ -236,7 +236,7 @@ struct ipath_devdata {
 	u64 ipath_tidtemplate;
 	/* value to write to free TIDs */
 	u64 ipath_tidinvalid;
-	/* PE-800 rcv interrupt setup */
+	/* IBA6120 rcv interrupt setup */
 	u64 ipath_rhdrhead_intr_off;
 
 	/* size of memory at ipath_kregbase */
@@ -621,10 +621,8 @@ int ipath_waitfor_mdio_cmdready(struct i
 int ipath_waitfor_mdio_cmdready(struct ipath_devdata *);
 int ipath_waitfor_complete(struct ipath_devdata *, ipath_kreg, u64, u64 *);
 u32 __iomem *ipath_getpiobuf(struct ipath_devdata *, u32 *);
-/* init PE-800-specific func */
-void ipath_init_pe800_funcs(struct ipath_devdata *);
-/* init HT-400-specific func */
-void ipath_init_ht400_funcs(struct ipath_devdata *);
+void ipath_init_iba6120_funcs(struct ipath_devdata *);
+void ipath_init_iba6110_funcs(struct ipath_devdata *);
 void ipath_get_eeprom_info(struct ipath_devdata *);
 u64 ipath_snap_cntr(struct ipath_devdata *, ipath_creg);
 
diff --git a/drivers/infiniband/hw/ipath/ipath_registers.h b/drivers/infiniband/hw/ipath/ipath_registers.h
--- a/drivers/infiniband/hw/ipath/ipath_registers.h	Fri Aug 25 11:19:45 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_registers.h	Fri Aug 25 11:19:45 2006 -0700
@@ -36,8 +36,7 @@
 
 /*
  * This file should only be included by kernel source, and by the diags.  It
- * defines the registers, and their contents, for the InfiniPath HT-400
- * chip.
+ * defines the registers, and their contents, for InfiniPath chips.
  */
 
 /*
@@ -286,7 +285,7 @@
 
 #define INFINIPATH_RT_ADDR_MASK 0xFFFFFFFFFFULL	/* 40 bits valid */
 
-/* TID entries (memory), HT400-only */
+/* TID entries (memory), HT-only */
 #define INFINIPATH_RT_VALID 0x8000000000000000ULL
 #define INFINIPATH_RT_ADDR_SHIFT 0
 #define INFINIPATH_RT_BUFSIZE_MASK 0x3FFF
