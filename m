Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291377AbSCIHOv>; Sat, 9 Mar 2002 02:14:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291471AbSCIHOk>; Sat, 9 Mar 2002 02:14:40 -0500
Received: from zeus.kernel.org ([204.152.189.113]:61645 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S292473AbSCIHO3>;
	Sat, 9 Mar 2002 02:14:29 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: frankeh@watson.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Futexes IV (Fast Lightweight Userspace Semaphores)
In-Reply-To: <Pine.LNX.4.33.0203081109390.2749-100000@penguin.transmeta.com>
In-Reply-To: <20020308190232.A2D273FE06@smtp.linux.ibm.com>
	<Pine.LNX.4.33.0203081109390.2749-100000@penguin.transmeta.com>
Date: Sat, 09 Mar 2002 15:49:35 +1100
Message-Id: <E16jYnr-0003T7-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Mar 2002 11:22:20 -0800 (PST)
Linus Torvalds <torvalds@transmeta.com> wrote:
> First off, I have to say that I really like the current patch by Rusty. 
> The hashing approach is very clean, and it all seems quite good. As to 
> specific points:

Thanks.  [Aside: VIRO PLEASE TAKE NOTE.]

> > (I) the fairness issues that have been raised.
> >     do you support two wakeup mechanism: FUTEX_UP and FUTEX_UP_FAIR 
> >     or you don't care about fairness and starvation
> 
> I don't think fairness and starvation is that big of a deal for
> semaphores, usually being unfair in these things tends to just improve
> performance through better cache locality with no real downside. That
> said, I think the option should be open (which it does seem to be).

1) Unfairness definitely helps performance (~30% faster on tdbtorture and
   IIRC on Hubertus' benchmark too).
2) Absolute fairness depends on hardware anyway.
3) I was not able to produce any evidence of STARVATION (which I think
   we all agree *is* an issue).

So I'd say stick with the minimalistic, fast, unfair solution.

> For rwlocks, my personal preference is the fifo-fair-preference (unlike
> semaphore fairness, I have actually seen loads where read- vs
> write-preference really is unacceptable). This might be a point where we 
> give users the choice.

Yes.  See post on "furwocks": fair-preference rw locks implemented in
userspace on top of the futexes.

> I do think we should make the lock bigger - I worry that atomic_t simply
> won't be enough for things like fair rwlocks, which might want a
> "cmpxchg8b" on x86. 
> 
> So I would suggest making the size (and thus alignment check) of locks at
> least 8 bytes (and preferably 16). That makes it slightly harder to put
> locks on the stack, but gcc does support stack alignment, even if the code
> sucks right now.

Actually, I disagree.

1) We've left wiggle room in the second arg to sys_futex() to add rwsems
   later if required.
2) Someone needs to implement them and prove they are superior to the
   pure userspace solution.

The most gain will be from a very briefly held lock that is 99.99% read.
But if it's 10%, it's not worth it: we need numbers.

Rusty.
-- 
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
