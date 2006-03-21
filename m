Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751780AbWCUPhi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751780AbWCUPhi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 10:37:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751787AbWCUPhh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 10:37:37 -0500
Received: from gw1.cosmosbay.com ([62.23.185.226]:56548 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP id S1751786AbWCUPhg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 10:37:36 -0500
Message-ID: <44201DAF.7090707@cosmosbay.com>
Date: Tue, 21 Mar 2006 16:37:19 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Jesper Dangaard Brouer <hawk@diku.dk>
CC: Robert Olsson <Robert.Olsson@data.slu.se>, jens.laas@data.slu.se,
       hans.liss@its.uu.se, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: Kernel panic: Route cache, RCU, possibly FIB trie.
References: <Pine.LNX.4.61.0603202234400.27140@ask.diku.dk> <17439.65413.214470.194287@robur.slu.se> <Pine.LNX.4.61.0603211552590.28173@ask.diku.dk>
In-Reply-To: <Pine.LNX.4.61.0603211552590.28173@ask.diku.dk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (gw1.cosmosbay.com [172.16.8.80]); Tue, 21 Mar 2006 16:37:22 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Dangaard Brouer a écrit :
> 
> On Tue, 21 Mar 2006, Robert Olsson wrote:
> 
>> Jesper Dangaard Brouer writes:
>>
>> > I have tried to track down the problem, and I think I have narrowed it
>> > a bit down.  My theory is that it is related to the route cache
>> > (ip_dst_cache) or FIB, which cannot dealloacate route cache slab
>> > elements (maybe RCU related).  (I have seen my route cache increase to
>> > around 520k entries using rtstat, before dying).
>> >
>> > I'm using the FIB trie system/algorithm (CONFIG_IP_FIB_TRIE). Think
>> > that the error might be cause by the "fib_trie" code.  See the syslog,
>> > output below.
>>
>> > Syslog#1 (indicating a problem with the fib trie)
>> > --------
>> > Mar 20 18:00:04 hostname kernel: Debug: sleeping function called 
>> from invalid context at mm/slab.c:2472
>> > Mar 20 18:00:04 hostname kernel: in_atomic():1, irqs_disabled():0
>> > Mar 20 18:00:04 hostname kernel:  [<c0103d9f>] dump_stack+0x1e/0x22
>> > Mar 20 18:00:04 hostname kernel:  [<c011cbe1>] __might_sleep+0xa6/0xae
>> > Mar 20 18:00:04 hostname kernel:  [<c014f3e9>] __kmalloc+0xd9/0xf3
>> > Mar 20 18:00:04 hostname kernel:  [<c014f5a4>] kzalloc+0x23/0x50
>> > Mar 20 18:00:04 hostname kernel:  [<c030ecd1>] tnode_alloc+0x3c/0x82
>> > Mar 20 18:00:04 hostname kernel:  [<c030edf6>] tnode_new+0x26/0x91
>> > Mar 20 18:00:04 hostname kernel:  [<c030f757>] halve+0x43/0x31d
>> > Mar 20 18:00:04 hostname kernel:  [<c030f090>] resize+0x118/0x27e
>>
>> Hello!
>>
>> Out of memory?
> One of the crashed was caused by out of memory, but all the memory was 
> allocated through slab.  More specifically to ip_dst_cache.
> 
>> Running BGP with full routing?
> No, running OSPF with around 760 subnets.
> 
>> And large number of flows.
> Yes, very large number of flows.
> 
>> Whats your normal number of entries route cache?
> On this machine, rigth now, between 14000 to 60000 entries in the route 
> cache.  On other machines, rigth now, I have a max of 151560 entries.
> 
>> And how much memory do you have?
> On this machine 1Gb memory (and 4 others), most of the machines have 2Gb.
> 
> 
>> From your report problems seems to related to flushing either 
>> rt_cache_flush
>> or fib_flush (before there was dev_close()?) so all associated entries 
>> should
>> freed. All the entries are freed via RCU which due to the deferred delete
>> can give a very high transient memory pressure. If we believe it's 
>> memory problem
>> we can try something out...
> 
> There is definitly high memory pressure on this machine!
> Slab memory usage, range from 39Mb to 205Mb (at the moment on the 
> production servers).
> 

Did you tried 2.6.16 ?

It contains changes in kernel/rcupdate.c so that not too many RCU elems are 
queued (force_quiescent_state()). So in the case a rt_cache_flush is done, you 
have the guarantee all entries are not pushed into rcu at once.

Eric
