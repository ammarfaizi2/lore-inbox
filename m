Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284309AbRLRE3M>; Mon, 17 Dec 2001 23:29:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284038AbRLRE2w>; Mon, 17 Dec 2001 23:28:52 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:15371 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S284017AbRLRE2l>; Mon, 17 Dec 2001 23:28:41 -0500
Date: Mon, 17 Dec 2001 20:27:18 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: William Lee Irwin III <wli@holomorphy.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Scheduler ( was: Just a second ) ...
In-Reply-To: <20011217200946.D753@holomorphy.com>
Message-ID: <Pine.LNX.4.33.0112172014530.2281-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[ cc'd back to Linux kernel, in case somebody wants to take a look whether
  there is something wrong in the sound drivers, for example ]

On Mon, 17 Dec 2001, William Lee Irwin III wrote:
>
> This is no benchmark. This is my home machine it's taking a bite out of.
> I'm trying to websurf and play mp3's and read email here. No forkbombs.
> No databases. No made-up benchmarks. I don't know what it's doing (or
> trying to do) in there but I'd like the CPU cycles back.
>
> From a recent /proc/profile dump on 2.4.17-pre1 (no patches), my top 5
> (excluding default_idle) are:
> --------------------------------------------------------
>  22420 total                                      0.0168
>   4624 default_idle                              96.3333
>   1280 schedule                                   0.6202
>   1130 handle_IRQ_event                          11.7708
>    929 file_read_actor                            9.6771
>    843 fast_clear_page                            7.5268

The most likely cause is simply waking up after each sound interrupt: you
also have a _lot_ of time handling interrupts. Quite frankly, web surfing
and mp3 playing simply shouldn't use any noticeable amounts of CPU.

The point being that I really doubt it's the scheduler proper, it's
probably how it is _used_. And I'd suspect your sound driver (or user)
conspires to keep scheduling stuff.

For example (and this is _purely_ an example, I don't know if this is
your particular case), this sounds like a classic case of "bad buffering".
What bad buffering would do is:
 - you have a sound buffer that the mp3 player tries to keep full
 - your sound buffer is, let's pick a random number, 64 entries of 1024
   bytes each.
 - the sound card gives an interrupt every time it has emptied a buffer.
 - the mp3 player is waiting on "free space"
 - we wake up the mp3 player for _every_ sound fragment filled.

Do you see what this leads to? We schedule the mp3 task (which gets a high
priority because it tends to run for a really short time, filling just 1
small buffer each time) _every_ time a single buffer empties. Even though
we have 63 other full buffers.

The classic fix for these kinds of things is _not_ to make the scheduler
faster. Sure, that would help, but that's not really the problem. The
_real_ fix is to use water-marks, and make the sound driver wake up the
writing process only when (say) half the buffers have emptied.

Now the mp3 player can fill 32 of the buffers at a time, and gets
scheduled an order of magnitude less. It doesn't end up waking up every
time.

Which sound driver are you using, just in case this _is_ the reason?

		Linus

