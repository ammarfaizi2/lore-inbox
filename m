Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751771AbWCUP2x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751771AbWCUP2x (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 10:28:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751772AbWCUP2w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 10:28:52 -0500
Received: from mgw1.diku.dk ([130.225.96.91]:58532 "EHLO mgw1.diku.dk")
	by vger.kernel.org with ESMTP id S1751771AbWCUP2v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 10:28:51 -0500
Date: Tue, 21 Mar 2006 16:27:47 +0100 (CET)
From: Jesper Dangaard Brouer <hawk@diku.dk>
To: Robert Olsson <Robert.Olsson@data.slu.se>
Cc: jens.laas@data.slu.se, hans.liss@its.uu.se, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: Kernel panic: Route cache, RCU, possibly FIB trie.
In-Reply-To: <17439.65413.214470.194287@robur.slu.se>
Message-ID: <Pine.LNX.4.61.0603211552590.28173@ask.diku.dk>
References: <Pine.LNX.4.61.0603202234400.27140@ask.diku.dk>
 <17439.65413.214470.194287@robur.slu.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 21 Mar 2006, Robert Olsson wrote:

> Jesper Dangaard Brouer writes:
>
> > I have tried to track down the problem, and I think I have narrowed it
> > a bit down.  My theory is that it is related to the route cache
> > (ip_dst_cache) or FIB, which cannot dealloacate route cache slab
> > elements (maybe RCU related).  (I have seen my route cache increase to
> > around 520k entries using rtstat, before dying).
> >
> > I'm using the FIB trie system/algorithm (CONFIG_IP_FIB_TRIE). Think
> > that the error might be cause by the "fib_trie" code.  See the syslog,
> > output below.
>
> > Syslog#1 (indicating a problem with the fib trie)
> > --------
> > Mar 20 18:00:04 hostname kernel: Debug: sleeping function called from invalid context at mm/slab.c:2472
> > Mar 20 18:00:04 hostname kernel: in_atomic():1, irqs_disabled():0
> > Mar 20 18:00:04 hostname kernel:  [<c0103d9f>] dump_stack+0x1e/0x22
> > Mar 20 18:00:04 hostname kernel:  [<c011cbe1>] __might_sleep+0xa6/0xae
> > Mar 20 18:00:04 hostname kernel:  [<c014f3e9>] __kmalloc+0xd9/0xf3
> > Mar 20 18:00:04 hostname kernel:  [<c014f5a4>] kzalloc+0x23/0x50
> > Mar 20 18:00:04 hostname kernel:  [<c030ecd1>] tnode_alloc+0x3c/0x82
> > Mar 20 18:00:04 hostname kernel:  [<c030edf6>] tnode_new+0x26/0x91
> > Mar 20 18:00:04 hostname kernel:  [<c030f757>] halve+0x43/0x31d
> > Mar 20 18:00:04 hostname kernel:  [<c030f090>] resize+0x118/0x27e
>
> Hello!
>
> Out of memory?
One of the crashed was caused by out of memory, but all the memory was 
allocated through slab.  More specifically to ip_dst_cache.

> Running BGP with full routing?
No, running OSPF with around 760 subnets.

> And large number of flows.
Yes, very large number of flows.

> Whats your normal number of entries route cache?
On this machine, rigth now, between 14000 to 60000 entries in the route 
cache.  On other machines, rigth now, I have a max of 151560 entries.

> And how much memory do you have?
On this machine 1Gb memory (and 4 others), most of the machines have 2Gb.


> From your report problems seems to related to flushing either rt_cache_flush
> or fib_flush (before there was dev_close()?) so all associated entries should
> freed. All the entries are freed via RCU which due to the deferred delete
> can give a very high transient memory pressure. If we believe it's memory problem
> we can try something out...

There is definitly high memory pressure on this machine!
Slab memory usage, range from 39Mb to 205Mb (at the moment on the production servers).

Hilsen
   Jesper Brouer

--
-------------------------------------------------------------------
Cand. scient datalog
Dept. of Computer Science, University of Copenhagen
-------------------------------------------------------------------
