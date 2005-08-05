Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262808AbVHEBM4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262808AbVHEBM4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 21:12:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262806AbVHEBKM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 21:10:12 -0400
Received: from mail.kroah.org ([69.55.234.183]:55271 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262803AbVHEBHJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 21:07:09 -0400
Date: Thu, 4 Aug 2005 18:06:41 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, david-b@pacbell.net
Subject: [patch 4/5] USB: ehci: microframe handling fix
Message-ID: <20050805010641.GE19625@kroah.com>
References: <20050805010206.711658000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="usb-ehci-microframe-handlin-fix.patch"
In-Reply-To: <20050805010533.GA19625@kroah.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Brownell <david-b@pacbell.net>

This patch has a one line oops fix, plus related cleanups.

 - The bugfix uses microframe scheduling data given to the hardware to
   test "is this a periodic QH", rather than testing for nonzero period.
   (Prevents an oops by providing the correct answer.)

 - The cleanup going along with the patch should make it clearer what's
   going on whenever those bitfields are accessed.

The bug came about when, around January, two new kinds of EHCI interrupt
scheduling operation were added, involving both the high speed (24 KBytes
per millisec) and low/full speed (1-64 bytes per millisec) microframe
scheduling.  A driver for the Edirol UA-1000 Audio Capture Unit ran into
the oops; it used one of the newly supported high speed modes.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/usb/host/ehci-dbg.c   |    2 +-
 drivers/usb/host/ehci-q.c     |    5 +++--
 drivers/usb/host/ehci-sched.c |   13 +++++++------
 drivers/usb/host/ehci.h       |    5 +++++
 4 files changed, 16 insertions(+), 9 deletions(-)

--- gregkh-2.6.orig/drivers/usb/host/ehci-dbg.c	2005-08-04 17:37:11.000000000 -0700
+++ gregkh-2.6/drivers/usb/host/ehci-dbg.c	2005-08-04 17:40:08.000000000 -0700
@@ -527,7 +527,7 @@
 						p.qh->period,
 						le32_to_cpup (&p.qh->hw_info2)
 							/* uframe masks */
-							& 0xffff,
+							& (QH_CMASK | QH_SMASK),
 						p.qh);
 				size -= temp;
 				next += temp;
--- gregkh-2.6.orig/drivers/usb/host/ehci.h	2005-08-04 17:37:11.000000000 -0700
+++ gregkh-2.6/drivers/usb/host/ehci.h	2005-08-04 17:40:08.000000000 -0700
@@ -385,6 +385,11 @@
 	__le32			hw_info1;        /* see EHCI 3.6.2 */
 #define	QH_HEAD		0x00008000
 	__le32			hw_info2;        /* see EHCI 3.6.2 */
+#define	QH_SMASK	0x000000ff
+#define	QH_CMASK	0x0000ff00
+#define	QH_HUBADDR	0x007f0000
+#define	QH_HUBPORT	0x3f800000
+#define	QH_MULT		0xc0000000
 	__le32			hw_current;	 /* qtd list - see EHCI 3.6.4 */
 	
 	/* qtd overlay (hardware parts of a struct ehci_qtd) */
--- gregkh-2.6.orig/drivers/usb/host/ehci-q.c	2005-08-04 17:37:11.000000000 -0700
+++ gregkh-2.6/drivers/usb/host/ehci-q.c	2005-08-04 17:40:08.000000000 -0700
@@ -222,7 +222,7 @@
 		struct ehci_qh	*qh = (struct ehci_qh *) urb->hcpriv;
 
 		/* S-mask in a QH means it's an interrupt urb */
-		if ((qh->hw_info2 & __constant_cpu_to_le32 (0x00ff)) != 0) {
+		if ((qh->hw_info2 & __constant_cpu_to_le32 (QH_SMASK)) != 0) {
 
 			/* ... update hc-wide periodic stats (for usbfs) */
 			ehci_to_hcd(ehci)->self.bandwidth_int_reqs--;
@@ -428,7 +428,8 @@
 			/* should be rare for periodic transfers,
 			 * except maybe high bandwidth ...
 			 */
-			if (qh->period) {
+			if ((__constant_cpu_to_le32 (QH_SMASK)
+					& qh->hw_info2) != 0) {
 				intr_deschedule (ehci, qh);
 				(void) qh_schedule (ehci, qh);
 			} else
--- gregkh-2.6.orig/drivers/usb/host/ehci-sched.c	2005-08-04 17:37:11.000000000 -0700
+++ gregkh-2.6/drivers/usb/host/ehci-sched.c	2005-08-04 17:40:08.000000000 -0700
@@ -301,7 +301,7 @@
 
 	dev_dbg (&qh->dev->dev,
 		"link qh%d-%04x/%p start %d [%d/%d us]\n",
-		period, le32_to_cpup (&qh->hw_info2) & 0xffff,
+		period, le32_to_cpup (&qh->hw_info2) & (QH_CMASK | QH_SMASK),
 		qh, qh->start, qh->usecs, qh->c_usecs);
 
 	/* high bandwidth, or otherwise every microframe */
@@ -385,7 +385,8 @@
 
 	dev_dbg (&qh->dev->dev,
 		"unlink qh%d-%04x/%p start %d [%d/%d us]\n",
-		qh->period, le32_to_cpup (&qh->hw_info2) & 0xffff,
+		qh->period,
+		le32_to_cpup (&qh->hw_info2) & (QH_CMASK | QH_SMASK),
 		qh, qh->start, qh->usecs, qh->c_usecs);
 
 	/* qh->qh_next still "live" to HC */
@@ -411,7 +412,7 @@
 	 * active high speed queues may need bigger delays...
 	 */
 	if (list_empty (&qh->qtd_list)
-			|| (__constant_cpu_to_le32 (0x0ff << 8)
+			|| (__constant_cpu_to_le32 (QH_CMASK)
 					& qh->hw_info2) != 0)
 		wait = 2;
 	else
@@ -533,7 +534,7 @@
 
 	/* reuse the previous schedule slots, if we can */
 	if (frame < qh->period) {
-		uframe = ffs (le32_to_cpup (&qh->hw_info2) & 0x00ff);
+		uframe = ffs (le32_to_cpup (&qh->hw_info2) & QH_SMASK);
 		status = check_intr_schedule (ehci, frame, --uframe,
 				qh, &c_mask);
 	} else {
@@ -569,10 +570,10 @@
 		qh->start = frame;
 
 		/* reset S-frame and (maybe) C-frame masks */
-		qh->hw_info2 &= __constant_cpu_to_le32 (~0xffff);
+		qh->hw_info2 &= __constant_cpu_to_le32(~(QH_CMASK | QH_SMASK));
 		qh->hw_info2 |= qh->period
 			? cpu_to_le32 (1 << uframe)
-			: __constant_cpu_to_le32 (0xff);
+			: __constant_cpu_to_le32 (QH_SMASK);
 		qh->hw_info2 |= c_mask;
 	} else
 		ehci_dbg (ehci, "reused qh %p schedule\n", qh);

--
