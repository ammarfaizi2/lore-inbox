Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263087AbTCLIM2>; Wed, 12 Mar 2003 03:12:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263088AbTCLIM1>; Wed, 12 Mar 2003 03:12:27 -0500
Received: from blackbird.intercode.com.au ([203.32.101.10]:45580 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id <S263087AbTCLIMW>; Wed, 12 Mar 2003 03:12:22 -0500
Date: Wed, 12 Mar 2003 19:22:53 +1100 (EST)
From: James Morris <jmorris@intercode.com.au>
To: Dawson Engler <engler@csl.stanford.edu>
cc: linux-kernel@vger.kernel.org, <mc@cs.stanford.edu>
Subject: Re: [CHECKER] more potential deadlocks
In-Reply-To: <200303050739.h257dae32460@csl.stanford.edu>
Message-ID: <Pine.LNX.4.44.0303121910090.5320-100000@blackbird.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Mar 2003, Dawson Engler wrote:

> --------------------------------------------------
> BUG?  but might be that the two different head pointers cannot point to
>       the same object.  not clear alias analysis will actually help here
>       since things are so hairy.
> 
> ERROR: 1 thread deadlock.
>    <&tw_death_lock>-><struct tcp_bind_hashbucket.lock (<local>:0)> occurred 1 times
>    <struct tcp_bind_hashbucket.lock (<local>:0)>-><&tw_death_lock> occurred 1 times

Not a bug.  The call chain is invalid:

> 	   ->/u2/engler/mc/oses/linux/linux-2.5.62/net/ipv4/tcp_ipv4.c:tcp_v4_hash_connect:683
> 	   ->/u2/engler/mc/oses/linux/linux-2.5.62/net/ipv4/tcp_ipv4.c:tcp_v4_hash_connect:694
> 	   ->/u2/engler/mc/oses/linux/linux-2.5.62/net/ipv4/tcp_ipv4.c:__tcp_v4_check_established:561
> 	   ->/u2/engler/mc/oses/linux/linux-2.5.62/net/ipv4/tcp_ipv4.c:__tcp_v4_check_established:622
> 	   ->/u2/engler/mc/oses/linux/linux-2.5.62/net/ipv4/tcp_ipv4.c:__tcp_v4_check_established:629
> 	   ->end=/u2/engler/mc/oses/linux/linux-2.5.62/net/ipv4/tcp_minisocks.c:tcp_tw_deschedule:481

The call to __tcp_v4_check_established() at line 694 takes a &tw paramater
which cannot be null.  This means that the call to tcp_tw_deschedule() at
line 629 will not happen and tw_death_lock is thus not taken on this path
while also holding a tcp_bind_hashbucket.lock.

If the caller provides a &tw param, a time-wait bucket (if found) is
returned via it to be destroyed outside the hash bucket lock.

> BUG: seems like it, if they can point to the same thing.  ERROR: 1 thread deadlock.
>    <struct in_device.lock (<local>:0)>-><struct ip_mc_list.lock (<local>:0)> occurred 5 times
>    <struct ip_mc_list.lock (<local>:0)>-><struct in_device.lock (<local>:0)> occurred 5 times

See below.

> BUG? very hard to follow, but interesting if a real bug.  unfortunately,
> could also be a false positive because of 
> 	1. infeasible callchain path or 
> 
> 	2. the various in_dev and im pointers never actually point to
> 	   the same object.
> 
> requires three threads: 
> 	thread 1: acquires im->lock then tries to get inetdev_lock
> 	thread 2: acquires inetdev_lock and tries to get in_dev->lock.
> 	thread 3: acquires in_dev->lock and tries to get im->lock.
> 
> ERROR: 2 thread deadlock.
>    <struct ip_mc_list.lock (<local>:0)>-><&inetdev_lock> occurred 5 times
>    <&inetdev_lock>-><struct ip_mc_list.lock (<local>:0)> occurred 4 times

These are indeed potential deadlock cases, caused by holding im->lock for
too long, now fixed by Alexey (in 2.5 bk at least).


- James
-- 
James Morris
<jmorris@intercode.com.au>



