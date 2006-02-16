Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932506AbWBPAwi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932506AbWBPAwi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 19:52:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932271AbWBPAwi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 19:52:38 -0500
Received: from smtp.osdl.org ([65.172.181.4]:23518 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932263AbWBPAwh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 19:52:37 -0500
Date: Wed, 15 Feb 2006 16:52:27 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: rmk+lkml@arm.linux.org.uk, Ingo Molnar <mingo@elte.hu>,
       frankeh@watson.ibm.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: SMP BUG
In-Reply-To: <20060215153013.474ff5e0.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0602151647260.22082@g5.osdl.org>
References: <43F12207.9010507@watson.ibm.com> <20060215230701.GD1508@flint.arm.linux.org.uk>
 <Pine.LNX.4.64.0602151521320.22082@g5.osdl.org> <20060215153013.474ff5e0.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 15 Feb 2006, Andrew Morton wrote:
> 
> I thought that patch wasn't a good one.  The runqueues should be
> initialised in sched_init().  init_idle() is called from fork_idle() which
> is called from the bowels of arch code.  I'm not sure that it gets called
> at all if !SMP (which seems strange).

sched_init() calls init_idle for the current CPU.

Perhaps more importantly, every _single_ CPU that comes up must call 
init-idle pretty much by definition. It's really what starts the whole 
scheduling thing - the scheduler itself very much depends on the "idle" 
task for each CPU.

So the reason I thought that Rik's patch was a cleanup was not because it 
was needed (initializing cpu_possible_map early should fix up the 
problems), but because it would actually be a very natural thing to do to 
to initialize the scheduler data structures as part of init-idle. The 
scheduler really isn't initialized until it has an idle thread anyway.

init_idle() already does part of the scheduler initializations, a pretty 
fundamental part, in fact:

	rq->curr = rq->idle = idle;

and the fact that "sched_init()" does some _other_ part of scheduler data 
structure initialization is actually just ugly.

So I like Rik's patch, but I don't feel _too_ strongly about it. The 
people who actually work on the scheduler should be the ones to sign off 
(or not) on it.

		Linus
