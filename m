Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279926AbRKFSSG>; Tue, 6 Nov 2001 13:18:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279925AbRKFSR4>; Tue, 6 Nov 2001 13:17:56 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:8204 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S279917AbRKFSRw>; Tue, 6 Nov 2001 13:17:52 -0500
Date: Tue, 6 Nov 2001 10:14:41 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Using %cr2 to reference "current"
In-Reply-To: <E161AkQ-0001Fp-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0111061006150.2222-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 6 Nov 2001, Alan Cox wrote:
>
> Our memory bloat is already pretty gross in 2.4 without adding 16K task
> stacks to the oversided struct page, bootmem and excess double linked lists.

There are some people who think that the 5kB stack we have now is too
small ;(

> I also need to try sticking a pointer to the task struct at the top of the
> stack and loading that - since that should be a cache line that isnt being
> shared around or swapped between processors

That should work fairly well, and has the advantage that you can hide more
state there if you want (ie it allows us, on demand, to move hot state of
"struct task_struct" up there).

There is a subset of "struct task_struct" that is basically completely
local to the task, and could be advantageous to move around. Things like

 - need_resched/sigpending/process attributes
 - ptrace
 - processor
 - addr_limit

are all things that we don't actually _need_ to go all the way to the task
structure to fetch, and that we mostly need to modify anyway on task
switch (ie "need_resched" and "processor" both need to be written on
task-switch anyway, and are not touched by anything other CPU)

So it would basically be a small per-CPU/thread area, not just the "struct
task_struct".

		Linus

