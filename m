Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265684AbSJSVx7>; Sat, 19 Oct 2002 17:53:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265685AbSJSVx7>; Sat, 19 Oct 2002 17:53:59 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:30738 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S265684AbSJSVx6>; Sat, 19 Oct 2002 17:53:58 -0400
Date: Sun, 20 Oct 2002 00:00:00 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Duncan Sands <baldrick@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@digeo.com>
Subject: Re: Use of yield() in the kernel
Message-ID: <20021019220000.GC28445@atrey.karlin.mff.cuni.cz>
References: <200210151536.39029.baldrick@wanadoo.fr> <20021018182558.GD237@elf.ucw.cz> <200210191425.34627.baldrick@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200210191425.34627.baldrick@wanadoo.fr>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Here is the list of files using yield(), excluding non-i386 arch specific
> > > files:
> >
> > ...
> >
> > > kernel/suspend.c
> >
> > This is okay.
> 
> Hi Pavel, I agree.  I have some questions about the code though:
> when you come across a thread with (p->flags & PF_FROZEN), why
> break out of the loop?  Why not just skip this thread and go on to
> the

There's "continue;" in there, and it should "just skip this thread".
									Pavel


> next one?  Also, does it matter if the code doing the freezing is itself
> frozen?
> 
> Ciao, Duncan.
> 
> PS: Here is the code, for reference:
> 
>         do {
>                 todo = 0;
>                 read_lock(&tasklist_lock);
>                 do_each_thread(g, p) {
>                         unsigned long flags;
>                         INTERESTING(p);
>                         if (p->flags & PF_FROZEN)
>                                 continue;
> 
>                         /* FIXME: smp problem here: we may not access other proc
> ess' flags
>                            without locking */
>                         p->flags |= PF_FREEZE;
>                         spin_lock_irqsave(&p->sig->siglock, flags);
>                         signal_wake_up(p);
>                         spin_unlock_irqrestore(&p->sig->siglock, flags);
>                         todo++;
>                 } while_each_thread(g, p);
>                 read_unlock(&tasklist_lock);
>                 yield();
>                 if (time_after(jiffies, start_time + TIMEOUT)) {
>                         printk( "\n" );
>                         return todo;
>                 }
>         } while(todo);

-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
