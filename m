Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261583AbVFPLpe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261583AbVFPLpe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 07:45:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261610AbVFPLpd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 07:45:33 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:15085 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261583AbVFPLpO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 07:45:14 -0400
Subject: Re: [PATCH] Re: [BUG] Race condition with it_real_fn in
	kernel/itimer.c
From: Steven Rostedt <rostedt@goodmis.org>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Roland McGrath <roland@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <1118921624.4512.16.camel@localhost.localdomain>
References: <42B067BD.F4526CD@tv-sign.ru>
	 <1118860623.4508.70.camel@localhost.localdomain>
	 <1118864043.4508.81.camel@localhost.localdomain>
	 <42B12DD6.7028CBAE@tv-sign.ru>
	 <1118921624.4512.16.camel@localhost.localdomain>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Thu, 16 Jun 2005 07:44:55 -0400
Message-Id: <1118922295.4512.23.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-06-16 at 07:33 -0400, Steven Rostedt wrote:

> int do_setitimer(int which, struct itimerval *value, struct itimerval *ovalue)
> {
>         struct task_struct *tsk = current;
> 	static spinlock_t lock = SPIN_LOCK_UNLOCKED;
> 
> [...]
> 		spin_lock(&lock);
> 		spin_unlock(&tsk->sighand->siglock);
> 		del_timer_sync(&tsk->signal->real_timer);
> 		spin_lock(&tsk->sighand->siglock);
> 		spin_unlock(&lock);

OK, I just got out of bed, so I'm not too with it :-) 

This is pretty much a guaranteed deadlock!  So the first spin_lock needs
to go before the siglock. That should do it!


	case ITIMER_REAL:
		spin_lock_irq(&lock);
		spin_lock(&tsk->sighand->siglock);
		[...]
		spin_unlock(&tsk->sighand->siglock);
		del_timer_sync(&tsk->signal->real_timer);
		spin_lock(&tsk->sighand->siglock);
		spin_unlock(&lock);

We just need to keep two do_setitimer calls from grabbing the siglock.
That first string of code didn't prevent that.

-- Steve

