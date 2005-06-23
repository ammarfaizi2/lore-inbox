Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262792AbVFWU5M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262792AbVFWU5M (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 16:57:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262662AbVFWUyb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 16:54:31 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:40409 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S262668AbVFWUpP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 16:45:15 -0400
To: Ingo Molnar <mingo@elte.hu>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ckrm-tech@lists.sourceforge.net,
       Chandra Seetharaman <sekharan@us.ibm.com>,
       Hubertus Franke <frankeh@us.ibm.com>, Shailabh Nagar <nagar@us.ibm.com>
Reply-To: Gerrit Huizenga <gh@us.ibm.com>
From: Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: [patch 02/38] CKRM e18: Processor Delay Accounting 
In-reply-to: Your message of Thu, 23 Jun 2005 11:37:32 +0200.
             <20050623093732.GA30848@elte.hu> 
Date: Thu, 23 Jun 2005 13:44:49 -0700
Message-Id: <E1DlYZ7-0003Mw-00@w-gerrit.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 23 Jun 2005 11:37:32 +0200, Ingo Molnar wrote:
> 
> * Ingo Molnar <mingo@elte.hu> wrote:
> 
> > 
> > * Gerrit Huizenga <gh@us.ibm.com> wrote:
> > 
> > > +#ifdef CONFIG_DELAY_ACCT
> > > +int task_running_sys(struct task_struct *p)
> > > +{
> > > +	return task_is_running(p);
> > > +}
> > > +EXPORT_SYMBOL_GPL(task_running_sys);
> > > +#endif
> > 
> > why is this function defined, and why is it exported?

This was exported so it could be used in the classification engine
which is a loadable module which determines how and when tasks join
classes.  There are two classification engines - a basic one (RBCE)
and a more advanced one (CRBCE).  The latter allows a user to set some
basic rules on how newly created tasks will join a class.

> this:
> 
> +#define task_is_running(p)     (this_rq() == task_rq(p))
> 
> is totally bogus. What you are checking is not whether 'the task is 
> running', but it is a complex way of doing p->thread_info->cpu == 
> smp_processor_id(). This, combined with:
> 
> +               if (pdata == NULL)
> +                       /* some wierdo race condition .. simply ignore */
> +                       continue;
> +               if (thread->state == TASK_RUNNING) {
> +                       if (task_running_sys(thread)) {
> +                               atomic_inc((atomic_t *) &
> +                                          (PSAMPLE(pdata)->cpu_running));
> +                               run++;
> +                       } else {
> +                               atomic_inc((atomic_t *) &
> +                                          (PSAMPLE(pdata)->cpu_waiting));
> +                               wait++;
> +                       }
> +               }
> 
> yields completely incorrect code, and bogus data. If your goal is to 
> sample executing-on-cpu vs. on-runqueue-waiting-to-run states then you 
> should use the already existing task_curr(p) call.
> 
> 	Ingo

I'll clean this up later this afternoon and regen a patch.

thanks!

gerrit
