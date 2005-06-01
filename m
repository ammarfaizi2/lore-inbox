Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261229AbVFASun@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261229AbVFASun (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 14:50:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261225AbVFAStb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 14:49:31 -0400
Received: from pat.uio.no ([129.240.130.16]:15287 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S261555AbVFAScL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 14:32:11 -0400
Subject: Re: RT and Cascade interrupts
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: john cooper <john.cooper@timesys.com>
Cc: Oleg Nesterov <oleg@tv-sign.ru>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>, Olaf Kirch <okir@suse.de>
In-Reply-To: <429DF8DE.7060008@timesys.com>
References: <42974F08.1C89CF2A@tv-sign.ru> <4297AF39.4070304@timesys.com>
	 <42983135.C521F1C8@tv-sign.ru> <4298AED8.8000408@timesys.com>
	 <1117312557.10746.6.camel@lade.trondhjem.org>
	 <4299332F.6090900@timesys.com>
	 <1117352410.10788.29.camel@lade.trondhjem.org>
	 <429B8678.1000706@timesys.com> <429DC4A8.BFF69FB3@tv-sign.ru>
	 <429DF8DE.7060008@timesys.com>
Content-Type: text/plain
Date: Wed, 01 Jun 2005 14:31:58 -0400
Message-Id: <1117650718.10733.65.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.778, required 12,
	autolearn=disabled, AWL 1.22, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

on den 01.06.2005 Klokka 14:05 (-0400) skreiv john cooper:
> I've done so and the second assert is generated
> when running the test.  So here we have a case
> of RPC_TASK_HAS_TIMER set but the associated
> timer->base == NULL.  It would seem this could
> easily be the scenario of executing in:
> 
> __run_timers()
>      timer->base = NULL;
>          rpc_run_timer()
>              task->tk_timeout_fn(task)
>              /* ksoftirqd preempted */
>                                               :
>                                           /* RPC client */
>                                           rpc_execute()
>                                              rpc_delete_timer()
>                                                  del_timer() returns 0
>                                                  BUG_ON(test_bit(RPC_TASK_HAS_TIMER,
>                                                    &task->tk_runstate));
>                                               :
>           /* rpc_run_timer() resumes */
>           clear_bit(RPC_TASK_HAS_TIMER,
>             &task->tk_runstate);
> 
> I don't see how this would imply a kernel/timer.c
> problem.  It also appears this wouldn't be causing
> the timer cascade corruption I've seen as the
> end result is deleting an already dequeued timer
> which is safe here.

If timer->base==NULL, then del_timer() returns 0 (as you correctly state
above). What you appear to be missing is that this will trigger a call
to del_timer_sync() inside del_singleshot_timer_sync().

In other words, your scenario above should, if the timer code is working
according to spec instead lead to

__run_timers()
     timer->base = NULL;
         rpc_run_timer()
             task->tk_timeout_fn(task)
             /* ksoftirqd preempted */
                                              :
                                       /* RPC client */
                                       rpc_execute()
                                          rpc_delete_timer()
					     del_singleshot_timer_sync()
                                                 del_timer() returns 0
						 del_timer_sync()
						/* wait until timer has
						   completed */
          /*rpc_run_timer() resumes */
          clear_bit(RPC_TASK_HAS_TIMER,
            &task->tk_runstate);
         ....
     set_running_timer(some_other_value);

				    BUG_ON(test_bit(RPC_TASK_HAS_TIMER,
                                                   &task->tk_runstate));
                                              :

Cheers,
  Trond

