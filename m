Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S154158AbQBJBBL>; Wed, 9 Feb 2000 20:01:11 -0500
Received: by vger.rutgers.edu id <S154074AbQBJBBD>; Wed, 9 Feb 2000 20:01:03 -0500
Received: from [216.101.162.242] ([216.101.162.242]:33140 "EHLO pizda.ninka.net") by vger.rutgers.edu with ESMTP id <S154167AbQBJBAk>; Wed, 9 Feb 2000 20:00:40 -0500
Date: Wed, 9 Feb 2000 21:16:12 -0800
Message-Id: <200002100516.VAA02967@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.rutgers.edu
Subject: New network driver interface changes, README
Sender: owner-linux-kernel@vger.rutgers.edu


	Hello folks.  A major interface change for the networking
drivers just occurred in 2.3.43-7 and at the request of Linus I'm
going to post here a brief description of what needs to be done to
fix up the drivers which are still not fixed.  This is all for the
better, and it's going to expose (and fix) a lot of bugs drivers
have now, and simplify them as well.

1) The tbusy, start, and interrupt members are now gone.
   They are replaced with clean interfaces which do the
   queueing/state work these members use to be used for.

   Many drivers manipulated them incorrectly, many used
   them internally for state tracking, etc.  And deleting
   these members forces people to fix the drivers and also
   abstracts out the operations so we can modify the network
   packet queueing implementation without changing all the drivers in
   the future should a change in the implementation be needed.

2) dev->tbusy conversions:

	Here are the basic transformations for fix up a driver's
	dev->tbusy references:

	Old way				New way

	dev->tbusy = 1;			netif_stop_queue(dev);

	dev->tbusy = 0;			netif_start_queue(dev);

	dev->tbusy = 0;			netif_wake_queue(dev);
	mark_bh(NET_BH);

	The on/off state of the tx queue is held in the
	state bit LINK_STATE_XOFF of dev->flags.  So you
	may explicitly query it with:

		test_bit(LINK_STATE_XOFF, &dev->flags);

	You absolutely may _NOT_ modify this bit with
	{set,clear,change}_bit().  You must go through the
	netif_*_queue() interfaces to make such a state
	change.

3) dev->start

	It is now represented by the LINK_STATE_START
	bit flag in dev->start, and you may query it.
	For example:

	  if (dev->start)

	becomes:

	  if (test_bit(LINK_STATE_START, &dev->state))

	Drivers are _HIGHLY_ encouraged not to mess with it's
	setting.  Drivers should only test it, the generic
	device up/down/config infrastructure sets it properly
	for you.

	For example, in many drivers there is a "dev->start = 1"
	line in the dev->open() method.  Remove it, it is wrong
	and it will be set for you by the generic network device
	layer when it invokes you.

4) dev->interrupt

	First, just delete all references to it from your driver.

	Some tried to use it as an SMP locking mechanism,
	most if not all did it incorrectly.  If you need
	internal locking in your driver, use your device
	private structure to hold spinlocks and other
	correct locking primitives needed to achieve this.

5) dev->hard_start_xmit()

	Some drivers assumed it was hw IRQ protected, some
	didn't, etc.  Massive disagreement.

	Now it is stated, this method is protected from
	re-entrancy via a dev->xmit_lock which is grabbed
	by the caller, you need not and should not make
	any refernece to this lock.

	This method will be called with local _software_
	interrupts disabled.  If you need local hw IRQs
	disabled or spinlocks on SMP to synchronize with
	the TX handling in your driver IRQ handler, you
	must do this yourself.

	And furthermore, by implication this method being
	called means that LINK_STATE_XOFF is _NOT_ set
	and the queue is on.

	This last point means that you should remove the
	"TX timeout" detection garbage from these methods
	in the driver.  Which leads me to #6.

6) TX timeouts are explicitly handled for you, you just
   need to provide a dev->tx_timeout handler and the
   timeout value you'd like the generic networking to use.

   The type of this method is:

	void my_driver_timeout(struct net_device *dev)

   It should make note of the timeout, try to unstuck
   the hardware, and if this process unblocks the
   transmit queue, you should call netif_wake_queue(dev)
   before returning.

   Set this up at driver init time like so:

	dev->tx_timeout = my_driver_timeout;
	dev->watchdog_timeo = TX_TIMEOUT;

I've begun to try to shape up the drivers/net/skeleton.c example
driver file to show how these mechanisms are meant to be used.

I would suggest that for more information folks look in there.
For most common cards which have a "TX descriptor ring of transmit
buffers" scheme, you want to pay particular attention to the
"#if TX_RING" sections.

You can also look at the changes made to several of the already
converted drivers to get even more of a feel of how things need
to be adjusted/fixed.  Personally I've done the most testing
with the sunhme.c driver.

Later,
David S. Miller
davem@redhat.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
