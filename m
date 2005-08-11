Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751083AbVHKPUA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751083AbVHKPUA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 11:20:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751081AbVHKPT7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 11:19:59 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:32685 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751083AbVHKPT7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 11:19:59 -0400
Date: Thu, 11 Aug 2005 08:20:31 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Ingo Molnar <mingo@elte.hu>, Dipankar Sarma <dipankar@in.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC,PATCH] Use RCU to protect tasklist for unicast signals
Message-ID: <20050811152031.GC1300@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <42FB41B5.98314BA5@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42FB41B5.98314BA5@tv-sign.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 11, 2005 at 04:16:53PM +0400, Oleg Nesterov wrote:
> Paul E. McKenney wrote:
> >
> > --- linux-2.6.13-rc6/kernel/signal.c	2005-08-08 19:59:24.000000000 -0700
> > +++ linux-2.6.13-rc6-tasklistRCU/kernel/signal.c	2005-08-10 08:20:25.000000000 -0700
> > @@ -1151,9 +1151,13 @@ int group_send_sig_info(int sig, struct 
> >
> >  	ret = check_kill_permission(sig, info, p);
> >  	if (!ret && sig && p->sighand) {
> > +		if (!get_task_struct_rcu(p)) {
> > +			return -ESRCH;
> > +		}
> >  		spin_lock_irqsave(&p->sighand->siglock, flags);
>                                       ^^^^^^^
> Is it correct?
> 
> The caller (kill_proc_info) does not take tasklist_lock anymore.
> If p does exec() at this time it can change/free its ->sighand.
> 
> fs/exec.c:de_thread()
>    773                  write_lock_irq(&tasklist_lock);
>    774                  spin_lock(&oldsighand->siglock);
>    775                  spin_lock(&newsighand->siglock);
>    776
>    777                  current->sighand = newsighand;
>    778                  recalc_sigpending();
>    779
>    780                  spin_unlock(&newsighand->siglock);
>    781                  spin_unlock(&oldsighand->siglock);
>    782                  write_unlock_irq(&tasklist_lock);
>    783
>    784                  if (atomic_dec_and_test(&oldsighand->count))
>    785                          kmem_cache_free(sighand_cachep, oldsighand);

Looks suspicious to me!  ;-)  Will look into this one, thank you for
pointing it out!

						Thanx, Paul
