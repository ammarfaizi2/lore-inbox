Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262563AbTC0NVD>; Thu, 27 Mar 2003 08:21:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262553AbTC0NVC>; Thu, 27 Mar 2003 08:21:02 -0500
Received: from fmr01.intel.com ([192.55.52.18]:20942 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S262551AbTC0NUz> convert rfc822-to-8bit;
	Thu, 27 Mar 2003 08:20:55 -0500
Date: Thu, 27 Mar 2003 15:32:02 +0200 (IST)
From: shmulik.hen@intel.com
X-X-Sender: hshmulik@jrslxjul4.npdj.intel.com
Reply-To: shmulik.hen@intel.com
To: Dan Eble <dane@aiinet.com>,
       bond-devel <bonding-devel@lists.sourceforge.net>,
       bond-announce <bonding-announce@lists.sourceforge.net>,
       linux-netdev <netdev@oss.sgi.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-net <linux-net@vger.kernel.org>
Subject: Re: BUG or not? GFP_KERNEL with interrupts disabled.
In-Reply-To: <E791C176A6139242A988ABA8B3D9B38A01085638@hasmsx403.iil.intel.com>
Message-ID: <Pine.LNX.4.44.0303271406230.7106-100000@jrslxjul4.npdj.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Further more, holding a lock_irq doesn't mean bottom halves are disabled
too, it just means interrupts are disabled and no *new* softirq can be
queued. Consider the following situation:

In bond_release() we hold write_lock_irqsave(&bond->lock, flags) and then
do all the releasing stuff. If, for example, we need to call
dev_mc_upload() for the released slave, the following will happen

        spin_lock_bh(&dev->xmit_lock);
        __dev_mc_upload(dev);
        spin_unlock_bh(&dev->xmit_lock);

spin_unlock_bh() calls local_bh_enable() which checks local_bh_count. If
local_bh_count reaches zero (and it does), it directly executes
do_softirq(). The check for in_interrupt() in do_softirq() is false and
the softirqs that were queued begin to run and process the Tx and Rx
backlogs. dev_queue_xmit() is called on the bond device which calls, lets
say, bond_xmit_xor(). The first thing bond_xmit_xor() does is try to grab
read_lock_irqsave(&bond->lock, flags). Since this lock is already held by
bond_release(), and we're on the same cpu without any context switch,
we've got ourselves a deadlock. This actually happened to us and it took us
a while to figure the system halt, but we've got the kdb trace to prove
it.

Specifically for bonding, as stated by Dan below, it is indeed not
necessary to hold a lock_irq in every entry point in the driver. From our
experience in previous projects, we discovered that it is sufficient to
just grab a read_lock when accessing the slaves list in any softirq level
function (receive, transmit and timer), and hold a write_lock_bh() only
when changing the slaves list in ioctl calls like bond_enslave(),
bond_release(), bond_release_all() which all run at user context.

We have created a version that uses the above scheme that is being tested
by our QA group these days. Such a major change in the locking scheme
requires allot of testing to try and detect potential hidden bugs and
corner cases. We expect this will also increase the total throughput,
since interrupts won't be blocked each time a packet is being transmitted
or the miimon timer pops. We believe we will be able to post the patch
(+results) next week.


On Tue, 25 Mar 2003, Dan Eble wrote:
> 
> (kernel is ppc 2.4.21-pre4)
> 
> In bond_enslave() [drivers/net/bonding.c]:
> 
>         write_lock_irqsave(&bond->lock, flags);
>         ...
>         err = netdev_set_master(slave_dev, master_dev);
>         ...
>         write_unlock_irqrestore(&bond->lock, flags);
> 
> In netdev_set_master() [net/core/dev.c]:
> 
>         rtmsg_ifinfo(RTM_NEWLINK, slave, IFF_SLAVE);
> 
> In rtmsg_ifinfo() [net/core/rtnetlink.c]:
> 
>         skb = alloc_skb(size, GFP_KERNEL);
>         ...
>         netlink_broadcast(rtnl, skb, 0, RTMGRP_LINK, GFP_KERNEL);
> 
> Doesn't this admit the possibility of sleeping with interrupts disabled? 
> I found it because I'm working on a driver that uses a master-slave
> relationship like the bonding driver, and decided I didn't really need to
> disable interrupts, so I tried using write_lock_bh()  instead.  The
> result
> was an "alloc_skb called nonatomically from interrupt" message because
> write_lock_bh() increments the local BH count (which seems reasonable).
> 
> A bigger question: Why are the IRQ check and the BH check inconsistent?
> That is, local_bh_count() says "yes" if you are currently running in BH
> context OR have disabled BHs; however, local_irq_count() says "yes" if
> you
> are currently running in interrupt context, but it says nothing (as far
> as
> I have seen) about whether IRQs are enabled or disabled.  Is this (a) the
> Right Way, (b) something that's more trouble to fix than to be burned-by
> once and then avoid for the rest of your life, or (c) totally horked?
> 
> --
> Dan Eble <dane@aiinet.com>  _____  .
>                            |  _  |/|
> Applied Innovation Inc.    | |_| | |
> http://www.aiinet.com/     |__/|_|_|
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-net" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> 

-- 
| Shmulik Hen                                    |
| Israel Design Center (Jerusalem)               |
| LAN Access Division                            |
| Intel Communications Group, Intel corp.        |


