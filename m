Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751048AbVHYOdw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751048AbVHYOdw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 10:33:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751085AbVHYOdw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 10:33:52 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:55971 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S1751043AbVHYOdv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 10:33:51 -0400
Date: Thu, 25 Aug 2005 15:36:57 +0100
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Linux/m68k <linux-m68k@vger.kernel.org>
Subject: Re: [PATCH] (18/22) task_thread_info - part 2/4
Message-ID: <20050825143657.GT9322@parcelfarce.linux.theplanet.co.uk>
References: <E1E8AEh-0005eT-NP@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.61.0508251107500.24552@scrub.home> <20050825130738.GQ9322@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.61.0508251515440.3728@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0508251515440.3728@scrub.home>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2005 at 04:10:38PM +0200, Roman Zippel wrote:
> Hi,
> 
> On Thu, 25 Aug 2005, Al Viro wrote:
> 
> > On Thu, Aug 25, 2005 at 11:15:24AM +0200, Roman Zippel wrote:
> > > >  
> > > > -	*ti = *orig->thread_info;
> > > >  	*tsk = *orig;
> > > > +	setup_thread_info(tsk, ti);
> > > >  	tsk->thread_info = ti;
> > > >  	ti->task = tsk;
> > > 
> > > This introduces a subtle ordering requirement, where setup_thread_info 
> > > magically finds in the new task_struct the pointer to the old thread_info 
> > > to setup the new thread_info.
> > 
> > Nothing subtle with it, especially since this is the only place with any
> > business to call setup_thread_info().
> 
> Wrong, we could have multiple versions setup_thread_info() and every one 
> gets the pointer to old thread_info via the new task_struct.

How does that make what I wrote above wrong?  We do have two versions, all
right.  Called from one place.  Each is a one-liner in my variant, more than
that in your.
 
> > > What is your problem with what I have in CVS? There it completes the basic
> > > task_struct setup and _after_ that it can setup the thread_info.
> > 
> > Which buys you what, exactly?  You end up with more things to do in
> > setup_thread_info() and it doesn't get cleaner.
> 
> Wrong.
> 
> +static inline void setup_thread_stack(struct task_struct *p, struct task_struct *org)
> +{
> +       *task_thread_info(p) = *task_thread_info(org);
> +       task_thread_info(p)->task = p;
> +}

... and that does not fit "more things to do in setup_thread_info()" in
which way?

> > > Al, I would really prefer to merge this one myself, I'm only waiting for 
> > > the 2.6.13 release and since this is not a regression, I don't really 
> > > understand why this must be in 2.6.13.
> > 
> > Fine, as long as that merge is done before your s/thread_info/stack/ patches.
> > It should be the first step before doing 200Kb worth of cosmetical stuff
> > that affects every architecture out there, not something that depends on
> > it done.
> 
> Please count correctly, there is only one 100KB patch, the rest is rather 
> small (50KB in 7 patches).

... no comments, except that 28K (ti6_1) + 24K (ti6_2) + 22K (ti6_3) +
12K (ti6_4) already appears to be more than 50K...

In any case, that's hardly the point - s/200/150/ if you wish and that
does not make the problem much better.
 
> > There's also a question of having mainline build and work on the architecture
> > in question, which obviously is not something you care about - this hairball
> > had been sitting in m68k CVS for how long?  Since 2.5.60-something, with
> > zero efforts to resolve it, right?  And mainline kernel didn't even build,
> > let alone work since that moment.
> > 
> > FWIW, essentially the same splitup of that mess had been posted more than
> > three months ago; definitely before 2.6.12-final.  Still no activity _and_
> > plans that involve doing kernel-wide renaming of struct thread_info *
> > thread_info in task_struct to void *stack as part of m68k merge.
> 
> Al, while I appreciate your iniative, could you please work a little bit 
> more with the other people working on this port? I did take and adapted 
> your patches and posted my versions of it and until yesterday you didn't 
> bother to comment publically. The "no activity" is complete bullshit.

I seem to remember some very public conversations with you on that topic,
but again, this is not the point - the real issue is with merge strategy
you proposed.  And no, I do not believe that doing that merge + great
renaming in a single burst is feasible.  Reorder that and yes, all parts
make sense and are doable.  With essentially the same final tree.

Hell, I can even offer to do and feed the per-arch cleanups of that, getting
the final chunk down to tolerable size.  After and separate from getting m68k
to work in mainline.

To clarify the situation: this is _NOT_ an attempt to prevent ->thread_info
cleanups from getting into the tree.  I actually think that they do make
sense; moreover, they do make sense on their own and mixing them with m68k
merge only causes extra problems for both.
