Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274966AbTHPVkF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 17:40:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274968AbTHPVkF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 17:40:05 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:55682 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S274966AbTHPVj5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 17:39:57 -0400
Date: Sat, 16 Aug 2003 22:39:01 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
Cc: Mike Galbraith <efault@gmx.de>, Con Kolivas <kernel@kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       gaxt <gaxt@rogers.com>
Subject: Re: Scheduler activations (IIRC) question
Message-ID: <20030816213901.GA25483@mail.jlokier.co.uk>
References: <20030815235431.GT1027@matchmail.com> <200308160149.29834.kernel@kolivas.org> <20030815230312.GD19707@mail.jlokier.co.uk> <20030815235431.GT1027@matchmail.com> <20030816005408.GA21356@mail.jlokier.co.uk> <5.2.1.1.2.20030816080614.01a0e418@pop.gmx.net> <20030816225427.Z639@nightmaster.csn.tu-chemnitz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030816225427.Z639@nightmaster.csn.tu-chemnitz.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Oeser wrote:
> Sounds more like a new futex feature: Wakeup after time expired.
>
> Then this "blocking" could be modeled as "blocking too long",
> which is how this kind of thing is handled more sanely anyway.

Nice idea, but it isn't quite right.  If my active task takes a second
in the system call, but doesn't block, I probably don't want the other
task to run at all.  There are occasions when a timer-initiated switch
like that would be useful, though.

The real problem is that if my active task blocks immediately,
e.g. because I call open() and it issues a disk I/O, I want to
continue handling the next work item as soon as the CPU is free.  Not
after 1ms or 10ms of CPU idle time.

The ideal is something like async I/O, but that only works for a
subset of I/O operations, and it isn't practical to extend it to the
more complex I/O operations efficiently.  (Inefficiently, yes, but I
may as well use my own helper threads if that's what aio would use).

This is a way to get equivalent efficiency to async I/O, that is
equivalent in terms of fully utilising the CPU(s) without lots of
threading contexts.  Therefore it should achive that, otherwise it
just isn't worth doing at all.

> The only thing that is disturbing about blocking, is blocking
> "too long". Blocking itself is ok, since it frees CPU time for
> other processes the programmer is completely unaware of.

No.  If there are other processes, the scheduler is perfectly able to
give time to them already.  It's wrong to give other processes
_additional_ time, over what they would already get.

Secondly, blocking is just a waste of time when there are no other
processes.  An idle CPU, reducing throughput and gaining nothing
(except a lower electricity bill, perhaps).

Thirdly, you're saying that I can have async system calls but I must
expect to give up some CPU time, either to the idle task or to someone
else.

In which case, I (like any other programmer) will choose to use
multiple threads instead and do it less efficiently, but at least my
program runs faster than it would with your suggestion - albeit with
less predictable response latencies :)

Conclusion - I like your idea, though it should work more like this:

   - Initiate wakeup of shadow task on timeout _or_ this task blocking.
   - Cancel wakeup of shadow task.

I don't know whether a modified futex or something else is right for it.

-- Jamie

