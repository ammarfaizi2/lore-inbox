Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130920AbRCJDhD>; Fri, 9 Mar 2001 22:37:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130921AbRCJDgy>; Fri, 9 Mar 2001 22:36:54 -0500
Received: from aslan.scsiguy.com ([63.229.232.106]:57104 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S130920AbRCJDgp>; Fri, 9 Mar 2001 22:36:45 -0500
Message-Id: <200103100336.f2A3ZqO67658@aslan.scsiguy.com>
To: linux-kernel@vger.kernel.org
cc: torvalds@transmeta.com
Subject: Version 6.1.6 of the aic7xxx driver availalbe
Date: Fri, 09 Mar 2001 20:35:52 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As always, the latest version of this driver is availalbe here:

http://people.FreeBSD.org/~gibbs/linux/

Complete CHANGELOG is now available at the above URL.

I try to filter though LK as often as I can, but for
best response, please email issues regarding this driver to
me directly.

Changes since 6.1.5 include:

	o Firmware generation is now a tunable option
	  defaulting to OFF.  Don't turn this on unless
	  you really have a reason to re-agenerate the
	  firmware (e.g. you are actively developing it).

	o aicasm Makefile changes from Alan Cox that
	  attempt to make aicasm compilable on more
	  distributions.

	o On some chips, at least the aic7856, the transition from
	  MREQPEND to HDONE can take a full 4 clock cycles.  Test
	  HDONE one more time to avoid this race.  We only want our
	  FIFO hung recovery code to execute when the engine is
	  really hung.  This makes the aic7856 work again on systems
	  affected by the PCI 2.1 retry bug.

	o Modify our interrupt handler so that optimizations
	  that rely on level sensitive interrupts are disabled
	  when edge triggered interrupts are in use.  This
	  affected the 284X and some EISA installations where
	  level sensitive interrupts are disabled.

	o Staticize some rogue symbols.  All exported symbols
	  have either an "ahc" or "aic7xxx" prefix to avoid
	  potential conflicts with other modules.

	o Fix the sorting of driver instances so that even
	  if PCI devices are presented to the driver in a
	  very strange order, it still works.  In the past,
	  we relied on function 0 of a device being seen prior
	  to function 1.  This should make the channel b primary
	  BIOS option functional again.

	o Add a crude hack to make modunload/modload cycles work
	  now that we are using the new PCI methods.  We must
	  detach our driver from each PCI device referenced by
	  a call to our release method.  The PCI code doesn't have
	  a method to do this, so we muck with the pci_dev ourselves.

	o Deregister our PCI driver when aic7xxx_release releases
	  the last host instance.

	o Only adjust our goal negotiation settings if the device 
	  is actually present.  This prevents a disconnected lun 
	  that does not claim to support negotiations from messing
	  up the settings for a successfully probed lun whose inquiry
	  data properly reflects the abilities of the device.

	o Set the device structure as releasable should the inquiry
	  come back with anything other than lun connected.  We  
	  should also do this if the device goes away as evidenced
	  by a selection timeout, but as we can't know if this
	  condition is persistant and there is no guarantee that
	  the mid-layer will reissue the inquiry command we use 
	  to validate the device, I've simply added a comment
	  this effect.

--
Justin
