Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262667AbVAEXh2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262667AbVAEXh2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 18:37:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262664AbVAEXh2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 18:37:28 -0500
Received: from ylpvm01-ext.prodigy.net ([207.115.57.32]:36770 "EHLO
	ylpvm01.prodigy.net") by vger.kernel.org with ESMTP id S262668AbVAEXfk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 18:35:40 -0500
From: David Brownell <david-b@pacbell.net>
To: Greg KH <greg@kroah.com>
Subject: [patch 2.6.10] ehci "hc died" on startup (chip bug workaround)
Date: Wed, 5 Jan 2005 14:35:42 -0800
User-Agent: KMail/1.7.1
Cc: linux-usb-devel@lists.sourceforge.net,
       Linux Kernel list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_+uG3BLx9Pdb0X50"
Message-Id: <200501051435.42666.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_+uG3BLx9Pdb0X50
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

We seem to have tracked some annoying board-coupled EHCI startup
problems to a chip bug, with a simple workaround.  Please merge.

- Dave

--Boundary-00=_+uG3BLx9Pdb0X50
Content-Type: text/x-diff;
  charset="us-ascii";
  name="e0105b.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="e0105b.patch"

This fixes OSDL bugid #3056 for at least some users, where the EHCI
driver gets a "fatal error" IRQ on startup ... only on certain boards,
starting with the 2.6.6 or 2.6.7 kernels.  These IRQs normally indicate
that an invalid DMA address got passed to the controller, or something
equally nasty and unrecoverable.

But it turns out that some of these controllers (at least ALI and Intel)
are lying.  They're issuing these IRQs without stopping, contrary to the
EHCI spec ... so these IRQs can be recovered from.  Thanks to Christian
Iversen for noticing that his ALI controller would continue operating,
which was the first real break in this annoying case.

This patch tests for these bogus IRQs, and ignores them ... working around
what's clearly a chip bug.  It's not clear why we started triggering that
bug, but at least EHCI is now usable on boards exhibiting this problem.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>


--- 1.112/drivers/usb/host/ehci-hcd.c	2004-12-24 18:03:39 -08:00
+++ edited/drivers/usb/host/ehci-hcd.c	2005-01-04 11:53:29 -08:00
@@ -903,14 +903,20 @@
 
 	/* PCI errors [4.15.2.4] */
 	if (unlikely ((status & STS_FATAL) != 0)) {
-		ehci_err (ehci, "fatal error\n");
+		/* bogus "fatal" IRQs appear on some chips... why?  */
+		status = readl (&ehci->regs->status);
+		dbg_cmd (ehci, "fatal", readl (&ehci->regs->command));
+		dbg_status (ehci, "fatal", status);
+		if (status & STS_HALT) {
+			ehci_err (ehci, "fatal error\n");
 dead:
-		ehci_reset (ehci);
-		writel (0, &ehci->regs->configured_flag);
-		/* generic layer kills/unlinks all urbs, then
-		 * uses ehci_stop to clean up the rest
-		 */
-		bh = 1;
+			ehci_reset (ehci);
+			writel (0, &ehci->regs->configured_flag);
+			/* generic layer kills/unlinks all urbs, then
+			 * uses ehci_stop to clean up the rest
+			 */
+			bh = 1;
+		}
 	}
 
 	if (bh)

--Boundary-00=_+uG3BLx9Pdb0X50--
