Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264644AbRGSBBE>; Wed, 18 Jul 2001 21:01:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264669AbRGSBAy>; Wed, 18 Jul 2001 21:00:54 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:54545 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S264644AbRGSBAs>; Wed, 18 Jul 2001 21:00:48 -0400
Date: Wed, 18 Jul 2001 17:59:49 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alex Ivchenko <aivchenko@ueidaq.com>
cc: <root@chaos.analogic.com>, <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM SOLVED: 2.4.x SPINLOCKS behave differently then 2.2.x
In-Reply-To: <3B5615E8.B838D6BD@ueidaq.com>
Message-ID: <Pine.LNX.4.33.0107181639050.7602-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 18 Jul 2001, Alex Ivchenko wrote:
>
> Our hardware requires that once you start talking to firmware you cannot let
> anybody to interrupt you.
> Thus, I lazily put in all "magic" handlers (read, write, ioctl):
>
> my_ioctl() {
> ... do entry stuff
> _fw_spinlock // = spin_lock_irqsave(...);
>
> .. do my stuff (nobody could interrupt me)
>
> _fw_spinunlock // = spin_lock_irqrestore(...);
> }

This should be ok, but ONLY if you don't sleep or do anything that could
sleep (or are otherwise bad) inside the spinlocks. The things you must not
have inside spinlocks are

 - global cli/sti
 - scheduling calls (and things that call them - sleep etc)
 - user memory access (get_user/put_user etc)

But a wake_up() should be fine.

	Linus

