Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266254AbUGORwW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266254AbUGORwW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jul 2004 13:52:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266257AbUGORwV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jul 2004 13:52:21 -0400
Received: from gate.crashing.org ([63.228.1.57]:51841 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S266254AbUGORwN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jul 2004 13:52:13 -0400
Subject: Re: kexec on ppc64
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: "R. Sharada [imap]" <sharada@in.ibm.com>, fastboot@lists.osdl.org,
       PPC64 External List <linuxppc64-dev@lists.linuxppc.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1089864891.10000.257.camel@nighthawk>
References: <20040714144514.GA2041@in.ibm.com>
	 <1089864891.10000.257.camel@nighthawk>
Content-Type: text/plain
Message-Id: <1089913838.2484.41.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 15 Jul 2004 13:50:39 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-07-15 at 00:14, Dave Hansen wrote:
> taking silly IBM list off the cc...
> 
> On Wed, 2004-07-14 at 07:45, R Sharada
> >         - also identify relevant data (that might be required for the
> > kexec kernel) that could be pushed into the device_tree so that it can
> > be passed to the new kexec kernel
> 
> We actually had a similar problem on x86.  The e820 table is presented
> by the BIOS, and must be saved or reconstructed when you boot into the
> new kernel.
> 
> It would be really cool to have a way of passing the memory layout
> information to the new kernel that is relatively cross-platform.  That
> way, we don't get stuck rewriting it for each new arch.

I wouldn't even try to go that way at first. What we need is to pass
an OF device-tree around on ppc, with all the necessary informations
stuffed in it as additional properties.

> For instance, instead of passing the BIOS/firmware structures like LMBs
> in the device tree or e820 tables to the kexec kernel, you'd pass the
> Linux concepts like zone_start_pfn and so forth.

I'd prefer letting the new kernel decide those based on the low level
firmware info, or you introduce a higher level dependency between the
"old" and "new" kernels (what if those concepts change between the 2
kernels ?)

> > I would like to solicit inputs, feedback, opinions, changes on this
> > preliminary idea and planned list of 'things to do'. I would also like
> > to know the interest to participate in this effort or anything else
> > related to 'kexec on ppc64'.
> 
> While you're ripping apart prom.c, have you thought about getting rid of
> all of the RELOC() stuff?  I think Ben H. had an evil plan for that,
> too.

Paulus already removed a bunch, once we manage to completely isolate
prom_init from the rest of the kernel, it will be easier to "finish" it
by having prom_init be a totally separate link entity (could even be 32
bits relocatable code).

> BTW, have you seen any opportunities to replace the arch-specific things
> like lmb_alloc() with normal bootmem calls?

As far as lmb_alloc() is concerned, there are some constraints like beeing
in RMO for some things, or beeing at the top of the memory for others, that
aren't quite addressed by bootmem. Again, we are in the firmware env at
this point, I wouldn't rely on too much linux-specific data structures.

What we need, as we already discussed for a while with Rusty, is a specific
allocator for use within prom_init() which properly deals with both OF-side
allocations (claim the memory) to avoid walking over things like initrd,
deals with the various constraints we have, and produce a map of allocated
area as a property for use by the rest of the kernel.

As far as the post-prom-init stage is concerned, we can just turn that map
into lmb's, or try to get rid of lmb's and turn that into bootmem provided
we can deal with the various RMO constraints.

Ben.


