Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263479AbUDBBXH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 20:23:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263507AbUDBBXH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 20:23:07 -0500
Received: from gate.crashing.org ([63.228.1.57]:26527 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S263479AbUDBBW6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 20:22:58 -0500
Subject: Re: Problems with dma_alloc_coherent()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: John Whitney <jwhitney-linuxppc@sands-edge.com>
Cc: Eugene Surovegin <ebs@ebshome.net>, Dan Malek <dan@embeddededge.com>,
       Matt Porter <mporter@kernel.crashing.org>,
       linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <CDB1AF42-8413-11D8-9FF0-000A95A07384@sands-edge.com>
References: <9EB527A2-83F5-11D8-9FF0-000A95A07384@sands-edge.com>
	 <20040401100546.A27472@home.com>
	 <4317F0F4-8405-11D8-9FF0-000A95A07384@sands-edge.com>
	 <20040401181926.GA3630@gate.ebshome.net> <406C658E.10500@embeddededge.com>
	 <20040401185956.GB3786@gate.ebshome.net>
	 <2C2F00BD-8410-11D8-9FF0-000A95A07384@sands-edge.com>
	 <20040401191715.GC3786@gate.ebshome.net>
	 <CDB1AF42-8413-11D8-9FF0-000A95A07384@sands-edge.com>
Content-Type: text/plain
Message-Id: <1080868954.1286.33.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 02 Apr 2004 11:22:34 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, time to step in....

> Yes, after thinking about it, it made more sense to modify the "struct
> bus_type" structure to have the bus memory map offset.  We could then
> have an OCP bus type, PLB bus type, etc.  However, that would be a core
> kernel change, and I don't know how easy it is to get those pushed back
> into the mainline.
> 
> Also, after looking at the kernel code more (I'm fairly new to 2.6,
> which I'm sure you've deduced), it looks like most routines expect
> instances of type "bus_type" to be enumeratable/hot-swappable, and many
> of the busses I'd use in the embedded world wouldn't fit.  I don't know
> how easy or difficult it would be to use the bus_type code construct in
> this fashion.

Please, bring this discussion to linux-kernel. The problem is similar
to some issue I'm having on ppc64 with iommu. In a more general way,
I want to be able to attach additional data to a struct device for use
by the DMA code, that can be pointers to the actual DMA functions,
pointer to the PHB structure, pointer to the iommu table, bus offset,
etc....

Adding such things to bus_type isn't a good option. Especially since
several platform may have different needs for the same bus type, or
several _instances_ of a bus of a given type may have different needs
(typically, the iommu info or DMA offset may be different for 2 busses
of the same type).

What struct bus_type provides is actually the "class" of the device
object in object terminology (which is yet different from struct
"class" in the driver model terminology, I know, this is all quite
confusing). That is, it defines the actual struct type that embeds
that struct device. It does _not_ represent an instance of that bus.

There is a hook in the device model that can be used to add your own
data to a device (typically to put something in device->platform_data).

This hook is called at device_register() and device_unregister() time,
however, it is bogus for a simple reason: Lifetime rules. The struct
device beeing a kobject, it can stay around after beeing unregistered,
at least until the last reference to the kobkjet gets dropped.
Theorically, we should also "remove" whatever we put in platform_data
at this same deletion time, and not earlier, or we may race with
something currently using the device.

This race is unlikely imho as I doubt we unregister devices that still
have a driver attached, and the driver is probably the only thing that
will actually use that platform data (indirectly via things like the
DMA API) but still...

Ben.


