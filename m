Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932516AbWI1QKa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932516AbWI1QKa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 12:10:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964949AbWI1QH6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 12:07:58 -0400
Received: from mx.pathscale.com ([64.160.42.68]:438 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1751878AbWI1QBX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 12:01:23 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 12 of 28] IB/ipath - print more informative parity error
	messages
X-Mercurial-Node: a7ba4b73f972dba7eb77a949f852bd003a4d4ebe
Message-Id: <a7ba4b73f972dba7eb77.1159459208@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1159459196@eng-12.pathscale.com>
Date: Thu, 28 Sep 2006 09:00:08 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rdreier@cisco.com
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Bryan O'Sullivan <bryan.osullivan@qlogic.com>

diff -r 4dbe5e686c78 -r a7ba4b73f972 drivers/infiniband/hw/ipath/ipath_iba6110.c
--- a/drivers/infiniband/hw/ipath/ipath_iba6110.c	Thu Sep 28 08:57:12 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_iba6110.c	Thu Sep 28 08:57:12 2006 -0700
@@ -389,17 +389,28 @@ static void hwerr_crcbits(struct ipath_d
 				     _IPATH_HTLINK1_CRCBITS)));
 }
 
+/* 6110 specific hardware errors... */
+static const struct ipath_hwerror_msgs ipath_6110_hwerror_msgs[] = {
+	INFINIPATH_HWE_MSG(HTCBUSIREQPARITYERR, "HTC Ireq Parity"),
+	INFINIPATH_HWE_MSG(HTCBUSTREQPARITYERR, "HTC Treq Parity"),
+	INFINIPATH_HWE_MSG(HTCBUSTRESPPARITYERR, "HTC Tresp Parity"),
+	INFINIPATH_HWE_MSG(HTCMISCERR5, "HT core Misc5"),
+	INFINIPATH_HWE_MSG(HTCMISCERR6, "HT core Misc6"),
+	INFINIPATH_HWE_MSG(HTCMISCERR7, "HT core Misc7"),
+	INFINIPATH_HWE_MSG(RXDSYNCMEMPARITYERR, "Rx Dsync"),
+	INFINIPATH_HWE_MSG(SERDESPLLFAILED, "SerDes PLL"),
+};
+
 /**
- * ipath_ht_handle_hwerrors - display hardware errors
+ * ipath_ht_handle_hwerrors - display hardware errors.
  * @dd: the infinipath device
  * @msg: the output buffer
  * @msgl: the size of the output buffer
  *
- * Use same msg buffer as regular errors to avoid
- * excessive stack use.  Most hardware errors are catastrophic, but for
- * right now, we'll print them and continue.
- * We reuse the same message buffer as ipath_handle_errors() to avoid
- * excessive stack usage.
+ * Use same msg buffer as regular errors to avoid excessive stack
+ * use.  Most hardware errors are catastrophic, but for right now,
+ * we'll print them and continue.  We reuse the same message buffer as
+ * ipath_handle_errors() to avoid excessive stack usage.
  */
 static void ipath_ht_handle_hwerrors(struct ipath_devdata *dd, char *msg,
 				     size_t msgl)
@@ -499,44 +510,16 @@ static void ipath_ht_handle_hwerrors(str
 			 bits);
 		strlcat(msg, bitsmsg, msgl);
 	}
-	if (hwerrs & (INFINIPATH_HWE_RXEMEMPARITYERR_MASK
-		      << INFINIPATH_HWE_RXEMEMPARITYERR_SHIFT)) {
-		bits = (u32) ((hwerrs >>
-			       INFINIPATH_HWE_RXEMEMPARITYERR_SHIFT) &
-			      INFINIPATH_HWE_RXEMEMPARITYERR_MASK);
-		snprintf(bitsmsg, sizeof bitsmsg, "[RXE Parity Errs %x] ",
-			 bits);
-		strlcat(msg, bitsmsg, msgl);
-	}
-	if (hwerrs & (INFINIPATH_HWE_TXEMEMPARITYERR_MASK
-		      << INFINIPATH_HWE_TXEMEMPARITYERR_SHIFT)) {
-		bits = (u32) ((hwerrs >>
-			       INFINIPATH_HWE_TXEMEMPARITYERR_SHIFT) &
-			      INFINIPATH_HWE_TXEMEMPARITYERR_MASK);
-		snprintf(bitsmsg, sizeof bitsmsg, "[TXE Parity Errs %x] ",
-			 bits);
-		strlcat(msg, bitsmsg, msgl);
-	}
-	if (hwerrs & INFINIPATH_HWE_IBCBUSTOSPCPARITYERR)
-		strlcat(msg, "[IB2IPATH Parity]", msgl);
-	if (hwerrs & INFINIPATH_HWE_IBCBUSFRSPCPARITYERR)
-		strlcat(msg, "[IPATH2IB Parity]", msgl);
-	if (hwerrs & INFINIPATH_HWE_HTCBUSIREQPARITYERR)
-		strlcat(msg, "[HTC Ireq Parity]", msgl);
-	if (hwerrs & INFINIPATH_HWE_HTCBUSTREQPARITYERR)
-		strlcat(msg, "[HTC Treq Parity]", msgl);
-	if (hwerrs & INFINIPATH_HWE_HTCBUSTRESPPARITYERR)
-		strlcat(msg, "[HTC Tresp Parity]", msgl);
+
+	ipath_format_hwerrors(hwerrs,
+			      ipath_6110_hwerror_msgs,
+			      sizeof(ipath_6110_hwerror_msgs) /
+			      sizeof(ipath_6110_hwerror_msgs[0]),
+			      msg, msgl);
 
 	if (hwerrs & (_IPATH_HTLINK0_CRCBITS | _IPATH_HTLINK1_CRCBITS))
 		hwerr_crcbits(dd, hwerrs, msg, msgl);
 
-	if (hwerrs & INFINIPATH_HWE_HTCMISCERR5)
-		strlcat(msg, "[HT core Misc5]", msgl);
-	if (hwerrs & INFINIPATH_HWE_HTCMISCERR6)
-		strlcat(msg, "[HT core Misc6]", msgl);
-	if (hwerrs & INFINIPATH_HWE_HTCMISCERR7)
-		strlcat(msg, "[HT core Misc7]", msgl);
 	if (hwerrs & INFINIPATH_HWE_MEMBISTFAILED) {
 		strlcat(msg, "[Memory BIST test failed, InfiniPath hardware unusable]",
 			msgl);
@@ -572,11 +555,6 @@ static void ipath_ht_handle_hwerrors(str
 		ipath_write_kreg(dd, dd->ipath_kregs->kr_hwerrmask,
 				 dd->ipath_hwerrmask);
 	}
-
-	if (hwerrs & INFINIPATH_HWE_RXDSYNCMEMPARITYERR)
-		strlcat(msg, "[Rx Dsync]", msgl);
-	if (hwerrs & INFINIPATH_HWE_SERDESPLLFAILED)
-		strlcat(msg, "[SerDes PLL]", msgl);
 
 	ipath_dev_err(dd, "%s hardware error\n", msg);
 	if (isfatal && !ipath_diag_inuse && dd->ipath_freezemsg)
diff -r 4dbe5e686c78 -r a7ba4b73f972 drivers/infiniband/hw/ipath/ipath_iba6120.c
--- a/drivers/infiniband/hw/ipath/ipath_iba6120.c	Thu Sep 28 08:57:12 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_iba6120.c	Thu Sep 28 08:57:12 2006 -0700
@@ -301,6 +301,26 @@ static const struct ipath_cregs ipath_pe
  */
 #define INFINIPATH_XGXS_SUPPRESS_ARMLAUNCH_ERR (1ULL<<63)
 
+/* 6120 specific hardware errors... */
+static const struct ipath_hwerror_msgs ipath_6120_hwerror_msgs[] = {
+	INFINIPATH_HWE_MSG(PCIEPOISONEDTLP, "PCIe Poisoned TLP"),
+	INFINIPATH_HWE_MSG(PCIECPLTIMEOUT, "PCIe completion timeout"),
+	/*
+	 * In practice, it's unlikely wthat we'll see PCIe PLL, or bus
+	 * parity or memory parity error failures, because most likely we
+	 * won't be able to talk to the core of the chip.  Nonetheless, we
+	 * might see them, if they are in parts of the PCIe core that aren't
+	 * essential.
+	 */
+	INFINIPATH_HWE_MSG(PCIE1PLLFAILED, "PCIePLL1"),
+	INFINIPATH_HWE_MSG(PCIE0PLLFAILED, "PCIePLL0"),
+	INFINIPATH_HWE_MSG(PCIEBUSPARITYXTLH, "PCIe XTLH core parity"),
+	INFINIPATH_HWE_MSG(PCIEBUSPARITYXADM, "PCIe ADM TX core parity"),
+	INFINIPATH_HWE_MSG(PCIEBUSPARITYRADM, "PCIe ADM RX core parity"),
+	INFINIPATH_HWE_MSG(RXDSYNCMEMPARITYERR, "Rx Dsync"),
+	INFINIPATH_HWE_MSG(SERDESPLLFAILED, "SerDes PLL"),
+};
+
 /**
  * ipath_pe_handle_hwerrors - display hardware errors.
  * @dd: the infinipath device
@@ -403,24 +423,13 @@ static void ipath_pe_handle_hwerrors(str
 		ipath_write_kreg(dd, dd->ipath_kregs->kr_hwerrmask,
 				 dd->ipath_hwerrmask);
 	}
-	if (hwerrs & (INFINIPATH_HWE_RXEMEMPARITYERR_MASK
-		      << INFINIPATH_HWE_RXEMEMPARITYERR_SHIFT)) {
-		bits = (u32) ((hwerrs >>
-			       INFINIPATH_HWE_RXEMEMPARITYERR_SHIFT) &
-			      INFINIPATH_HWE_RXEMEMPARITYERR_MASK);
-		snprintf(bitsmsg, sizeof bitsmsg, "[RXE Parity Errs %x] ",
-			 bits);
-		strlcat(msg, bitsmsg, msgl);
-	}
-	if (hwerrs & (INFINIPATH_HWE_TXEMEMPARITYERR_MASK
-		      << INFINIPATH_HWE_TXEMEMPARITYERR_SHIFT)) {
-		bits = (u32) ((hwerrs >>
-			       INFINIPATH_HWE_TXEMEMPARITYERR_SHIFT) &
-			      INFINIPATH_HWE_TXEMEMPARITYERR_MASK);
-		snprintf(bitsmsg, sizeof bitsmsg, "[TXE Parity Errs %x] ",
-			 bits);
-		strlcat(msg, bitsmsg, msgl);
-	}
+
+	ipath_format_hwerrors(hwerrs,
+			      ipath_6120_hwerror_msgs,
+			      sizeof(ipath_6120_hwerror_msgs)/
+			      sizeof(ipath_6120_hwerror_msgs[0]),
+			      msg, msgl);
+
 	if (hwerrs & (INFINIPATH_HWE_PCIEMEMPARITYERR_MASK
 		      << INFINIPATH_HWE_PCIEMEMPARITYERR_SHIFT)) {
 		bits = (u32) ((hwerrs >>
@@ -430,10 +439,6 @@ static void ipath_pe_handle_hwerrors(str
 			 "[PCIe Mem Parity Errs %x] ", bits);
 		strlcat(msg, bitsmsg, msgl);
 	}
-	if (hwerrs & INFINIPATH_HWE_IBCBUSTOSPCPARITYERR)
-		strlcat(msg, "[IB2IPATH Parity]", msgl);
-	if (hwerrs & INFINIPATH_HWE_IBCBUSFRSPCPARITYERR)
-		strlcat(msg, "[IPATH2IB Parity]", msgl);
 
 #define _IPATH_PLL_FAIL (INFINIPATH_HWE_COREPLL_FBSLIP |	\
 			 INFINIPATH_HWE_COREPLL_RFSLIP )
@@ -458,34 +463,6 @@ static void ipath_pe_handle_hwerrors(str
 		ipath_write_kreg(dd, dd->ipath_kregs->kr_hwerrmask,
 				 dd->ipath_hwerrmask);
 	}
-
-	if (hwerrs & INFINIPATH_HWE_PCIEPOISONEDTLP)
-		strlcat(msg, "[PCIe Poisoned TLP]", msgl);
-	if (hwerrs & INFINIPATH_HWE_PCIECPLTIMEOUT)
-		strlcat(msg, "[PCIe completion timeout]", msgl);
-
-	/*
-	 * In practice, it's unlikely wthat we'll see PCIe PLL, or bus
-	 * parity or memory parity error failures, because most likely we
-	 * won't be able to talk to the core of the chip.  Nonetheless, we
-	 * might see them, if they are in parts of the PCIe core that aren't
-	 * essential.
-	 */
-	if (hwerrs & INFINIPATH_HWE_PCIE1PLLFAILED)
-		strlcat(msg, "[PCIePLL1]", msgl);
-	if (hwerrs & INFINIPATH_HWE_PCIE0PLLFAILED)
-		strlcat(msg, "[PCIePLL0]", msgl);
-	if (hwerrs & INFINIPATH_HWE_PCIEBUSPARITYXTLH)
-		strlcat(msg, "[PCIe XTLH core parity]", msgl);
-	if (hwerrs & INFINIPATH_HWE_PCIEBUSPARITYXADM)
-		strlcat(msg, "[PCIe ADM TX core parity]", msgl);
-	if (hwerrs & INFINIPATH_HWE_PCIEBUSPARITYRADM)
-		strlcat(msg, "[PCIe ADM RX core parity]", msgl);
-
-	if (hwerrs & INFINIPATH_HWE_RXDSYNCMEMPARITYERR)
-		strlcat(msg, "[Rx Dsync]", msgl);
-	if (hwerrs & INFINIPATH_HWE_SERDESPLLFAILED)
-		strlcat(msg, "[SerDes PLL]", msgl);
 
 	ipath_dev_err(dd, "%s hardware error\n", msg);
 	if (isfatal && !ipath_diag_inuse && dd->ipath_freezemsg) {
diff -r 4dbe5e686c78 -r a7ba4b73f972 drivers/infiniband/hw/ipath/ipath_intr.c
--- a/drivers/infiniband/hw/ipath/ipath_intr.c	Thu Sep 28 08:57:12 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_intr.c	Thu Sep 28 08:57:12 2006 -0700
@@ -132,6 +132,82 @@ static u64 handle_e_sum_errs(struct ipat
 	return ignore_this_time;
 }
 
+/* generic hw error messages... */
+#define INFINIPATH_HWE_TXEMEMPARITYERR_MSG(a) \
+	{ \
+		.mask = ( INFINIPATH_HWE_TXEMEMPARITYERR_##a <<    \
+			  INFINIPATH_HWE_TXEMEMPARITYERR_SHIFT ),   \
+		.msg = "TXE " #a " Memory Parity"	     \
+	}
+#define INFINIPATH_HWE_RXEMEMPARITYERR_MSG(a) \
+	{ \
+		.mask = ( INFINIPATH_HWE_RXEMEMPARITYERR_##a <<    \
+			  INFINIPATH_HWE_RXEMEMPARITYERR_SHIFT ),   \
+		.msg = "RXE " #a " Memory Parity"	     \
+	}
+
+static const struct ipath_hwerror_msgs ipath_generic_hwerror_msgs[] = {
+	INFINIPATH_HWE_MSG(IBCBUSFRSPCPARITYERR, "IPATH2IB Parity"),
+	INFINIPATH_HWE_MSG(IBCBUSTOSPCPARITYERR, "IB2IPATH Parity"),
+
+	INFINIPATH_HWE_TXEMEMPARITYERR_MSG(PIOBUF),
+	INFINIPATH_HWE_TXEMEMPARITYERR_MSG(PIOPBC),
+	INFINIPATH_HWE_TXEMEMPARITYERR_MSG(PIOLAUNCHFIFO),
+
+	INFINIPATH_HWE_RXEMEMPARITYERR_MSG(RCVBUF),
+	INFINIPATH_HWE_RXEMEMPARITYERR_MSG(LOOKUPQ),
+	INFINIPATH_HWE_RXEMEMPARITYERR_MSG(EAGERTID),
+	INFINIPATH_HWE_RXEMEMPARITYERR_MSG(EXPTID),
+	INFINIPATH_HWE_RXEMEMPARITYERR_MSG(FLAGBUF),
+	INFINIPATH_HWE_RXEMEMPARITYERR_MSG(DATAINFO),
+	INFINIPATH_HWE_RXEMEMPARITYERR_MSG(HDRINFO),
+};
+
+/**
+ * ipath_format_hwmsg - format a single hwerror message
+ * @msg message buffer
+ * @msgl length of message buffer
+ * @hwmsg message to add to message buffer
+ */
+static void ipath_format_hwmsg(char *msg, size_t msgl, const char *hwmsg)
+{
+	strlcat(msg, "[", msgl);
+	strlcat(msg, hwmsg, msgl);
+	strlcat(msg, "]", msgl);
+}
+
+/**
+ * ipath_format_hwerrors - format hardware error messages for display
+ * @hwerrs hardware errors bit vector
+ * @hwerrmsgs hardware error descriptions
+ * @nhwerrmsgs number of hwerrmsgs
+ * @msg message buffer
+ * @msgl message buffer length
+ */
+void ipath_format_hwerrors(u64 hwerrs,
+			   const struct ipath_hwerror_msgs *hwerrmsgs,
+			   size_t nhwerrmsgs,
+			   char *msg, size_t msgl)
+{
+	int i;
+	const int glen =
+	    sizeof(ipath_generic_hwerror_msgs) /
+	    sizeof(ipath_generic_hwerror_msgs[0]);
+
+	for (i=0; i<glen; i++) {
+		if (hwerrs & ipath_generic_hwerror_msgs[i].mask) {
+			ipath_format_hwmsg(msg, msgl,
+					   ipath_generic_hwerror_msgs[i].msg);
+		}
+	}
+
+	for (i=0; i<nhwerrmsgs; i++) {
+		if (hwerrs & hwerrmsgs[i].mask) {
+			ipath_format_hwmsg(msg, msgl, hwerrmsgs[i].msg);
+		}
+	}
+}
+
 /* return the strings for the most common link states */
 static char *ib_linkstate(u32 linkstate)
 {
diff -r 4dbe5e686c78 -r a7ba4b73f972 drivers/infiniband/hw/ipath/ipath_kernel.h
--- a/drivers/infiniband/hw/ipath/ipath_kernel.h	Thu Sep 28 08:57:12 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_kernel.h	Thu Sep 28 08:57:12 2006 -0700
@@ -897,4 +897,20 @@ extern struct mutex ipath_mutex;
 
 #endif /* _IPATH_DEBUGGING */
 
+/*
+ * this is used for formatting hw error messages...
+ */
+struct ipath_hwerror_msgs {
+	u64 mask;
+	const char *msg;
+};
+
+#define INFINIPATH_HWE_MSG(a, b) { .mask = INFINIPATH_HWE_##a, .msg = b }
+
+/* in ipath_intr.c... */
+void ipath_format_hwerrors(u64 hwerrs,
+			   const struct ipath_hwerror_msgs *hwerrmsgs,
+			   size_t nhwerrmsgs,
+			   char *msg, size_t lmsg);
+
 #endif				/* _IPATH_KERNEL_H */
diff -r 4dbe5e686c78 -r a7ba4b73f972 drivers/infiniband/hw/ipath/ipath_registers.h
--- a/drivers/infiniband/hw/ipath/ipath_registers.h	Thu Sep 28 08:57:12 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_registers.h	Thu Sep 28 08:57:12 2006 -0700
@@ -134,10 +134,24 @@
 #define INFINIPATH_HWE_TXEMEMPARITYERR_SHIFT 40
 #define INFINIPATH_HWE_RXEMEMPARITYERR_MASK 0x7FULL
 #define INFINIPATH_HWE_RXEMEMPARITYERR_SHIFT 44
-#define INFINIPATH_HWE_RXDSYNCMEMPARITYERR  0x0000000400000000ULL
-#define INFINIPATH_HWE_MEMBISTFAILED        0x0040000000000000ULL
 #define INFINIPATH_HWE_IBCBUSTOSPCPARITYERR 0x4000000000000000ULL
 #define INFINIPATH_HWE_IBCBUSFRSPCPARITYERR 0x8000000000000000ULL
+/* txe mem parity errors (shift by INFINIPATH_HWE_TXEMEMPARITYERR_SHIFT) */
+#define INFINIPATH_HWE_TXEMEMPARITYERR_PIOBUF	0x1ULL
+#define INFINIPATH_HWE_TXEMEMPARITYERR_PIOPBC	0x2ULL
+#define INFINIPATH_HWE_TXEMEMPARITYERR_PIOLAUNCHFIFO 0x4ULL
+/* rxe mem parity errors (shift by INFINIPATH_HWE_RXEMEMPARITYERR_SHIFT) */
+#define INFINIPATH_HWE_RXEMEMPARITYERR_RCVBUF   0x01ULL
+#define INFINIPATH_HWE_RXEMEMPARITYERR_LOOKUPQ  0x02ULL
+#define INFINIPATH_HWE_RXEMEMPARITYERR_EAGERTID 0x04ULL
+#define INFINIPATH_HWE_RXEMEMPARITYERR_EXPTID   0x08ULL
+#define INFINIPATH_HWE_RXEMEMPARITYERR_FLAGBUF  0x10ULL
+#define INFINIPATH_HWE_RXEMEMPARITYERR_DATAINFO 0x20ULL
+#define INFINIPATH_HWE_RXEMEMPARITYERR_HDRINFO  0x40ULL
+/* waldo specific -- find the rest in ipath_6110.c */
+#define INFINIPATH_HWE_RXDSYNCMEMPARITYERR  0x0000000400000000ULL
+/* monty specific -- find the rest in ipath_6120.c */
+#define INFINIPATH_HWE_MEMBISTFAILED	0x0040000000000000ULL
 
 /* kr_hwdiagctrl bits */
 #define INFINIPATH_DC_FORCETXEMEMPARITYERR_MASK 0xFULL
