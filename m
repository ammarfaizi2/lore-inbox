Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750879AbVH2Kjn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750879AbVH2Kjn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 06:39:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750883AbVH2Kjn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 06:39:43 -0400
Received: from gw.alcove.fr ([81.80.245.157]:29652 "EHLO placid.alcove-fr")
	by vger.kernel.org with ESMTP id S1750866AbVH2Kjn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 06:39:43 -0400
Subject: Re: 2.6.13-rc7-git2 crashes on iBook
From: Stelian Pop <stelian@popies.net>
To: Alex Williamson <alex.williamson@hp.com>
Cc: Andreas Schwab <schwab@suse.de>, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <1125288175.5595.3.camel@localhost.localdomain>
References: <jehdda2tqt.fsf@sykes.suse.de>
	 <1125288175.5595.3.camel@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Date: Mon, 29 Aug 2005 12:39:11 +0200
Message-Id: <1125311951.4662.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le dimanche 28 août 2005 à 22:02 -0600, Alex Williamson a écrit :
> On Sun, 2005-08-28 at 13:20 +0200, Andreas Schwab wrote:
> > The last change to drivers/pci/setup-res.c (Ignore disabled ROM resources
> > at setup) is breaking radeonfb on iBook G3 (with Radeon Mobility M6 LY).
> > It crashes in pci_map_rom when called from radeonfb_map_ROM.  This is
> > probably a dormant bug that was just uncovered by the change.
> 
>    Same thing on Mac Mini.  2.6.13 doesn't boot.  Revert the
> drivers/pci/setup-res.c change from rc7-git2 and it seems ok.

Confirmed on an Apple Powerbook too.

For reference, the (already reverted) patch which needs to be applied is
below.

Signed-off-by: Stelian Pop <stelian@popies.net>

Index: linux-2.6.git/drivers/pci/setup-res.c
===================================================================
--- linux-2.6.git.orig/drivers/pci/setup-res.c	2005-08-29 10:03:00.000000000 +0200
+++ linux-2.6.git/drivers/pci/setup-res.c	2005-08-29 12:23:20.980716336 +0200
@@ -53,9 +53,7 @@
 	if (resno < 6) {
 		reg = PCI_BASE_ADDRESS_0 + 4 * resno;
 	} else if (resno == PCI_ROM_RESOURCE) {
-		if (!(res->flags & IORESOURCE_ROM_ENABLE))
-			return;
-		new |= PCI_ROM_ADDRESS_ENABLE;
+		new |= res->flags & IORESOURCE_ROM_ENABLE;
 		reg = dev->rom_base_reg;
 	} else {
 		/* Hmm, non-standard resource. */

Stelian.
-- 
Stelian Pop <stelian@popies.net>

