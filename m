Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132297AbQLQDlo>; Sat, 16 Dec 2000 22:41:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132303AbQLQDle>; Sat, 16 Dec 2000 22:41:34 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:13328 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S132297AbQLQDlU>; Sat, 16 Dec 2000 22:41:20 -0500
Date: Sat, 16 Dec 2000 19:09:56 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-test13-pre1 lockup: run_task_queue or tty_io are wrong
In-Reply-To: <20001217034928.A410@ppc.vc.cvut.cz>
Message-ID: <Pine.LNX.4.10.10012161859340.23256-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 17 Dec 2000, Petr Vandrovec wrote:
>   my 2.4.0-test13-pre1 just stopped answering to my keystrokes.
> I've found that it is looping in tqueue_bh and flush_to_ldisc
> still again and again.

Thanks, I think you found the big problem with test12.

> Is current run_task_queue() behavior intentional, or is it
> only bug introduced by changing task queue to list based
> implementation?

It's a bug.

Ho humm. I'll have to check what the proper fix is. Right now the rule is
that nobody can _ever_ remove himself from a task queue, although there is
one bad user that does exactly that, and that means that it should be ok
to just cache the "next" pointer in run_task_queue(), and make it look
something like

	static void run_task_queue(task_queue *list)
	{
		if (!list_empty(list)) {
			unsigned long flags;
			struct list_head *next;

			spin_lock_irqsave(&tqueue_lock, flags);
			next = list->next;
			while (next != list) {
				struct list_head *curr;
				void *arg;
				void (*f) (void *);  
				struct tq_struct *p;

				curr = next;
				next = next->next;
				list_del(curr);

				p = list_entry(curr, struct tq_struct, list);
				arg = p->data;
				f = p->routine;
				p->sync = 0;
				spin_unlock_irqrestore(&tqueue_lock, flags);

				if (f)
					f(arg);

				spin_lock_irq(&tqueue_lock);
			}
			spin_unlock_irqrestore(&tqueue_lock, flags);
		}
	}
				
which basically will never re-start at the head if a tq re-inserts iself
(side note: new entires are inserted at the end, but if it was already the
last entry then re-inserting it will not re-execute it, should this should
avoid your problem).

Does this fix the problem for you?

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
