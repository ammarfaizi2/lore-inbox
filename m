Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261180AbVE1UgP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261180AbVE1UgP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 May 2005 16:36:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261182AbVE1UgO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 May 2005 16:36:14 -0400
Received: from pat.uio.no ([129.240.130.16]:58772 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S261180AbVE1UgL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 May 2005 16:36:11 -0400
Subject: Re: RT and Cascade interrupts
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: john cooper <john.cooper@timesys.com>
Cc: Oleg Nesterov <oleg@tv-sign.ru>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>, Olaf Kirch <okir@suse.de>
In-Reply-To: <4298AED8.8000408@timesys.com>
References: <42974F08.1C89CF2A@tv-sign.ru> <4297AF39.4070304@timesys.com>
	 <42983135.C521F1C8@tv-sign.ru>  <4298AED8.8000408@timesys.com>
Content-Type: text/plain
Date: Sat, 28 May 2005 13:35:57 -0700
Message-Id: <1117312557.10746.6.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-2.863, required 12,
	autolearn=disabled, AWL 2.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

lau den 28.05.2005 Klokka 13:48 (-0400) skreiv john cooper:

> The other possibility to fix the original problem within
> the scope of the RPC code was to replace the bit state of
> RPC_TASK_HAS_TIMER with a count so we don't obscure the
> fact the timer was requeued during the preemption window.
> This happens as rpc_run_timer() does an unconditional
> clear_bit(RPC_TASK_HAS_TIMER,..) before returning.
> 
> Another would be to check timer->base/timer_pending()
> in rpc_run_timer() and to omit doing a clear_bit()
> if the timer is found to have been requeued.

Could you please explain why you think such a scenario is possible? The
timer functions themselves should never be causing a re-queue, and every
iteration through the loop in __rpc_execute() should cause any pending
timer to be killed, as should rpc_release_task().

That's why we can use del_singleshot_timer_sync() in the first place:
because there is no recursion, and no re-queueing that can cause races.
I don't see how either preemption or RT will change that (and if they
do, then _that_ is the real bug that needs fixing).

Cheers,
  Trond

