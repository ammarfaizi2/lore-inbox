Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261425AbVFIXTO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261425AbVFIXTO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 19:19:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262417AbVFIXTN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 19:19:13 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:63221 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261425AbVFIXSy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 19:18:54 -0400
Message-ID: <42A8CE19.1000807@mvista.com>
Date: Thu, 09 Jun 2005 16:17:45 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Trond Myklebust <trond.myklebust@fys.uio.no>
CC: john cooper <john.cooper@timesys.com>, Oleg Nesterov <oleg@tv-sign.ru>,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Olaf Kirch <okir@suse.de>
Subject: Re: RT and Cascade interrupts
References: <42974F08.1C89CF2A@tv-sign.ru> <4297AF39.4070304@timesys.com>	 <42983135.C521F1C8@tv-sign.ru> <4298AED8.8000408@timesys.com>	 <1117312557.10746.6.camel@lade.trondhjem.org>	 <4299332F.6090900@timesys.com>	 <1117352410.10788.29.camel@lade.trondhjem.org>	 <429B8678.1000706@timesys.com> <429DC4A8.BFF69FB3@tv-sign.ru>	 <429DF8DE.7060008@timesys.com>	 <1117650718.10733.65.camel@lade.trondhjem.org>	 <429E0A86.7000507@timesys.com>	 <1117657267.10733.106.camel@lade.trondhjem.org>	 <429E21B8.2070404@timesys.com>	 <1117666319.10822.17.camel@lade.trondhjem.org>	 <429E7D91.9000808@timesys.com> <1117686367.10822.104.camel@lade.trondhjem.org>
In-Reply-To: <1117686367.10822.104.camel@lade.trondhjem.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Excuse me for interrupting this thread, but have you seen:

http://marc.theaimsgroup.com/?l=linux-kernel&m=111717961227508&w=2

I think this will fix your problem.

George
-- 

Trond Myklebust wrote:
> on den 01.06.2005 Klokka 23:31 (-0400) skreiv john cooper:
> 
>>I fully share your frustration of wanting to "use the
>>latest patch -- dammit".  However there are other practical
>>constraints coming into play.  This tree has accumulated a
>>substantial amount of fixes for scheduler violation assertions
>>along with associated testing and has faired well thus far.
>>The bug under discussion here is the last major operational
>>problem found in the associated testing process.  Arriving
>>at this point also required development of target specific
>>driver/board code so a resync to a later version is not a
>>trivial operation.  However it would be justifiable in the
>>case of encountering at an impasse with the current tree.
> 
> 
> My point is that you are considering timer bugs due to synchronization
> problems in code which is obviously not designed to accommodate
> synchronization. Once that fact is established, one moves on and
> considers the code which does support synchronization.
> 
> 
>>>Could you then apply the following debugging patch? It should warn you
>>>in case something happens to corrupt base->running_timer (something
>>>which would screw up del_timer_sync()). I'm not sure that can happen,
>>>but it might be worth checking.
>>
>>Yes, thanks.  Though the event trace does not suggest a
>>reentrance in __run_timer() but rather a preemption of it
>>during the call to rpc_run_timer() by a high priority
>>application task in the midst of an RPC.  The preempting
>>task requeues the timer in the cascade at the tail of
>>xprt_transmit().  rpc_run_timer() upon resuming execution
>>unconditionally clears the RPC_TASK_HAS_TIMER flag.  This
>>creates the inconsistent state.
> 
> 
> There are NO cases where that is supposed to be allowed to occur. This
> case is precisely what del_timer_sync() is supposed to treat.
> 
> 
>>No explicit deletion attempt of the timer (synchronous or
>>otherwise) is coming into play in the failure scenario as
>>witnessed by the event trace.  Rather it is the implicit
>>dequeue of the timer from the cascade in __run_timer() and
>>attempt to track ownership of it in rpc_run_timer() via
>>RPC_TASK_HAS_TIMER which is undermined in the case of
>>preemption.
> 
> 
> No!!! The responsibility for tracking timers that have been dequeued and
> that are currently running inside __run_timer() lies fairly and squarely
> with del_timer_sync().
> There is NOTHING within the RT patches that implies that the existing
> callers of del_timer_sync() should be burdened with having to do
> additional tracking of pending timers. To do so would be a major change
> of the existing API, and would require a lot of justification.
> 
> IOW: nobody but you is claiming that the RPC code is trying to deal with
> this case by tracking RPC_TASK_HAS_TIMER. That is not its purpose, nor
> should it be in the RT case.
> 
> 
>> From earlier mail:
>>
>> > There should be no instances of RPC entering call_transmit() or any
>> > other tk_action callback with a pending timer.
>>
>>My description wasn't clear.  The timeout isn't pending
>>before call_transmit().  Rather the RPC appears to be
>>blocked elsewhere and upon wakeup via __run_timer()/xprt_timer()
>>preempts ksoftirqd and does the __rpc_sleep_on()/__mod_timer()
>>at the very tail of xprt_transmit().
> 
> 
> No!!! How is this supposed to happen? There is only one thread that is
> allowed to call rpc_sleep_on(), and that is the exact same thread that
> is calling __rpc_execute(). It may call rpc_sleep_on() only from inside
> a task->tk_action() call, and therefore only _after_ it has called
> rpc_delete_timer(). There is supposed to be strict ordering here!
> 
> Trond
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/
