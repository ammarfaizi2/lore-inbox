Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757532AbWKXAtK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757532AbWKXAtK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 19:49:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757531AbWKXAtJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 19:49:09 -0500
Received: from gw1.cosmosbay.com ([86.65.150.130]:16513 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP id S1757527AbWKXAtG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 19:49:06 -0500
Message-ID: <45664160.6060504@cosmosbay.com>
Date: Fri, 24 Nov 2006 01:48:32 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
MIME-Version: 1.0
To: Ulrich Drepper <drepper@redhat.com>
CC: Jeff Garzik <jeff@garzik.org>, Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       David Miller <davem@davemloft.net>, Andrew Morton <akpm@osdl.org>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>, linux-kernel@vger.kernel.org
Subject: Re: [take25 1/6] kevent: Description.
References: <11641265982190@2ka.mipt.ru> <456621AC.7000009@redhat.com> <45662522.9090101@garzik.org> <45663298.7000108@redhat.com>
In-Reply-To: <45663298.7000108@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (gw1.cosmosbay.com [86.65.150.130]); Fri, 24 Nov 2006 01:48:21 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich Drepper a écrit :
> 
> You create worker threads to handle to work for the entire program. Look 
> at something like a web server.  When creating several queues, how do 
> you distribute all the connections to the different queues?  To ensure 
> every connection is handled as quickly as possible you stuff them all in 
> the same queue and then have all threads use this one queue. Whenever an 
> event is posted a thread is woken.  _One_ thread.  If two events are 
> posted, two threads are woken.  In this situation we have a few atomic 
> ops at userlevel to make sure that the two threads don't pick the same 
> event but that's all there is wrt "fighting".
> 
> The alternative is the sorry state we have now.  In nscd, for instance, 
> we have one single thread waiting for incoming connections and it then 
> has to wake up a worker thread to handle the processing.  This is done 
> because we cannot "park" all threads in the accept() call since when a 
> new connection is announced _all_ the threads are woken.  With the new 
> event handling this wouldn't be the case, one thread only is woken and 
> we don't have to wake worker threads.  All threads can be worker threads.

Having one specialized thread handling the distribution of work to worker 
threads is better most of the time. This thread can be a worker thread by 
itself (to avoid context switchs), but can decide to wake up 'slave threads' 
if he believes it has too (for example if he can notice that a *lot* of 
requests are pending)

This is because with moderate load, it's better to have only one CPU running 
80% of its time, keeping its cache hot, than 'distribute' the work on four 
CPU, that would be used 25% of their time, but with lot of cache line ping 
pongs and poor cache reuse.

If you let 'kevent'/'dumb kernel dispatcher'/'futex'/'whatever' decide to wake 
up one thread for each new event, you *may* have lower performance, because of 
higher system overhead (system means : system scheduler/internals, but also 
bus trafic)
  Only the application writer can have a clue of average use of its worker 
threads, and can decide to dynamically adjust parameters if needed to handle 
load spikes.

SMP machines are nice, but for many workloads, it's better to avoid spreading 
a working set on several CPUS that fight for common resources (memory).


Back to 'kevent':
-----------------
I think that having a syscall to commit events should not be mandatory. A 
syscall is needed only to wait for new events if the ring is empty. But then 
maybe we dont need yet a new syscall to perform a wait :
We already have nice synchronisations primitives (futex for example).

User program should be able to update a 'uidx' in user space (using atomic ops 
only if multi-threaded), and could just use futex infrastructure if ring 
buffer is empty (uidx == kidx) , and call FUTEX_WAIT( &kidx, current value = uidx)

I think I already gave my opinion on a ring buffer, but let just rephrase it :

One part should be read/write for application (to be able to change uidx)
(or User app just give at init time to kernel the address of a futex in its vm 
space)

One part could be read only for application (but could be read/write : we dont 
care if user application is stupid) : kernel writes its kidx (or a copy of it) 
and events.

For best performance, uidx and kidx should be on different cache lines (basic 
isolation of producer / consumer)

When kernel wants to queue a new event in a ring buffer it can :

See if user program did consume some events since last invocation (kernel 
fetches uidx and compare it with its own uidx value : no syscall needed)
Check if a slot is available in ring buffer.
Copy the event in ring buffer, perform a memory barrier, then increment kidx.
call futex_wake(&kidx, 1 thread)

User application is free to have one thread/process or several 
threads/processes waiting for new events (or even no thread at all :) )

Eric

