Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264485AbRFIUi0>; Sat, 9 Jun 2001 16:38:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264486AbRFIUiP>; Sat, 9 Jun 2001 16:38:15 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:46096 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S264485AbRFIUhz>; Sat, 9 Jun 2001 16:37:55 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: [CHECKER] a couple potential deadlocks in 2.4.5-ac8
Date: 9 Jun 2001 13:37:35 -0700
Organization: A poorly-installed InterNetNews site
Message-ID: <9fu1ef$psh$1@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.21.0106091148380.26187-100000@penguin.transmeta.com> <19317.992115181@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <19317.992115181@redhat.com>,
David Woodhouse  <dwmw2@infradead.org> wrote:
>
>Obtaining a read lock twice can deadlock too, can't it?

If it does (with spinlocks), then that's an implementation bug (which
might well be there).  We depend on the read-lock being recursive in a
lot of places, notably the fact that we don't disable interrupts while
holding read-locks if we know that the interrupt routines only take a
read-lock. 

>	A		B
>	read_lock()
>			write_lock()
>			...sleeps...
>	read_lock()
>	...sleeps...
>
>Or do we not make new readers sleep if there's a writer waiting?

The writer-waiter should not be spinning with the write lock held.

Note that the blocking versions are different, and I explicitly meant
only the read-spinlocks, not read-semaphores. For the semaphores I think
your schenario is indeed correct.

		Linus
