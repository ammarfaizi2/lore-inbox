Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753161AbVHHArB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753161AbVHHArB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 20:47:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753159AbVHHArA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 20:47:00 -0400
Received: from b3162.static.pacific.net.au ([203.143.238.98]:41611 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S1753161AbVHHAq7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 20:46:59 -0400
Subject: Re: [linux-pm] [PATCH] Workqueue freezer support.
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Patrick Mochel <mochel@digitalimplant.org>,
       Christoph Lameter <christoph@lameter.com>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.50.0508052148280.19501-100000@monsoon.he.net>
References: <1121923059.2936.224.camel@localhost>
	 <Pine.LNX.4.50.0507211221550.12779-100000@monsoon.he.net>
	 <1123243967.3266.2.camel@localhost>
	 <Pine.LNX.4.50.0508052148280.19501-100000@monsoon.he.net>
Content-Type: text/plain
Organization: Cycades
Message-Id: <1123462015.3969.98.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Mon, 08 Aug 2005 10:46:55 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Sorry for the slow response. Busy still.

On Sat, 2005-08-06 at 15:06, Patrick Mochel wrote:
> On Fri, 5 Aug 2005, Nigel Cunningham wrote:
> 
> > Hi.
> >
> > I finally found some time to finish this off. I don't really like the
> > end result - the macros looked clearer to me - but here goes. If it
> > looks okay, I'll seek sign offs from each of the affected driver
> > maintainers and from Ingo. Anyone else?
> 
> What are your feelings about this: http://lwn.net/Articles/145417/ ?

I'm sure it could work, but I do worry a little about the possibilities
for exploits. It seems to me that if someone can get root, they an
insmod a module that could schedule any kind of work via any process.
Tracing that sort of security hole could be intractable. Christoph, is
that something you've considered/have thoughts on? Perhaps I'm just
being paranoid :>

> It seems like a cleaner way to do things. How would these patches change
> if that were merged?

We would still need some way to mark which threads to freeze, so we'd
still need the same sort of thing as far as kthread_run etc goes.

We'd also still mark unfreezable threads with NOFREEZE and not mark
other threads, so no change there.

The first substantial change I can see would be switching from
try_to_freeze to try_todo_list (could this be 'run_todo_list'? Try
implies failure is possible - if it is possible, why do we ignore
whether it fails?).

The second substantial change would be in the area of the refrigeration
code itself, ala Christoph's patch.

One more question regarding Christoph's patch - would it be worth moving
the refrigerator related code from sched.h to a separate file? We
already have so many things that depend on sched.h, and this will add
more. It will also make maintenance less painful because you won't have
to recompile everything that depends on sched.h when all you did was
modify (say) freezing().

> Concerning the patch specifically:
> 
> > diff -ruNp 400-workthreads.patch-old/include/linux/kthread.h 400-workthreads.patch-new/include/linux/kthread.h
> > --- 400-workthreads.patch-old/include/linux/kthread.h	2004-11-03 21:51:12.000000000 +1100
> > +++ 400-workthreads.patch-new/include/linux/kthread.h	2005-08-03 11:52:01.000000000 +1000
> > @@ -23,10 +23,20 @@
> >   *
> >   * Returns a task_struct or ERR_PTR(-ENOMEM).
> >   */
> > +struct task_struct *__kthread_create(int (*threadfn)(void *data),
> > +				   void *data,
> > +				   unsigned long freezer_flags,
> > +				   const char namefmt[],
> > +				   va_list * args);
> > +
> 
> When comparing this to this:
> 
> > diff -ruNp 400-workthreads.patch-old/include/linux/workqueue.h 400-workthreads.patch-new/include/linux/workqueue.h
> > --- 400-workthreads.patch-old/include/linux/workqueue.h	2005-06-20 11:47:30.000000000 +1000
> > +++ 400-workthreads.patch-new/include/linux/workqueue.h	2005-08-03 11:49:34.000000000 +1000
> > @@ -51,9 +51,12 @@ struct work_struct {
> >  	} while (0)
> >
> >  extern struct workqueue_struct *__create_workqueue(const char *name,
> > -						    int singlethread);
> > -#define create_workqueue(name) __create_workqueue((name), 0)
> > -#define create_singlethread_workqueue(name) __create_workqueue((name), 1)
> > +						    int singlethread,
> > +						    unsigned long freezer_flag);
> > +#define create_workqueue(name) __create_workqueue((name), 0, 0)
> > +#define create_nofreeze_workqueue(name) __create_workqueue((name), 0, PF_NOFREEZE)
> > +#define create_singlethread_workqueue(name) __create_workqueue((name), 1, 0)
> > +#define create_nofreeze_singlethread_workqueue(name) __create_workqueue((name), 1, PF_NOFREEZE)
> 
> And to this:
> 
> 
> >  static struct task_struct *create_workqueue_thread(struct workqueue_struct *wq,
> > -						   int cpu)
> > +						   int cpu,
> > +						   unsigned long freezer_flags)
> >  {
> 
> There is a slight discrepancy in the API changes. Obviously, we don't want
> to change every caller of create_workqueue() to support this. But, perhaps
> you could standardize the handling of the freezer flags (by e.g. creating
> a separate _nofreeze version for each).

Missed that one, sorry.

> Also, functions that take a va_list parameter pass the structure (array)
> rather than the pointer. See the definition of vprintk() in
> include/linux/kernel.h for an example.

Thanks for the pointer.

Nigel

> 
> Thanks,
> 
> 
> 	Pat
> 
> ______________________________________________________________________
> _______________________________________________
> linux-pm mailing list
> linux-pm@lists.osdl.org
> https://lists.osdl.org/mailman/listinfo/linux-pm
-- 
Evolution.
Enumerate the requirements.
Consider the interdependencies.
Calculate the probabilities.

