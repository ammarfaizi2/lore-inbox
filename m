Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264489AbRGRXkA>; Wed, 18 Jul 2001 19:40:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264461AbRGRXju>; Wed, 18 Jul 2001 19:39:50 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:59921 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S264432AbRGRXji>; Wed, 18 Jul 2001 19:39:38 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Linus Torvalds <torvalds@transmeta.com>
Subject: Re: Inclusion of zoned inactive/free shortage patch
Date: Thu, 19 Jul 2001 01:42:45 +0200
X-Mailer: KMail [version 1.2]
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>,
        Rik van Riel <riel@conectiva.com.br>
In-Reply-To: <Pine.LNX.4.33.0107181555181.1237-100000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0107181555181.1237-100000@penguin.transmeta.com>
MIME-Version: 1.0
Message-Id: <0107190142450I.12129@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 19 July 2001 00:59, Linus Torvalds wrote:
> On Thu, 19 Jul 2001, Daniel Phillips wrote:
> > I don't really see much use for inactive_shortage_total() by
> > itself, except maybe deciding when to scan vs sitting idle.
>
> Absolutely. But that's an important decision in itself. Getting that
> decision wrong means that we either scan too little (and which point
> the question of per-zone shortages becomes moot, because by the time
> we start scanning we're too deep in trouble to be able to do a good
> gradual job anyway). Or we scan too much, and then the per-zone
> shortage just means that we'll always have so much inactive stuff in
> all the zones that we'll continue scanning forever - because none of
> the zones (correctly) feel that they have any reason to actually free
> anything.

Yes, scanning too much is mainly a cpu waste, but it also has the bad
effect of degrading quality of the long term aging information
(because pages aren't fairly aged while they're on the inactive queues.)

I'm thinking about an alternative way of aging that lets ->age be a
signed value, then when you get a surge in demand for deactivation
you just raise the threshold at which deactivation takes place.  This
would be in addition to scanning more, but should save a lot of cpu.
This is exactly at the time that it's good to save cpu.  There's still
a lot of thinking to do about what the function of the current
exponential down-aging really is, and how to capture the good effects
with subtracts instead of shifts.  Caveat: not 2.4 stuff, obviously.

> So the global inactive_shortage() decision is certainly an important
> one: it should trigger early enough to matter, but not so early that
> we trigger it even when most local zones are really totally saturated
> and we really shouldn't be scanning at all.

Yes.  The inactive shortage needs to be a function of the length of
the inactive_dirty queue rather than just the amount that free pages
is less than some fixed minimum.  The target length of the
inactive_dirty queue in turn can be a function of the global free
shortage (which is where the minimum free numbers get used) and the
transfer rate of the disk(s).  Again, experimental - without careful
work a feedback mechanism like this could oscillate wildly.  It's most
probably the way forward in the long run though.

--
Daniel
