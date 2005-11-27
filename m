Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751013AbVK0MSb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751013AbVK0MSb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Nov 2005 07:18:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751014AbVK0MSb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Nov 2005 07:18:31 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:17314 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751012AbVK0MSb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Nov 2005 07:18:31 -0500
Date: Sun, 27 Nov 2005 13:18:35 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Oleg Nesterov <oleg@tv-sign.ru>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Roland McGrath <roland@redhat.com>
Subject: Re: [PATCH 1/2] PF_DEAD: cleanup usage
Message-ID: <20051127121835.GB22229@elte.hu>
References: <4385E3FF.C99DBCF5@tv-sign.ru> <20051125051232.GB22230@elte.hu> <Pine.LNX.4.64.0511250950450.13959@g5.osdl.org> <43883D01.8CCB31A6@tv-sign.ru> <Pine.LNX.4.64.0511260949030.13959@g5.osdl.org> <4388B5AA.34CE5294@tv-sign.ru> <Pine.LNX.4.64.0511261023500.13959@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0511261023500.13959@g5.osdl.org>
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

> Well, in all fairness, it's entirely possible (nay, likely) that 
> PF_DEAD just isn't relevant the way it used to be.

yes, that's the case. I do believe we should go with Oleg's original 
patches.

> Looking at the history, the immediate reason for PF_DEAD was (I think) 
> that we had a race where we would first mark the task as a ZOMBIE, and 
> then if it was self-reaping, we'd mark it dead in release_task(). But 
> we dropped the tasklist_lock in between, which meant that the real 
> parent could come in and reap it just before it reaped itself, and all 
> hell would break lose.

yeah. Another problem was if we accidentally scheduled somewhere after 
the task was marked TASK_DEAD. (That used to be caught by another 
PF_DEAD check before the final schedule()).

all this stuff got changed as part of the PREEMPT_VOLUNTARY changes, and 
now we exit in a much more robust way.

> HOWEVER. I just noticed something strange. EXIT_DEAD should be in 
> "task->exit_state", not in "task->state". So there's something strange 
> going on in that neck of the woods _anyway_. That whole
> 
> 	...
>         if (unlikely(prev->flags & PF_DEAD))
>                 prev->state = EXIT_DEAD;
> 	...
> 
> in kernel/sched.c seems totally bogus.

no, it's not bogus. PF_DEAD is basically just a fancy, persistent flag 
for "mark the task state as EXIT_DEAD atomically before the final 
schedule". The TASK_DEAD flag is still necessary so that we dont stay on 
the runqueue. [we could use TASK_UNINTERRUPTIBLE - it should just not be 
TASK_RUNNING or TASK_INTERRUPTIBLE.]

in any case, i agree with Oleg's patches: with the current code it's 
unnecessary to signal towards schedule() to turn the PF_DEAD flag into 
EXIT_DEAD - we can do it right where we set PF_DEAD: immediately before 
calling the final schedule(). PF_DEAD is a relic from the days when the 
exit path was structured differently.

	Ingo
