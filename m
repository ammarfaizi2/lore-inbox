Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315257AbSDWQxn>; Tue, 23 Apr 2002 12:53:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315261AbSDWQxm>; Tue, 23 Apr 2002 12:53:42 -0400
Received: from zero.tech9.net ([209.61.188.187]:58385 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S315257AbSDWQxl>;
	Tue, 23 Apr 2002 12:53:41 -0400
Subject: Re: [PATCH] 2.5: MAX_PRIO cleanup
From: Robert Love <rml@tech9.net>
To: mingo@elte.hu
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0204230948150.10873-100000@elte.hu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 23 Apr 2002 12:53:40 -0400
Message-Id: <1019580821.2045.85.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-04-23 at 03:53, Ingo Molnar wrote:

> i agree that this area needs cleaning up, but i dont agree with all
> aspects of your patch. I intentionally left the user-space API side
> separate, MAX_RT can in fact be higher than 100 (without changing the
> user-space API), the only rule is that it must not be smaller. We in fact
> had such a situation once.  It's a perfectly valid goal to have 'super
> high prio' kernel-space threads in the future that have in fact some
> priority that cannot be reached by user-space threads.
> 
> so i've re-done a variation of your patch, which defines USER_MAX_RT_PRIO,
> so the user-space API can still stay separate from the kernel-internal
> representation.

This is better.  I did not want to add another define or a new policy
(i.e. user != kernel maximum priority) but doing so is valid.  Actually,
I think there are a lot of kernel threads where we probably want to set
a priority above the max user-space priority.

There are circumstances in user programming where we want a larger
maximum RT priority, too.  In serious RT programming it wouldn't be
uncommon to see 100-1000 priority levels.  I think having such a wide
range is partly to make programming easier (i.e. a lame crutch) but it
does help to more readily layer real-time tasks.

Now the hard part is abstracting sched_find_first_set for an arbitrary
MAX_RT_PRIO.

> i've also done some other changes:
> 
> >  /*
> > - * Priority of a process goes from 0 to 139. The 0-99
> > - * priority range is allocated to RT tasks, the 100-139
> > - * range is for SCHED_OTHER tasks. Priority values are
> > - * inverted: lower p->prio value means higher priority.
> > + * Priority of a process goes from 0 to MAX_PRIO-1.  The
> > + * 0 to MAX_RT_PRIO-1 priority range is allocated to RT tasks,
> > + * the MAX_RT_PRIO to MAX_PRIO range is for SCHED_OTHER tasks.
> > + * Priority values are inverted: lower p->prio value means higher
> > + * priority.
> 
> this i dont agree with either. The point of comments is easy
> understanding, so i intentionally kept the 'hard' constants and i'm
> updating them constantly - it's much easier to understand how things
> happen if it does not happen via a define. The code itself i agree should
> stay abstract, but the comments should stay as humanly readable as
> possible.

Whatever you prefer...

> (the set|get_affinity comment fixes i kept, plus the runqueue
> double-lock/unlock comments as well, see the attached patch.)

Great, thank you.

Linus, Ingo's patch is fine by me.  Apply?

	Robert Love

