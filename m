Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131499AbRABUWe>; Tue, 2 Jan 2001 15:22:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131624AbRABUWZ>; Tue, 2 Jan 2001 15:22:25 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:51974 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131499AbRABUWQ>; Tue, 2 Jan 2001 15:22:16 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: [PATCH] move xchg/cmpxchg to atomic.h
Date: 2 Jan 2001 11:51:23 -0800
Organization: Transmeta Corporation
Message-ID: <92tbfr$okp$1@penguin.transmeta.com>
In-Reply-To: <20010102125924.A9538@gruyere.muc.suse.de> <E14DV5K-0002Xn-00@the-village.bc.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <E14DV5K-0002Xn-00@the-village.bc.nu>,
Alan Cox  <alan@lxorguk.ukuu.org.uk> wrote:
>> > We really can't.  We _only_ have load-and-zero.  And it has to be 16-byte
>> > aligned.  xchg() is just not something the CPU implements.
>> 
>> The network code relies on the reader-xchg semantics David described in 
>> several places.
>
>I guess the network code will just have to change for 2.5. read_xchg_val()
>can be a null macro for everyone else at least

You can easily do reader-xchg semantics even if you don't have an atomic
xchg and are using spinlocks. In fact, it will work the obvious way
correctly, assuming that the reader either gets the old value or the new
value but not some "partway old and new".

A xchg() that uses spinlocks and a simple read+write inside the spinlock
will give that exact behaviour as long as the "load-and-zero" is not
used for the xchg _value_, but only used for the spinlock, which is the
obvious implementation.

So we're fine. The parisc implementation isn't the fastest in the world,
but hey, that's what you get for having bad hardware support for SMP.

		Linus
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
