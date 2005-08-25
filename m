Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932080AbVHYPUL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932080AbVHYPUL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 11:20:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932082AbVHYPUK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 11:20:10 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:6849 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932080AbVHYPUJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 11:20:09 -0400
Date: Thu, 25 Aug 2005 17:20:02 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Linux/m68k <linux-m68k@vger.kernel.org>
Subject: Re: [PATCH] (18/22) task_thread_info - part 2/4
In-Reply-To: <20050825143657.GT9322@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.61.0508251656080.3728@scrub.home>
References: <E1E8AEh-0005eT-NP@parcelfarce.linux.theplanet.co.uk>
 <Pine.LNX.4.61.0508251107500.24552@scrub.home>
 <20050825130738.GQ9322@parcelfarce.linux.theplanet.co.uk>
 <Pine.LNX.4.61.0508251515440.3728@scrub.home>
 <20050825143657.GT9322@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 25 Aug 2005, Al Viro wrote:

> > > > >  
> > > > > -	*ti = *orig->thread_info;
> > > > >  	*tsk = *orig;
> > > > > +	setup_thread_info(tsk, ti);
> > > > >  	tsk->thread_info = ti;
> > > > >  	ti->task = tsk;
> > > > 
> > > > This introduces a subtle ordering requirement, where setup_thread_info 
> > > > magically finds in the new task_struct the pointer to the old thread_info 
> > > > to setup the new thread_info.
> 
> How does that make what I wrote above wrong?  We do have two versions, all
> right.  Called from one place.  Each is a one-liner in my variant, more than
> that in your.

The point is about ordering requirements that your "setup_thread_info(tsk, 
ti);" must be inbetween "*tsk = *orig;" and "tsk->thread_info = ti;", so 
that setup_thread_info() gets the right thread_info.

> > > > What is your problem with what I have in CVS? There it completes the basic
> > > > task_struct setup and _after_ that it can setup the thread_info.
> > > 
> > > Which buys you what, exactly?  You end up with more things to do in
> > > setup_thread_info() and it doesn't get cleaner.
> > 
> > Wrong.
> > 
> > +static inline void setup_thread_stack(struct task_struct *p, struct task_struct *org)
> > +{
> > +       *task_thread_info(p) = *task_thread_info(org);
> > +       task_thread_info(p)->task = p;
> > +}
> 
> ... and that does not fit "more things to do in setup_thread_info()" in
> which way?

That in the sum it's still the same work.

> > Please count correctly, there is only one 100KB patch, the rest is rather 
> > small (50KB in 7 patches).
> 
> ... no comments, except that 28K (ti6_1) + 24K (ti6_2) + 22K (ti6_3) +
> 12K (ti6_4) already appears to be more than 50K...

ti6 is the sum of ti6_?, to make it easier to verify.

> In any case, that's hardly the point - s/200/150/ if you wish and that
> does not make the problem much better.

Most of them rather simple search and replace.

> I seem to remember some very public conversations with you on that topic,
> but again, this is not the point

There has been a bit on IRC, but I can't really discuss such things on IRC 
(everyone just makes his own point and the issues continue and just scroll 
away) and it certainly didn't happen on the linux-m68k ml.

> - the real issue is with merge strategy
> you proposed.  And no, I do not believe that doing that merge + great
> renaming in a single burst is feasible.  Reorder that and yes, all parts
> make sense and are doable.  With essentially the same final tree.

The biggest part is already at the end and I'll split the big one into 
three separate patches (stack, end_of_stack and task_thread_info changes). 
I'll send them to Andrew and we can still discuss how quickly to merge 
each part. I don't really see the point in holding off for too long, 
except for the final thread_info field removal.

bye, Roman
