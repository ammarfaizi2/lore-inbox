Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265320AbUAFDde (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 22:33:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265329AbUAFDde
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 22:33:34 -0500
Received: from p50821721.dip.t-dialin.net ([80.130.23.33]:64654 "EHLO
	averell.firstfloor.org") by vger.kernel.org with ESMTP
	id S265320AbUAFDcv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 22:32:51 -0500
To: David Hinds <dhinds@sonic.net>
cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: PCI memory allocation bug with CONFIG_HIGHMEM
From: Andi Kleen <ak@muc.de>
Date: Tue, 06 Jan 2004 04:32:41 +0100
In-Reply-To: <1aJdi-7TH-25@gated-at.bofh.it> (David Hinds's message of "Mon,
 05 Jan 2004 21:10:20 +0100")
Message-ID: <m37k054uqu.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.090013 (Oort Gnus v0.13) Emacs/21.2 (i586-suse-linux)
References: <1aJdi-7TH-25@gated-at.bofh.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Hinds <dhinds@sonic.net> writes:

> In arch/i386/kernel/setup.c we have:
>
> 	/* Tell the PCI layer not to allocate too close to the RAM area.. */
> 	low_mem_size = ((max_low_pfn << PAGE_SHIFT) + 0xfffff) & ~0xfffff;
> 	if (low_mem_size > pci_mem_start)
> 		pci_mem_start = low_mem_size;
>
> which is meant to round up pci_mem_start to the nearest 1 MB boundary
> past the top of physical RAM.  However this does not consider highmem.
> Should this just be using max_pfn rather than max_low_pfn?

max_pfn would get memory >4GB on highmem systems, which generally
doesn't work because many PCI devices only support 32bit addresses.

IMHO the only reliable way to get physical bus space for mappings
is to allocate some memory and map the mapping over that.
On x86-64 the allocation must be GFP_DMA, on i386 it can be GFP_KERNEL.

The problem is that BIOS commonly use physical address space without
marking it in the e820 map. For example the AGP aperture is normally
not marked in any way in the e820 map, but you definitely cannot reuse
its bus space. The old code assumed that there is a memory hole below
the highest memory address <4GB, but that can be not true on a system
with >3GB.

We unfortunately must assume on such systems that all holes in e820
space are already used by something. On a system with <3GB you 
are usually lucky because there is some space left, but even that
can break and e.g. conflict with reserved ACPI mappings. In theory
you could have a heuristic with something like "if E820_RAM is 
<2GB just allocate it after the highest E820_RAM map not conflicting
with other E820 mappings", but this would be quite hackish and 
may break on weird systems.

BTW drivers/char/mem.c makes the same broken assumption. It really
wants to default to uncached access for any holes, but default to
cached for real memory. Doing that also requires reliable hole detection,
which we don't have.

One approach I haven't checked is that the ACPI memory map may have
fixed the problem (no defined way to get a hole)

As long as you only have e820 I think there is no real alternative to
the "put io map over memory" technique.

-Andi
