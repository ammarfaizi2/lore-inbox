Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130552AbRCIQy7>; Fri, 9 Mar 2001 11:54:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130565AbRCIQyt>; Fri, 9 Mar 2001 11:54:49 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:13317 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S130552AbRCIQyh>;
	Fri, 9 Mar 2001 11:54:37 -0500
Date: Fri, 9 Mar 2001 15:38:12 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: "Hicks, Jamey" <Jamey.Hicks@compaq.com>
Cc: "'linux-usb-devel@lists.sourceforge.net'" 
	<linux-usb-devel@lists.sourceforge.net>,
        David Brownell <david-b@pacbell.net>,
        Manfred Spraul <manfred@colorfullife.com>, zaitcev@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] Re: SLAB vs. pci_alloc_xxx in usb-uhci patc h
Message-ID: <20010309153812.A29122@flint.arm.linux.org.uk>
In-Reply-To: <879158D1D558D4118DBD0008C7CF32A9015834A7@tayexc07.tay.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <879158D1D558D4118DBD0008C7CF32A9015834A7@tayexc07.tay.cpqcorp.net>; from Jamey.Hicks@compaq.com on Fri, Mar 09, 2001 at 09:27:53AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 09, 2001 at 09:27:53AM -0500, Hicks, Jamey wrote:
> Are there any large-memory machines that need pci_alloc_consistent() in the
> USB controller driver?  If not, then let's just set up an uncached mapping
> of all of DRAM and use a modified version of virt_to_bus and bus_to_virt.

Yuck!  Some machines have 256MB, and I think 512MB of RAM image is just
plain stupid.  (256MB cached, 256MB uncached).  Looking further, one
such machine has:

	cached ram:	256MB
	uncached ram:	256MB
	ioremap space:	512MB	(from PhilB)
	io space:	256MB

In order to follow your suggestion, we'd have to drop the kernel from 0xc*
down to 0xb*.

> It gets around all the issues of having a better allocator of uncached
> memory.  Even with a slab allocator for uncached memory, modified versions
> of virt_to_bus and bus_to_virt would have to be used.

Not if it follows the pci_alloc_consistent interface where we get returned
the DMA and CPU cookies.

> The other choice is cache invalidation and flushing around all the code that
> touches ED's and TD's.  This might not be too bad if it is encapsulated in
> _read and _write macros.  How performance critical is the ED and TD code?

When I went through the OHCI code (which has been eaten by many kernel
updates and rsync), I got down to the TDs and EDs, and realised that the
old cache tricks wouldn't work - there are situations where both the
controller and the CPU need access within the same cache line.

> The latest ARM -NP patches work on SA1110 with the SA1111 controller (which
> is OHCI-like).  With minimal tweaks they work on SA110/Footbridge with an
> OHCI controller.  We will be submitting these patches as tweaks.  It's not
> beautiful, but it doesn't change the mainstream (x86) code significantly.

Comparing the SA11x0 documentation I have here and the OHCI controller
docs, certainly the register sets are significantly different.

It was also my understanding that the SA11x0 USB patches were completely
separate from the existing Linux USB code (or that is what I was told).

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

