Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268427AbSIRSsO>; Wed, 18 Sep 2002 14:48:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268631AbSIRSsO>; Wed, 18 Sep 2002 14:48:14 -0400
Received: from mx2.elte.hu ([157.181.151.9]:53125 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S268427AbSIRSsN>;
	Wed, 18 Sep 2002 14:48:13 -0400
Date: Wed, 18 Sep 2002 21:00:37 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [patch] lockless, scalable get_pid(), for_each_process()
 elimination, 2.5.35-BK
In-Reply-To: <20020918182818.GA14629@win.tue.nl>
Message-ID: <Pine.LNX.4.44.0209182038400.26337-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 18 Sep 2002, Andries Brouwer wrote:

> Collisions cost time. In a large space there are few collisions.
> 
> Now suppose you start 10^4 tasks at boot time and after 10^9 forks you
> have to come back. Do you necessarily have to come across this bunch of
> 10^4 tasks that are still sitting there? That would be unfortunate.

If you think you can outrun this O(N^2) algorithm with Moore's law in both
CPU performance and RAM space then you need to reconsider. I considered
solving this problem a few years ago, but it was clearly too much fuss for
too little gain. Now wli did the work and i think it's important, even if
taking the PID allocation issue completely out of the picture.

there's a good reason why this problem started to trigger and slowly made
its way on my radar as well, after so many years of passivity (we've had
this algorithm since day 1 i believe) - O(N^2)  algrithms do tend to show
up sooner or later, there's no escape.

> But, you see, there are really many ways to avoid that.
> 
> Let me just invent one on the spot. Pick a random generator with period
> 2^128 - 1 and each time you want a new pid pick the last 30 bits of its
> output. Why is that nice? Next time you come around to the same pid,
> pids that were close together first are far apart the second time.

actually now you've moved entirely out of the problem space. Ie. some nice
looking ps output:

mingo    1205341178 0.0 1689.3 123485616 tty5 S  16:26  0:00 -bash
mingo    21123326 0.0 1682.9 212345112 tty6 S  16:26    0:00 -bash
mingo    81430573 0.0 2074.9 1096872604 tty5 S  19:11   0:00 slogin x
mingo    579584   0.0 323.1 9833960    tty3 S  20:07    0:00 lynx
mingo    2690291337 0.1 2748.7 861737004 tty2 S  20:36  0:00 pine -i
mingo    1560603  0.0 1622.2 4431396   tty2 SN 20:39    0:00 -bash

just to solve the lameness of an algorithm that can be fixed nicely? Wow.

> You see, no data structures, no bitmaps, and very good behaviour on
> average, even after 10^9 forks.

just an occasional blip of 1-2-10 millisecs every few seconds, perhaps 100
millisecs if unlucky, even with just a 0.1% fill rate of the PID space.
Lowlatency patches? Why the need, we've got this get_pid() game of
roulette...

> But there are lots of other solutions.

such as? ...

	Ingo

