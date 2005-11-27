Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751006AbVK0Lza@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751006AbVK0Lza (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Nov 2005 06:55:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751007AbVK0Lza
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Nov 2005 06:55:30 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:3236 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751003AbVK0Lz3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Nov 2005 06:55:29 -0500
Date: Sun, 27 Nov 2005 12:55:36 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Oleg Nesterov <oleg@tv-sign.ru>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 1/2] PF_DEAD: cleanup usage
Message-ID: <20051127115536.GA22229@elte.hu>
References: <4385E3FF.C99DBCF5@tv-sign.ru> <20051125051232.GB22230@elte.hu> <Pine.LNX.4.64.0511250950450.13959@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0511250950450.13959@g5.osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -1.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.5 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	1.3 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@osdl.org> wrote:

> > > I think it is better to set EXIT_DEAD in do_exit(), along with PF_DEAD 
> > > flag.
> > 
> > nice idea - your patch looks good to me.
> 
> I'm not entirely convinced.
> 
> The thing is, We used to have DEAD in the task state flags, ie 
> TASK_ZOMBIE was it.
> 
> We started using PF_DEAD in 2003 with this commit message:
> 
> Author: Linus Torvalds <torvalds@home.osdl.org>  2003-10-26 03:16:23
> 
>     Add a sticky "PF_DEAD" task flag to keep track of dead processes.
>     
>     Use this to simplify 'finish_task_switch', but perhaps more
>     importantly we can use this to track down why some processes
>     seem to sometimes not die properly even after having been
>     marked as ZOMBIE. The "task->state" flags are too fluid to 
>     allow that well.
> 
> ie the PF_DEAD flag was never really about is _needing_ it: it was all 
> about being able to safely check it _without_ having to rely on 
> task->state.

but this was in times when we did alot of nontrivial operations after we 
marked a task "dead". Today we do this:

        /* PF_DEAD causes final put_task_struct after we schedule. */
        preempt_disable();
        BUG_ON(tsk->flags & PF_DEAD);
        tsk->flags |= PF_DEAD;

        schedule();
        BUG();

(i introduced the above changes to make more of the exit path 
preemptable.)

PF_DEAD has zero relevance by today, and Oleg's patches are perfectly 
correct and dont add the kind of risk that they'd have meant in 2003.

> So putting it back into task->state is not wrong per se, but it kind 
> of misses the point of why it was somewhere else in the first place 
> (or rather, why it was there in the _second_ place, since it was in 
> task->state in the first place and got moved out of there).

yeah, PF_DEAD had its purpose back when we first marked a task dead, 
then we did the release_task(). We used to have problems with 
proc_pid_flush() which could sleep, which would lose the TASK_ZOMBIE or 
TASK_DEAD flag and we'd come back from the 'final' schedule().

today that's impossible, due to the code above - we only mark it PF_DEAD 
straight before going into the final schedule().

	Ingo
