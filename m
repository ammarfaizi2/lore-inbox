Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750709AbWBWCiG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750709AbWBWCiG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 21:38:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750712AbWBWCiG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 21:38:06 -0500
Received: from gate.crashing.org ([63.228.1.57]:38111 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1750709AbWBWCiE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 21:38:04 -0500
Subject: Re: [PATCH 3/6] PCI legacy I/O port free driver (take2) - Add
	device_flags into pci_device_id
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Greg KH <greg@kroah.com>
Cc: Andi Kleen <ak@suse.de>, Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       akpm@osdl.org, rmk+lkml@arm.linux.org.uk
In-Reply-To: <20060221211004.GA12784@kroah.com>
References: <43FAB283.8090206@jp.fujitsu.com>
	 <43FAB375.2020007@jp.fujitsu.com> <20060221205640.GA12423@kroah.com>
	 <200602212159.52106.ak@suse.de>  <20060221211004.GA12784@kroah.com>
Content-Type: text/plain
Date: Thu, 23 Feb 2006 13:37:38 +1100
Message-Id: <1140662259.8264.22.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.91 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-02-21 at 13:10 -0800, Greg KH wrote:
> On Tue, Feb 21, 2006 at 09:59:51PM +0100, Andi Kleen wrote:
> > On Tuesday 21 February 2006 21:56, Greg KH wrote:
> > 
> > > I don't think you can add fields here, after the driver_data field.  It
> > > might mess up userspace tools a lot, as you are changing a userspace
> > > api.
> > 
> > User space should look at the ASCII files (modules.*), not the binary
> > As long as the code to generate these files still works it should be ok.
> 
> Does it?  Shouldn't the tools export this information too, if it really
> should belong in the pci_id structure?
> 
> So, is _every_ pci driver going to have to be modified to support this
> new field if they are supposed to work on this kind of hardware?  If so,
> that doesn't sound like a good idea.  Any way we can just set the bit in
> the pci arch specific code for the devices instead?

I think the right approach is to not change driver_data but instead to
add a new version of pci_enable_device() (I call it
pci_enable_resources() but you are welcome to find something more fancy)
to enable a selected set of resources with the old pci_enable_device()
just calling the new one with a full mask set.

I don't like the driver_data approach. I don't like the static table
approach in fact. Drivers may "know" wether they need to enable/disable
given resources based on other things like revision, etc... Some drivers
may want to enable only one BAR, access some registers to properly
figure out what rev of a device they are talking to, then selectively
enable other BARs and/or MSIs etc...

I think the driver should be in control... flags in a static table
aren't flexible enough.

Ben.


