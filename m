Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262162AbVBAXI1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262162AbVBAXI1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 18:08:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262178AbVBAXH5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 18:07:57 -0500
Received: from gate.crashing.org ([63.228.1.57]:18358 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262171AbVBAXHf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 18:07:35 -0500
Subject: Re: [PATCH 1/1] pci: Block config access during BIST (resend)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Greg KH <greg@kroah.com>
Cc: Matthew Wilcox <matthew@wil.cx>, Brian King <brking@us.ibm.com>,
       Andi Kleen <ak@muc.de>, Paul Mackerras <paulus@samba.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-pci@atrey.karlin.mff.cuni.cz
In-Reply-To: <20050201185859.GA7174@kroah.com>
References: <20050113202354.GA67143@muc.de> <41ED27CD.7010207@us.ibm.com>
	 <1106161249.3341.9.camel@localhost.localdomain>
	 <41F7C6A1.9070102@us.ibm.com> <1106777405.5235.78.camel@gaston>
	 <1106841228.14787.23.camel@localhost.localdomain>
	 <41FA4DC2.4010305@us.ibm.com> <20050201072746.GA21236@kroah.com>
	 <41FF9C78.2040100@us.ibm.com>
	 <20050201154400.GC10088@parcelfarce.linux.theplanet.co.uk>
	 <20050201185859.GA7174@kroah.com>
Content-Type: text/plain
Date: Wed, 02 Feb 2005 10:07:08 +1100
Message-Id: <1107299228.5624.22.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-02-01 at 10:58 -0800, Greg KH wrote:

> > If we've done a write to config space while the adapter was blocked,
> > shouldn't we replay those accesses at this point?
> 
> This has been discussed a lot already.  I think we might as well let the
> thing fail in random and odd ways, as it's some pretty broken hardware
> anyway that wants this functionality :)

I don't agree that it's broken hardware, especially in the case where we
use these for power managed devices (on pmac, or eventually embedded,
where we can have PM be as drastic as completely removing power/clock
from a device or that sort of thing).

But as I wrote earlier, I consider that in those cases, userland has no
business writing to config space. If it does, then it has to be aware of
the device beeing potentially offlined or that sort of thing and have
proper interface to the kernel driver etc...

The reads coming from the cache, on the other hand, have a more
legitimate use which are to let

 - distro HW probing tool to actually see devices even when they
are power managed or BIST by their kernel driver

 - crap like XFree86 to have a proper idea of what address ranges
are actually used on the bus, including devices that are power managed
or BIST (*).

Ben.


(*) An unrelated note: It's not always legal to allocate thigns in PCI
space or move devices around anyway. It's definitely not on logically
partitionned PPC machines where HV won't let a partition access other IO
ranges than the ones where the "allowed" devices for this partition were
intially put by the firmware... Again, X should really be changed to
just stop doing anything but "probing" on the bus at least with Linux.
The only problem is the VGA enable story, but as we discussed earlier,
that too should be dealt with in the kernel. I think we could integrate
that cleanly in sysfs for PCI devices in the generic code btw.
 
Ben.


