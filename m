Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287109AbSBKGVF>; Mon, 11 Feb 2002 01:21:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287289AbSBKGUz>; Mon, 11 Feb 2002 01:20:55 -0500
Received: from zero.tech9.net ([209.61.188.187]:1294 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S287109AbSBKGUl>;
	Mon, 11 Feb 2002 01:20:41 -0500
Subject: Re: 2.5.4 Compile Error
From: Robert Love <rml@tech9.net>
To: John Weber <weber@nyc.rr.com>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org
In-Reply-To: <3C675E6B.4010605@nyc.rr.com>
In-Reply-To: <3C674CFA.2030107@nyc.rr.com>
	<3C6750CD.46575DAA@mandrakesoft.com>  <3C675E6B.4010605@nyc.rr.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 11 Feb 2002 01:20:46 -0500
Message-Id: <1013408447.806.409.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-02-11 at 01:02, John Weber wrote:

> The function thread_saved_pc() is a mystery to me.  It is declared with 
> a return type of unsigned long, and yet return this:
> 
> ((unsigned long *)tsk->thread->esp)[3]
> 
> This is confusing to me in many ways:
> - the "thread" member of task struct is not a pointer
> - esp is of type unsigned long, so I don't understand the cast, and
> I certainly don't understand the [3] here.
> 
> Can anyone explain this code to me?

The problem is an interdependency between processor.h and sched.h.

The old code was the same, except it did

	t->esp

where t was a thread_struct, instead of what we do now

	t->thread->esp

where t is a task_struct.  And thus whereby before we passed

	p->thread

as the argument, now you pass just `p'.  I.e., its the same net-affect. 
The error is because the function needs access to both task_struct (in
sched.h) and thread_struct (in processor.h) but the two are interrelated
so we can't include them in each other.

The contents of esp is a memory address, so typecasting it to (unsigned
long *) is OK.

As for the [3], p[3] is the same as
	*(p+3)
ie,
	*(p+sizeof(p))
so that is legal.

So the fix, aside from reverting this change and the kernel/sched.c
change and the sparc64 changes ... would be to solve the dependency
issue.

	Robert Love

