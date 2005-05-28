Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261171AbVE1Rto@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261171AbVE1Rto (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 May 2005 13:49:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261172AbVE1Rtn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 May 2005 13:49:43 -0400
Received: from mail.timesys.com ([65.117.135.102]:51040 "EHLO
	exchange.timesys.com") by vger.kernel.org with ESMTP
	id S261171AbVE1Rtl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 May 2005 13:49:41 -0400
Message-ID: <4298AED8.8000408@timesys.com>
Date: Sat, 28 May 2005 13:48:08 -0400
From: john cooper <john.cooper@timesys.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Oleg Nesterov <oleg@tv-sign.ru>
CC: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Olaf Kirch <okir@suse.de>, trond.myklebust@fys.uio.no,
       john cooper <john.cooper@timesys.com>
Subject: Re: RT and Cascade interrupts
References: <42974F08.1C89CF2A@tv-sign.ru> <4297AF39.4070304@timesys.com> <42983135.C521F1C8@tv-sign.ru>
In-Reply-To: <42983135.C521F1C8@tv-sign.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 May 2005 17:43:02.0656 (UTC) FILETIME=[B248B000:01C563AC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov wrote:
> 
> CPU_0						CPU_1
> 
> rpc_release_task(task)
> 						__run_timers:
> 							timer->base = NULL;
> 	rpc_delete_timer()
> 		if (timer->base)
> 			// not taken
> 			del_timer_sync();
> 
> 	mempool_free(task);
> 							timer->function(task):
> 								// task already freed/reused
> 								__rpc_default_timer(task);

Ah ok, I was misreading the above.  Now I see your point.
The race if hit loses the synchronization provided by
del_timer_sync() in my case.  Thanks for being persistent.

The other possibility to fix the original problem within
the scope of the RPC code was to replace the bit state of
RPC_TASK_HAS_TIMER with a count so we don't obscure the
fact the timer was requeued during the preemption window.
This happens as rpc_run_timer() does an unconditional
clear_bit(RPC_TASK_HAS_TIMER,..) before returning.

Another would be to check timer->base/timer_pending()
in rpc_run_timer() and to omit doing a clear_bit()
if the timer is found to have been requeued.

The former has simpler locking requirements but requires
an rpc_task data structure modification.  The latter does
not and is a bit more intuitive but needs additional
locking.  Both appear to provide a solution though I
haven't yet attempted either.

Anyone with more ownership of this code care to comment
on a preferred fix?

-john


-- 
john.cooper@timesys.com
