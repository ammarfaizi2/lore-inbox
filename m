Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263019AbTIARP4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 13:15:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263112AbTIARP4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 13:15:56 -0400
Received: from hq.pm.waw.pl ([195.116.170.10]:55706 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id S263019AbTIARPn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 13:15:43 -0400
To: "David S. Miller" <davem@redhat.com>
Cc: alan@lxorguk.ukuu.org.uk, jes@trained-monkey.org, zaitcev@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RFC: kills consistent_dma_mask
References: <m3oeynykuu.fsf@defiant.pm.waw.pl>
	<20030818111522.A12835@devserv.devel.redhat.com>
	<m33cfyt3x6.fsf@trained-monkey.org>
	<1061298438.30566.29.camel@dhcp23.swansea.linux.org.uk>
	<20030819095547.2bf549e3.davem@redhat.com>
	<m34r0dwfrr.fsf@defiant.pm.waw.pl> <m38ypl29i4.fsf@defiant.pm.waw.pl>
	<m3isoo2taz.fsf@trained-monkey.org> <m3n0dz5kfg.fsf@defiant.pm.waw.pl>
	<20030824060057.7b4c0190.davem@redhat.com>
	<m365kmltdy.fsf@defiant.pm.waw.pl> <m365kex2rp.fsf@defiant.pm.waw.pl>
	<20030830185007.5c61af71.davem@redhat.com>
	<1062334374.31861.32.camel@dhcp23.swansea.linux.org.uk>
	<20030831222233.1bd41f01.davem@redhat.com>
	<m37k4tj71h.fsf@defiant.pm.waw.pl>
	<20030901004308.477f8cc8.davem@redhat.com>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 01 Sep 2003 19:14:46 +0200
In-Reply-To: <20030901004308.477f8cc8.davem@redhat.com>
Message-ID: <m3ptikctx5.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" <davem@redhat.com> writes:

> Sure, I'm fine with this as a termporary thing until we
> work out the details properly.

How about the following patch? It corrects most, if not all, obvious
things.

--- linux-2.6/Documentation/DMA-mapping.txt	2003-08-09 06:36:56.000000000 +0200
+++ linux-2.6/Documentation/DMA-mapping.txt.orig	2003-09-01 19:06:16.000000000 +0200
@@ -76,7 +76,8 @@
 Does your device have any DMA addressing limitations?  For example, is
 your device only capable of driving the low order 24-bits of address
 on the PCI bus for SAC DMA transfers?  If so, you need to inform the
-PCI layer of this fact.
+PCI layer of this fact.  Even if you do, this information will be
+ignored on some architectures, such as i386.
 
 By default, the kernel assumes that your device can address the full
 32-bits in a SAC cycle.  For a 64-bit DAC capable device, this needs
@@ -123,6 +124,11 @@
 2) Use some non-DMA mode for data transfer, if possible.
 3) Ignore this device and do not initialize it.
 
+Most platforms will ignore pci_set_consistent_dma_mask() at all and, for
+example, use the device mask set with pci_set_dma_mask() for consistent
+allocations. Remember that even setting both masks to the same value
+doesn't necessarily mean this value will actually be honoured.
+
 It is recommended that your driver print a kernel KERN_WARNING message
 when you end up performing either #2 or #3.  In this manner, if a user
 of your driver reports that performance is bad or that the device is not
@@ -180,10 +186,8 @@
 		goto ignore_this_device;
 	}
 
-pci_set_consistent_dma_mask() will always be able to set the same or a
-smaller mask as pci_set_dma_mask(). However for the rare case that a
-device driver only uses consistent allocations, one would have to
-check the return value from pci_set_consistent_dma_mask().
+For the rare case that a device driver only uses consistent allocations,
+one would have to check the return value from pci_set_consistent_dma_mask().
 
 If your 64-bit device is going to be an enormous consumer of DMA
 mappings, this can be problematic since the DMA mappings are a
@@ -201,17 +205,17 @@
 	}
 
 When pci_set_dma_mask() is successful, and returns zero, the PCI layer
-saves away this mask you have provided.  The PCI layer will use this
-information later when you make DMA mappings.
+saves away this mask you have provided.  The PCI layer may or may not
+use this information later when you make DMA mappings.
 
 There is a case which we are aware of at this time, which is worth
 mentioning in this documentation.  If your device supports multiple
 functions (for example a sound card provides playback and record
 functions) and the various different functions have _different_
 DMA addressing limitations, you may wish to probe each mask and
-only provide the functionality which the machine can handle.  It
-is important that the last call to pci_set_dma_mask() be for the 
-most specific mask.
+only provide the functionality which the machine can handle. Remember
+that the last call to pci_set_dma_mask() will set the mask which will
+(or will not) be used for subsequent DMA mapping requests.
 
 Here is pseudo-code showing how this might be done:
 
@@ -239,7 +243,10 @@
 
 A sound card was used as an example here because this genre of PCI
 devices seems to be littered with ISA chips given a PCI front end,
-and thus retaining the 16MB DMA addressing limitations of ISA.
+and thus retaining the 16MB DMA addressing limitations of ISA. While
+this example will not probably work for pci_map_* functions, the mask
+will be honoured for pci_alloc_consistent() on all platforms except
+ia64 and x86-64.
 
 			Types of DMA mappings
 
@@ -330,10 +337,10 @@
 default return a DMA address which is SAC (Single Address Cycle)
 addressable.  Even if the device indicates (via PCI dma mask) that it
 may address the upper 32-bits and thus perform DAC cycles, consistent
-allocation will only return > 32-bit PCI addresses for DMA if the
-consistent dma mask has been explicitly changed via
+allocation on ia64 and x86-64 will only return > 32-bit PCI addresses
+for DMA if the consistent dma mask has been explicitly changed via
 pci_set_consistent_dma_mask().  This is true of the pci_pool interface
-as well.
+as well. On other platforms, use pci_set_dma_mask().
 
 pci_alloc_consistent returns two values: the virtual address which you
 can use to access it from the CPU and dma_handle which you pass to the

-- 
Krzysztof Halasa, B*FH

