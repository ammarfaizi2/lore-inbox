Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265999AbUAEXDt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 18:03:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265994AbUAEXBo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 18:01:44 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:37647 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S265999AbUAEXAY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 18:00:24 -0500
Date: Mon, 5 Jan 2004 23:00:16 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: David Hinds <dhinds@sonic.net>
Cc: linux-kernel@vger.kernel.org, Amit <mehrotraamit@yahoo.co.in>
Subject: Re: PCI memory allocation bug with CONFIG_HIGHMEM
Message-ID: <20040105230016.D11207@flint.arm.linux.org.uk>
Mail-Followup-To: David Hinds <dhinds@sonic.net>,
	linux-kernel@vger.kernel.org, Amit <mehrotraamit@yahoo.co.in>
References: <20040105120707.A18107@sonic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040105120707.A18107@sonic.net>; from dhinds@sonic.net on Mon, Jan 05, 2004 at 12:07:07PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 05, 2004 at 12:07:07PM -0800, David Hinds wrote:
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
> 
> (I have a report of this failing on a laptop with a highmem kernel,
> causing a PCI memory resource to be allocated on top of a RAM area)

Beware - people sometimes use mem= to tell the kernel how much RAM is
available for its use.  Unfortunately, this overrides the E820 map,
and causes the kernel to believe that all memory above the end of RAM
is available for use.

This is not the case, especially on ACPI systems.

I have come to the conclusion that the use of mem= is a _very_ bad idea
unless someone has an extremely good reason to override the E820 map.
And even then, it must be used with extreme care, and also in combination
with the reserve= parameter to ensure that reserved memory areas remain
marked as such.  (Reserved regions as in the ACPI data tables.)

Failure to follow this will result in non-functional PCMCIA/Cardbus
because of memory resource collisions between system RAM and PCI
memory space.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
