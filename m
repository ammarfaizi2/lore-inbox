Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265840AbSKAXJw>; Fri, 1 Nov 2002 18:09:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265841AbSKAXJw>; Fri, 1 Nov 2002 18:09:52 -0500
Received: from mtao-m01.ehs.aol.com ([64.12.52.73]:48778 "EHLO
	mtao-m01.ehs.aol.com") by vger.kernel.org with ESMTP
	id <S265840AbSKAXJv>; Fri, 1 Nov 2002 18:09:51 -0500
Date: Fri, 01 Nov 2002 15:16:18 -0800
From: John Gardiner Myers <jgmyers@netscape.com>
Subject: Re: Unifying epoll,aio,futexes etc. (What I really want from epoll)
In-reply-to: <20021031154112.GB27801@bjl1.asuk.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-aio@kvack.org, lse-tech@lists.sourceforge.net
Message-id: <3DC30B42.5020904@netscape.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.2b)
 Gecko/20021016
References: <20021031154112.GB27801@bjl1.asuk.net>
 <Pine.LNX.4.44.0210311211160.1562-100000@blue1.dev.mcafeelabs.com>
 <20021031230215.GA29671@bjl1.asuk.net> <3DC1DEFB.6070206@free-market.net>
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew D. Hall wrote:

> *  There is a seemingly significant overhead in performing exactly one 
> callback per event.

The "exactly one callback per event" semantics of aio are important for 
cancellation in thread pool environments.  When you're shutting down a 
connection, you need to be able to get to a point where you know no 
other thread is processing or will process an event for the connection, 
so it is safe to free the connection state.

> *  Only one queue per process or kernel thread.

Having a single thread process multiple queues is not particularly 
interesting (unless you have user-space threads or coroutines).  Being 
able to have different threads in the same process process different 
queues is interesting--it permits a library to set up its own queue, 
using its own threads to process it.

> *  No re-arming events.  They must be manually killed.

Rearming events is a useful way to get the correct cancellation 
semantics in thread pool environments.

> -  Should the kernel attempt to prune the queue of "cancelled" events 
> (hints later deemed irrelevant, untrue, or obsolete by newer events)? 

This makes the cancellation semantics much easier to deal with in single 
threaded event loops.  Single threaded cancellation is difficult in the 
current aio interface because in the case where the canceled operation 
already has an undelivered event in the queue, the canceling code has to 
defer freeing the context until it receives that event.

An additional point: In a thread pool environment, you want event wakeup 
to be in LIFO order and use wake-one semantics.  You also want 
concurrency control: don't deliver an event to a waiting thread if that 
pool does not have fewer threads in runnable state than CPUs.


