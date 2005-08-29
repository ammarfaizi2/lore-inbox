Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751272AbVH2SR4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751272AbVH2SR4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 14:17:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbVH2SR4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 14:17:56 -0400
Received: from aun.it.uu.se ([130.238.12.36]:22972 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S1751269AbVH2SRz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 14:17:55 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17171.20778.949307.580714@alkaid.it.uu.se>
Date: Mon, 29 Aug 2005 20:17:14 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Sean Neakums <sneakums@zork.net>
Cc: Andreas Schwab <schwab@suse.de>, linuxppc-dev@ozlabs.org,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.13 PowerBook boot hang (was Re: 2.6.13-rc7-git2 crashes on iBook)
In-Reply-To: <7wr7cdt3jk.fsf@frotz.zork.net>
References: <jehdda2tqt.fsf@sykes.suse.de>
	<7wr7cdt3jk.fsf@frotz.zork.net>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Neakums writes:
 > Andreas Schwab <schwab@suse.de> writes:
 > 
 > > The last change to drivers/pci/setup-res.c (Ignore disabled ROM resources
 > > at setup) is breaking radeonfb on iBook G3 (with Radeon Mobility M6 LY).
 > > It crashes in pci_map_rom when called from radeonfb_map_ROM.  This is
 > > probably a dormant bug that was just uncovered by the change.
 > 
 > 2.6.13 hangs on boot on my PowerBook 5.4, reverting the disabled ROM
 > patch (appended for confirmation) fixes it.  2.6.13-rc7 was fine.

Same here, on an Apple eMac with Radeon graphics. 2.6.13-rc7 worked fine,
2.6.13 vanilla hangs early in the boot when radeonfb is about to take over
from OF. Reverting the patch below eliminates the hang.

/Mikael

 > diff-tree 755528c860b05fcecda1c88a2bdaffcb50760a7f (from 26aad69e3dd854abe9028ca873fb40b410a39dd7)
 > Author: Linus Torvalds <torvalds@g5.osdl.org>
 > Date:   Fri Aug 26 10:49:22 2005 -0700
 > 
 >     Ignore disabled ROM resources at setup
 >     
 >     Writing even a disabled value seems to mess up some matrox graphics
 >     cards.  It may be a card-related issue, but we may also be writing
 >     reserved low bits in the result.
 >     
 >     This was a fall-out of switching x86 over to the generic PCI resource
 >     allocation code, and needs more debugging.  In particular, the old x86
 >     code defaulted to not doing any resource allocations at all for ROM
 >     resources.
 >     
 >     In the meantime, this has been reported to make X happier by Helge
 >     Hafting <helgehaf@aitel.hist.no>.
 >     
 >     Signed-off-by: Linus Torvalds <torvalds@osdl.org>
 > 
 > diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
 > --- a/drivers/pci/setup-res.c
 > +++ b/drivers/pci/setup-res.c
 > @@ -53,7 +53,9 @@ pci_update_resource(struct pci_dev *dev,
 >  	if (resno < 6) {
 >  		reg = PCI_BASE_ADDRESS_0 + 4 * resno;
 >  	} else if (resno == PCI_ROM_RESOURCE) {
 > -		new |= res->flags & IORESOURCE_ROM_ENABLE;
 > +		if (!(res->flags & IORESOURCE_ROM_ENABLE))
 > +			return;
 > +		new |= PCI_ROM_ADDRESS_ENABLE;
 >  		reg = dev->rom_base_reg;
 >  	} else {
 >  		/* Hmm, non-standard resource. */
 > -
 > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
 > the body of a message to majordomo@vger.kernel.org
 > More majordomo info at  http://vger.kernel.org/majordomo-info.html
 > Please read the FAQ at  http://www.tux.org/lkml/
 > 
