Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129345AbQLKHbT>; Mon, 11 Dec 2000 02:31:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129875AbQLKHa7>; Mon, 11 Dec 2000 02:30:59 -0500
Received: from isis.its.uow.edu.au ([130.130.68.21]:59793 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S129345AbQLKHax>; Mon, 11 Dec 2000 02:30:53 -0500
Message-ID: <3A347C69.9635C3B4@uow.edu.au>
Date: Mon, 11 Dec 2000 18:04:09 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
CC: Marcus Meissner <Marcus.Meissner@caldera.de>, linux-kernel@vger.kernel.org
Subject: Re: hotplug mopup
In-Reply-To: <200012101510.QAA29551@ns.caldera.de> from "Marcus Meissner" at Dec 10, 2000 04:10:01 PM <200012110236.eBB2ar7216847@saturn.cs.uml.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Albert D. Cahalan" wrote:
> 
> Marcus Meissner writes:
> 
> >> - On the unregister/removal path, the netdevice layer ensures that
> >>   the interface is removed from the kernel namespace prior to launching
> >>   `/sbin/hotplug net unregister eth0'.
> >>
> >>   This means that when handling netdevice unregistration
> >>   /sbin/hotplug cannot and must not attempt to do anything with eth0!
> >>   Generally it'll fail to find an interface with this name.  If it does
> >>   find eth0, it'll be the wrong one due to a race.
> >
> > I always thought I should have to do "/sbin/ifdown eth0" here.
> > (Just as I do /sbin/ifup eth0 on register.)
> 
> Yes, definitely. Otherwise, how can one replace the eth0 hardware
> without messing up the network settings? This is supposed to be
> hot plug and all... to me that means I can rip out one network
> card and pop in another without breaking my ssh connections.

Let's see...

You pull the card (let's suppose it's Cardbus).  That causes an
interrupt which eventually gets fed to the PCI layer's
pci_remove_device().

The PCI layer calls the netdevice's pci_driver.remove() method.

Typically, xxx_remove() calls unregister_netdevice().

unregister_netdevice() downs the interface, then removes the
netdevice from the kernel namespace and then runs
'/sbin/hotplug net unregister eth0' asynchronously.

When we return from unregister_netdevice() we can guarantee
that the driver's module refcount is zero if this was the
last matching device.

We then wind all the way back to the PCI layer, whizzing gaily
back through the driver whose module refcount is now zero.  Sigh.

The PCI layer runs '/sbin/hotplug pci remove' asynchronously.  The
driver can be unloaded.

So where in all of this can you read the interface's network
settings?  Nowhere, I'm afraid.  They're released in
unregister_netdevice().

Isn't this a userspace tool problem?

-
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
