Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264785AbSJVRSR>; Tue, 22 Oct 2002 13:18:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264787AbSJVRSR>; Tue, 22 Oct 2002 13:18:17 -0400
Received: from adedition.com ([216.209.85.42]:16644 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id <S264785AbSJVRSM>;
	Tue, 22 Oct 2002 13:18:12 -0400
Date: Tue, 22 Oct 2002 13:24:04 -0400
From: Mark Mielke <mark@mark.mielke.cc>
To: Duncan Sands <baldrick@wanadoo.fr>
Cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@digeo.com>
Subject: Re: Use of yield() in the kernel
Message-ID: <20021022172404.GB1314@mark.mielke.cc>
References: <200210151536.39029.baldrick@wanadoo.fr> <200210191425.34627.baldrick@wanadoo.fr> <20021019220000.GC28445@atrey.karlin.mff.cuni.cz> <200210201110.33254.baldrick@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200210201110.33254.baldrick@wanadoo.fr>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Would it be sensible to add a "yield_short()" function to the kernel?

mark


On Sun, Oct 20, 2002 at 11:10:33AM +0200, Duncan Sands wrote:
> > > Hi Pavel, I agree.  I have some questions about the code though:
> > > when you come across a thread with (p->flags & PF_FROZEN), why
> > > break out of the loop?  Why not just skip this thread and go on to
> > > the
> >
> > There's "continue;" in there, and it should "just skip this thread".
> > 									Pavel
> 
> I meant, why not just do as in the following code (I've changed
> INTERESTING also, for same reason, as explained below):
> 
> 	do {
> 		todo = 0;
> 		read_lock(&tasklist_lock);
> 		do_each_thread(g, p) {
> 			unsigned long flags;
> 
>                         if (
> 				!(p->flags & PF_IOTHREAD) &&
> 				(p != current) &&
> 				(p->state != TASK_ZOMBIE) &&
> 				!(p->flags & PF_FROZEN)
> 			) {
> 
> 				/* FIXME: smp problem here: we may not access other process' flags
> 				   without locking */
> 				p->flags |= PF_FREEZE;
> 				spin_lock_irqsave(&p->sig->siglock, flags);
> 				signal_wake_up(p);
> 				spin_unlock_irqrestore(&p->sig->siglock, flags);
> 				todo++;
> 			}
> 		} while_each_thread(g, p);
> 		read_unlock(&tasklist_lock);
> 		yield();
> 		if (time_after(jiffies, start_time + TIMEOUT)) {
> 			printk( "\n" );
> 			printk(KERN_ERR " stopping tasks failed (%d tasks remaining)\n", todo );
> 			return todo;
> 		}
> 	} while(todo);
> 
> The reason is that yield(), which sends the current task to the expired list,
> can take a long time before it runs again.  With the current code, every time
> you meet, for example, a kernel thread you break out of the loop, perform
> a yield (= wait a long time), before going on to the next thread.  This could
> take forever.  With code like that above, you mark as many tasks frozen as
> possible, with as few yields as possible.  Isn't that better?
> 
> Ciao,
> 
> Duncan.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

