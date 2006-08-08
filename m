Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965044AbWHHW1j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965044AbWHHW1j (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 18:27:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965053AbWHHW1i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 18:27:38 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:32410 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S965044AbWHHW1i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 18:27:38 -0400
Date: Tue, 8 Aug 2006 18:27:09 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: David Miller <davem@davemloft.net>
cc: tytso@mit.edu, mchan@broadcom.com, herbert@gondor.apana.org.au,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       tglx@linutronix.de, mingo@elte.hu
Subject: Re: [PATCH -rt DO NOT APPLY] Fix for tg3 networking lockup
In-Reply-To: <20060808.150006.48399434.davem@davemloft.net>
Message-ID: <Pine.LNX.4.58.0608081819300.18586@gandalf.stny.rr.com>
References: <Pine.LNX.4.58.0608070124340.15870@gandalf.stny.rr.com>
 <20060806.231846.71090637.davem@davemloft.net> <Pine.LNX.4.58.0608080819080.7917@gandalf.stny.rr.com>
 <20060808.150006.48399434.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 8 Aug 2006, David Miller wrote:

> From: Steven Rostedt <rostedt@goodmis.org>
> Date: Tue, 8 Aug 2006 08:24:10 -0400 (EDT)
>
> > Of the 4 timers, only one is a timeout. The other three expire every time,
> > forcing the timer wheel into effect.  Even though it's one timer
> > implementing 4, it's expensive to use it as a watchdog.
>
> It's not a watchdog, the timer continually fires.

Right, I should have used the term "heartbeat" instead :)

>
> It is the on-chip ASF firmware that "times out" if it does not
> see  the heartbeat message from the driver within 5 seconds.
>
> The driver timer in question runs every 2 seconds to write this
> heartbeat message to the chip.
>

OK, but still, if it is expected to expire, which this one is, then it
should be converted to a hrtimer, instead of a normal timer.  The hrtimers
were introduced to make it more efficient for expiring timers.  Well, they
really were introduced for high resolution, but in order to do that the
expiring timer implementation needed to be improved.  The timer wheel is
most efficient for those timers that are not expected to time out
(probably what a watchdog timer would actually do, so my terminology was
really incorrect).

The timer wheel is O(1) in removing and adding a timer, but can be O(n)
if the timers cascade (which would happen when a timer moves to expire).

The hrtimers are O(1) in expiring but O(log n) on adding and removing. So
they are better to use when you know that the timer will expire.

This also help's Ted's case for the -rt patch since the hrtimers there
have a dynamic priority.

-- Steve

