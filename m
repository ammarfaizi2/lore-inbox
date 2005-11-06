Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932264AbVKFBAI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932264AbVKFBAI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 20:00:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932266AbVKFBAI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 20:00:08 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:9615 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932264AbVKFBAG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 20:00:06 -0500
Date: Sat, 5 Nov 2005 17:00:04 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, dipankar@in.ibm.com,
       mingo@elte.hu, suzannew@cs.pdx.edu
Subject: Re: [PATCH] Additional/catchup RCU signal fixes for -mm
Message-ID: <20051106010004.GB20178@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20051105013650.GA17461@us.ibm.com> <436CDEAF.E236BC40@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <436CDEAF.E236BC40@tv-sign.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 05, 2005 at 07:32:47PM +0300, Oleg Nesterov wrote:
> "Paul E. McKenney" wrote:
> >
> > @@ -1386,7 +1387,7 @@ send_sigqueue(int sig, struct sigqueue *
> >  {
> >  	unsigned long flags;
> >  	int ret = 0;
> > -	struct sighand_struct *sh = p->sighand;
> > +	struct sighand_struct *sh;
> >
> >  	BUG_ON(!(q->flags & SIGQUEUE_PREALLOC));
> >
> > @@ -1405,7 +1406,15 @@ send_sigqueue(int sig, struct sigqueue *
> >  		goto out_err;
> >  	}
> >
> > +retry:
> > +	sh = rcu_dereference(p->sighand);
> > +
> >  	spin_lock_irqsave(&sh->siglock, flags);
> > +	if (p->sighand != sh) {
> > +		/* We raced with exec() in a multithreaded process... */
> > +		spin_unlock_irqrestore(&sh->siglock, flags);
> > +		goto retry;
> 
> p->sighand can't be changed, de_thread calls exit_itimers() before
> changing ->sighand. But I still think it can be NULL, and send_sigqueue()
> should return -1 in that case.

OK, I put the NULL check in with my previous patch.

And you are absolutely right in the de_thread() case.  I need to add 
more cases to steamroller...

> > @@ -1464,15 +1473,8 @@ send_group_sigqueue(int sig, struct sigq
> >
> >  	BUG_ON(!(q->flags & SIGQUEUE_PREALLOC));
> >
> > -	while (!read_trylock(&tasklist_lock)) {
> > -		if (!p->sighand)
> > -			return -1;
> > -		cpu_relax();
> > -	}
> > -	if (unlikely(!p->sighand)) {
> > -		ret = -1;
> > -		goto out_err;
> > -	}
> > +	read_lock(&tasklist_lock);
> > +	/* Since it_lock is held, p->sighand cannot be NULL. */
> >  	spin_lock_irqsave(&p->sighand->siglock, flags);
> 
> Again, I think the comment is wrong.
> 
> However, now I think we really have a race with exec, and this race was not
> introduced by your patches!

This patch was not mine, though I guess that it is by now.  ;-)

> If !thread_group_leader() does exec de_thread() calls release_task(->group_leader)
> before calling exit_itimers(). This means that send_group_sigqueue() which
> always has p == ->group_leader parameter can oops here.

But in that case, __exit_sighand(->group_leader) would have been called,
so ->sighand would be NULL.  And none of this can change while we are holding
tasklist_lock.

If we don't want to be hitting the exec()ed task with a signal, the
thing to do would be to drop the signal, as in the attached patch.
I believe that this is an acceptable approach, since had the timer
fired slightly later, it would have been disabled, right?

Thoughts?

						Thanx, Paul

Signed-off-by: <paulmck@us.ibm.com>

diff -urpNa -X dontdiff linux-2.6.14-mm0-fix-2/kernel/signal.c linux-2.6.14-mm0-fix-3/kernel/signal.c
--- linux-2.6.14-mm0-fix-2/kernel/signal.c	2005-11-05 15:05:38.000000000 -0800
+++ linux-2.6.14-mm0-fix-3/kernel/signal.c	2005-11-05 16:27:52.000000000 -0800
@@ -1481,6 +1481,10 @@ send_group_sigqueue(int sig, struct sigq
 	read_lock(&tasklist_lock);
 	while (p->group_leader != p)
 		p = p->group_leader;
+	if (p->sighand == NULL) {
+		ret = 1;
+		goto out_err;
+	}
 	spin_lock_irqsave(&p->sighand->siglock, flags);
 	handle_stop_signal(sig, p);
 
