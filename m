Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751083AbVKZRz7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751083AbVKZRz7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Nov 2005 12:55:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751110AbVKZRz7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Nov 2005 12:55:59 -0500
Received: from smtp.osdl.org ([65.172.181.4]:55427 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751083AbVKZRz7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Nov 2005 12:55:59 -0500
Date: Sat, 26 Nov 2005 09:55:46 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Oleg Nesterov <oleg@tv-sign.ru>
cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 1/2] PF_DEAD: cleanup usage
In-Reply-To: <43883D01.8CCB31A6@tv-sign.ru>
Message-ID: <Pine.LNX.4.64.0511260949030.13959@g5.osdl.org>
References: <4385E3FF.C99DBCF5@tv-sign.ru> <20051125051232.GB22230@elte.hu>
 <Pine.LNX.4.64.0511250950450.13959@g5.osdl.org> <43883D01.8CCB31A6@tv-sign.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 26 Nov 2005, Oleg Nesterov wrote:
> > 
> > So putting it back into task->state is not wrong per se, but it kind of
> > misses the point of why it was somewhere else in the first place (or
> > rather, why it was there in the _second_ place, since it was in
> > task->state in the first place and got moved out of there).
> 
> schedule:
> 
> 	if (unlikely(prev->flags & PF_DEAD))
> 		prev->state = EXIT_DEAD;
> 
> Which means: "If PF_DEAD is set, ignore ->state value. It should be TASK_RUNNING,
> but we have to change it, otherwise the task won't be deactivated. We are using
> EXIT_DEAD (which should live only in ->exit_state) because other TASK_XXX values
> won't work".
> 
> So in my opinion PF_DEAD has already slipped into the ->state partly.

You mis-understand.

PF_DEAD has _always_ been about the task state, in a very serious way. It 
didn't "slip into" it. It always was very much about it.

The problem is that we touch "task->state" in a _lot_ of places: for 
example, when we take a page fault, we have to clear it, because we can't 
just run with some random task state (see top of __handle_mm_fault). 

PF_DEAD was a "safe haven". It's somewhere that we _don't_ modify the word 
in many places, so it doesn't get lost, and we can do sanity checking (ie 
we can have things like "BUG_ON(tsk->flags & PF_DEAD)" to make sure that 
the task really is valid in a few places. 

Now, arguably the task struct handling is solid enough that maybe we don't 
need this any more. But this is what it was all about: it was hidden away 
in a non-obvious place exactly _because_ we wanted it hidden away 
somewhere where the normal ops wouldn't ever touch it.

			Linus
