Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261413AbULATDQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261413AbULATDQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 14:03:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261414AbULATDQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 14:03:16 -0500
Received: from ylpvm01-ext.prodigy.net ([207.115.57.32]:21127 "EHLO
	ylpvm01.prodigy.net") by vger.kernel.org with ESMTP id S261413AbULATCN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 14:02:13 -0500
From: David Brownell <david-b@pacbell.net>
Subject: Fwd: [patch 2.6] EHCI race fix
Date: Wed, 1 Dec 2004 11:00:06 -0800
User-Agent: KMail/1.7.1
To: Linux Kernel list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_3ShrBAzjCoIkx8r"
Message-Id: <200412011100.07072.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_3ShrBAzjCoIkx8r
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline



----------  Forwarded Message  ----------

Subject: [patch 2.6] EHCI race fix
Date: Wednesday 01 December 2004 10:42 am
From: David Brownell <david-b@pacbell.net>
To: linux-usb-devel@lists.sourceforge.net

See the description in the attachment ... the patch should
potentially be of interest if you've been having any issues
with EHCI under load, after the driver successfully starts,
using bulk traffic.  (So: using network or mass storage
adapters, and the like.)  The problem is in 2.4 kernels
too, the same fix should work; but this patch gets a reject
against 2.4.28 sources.

I'm sending this version around for feedback before I submit
it, but I have no reason to think it adds new problems.

- Dave



-------------------------------------------------------

--Boundary-00=_3ShrBAzjCoIkx8r
Content-Type: text/x-diff;
  charset="us-ascii";
  name="ehci-1201.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ehci-1201.patch"

This makes the EHCI driver stop trying to update a live QH ... it's
not like OHCI, that can't be done safely because of a hardware race.
The fix just unlinks the queue before updating its head; only the tail
can safely be updated "live".

The race shows readily enough under load with the right hardware.
The controller silicon might be relatively slow, or maybe it's the
bus that's slow/busy:

	Host			Controller
	---			----------
				reads two TD pointers
	update two TD pointers
	wmb()
	activate QH
				reads rest of QH

Net result is that the HC treats the old TD pointers as valid, and things
start misbehaving.  Busy controllers will misbehave worse; some systems
wouldn't notice more than a slowdown, especially with light USB loads.

This affects behavior in two cases.  The uncommon one is when an endpoint
gets an error and halts.  The more common one happens when the controller
runs off the end of its queue and overlays an inactive "dummy" TD into
the QH ... something the spec says shouldn't happen, but which more
silicon seems to be doing.  (Presumably to reduce DMA chatter.)


--- 1.65/drivers/usb/host/ehci-q.c	2004-11-22 13:43:04 -08:00
+++ edited/drivers/usb/host/ehci-q.c	2004-12-01 08:47:10 -08:00
@@ -83,11 +83,11 @@
 
 /*-------------------------------------------------------------------------*/
 
-/* update halted (but potentially linked) qh */
-
 static inline void
 qh_update (struct ehci_hcd *ehci, struct ehci_qh *qh, struct ehci_qtd *qtd)
 {
+	BUG_ON(qh->qh_state != QH_STATE_IDLE);
+
 	qh->hw_qtd_next = QTD_NEXT (qtd->qtd_dma);
 	qh->hw_alt_next = EHCI_LIST_END;
 
@@ -96,6 +96,24 @@
 	qh->hw_token &= __constant_cpu_to_le32 (QTD_TOGGLE | QTD_STS_PING);
 }
 
+static void
+qh_refresh (struct ehci_hcd *ehci, struct ehci_qh *qh)
+{
+	struct ehci_qtd *qtd;
+
+	if (list_empty (&qh->qtd_list))
+		qtd = qh->dummy;
+	else {
+		qtd = list_entry (qh->qtd_list.next,
+				struct ehci_qtd, qtd_list);
+		/* first qtd may already be partially processed */
+		if (cpu_to_le32 (qtd->qtd_dma) == qh->hw_current)
+			qtd = NULL;
+	}
+	if (qtd)
+		qh_update (ehci, qh, qtd);
+}
+
 /*-------------------------------------------------------------------------*/
 
 static void qtd_copy_status (
@@ -226,6 +244,7 @@
 	spin_lock (&ehci->lock);
 }
 
+static void start_unlink_async (struct ehci_hcd *ehci, struct ehci_qh *qh);
 
 /*
  * Process and free completed qtds for a qh, returning URBs to drivers.
@@ -369,21 +388,20 @@
 	/* restore original state; caller must unlink or relink */
 	qh->qh_state = state;
 
-	/* update qh after fault cleanup */
-	if (unlikely (stopped != 0)
-			/* some EHCI 0.95 impls will overlay dummy qtds */ 
-			|| qh->hw_qtd_next == EHCI_LIST_END) {
-		if (list_empty (&qh->qtd_list))
-			end = qh->dummy;
-		else {
-			end = list_entry (qh->qtd_list.next,
-					struct ehci_qtd, qtd_list);
-			/* first qtd may already be partially processed */
-			if (cpu_to_le32 (end->qtd_dma) == qh->hw_current)
-				end = NULL;
+	/* be sure the hardware's done with the qh before refreshing
+	 * it after fault cleanup, or recovering from silicon wrongly
+	 * overlaying the dummy qtd (which reduces DMA chatter).
+	 */
+	if (stopped != 0 || qh->hw_qtd_next == EHCI_LIST_END) {
+		switch (state) {
+		case QH_STATE_IDLE:
+			qh_refresh(ehci, qh);
+			break;
+		case QH_STATE_LINKED:
+			start_unlink_async (ehci, qh);
+			break;
+		/* otherwise, unlink already started */
 		}
-		if (end)
-			qh_update (ehci, qh, end);
 	}
 
 	return count;
@@ -936,8 +956,6 @@
 
 /* the async qh for the qtds being reclaimed are now unlinked from the HC */
 
-static void start_unlink_async (struct ehci_hcd *ehci, struct ehci_qh *qh);
-
 static void end_unlink_async (struct ehci_hcd *ehci, struct pt_regs *regs)
 {
 	struct ehci_qh		*qh = ehci->reclaim;
@@ -957,6 +975,10 @@
 	qh->reclaim = NULL;
 
 	qh_completions (ehci, qh, regs);
+
+	/* freshen qh after halt, or a common silicon quirk */
+	if ((HALT_BIT & qh->hw_token) || qh->hw_qtd_next == EHCI_LIST_END)
+		qh_refresh (ehci, qh);
 
 	if (!list_empty (&qh->qtd_list)
 			&& HCD_IS_RUNNING (ehci->hcd.state))

--Boundary-00=_3ShrBAzjCoIkx8r--
