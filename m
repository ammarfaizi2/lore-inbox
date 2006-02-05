Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751420AbWBEKgF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751420AbWBEKgF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 05:36:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751691AbWBEKgE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 05:36:04 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:20388 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751420AbWBEKgD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 05:36:03 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH -mm] swsusp: freeze user space processes first
Date: Sun, 5 Feb 2006 11:34:18 +0100
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, pavel@suse.cz, nigel@suspend2.net
References: <200602051014.43938.rjw@sisk.pl> <20060205013859.60a6e5ab.akpm@osdl.org>
In-Reply-To: <20060205013859.60a6e5ab.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602051134.19490.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sunday 05 February 2006 10:38, Andrew Morton wrote:
> "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> > This patch allows swsusp to freeze processes successfully under heavy load
> > by freezing userspace processes before kernel threads.
> > 
> > ...
> >
> >  /* 0 = success, else # of processes that we failed to stop */
> >  int freeze_processes(void)
> >  {
> > -	int todo;
> > +	int todo, nr_user, user_frozen;
> >  	unsigned long start_time;
> >  	struct task_struct *g, *p;
> >  	unsigned long flags;
> >  
> >  	printk( "Stopping tasks: " );
> >  	start_time = jiffies;
> > +	user_frozen = 0;
> >  	do {
> > -		todo = 0;
> > +		nr_user = todo = 0;
> >  		read_lock(&tasklist_lock);
> >  		do_each_thread(g, p) {
> >  			if (!freezeable(p))
> >  				continue;
> >  			if (frozen(p))
> >  				continue;
> > -
> > -			freeze(p);
> > -			spin_lock_irqsave(&p->sighand->siglock, flags);
> > -			signal_wake_up(p, 0);
> > -			spin_unlock_irqrestore(&p->sighand->siglock, flags);
> > -			todo++;
> > +			if (p->mm && !(p->flags & PF_BORROWED_MM)) {
> > +				/* The task is a user-space one.
> > +				 * Freeze it unless there's a vfork completion
> > +				 * pending
> > +				 */
> > +				if (!p->vfork_done)
> > +					freeze_process(p);
> > +				nr_user++;
> > +			} else {
> > +				/* Freeze only if the user space is frozen */
> > +				if (user_frozen)
> > +					freeze_process(p);
> > +				todo++;
> > +			}
> >  		} while_each_thread(g, p);
> >  		read_unlock(&tasklist_lock);
> > +		todo += nr_user;
> > +		if (!user_frozen && !nr_user) {
> > +			sys_sync();
> > +			start_time = jiffies;
> > +		}
> > +		user_frozen = !nr_user;
> >  		yield();			/* Yield is okay here */
> > -		if (todo && time_after(jiffies, start_time + TIMEOUT)) {
> > -			printk( "\n" );
> > -			printk(KERN_ERR " stopping tasks timed out (%d tasks remaining)\n", todo );
> > +		if (todo && time_after(jiffies, start_time + TIMEOUT))
> >  			break;
> 
> The logic in that loop makes my brain burst.
> 
> What happens if a process does vfork();sleep(100000000)?

The freezing of processes will fail due to the timeout.

Without the if (!p->vfork_done) it would fail too, because the child would
be frozen and the parent would wait for the vfork completion in the
TASK_UNINTERRUPTIBLE state (ie. unfreezeable).  But in that case
we have a race between the "freezer" and the child process
(ie. if the child gets frozen before it completes the vfork completion, the
paret will be unfreezeable) which sometimes leads to a failure when it
should not.  [We have a test case showing this.]

Greetings,
Rafael
