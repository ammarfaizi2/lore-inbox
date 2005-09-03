Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750858AbVICAES@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750858AbVICAES (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 20:04:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751225AbVICAES
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 20:04:18 -0400
Received: from colo.lackof.org ([198.49.126.79]:50400 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S1750858AbVICAER (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 20:04:17 -0400
Date: Fri, 2 Sep 2005 18:08:54 -0600
From: Grant Grundler <grundler@parisc-linux.org>
To: Paul Mackerras <paulus@samba.org>
Cc: Grant Grundler <grundler@parisc-linux.org>, Brian King <brking@us.ibm.com>,
       Andrew Morton <akpm@osdl.org>, greg@kroah.com, matthew@wil.cx,
       benh@kernel.crashing.org, ak@muc.de, linux-kernel@vger.kernel.org,
       alan@lxorguk.ukuu.org.uk, linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH 1/2] pci: Block config access during BIST (resend)
Message-ID: <20050903000854.GC8463@colo.lackof.org>
References: <41FFBDC9.2010206@us.ibm.com> <20050201174758.GE10088@parcelfarce.linux.theplanet.co.uk> <4200F2B2.3080306@us.ibm.com> <20050208200816.GA25292@kroah.com> <42B83B8D.9030901@us.ibm.com> <430B3CB4.1050105@us.ibm.com> <20050901160356.2a584975.akpm@osdl.org> <4318E6B3.7010901@us.ibm.com> <20050902224314.GB8463@colo.lackof.org> <17176.56354.363726.363290@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17176.56354.363726.363290@cargo.ozlabs.ibm.com>
X-Home-Page: http://www.parisc-linux.org/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 03, 2005 at 09:11:30AM +1000, Paul Mackerras wrote:
> Think about it.  Taking the lock ensures that we don't do the
> assignment (dev->block_ucfg_access = 1) while any other cpu has the
> pci_lock.  In other words, the reason for taking the lock is so that
> we wait until nobody else is doing an access, not to make others wait.

The block_ucfg_access field is only used when making the choice to
use saved state or call the PCI bus cfg accessor.
I don't what problem waiting solves here since any CPU already
accessing real cfg space will finish what they are doing anyway.
ie they already made the choice to access real cfg space.
We just need to make sure successive accesses to cfg space
for this device only access the saved state. For that, a memory barrier
around all uses of block_ucfg_access should be sufficient.
Or do you think I'm still drinking the wrong color cool-aid?

> > If you had:
> > 	spin_lock_irqsave(&pci_lock, flags);
> > 	pci_save_state(dev);
> > 	dev->block_ucfg_access = 1;
> > 	spin_unlock_irqrestore(&pci_lock, flags);
> > 
> > Then I could buy your arguement since the flag now implies
> > we need to atomically save state and set the flag.
> 
> That's probably a good thing to do to.

One needs to verify pci_lock isn't acquired in pci_save_state()
(or some other obvious dead lock).

It would make sense to block pci cfg *writes* to that device
while we save the state.

grant
