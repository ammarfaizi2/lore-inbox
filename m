Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269779AbRHTWyQ>; Mon, 20 Aug 2001 18:54:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269781AbRHTWyH>; Mon, 20 Aug 2001 18:54:07 -0400
Received: from mailhost.idcomm.com ([207.40.196.14]:27347 "EHLO
	mailhost.idcomm.com") by vger.kernel.org with ESMTP
	id <S269779AbRHTWx4>; Mon, 20 Aug 2001 18:53:56 -0400
Message-ID: <3B81955A.C95A271E@idcomm.com>
Date: Mon, 20 Aug 2001 16:55:22 -0600
From: "D. Stimits" <stimits@idcomm.com>
Reply-To: stimits@idcomm.com
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-pre1-xfs-4 i686)
X-Accept-Language: en
MIME-Version: 1.0
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: /dev/random in 2.4.6
In-Reply-To: <Pine.LNX.4.30.0108200903580.4612-100000@waste.org> <2251207905.998322034@[10.132.112.53]>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Bligh - linux-kernel wrote:
...
> An alternative approach to all of this, perhaps, would be to use extremely
> finely grained timers (if they exist), in which case more bits of entropy
> could perhaps be derived per sample, and perhaps sample them on
> more operations. I don't know what the finest resolution timer we have
> is, but I'd have thought people would be happier using ANY existing
> mechanism (including network IRQs) if the timer resolution was (say)
> 1 nanosecond.

I'm probably wording this poorly, but I'm going to call a device that
provides irqs, and which is probably not predictable except under a
severe attack, a pseudo-entropy source, and other devices which are
presumed to be non-observable or otherwise unpredictable an entropy
source. Examples, eth0 or a modem as pseudo-entropy source, and hard
drive, keyboard, or mouse activity as entropy source (although if you
use wireless keyboard or mouse, more likely they'd have to be
reclassified as pseudo-entropy sources).

Why is it required to use only the time between irq's of a single device
for start/stop times (time delta measurement)? If the time period were
instead calculated not on the time between irq of a single device, but
instead start and stop times were based on different device irq's, then
many pseudo entropy sources could become full entropy sources...to
accurately/precisely snoop eth0 traffic and determine it's irq would no
longer be helpful if the time involved the starting of a timer from
eth0, but the stop (and thus delta) was derived from something else like
hard drive activity. Force the attacker to monitor more than one irq,
plus require the attacker to know which irq device corresponds to the
stop irq of a particular timer.

A variation on the theme would be to rotate which entropy source is used
as the stop event whenever a pseudo entropy source starts a timer. E.G.,
eth0 irq starts a timer, and the hard drive is set to stop the timer on
eth0 (the same hard drive timer could also start or stop a hard drive
time delta, it's a separate issue) the first time, but using this irq
causes eth0 stop events to now be bound to mouse events instead. In that
example, the attacker would have to monitor both eth0 irq, and hard
drive irq, as well as knowing that the hard drive is the stop event; the
first time it is used, the attacker would then have to be able to
monitor the eth0 irq, and the mouse irq, along with knowledge that the
mouse irq is now the stop event (and the first time a mouse event is
used as a stop event to the eth0 timer, a new stop event device would be
rotated in). Given a mouseless/keyboardless/headless machine, but with
several pseudo entropy sources, one could still have some degree of
confidence even when the attacker controls and monitors all pseudo
entropy source irq's, based on the notion that the attacker won't know
*which* irq corresponds to a start or stop event (knowing irq no longer
provides a direct time measurement). If pseudo entropy sources used
trusted entropy sources for stop events, this would be preferable, but a
completely pseudo entropy set of sources could become much more trusted
if the exact rotation scheme in use at each irq was not known to the
attacker. Would it be practical to segregate begin/end irq timer events
to different devices, rather than having begin/end events based soley on
a single device?

D. Stimits, stimits@idcomm.com

> 
> --
> Alex Bligh
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
