Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131111AbRCGXOI>; Wed, 7 Mar 2001 18:14:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131198AbRCGXN6>; Wed, 7 Mar 2001 18:13:58 -0500
Received: from horus.its.uow.edu.au ([130.130.68.25]:20879 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S131111AbRCGXNp>; Wed, 7 Mar 2001 18:13:45 -0500
Message-ID: <3AA6C080.99D35298@uow.edu.au>
Date: Wed, 07 Mar 2001 23:13:04 +0000
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.61 [en] (X11; I; Linux 2.4.1-pre10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@mandrakesoft.com>
CC: Linux Knernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>, Alan Cox <alan@redhat.com>,
        "David S. Miller" <davem@redhat.com>, netdev@oss.sgi.com,
        Arjan van de Ven <arjan@fenrus.demon.nl>
Subject: Re: [PATCH] RFC: fix ethernet device initialization
In-Reply-To: <3AA6A570.57FF2D36@mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> 
> People from time to time point out a wart in ethernet initialization:
> 

They sure do.  You were away at the time, but I had a 94 file,
140k patch late last year which fixed all this.  It's
at

	http://www.uow.edu.au/~andrewm/linux/netdevice.patch

and the design doc is at

	http://www.uow.edu.au/~andrewm/linux/netdevice2.txt

>From a quick look, I think the only substantive difference
here is that my `prepare_etherdev()' function allocates
and reserves the device's name (eth0), but prevents it
from being available in netdevice namespace lookups.  This
was done because lots of drivers wanted to do:

	init_etherdev();	(Replaced with prepare_etherdev())
	printk("%s: something", dev->name);

The changes to dev.c and net_init.c were fairly subtle
and took some thinking about - we should revisit them
if you want to go ahead with this.

The patch all worked OK, was back-compatible with unaltered
drivers, and indeed altered all the drivers.  But it kind of
got lost.  Too big, too late and dev_probe_lock() was there.

Now, Arjan says that this race is causing oopses.  This
surprises me, because current kernels have the the dev_probe_lock()
hack which I put in.  This fixes the problem for PCI and Cardbus
drivers. The ISA drivers generally use the dev->init() technique
which is not racy.  There isn't a lot left over.  Arjan?  Which driver?

The other reason I'm surprised that it's causing oopses: most
racy drivers do this:

xxx_probe()
{
	init_etherdev();
	<initialisation - takes 10s of milliseconds and can sleep>
	dev->open = xxx_open;
	return;
}

So the vastly most probably failure mode if the race occurs 
is this: the interface is opened while dev->open is NULL.
This won't oops.  Sure, the interface is screwed because
the open() routine hasn't been called, but it should hang
in there.  A subsequent close() of the interface *will*
call dev->close, and I guess the driver is likely to get
upset if its close() routine is called without a corresponding
open().

Yes, we can fix this if we want, and kill off dev_probe_lock().
It'll only take a few days.  Do we want?  If not, we can
extend the dev_probe_lock() thing to cover probes for
other busses.  USB, I guess.


-
