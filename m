Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266047AbUAFAtP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 19:49:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265940AbUAFAqY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 19:46:24 -0500
Received: from bolt.sonic.net ([208.201.242.18]:45189 "EHLO bolt.sonic.net")
	by vger.kernel.org with ESMTP id S266042AbUAFAoa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 19:44:30 -0500
Date: Mon, 5 Jan 2004 16:44:23 -0800
From: David Hinds <dhinds@sonic.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, Amit <mehrotraamit@yahoo.co.in>,
       Russell King <rmk@arm.linux.org.uk>
Subject: Re: PCI memory allocation bug with CONFIG_HIGHMEM
Message-ID: <20040105164423.A30738@sonic.net>
References: <20040105120707.A18107@sonic.net> <Pine.LNX.4.58.0401051630190.2170@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0401051630190.2170@home.osdl.org>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 05, 2004 at 04:36:15PM -0800, Linus Torvalds wrote:
> 
> On Mon, 5 Jan 2004, David Hinds wrote:
> > 
> > In arch/i386/kernel/setup.c we have:
> > 
> > 	/* Tell the PCI layer not to allocate too close to the RAM area.. */
> > 	low_mem_size = ((max_low_pfn << PAGE_SHIFT) + 0xfffff) & ~0xfffff;
> > 	if (low_mem_size > pci_mem_start)
> > 		pci_mem_start = low_mem_size;
> > 
> > which is meant to round up pci_mem_start to the nearest 1 MB boundary
> > past the top of physical RAM.  However this does not consider highmem.
> > Should this just be using max_pfn rather than max_low_pfn?
> 
> Yes and no. That doesn't really work either, for any machine with more
> than 4GB of RAM.

Ugh.

> We want to find the memory hole (in the low 4GB region), and usually the
> e820 memory map should make that all happen properly. What does that
> report on this laptop?
> 
> This is why we put the memory resources in /proc/iomem, and mark them 
> busy: so that the PCI subsystem won't try to allocate PCI memory in the 
> RAM (or ACPI reserved) area. The "pci_mem_start" thing is just a point to 
> _start_ the allocation, the PCI subsystem still should honor the fact that 
> we have memory above it. That's the whole point of doing proper resource 
> allocation, after all.
> 
> Does this not work, or have you disabled e820 for some reason?

The original problem was actually that grub was passing a bogus mem=
parameter to the kernel that was 4K too small, I guess because it was
intending to indicate the amount of "available" memory (the top 4K is
reserved for ACPI).  If highmem had not been enabled, the above code
would have corrected the problem; but with highmem, the computed
low_mem_size was incorrect.  I would say that grub is just broken and
is misusing the mem= parameter, but this has been a problem for years
and they don't seem interested in fixing it.

-- Dave
