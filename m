Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261370AbVAGSKd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261370AbVAGSKd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 13:10:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261365AbVAGSKd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 13:10:33 -0500
Received: from ylpvm01-ext.prodigy.net ([207.115.57.32]:27873 "EHLO
	ylpvm01.prodigy.net") by vger.kernel.org with ESMTP id S261381AbVAGSFv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 13:05:51 -0500
From: David Brownell <david-b@pacbell.net>
To: Greg KH <greg@kroah.com>
Subject: Re: [patch 2.6.10] ehci "hc died" on startup (chip bug workaround)
Date: Fri, 7 Jan 2005 10:05:43 -0800
User-Agent: KMail/1.7.1
Cc: linux-usb-devel@lists.sourceforge.net,
       Linux Kernel list <linux-kernel@vger.kernel.org>
References: <200501051435.42666.david-b@pacbell.net> <20050107174328.GB28878@kroah.com>
In-Reply-To: <20050107174328.GB28878@kroah.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_39s3BM2enNUrK8V"
Message-Id: <200501071005.43520.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_39s3BM2enNUrK8V
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Friday 07 January 2005 9:43 am, Greg KH wrote:
> On Wed, Jan 05, 2005 at 02:35:42PM -0800, David Brownell wrote:
> > We seem to have tracked some annoying board-coupled EHCI startup
> > problems to a chip bug, with a simple workaround.  Please merge.
> 
> Hm, I get a reject from this:
> ...
> 
> What kernel tree is it against?

Probably my gadget-2.6 tree; here's one that applies against
current 2.5 BK or your USB integration tree.  Sorry!

- Dave

--Boundary-00=_39s3BM2enNUrK8V
Content-Type: text/x-diff;
  charset="us-ascii";
  name="e0107.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="e0107.patch"

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


--- xu26/drivers/usb/host/ehci-hcd.c	2004-12-20 15:07:23.000000000 -0800
+++ gadget-2.6/drivers/usb/host/ehci-hcd.c	2005-01-04 12:01:46.000000000 -0800
@@ -883,13 +903,20 @@
 
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

--Boundary-00=_39s3BM2enNUrK8V--
