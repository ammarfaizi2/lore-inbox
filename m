Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750721AbWFJIX5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750721AbWFJIX5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 04:23:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750724AbWFJIX5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 04:23:57 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:35048 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750721AbWFJIX4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 04:23:56 -0400
Date: Sat, 10 Jun 2006 10:23:00 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Dinakar Guniguntala <dino@in.ibm.com>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] Fix for Bug in PI exit code
Message-ID: <20060610082300.GA32261@elte.hu>
References: <20060609131409.GA4962@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060609131409.GA4962@in.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5224]
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Dinakar Guniguntala <dino@in.ibm.com> wrote:

> We were seeing oopses like below a lot when using PI mutexes

> ===============================================================================
> After a lot of debugging we found that this is caused due to the following race.
> PM is a PI mutex, A and B are RT threads
> 
>         Thread A (RT)                  Thread B (RT)
>             |
>             v
>     pthread_mutex_lock (PM)                 |
>     (glibc) got mutex                       v
>          do work                   pthread_mutex_lock (PM)
>                                    rt_mutex_timed_lock
> 
>           EINTR                    EINTR (Process gets aborted)
> 
>          do_exit                   lock(pi_mutex->lock->wait_lock)
>     exit_pi_state_list             clear_waiters
>     lock(hb->lock)
>     pi_state->owner = NULL         unlock(pi_mutex->lock->wait_lock)
>     rt_mutex_unlock(pi_mutex)      lock(hb->lock) (blocks)
>     unlock(hb->lock)               unblock -> free_pi_state
>     continue exit processing       doesn't expect pi_state->owner to be NULL
>                                    Panic
> 
> The patch attached below seems to make this problem go away. This has 
> been stress tested quite a bit in the past 24 hours. Does it look sane 
> to you ??

yeah, makes sense. Thanks, applied.

	Ingo
