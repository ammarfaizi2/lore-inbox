Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268745AbTCCTsF>; Mon, 3 Mar 2003 14:48:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268746AbTCCTsE>; Mon, 3 Mar 2003 14:48:04 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:33806 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S268745AbTCCTsB>; Mon, 3 Mar 2003 14:48:01 -0500
Date: Mon, 3 Mar 2003 19:58:25 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Matt Porter <porter@cox.net>
Cc: linux-kernel@vger.kernel.org, Dave Miller <davem@redhat.com>
Subject: Re: *dma_sync_single API change to support non-coherent cpus
Message-ID: <20030303195825.C17997@flint.arm.linux.org.uk>
Mail-Followup-To: Matt Porter <porter@cox.net>,
	linux-kernel@vger.kernel.org, Dave Miller <davem@redhat.com>
References: <20030303111848.A31278@home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030303111848.A31278@home.com>; from porter@cox.net on Mon, Mar 03, 2003 at 11:18:48AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 03, 2003 at 11:18:48AM -0700, Matt Porter wrote:
> On non cache coherent processors, it is necessary to perform
> cache operations on the virtual address associated with the
> buffer to ensure consistency.  There is one problem, however,
> the current API does not provide the virtual address for the
> buffer.  It only provides the bus address in the dma_addr_t.
> On arm and mips, this is dealt with by simply doing bus_to_virt().
> However, bus_to_virt() isn't valid for all addresses that could
> have been passed into *map_single().

I find myself thinking, in passing, why we don't have these
architectures define something like the following in architecture
specific code:

	struct dma_addr {
		unsigned long cpu;
		unsigned long bus;
		unsigned long size;
	};

	#define dma_bus_addr(x)	((x).bus)
	#define dma_cpu_addr(x)	((x).cpu)

and have:

	dma_map_single(dev, &dma_addr, addr, size);

	dma_sync_single(dev, &dma_addr);

Architectures which only need the CPU address can place only that in
their structure definition, and make dma_map_single and friends no-ops.
I feel that this would get rid of all the shouting DMA_* macros found
in various pci.h header files.

This may be something considering for 2.7 though.

DaveM, as the author of the original PCI DMA API, any comments on this
(probably ill-thoughtout) idea?

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

