Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262091AbVCAW0p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262091AbVCAW0p (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 17:26:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262096AbVCAW0o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 17:26:44 -0500
Received: from gate.crashing.org ([63.228.1.57]:54978 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262091AbVCAW0L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 17:26:11 -0500
Subject: Re: [PATCH/RFC] I/O-check interface for driver's error handling
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: linux-pci@atrey.karlin.mff.cuni.cz, Matthew Wilcox <matthew@wil.cx>,
       Linus Torvalds <torvalds@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
       Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org, Linas Vepstas <linas@austin.ibm.com>,
       "Luck, Tony" <tony.luck@intel.com>
In-Reply-To: <200503010910.29460.jbarnes@engr.sgi.com>
References: <422428EC.3090905@jp.fujitsu.com>
	 <Pine.LNX.4.58.0503010844470.25732@ppc970.osdl.org>
	 <20050301165904.GN28741@parcelfarce.linux.theplanet.co.uk>
	 <200503010910.29460.jbarnes@engr.sgi.com>
Content-Type: text/plain
Date: Wed, 02 Mar 2005 09:23:47 +1100
Message-Id: <1109715827.5679.44.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-03-01 at 09:10 -0800, Jesse Barnes wrote:
> On Tuesday, March 1, 2005 8:59 am, Matthew Wilcox wrote:
> > The MCA handler has to go and figure out what the hell just happened
> > (was it a DIMM error, PCI bus error, etc).  OK, fine, it finds that it
> > was an error on PCI bus 73.  At this point, I think the architecture
> > error handler needs to call into the PCI subsystem and say "Hey, there
> > was an error, you deal with it".
> >
> > If we're lucky, we get all the information that allows us to figure
> > out which device it was (eg a destination address that matches a BAR),
> > then we could have a ->error method in the pci_driver that handles it.
> > If there's no ->error method, at leat call ->remove so one device only
> > takes itself down.
> >
> > Does this make sense?
> 
> This was my thought too last time we had this discussion.  A completely 
> asynchronous call is probably needed in addition to Hidetoshi's proposed API, 
> since as you point out, the driver may not be running when an error occurs 
> (e.g. in the case of a DMA error or more general bus problem).  The async 
> ->error callback could do a total reset of the card, or something along those 
> lines as Jeff suggests, while the inline ioerr_clear/ioerr_check API could 
> potentially deal with errors as they happen (probably in the case of PIO 
> related errors), when the additional context may allow us to be smarter about 
> recovery.

What I think we need is an async call that takes:

 - an opaque blob with the error informations and accessors (see my
reply to Jeff)

 - a slot state (slot isolated, slot has been reset, slot has IOs /DMA
enabled/disabled, must probably be a bitmask)

 - a bit mask of possible actions the driver can request (nothing, reset
slot, re-enable IOs, ...)

I'm afraid tho that the combinatory explosion will make it difficult to
drivers to deal with the right thing. Maybe we can simplify the mecanism
to archs that can just 1) re-enable IOs, 2) reset slot.

Note that the reason to re-enable IOs before trying to reset the slot is
that some devices will allow you to extract diagnostic informations, and
it's always useful to gather as much informations as possible upon an
error of this type.

Ben.


