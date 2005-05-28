Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261186AbVE1WRv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261186AbVE1WRv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 May 2005 18:17:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261187AbVE1WRv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 May 2005 18:17:51 -0400
Received: from pat.uio.no ([129.240.130.16]:61586 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S261186AbVE1WRs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 May 2005 18:17:48 -0400
Subject: Re: RT and Cascade interrupts
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: john cooper <john.cooper@timesys.com>
Cc: Oleg Nesterov <oleg@tv-sign.ru>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>, Olaf Kirch <okir@suse.de>
In-Reply-To: <4298AED8.8000408@timesys.com>
References: <42974F08.1C89CF2A@tv-sign.ru> <4297AF39.4070304@timesys.com>
	 <42983135.C521F1C8@tv-sign.ru>  <4298AED8.8000408@timesys.com>
Content-Type: text/plain
Date: Sat, 28 May 2005 15:17:34 -0700
Message-Id: <1117318654.10746.67.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.012, required 12,
	autolearn=disabled, AWL 1.99, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

lau den 28.05.2005 Klokka 13:48 (-0400) skreiv john cooper:
> The other possibility to fix the original problem within
> the scope of the RPC code was to replace the bit state of
> RPC_TASK_HAS_TIMER with a count so we don't obscure the
> fact the timer was requeued during the preemption window.
> This happens as rpc_run_timer() does an unconditional
> clear_bit(RPC_TASK_HAS_TIMER,..) before returning.

Just to clarify a bit more here. RPC_TASK_HAS_TIMER is definitely _not_
redundantly replicating timer state, as I saw you asserting previously.

There are two distinct cases where timer->base may be NULL. In the first
case, the timer is inactive and was never queued so it is entirely
pointless to be calling del_timer() & friends. In the second case, the
timer was active, but has expired and was picked up by __run_timers().
del_singleshot_timer_sync() fails to distinguish these two cases, and
will therefore end up redundantly calling del_timer_sync() every time a
task loops through __rpc_execute() without setting a timer. Your patch
to remove RPC_TASK_HAS_TIMER will re-introduce that redundant behaviour
but will re-introduce precisely the race that del_timer_sync() is
designed to fix.

So, I repeat: I want to see a case description that clearly demonstrates
a race scenario in the existing code before I'm willing to consider any
patches at all.

Cheers,
  Trond

