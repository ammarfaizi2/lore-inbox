Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132662AbQKDJqU>; Sat, 4 Nov 2000 04:46:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132551AbQKDJqK>; Sat, 4 Nov 2000 04:46:10 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:51468 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S131872AbQKDJqH>;
	Sat, 4 Nov 2000 04:46:07 -0500
Message-ID: <3A03DABD.AF4B9AD5@mandrakesoft.com>
Date: Sat, 04 Nov 2000 04:45:33 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.18pre18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Hen, Shmulik" <shmulik.hen@intel.com>
CC: "'LKML'" <linux-kernel@vger.kernel.org>,
        "'LNML'" <linux-net@vger.kernel.org>
Subject: Re: Locking Between User Context and Soft IRQs in 2.4.0
In-Reply-To: <07E6E3B8C072D211AC4100A0C9C5758302B27077@hasmsx52.iil.intel.com>
Content-Type: multipart/mixed;
 boundary="------------DEBF8410F3B308669502F05E"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------DEBF8410F3B308669502F05E
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

"Hen, Shmulik" wrote:
> We are trying to port a network driver from 2.2.x to 2.4.x and have some
> question regarding locks.
> According to the kernel locking HOWTO, we have to take extra care when
> locking between user context threads and BH/tasklet/softIRQ,
> so we learned (the hard way ;-) that when running the ioctl system call from
> an application we should use spin_lock/unlock_bh() and not
> spin_lock/unlock() inside dev->do_ioctl().

That is not necessarily true.  If you have timers or tasklets going,
sure.  I prefer kernel threads for a lot of tasks nowadays, because you
only have two cases for locking -- user and interrupt -- and you can
sleep all you want to in a kernel thread.


> *       What about the other entry points implemented in net_device ?

I wrote the attached doc, after tracing through the code.  It has not
been reviewed yet so it is not canonical, but hopefully it is
informative...


> *       We've got dev->get_stats, dev->set_mac_address,
> dev->set_mutlicast_list and others that are all called from running
> 'ifconfig' which is an application. Are they considered user context too ?

You are inside a spinlock in get_stats, so you cannot sleep.  But you
can sleep in set_multicast_list.  Not sure about set_mac_address.


> *       What about dev->open and dev->stop ?

Sleep all you want, we'll leave the light on for ya.


> *       We figured that dev->hard_start_xmit() and timer callbacks are not
> considered user context, but how can I find out if they are being run as
> SoftIRQ or as tasklets or as Bottom Halves ? (their different definitions
> require different types of protections)

I'm not sure about the context from which hard_start_xmit is called... 
Its inside a spinlock, so you shouldn't be sleeping.  timers are unique
unto themselves... but you lock against them using spin_lock_bh outside
the timer, and spin_lock inside the timer.

> wrap entire operations from top to bottom. For example, our
> dev->hard_start_xmit() will have a spin_lock() at the beginning and a
> spin_unlock() at the end of the function.

Why?  dev->xmit_lock is obtained before dev->hard_start_xmit is called,
and released after it returns.


> *       What about other calls to the kernel ? can the running thread be
> switched out of context when calling kernel entries and not be switched back
> in when they finish ? should I beware of deadlocks in such case ?

You should always beware of deadlocks!

	Jeff


-- 
Jeff Garzik             | Dinner is ready when
Building 1024           | the smoke alarm goes off.
MandrakeSoft            |	-/usr/games/fortune
--------------DEBF8410F3B308669502F05E
Content-Type: text/plain; charset=us-ascii;
 name="netdevices.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="netdevices.txt"



struct net_device synchronization rules
=======================================
dev->open:
	Locking: Inside rtnl_lock() semaphore.
	Sleeping: OK

dev->stop:
	Locking: Inside rtnl_lock() semaphore.
	Sleeping: OK

dev->do_ioctl:
	Locking: Inside rtnl_lock() semaphore.
	Sleeping: OK

dev->get_stats:
	Locking: Inside dev_base_lock spinlock.
	Sleeping: NO

dev->hard_start_xmit:
	Locking: Inside dev->xmit_lock spinlock.
	Sleeping: NO[1]

dev->tx_timeout:
	Locking: Inside dev->xmit_lock spinlock.
	Sleeping: NO[1]

dev->set_multicast_list:
	Locking: Inside dev->xmit_lock spinlock.
	Sleeping: NO[1]


NOTE [1]: On principle, you should not sleep when a spinlock is held.
However, since this spinlock is per-net-device, we only block ourselves
if we sleep, so the effect is mitigated.


--------------DEBF8410F3B308669502F05E--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
