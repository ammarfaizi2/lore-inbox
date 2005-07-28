Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261371AbVG1KBv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261371AbVG1KBv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 06:01:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261374AbVG1KBu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 06:01:50 -0400
Received: from lirs02.phys.au.dk ([130.225.28.43]:27018 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S261359AbVG1J7X
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 05:59:23 -0400
Date: Thu, 28 Jul 2005 11:59:04 +0200 (METDST)
From: Esben Nielsen <simlo@phys.au.dk>
To: "K.R. Foley" <kr@cybsft.com>
Cc: Ingo Molnar <mingo@elte.hu>, Steven Rostedt <rostedt@goodmis.org>,
       LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC][PATCH] Make MAX_RT_PRIO and MAX_USER_RT_PRIO configurable
In-Reply-To: <42E7C777.7010400@cybsft.com>
Message-Id: <Pine.OSF.4.05.10507272159020.848-100000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 27 Jul 2005, K.R. Foley wrote:

> Esben Nielsen wrote:
> [...]
> 
> All of the RT priorities that we have are not absolutely necessary. As I 
> think Steven pointed out in another email, it is nice though to be able 
> to priortize tasks using large jumps in priorities and then being able 
> to fill in tasks that are dependent on other tasks in between. 

For portability you shouldn't hardcode your priorities anyway. You need
some sort of abstraction layer. It should be very simple to code one such 
you at least can avoid having gaps in your priorities. Making it figure
out who can share priorities is probably harder. 
Under all circumstances: You are stressing the system run-time because you
didn't do a proper job compile and boot time. 

> Even if 
> you think of nothing but the IRQ handlers, the 5-10 priorities quickly 
> get crowded without any user tasks.

Why do the irq-handlers need _different_ priorities? Do they really have
to preempt each other? It is likely that  the longest handler runs
longer than the accepted latency for the most critical handler. Thus the
most critical handler has to preempt that one. But I bet you don't have a
system with 10 interrupts source where handler 1 needs to preempt handler 
2, handler 2 needs to preempt handler 3 etc. At most you have a system
where handlers 1-3 need to preempt handlers 4-10 (and the application)
handler 4 and 5 need to preempt handler 6-10, while handlers 6-10 don't
need to preempt any of the other handlers. In that case you only need 3
priorities, not 5-10. (The highest priority can very well be hard-irq
context :-). 
Then add 2 RT priorities for your application. You need one thread to
handle the data from the high priority interrupt and 1 for the middle
interrupt. You thus have 5 RT priorities
 1: handlers 1-3 (can be in hard irq)
 2: application thread 1
 3: handlers 4 and 5
 4: application thread 2
 5: the rest of the irq handlers

Even as your application grows big it doesn't help throwing in more
priorities. If a task runs for very long and have a low latency limit you
will have a hard time no matter what you do. If all the low latency stuff
runs sufficient fast it can just as well run with FIFO priority wrt. each
other.
And even if you split the stuff up in seperate OS threads giving them the
same RT priority and FIFO policy will make things run faster due to fewer
task switches. Preemption is expensive. Even though you want it, you
should design your system such it doesn't happen too often.

Esben

> 
> 
> -- 
>     kr
> 


