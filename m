Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262583AbRENX5h>; Mon, 14 May 2001 19:57:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262587AbRENX52>; Mon, 14 May 2001 19:57:28 -0400
Received: from isis.its.uow.edu.au ([130.130.68.21]:19847 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S262583AbRENX5O>; Mon, 14 May 2001 19:57:14 -0400
Message-ID: <3B006F84.C1427EB3@uow.edu.au>
Date: Tue, 15 May 2001 09:51:32 +1000
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-ac13 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: kuznet@ms2.inr.ac.ru
CC: Jeff Garzik <jgarzik@mandrakesoft.com>, davem@redhat.COM,
        linux-kernel@vger.kernel.org
Subject: Re: NETDEV_CHANGE events when __LINK_STATE_NOCARRIER is modified
In-Reply-To: <3B002001.AEEEE415@mandrakesoft.com> from "Jeff Garzik" at May 14, 1 02:12:17 pm <200105141840.WAA16086@ms2.inr.ac.ru>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kuznet@ms2.inr.ac.ru wrote:
> 
> Hello!
> 
> > Note that using dev->name during probe was always incorrect.  Think
> > about the error case:
> ...
> > So, using interface name in this manner was always buggy because it
> > conveys no useful information to the user.
> 
> I used to think about cases of success. 8)
> In any case the question follows: do we have some another generic
> unique human-readable identifier? Only if device is PCI?
> 
> Actually, I am puzzled mostly with Andrew's note about "simplicity".
> Andrew's patch was evidently much __simpler__ than yours, at least,
> it required one liner for each device and surely was not a "2.5 material".

mmm...  I had to do a bit of mangling in the net core to be able
to "reserve" the netdevice name at init_etherdev() time, but make
it unavailable in namespace lookups.

As Jeff points out, it was an unusual interface - a two-phase
registration where we first reserve the name and then later
either commit it or withdraw it.  That's not the way kernel
normally does things, and it was done that way for back-compatibility,
and to make the device naming prettier.

And yes, it was a 140k patch because it modified about eighty drivers,
pulled out the old interfaces and pulled out dev_probe_lock().

> > I'm all for removing it...  I do not like removing it in a so-called
> > "stable" series, though.  alloc_etherdev() was enough to solve the race
> > and flush out buggy drivers using dev->name during probe.  Notice I did
> > not remove init_etherdev and fix it properly -- IMHO that is 2.5
> > material.
> 
> Nope, guy. Fixing fatal bug is always material of released kernel.
> 
> In any case the question remains: what is the sense of dev_probe_lock now?

It protects the as-yet-unchanged PCI and Cardbus drivers from a
fatal race.

This is not some theoretical race, BTW: as an experiment I put
a simple "schedule()" into vortex_probe1() and it killed the
driver.  Because:

      sys_init_module()
      ->vortex_probe1()
        ->init_etherdev()
	  ->register_netdev()
	    ->/sbin/hotplug  (an asynchronous execve)
	      -> ifconfig eth0 up

ifconfig is executed before vortex_probe1() had fully initialised the
device and the data structures.  The probe takes tens of milliseconds.

The only thing which prevents this race is the fact that sys_init_module()
and sys_ioctl() both do lock_kernel().  If xxx_probe() drops the BKL,
ifconfig gets in there and fails.  Usually, ifconfig finds the driver
has a null ->open() method, so the interface open "succeeds" but the
hardware wasn't opened.  A subsequent ->close() will probably crash
the machine.

That is what dev_probe_lock() is doing today.  It blocks
ifconfig while ->probe() is in progress.  Drivers which
do not use alloc_etherdev() and which can drop the BKL
in probe may fail to work with /sbin/hotplug initialisation
if dev_probe_lock() is removed.  At present that seems to
include acenic, eepro100, pcnet32 and everyone's 3c59x
except mine :)

-
