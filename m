Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264962AbSKJRHS>; Sun, 10 Nov 2002 12:07:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264967AbSKJRHS>; Sun, 10 Nov 2002 12:07:18 -0500
Received: from packet.digeo.com ([12.110.80.53]:48833 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S264962AbSKJRHN>;
	Sun, 10 Nov 2002 12:07:13 -0500
Message-ID: <3DCE93CF.79AF516C@digeo.com>
Date: Sun, 10 Nov 2002 09:13:51 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Miquel van Smoorenburg <miquels@cistron.nl>,
       "David S. Miller" <davem@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.46: kernel BUG at kernel/timer.c:333!
References: <aqj8bf$ff2$1@ncc1701.cistron.net> <3DCD5917.FEEA7C5D@digeo.com> <20021110153236.A18563@cistron.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Nov 2002 17:13:51.0815 (UTC) FILETIME=[8A880D70:01C288DC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miquel van Smoorenburg wrote:
> 
> According to Andrew Morton:
> > Miquel van Smoorenburg wrote:
> > > I can reliably crash 2.5.X on one of our newsservers (dual PIII/450, GigE,
> > > lots of disk- and network I/O).
> > >
> > > kernel BUG at kernel/timer.c:333!
> >
> > There are timer fixes in Linus's current tree.  The problem which
> > they address could cause this BUG.
> 
> I've booted 2.5.46bk5 on the machine, and it has been running for over
> 2 hours with extra heavy diskio. That reliably crashed the machine
> in about 45 minutes with 2.4.45 and 2.5.46, machine is still up now.

OK, thanks.

> 
> I'm still seeing the buffer layer error at fs/buffer.c:1623,
> though. Happens when a blockdev is close()d. Is a fix for
> this in -mm2? Does -mm2 include -bk5 ?  If so I'll put that
> on it and keep an eye on it tomorrow, see what happens.

This is a blockdev which was under mmap(), yes?  No, I haven't looked at
that yet.  It'll be a matter of just killing the warning.

mmapping a blockdev is a pretty dopey thing to do, btw.  It doesn't
allow the use of highmem, the IO uses tiny BIOs (in fact I think
it uses 512-byte or 1k blocksize too) and there are buffer_heads
all over the place.  You'll get better results from mmapping a
regular file.
 
> Debug messages I'm still seeing:
> (note that I compiled IPv6 into the kernel since we're slowly moving
> our network to IPv6 but that it is otherwise unused right now, and
> that the previous kernels that crashed on me didn't have IPv6 in it)
> 
> Uninitialised timer!
> This is just a warning.  Your computer is OK
> function=0xc0285748, data=0xf78a6680
> Call Trace:
>  [<c0122610>] check_timer_failed+0x40/0x54
>  [<c0285748>] igmp6_timer_handler+0x0/0x58
>  [<c0122b12>] del_timer+0x16/0x84
>  [<c02855d8>] igmp6_join_group+0x94/0x124

I missed one there.


--- 25/net/ipv6/mcast.c~ip6-mcast-timer	Sun Nov 10 09:12:28 2002
+++ 25-akpm/net/ipv6/mcast.c	Sun Nov 10 09:12:44 2002
@@ -296,6 +296,7 @@ int ipv6_dev_mc_inc(struct net_device *d
 	}
 
 	memset(mc, 0, sizeof(struct ifmcaddr6));
+	init_timer(&mc->mca_timer);
 	mc->mca_timer.function = igmp6_timer_handler;
 	mc->mca_timer.data = (unsigned long) mc;
 

_
