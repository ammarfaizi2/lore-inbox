Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964947AbVKACo6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964947AbVKACo6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 21:44:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964948AbVKACo6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 21:44:58 -0500
Received: from gate.crashing.org ([63.228.1.57]:24473 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S964947AbVKACo6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 21:44:58 -0500
Subject: Re: [linux-usb-devel] Re: Commit "[PATCH] USB: Always do
	usb-handoff" breaks my powerbook
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Brownell <david-b@pacbell.net>
Cc: linux-usb-devel@lists.sourceforge.net, Paul Mackerras <paulus@samba.org>,
       Alan Stern <stern@rowland.harvard.edu>, linux-kernel@vger.kernel.org
In-Reply-To: <200510311741.56638.david-b@pacbell.net>
References: <17253.43605.659634.454466@cargo.ozlabs.ibm.com>
	 <1130804214.29054.390.camel@gaston>
	 <200510311741.56638.david-b@pacbell.net>
Content-Type: text/plain
Date: Tue, 01 Nov 2005 13:41:43 +1100
Message-Id: <1130812903.29054.408.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> No PCI quirk code has ever called pci_enable_device() AFAICT.

Most PCI quirks only do config space accesses

> Of course the _need_ to do such a thing might be another PPC-specific
> (or OpenFirmware-specific?) PCI thing ... we've hit other cases where
> PPC breaks things that work on other PCI systems (and vice versa).

"ppc" doens't do anything fancy that other archs don't do too, please
stop with your "ppc specific" thing all over the place.

It is illegal, whatever the platform is, to tap a PCI device MMIO like
that without calling pci_enable_device(), requesting resources etc... or
at the very least, testing if MMIO decoding is enabled on the chip.
Period. It has nothing to do with PPC and all to do with correctness.

> If quirk code can't rely on BARs, then the PCI system needs some
> basic overhauls ... yes?  I mean, how could quirk code ever work
> if it can't access the relevant chip registers??

Most quirk only ever use config space. BARs are _not_ guaranteed to be
set at quirk time. In fact, those devices are left disabled on purpose,
thus you should at least test if MMIO access is enabled, and if not,
avoid touching the device at all.

> > I'm not sure it's legal to do pci_enable_device() from within a pci
> > quirk anyway. I really wonder what that code is doing in the quirks, I
> > don't think it's the right place, but I may be wrong.
> 
> Erm, what "code is doing" what, that you mean ??

What _That_ code is doing in the quirks... shouldn't it be in the
{U,O,E}HCI drivers instead ?

> > What is the logic supposed to be there ?
> 
> Which logic?  The fundamental thing those USB handoff functions do
> is make sure that BIOS code lets go of the host controllers.  The
> main reason it'd be using a controller is because of USB keyboards,
> mice, or maybe boot disks.  Secondarily, that code needs to make
> sure the controller is really quiesced before Linux starts using it.

So you rant about "ppc specific" whatever while the entire point of this
code is to workaround x86 specific BIOS junk ...

Ben.


