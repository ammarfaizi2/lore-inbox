Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964965AbWI1QDg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964965AbWI1QDg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 12:03:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932512AbWI1QCj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 12:02:39 -0400
Received: from mx.pathscale.com ([64.160.42.68]:4278 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1751924AbWI1QBY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 12:01:24 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 22 of 28] IB/ipath - fix and recover TXE piobuf and PBC parity
	errors
X-Mercurial-Node: 5aea5f31529d9b8ff214bc11fd554eadee9fab18
Message-Id: <5aea5f31529d9b8ff214.1159459218@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1159459196@eng-12.pathscale.com>
Date: Thu, 28 Sep 2006 09:00:18 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rdreier@cisco.com
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We can sometimes trigger parity errors due to processor speculative
reads to our write-combined memory (mostly seen on Woodcrest).   Add a
stats counter for these.

Factored out the sendbuffererror buffer cancellation code so it can be
used in the new handling; suppress likely subsequent error messages if
within two jiffies of the cancellation.

Also restore 2 dropped TXE lines on hwe_bitsextant noticed while
debugging.

Signed-off-by: Bryan O'Sullivan <bryan.osullivan@qlogic.com>

diff -r a78c7b475df6 -r 5aea5f31529d drivers/infiniband/hw/ipath/ipath_common.h
--- a/drivers/infiniband/hw/ipath/ipath_common.h	Thu Sep 28 08:57:13 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_common.h	Thu Sep 28 08:57:13 2006 -0700
@@ -141,8 +141,9 @@ struct infinipath_stats {
 	 * packets if ipath not configured, etc.)
 	 */
 	__u64 sps_krdrops;
+	__u64 sps_txeparity; // PIO buffer parity error, recovered
 	/* pad for future growth */
-	__u64 __sps_pad[46];
+	__u64 __sps_pad[45];
 };
 
 /*
diff -r a78c7b475df6 -r 5aea5f31529d drivers/infiniband/hw/ipath/ipath_iba6110.c
--- a/drivers/infiniband/hw/ipath/ipath_iba6110.c	Thu Sep 28 08:57:13 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_iba6110.c	Thu Sep 28 08:57:13 2006 -0700
@@ -451,7 +451,10 @@ static void ipath_ht_handle_hwerrors(str
 	 * make sure we get this much out, unless told to be quiet,
 	 * or it's occurred within the last 5 seconds
 	 */
-	if ((hwerrs & ~dd->ipath_lasthwerror) ||
+	if ((hwerrs & ~(dd->ipath_lasthwerror |
+			((INFINIPATH_HWE_TXEMEMPARITYERR_PIOBUF |
+			  INFINIPATH_HWE_TXEMEMPARITYERR_PIOPBC)
+			<< INFINIPATH_HWE_TXEMEMPARITYERR_SHIFT))) ||
 	    (ipath_debug & __IPATH_VERBDBG))
 		dev_info(&dd->pcidev->dev, "Hardware error: hwerr=0x%llx "
 			 "(cleared)\n", (unsigned long long) hwerrs);
@@ -464,6 +467,33 @@ static void ipath_ht_handle_hwerrors(str
 
 	ctrl = ipath_read_kreg32(dd, dd->ipath_kregs->kr_control);
 	if (ctrl & INFINIPATH_C_FREEZEMODE) {
+		/*
+		 * parity errors in send memory are recoverable,
+		 * just cancel the send (if indicated in * sendbuffererror),
+		 * count the occurrence, unfreeze (if no other handled
+		 * hardware error bits are set), and continue. They can
+		 * occur if a processor speculative read is done to the PIO
+		 * buffer while we are sending a packet, for example.
+		 */
+		if (hwerrs & ((INFINIPATH_HWE_TXEMEMPARITYERR_PIOBUF |
+			       INFINIPATH_HWE_TXEMEMPARITYERR_PIOPBC)
+			      << INFINIPATH_HWE_TXEMEMPARITYERR_SHIFT)) {
+			ipath_stats.sps_txeparity++;
+			ipath_dbg("Recovering from TXE parity error (%llu), "
+			    	  "hwerrstatus=%llx\n",
+				  (unsigned long long) ipath_stats.sps_txeparity,
+				  (unsigned long long) hwerrs);
+			ipath_disarm_senderrbufs(dd);
+			hwerrs &= ~((INFINIPATH_HWE_TXEMEMPARITYERR_PIOBUF |
+				     INFINIPATH_HWE_TXEMEMPARITYERR_PIOPBC)
+				    << INFINIPATH_HWE_TXEMEMPARITYERR_SHIFT);
+			if (!hwerrs) { // else leave in freeze mode
+				ipath_write_kreg(dd,
+						 dd->ipath_kregs->kr_control,
+						 dd->ipath_control);
+				return;
+			}
+		}
 		if (hwerrs) {
 			/*
 			 * if any set that we aren't ignoring; only
diff -r a78c7b475df6 -r 5aea5f31529d drivers/infiniband/hw/ipath/ipath_iba6120.c
--- a/drivers/infiniband/hw/ipath/ipath_iba6120.c	Thu Sep 28 08:57:13 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_iba6120.c	Thu Sep 28 08:57:13 2006 -0700
@@ -370,7 +370,10 @@ static void ipath_pe_handle_hwerrors(str
 	 * make sure we get this much out, unless told to be quiet,
 	 * or it's occurred within the last 5 seconds
 	 */
-	if ((hwerrs & ~dd->ipath_lasthwerror) ||
+	if ((hwerrs & ~(dd->ipath_lasthwerror |
+			((INFINIPATH_HWE_TXEMEMPARITYERR_PIOBUF |
+			  INFINIPATH_HWE_TXEMEMPARITYERR_PIOPBC)
+			 << INFINIPATH_HWE_TXEMEMPARITYERR_SHIFT))) ||
 	    (ipath_debug & __IPATH_VERBDBG))
 		dev_info(&dd->pcidev->dev, "Hardware error: hwerr=0x%llx "
 			 "(cleared)\n", (unsigned long long) hwerrs);
@@ -383,6 +386,33 @@ static void ipath_pe_handle_hwerrors(str
 
 	ctrl = ipath_read_kreg32(dd, dd->ipath_kregs->kr_control);
 	if (ctrl & INFINIPATH_C_FREEZEMODE) {
+		/*
+		 * parity errors in send memory are recoverable,
+		 * just cancel the send (if indicated in * sendbuffererror),
+		 * count the occurrence, unfreeze (if no other handled
+		 * hardware error bits are set), and continue. They can
+		 * occur if a processor speculative read is done to the PIO
+		 * buffer while we are sending a packet, for example.
+		 */
+		if (hwerrs & ((INFINIPATH_HWE_TXEMEMPARITYERR_PIOBUF |
+			       INFINIPATH_HWE_TXEMEMPARITYERR_PIOPBC)
+			      << INFINIPATH_HWE_TXEMEMPARITYERR_SHIFT)) {
+			ipath_stats.sps_txeparity++;
+			ipath_dbg("Recovering from TXE parity error (%llu), "
+			    	  "hwerrstatus=%llx\n",
+				  (unsigned long long) ipath_stats.sps_txeparity,
+				  (unsigned long long) hwerrs);
+			ipath_disarm_senderrbufs(dd);
+			hwerrs &= ~((INFINIPATH_HWE_TXEMEMPARITYERR_PIOBUF |
+				     INFINIPATH_HWE_TXEMEMPARITYERR_PIOPBC)
+				    << INFINIPATH_HWE_TXEMEMPARITYERR_SHIFT);
+			if (!hwerrs) { // else leave in freeze mode
+				ipath_write_kreg(dd,
+						 dd->ipath_kregs->kr_control,
+						 dd->ipath_control);
+			    return;
+			}
+		}
 		if (hwerrs) {
 			/*
 			 * if any set that we aren't ignoring only make the
@@ -406,9 +436,8 @@ static void ipath_pe_handle_hwerrors(str
 		} else {
 			ipath_dbg("Clearing freezemode on ignored hardware "
 				  "error\n");
-			ctrl &= ~INFINIPATH_C_FREEZEMODE;
 			ipath_write_kreg(dd, dd->ipath_kregs->kr_control,
-					 ctrl);
+			   		 dd->ipath_control);
 		}
 	}
 
@@ -880,6 +909,8 @@ static void ipath_init_pe_variables(stru
 	dd->ipath_hwe_bitsextant =
 		(INFINIPATH_HWE_RXEMEMPARITYERR_MASK <<
 		 INFINIPATH_HWE_RXEMEMPARITYERR_SHIFT) |
+		(INFINIPATH_HWE_TXEMEMPARITYERR_MASK <<
+		 INFINIPATH_HWE_TXEMEMPARITYERR_SHIFT) |
 		(INFINIPATH_HWE_PCIEMEMPARITYERR_MASK <<
 		 INFINIPATH_HWE_PCIEMEMPARITYERR_SHIFT) |
 		INFINIPATH_HWE_PCIE1PLLFAILED |
diff -r a78c7b475df6 -r 5aea5f31529d drivers/infiniband/hw/ipath/ipath_intr.c
--- a/drivers/infiniband/hw/ipath/ipath_intr.c	Thu Sep 28 08:57:13 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_intr.c	Thu Sep 28 08:57:13 2006 -0700
@@ -37,6 +37,50 @@
 #include "ipath_verbs.h"
 #include "ipath_common.h"
 
+/*
+ * Called when we might have an error that is specific to a particular
+ * PIO buffer, and may need to cancel that buffer, so it can be re-used.
+ */
+void ipath_disarm_senderrbufs(struct ipath_devdata *dd)
+{
+	u32 piobcnt;
+	unsigned long sbuf[4];
+	/*
+	 * it's possible that sendbuffererror could have bits set; might
+	 * have already done this as a result of hardware error handling
+	 */
+	piobcnt = dd->ipath_piobcnt2k + dd->ipath_piobcnt4k;
+	/* read these before writing errorclear */
+	sbuf[0] = ipath_read_kreg64(
+		dd, dd->ipath_kregs->kr_sendbuffererror);
+	sbuf[1] = ipath_read_kreg64(
+		dd, dd->ipath_kregs->kr_sendbuffererror + 1);
+	if (piobcnt > 128) {
+		sbuf[2] = ipath_read_kreg64(
+			dd, dd->ipath_kregs->kr_sendbuffererror + 2);
+		sbuf[3] = ipath_read_kreg64(
+			dd, dd->ipath_kregs->kr_sendbuffererror + 3);
+	}
+
+	if (sbuf[0] || sbuf[1] || (piobcnt > 128 && (sbuf[2] || sbuf[3]))) {
+		int i;
+		if (ipath_debug & (__IPATH_PKTDBG|__IPATH_DBG)) {
+			__IPATH_DBG_WHICH(__IPATH_PKTDBG|__IPATH_DBG,
+					  "SendbufErrs %lx %lx", sbuf[0],
+					  sbuf[1]);
+			if (ipath_debug & __IPATH_PKTDBG && piobcnt > 128)
+				printk(" %lx %lx ", sbuf[2], sbuf[3]);
+			printk("\n");
+		}
+
+		for (i = 0; i < piobcnt; i++)
+			if (test_bit(i, sbuf))
+				ipath_disarm_piobufs(dd, i, 1);
+		dd->ipath_lastcancel = jiffies+3; // no armlaunch for a bit
+	}
+}
+
+
 /* These are all rcv-related errors which we want to count for stats */
 #define E_SUM_PKTERRS \
 	(INFINIPATH_E_RHDRLEN | INFINIPATH_E_RBADTID | \
@@ -68,53 +112,9 @@
 
 static u64 handle_e_sum_errs(struct ipath_devdata *dd, ipath_err_t errs)
 {
-	unsigned long sbuf[4];
 	u64 ignore_this_time = 0;
-	u32 piobcnt;
-
-	/* if possible that sendbuffererror could be valid */
-	piobcnt = dd->ipath_piobcnt2k + dd->ipath_piobcnt4k;
-	/* read these before writing errorclear */
-	sbuf[0] = ipath_read_kreg64(
-		dd, dd->ipath_kregs->kr_sendbuffererror);
-	sbuf[1] = ipath_read_kreg64(
-		dd, dd->ipath_kregs->kr_sendbuffererror + 1);
-	if (piobcnt > 128) {
-		sbuf[2] = ipath_read_kreg64(
-			dd, dd->ipath_kregs->kr_sendbuffererror + 2);
-		sbuf[3] = ipath_read_kreg64(
-			dd, dd->ipath_kregs->kr_sendbuffererror + 3);
-	}
-
-	if (sbuf[0] || sbuf[1] || (piobcnt > 128 && (sbuf[2] || sbuf[3]))) {
-		int i;
-
-		ipath_cdbg(PKT, "SendbufErrs %lx %lx ", sbuf[0], sbuf[1]);
-		if (ipath_debug & __IPATH_PKTDBG && piobcnt > 128)
-			printk("%lx %lx ", sbuf[2], sbuf[3]);
-		for (i = 0; i < piobcnt; i++) {
-			if (test_bit(i, sbuf)) {
-				u32 __iomem *piobuf;
-				if (i < dd->ipath_piobcnt2k)
-					piobuf = (u32 __iomem *)
-						(dd->ipath_pio2kbase +
-						 i * dd->ipath_palign);
-				else
-					piobuf = (u32 __iomem *)
-						(dd->ipath_pio4kbase +
-						 (i - dd->ipath_piobcnt2k) *
-						 dd->ipath_4kalign);
-
-				ipath_cdbg(PKT,
-					   "PIObuf[%u] @%p pbc is %x; ",
-					   i, piobuf, readl(piobuf));
-
-				ipath_disarm_piobufs(dd, i, 1);
-			}
-		}
-		if (ipath_debug & __IPATH_PKTDBG)
-			printk("\n");
-	}
+
+	ipath_disarm_senderrbufs(dd);
 	if ((errs & E_SUM_LINK_PKTERRS) &&
 	    !(dd->ipath_flags & IPATH_LINKACTIVE)) {
 		/*
@@ -554,6 +554,14 @@ static int handle_errors(struct ipath_de
 			~(INFINIPATH_E_HARDWARE |
 			  INFINIPATH_E_IBSTATUSCHANGED);
 	}
+
+	// likely due to cancel, so suppress
+	if ((errs & (INFINIPATH_E_SPKTLEN | INFINIPATH_E_SPIOARMLAUNCH)) &&
+		dd->ipath_lastcancel > jiffies) {
+		ipath_dbg("Suppressed armlaunch/spktlen after error send cancel\n");
+		errs &= ~(INFINIPATH_E_SPIOARMLAUNCH | INFINIPATH_E_SPKTLEN);
+	}
+
 	if (!errs)
 		return 0;
 
diff -r a78c7b475df6 -r 5aea5f31529d drivers/infiniband/hw/ipath/ipath_kernel.h
--- a/drivers/infiniband/hw/ipath/ipath_kernel.h	Thu Sep 28 08:57:13 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_kernel.h	Thu Sep 28 08:57:13 2006 -0700
@@ -427,6 +427,9 @@ struct ipath_devdata {
 	unsigned long ipath_rcvctrl;
 	/* shadow kr_sendctrl */
 	unsigned long ipath_sendctrl;
+	/* ports waiting for PIOavail intr */
+	unsigned long ipath_portpiowait;
+	unsigned long ipath_lastcancel; // to not count armlaunch after cancel
 
 	/* value we put in kr_rcvhdrcnt */
 	u32 ipath_rcvhdrcnt;
@@ -490,8 +493,6 @@ struct ipath_devdata {
 	u32 ipath_htwidth;
 	/* HT speed (200,400,800,1000) from HT config */
 	u32 ipath_htspeed;
-	/* ports waiting for PIOavail intr */
-	unsigned long ipath_portpiowait;
 	/*
 	 * number of sequential ibcstatus change for polling active/quiet
 	 * (i.e., link not coming up).
@@ -585,6 +586,7 @@ void ipath_disable_wc(struct ipath_devda
 void ipath_disable_wc(struct ipath_devdata *dd);
 int ipath_count_units(int *npresentp, int *nupp, u32 *maxportsp);
 void ipath_shutdown_device(struct ipath_devdata *);
+void ipath_disarm_senderrbufs(struct ipath_devdata *);
 
 struct file_operations;
 int ipath_cdev_init(int minor, char *name, struct file_operations *fops,
