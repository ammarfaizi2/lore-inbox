Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292222AbSCHXCU>; Fri, 8 Mar 2002 18:02:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292150AbSCHXCL>; Fri, 8 Mar 2002 18:02:11 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:41469 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S292237AbSCHXCA>; Fri, 8 Mar 2002 18:02:00 -0500
Content-Type: text/plain; charset=US-ASCII
From: Hubertus Franke <frankeh@watson.ibm.com>
Reply-To: frankeh@watson.ibm.com
Organization: IBM Research
To: george anzinger <george@mvista.com>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] Futexes IV (Fast Lightweight Userspace Semaphores)
Date: Fri, 8 Mar 2002 18:02:52 -0500
X-Mailer: KMail [version 1.3.1]
Cc: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0203081109390.2749-100000@penguin.transmeta.com> <3C89234B.F9F1BDD1@mvista.com>
In-Reply-To: <3C89234B.F9F1BDD1@mvista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020308230156.D7AB23FE06@smtp.linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 08 March 2002 03:47 pm, george anzinger wrote:
> Linus Torvalds wrote:
> > On Fri, 8 Mar 2002, Hubertus Franke wrote:
> > > Could you also comment on the functionality that has been discussed.
> >
> > First off, I have to say that I really like the current patch by Rusty.
> > The hashing approach is very clean, and it all seems quite good. As to
> >
> > specific points:
> > > (I) the fairness issues that have been raised.
> > >     do you support two wakeup mechanism: FUTEX_UP and FUTEX_UP_FAIR
> > >     or you don't care about fairness and starvation
> >
> > I don't think fairness and starvation is that big of a deal for
> > semaphores, usually being unfair in these things tends to just improve
> > performance through better cache locality with no real downside. That
> > said, I think the option should be open (which it does seem to be).
> >
> > For rwlocks, my personal preference is the fifo-fair-preference (unlike
> > semaphore fairness, I have actually seen loads where read- vs
> > write-preference really is unacceptable). This might be a point where we
> > give users the choice.
> >
> > I do think we should make the lock bigger - I worry that atomic_t simply
> > won't be enough for things like fair rwlocks, which might want a
> > "cmpxchg8b" on x86.
> >
> > So I would suggest making the size (and thus alignment check) of locks at
> > least 8 bytes (and preferably 16). That makes it slightly harder to put
> > locks on the stack, but gcc does support stack alignment, even if the
> > code sucks right now.
>
> I think this is needed if we want to address the "task dies while
> holding a lock" issue.  In this case we need to know who holds the lock.
>
> -g
>

Georg, while desirable its very tricky if possible at all.

You need to stick your pid or so into the lock and do it 
atomically. So let's assume we only stick with architectures that can do 
cmpxchg-doubleword, still its not fool proof. 
First, the app could still corrupt that count or pid field of the lock 
In that case the whole logic get'ss crewed up.
There is no guarantee that you ever know who holds the locks !!!

Secondly, what guarantee do you have that your data is kosher ?
I tend to agree with the masses, that hand waving might be the best
first approximation 

-- 
-- Hubertus Franke  (frankeh@watson.ibm.com)
