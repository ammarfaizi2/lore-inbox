Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265761AbUF2OVV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265761AbUF2OVV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 10:21:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265763AbUF2OVV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 10:21:21 -0400
Received: from stat1.steeleye.com ([65.114.3.130]:37839 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S265761AbUF2OVS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 10:21:18 -0400
Subject: [RFC] on-chip coherent memory API for DMA
From: James Bottomley <James.Bottomley@steeleye.com>
To: Ian Molton <spyro@f2s.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, tony@atomide.com,
       jamey.hicks@hp.com, joshua@joshuawise.com, david-b@pacbell.net,
       Russell King <rmk@arm.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 29 Jun 2004 09:21:05 -0500
Message-Id: <1088518868.1862.18.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The purpose of this API is to find a way of declaring on-chip memory as
a pool for dma_alloc_coherent() that can be useful to all architectures.

The proposed API is:

nt dma_declare_coherent_memory(struct device *dev, dma_addr_t bus_addr,
dma_addr_t device_addr, size_t size, int flags)

This API basically declares a region of memory to be handed out by
dma_alloc_coherent when it's asked for coherent memory for this device.

bus_addr is the physical address to which the memory is currently
assigned in the bus responding region

device_addr is the physical address the device needs to be programmed
with actually to address this memory.

size is the size of the area (must be multiples of PAGE_SIZE).

The flags is where all the magic is.  They can be or'd together and are

DMA_MEMORY_MAP - request that the memory returned from
dma_alloc_coherent() be directly writeable.

DMA_MEMORY_IO - request that the memory returned from
dma_alloc_coherent() be addressable using read/write/memcpy_toio etc.

One or both of these flags must be present

DMA_MEMORY_INCLUDES_CHILDREN - make the declared memory be allocated by
dma_alloc_coherent of any child devices of this one (for memory residing
on a bridge).

DMA_MEMORY_EXCLUSIVE - only allocate memory from the declared regions. 
Do not allow dma_alloc_coherent() to fall back to system memory when
it's out of memory in the declared region.

The return value would be either DMA_MEMORY_MAP or DMA_MEMORY_IO and
must correspond to a passed in flag (i.e. no returning DMA_MEMORY_IO if
only DMA_MEMORY_MAP were passed in) or zero for failure.

I think also, it's reasonable only to have a single declared region per
device.

Implementation details

Obviously, the big change is that dma_alloc_coherent() may now be
handing out memory that can't be directly written to (in the case of a
DMA_MEMORY_IO return).

I envisage implementing an internal per device resource allocator in
drivers/base into which each platform allocator can plug do do the heavy
allocation lifting (they'd still get to do the platform magic to make
the returned region visible as memory if necessary).

The API would be platform optional, with platforms not wishing to
implement it simply hard coding a return 0.

There would also be a corresponding

void dma_release_declared_memory(struct device *dev)

whose job would be to clean up unconditionally (and not check if the
memory were still in use).

I already have this coded up on x86 and implemented for a SCSI card I
have with four channels and a shared 2MB memory area on chip.  I'll post
the implementations when I get it cleaned up.

James


