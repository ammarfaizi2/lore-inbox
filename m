Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261971AbVAHHlQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261971AbVAHHlQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 02:41:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261859AbVAHHhj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 02:37:39 -0500
Received: from mail.kroah.org ([69.55.234.183]:43909 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261860AbVAHFsQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 00:48:16 -0500
Subject: Re: [PATCH] USB and Driver Core patches for 2.6.10
In-Reply-To: <11051632582144@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 7 Jan 2005 21:47:38 -0800
Message-Id: <1105163258176@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1938.439.56, 2005/01/07 10:29:46-08:00, david-b@pacbell.net

[PATCH] USB: ehci "hc died" on startup (chip bug workaround)

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
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/usb/host/ehci-hcd.c |   19 +++++++++++++------
 1 files changed, 13 insertions(+), 6 deletions(-)


diff -Nru a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
--- a/drivers/usb/host/ehci-hcd.c	2005-01-07 15:34:45 -08:00
+++ b/drivers/usb/host/ehci-hcd.c	2005-01-07 15:34:45 -08:00
@@ -883,13 +883,20 @@
 
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

