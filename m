Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264256AbSIQPlW>; Tue, 17 Sep 2002 11:41:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264297AbSIQPlW>; Tue, 17 Sep 2002 11:41:22 -0400
Received: from mx2.elte.hu ([157.181.151.9]:12226 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S264256AbSIQPlV>;
	Tue, 17 Sep 2002 11:41:21 -0400
Date: Tue, 17 Sep 2002 17:53:33 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Robert Love <rml@tech9.net>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] BUG(): sched.c: Line 944
In-Reply-To: <Pine.LNX.4.44.0209170834210.4144-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0209171750140.4094-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 17 Sep 2002, Linus Torvalds wrote:

> 	void schedule(void)
> 	{
> 		BUG_ON(in_atomic());
> 		BUG_ON(current->state & TASK_ZOMBIE);
> 		do_schedule();
> 	}
> 
> 	void exit_schedule(void)
> 	{
> 		BUG_ON(!(current->state & TASK_ZOMBIE));
> 		do_schedule();
> 	}

i'd rather do it the other way around - ie. do a:

	if (unlikely(current->state == TASK_ZOMBIE)) {
		... exit checks ...
	} else {
		... normal checks ...
	}

this test is cheaper than a function call. I'd say the ZOMBIE check alone
is not significant enough to introduce a function split in the hotpath.  
This check is also easier to remove later on.

TASK_ZOMBIE is only ever allowed to be set for exiting tasks. [and if
TASK_ZOMBIE handling is broken then it will trigger the normal atomic
tests so it's not like we are silently ignoring those errors.]

	Ingo

