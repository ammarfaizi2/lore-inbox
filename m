Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311839AbSDDW4Z>; Thu, 4 Apr 2002 17:56:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311871AbSDDW4Q>; Thu, 4 Apr 2002 17:56:16 -0500
Received: from zero.tech9.net ([209.61.188.187]:50185 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S311839AbSDDWz6>;
	Thu, 4 Apr 2002 17:55:58 -0500
Subject: Re: Patch: linux-2.5.8-pre1/kernel/exit.c change caused BUG() at
	boot  time
From: Robert Love <rml@tech9.net>
To: Andrew Morton <akpm@zip.com.au>
Cc: Roger Larsson <roger.larsson@norran.net>,
        Linus Torvalds <torvalds@transmeta.com>,
        Dave Hansen <haveblue@us.ibm.com>,
        "Adam J. Richter" <adam@yggdrasil.com>, linux-kernel@vger.kernel.org
In-Reply-To: <3CACD5D3.B2DA02AE@zip.com.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 04 Apr 2002 17:55:25 -0500
Message-Id: <1017960927.22299.634.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-04-04 at 17:38, Andrew Morton wrote:

> With the appropriate locking, memory barriers and other
> relevant goo I think this would work...

Yah, I guess, but that isn't pretty at all ;)

Andrew, remember how we used to do it (and still do it in the 2.4
patch)?  Wouldn't that work?  Specifically, when we enter
preempt_schedule we set a flag value in preempt_count.  This flag value
is checked at the top of schedule and, if set, we skip the first chunk
of code that handles sleeping tasks.  The task->state never changes. 
Upon leaving schedule and returning to preempt_schedule, we unset the
flag.

This allows us to preempt tasks in any state, without problems or
special cases.  It also wasn't too much overhead - compared to now,
basically just:

	if (unlikely(current->preempt_count() & PREEMPT_ACTIVE))
		goto pick_next_task;

at the top of schedule().

	Robert Love

