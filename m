Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262611AbVDYNuf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262611AbVDYNuf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 09:50:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262613AbVDYNuf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 09:50:35 -0400
Received: from unthought.net ([212.97.129.88]:52710 "EHLO unthought.net")
	by vger.kernel.org with ESMTP id S262611AbVDYNuV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 09:50:21 -0400
Date: Mon, 25 Apr 2005 15:50:19 +0200
From: Jakob Oestergaard <jakob@unthought.net>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Greg Banks <gnb@melbourne.sgi.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: bdflush/rpciod high CPU utilization, profile does not make sense
Message-ID: <20050425135019.GW17359@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	Greg Banks <gnb@melbourne.sgi.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20050411144127.GE13369@unthought.net> <1113232905.9962.15.camel@lade.trondhjem.org> <20050411154211.GG13369@unthought.net> <1113267809.1956.242.camel@hole.melbourne.sgi.com> <20050412092843.GB17359@unthought.net> <20050419194515.GP17359@unthought.net> <1113950788.10685.9.camel@lade.trondhjem.org> <20050420135758.GS17359@unthought.net> <20050424071523.GV17359@unthought.net> <1114398598.2874.32.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1114398598.2874.32.camel@lade.trondhjem.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 24, 2005 at 11:09:58PM -0400, Trond Myklebust wrote:
...
> Actually, the most telling difference here is with the random read rates
> which shows up to 1000% difference. I seriously doubt that has much to
> do with lock contention (given that the sequential reads show 20% as you
> said).
> 
> Could you once again have a look at the retransmission rates (both UDP
> and TCP), comparing the SMP and UP cases?

Ok Trond, I've spent the better part of today producing new numbers -
can't say I have anything conclusive, except that
1) 2.4 is a better NFS client for these benchmarks than 2.6, most
   notably wrt. writes
2) Performance over NFS is roughly half of local disk performance

I'm going to just go with the performance I'm seeing as of now, but keep
an eye out for improvements - if you come up with performance related
patches you want tested, I'll be happy to give them a spin.

Numbers etc. follow; in case you're interested - hey, I wasted most of
today producing them, so I might as well send them to the list in case
anyone can use them for anything  ;)



I ran the benchmarks again with UP/SMP, UDP/TCP - I get around 5-20
retransmisssions per second during writes when using UDP mounts,
typically a few retransmissions per second (1-3) during reads when
using UDP mounts, and 0 (zero) retransmissions on TCP mounts. UP/SMP
makes no noticable difference here.

I also tried booting a 2.6.10 (SMP) kernel on the client, and I have
rerun all the benchmarks with considarably larger files (it was stupid
to use 2G test files when both client and server have 2G memory - not
that it makes a huge difference though, but it could explain the
extremely high random read/write rates we saw earlier - these high
random rates have disappeared now that I use 4G files for testing - what
a stupid mistake to make...).

To sum up, I've taken the highes rates seen in each of the tests (not
caring whether the rate was seen with 1, 2 or 4 threads), and written it
all up in the little matrix below here:

When re-testing, it is normal to see +- 5% deviation in the rates.

I did some of the tests with both tg3 and e1000 on the server. The
server did at all times run 2.6.11.6. Numbers are in MiB/sec

   server NIC:    e1000       tg3
--------------- read write read write
2.6.11 up/udp   47   42
2.6.11 up/tcp   38   34
2.6.11 smp/udp  40   35
2.6.11 smp/tcp  34   31
2.6.10 smp/udp  45   39    44 40
2.6.10 smp/tcp  40   33    38 31

And just to make sure 2.4.25 is still alive and kicking: This test was
done on the other client machine (e1000 NIC, dual athlon):

   server NIC:     tg3
--------------- read write
2.4.25 smp/udp  45   52

Finally a local benchmark on the file server, just to see what we can
get taking NFS out of the equation:

----------------- read write
2.6.11 smp/local  76   65


Hope some of this is worth something to someone  ;)

Thanks for all the help and feedback! 

-- 

 / jakob

