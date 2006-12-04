Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758306AbWLDBzm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758306AbWLDBzm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 20:55:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758682AbWLDBzm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 20:55:42 -0500
Received: from havoc.gtf.org ([69.61.125.42]:38019 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1758306AbWLDBzl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 20:55:41 -0500
Date: Sun, 3 Dec 2006 20:53:58 -0500
From: Jeff Garzik <jeff@garzik.org>
To: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] USB: fix ohci.h over-use warnings
Message-ID: <20061204015358.GA7723@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


When u132-hcd is built, it includes local header ohci.h, which appears
to have been intended only for use by ohci-hcd.

This throws warnings about functions which are defined and not used.
The warnings thrown are because three small functions are implemented in
the header, but not declared 'inline', a rather strange affair.

Since these functions are small, let's go ahead and define them as
'inline', just like the inline functions surrounding them.  This makes
things more consistent, and kills the warnings.

Signed-off-by: Jeff Garzik <jeff@garzik.org>

diff --git a/drivers/usb/host/ohci.h b/drivers/usb/host/ohci.h
index a2f42a2..fd93e7e 100644
--- a/drivers/usb/host/ohci.h
+++ b/drivers/usb/host/ohci.h
@@ -602,7 +602,7 @@ #define	FSMP(fi) 		(0x7fff & ((6 * ((fi)
 #define	FIT			(1 << 31)
 #define LSTHRESH		0x628		/* lowspeed bit threshold */
 
-static void periodic_reinit (struct ohci_hcd *ohci)
+static inline void periodic_reinit (struct ohci_hcd *ohci)
 {
 	u32	fi = ohci->fminterval & 0x03fff;
 	u32	fit = ohci_readl(ohci, &ohci->regs->fminterval) & FIT;
@@ -626,11 +626,11 @@ #define read_roothub(hc, register, mask)
 			temp = ohci_readl (hc, &hc->regs->roothub.register); \
 	temp; })
 
-static u32 roothub_a (struct ohci_hcd *hc)
+static inline u32 roothub_a (struct ohci_hcd *hc)
 	{ return read_roothub (hc, a, 0xfc0fe000); }
 static inline u32 roothub_b (struct ohci_hcd *hc)
 	{ return ohci_readl (hc, &hc->regs->roothub.b); }
 static inline u32 roothub_status (struct ohci_hcd *hc)
 	{ return ohci_readl (hc, &hc->regs->roothub.status); }
-static u32 roothub_portstatus (struct ohci_hcd *hc, int i)
+static inline u32 roothub_portstatus (struct ohci_hcd *hc, int i)
 	{ return read_roothub (hc, portstatus [i], 0xffe0fce0); }

