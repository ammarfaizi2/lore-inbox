Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265787AbSJTJjZ>; Sun, 20 Oct 2002 05:39:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263246AbSJTJiy>; Sun, 20 Oct 2002 05:38:54 -0400
Received: from smtp-out-4.wanadoo.fr ([193.252.19.23]:65436 "EHLO
	mel-rto4.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S265787AbSJTJen>; Sun, 20 Oct 2002 05:34:43 -0400
Content-Type: text/plain; charset=US-ASCII
From: Duncan Sands <baldrick@wanadoo.fr>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: Use of yield() in the kernel
Date: Sun, 20 Oct 2002 11:10:33 +0200
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@digeo.com>
References: <200210151536.39029.baldrick@wanadoo.fr> <200210191425.34627.baldrick@wanadoo.fr> <20021019220000.GC28445@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20021019220000.GC28445@atrey.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210201110.33254.baldrick@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Hi Pavel, I agree.  I have some questions about the code though:
> > when you come across a thread with (p->flags & PF_FROZEN), why
> > break out of the loop?  Why not just skip this thread and go on to
> > the
>
> There's "continue;" in there, and it should "just skip this thread".
> 									Pavel

I meant, why not just do as in the following code (I've changed
INTERESTING also, for same reason, as explained below):

	do {
		todo = 0;
		read_lock(&tasklist_lock);
		do_each_thread(g, p) {
			unsigned long flags;

                        if (
				!(p->flags & PF_IOTHREAD) &&
				(p != current) &&
				(p->state != TASK_ZOMBIE) &&
				!(p->flags & PF_FROZEN)
			) {

				/* FIXME: smp problem here: we may not access other process' flags
				   without locking */
				p->flags |= PF_FREEZE;
				spin_lock_irqsave(&p->sig->siglock, flags);
				signal_wake_up(p);
				spin_unlock_irqrestore(&p->sig->siglock, flags);
				todo++;
			}
		} while_each_thread(g, p);
		read_unlock(&tasklist_lock);
		yield();
		if (time_after(jiffies, start_time + TIMEOUT)) {
			printk( "\n" );
			printk(KERN_ERR " stopping tasks failed (%d tasks remaining)\n", todo );
			return todo;
		}
	} while(todo);

The reason is that yield(), which sends the current task to the expired list,
can take a long time before it runs again.  With the current code, every time
you meet, for example, a kernel thread you break out of the loop, perform
a yield (= wait a long time), before going on to the next thread.  This could
take forever.  With code like that above, you mark as many tasks frozen as
possible, with as few yields as possible.  Isn't that better?

Ciao,

Duncan.
