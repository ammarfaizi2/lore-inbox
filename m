Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262033AbVGVEtz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262033AbVGVEtz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 00:49:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262023AbVGVEtz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 00:49:55 -0400
Received: from [216.208.38.107] ([216.208.38.107]:16536 "EHLO
	OTTLS.pngxnet.com") by vger.kernel.org with ESMTP id S262032AbVGVEtE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 00:49:04 -0400
Subject: Re: [linux-pm] [PATCH] Workqueue freezer support.
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Patrick Mochel <mochel@digitalimplant.org>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.50.0507211221550.12779-100000@monsoon.he.net>
References: <1121923059.2936.224.camel@localhost>
	 <Pine.LNX.4.50.0507211221550.12779-100000@monsoon.he.net>
Content-Type: text/plain
Organization: Cycades
Message-Id: <1122001360.3030.17.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Fri, 22 Jul 2005 13:02:41 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Fri, 2005-07-22 at 05:42, Patrick Mochel wrote:
> On Thu, 21 Jul 2005, Nigel Cunningham wrote:
> 
> > This patch implements freezer support for workqueues. The current
> > refrigerator implementation makes all workqueues NOFREEZE, regardless of
> > whether they need to be or not.
> 
> A few comments..
> 
> > Signed-off by: Nigel Cunningham <nigel@suspend2.net>
> >
> >  drivers/acpi/osl.c          |    2 +-
> >  drivers/block/ll_rw_blk.c   |    2 +-
> >  drivers/char/hvc_console.c  |    2 +-
> >  drivers/char/hvcs.c         |    2 +-
> >  drivers/input/serio/serio.c |    2 +-
> >  drivers/md/dm-crypt.c       |    2 +-
> >  drivers/scsi/hosts.c        |    2 +-
> >  drivers/usb/net/pegasus.c   |    2 +-
> 
> If you want some practice splitting things up, submit the patches above
> individually to the maintainers o the relevant code once the patches you
> submit below get merged to -mm.

Ok. Thanks for telling me.

> >  include/linux/kthread.h     |   20 ++++++++++++++++++--
> >  include/linux/workqueue.h   |    9 ++++++---
> >  kernel/kmod.c               |    4 ++++
> >  kernel/kthread.c            |   23 ++++++++++++++++++++++-
> >  kernel/sched.c              |    4 ++--
> >  kernel/softirq.c            |    3 +--
> >  kernel/workqueue.c          |   21 ++++++++++++---------
> >  15 files changed, 73 insertions(+), 27 deletions(-)
> 
> 
> You should make sure that you get an explicit ACK from people (Ingo et al)
> about whether this is an acceptable interface.

Ok. How do I know who to ask? (Who besides Ingo, and could I learn who
without help - Maintainers?)

> > --- 400-workthreads.patch-old/include/linux/kthread.h	2004-11-03 21:51:12.000000000 +1100
> > +++ 400-workthreads.patch-new/include/linux/kthread.h	2005-07-20 15:11:37.000000000 +1000
> > @@ -27,6 +27,14 @@ struct task_struct *kthread_create(int (
> >  				   void *data,
> >  				   const char namefmt[], ...);
> >
> > +struct task_struct *_kthread_create(int (*threadfn)(void *data),
> > +				   void *data,
> > +				   unsigned long freezer_flags,
> > +				   const char namefmt[], ...);
> > +
> 
> This should be __kthread_create(...)

Ok. Fixed. Is one underscore ever right?

> > -#define kthread_run(threadfn, data, namefmt, ...)			   \
> > +#define kthread_run(threadfn, data, namefmt, args...)			   \
> >  ({									   \
> >  	struct task_struct *__k						   \
> > -		= kthread_create(threadfn, data, namefmt, ## __VA_ARGS__); \
> > +		= kthread_create(threadfn, data, namefmt, ##args);	   \
> >  	if (!IS_ERR(__k))						   \
> >  		wake_up_process(__k);					   \
> >  	__k;								   \
> >  })
> >
> > +#define kthread_nofreeze_run(threadfn, data, namefmt, args...)		   \
> > +({									   \
> > +	struct task_struct *__k	= kthread_nofreeze_create(threadfn, data,  \
> > +			namefmt, ##args);				   \
> > +	if (!IS_ERR(__k))						   \
> > +		wake_up_process(__k);					   \
> > +	__k;								   \
> > +})
> 
> Do these functions need to be inlined?

I tried to find out how to pass the va_list on nicely without using a
#define, but could find the info. If you're able to tell me, I'll make
them inline. Perhaps I could also improve the kthread_create call Pavel
and Ingo commented on.

> > @@ -86,6 +87,10 @@ static int kthread(void *_create)
> >  	/* By default we can run anywhere, unlike keventd. */
> >  	set_cpus_allowed(current, CPU_MASK_ALL);
> >
> > +	/* Set our freezer flags */
> > +	current->flags &= ~(PF_SYNCTHREAD | PF_NOFREEZE);
> > +	current->flags |= (create->freezer_flags & PF_NOFREEZE);
> > +
> 
> Maybe these should be encapsulated in a helper in include/linux/sched.h
> like some other flags manipulations are?

This would be the only place it's used. Does that matter? (And note from
the updated patch that the SYNCTHREAD wouldn't be there).

> > diff -ruNp 400-workthreads.patch-old/kernel/sched.c 400-workthreads.patch-new/kernel/sched.c
> > --- 400-workthreads.patch-old/kernel/sched.c	2005-07-21 04:00:02.000000000 +1000
> > +++ 400-workthreads.patch-new/kernel/sched.c	2005-07-21 04:00:19.000000000 +1000
> > @@ -4580,10 +4580,10 @@ static int migration_call(struct notifie
> >
> >  	switch (action) {
> >  	case CPU_UP_PREPARE:
> > -		p = kthread_create(migration_thread, hcpu, "migration/%d",cpu);
> > +		p = kthread_create(migration_thread, hcpu,
> > +				"migration/%d",cpu);
> 
> This is unnecessary.

Oops. Comes from adding an extra parameter, fixing line length and then
removing it. Fixed.

> Overall, it looks pretty good.

Thanks!

Nigel

> Thanks,
> 
> 
> 
> 	Pat
-- 
Evolution.
Enumerate the requirements.
Consider the interdependencies.
Calculate the probabilities.

