Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266046AbUAFAjJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 19:39:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266033AbUAFAgv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 19:36:51 -0500
Received: from fw.osdl.org ([65.172.181.6]:13482 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265990AbUAFAgR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 19:36:17 -0500
Date: Mon, 5 Jan 2004 16:36:15 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: David Hinds <dhinds@sonic.net>
cc: linux-kernel@vger.kernel.org, Amit <mehrotraamit@yahoo.co.in>,
       Russell King <rmk@arm.linux.org.uk>
Subject: Re: PCI memory allocation bug with CONFIG_HIGHMEM
In-Reply-To: <20040105120707.A18107@sonic.net>
Message-ID: <Pine.LNX.4.58.0401051630190.2170@home.osdl.org>
References: <20040105120707.A18107@sonic.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 5 Jan 2004, David Hinds wrote:
> 
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

Yes and no. That doesn't really work either, for any machine with more
than 4GB of RAM.

We want to find the memory hole (in the low 4GB region), and usually the
e820 memory map should make that all happen properly. What does that
report on this laptop?

This is why we put the memory resources in /proc/iomem, and mark them 
busy: so that the PCI subsystem won't try to allocate PCI memory in the 
RAM (or ACPI reserved) area. The "pci_mem_start" thing is just a point to 
_start_ the allocation, the PCI subsystem still should honor the fact that 
we have memory above it. That's the whole point of doing proper resource 
allocation, after all.

Does this not work, or have you disabled e820 for some reason?

		Linus
