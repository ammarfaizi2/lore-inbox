Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750889AbVKDUID@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750889AbVKDUID (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 15:08:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750897AbVKDUID
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 15:08:03 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:37550 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750889AbVKDUIB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 15:08:01 -0500
Date: Fri, 4 Nov 2005 12:08:02 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, dipankar@in.ibm.com, suzannew@cs.pdx.edu
Subject: Re: [PATCH] Fixes for RCU handling of task_struct
Message-ID: <20051104200801.GA16092@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20051031020535.GA46@us.ibm.com> <20051031140459.GA5664@elte.hu> <20051031205119.5bd897f3.akpm@osdl.org> <20051103190916.GA13417@us.ibm.com> <436B9D5D.3EB28CD5@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <436B9D5D.3EB28CD5@tv-sign.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 04, 2005 at 08:41:49PM +0300, Oleg Nesterov wrote:
> "Paul E. McKenney" wrote:
> > 
> > On Mon, Oct 31, 2005 at 08:51:19PM -0800, Andrew Morton wrote:
> > > Ingo Molnar <mingo@elte.hu> wrote:
> > > >
> > > > @@ -1433,7 +1485,16 @@ send_group_sigqueue(int sig, struct sigq
> > > >     int ret = 0;
> > > >
> > > >     BUG_ON(!(q->flags & SIGQUEUE_PREALLOC));
> > > >  -  read_lock(&tasklist_lock);
> > > >  +
> > > >  +  while(!read_trylock(&tasklist_lock)) {
> > > >  +          if (!p->sighand)
> > > >  +                  return -1;
> > > >  +          cpu_relax();
> > > >  +  }
> > >
> > > This looks kind of ugly and quite unobvious.
> > >
> > > What's going on there?
> > 
> > This was discussed in the following thread:
> > 
> >         http://marc.theaimsgroup.com/?l=linux-kernel&m=112756875713008&w=2
> > 
> > Looks like its author asked for it to be withdrawn in favor of Roland's
> > "[PATCH] Call exit_itimers from do_exit, not __exit_signal" patch:
> > 
> >         http://marc.theaimsgroup.com/?l=linux-kernel&m=113008567108608&w=2
> > 
> > My guess is that "Roland" is "Roland McGrath", but I cannot find the
> > referenced patch.  Oleg, any enlightenment?
> 
> Yes, it was from Roland McGrath:
> 
> 	http://kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=25f407f0b668f5e4ebd5d13e1fb4306ba6427ead
> 
> So I think you can remove ->sighand == NULL re-check and do s/read_trylock/read_lock/.
> Posix timers are destroyed from do_exit()->exit_itimers(), after that nobody can send
> SI_TIMER to this dying thread group (even if cpu-timer was attached to another process).

This one is not my patch, but, in the spirit of getting things resolved,
I will respond as best I can.

I agree with the change from read_trylock() to read_lock(), given
that Roland's change has been merged.  I also agree with removing the
check against NULL ("if (!p->sighand)").

Andrew, if you would be willing to send me the current state of your
kernel/signal.c, I would be happy to provide the appropriate patch
to get this straightened out.  If there is somewhere I should be
looking to figure this out myself, please let me know.

> send_sigqueue() is different,
> 
> > @@ -1385,16 +1407,47 @@ send_sigqueue(int sig, struct sigqueue *
> >  {
> >         unsigned long flags;
> >         int ret = 0;
> > +       struct sighand_struct *sh = p->sighand;
> > 
> >         BUG_ON(!(q->flags & SIGQUEUE_PREALLOC));
> > -       read_lock(&tasklist_lock);
> > +
> > +       /*
> > +        * The rcu based delayed sighand destroy makes it possible to
> > +        * run this without tasklist lock held. The task struct itself
> > +        * cannot go away as create_timer did get_task_struct().
> > +        *
> > +        * We return -1, when the task is marked exiting, so
> > +        * posix_timer_event can redirect it to the group leader
> > +        *
> > +        */
> > +       rcu_read_lock();
> > 
> >         if (unlikely(p->flags & PF_EXITING)) {
> >                 ret = -1;
> >                 goto out_err;
> 
> Is it really needed? You are doing this check again below.

This one looks to be an efficiency hack.  It avoids the lock overhead
in the case that the task is exiting.  Since this case should be rare,
I agree that it makes sense to remove it.

> > -       spin_lock_irqsave(&p->sighand->siglock, flags);
> > +       spin_lock_irqsave(&sh->siglock, flags);
>
> But 'sh' can be NULL, no? Yes, you already checked PF_EXITING, so this is
> very unlikely, but I think it is still possible in theory. 'sh' was loaded
> before reading p->flags, but rcu_read_lock() does not imply memory barrier.

'sh' cannot be NULL, because the caller holds ->it_lock and has checked
for timer deletion under that lock, and because the exiting process
quiesces and deletes timers before freeing sighand.

I do need to look at races with exec(), which could potentially cause
us to be working with the wrong instance of sighand.  I will do this
for -rt, and also for -mm as soon as I get access to it.

> Paul, currently I have no time to read the patch carefully, so probably
> this all is my misunderstanding.

Oleg, I very much appreciate your identifying the patch!  The exec()
issue might well be real, and deserves a look in any case.

> > @@ -352,6 +359,7 @@ void __exit_signal(struct task_struct *t
> >                 BUG();
> >         if (!atomic_read(&sig->count))
> >                 BUG();
> > +       rcu_read_lock();
> >         spin_lock(&sighand->siglock);
> 
> Why rcu_read_lock() here?

In theory unneeded due to the fact that we are holding a reference
count and only doing atomic operations on the sighand_struct.
In practice, very cheap operation and easier documentation.  I don't
want to add strange rules to Documentation/RCU about leaving out
rcu_read_lock() and rcu_dereference() in the special case where
all operations on the RCU-protected structure are atomic, especially
since they are sometimes non-atomic in UP kernels.

The documentation is long enough as it is!  ;-)

> > +static inline int get_task_struct_rcu(struct task_struct *t)
> > +{
> > +       int oldusage;
> > +
> > +       do {
> > +               oldusage = atomic_read(&t->usage);
> > +               if (oldusage == 0) {
> > +                       return 0;
> > +               }
> > +       } while (cmpxchg(&t->usage.counter,
> > +                oldusage, oldusage + 1) != oldusage);
> > +       return 1;
> > +}
> > 
> 
> I still don't understand the purpose of get_task_struct_rcu().

And you are right -- I recently submitted a patch to remove the only
use of it, but it does not appear to have made it into 2.6.14-rt6.
I will check -rt6 and submit a consolidated patch against it.

						Thanx, Paul
