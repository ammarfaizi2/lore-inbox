Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129764AbQLWHGH>; Sat, 23 Dec 2000 02:06:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129950AbQLWHF5>; Sat, 23 Dec 2000 02:05:57 -0500
Received: from horus.its.uow.edu.au ([130.130.68.25]:22729 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S129764AbQLWHFp>; Sat, 23 Dec 2000 02:05:45 -0500
Message-ID: <3A4448DE.DEE4C43C@uow.edu.au>
Date: Sat, 23 Dec 2000 17:40:30 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: netdevice interface changes in 2.4.0test13pre4ac1
In-Reply-To: <E149VsK-0004w2-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> ...
> 
> 2.4.0test13pre4-ac1
> ...
> o       Fix network register/hotplug/publish problems   (Andrew Morton)

This patch is a step on the way to changing how netdevices are
registered.  It is a significant restructuring which was
basically forced upon us by a bad race condition which the new
hotplug code exposed.  

Alan has applied the core netdevice patch and a set of changes
to the tokenring drivers which make them use the new interface.

There are about eighty drivers which still need to be changed and
I'll be doing these in large lumps.  fc, hippi, ethernet, etc.

I'm determined to get them *all* done, and quickly.  We cannot
just half-do it and leave another back-compatibility layer in
the kernel.

If anyone wants to help (please) then please send the patches
to me so I can maintain them in nice big, orthogonal
easily-backed-out-if-necessary chunks.  Thanks.

Here's a description of the problem, and the interface
changes which were made to address it:




Proposed 2.4 netdevice interface change.
Andrew Morton <andrewm@uow.edu.au>
19 December 2000


     The problem
     ===========

A typical netdevice's probe() function is structured like this:

	int xxx_probe()
	{
		struct net_device *dev = init_etherdev();
		...
		initialise()
		...
		dev->open = xxx_open;
		if (errcode)
			unregister_netdevice(dev);
		return errcode;
	}

The problem is, init_etherdev() calls register_netdevice() and makes
the netdevice available in the kernel namespace before it's ready to be
opened.  Probe routines can easily take tens of milliseconds talking to
slow EEPROMs and MII devices so the window is large.

The problem becomes acute now we are running /sbin/hotplug from within
register_netdevice().  When /sbin/hotplug tries to open the device it
wins the race every time! The device's `open' method is NULL and the
open "succeeds", but the hardware wasn't prepared for operation.  Bad.

Kernel 2.4.0-test12 has a kludge in it (dev_probe_lock) which protects
PCI devices, but that's not a fix.

The big kernel lock accidentally protects us from this race because
it's taken by both sys_init_module() and sys_ioctl().  But if the
probe() routines calls schedule() - and they all can - the BKL is
dropped and we lose.


"Old style" netdevices which statically allocate their struct
net_device are OK.  They do this:

	static struct net_device yyy_dev;

	init_module()
	{
		yyy_dev.init = yyy_probe;
		register_netdev(&yyy_dev);
	}

This works fine because register_netdevice() calls yyy_probe() prior to
registering the device, and register_netdevice() calls /sbin/hotplug
_after_ the call to yyy_probe() and after registering the netdevice.


The tokenring, hippi and fc drivers do quite wierd things in their
initialisation.  This is not described here, but suffice to say that they
are racy and they can be fixed with the proposed new design.



     The fix
     =======

The correct fix is to:

     1): Not make the netdevice visible in the namespace until
         it's ready to accept open()s.

     2): Allocate the netdevice's name ("eth0") early in
         probe(), because drivers like to print it out in diagnostic
         messages.

     2): Not call /sbin/hotplug until the device is registered
         and ready to accept open()s.

     3):  Minimise the amount of changes which are required.

     4): Not break the "Old style" drivers.

     5): Provide easy 2.2 back-compatibility for those drivers
         which support 2.2.

     6): Change ALL the drivers quickly! Don't leave yet
         another back-compatibility layer lying around.

     7): Support a back-compatibility for the duration of the
         netdevice changes.  Perhaps a couple of weeks.

     8): Approximately 83 drivers need to be changed.

     The new interface
     =================

Netdevices gain a new state called "hidden".  A hidden netdevice is not
visible in namespace lookups, but its existence reserves the interface
name to prevent duplicates or races.


We create three new API functions:

     prepare_etherdev(), prepare_trdev(), prepare_fcdev(), etc.

          These are similar to init_etherdev() and friends,
          but the device is created in a hidden state and protocols are
          not notified of the device's existence and /sbin/hotplug is
          not called.

     publish_netdev(struct net_device *dev)

          This is a new API function altogether.  It takes a
          hidden netdevice and "commits" it.  The netdevice is
          unhidden, the protocols are notified of its existence and
          /sbin/hotplug is called.

     withdraw_netdev(struct net_device *dev)

          This reverts the effects of prepare_etherdev() and
          friends.  It's called on the error path and it simply removes
          the hidden netdevice from the device list.  Protocols are not
          notified and /sbin/hotplug is not called.


We retain these:

     register_netdev()

          This function remains in place.  It should only be
          used by "old style" drivers and by virtual devices such as
          the IP/IP driver and the bonding driver.

          register_netdev() registers the device in the
          namespace (unhidden), notifies protocols and runs
          /sbin/hotplug.

     register_netdevice()

          Lower-level form of register_netdev().  The device
          is registered in the namespace and the protocols are
          notified.  /sbin/hotplug is not called.

          This function must be called with the rtnl_lock
          held.  It is typically used by virtual devices such as
          tunnelling protocols and bonding drivers.

          So there is no hotplug notification when one of
          these devices is registered.  Should there be? If so, they
          should use register_netdev().

     unregister_netdev()

          This function remains in place.  Should only be
          called for an unhidden interface.  It closes the device,
          removes the interface from the namespace, notifies protocols
          of the disappearing interface and then calls /sbin/hotplug.

     unregister_netdevice()

          Lower-level form of unregister_netdev().  The
          device is unregistered and then the protocols are notified,
          but /sbin/hotplug is not called.


Additional details on these functions are available in the source in
kernel-doc format.

Note that /sbin/hotplug is never called under the rtnl_lock.  This is
not very important at the time of writing, because /sbin/hotplug is
launched asynchronously.  But it leaves open the option of running
/sbin/hotplug synchronously at some time in the future, which would be
nice.


Doomed functions:

     init_etherdev(), init_trdev(), etc.

          These will remain in existence until all drivers
          are changed.  They will still have the raciness identified
          above.

          They register the device in the namespace
          (unhidden) and notify protocols.  But /sbin/hotplug is NOT
          run for these devices.

          /sbin/hotplug WILL be called when these devices are
          unregistered, however.


Other things:

     #define HAVE_PUBLISH_NETDEV

          This is for 2.2-compatible drivers.  They can do this:

          #ifdef HAVE_PUBLISH_NETDEV
          #define init_etherdev prepare_etherdev
          #define publish_netdev(dev) do {} while (0)
          #define withdraw_netdev unregister_netdev
          #endif

New driver structure:

	int xxx_probe()
	{
-		struct net_device *dev = init_etherdev();
+		struct net_device *dev = prepare_etherdev();
		...
		initialise()
		...
		dev->open = xxx_open;
		if (errcode)
-			unregister_netdevice(dev);
+			withdraw_netdevice(dev);
+		else
+			publish_netdev(dev);
		return errcode;
	}

In other words:

	int xxx_probe()
	{
		struct net_device *dev = prepare_etherdev();
		...
		initialise()
		...
		dev->open = xxx_open;
		if (errcode)
			withdraw_netdevice(dev);
		else
			publish_netdev(dev);
		return errcode;
	}
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
