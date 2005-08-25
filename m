Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964969AbVHYNEd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964969AbVHYNEd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 09:04:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964967AbVHYNEd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 09:04:33 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:5019 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S964966AbVHYNEc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 09:04:32 -0400
Date: Thu, 25 Aug 2005 14:07:38 +0100
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Al Viro <viro@www.linux.org.uk>, geert@linux-m68k.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, linux-m68k@vger.kernel.org
Subject: Re: [PATCH] (18/22) task_thread_info - part 2/4
Message-ID: <20050825130738.GQ9322@parcelfarce.linux.theplanet.co.uk>
References: <E1E8AEh-0005eT-NP@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.61.0508251107500.24552@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0508251107500.24552@scrub.home>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2005 at 11:15:24AM +0200, Roman Zippel wrote:
> >  
> > -	*ti = *orig->thread_info;
> >  	*tsk = *orig;
> > +	setup_thread_info(tsk, ti);
> >  	tsk->thread_info = ti;
> >  	ti->task = tsk;
> 
> This introduces a subtle ordering requirement, where setup_thread_info 
> magically finds in the new task_struct the pointer to the old thread_info 
> to setup the new thread_info.

Nothing subtle with it, especially since this is the only place with any
business to call setup_thread_info().

> What is your problem with what I have in CVS? There it completes the basic
> task_struct setup and _after_ that it can setup the thread_info.

Which buys you what, exactly?  You end up with more things to do in
setup_thread_info() and it doesn't get cleaner.

> Al, I would really prefer to merge this one myself, I'm only waiting for 
> the 2.6.13 release and since this is not a regression, I don't really 
> understand why this must be in 2.6.13.

Fine, as long as that merge is done before your s/thread_info/stack/ patches.
It should be the first step before doing 200Kb worth of cosmetical stuff
that affects every architecture out there, not something that depends on
it done.

There's also a question of having mainline build and work on the architecture
in question, which obviously is not something you care about - this hairball
had been sitting in m68k CVS for how long?  Since 2.5.60-something, with
zero efforts to resolve it, right?  And mainline kernel didn't even build,
let alone work since that moment.

FWIW, essentially the same splitup of that mess had been posted more than
three months ago; definitely before 2.6.12-final.  Still no activity _and_
plans that involve doing kernel-wide renaming of struct thread_info *
thread_info in task_struct to void *stack as part of m68k merge.  With
200-odd Kb of patches just out of that renaming.  At which point I gave
up on explaining the difference between "take the diff between mainline
and CVS + whatever needed to make all other platforms compile after change
and try to shove it into mainline" and "do minimally intrusive merge,
followed by sane cleanup sequence done in mainline".
