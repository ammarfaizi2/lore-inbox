Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266144AbTGDTwe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jul 2003 15:52:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266151AbTGDTwe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jul 2003 15:52:34 -0400
Received: from air-2.osdl.org ([65.172.181.6]:55212 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266144AbTGDTw2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jul 2003 15:52:28 -0400
Date: Fri, 4 Jul 2003 13:06:50 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
cc: benh@kernel.crashing.org,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <linuxppc-dev@lists.linuxppc.org>, <linuxppc64-dev@lists.linuxppc.org>
Subject: Re: [PATCH 2.5.73] Signal stack fixes #1 introduce PF_SS_ACTIVE
In-Reply-To: <20030704193848.GG22152@wohnheim.fh-wedel.de>
Message-ID: <Pine.LNX.4.44.0307041259050.10035-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 4 Jul 2003, Jörn Engel wrote:
> 
> So some application has it's signal handler on the signal stack and
> instead of returning to the kernel, it detect where it left off before
> the signal, mangles the last two stack frames, and goes back directly?

Yeah, basically a lot of old threading stuff did the equivalent of 
longjump by hand.

It is entirely possible that they do not do this out of signal handlers, 
since that has its own set of problems anyway, and one of the reasons for 
doing co-operative user level threading is to not need locking, and thus 
you never want to do any thread switching asynchronously (eg from a signal 
context).

So I'm not saying that your patch will necessarily break stuff, I'm just 
pointing out that it was actually done the way it is done on purpose.

> If this is correct, it definitely saves a lot of time, but it also
> means that the kernel has no way to ever detect a broken signal
> handler, if it operates from the signal stack.

Sure it does. It can detect just about _any_ brokenness, except for the 
very rare case of total stack pointer corruption.

> What is the point of the seperate signal stack anyway.  I like it,
> because it allows me to handle signals, even when the normal stack is
> broken for some reason.

The people who use it tend to do user-space memory management, and for 
example put hard limits on their stack usage - possibly because they have 
a lot of stacks because they use threads.

Most of the time if the original stack is blown, the fault is
non-recoverable. But you can use the alternate stack to either just give a 
nice debug message (even in the presense of otherwise non-recoverable 
errors), _or_ you can actually do things like fix up the stack 
dynamically.

Quite frankly, for the recursive SIGSEGV problem, I'd much rather look at
the signal mask. If SIGSEGV is blocked, we should probably just kill the
program instead of clearing the blocking and trying to handle the SIGSEGV 
anyway. That should fix your test case, _without_ any subtle side effects.

		Linus

