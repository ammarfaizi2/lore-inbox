Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131763AbRCUUbc>; Wed, 21 Mar 2001 15:31:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131775AbRCUUbW>; Wed, 21 Mar 2001 15:31:22 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:21508 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131763AbRCUUbS>; Wed, 21 Mar 2001 15:31:18 -0500
Date: Wed, 21 Mar 2001 12:29:55 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Mike Galbraith <mikeg@wen-online.de>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
        Rik van Riel <riel@conectiva.com.br>
Subject: Re: kswapd deadlock 2.4.3-pre6
In-Reply-To: <Pine.LNX.4.33.0103211853420.2398-100000@mikeg.weiden.de>
Message-ID: <Pine.LNX.4.31.0103211223480.9358-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 21 Mar 2001, Mike Galbraith wrote:
>
> I have a repeatable deadlock when SMP is enabled on my UP box.
>
> >>EIP; c021e29a <stext_lock+1556/677b>   <=====

When you see something like this, please do

	gdb vmlinux

	(gdb) x/10i 0xc021e29a

and it will basically show you where the code jumps back to.

It's almost certainly the beginning of swap_out_mm() where we get the
page_table_lock, but it would still be good to verify.

The deadlock implies that somebody scheduled with page_table_lock held.
Which would be really bad. You should be able to do something like

	if (current->mm && spin_is_locked(&current->mm->page_table_lock))
		BUG():

in the scheduler to see if it triggers (this only works on UP hardware
with a SMP kernel - on a real SMP machine it's entirely legal to have the
lock during a schedule, as the lock may be held by any of the _other_
CPU's, of course, and the above assert would be the wrong thing to do in
general)

Of course, it might not be somebody scheduling with a spinlock, it might
just be a recursive lock bug, but that sounds really unlikely.

> ac20+2.4.2-ac20-rwmmap_sem3 does not deadlock doing the same
> churn/burn via make -j30 bzImage.

it won't do the page table locking for page table allocations, so it will
have other bugs, though.

			Linus

