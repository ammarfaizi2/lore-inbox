Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266263AbRGYAjl>; Tue, 24 Jul 2001 20:39:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266293AbRGYAjc>; Tue, 24 Jul 2001 20:39:32 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:41999 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S266263AbRGYAjV>; Tue, 24 Jul 2001 20:39:21 -0400
From: Linus Torvalds <torvalds@transmeta.com>
Date: Tue, 24 Jul 2001 17:37:34 -0700
Message-Id: <200107250037.f6P0bYw29925@penguin.transmeta.com>
To: washer@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: switch_mm() can fail to load ldt on SMP
Newsgroups: linux.dev.kernel
In-Reply-To: <200107242241.PAA05423@crg8.sequent.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

In article <200107242241.PAA05423@crg8.sequent.com> you write:
>
>We've run into a small bug in switch_mm() which results in a process
>running with a 'stale' ldt.

Good job.

>The first fix would be to patch switch_mm(), so that when the next and
>prev mm pointers are equal, it checks to see if mm->context.segments
>is non-null, if so, it calls load_LDT(). This will unfortunately lead
>to many unnecessary calls to load_LDT(). An enhanced version of this
>fix, would involve introducing a bit array into the mm_struct, one
>bit per cpu. When write_ldt() first allocates the ldt for this mm_struct,
>it would set all bits. Subsequently, in switch_mm(), we could
>introduce  a test such as
>        if(next->context.segments &&
>        test_and_clear_bit(cpu,&next->ldtupdate))load_LDT(next);

This is actually how the "mmu_context" struct is meant to be used: it's
there exactly for per-architecture context bits, and when I did the x86
part I incorrectly thought that the x86 doesn't have any MMU context.
You're obviously right that it has context, and part of the context is
just the list of CPU's that have seen the new LDT.

>Which fix is better depends on the system and application. On a system
>with hundreds of processes sharing the same mm_struct, the first fix
>will result in quite a few calls to load_LDT(). On a system with a large
>number of cpus, and short lived programs using segments, the IPI will
>be wasteful.

Done right, you should have
 - processes with a NULL segment have mm->context.ldtinvalid = 0
 - setldt() sets all bits in "mm->context.ldtinvalid"
 - switch_mm() does (in the CONFIG_SMP "else {" part)
	if (test_and_clear_bit(cpu, &next->context.ldtinvalid))
		load_LDT(next);

which has _no_ extra LDT loads except when required, and only adds one
bit clear-and-test for the one case that needs it (SMP with same mm's)

Would you like to code up this, test it and send it to me?

Btw, good debugging!

		Linus "lazy is my middle name" Torvalds
