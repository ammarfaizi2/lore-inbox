Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131309AbRAaQge>; Wed, 31 Jan 2001 11:36:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131247AbRAaQgR>; Wed, 31 Jan 2001 11:36:17 -0500
Received: from chiara.elte.hu ([157.181.150.200]:12294 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S129996AbRAaQgI>;
	Wed, 31 Jan 2001 11:36:08 -0500
Date: Wed, 31 Jan 2001 17:35:31 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Daniel Phillips <phillips@innominate.de>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] new, scalable timer implementation, smptimers-2.4.0-B1
In-Reply-To: <3A7827CA.AA840EB4@innominate.de>
Message-ID: <Pine.LNX.4.30.0101311728080.1687-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 31 Jan 2001, Daniel Phillips wrote:

>   b) The current API looks like it was designed primarly with one-shot
> timers in mind.  Most timers events are multishot (because
> sleep_on_timeout is better for most one-shot applications [...]

sleep_on_timeout() uses a one-shot timer internally.

but for 2.4, the changing of the timer interface is out of question. My
main goal was to achieve good SMP scalability with the existing interface.

i do not agree with passing the timer address instead of the ->data field.
It's one more dereference to use, for no particular reason. If you want to
get at the timer structure you can still do it by embedding it into a
structure:

	struct foo {
		...
		timer_t timer;
		...
	}

and ->data will point to &foo.

with the timerlist lock being per-CPU, basically all lock contention has
been eliminated. So it's not a problem anymore to drop/reaquire the lock,
it's not more than a nicely cached, CPU-local variable.

	Ingo

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
