Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271715AbTHMJiH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 05:38:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271724AbTHMJiG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 05:38:06 -0400
Received: from mail10.speakeasy.net ([216.254.0.210]:1680 "EHLO
	mail.speakeasy.net") by vger.kernel.org with ESMTP id S271715AbTHMJiA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 05:38:00 -0400
Date: Wed, 13 Aug 2003 02:37:58 -0700
Message-Id: <200308130937.h7D9bwf04727@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Jeremy Fitzhardinge <jeremy@goop.org>
X-Fcc: ~/Mail/linus
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Matt Wilson <msw@redhat.com>,
       Linux Kernel List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH] revert zap_other_threads breakage, disallow
	CLONE_THREAD without CLONE_DETACHED
In-Reply-To: Jeremy Fitzhardinge's message of  Wednesday, 13 August 2003 00:11:00 -0700 <1060758660.18727.17.camel@ixodes.goop.org>
X-Windows: no hardware is safe.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> One is that it prevents any single piece of code using
> clone(CLONE_THREAD) from working on both 2.4 and 2.6.

I am not aware of what uses have been made of CLONE_THREAD in vanilla 2.4.
The semantics are so drastically different between 2.4 and 2.6 that it
seems useful to me that anything expecting the behavior you get from
CLONE_THREAD in 2.4 have some indication that the world is different now.

> Perhaps I'm the only person in the world to use CLONE_THREAD, but it
> seems unlikely.  After all, clone() is a public interface.

Whoever is using it needs to cope with the many differences in the way that
CLONE_THREAD threads behave in 2.6 vs 2.4.

> I guess my concern is that I'm not convinced we really understand what's
> going wrong here, and so I'm not convinced that this patch really fixes
> things.

Every problem that I have personally seen or thought of, we understand and
have addressed in some fashion (the last of them by punting so it's ruled
out).  I am not making any special claims about the code--there certainly
could be more problems.  But there is not a failure mode that I have either
seen in a reproducible test case or seen postulated in our discussion that
we have not elucidated fully.  I can certainly accept that you have seen
some failures that are not specifically explained, but as I understand it
there aren't any that you are seeing now or that you could reproduce that
aren't addressed by the changes we've discussed before now.  If there are
specific failures you can reproduce that we have not already addressed, I
would certainly like to see them.  When the last potential problem was
identified, it seemed sufficiently sticky to address properly that the
inclination was to punt.  This seemed appropriate given that the only user
to complain about the subject (you) had said he'd punted on using the
problematical feature combination (CLONE_THREAD without CLONE_DETACHED).  I
wouldn't claim that the last unresolved problem is intractable (in fact, I
already proposed a hacky solution that might be adequate) or that there
necessarily are (or aren't) more problems in the whole area of exit
handling.  I don't know of other problems, and if people in actual fact
care about using CLONE_THREAD without CLONE_DETACHED in 2.6, then it is
worth someone's time and effort to address the remaining known problem and
field any newly discovered ones rather than punting.  

If there are in fact other mysterious problems with exit handling unrelated
to the CLONE_THREAD|SIGCHLD style usage as you seem to be alluding to,
certainly we should track them down.  I honestly don't know any specific
reasons to suspect any such things.  Vague concern about ptrace seems like a
red herring to me, unless you can cite some specific oddness actually
happening to a real kernel.  All the exit handling code has cases for ptrace
specifically and does things differently.  If you are talking specifically
about the problem we discussed most recently, de_thread blocking when there
are zombies in the thread group: indeed, I think it will block when there
are ptrace'd zombies and the exec will not complete until the tracer reaps
them all.  That could be called a semantic of ptrace, rather than a bug.
Otherwise, a debugger wouldn't necessarily get reports for every traced
thread and would need to know by other means that an exec had happened and
implicitly reaped them (not really hard to deal with, but perhaps an
unnecessary complication of the ptrace thread tracing interface).


Thanks,
Roland
  
