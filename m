Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261302AbVFBDdN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261302AbVFBDdN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 23:33:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261331AbVFBDdN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 23:33:13 -0400
Received: from mail.timesys.com ([65.117.135.102]:50477 "EHLO
	exchange.timesys.com") by vger.kernel.org with ESMTP
	id S261302AbVFBDdE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 23:33:04 -0400
Message-ID: <429E7D91.9000808@timesys.com>
Date: Wed, 01 Jun 2005 23:31:29 -0400
From: john cooper <john.cooper@timesys.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Trond Myklebust <trond.myklebust@fys.uio.no>
CC: Oleg Nesterov <oleg@tv-sign.ru>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>, Olaf Kirch <okir@suse.de>,
       john cooper <john.cooper@timesys.com>
Subject: Re: RT and Cascade interrupts
References: <42974F08.1C89CF2A@tv-sign.ru> <4297AF39.4070304@timesys.com>	 <42983135.C521F1C8@tv-sign.ru> <4298AED8.8000408@timesys.com>	 <1117312557.10746.6.camel@lade.trondhjem.org>	 <4299332F.6090900@timesys.com>	 <1117352410.10788.29.camel@lade.trondhjem.org>	 <429B8678.1000706@timesys.com> <429DC4A8.BFF69FB3@tv-sign.ru>	 <429DF8DE.7060008@timesys.com>	 <1117650718.10733.65.camel@lade.trondhjem.org>	 <429E0A86.7000507@timesys.com>	 <1117657267.10733.106.camel@lade.trondhjem.org>	 <429E21B8.2070404@timesys.com> <1117666319.10822.17.camel@lade.trondhjem.org>
In-Reply-To: <1117666319.10822.17.camel@lade.trondhjem.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 Jun 2005 03:26:16.0656 (UTC) FILETIME=[D5FC5500:01C56722]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust wrote:
> on den 01.06.2005 Klokka 16:59 (-0400) skreiv john cooper:
> 
>>Yes later versions of the patch do.  The version at hand
>>40-04 is based on 2.6.11.  We intend to sync-up with a
>>more recent version of the RT patch pending resolution
>>of this issue.
> 
> 
> Well it is pointless to concentrate on an obviously buggy patch. Could
> you please sync up to rc5-rt-V0.7.47-15 at least: that looks like it
> might be working (or at least be close to working).

I fully share your frustration of wanting to "use the
latest patch -- dammit".  However there are other practical
constraints coming into play.  This tree has accumulated a
substantial amount of fixes for scheduler violation assertions
along with associated testing and has faired well thus far.
The bug under discussion here is the last major operational
problem found in the associated testing process.  Arriving
at this point also required development of target specific
driver/board code so a resync to a later version is not a
trivial operation.  However it would be justifiable in the
case of encountering at an impasse with the current tree.

> Could you then apply the following debugging patch? It should warn you
> in case something happens to corrupt base->running_timer (something
> which would screw up del_timer_sync()). I'm not sure that can happen,
> but it might be worth checking.

Yes, thanks.  Though the event trace does not suggest a
reentrance in __run_timer() but rather a preemption of it
during the call to rpc_run_timer() by a high priority
application task in the midst of an RPC.  The preempting
task requeues the timer in the cascade at the tail of
xprt_transmit().  rpc_run_timer() upon resuming execution
unconditionally clears the RPC_TASK_HAS_TIMER flag.  This
creates the inconsistent state.

No explicit deletion attempt of the timer (synchronous or
otherwise) is coming into play in the failure scenario as
witnessed by the event trace.  Rather it is the implicit
dequeue of the timer from the cascade in __run_timer() and
attempt to track ownership of it in rpc_run_timer() via
RPC_TASK_HAS_TIMER which is undermined in the case of
preemption.

 From earlier mail:

 > There should be no instances of RPC entering call_transmit() or any
 > other tk_action callback with a pending timer.

My description wasn't clear.  The timeout isn't pending
before call_transmit().  Rather the RPC appears to be
blocked elsewhere and upon wakeup via __run_timer()/xprt_timer()
preempts ksoftirqd and does the __rpc_sleep_on()/__mod_timer()
at the very tail of xprt_transmit().

I have work-arounds which detect the preemption of
rpc_run_timer() and correct the timer state.  But I
don't suggest they are general solutions or a
permanent fix.

In any case I will ascertain whether or not the problem here
still exists as soon as possible upon resync with a current
tree.

-john


-- 
john.cooper@timesys.com
