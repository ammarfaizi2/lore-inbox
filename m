Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262407AbVCBTsZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262407AbVCBTsZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 14:48:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262447AbVCBTro
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 14:47:44 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:46308 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262407AbVCBTqr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 14:46:47 -0500
Date: Wed, 2 Mar 2005 13:46:40 -0600
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: linux-pci@atrey.karlin.mff.cuni.cz, Linus Torvalds <torvalds@osdl.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       "Luck, Tony" <tony.luck@intel.com>
Subject: Re: [PATCH/RFC] I/O-check interface for driver's error handling
Message-ID: <20050302194640.GK1220@austin.ibm.com>
References: <422428EC.3090905@jp.fujitsu.com> <Pine.LNX.4.58.0503010844470.25732@ppc970.osdl.org> <20050302182205.GI1220@austin.ibm.com> <200503021041.07090.jbarnes@engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503021041.07090.jbarnes@engr.sgi.com>
User-Agent: Mutt/1.5.6+20040818i
From: Linas Vepstas <linas@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2005 at 10:41:06AM -0800, Jesse Barnes was heard to remark:
> On Wednesday, March 2, 2005 10:22 am, Linas Vepstas wrote:
> > On Tue, Mar 01, 2005 at 08:49:45AM -0800, Linus Torvalds was heard to 
> remark:
> > > The new API is what _allows_ a driver to care. It doesn't handle DMA, but
> > > I think that's because nobody knows how to handle it (ie it's probably
> > > hw-dependent and all existign implementations would thus be
> > > driver-specific anyway).
> >
> > ?
> > We could add a call
> >
> > int pci_was_there_an_error_during_dma (struct pci_dev);
> >
> > right?  And it could return true/false, right?  I can certainly
> > do that today with ppc64.  I just can't tell you which dma triggered
> > the problem.
> 
> One issue with that is how to notify drivers that they need to make this call.  
> In may cases, DMA completion will be signalled by an interrupt, but if the 
> DMA failed, that interrupt may never happen, which means the call to 
> pci_unmap or the above function from the interrupt handler may never occur.

Hmm. Well, I notice that e100/e1000 has a heartbeat built into it, so
that if the card doesn't respond, it resets the card.  So this would 
be a natural place for them.  And I suspect that *all* scsi drivers
have timeouts; they initiate a cascade of reset sequences if they
don't get data back after X seconds.

I see nothing wrong with adding a requirement, something that says
"If a device driver wants to be pci-error aware, then yea-verily it 
must use a dma-timeout timer (say 15 seconds) and check for 
pci errors in the dma-timeout handler".

> Some I/O errors are by nature asynchronous and unpredictable, so I think we 
> need a separate thread and callback interface to deal with errors where the 
> beginning of the transaction and the end of the transaction occur in 
> different contexts, in addition to the PIO transaction interface already 
> proposed.

I don't know what the pci-express implementation is like, but the 
ppc64 implementation is *not* transactional, so I don't have that issue.

If some pci chipsets only report dma errors on a transactional basis,
then we need to modify pci_map_sg() and pci_map_single() and etc. to
take a cookie as well.  It would be up to the device driver to alloc
and retire cookies as the dma's complete (and make sure it can find
its cookies in any context).  Is this or something like this that 
is needed? 

--linas

