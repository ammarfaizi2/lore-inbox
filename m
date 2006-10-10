Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964903AbWJJDgQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964903AbWJJDgQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 23:36:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964913AbWJJDgQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 23:36:16 -0400
Received: from gate.crashing.org ([63.228.1.57]:47055 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S964903AbWJJDgP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 23:36:15 -0400
Subject: driver,platform,firmware,system, data data data ....
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Greg KH <greg@kroah.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Tue, 10 Oct 2006 13:36:08 +1000
Message-Id: <1160451368.32237.78.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg !

I'm in need of something around the lines of pci "sysdata" but
generically (for all devices). So I had a look, and noticed that in
struct device, we have already 3 "data":

 - driver_data (ok, that one we know all about)
 - firmware_data (just discovered it, I already know what to use it
for :)
 - platform_data (ugh ?)

It's my understanding that the later is for use by platform drivers,
right ?

So except for the size of the patch and boredom of going through all of
them fixing them, do you see any reason why this later one shouldn't be
moved out to platform_driver ? (I haven't actually checked at all the
occurences in the tree though).

On the other hand, we have in pci_dev

 - sysdata (ok, let's call it system_data)

Which I would quite like to see in struct device instead :)

The reason is that I have to deal with setups with multiple iommu's and
non-PCI devices. The current powerpc infrastructure for findign the
right iommu for dma_ops tests various bus types (pci and vio for now for
pci and virtual ios) and get the right data structure defined by each of
these (in sysdata for pci, some other field for vio) to get the iommu
table pointer.

Now, with more non-pci bus types coming in, and the advent of some
platform-like OF (open firmware probed) devices, we end up with more of
these bus types and a fairly complicated situation to get to the iommu.
Since it's a fairly hot path, I'm not happy comparing the bus type with
3 or more types and going looking at various bus specific data
structures to find it.

Thus I want a arch-wide data structure that can be attached to any
struct device to carry the iommu table pointer (and maybe a couple of
other things in the future but it's mostly that for now).

Thus that would be a nice fit for a system_data there (and since that's
what we use sysdata in pci_dev for, basically, remove the later).

As a temporary measure, I'll hijack firmware_data which isn't used for
anything on powerpc at the moment (though I'd like to use it in the
future for a pointer to the OF device node if any).

Any comments on the approach ? If you are ok, I'll look into doing the
tedious work of converting the whole tree to those 2 changes (moving
platform_data to platform_driver and pci sysdata to generic system_data)
and cook some patches for after 2.6.19.

Cheers,
Ben.


