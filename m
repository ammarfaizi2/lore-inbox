Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288921AbSAZBz1>; Fri, 25 Jan 2002 20:55:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288954AbSAZBzI>; Fri, 25 Jan 2002 20:55:08 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:48390 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S288921AbSAZBy5>; Fri, 25 Jan 2002 20:54:57 -0500
Date: Fri, 25 Jan 2002 17:53:57 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andi Kleen <ak@suse.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] syscall latency improvement #1
In-Reply-To: <p73y9il7vlr.fsf@oldwotan.suse.de>
Message-ID: <Pine.LNX.4.33.0201251741430.16917-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 26 Jan 2002, Andi Kleen wrote:
>
> It doesn't explain the Athlon speedups. On athlon cli is ~4 cycles.

.. and it probably serializes the instruction stream.

Look at the patch.

The _only_ thing it does for the system call path is:

 - remove the "cli"

 - change

	cmpl $0,..
	jne
	cmp $0,..
	jne

   into

	movl ..,reg
	testl reg,reg
	jne

and the latter may be worth a cycle (or two, if the CPU happens to like
the second form better for some other reason), but it's certainly not
noticeable.

A 3.4% improvement is equivalent to something like 9 cycles, so the "cli"
being faster on Athlon than on a PIII certainly explains why it's less
noticeable on the Athlon, but it still makes me suspect that the _real_
cost of the cli is on the order of 8 cycles.

It should be eminently testable. Just remove the cli from the standard
kernel, and do before-and-after tests.

		Linus

