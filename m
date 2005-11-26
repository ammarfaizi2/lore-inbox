Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750710AbVKZSra@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750710AbVKZSra (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Nov 2005 13:47:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750711AbVKZSra
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Nov 2005 13:47:30 -0500
Received: from smtp.osdl.org ([65.172.181.4]:50827 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750710AbVKZSr3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Nov 2005 13:47:29 -0500
Date: Sat, 26 Nov 2005 10:47:13 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Oleg Nesterov <oleg@tv-sign.ru>
cc: Ingo Molnar <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Roland McGrath <roland@redhat.com>
Subject: Re: [PATCH 1/2] PF_DEAD: cleanup usage
In-Reply-To: <4388B5AA.34CE5294@tv-sign.ru>
Message-ID: <Pine.LNX.4.64.0511261023500.13959@g5.osdl.org>
References: <4385E3FF.C99DBCF5@tv-sign.ru> <20051125051232.GB22230@elte.hu>
  <Pine.LNX.4.64.0511250950450.13959@g5.osdl.org> <43883D01.8CCB31A6@tv-sign.ru>
 <Pine.LNX.4.64.0511260949030.13959@g5.osdl.org> <4388B5AA.34CE5294@tv-sign.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 26 Nov 2005, Oleg Nesterov wrote:
> 
> Ok, I see you point now, thanks.

Well, in all fairness, it's entirely possible (nay, likely) that PF_DEAD 
just isn't relevant the way it used to be.

Looking at the history, the immediate reason for PF_DEAD was (I think) 
that we had a race where we would first mark the task as a ZOMBIE, and 
then if it was self-reaping, we'd mark it dead in release_task(). But we 
dropped the tasklist_lock in between, which meant that the real parent 
could come in and reap it just before it reaped itself, and all hell would 
break lose. 

That bug was fixed sixteen hours after PF_DEAD was introduced (thanks to a 
bug-on on PF_DEAD that never even made the kernel history, I suspect), and 
I doubt PF_DEAD has done anything for us since (and this was two years 
ago).

What I'm trying to say is that it's entirely possible that your cleanup is 
just way overdue, and we shouldn't have that separate PF_DEAD thing any 
more. My arguments against your patch is mainly me just being nervous, and 
I'm not 100% convinced they are valid and good arguments.

HOWEVER. I just noticed something strange. EXIT_DEAD should be in 
"task->exit_state", not in "task->state". So there's something strange 
going on in that neck of the woods _anyway_. That whole

	...
        if (unlikely(prev->flags & PF_DEAD))
                prev->state = EXIT_DEAD;
	...

in kernel/sched.c seems totally bogus.

I think we should remove that thing entirely, since it's actually a total 
no-op, apart from doing something that is actively wrong. The "exit_state" 
flag should already _be_ EXIT_DEAD, no? And the "task->state" flag should 
never be EXIT_DEAD in the first place.

And now that "exit_state" is already separate from "state", the reason for 
PF_DEAD really is gone, and it could be replaced with a

	tsk->exit_state & EXIT_DEAD

test instead.

Roland added to Cc:, because the exit_state splitup was his, I think.

Oleg? Roland?

			Linus
