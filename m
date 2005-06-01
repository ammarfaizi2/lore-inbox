Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261162AbVFATtV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261162AbVFATtV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 15:49:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261191AbVFATrc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 15:47:32 -0400
Received: from pat.uio.no ([129.240.130.16]:2202 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S261162AbVFATqt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 15:46:49 -0400
Subject: Re: RT and Cascade interrupts
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: john cooper <john.cooper@timesys.com>
Cc: Oleg Nesterov <oleg@tv-sign.ru>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>, Olaf Kirch <okir@suse.de>
In-Reply-To: <429E0A86.7000507@timesys.com>
References: <42974F08.1C89CF2A@tv-sign.ru> <4297AF39.4070304@timesys.com>
	 <42983135.C521F1C8@tv-sign.ru> <4298AED8.8000408@timesys.com>
	 <1117312557.10746.6.camel@lade.trondhjem.org>
	 <4299332F.6090900@timesys.com>
	 <1117352410.10788.29.camel@lade.trondhjem.org>
	 <429B8678.1000706@timesys.com> <429DC4A8.BFF69FB3@tv-sign.ru>
	 <429DF8DE.7060008@timesys.com>
	 <1117650718.10733.65.camel@lade.trondhjem.org>
	 <429E0A86.7000507@timesys.com>
Content-Type: text/plain
Date: Wed, 01 Jun 2005 15:46:41 -0400
Message-Id: <1117655201.10733.98.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.635, required 12,
	autolearn=disabled, AWL 1.36, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

on den 01.06.2005 Klokka 15:20 (-0400) skreiv john cooper:

> You might have missed in my earlier mail as
> this is a not an MP kernel ie: !CONFIG_SMP
> The synchronous timer delete primitives don't
> exist in this configuration:
> 
> include/linux/timer.h:
> 
> #ifdef CONFIG_SMP
>    extern int del_timer_sync(struct timer_list *timer);
>    extern int del_singleshot_timer_sync(struct timer_list *timer);
> #else
> # define del_timer_sync(t) del_timer(t)
> # define del_singleshot_timer_sync(t) del_timer(t)
> #endif


For the RT patched stuff that should read

#if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_SOFTIRQS)
  extern int del_timer_sync(struct timer_list *timer);
  extern int del_singleshot_timer_sync(struct timer_list *timer);
#else
# define del_timer_sync(t) del_timer(t)
# define del_singleshot_timer_sync(t) del_timer(t)
#endif


> BTW, I don't know if you happened on the mail I sent
> yesterday.  It details rpc_run_timer() waking up an
> application task blocked in call_transmit().  The
> app task preempts ksoftirqd and eventually does a
> __rpc_sleep_on()/__mod_timer() which requeues the
> timer in the cascade.  When ksoftirqd/rpc_run_timer()
> resumes RPC_TASK_HAS_TIMER is unconditionally cleared
> however the timer is queued in the cascade.  This
> appears to be at least one cause of the timer cascade
> corruption I've seen.

I saw it. Once again, I don't see how that can happen. __rpc_execute()
should be calling rpc_delete_timer() before it calls task->tk_action.

There should be no instances of RPC entering call_transmit() or any
other tk_action callback with a pending timer.

Cheers,
  Trond

