Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264745AbSKJFON>; Sun, 10 Nov 2002 00:14:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264746AbSKJFON>; Sun, 10 Nov 2002 00:14:13 -0500
Received: from h-64-105-136-52.SNVACAID.covad.net ([64.105.136.52]:36269 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S264745AbSKJFOM>; Sun, 10 Nov 2002 00:14:12 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Sat, 9 Nov 2002 21:20:46 -0800
Message-Id: <200211100520.VAA27408@baldur.yggdrasil.com>
To: willy@debian.org
Subject: Re: [parisc-linux] Untested port of parisc_device to generic device interface
Cc: andmike@us.ibm.com, hch@lst.de, James.Bottomley@steeleye.com,
       linux-kernel@vger.kernel.org, mochel@osdl.org,
       parisc-linux@lists.parisc-linux.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 09, 2002 at 05:21:50AM +0000, Matthew Wilcox wrote about
generic device models:
> And, for gods sake, don't fuck it up by integrating it with USB too early
> in the game.

	Without rewriting everything, I could see creating a common
device container for devices connected directly to the CPU's memory,
IO or interrupt busses (PCI, ISA, sbus, etc.) so as not to increase
the memory size of device and device_driver for non-mapped device
types (USB, firewire, SCSI, etc.).  More importantly, this change
would provide some type checking for operations that are really only
meaningful on CPU mapped devices, such as the "generic"
dma_{alloc,free}_consistent() and related functions.  I imagine
something like this:


struct cpu_mapped_device {
	dma_addr_t		dma_mask;
	/* Initialized from parent->dma_mask and driver->dma_restrictions. */
	void			*prealloc_vaddr;
	void 			*prealloc_busaddr;
	struct device		device;
};

struct cpu_mapped_driver {
	struct io_restrictions	*dma_restrictions;
	int			prealloc_consistent;
	int			fake_consistent_ok : 1;
	struct device_driver	driver;
};

struct device {
	...
	struct resource_list		*resources;
	/* For automatic release of memory ranges, IO ports, DMA channels,
	   IRQ's, SCSI ID's, SCSI LUN's within an ID, USB device ID's,
	   etc.  (but not USB hub ports, and PCMCIA slots, which we can
	   released before ->remove() is called). */

	dma_pool_t			dma_stub_pool[2];
	struct cpu_mapped_device	*dma_dev;
	/* Points to the cpu_mapped_device that we are embedded in for PCI,
	   ISA, and other cpu mapped devices.  Points to the parent
	   cpu mapped device for others, such as the USB controller for a
	   USB network interface.   Will be used for allocating DMA gather
	   scatter stubs when allocating skbuff's, bio's, scsi_request's,
	   USB request blocks, etc., eliminating another set of error
	   branches. */
};

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Miplitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
