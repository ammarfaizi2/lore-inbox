Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932250AbWCDR3W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932250AbWCDR3W (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 12:29:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932254AbWCDR3V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 12:29:21 -0500
Received: from smtp.osdl.org ([65.172.181.4]:17562 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932250AbWCDR3U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 12:29:20 -0500
Date: Sat, 4 Mar 2006 09:28:54 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Paul Mackerras <paulus@samba.org>
cc: David Howells <dhowells@redhat.com>, akpm@osdl.org,
       linux-arch@vger.kernel.org, bcrl@linux.intel.com, matthew@wil.cx,
       linux-kernel@vger.kernel.org, mingo@redhat.com,
       linuxppc64-dev@ozlabs.org, jblunck@suse.de
Subject: Re: Memory barriers and spin_unlock safety
In-Reply-To: <17417.29375.87604.537434@cargo.ozlabs.ibm.com>
Message-ID: <Pine.LNX.4.64.0603040914160.22647@g5.osdl.org>
References: <32518.1141401780@warthog.cambridge.redhat.com>
 <Pine.LNX.4.64.0603030823200.22647@g5.osdl.org> <17417.29375.87604.537434@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 4 Mar 2006, Paul Mackerras wrote:
> 
> > If so, a simple write barrier should be sufficient. That's exactly what 
> > the x86 write barriers do too, ie stores to magic IO space are _not_ 
> > ordered wrt a normal [smp_]wmb() (or, as per how this thread started, a 
> > spin_unlock()) at all.
> 
> By magic IO space, do you mean just any old memory-mapped device
> register in a PCI device, or do you mean something else?

Any old memory-mapped device that has been marked as write-combining in 
the MTRR's or page tables.

So the rules from the PC side (and like it or not, they end up being 
what all the drivers are tested with) are:

 - regular stores are ordered by write barriers
 - PIO stores are always synchronous
 - MMIO stores are ordered by IO semantics
	- PCI ordering must be honored:
	  * write combining is only allowed on PCI memory resources
	    that are marked prefetchable. If your host bridge does write 
	    combining in general, it's not a "host bridge", it's a "host 
	    disaster".
	  * for others, writes can always be posted, but they cannot
	    be re-ordered wrt either reads or writes to that device
	    (ie a read will always be fully synchronizing)
	- io_wmb must be honored

In addition, it will help a hell of a lot if you follow the PC notion of 
"per-region extra rules", ie you'd default to the non-prefetchable 
behaviour even for areas that are prefetchable from a PCI standpoint, but 
allow some way to relax the ordering rules in various ways.

PC's use MTRR's or page table hints for this, but it's actually perfectly 
possible to do it by virtual address (ie decide on "ioremap()" time by 
looking at some bits that you've saved away to remap it to a certain 
virtual address range, and then use the virtual address as a hint for 
readl/writel whether you need to serialize or not).

On x86, we already use the "virtual address" trick to distinguish between 
PIO and MMIO for the newer ioread/iowrite interface (the older 
inb/outb/readb/writeb interfaces obviously don't need that, since the IO 
space is statically encoded in the function call itself).

The reason I mention the MTRR emulation is again just purely compatibility 
with drivers that get 99.9% of all the testing on a PC platform.

		Linus
