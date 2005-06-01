Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261247AbVFATY7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261247AbVFATY7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 15:24:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261155AbVFATYw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 15:24:52 -0400
Received: from mail.timesys.com ([65.117.135.102]:856 "EHLO
	exchange.timesys.com") by vger.kernel.org with ESMTP
	id S261247AbVFATWV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 15:22:21 -0400
Message-ID: <429E0A86.7000507@timesys.com>
Date: Wed, 01 Jun 2005 15:20:38 -0400
From: john cooper <john.cooper@timesys.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Trond Myklebust <trond.myklebust@fys.uio.no>
CC: Oleg Nesterov <oleg@tv-sign.ru>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>, Olaf Kirch <okir@suse.de>,
       john cooper <john.cooper@timesys.com>
Subject: Re: RT and Cascade interrupts
References: <42974F08.1C89CF2A@tv-sign.ru> <4297AF39.4070304@timesys.com>	 <42983135.C521F1C8@tv-sign.ru> <4298AED8.8000408@timesys.com>	 <1117312557.10746.6.camel@lade.trondhjem.org>	 <4299332F.6090900@timesys.com>	 <1117352410.10788.29.camel@lade.trondhjem.org>	 <429B8678.1000706@timesys.com> <429DC4A8.BFF69FB3@tv-sign.ru>	 <429DF8DE.7060008@timesys.com> <1117650718.10733.65.camel@lade.trondhjem.org>
In-Reply-To: <1117650718.10733.65.camel@lade.trondhjem.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 01 Jun 2005 19:15:33.0984 (UTC) FILETIME=[48C91E00:01C566DE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust wrote:
> on den 01.06.2005 Klokka 14:05 (-0400) skreiv john cooper:
>>I don't see how this would imply a kernel/timer.c
>>problem.  It also appears this wouldn't be causing
>>the timer cascade corruption I've seen as the
>>end result is deleting an already dequeued timer
>>which is safe here.
> 
> 
> If timer->base==NULL, then del_timer() returns 0 (as you correctly state
> above). What you appear to be missing is that this will trigger a call
> to del_timer_sync() inside del_singleshot_timer_sync().

You might have missed in my earlier mail as
this is a not an MP kernel ie: !CONFIG_SMP
The synchronous timer delete primitives don't
exist in this configuration:

include/linux/timer.h:

#ifdef CONFIG_SMP
   extern int del_timer_sync(struct timer_list *timer);
   extern int del_singleshot_timer_sync(struct timer_list *timer);
#else
# define del_timer_sync(t) del_timer(t)
# define del_singleshot_timer_sync(t) del_timer(t)
#endif

BTW, I don't know if you happened on the mail I sent
yesterday.  It details rpc_run_timer() waking up an
application task blocked in call_transmit().  The
app task preempts ksoftirqd and eventually does a
__rpc_sleep_on()/__mod_timer() which requeues the
timer in the cascade.  When ksoftirqd/rpc_run_timer()
resumes RPC_TASK_HAS_TIMER is unconditionally cleared
however the timer is queued in the cascade.  This
appears to be at least one cause of the timer cascade
corruption I've seen.

-john


-- 
john.cooper@timesys.com
