Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261323AbVDZEd4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261323AbVDZEd4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 00:33:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261318AbVDZEd4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 00:33:56 -0400
Received: from gate.crashing.org ([63.228.1.57]:59590 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261332AbVDZEd3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 00:33:29 -0400
Subject: Re: [PATCH] PCI: Add pci shutdown ability
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Adam Belay <abelay@novell.com>
Cc: Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Alan Stern <stern@rowland.harvard.edu>, alexn@dsv.su.se,
       Greg KH <greg@kroah.com>, gud@eth.net,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, Jeff Garzik <jgarzik@pobox.com>,
       cramerj@intel.com, Linux-USB <linux-usb-devel@lists.sourceforge.net>
In-Reply-To: <20050425232330.GG27771@neo.rr.com>
References: <1114458325.983.17.camel@localhost.localdomain>
	 <Pine.LNX.4.44L0.0504251609420.7408-100000@iolanthe.rowland.org>
	 <20050425145831.48f27edb.akpm@osdl.org> <20050425221326.GC15366@redhat.com>
	 <20050425232330.GG27771@neo.rr.com>
Content-Type: text/plain
Date: Tue, 26 Apr 2005 14:32:29 +1000
Message-Id: <1114489949.7111.43.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I've been considering for a while that, in addition to ->probe and ->remove, we
> have the following:
> 
> "struct device" -->
> ->attach - binds to the device and allocates data structures
> ->probe - detects and sets up the hardware
> ->start - begins transactions (like DMA)
> ->stop - stops transactions
> ->remove - prepares the hardware for no driver control
> ->detach - frees stuff and unbinds the device
> 
> ->start and ->stop would be optional, and only used where they apply.

>From my experience, this doesn't work. You actually want to have power
transitions and start/stop semantics to be "atomic" as far as drvier
state change is concerned. You can't for example stop all drivers, then
in a second pass, change the power state, since after you have stopped
drivers, you parent (bus) driver may not let you talk to your device
anymore for obvious reasons (and thus may prevent you from doing the
power state change).

We really want all this to be part of the normal power management
infrastructure. In this specific state, it's just basically a system
state, that has already been discussed at lenght and that we nicknamed
'freeze' since it's exactly what suspend-to-disk needs before
snapshoting the system image.

> ->probe and ->remove would be useful for resource rebalancing
> 
> Power management functions could (and usually should) manually call some of
> these.  Also this would be useful for error recovery and restarting devices.
> 
> Still, cpufreq seems like a difficult problem.  What's to prevent,
> hypothetically, an SMP system from stoping a device while the upper class
> layer tries to use it.

Proper locking in the driver should prevent that. if you have a problem
with "SMP", then you have a problem with preempt, and others ... then
your model is flawed. 
 
> If the class level locks control of the device, then
> DMA can't be stopped.  Also, attempting to stop device activity may fail
> if the driver decides it's not possible.

No locking should be at the class level. All locking should be local to
the device, unless the notion of device state is managed outside of the
driver.

I don't like this notion of "stop" separated from power states anyway, I
think it just doesn't work in practice.

Ben.

> Thanks,
> Adam
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>

