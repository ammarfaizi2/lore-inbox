Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965007AbVHYOKr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965007AbVHYOKr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 10:10:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965010AbVHYOKr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 10:10:47 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:58816 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S965007AbVHYOKq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 10:10:46 -0400
Date: Thu, 25 Aug 2005 16:10:38 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Linux/m68k <linux-m68k@vger.kernel.org>
Subject: Re: [PATCH] (18/22) task_thread_info - part 2/4
In-Reply-To: <20050825130738.GQ9322@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.61.0508251515440.3728@scrub.home>
References: <E1E8AEh-0005eT-NP@parcelfarce.linux.theplanet.co.uk>
 <Pine.LNX.4.61.0508251107500.24552@scrub.home>
 <20050825130738.GQ9322@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 25 Aug 2005, Al Viro wrote:

> On Thu, Aug 25, 2005 at 11:15:24AM +0200, Roman Zippel wrote:
> > >  
> > > -	*ti = *orig->thread_info;
> > >  	*tsk = *orig;
> > > +	setup_thread_info(tsk, ti);
> > >  	tsk->thread_info = ti;
> > >  	ti->task = tsk;
> > 
> > This introduces a subtle ordering requirement, where setup_thread_info 
> > magically finds in the new task_struct the pointer to the old thread_info 
> > to setup the new thread_info.
> 
> Nothing subtle with it, especially since this is the only place with any
> business to call setup_thread_info().

Wrong, we could have multiple versions setup_thread_info() and every one 
gets the pointer to old thread_info via the new task_struct.

> > What is your problem with what I have in CVS? There it completes the basic
> > task_struct setup and _after_ that it can setup the thread_info.
> 
> Which buys you what, exactly?  You end up with more things to do in
> setup_thread_info() and it doesn't get cleaner.

Wrong.

+static inline void setup_thread_stack(struct task_struct *p, struct task_struct *org)
+{
+       *task_thread_info(p) = *task_thread_info(org);
+       task_thread_info(p)->task = p;
+}

-       *ti = *orig->thread_info;
        *tsk = *orig;
        tsk->thread_info = ti;
-       ti->task = tsk;
+       setup_thread_stack(tsk, orig);

It's exactly the same work and setup_thread_stack() gets the old and new 
task_struct, with each one having the _correct_ thread_info.
If you really want to count cycles, the only minor difference is that 
some "ti" become "tsk->thread_info", but gcc is perfectly capable to 
detect that it's the same and it will generate the same code.

Moreover my code is cleaner, as it clearly separates two tasks:

	setup_task_struct(tsk, orig);
	setup_thread_stack(tsk, orig);


> > Al, I would really prefer to merge this one myself, I'm only waiting for 
> > the 2.6.13 release and since this is not a regression, I don't really 
> > understand why this must be in 2.6.13.
> 
> Fine, as long as that merge is done before your s/thread_info/stack/ patches.
> It should be the first step before doing 200Kb worth of cosmetical stuff
> that affects every architecture out there, not something that depends on
> it done.

Please count correctly, there is only one 100KB patch, the rest is rather 
small (50KB in 7 patches).

> There's also a question of having mainline build and work on the architecture
> in question, which obviously is not something you care about - this hairball
> had been sitting in m68k CVS for how long?  Since 2.5.60-something, with
> zero efforts to resolve it, right?  And mainline kernel didn't even build,
> let alone work since that moment.
> 
> FWIW, essentially the same splitup of that mess had been posted more than
> three months ago; definitely before 2.6.12-final.  Still no activity _and_
> plans that involve doing kernel-wide renaming of struct thread_info *
> thread_info in task_struct to void *stack as part of m68k merge.

Al, while I appreciate your iniative, could you please work a little bit 
more with the other people working on this port? I did take and adapted 
your patches and posted my versions of it and until yesterday you didn't 
bother to comment publically. The "no activity" is complete bullshit.

bye, Roman
