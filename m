Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291291AbSCHXsf>; Fri, 8 Mar 2002 18:48:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291194AbSCHXsQ>; Fri, 8 Mar 2002 18:48:16 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:34031 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S291297AbSCHXsD> convert rfc822-to-8bit;
	Fri, 8 Mar 2002 18:48:03 -0500
Message-ID: <3C894D87.FF70DD12@mvista.com>
Date: Fri, 08 Mar 2002 15:47:19 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: frankeh@watson.ibm.com
CC: Linus Torvalds <torvalds@transmeta.com>,
        Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Futexes IV (Fast Lightweight Userspace Semaphores)
In-Reply-To: <Pine.LNX.4.33.0203081109390.2749-100000@penguin.transmeta.com> <3C89234B.F9F1BDD1@mvista.com> <20020308230156.D7AB23FE06@smtp.linux.ibm.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hubertus Franke wrote:
> 
> On Friday 08 March 2002 03:47 pm, george anzinger wrote:
> > Linus Torvalds wrote:
> > > On Fri, 8 Mar 2002, Hubertus Franke wrote:
> > > > Could you also comment on the functionality that has been discussed.
> > >
> > > First off, I have to say that I really like the current patch by Rusty.
> > > The hashing approach is very clean, and it all seems quite good. As to
> > >
> > > specific points:
> > > > (I) the fairness issues that have been raised.
> > > >     do you support two wakeup mechanism: FUTEX_UP and FUTEX_UP_FAIR
> > > >     or you don't care about fairness and starvation
> > >
> > > I don't think fairness and starvation is that big of a deal for
> > > semaphores, usually being unfair in these things tends to just improve
> > > performance through better cache locality with no real downside. That
> > > said, I think the option should be open (which it does seem to be).
> > >
> > > For rwlocks, my personal preference is the fifo-fair-preference (unlike
> > > semaphore fairness, I have actually seen loads where read- vs
> > > write-preference really is unacceptable). This might be a point where we
> > > give users the choice.
> > >
> > > I do think we should make the lock bigger - I worry that atomic_t simply
> > > won't be enough for things like fair rwlocks, which might want a
> > > "cmpxchg8b" on x86.
> > >
> > > So I would suggest making the size (and thus alignment check) of locks at
> > > least 8 bytes (and preferably 16). That makes it slightly harder to put
> > > locks on the stack, but gcc does support stack alignment, even if the
> > > code sucks right now.
> >
> > I think this is needed if we want to address the "task dies while
> > holding a lock" issue.  In this case we need to know who holds the lock.
> >
> > -g
> >
> 
> George, while desirable its very tricky if possible at all.
> 
> You need to stick your pid or so into the lock and do it
> atomically. So let's assume we only stick with architectures that can do
> cmpxchg-doubleword, still its not fool proof.

Uh, just the pid would do.  Maybe reserve a bit to indicate contention,
but surly one word would be enough.

> First, the app could still corrupt that count or pid field of the lock
> In that case the whole logic get'ss crewed up.
> There is no guarantee that you ever know who holds the locks !!!

At that point you are most likely down for the count.  The most use for
this would be development where programs are dying like flies.  If the
sem area is "registered" with the kernel, it could do the right thing®
in the exit code.  Except for using the cmpxchg I don't think it adds to
the overhead.
> 
> Secondly, what guarantee do you have that your data is kosher ?

Well, none, but you don't in either case.  This is a non-argument.

> I tend to agree with the masses, that hand waving might be the best
> first approximation

That is your privilege :-)
> 
> --
> -- Hubertus Franke  (frankeh@watson.ibm.com)

-- 
George           george@mvista.com
High-res-timers: http://sourceforge.net/projects/high-res-timers/
Real time sched: http://sourceforge.net/projects/rtsched/
