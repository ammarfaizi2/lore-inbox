Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317169AbSHJS1L>; Sat, 10 Aug 2002 14:27:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317181AbSHJS1L>; Sat, 10 Aug 2002 14:27:11 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:26118 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317169AbSHJS1K>; Sat, 10 Aug 2002 14:27:10 -0400
Date: Sat, 10 Aug 2002 11:32:24 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Daniel Phillips <phillips@arcor.de>
cc: Andrew Morton <akpm@zip.com.au>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 6/12] hold atomic kmaps across generic_file_read
In-Reply-To: <E17damz-0001Zq-00@starship>
Message-ID: <Pine.LNX.4.44.0208101119320.2197-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 10 Aug 2002, Daniel Phillips wrote:
> > 
> > And obviously the heuristic should be a really fast one. The atomic 
> > copy_to_user() is the _perfect_ heuristic, because if it just does the 
> > memcpy there is absolutely zero overhead (it just does it). The overhead 
> > comes in only in the case where we're going to be slowed down by the fault 
> > anyway, _and_ where we want to do the clever tricks.
> 
> So the overhead consists of inc/deccing preempt_count around the
> copy_*_user, which fakes do_page_fault into forcing an early return.

Well, I'm actually expecting that preempt will at some day be the normal
thing to do, so the inc/dec is not so much an overhead of the heuristic,
but a direct result of using "kmap_atomic()" in the first place.

But yes, for the non-preempters, there would be the overhead of doing the
preempt count thing.

That is a nice per-cpu non-atomic thing, and in a cacheline that has been
brought in as part of the system call logic anyway. It will dirty it,
though - and I don't know if that is the "normal" state of that line
otherwise.

[ Side note - one of the reasons I'd potentially like to move the
  thread_info thing to the _top_ of the stack (instead of the bottom) is
  that that way it could share the cacheline with the kernel stack that
  gets dirtied on every kernel entry anyway. Dunno if it matters. ]

> > It doesn't touch it twice. It touches _both_ of the potential pages that 
> > will be involved in the memcpy - since the copy may well not be 
> > page-aligned in user space.
> 
> Oh duh.  I stared at that for the longest time, without realizing there's no
> alignment requirement.

Well, I will not claim that that code is very pretty or obvious. 

Also, as-is, nobody has ever been able to prove that the pre-fetching as
it stands now really fixes the race, although it makes it certainly makes
it practically speaking impossible to trigger. 

> > So with the atomic copy-from-user, we can trap the problem only when it is 
> > a problem, and go full speed normally.
> 
> That's all crystal clear now.  (Though the way do_page_fault finesses
> copy_from_user into returning early is a little - how should I put it -
> opaque.  Yes, I see it, but...)

Well, yes. The whole "fixup" thing is certainly not the most obvious thing 
ever written (and you can thank Richard Henderson for the approach), but 
it has turned out to be a very useful thing to have. It removed all the 
races we had between checking whether an area was properly mapped and 
actually accessing that area (ie the old "verify_area()" approach), and 
it's extremely efficient for the fast path (the fault path is a bit less 
so, but ..)

> I'm sure you're aware there's a lot more you can do with these tricks
> than just zero-copy read - there's zero-copy write as well, and there
> are both of the above, except a full pte page at a time.  There could
> even be a file to file copy if there were an interface for it.

The file-to-file copy is really nasty to do, for the simple reason that
one page really wants to have just one "owner". So while doing a
file-to-file copy is certainly possible, it tends to imply removing the
cached page from the source and inserting it into the destination.

Which is the right thing to do for streaming copies, but the _wrong_ thing 
to do if the source is then used again.

		Linus

