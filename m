Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932153AbVKDQ2S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932153AbVKDQ2S (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 11:28:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932163AbVKDQ2R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 11:28:17 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:21680 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S932153AbVKDQ2P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 11:28:15 -0500
Message-ID: <436B9D5D.3EB28CD5@tv-sign.ru>
Date: Fri, 04 Nov 2005 20:41:49 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: paulmck@us.ibm.com
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, dipankar@in.ibm.com, suzannew@cs.pdx.edu
Subject: Re: [PATCH] Fixes for RCU handling of task_struct
References: <20051031020535.GA46@us.ibm.com> <20051031140459.GA5664@elte.hu> <20051031205119.5bd897f3.akpm@osdl.org> <20051103190916.GA13417@us.ibm.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Paul E. McKenney" wrote:
> 
> On Mon, Oct 31, 2005 at 08:51:19PM -0800, Andrew Morton wrote:
> > Ingo Molnar <mingo@elte.hu> wrote:
> > >
> > > @@ -1433,7 +1485,16 @@ send_group_sigqueue(int sig, struct sigq
> > >     int ret = 0;
> > >
> > >     BUG_ON(!(q->flags & SIGQUEUE_PREALLOC));
> > >  -  read_lock(&tasklist_lock);
> > >  +
> > >  +  while(!read_trylock(&tasklist_lock)) {
> > >  +          if (!p->sighand)
> > >  +                  return -1;
> > >  +          cpu_relax();
> > >  +  }
> >
> > This looks kind of ugly and quite unobvious.
> >
> > What's going on there?
> 
> This was discussed in the following thread:
> 
>         http://marc.theaimsgroup.com/?l=linux-kernel&m=112756875713008&w=2
> 
> Looks like its author asked for it to be withdrawn in favor of Roland's
> "[PATCH] Call exit_itimers from do_exit, not __exit_signal" patch:
> 
>         http://marc.theaimsgroup.com/?l=linux-kernel&m=113008567108608&w=2
> 
> My guess is that "Roland" is "Roland McGrath", but I cannot find the
> referenced patch.  Oleg, any enlightenment?

Yes, it was from Roland McGrath:

	http://kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=25f407f0b668f5e4ebd5d13e1fb4306ba6427ead

So I think you can remove ->sighand == NULL re-check and do s/read_trylock/read_lock/.
Posix timers are destroyed from do_exit()->exit_itimers(), after that nobody can send
SI_TIMER to this dying thread group (even if cpu-timer was attached to another process).

send_sigqueue() is different,

> @@ -1385,16 +1407,47 @@ send_sigqueue(int sig, struct sigqueue *
>  {
>         unsigned long flags;
>         int ret = 0;
> +       struct sighand_struct *sh = p->sighand;
> 
>         BUG_ON(!(q->flags & SIGQUEUE_PREALLOC));
> -       read_lock(&tasklist_lock);
> +
> +       /*
> +        * The rcu based delayed sighand destroy makes it possible to
> +        * run this without tasklist lock held. The task struct itself
> +        * cannot go away as create_timer did get_task_struct().
> +        *
> +        * We return -1, when the task is marked exiting, so
> +        * posix_timer_event can redirect it to the group leader
> +        *
> +        */
> +       rcu_read_lock();
> 
>         if (unlikely(p->flags & PF_EXITING)) {
>                 ret = -1;
>                 goto out_err;

Is it really needed? You are doing this check again below.

> -       spin_lock_irqsave(&p->sighand->siglock, flags);
> +       spin_lock_irqsave(&sh->siglock, flags);

But 'sh' can be NULL, no? Yes, you already checked PF_EXITING, so this is
very unlikely, but I think it is still possible in theory. 'sh' was loaded
before reading p->flags, but rcu_read_lock() does not imply memory barrier.

Paul, currently I have no time to read the patch carefully, so probably
this all is my misunderstanding.

> @@ -352,6 +359,7 @@ void __exit_signal(struct task_struct *t
>                 BUG();
>         if (!atomic_read(&sig->count))
>                 BUG();
> +       rcu_read_lock();
>         spin_lock(&sighand->siglock);

Why rcu_read_lock() here?

> +static inline int get_task_struct_rcu(struct task_struct *t)
> +{
> +       int oldusage;
> +
> +       do {
> +               oldusage = atomic_read(&t->usage);
> +               if (oldusage == 0) {
> +                       return 0;
> +               }
> +       } while (cmpxchg(&t->usage.counter,
> +                oldusage, oldusage + 1) != oldusage);
> +       return 1;
> +}
> 

I still don't understand the purpose of get_task_struct_rcu().

Oleg.
