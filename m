Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030264AbWCWPlj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030264AbWCWPlj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 10:41:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030266AbWCWPlj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 10:41:39 -0500
Received: from mgw1.diku.dk ([130.225.96.91]:33924 "EHLO mgw1.diku.dk")
	by vger.kernel.org with ESMTP id S1030262AbWCWPlh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 10:41:37 -0500
Date: Thu, 23 Mar 2006 16:35:59 +0100 (CET)
From: Jesper Dangaard Brouer <hawk@diku.dk>
To: "David S. Miller" <davem@davemloft.net>
Cc: dipankar@in.ibm.com, Robert Olsson <Robert.Olsson@data.slu.se>,
       jens.laas@data.slu.se, hans.liss@its.uu.se, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org, Eric Dumazet <dada1@cosmosbay.com>,
       mike.stroyan@hp.com, Suresh Bhogavilli <sbhogavilli@verisign.com>
Subject: Re: Kernel panic: Route cache, RCU, possibly FIB trie.
In-Reply-To: <20060321.132514.24407022.davem@davemloft.net>
Message-ID: <Pine.LNX.4.61.0603231536180.29788@ask.diku.dk>
References: <Pine.LNX.4.61.0603211113550.15500@ask.diku.dk>
 <20060321.023705.26111240.davem@davemloft.net> <Pine.LNX.4.61.0603211538280.28173@ask.diku.dk>
 <20060321.132514.24407022.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 21 Mar 2006, David S. Miller wrote:

> From: Jesper Dangaard Brouer <hawk@diku.dk>
> Date: Tue, 21 Mar 2006 15:51:34 +0100 (CET)
>
>> You guessed right... I did enable IP_ROUTE_MULTIPATH_CACHED, I have
>> now disabled it and equal multi path routing in general
>> (CONFIG_IP_ROUTE_MULTIPATH).
>
> It is almost certainly the cause of your crashes, that code
> is still extremely raw and that's why it is listed as "EXPERIMENTAL".

It seems your are right :-) (and I'll take more care of using experimental 
code on production again). The machine, has now been running for 34 hours 
without crashing.  The strange thing is that I'm running the same kernel 
on 30 other (similar) machines, which have not crashed.  (I do suspect the 
specific traffic load pattern to influence this)


BUT, I do think I have noticed another problem in the garbage collection 
code (route.c), that causes the garbage collector (almost) never to 
garbage collect.

This is caused by the value "ip_rt_max_size" (/proc/sys/net/ipv4/route/max_size)
being set too large.  It is set to 16 times the gc_thresh value (this 
size dependend on the memory size).  In the garbage collection function 
(rt_garbage_collect) garbage collecting entries are ignored (gc_ignored) 
if the number of entries are below "ip_rt_max_size".

With 1Gb memory, gc_thresh=65536 times 16 is 1048576. Which means that we 
only start to garbage collect when there is more than 1 million entries. 
This seems wrong... (the reason it does not grow this large is the 600 
second periodic flushes).


Hilsen
   Jesper Brouer

--
-------------------------------------------------------------------
Cand. scient datalog
Dept. of Computer Science, University of Copenhagen
-------------------------------------------------------------------


grep . /proc/sys/net/ipv4/route/*
/proc/sys/net/ipv4/route/error_burst:5000
/proc/sys/net/ipv4/route/error_cost:1000
grep: /proc/sys/net/ipv4/route/flush: Operation not permitted
/proc/sys/net/ipv4/route/gc_elasticity:8
/proc/sys/net/ipv4/route/gc_interval:60
/proc/sys/net/ipv4/route/gc_min_interval:0
/proc/sys/net/ipv4/route/gc_min_interval_ms:500
/proc/sys/net/ipv4/route/gc_thresh:65536
/proc/sys/net/ipv4/route/gc_timeout:300
/proc/sys/net/ipv4/route/max_delay:10
/proc/sys/net/ipv4/route/max_size:1048576
/proc/sys/net/ipv4/route/min_adv_mss:256
/proc/sys/net/ipv4/route/min_delay:2
/proc/sys/net/ipv4/route/min_pmtu:552
/proc/sys/net/ipv4/route/mtu_expires:600
/proc/sys/net/ipv4/route/redirect_load:20
/proc/sys/net/ipv4/route/redirect_number:9
/proc/sys/net/ipv4/route/redirect_silence:20480
/proc/sys/net/ipv4/route/secret_interval:600

