Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132683AbRDKTZj>; Wed, 11 Apr 2001 15:25:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132967AbRDKTZ3>; Wed, 11 Apr 2001 15:25:29 -0400
Received: from otter.mbay.net ([206.40.79.2]:35334 "EHLO otter.mbay.net")
	by vger.kernel.org with ESMTP id <S132683AbRDKTZP> convert rfc822-to-8bit;
	Wed, 11 Apr 2001 15:25:15 -0400
From: jalvo@mbay.net (John Alvord)
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
Cc: george anzinger <george@mvista.com>, Mark Salisbury <gonar@mediaone.net>,
        mark salisbury <mbs@mc.com>,
        high-res-timers-discourse@lists.sourceforge.net,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
        David Schleef <ds@schleef.org>, Jeff Dike <jdike@karaya.com>,
        schwidefsky@de.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: No 100 HZ timer !
Date: Wed, 11 Apr 2001 19:21:38 GMT
Message-ID: <3ad5ade8.18532709@mail.mbay.net>
In-Reply-To: <20010410193521.A21133@pcep-jamie.cern.ch> <E14n2hi-0004ma-00@the-village.bc.nu> <20010410202416.A21512@pcep-jamie.cern.ch> <3AD35EFB.40ED7810@mvista.com> <3AD366DC.478E4AF@mc.com> <3AD38464.A1F97AC8@mvista.com> <002a01c0c221$32703e60$6501a8c0@gonar.com> <20010411181101.B23974@pcep-jamie.cern.ch> <3AD48D81.6E7B23B1@mvista.com> <20010411205704.B24318@pcep-jamie.cern.ch>
In-Reply-To: <20010411205704.B24318@pcep-jamie.cern.ch>
X-Mailer: Forte Agent 1.5/32.451
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Apr 2001 20:57:04 +0200, Jamie Lokier
<lk@tantalophile.demon.co.uk> wrote:

>george anzinger wrote:
>> > A pointer-based priority queue is really not a very complex thing, and
>> > there are ways to optimise them for typical cases like the above.
>> > 
>> Please do enlighten me.  The big problem in my mind is that the
>> pointers, pointing at points in time, are perishable.
>
>Um, I'm not sure what perishability has to do with anything.  Timers at
>the moment can be added, deleted and destroyed and it's no big deal.
>
>Look in an algorithms book under "priority queue".  They usually don't
>say how to use a heap-ordered tree -- usually it's an array -- but you
>can use a tree if you want.  In such a tree, each timer has a link to
>_two_ next timers and one previous timer.  (The previous timer link is
>only needed if you can delete timers before they expire, which is
>required for Linux).
>
>I'm not saying saying a heap-ordered tree is fastest.  But it's ok, and
>doesn't require any more storage than the `struct timer' objects
>themselves.
>
>It's possible to optimise this kind of data structure rather a lot,
>depending on how you want to use it.  Linux' current timer algorithm is
>a pretty good example of a priority queue optimised for timer ticks,
>where you don't mind doing a small amount of work per tick.
>
>One notable complication with the kernel is that we don't want every
>timer to run at its exactly allocated time, except for some special
>timers.  For example, if you have 100 TCP streams and their
>retransmission times are scheduled for 1.0000s, 1.0001s, 1.0002s, etc.,
>you'd much rather just process them all at once as is done at the moment
>by the 100Hz timer.  This is because cache locality is much more
>important for TCP retransmits than transmit timing resolution.
>
>There's literature online about this class of problems: look up "event
>set" and "simulation" and "fast priority queue".

I bumped into a funny non-optimization a few years ago. A system with
a timer queue like the above had been "optimized" by keeping old timer
elements... ready for new tasks to link onto and activate. The
granularity was 1 millsecond. Over time, all timer values from 0 to
roughly 10 minutes had been used. That resulted in 60,000 permanent
storage fragments laying about... a significant fragmentation problem.
The end was a forced recycle every month or so.

john alvord
