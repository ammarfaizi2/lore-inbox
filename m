Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131973AbRDMWH0>; Fri, 13 Apr 2001 18:07:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131976AbRDMWHQ>; Fri, 13 Apr 2001 18:07:16 -0400
Received: from mailgw.prontomail.com ([216.163.180.10]:24783 "EHLO
	c0mailgw04.prontomail.com") by vger.kernel.org with ESMTP
	id <S131973AbRDMWHE>; Fri, 13 Apr 2001 18:07:04 -0400
Message-ID: <3AD7783F.DDB367E6@mvista.com>
Date: Fri, 13 Apr 2001 15:05:51 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.72 [en] (X11; I; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Brian Gerst <bgerst@didntduck.org>
CC: Mircea Damian <dmircea@kappa.ro>, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: No one wants to help me :-(
In-Reply-To: <20010413134213.E13992@linux.kappa.ro> <3AD74080.2499C032@didntduck.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brian Gerst wrote:
> 
> Mircea Damian wrote:
> >
> > Hello,
> >
> > I was expecting to receive some replies to my last desperate messages:
> > http://www.mail-archive.com/linux-kernel@vger.kernel.org/msg35446.html
> > http://www.mail-archive.com/linux-kernel@vger.kernel.org/msg36591.html
> >
> > My machine is dyeing in add_timer(). It seems to happen only on SMP
> > machines and is something related to the network driver. For some reason
> >  one of the timer lists gets broken so we (we are two people trying to
> >  solve this issue) wrote a "safe" timer.c which tries to rebuild the chain
> >  in case it hits a NULL pointer.
> >
> > The machine is (ofcourse) slower with this patch but at least it works.
> >
> > Maybe someone can see which is the real bug and fix it.
> >
> > Please help!
> 
> I found (at least part of) the problem.  In detach_timer() we test if
> the timer is pending.  If it is not the function does not remove the
> timer from the list and returns 0.  The functions that call
> detach_timer() do not check the return value and unconditionally set the
> list pointers to NULL, even though the timer is still on the list.
> Patch against 2.4.3 attached, but there may be a better solution.
> 
uh, but the pending test is to check for NULL pointers, so while your
change consolidates some code, I don't think it changes anything, unless
you can find a place that calls detach_timer and doesn't clear the
pointers...

For what its worth, my look at this problem seems to indicate that the
new timer pointer is zero.  This would be a problem in the network code
somewhere.  I would guess that the whole structure is being released by
cpu X while cpu y is trying to set up a timer.  But then I don't really
know the network code (at all).  Just going by the error, defer of zero
in add_timer() which only looks at the timer to verify that the pointers
are zero.

George


George


> --
> 
>                                                 Brian Gerst
> 
>   ------------------------------------------------------------------------
> diff -urN linux-2.4.3/kernel/timer.c linux/kernel/timer.c
> --- linux-2.4.3/kernel/timer.c  Thu Dec 14 20:52:22 2000
> +++ linux/kernel/timer.c        Fri Apr 13 13:26:08 2001
> @@ -194,6 +194,7 @@
>         if (!timer_pending(timer))
>                 return 0;
>         list_del(&timer->list);
> +       timer->list.next = timer->list.prev = NULL;
>         return 1;
>  }
> 
> @@ -217,7 +218,6 @@
> 
>         spin_lock_irqsave(&timerlist_lock, flags);
>         ret = detach_timer(timer);
> -       timer->list.next = timer->list.prev = NULL;
>         spin_unlock_irqrestore(&timerlist_lock, flags);
>         return ret;
>  }
> @@ -246,7 +246,6 @@
> 
>                 spin_lock_irqsave(&timerlist_lock, flags);
>                 ret += detach_timer(timer);
> -               timer->list.next = timer->list.prev = 0;
>                 running = timer_is_running(timer);
>                 spin_unlock_irqrestore(&timerlist_lock, flags);
> 
> @@ -309,7 +308,6 @@
>                         data= timer->data;
> 
>                         detach_timer(timer);
> -                       timer->list.next = timer->list.prev = NULL;
>                         timer_enter(timer);
>                         spin_unlock_irq(&timerlist_lock);
>                         fn(data);
