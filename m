Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262662AbVAVDF5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262662AbVAVDF5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 22:05:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262658AbVAVDF4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 22:05:56 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:34879
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262656AbVAVDEi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 22:04:38 -0500
Date: Sat, 22 Jan 2005 04:04:38 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Mauricio Lin <mauriciolin@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Edjard Souza Mota <edjard@gmail.com>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: User space out of memory approach
Message-ID: <20050122030438.GE11112@dualathlon.random>
References: <3f250c71050110134337c08ef0@mail.gmail.com> <20050110192012.GA18531@logos.cnet> <4d6522b9050110144017d0c075@mail.gmail.com> <20050110200514.GA18796@logos.cnet> <1105403747.17853.48.camel@tglx.tec.linutronix.de> <20050111083837.GE26799@dualathlon.random> <3f250c71050121132713a145e3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f250c71050121132713a145e3@mail.gmail.com>
X-AA-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-AA-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
X-Cpushare-GPG-Key: 1024D/4D11C21C 5F99 3C8B 5142 EB62 26C3  2325 8989 B72A 4D11 C21C
X-Cpushare-SSL-SHA1-Cert: 3812 CD76 E482 94AF 020C  0FFA E1FF 559D 9B4F A59B
X-Cpushare-SSL-MD5-Cert: EDA5 F2DA 1D32 7560  5E07 6C91 BFFC B885
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 21, 2005 at 05:27:11PM -0400, Mauricio Lin wrote:
> Hi Andrea,
> 
> I applied your patch and I am checking your code. It is really a very
> interesting work. I have a question about the function
> __set_current_state(TASK_INTERRUPTIBLE) you put in out_of_memory
> function. Do not you think it would be better put set_current_state
> instead of __set_current_state function? AFAIK the set_current_state
> function is more feasible for SMP systems, right?

set_current_state is needed only when you need to place a memory barrier
after __set_current_state. So it's needed in the usual wait_event loop,
right after registering in the waitqueue. Example:

	unsigned long flags;

	wait->flags &= ~WQ_FLAG_EXCLUSIVE;
	spin_lock_irqsave(&q->lock, flags);
	if (list_empty(&wait->task_list))
		__add_wait_queue(q, wait);
	/*
	 * don't alter the task state if this is just going to
	 * queue an async wait queue callback
	 */
	if (is_sync_wait(wait))
		set_current_state(state);
	spin_unlock_irqrestore(&q->lock, flags);

and even in the above is needed only because spin_unlock has inclusive
semantics in ia64. In 2.4 there was no unlock at all after
set_current_state and it was like this:


		set_current_state(TASK_UNINTERRUPTIBLE);
\
		if (condition)
\
			break;
\
		schedule();
\

The rule of thumb is that if there's nothing between set_current_state
and schedule() then __set_current_state is more efficient and equally
safe to use. And the oom killer path I posted falls in this category,
nothing in between set_current_state and schedule, so no reason to place
memory barries in there.

Hope this helps ;)
