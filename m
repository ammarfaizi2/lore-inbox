Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316753AbSGQUv6>; Wed, 17 Jul 2002 16:51:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316755AbSGQUv6>; Wed, 17 Jul 2002 16:51:58 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:52485 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S316753AbSGQUv4>; Wed, 17 Jul 2002 16:51:56 -0400
Date: Wed, 17 Jul 2002 13:55:47 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Daniel Phillips <phillips@arcor.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: HZ, preferably as small as possible
In-Reply-To: <E17UuXr-0004PH-00@starship>
Message-ID: <Pine.LNX.4.44.0207171347150.6820-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 17 Jul 2002, Daniel Phillips wrote:
>
> We don't have to feel restricted to integer multiples.  I'll paste in my
> earlier post, for your convenience:

Oh, I agree. I think the integer multiplies simplify the problem space,
and should be trivial for most timer hardware (ie most timer hardware is
likely just a counter, so making the countdown value be N times as big
just automatically gives you integer multiples).

The _important_ part I would prefer people to take away is that it is
easier to "slow down" the clock than it is to speed it up. Mainly because
the place that are likely to care about speeding it up are also very very
timing-critical. For example, there is no way in _hell_ that we're going
to reprogram the old-style PC/AT timer inside the "add_timer()" function.
It just is not viable.

In contrast, the places who are interested in slowing the timer down are
also the places likely to not be as timing-critical. The idle loop being
the perfect example (and also being right now the _only_ example where
somebody actually asked for a slower timer tick).

Also note that once you're willing to do this in the slow path, you can
also do real "fixups" to the results since you can afford to take a small
hit when you get back to "fast mode". For example, if we only do this on
PC's while we go into C3 anyway (where latencies to saving power are quite
noticeably anyway, so that the idle loop already has to do some latency
estimation before it decides to go into C3), then we can easily afford to
completely re-setting not just the timer counter, but doing fairly complex
things like re-adjusting the whole time-of-day clock.

See how it becomes a much simpler game (and you have more options) if you
take the "slow the timer down when idle" approach instead of taking the
"speed the timer up when you need to" approach?

			Linus

