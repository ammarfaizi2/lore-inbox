Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265589AbSJSMT2>; Sat, 19 Oct 2002 08:19:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265591AbSJSMT2>; Sat, 19 Oct 2002 08:19:28 -0400
Received: from smtp-out-3.wanadoo.fr ([193.252.19.233]:22704 "EHLO
	mel-rto3.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S265589AbSJSMTW>; Sat, 19 Oct 2002 08:19:22 -0400
Content-Type: text/plain; charset=US-ASCII
From: Duncan Sands <baldrick@wanadoo.fr>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: Use of yield() in the kernel
Date: Sat, 19 Oct 2002 14:25:34 +0200
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@digeo.com>
References: <200210151536.39029.baldrick@wanadoo.fr> <20021018182558.GD237@elf.ucw.cz>
In-Reply-To: <20021018182558.GD237@elf.ucw.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210191425.34627.baldrick@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Here is the list of files using yield(), excluding non-i386 arch specific
> > files:
>
> ...
>
> > kernel/suspend.c
>
> This is okay.

Hi Pavel, I agree.  I have some questions about the code though:
when you come across a thread with (p->flags & PF_FROZEN), why
break out of the loop?  Why not just skip this thread and go on to the
next one?  Also, does it matter if the code doing the freezing is itself
frozen?

Ciao, Duncan.

PS: Here is the code, for reference:

        do {
                todo = 0;
                read_lock(&tasklist_lock);
                do_each_thread(g, p) {
                        unsigned long flags;
                        INTERESTING(p);
                        if (p->flags & PF_FROZEN)
                                continue;

                        /* FIXME: smp problem here: we may not access other proc
ess' flags
                           without locking */
                        p->flags |= PF_FREEZE;
                        spin_lock_irqsave(&p->sig->siglock, flags);
                        signal_wake_up(p);
                        spin_unlock_irqrestore(&p->sig->siglock, flags);
                        todo++;
                } while_each_thread(g, p);
                read_unlock(&tasklist_lock);
                yield();
                if (time_after(jiffies, start_time + TIMEOUT)) {
                        printk( "\n" );
                        return todo;
                }
        } while(todo);
