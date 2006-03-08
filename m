Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932154AbWCHQk2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932154AbWCHQk2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 11:40:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932265AbWCHQk2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 11:40:28 -0500
Received: from teetot.devrandom.net ([66.35.250.243]:13189 "EHLO
	teetot.devrandom.net") by vger.kernel.org with ESMTP
	id S932154AbWCHQk1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 11:40:27 -0500
Date: Wed, 8 Mar 2006 08:40:42 -0800
From: thockin@hockin.org
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Greg KH <greg@kroah.com>, Tejun Heo <htejun@gmail.com>,
       Jeff Garzik <jeff@garzik.org>, Kumar Gala <galak@kernel.crashing.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: proper way to assign fixed PCI resources to a "hotplug" device
Message-ID: <20060308164041.GA31828@hockin.org>
References: <Pine.LNX.4.44.0603031638050.30957-100000@gate.crashing.org> <4408CEC8.7040507@garzik.org> <20060308020028.GB26028@kroah.com> <440E4203.7040303@gmail.com> <20060308052723.GD29867@kroah.com> <20060308143952.B4851@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060308143952.B4851@jurassic.park.msu.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 08, 2006 at 02:39:52PM +0300, Ivan Kokshaysky wrote:
> On Tue, Mar 07, 2006 at 09:27:23PM -0800, Greg KH wrote:
> > On Wed, Mar 08, 2006 at 11:31:31AM +0900, Tejun Heo wrote:
> > > So, the problem is that the chip actually disables the PCI BAR if 
> > > certain switches aren't turned on and thus BIOSes are likely not to 
> > > reserve mmio address for the BAR. We can turn on proper switches during 
> > > driver initialization but we don't know how to wiggle the BAR into mmio 
> > > address space.
> > 
> > Thanks for the explaination, that makes more sense.  Unfortunatly I do
> > not know how to do this right now :(
> > 
> > Anyone with any ideas?
> 
> We have 'pci_fixup_early' stuff exactly for that sort of hardware.
> IOW, just add a quirk routine that turns on desired mode of the
> device and use DECLARE_PCI_FIXUP_EARLY() for it.
> The new BAR will be discovered an assigned automatically then.

Assigned from what pool?  BIOS most likely sizes the hole to be a pretty
tight fit for all the resources it knows about.  If there is suddenly a
new resource, you're in trouble.

The problem is that we don't know explicitly where or how big the hole is,
how it is allocated (prefetch or non).  Then, even if we *did* know, we
don't know that there's enough space for an arbitrary device to show up
later.

In BIOSes I control we enable the BARs and allocate regions for them and
then turn them off if need be.

There really isn't a good generic answer to this that will work with
existing BIOSes.  My first instinct is to call this a BIOS bug.

We could teach linux about chipsets and let Linux re-do the whole
PCI-allocation process.   But that's not an easy task, and is probably a
contentious idea.

Tim
