Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261468AbTJHNuv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 09:50:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261661AbTJHNtP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 09:49:15 -0400
Received: from pentafluge.infradead.org ([213.86.99.235]:24760 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261468AbTJHNc5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 09:32:57 -0400
Subject: Time precision, adjtime(x) vs. gettimeofday
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1065619951.25818.15.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 08 Oct 2003 15:32:31 +0200
Content-Transfer-Encoding: 7bit
X-SA-Exim-Mail-From: benh@kernel.crashing.org
X-SA-Exim-Scanned: No; SAEximRunCond expanded to false
X-Pentafluge-Mail-From: <benh@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

While fixing problems experienced by some scientific users who
found out that gettimeofday() could sometimes run backward, I
found a nasty issue I don't know if we can fix at all or if it's
not worth bothering.

So the problem is with any arch (ppc, x86, ...) who uses a HW
timer (like the CPU timebase on PPC) to provide better-than-jiffy
precision in do_gettimeofday().

The problem is that the offset added to xtime value (typically
the HW timer current value minus the HW timer value at the last
timer interrupt scaled to usec) uses a scaling factor which has
been calibrated once, and doesn't take into account the adjustements
done to xtime increase by adjtime/adjtimex algorithm.

That means that if, for example, adjtimex was called with a factor
that is trying to slow you down a bit, and you call gettimeofday
right before the end of a jiffy period, you may calculate an offset
based on the HW timer that is actually higher than what will be
really added to xtime on the next interrupt.

So you can end-up returning non-monotonic values from gettimeofday().

I don't see a way to fix that that wouldn't bloat do_gettimeofday(),
except if we can, at jiffy interrupt time, pre-calculate a scaling
factor for the next jiffy and just apply it on the HW timer value
on the next calls to do_gettimeofday(). But that option would need
better understanding of the adjtime(x) algorithm that what I have
at this point.

Storing the last value to make sure we don't return a value that is
lower will defeat the read_lock/write_lock mecanism, forcing us to
take the write_lock(), and thus screwing up scalability.

Any idea ?

Note: In addition to the above, there seem to be a race on x86 2.4
(only, 2.6 doesn't have it) due to the fact that the actual xtime
increase is done from a bottom half. The HW timer "last stamp" is
stored from the HW interrupt, xtime is only updated on the BH, so
if gettimeofday is called in between those 2, you'll end up using
the "new" "last stamp" with the old xtime, thus returning an
incorrect value. A fix we use on PPC is to use

 jiffies - wall_jiffies

As an additional correction.

Ben.


