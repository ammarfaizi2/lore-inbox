Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131208AbQL0EK5>; Tue, 26 Dec 2000 23:10:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132012AbQL0EKq>; Tue, 26 Dec 2000 23:10:46 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:13632 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S131208AbQL0EKf>; Tue, 26 Dec 2000 23:10:35 -0500
Date: Wed, 27 Dec 2000 04:39:57 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <andrewm@uow.edu.au>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [prepatch] 2.4 waitqueues
Message-ID: <20001227043957.E29610@athlon.random>
In-Reply-To: <3A4937D2.B7FE7C28@uow.edu.au>, <3A4937D2.B7FE7C28@uow.edu.au>; <20001227033459.A29610@athlon.random> <3A495A88.D44D19E6@uow.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3A495A88.D44D19E6@uow.edu.au>; from andrewm@uow.edu.au on Wed, Dec 27, 2000 at 01:57:12PM +1100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 27, 2000 at 01:57:12PM +1100, Andrew Morton wrote:
> Oh, it's all still there, but it's now all in the header file:
> 
> #ifdef DEBUG
> #define foo() printk(stuff)
> #else
> #define foo()
> #endif

I intentionally didn't focused on such part of your patch because I understood
from the description that debugging stuff was gone and I wasn't going to agree
with such part regardless of the implementation it was really the case ;).

Now reading such part of the patch it looks a fine cleanup of course.

> No, gcc doesn't give any warnings about uninitialised vars.  It _could_
> give warnings about unused ones, but doesn't.

So then you're wasting stack in UP compile.

Not a big deal but still I'd prefer the CONFIG_SMP #ifdef though, it looks even
more obvious that it's a compile check and at least in your usage I cannot see
a relevant readability advantage. And my own feeling is not having to rely on
more things to produce the wanted asm when there's no relevant advantage, but
if Linus likes it I won't object further.

> It's not just open-coded printks - it's oopses.  If you take an oops or a
> BUG or a panic within wake_up() or _anywhere_ with the runqueue_lock held,
> the machine deadlocks and you don't get any diagnostics.  This is bad.
> We really do need to get that wake_up() out of printk().  tq_timer may
> not be the best way.  Suggestions welcome.

For kernel autodiagnostics we need to trust something. This something is
everything that gets into the oops path. wake_up is one of those things.  You
want to replace wake_up with queue_task, why shouldn't queue_task break instead
of wake_up? You're replacing a thing with another thing that can of course
break too if there's a bug (hardware or software). But they're so core things
that we need to trust anyway and we need to get them right from sources without
relying on any testing anyways. So I simply don't see any advantage of using
queue_task other than making things slower and more complex. Debugging hardware
bugs isn't a good point either. Of course I see why you were doing that during
developement, and that's fine for local debugging ;)

For the runqueue_lock right way to not having to trust schedule as well is to
add it to the bust_spinlocks list.

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
