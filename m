Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262633AbREVQvO>; Tue, 22 May 2001 12:51:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262650AbREVQvE>; Tue, 22 May 2001 12:51:04 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:3345 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262633AbREVQu5>; Tue, 22 May 2001 12:50:57 -0400
Date: Tue, 22 May 2001 09:50:48 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Akash Jain <aki51@acura.stanford.edu>
cc: su.class.cs99q@nntp.stanford.edu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]drivers/net/wan/lmc/lmc_main.c
In-Reply-To: <20010521204844.A2399@acura.stanford.edu>
Message-ID: <Pine.LNX.4.21.0105220949240.19531-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 21 May 2001, Akash Jain wrote:
>
> Sorry if this is reposted, previous one seemed to get tied up.
> Here is a patch to the drivers/net/wan/lmc/lmc_main.c file.

I got the previous one, here's a copy of my reply to the people who
weren't cc'd on that one.

		Linus

--- in a previous email, Linus wrote ---

lmc_main.c is _soo_ broken than this patch only scratches the surface and
only hides a small small part of the offenders.

In particular, the fact that it does allocations with GFP_KERNEL while
holding a spinlock is the _least_ of its troubles: it also does a
"copy_from/to_user()" while holding the same spinlock (and has timeouts
of up to half a second with interrupts disabled from the same spinlock).

The kmalloc() is likely to succeed: a copy_from_user() can be trivially
made to cause IO every time by a wily user.

In short, the whole locking strategy is broken, and there's no way to fix
it with small micro-patches. So not applied.

(And it also looks like your sanity checker doesn't trap "copy to/from
user space with spinlocks held or irq's disabled", hint hint ;).

Btw, what's the right address to send this kind of feedback to the
stanford group? 

Good work by the checker, btw. it's not your fault that the problem goes
deeper than what you found.

        Thanks,

                Linus

