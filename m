Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271700AbTG2Mtq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 08:49:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271701AbTG2Mtq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 08:49:46 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:27279 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S271700AbTG2Mtg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 08:49:36 -0400
Subject: Re: another must-fix: major PS/2 mouse problem
From: Albert Cahalan <albert@users.sf.net>
To: Andrew Morton <akpm@osdl.org>
Cc: Albert Cahalan <albert@users.sourceforge.net>, zwane@arm.linux.org.uk,
       linux-yoann@ifrance.com,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>, vortex@scyld.com, jgarzik@pobox.com
In-Reply-To: <20030728201459.78c8c7c6.akpm@osdl.org>
References: <1054431962.22103.744.camel@cube> <3EDCF47A.1060605@ifrance.com>
	 <1054681254.22103.3750.camel@cube> <3EDD8850.9060808@ifrance.com>
	 <1058921044.943.12.camel@cube> <20030724103047.31e91a96.akpm@osdl.org>
	 <1059097601.1220.75.camel@cube> <20030725201914.644b020c.akpm@osdl.org>
	 <Pine.LNX.4.53.0307261112590.12159@montezuma.mastecende.com>
	 <1059447325.3862.86.camel@cube>  <20030728201459.78c8c7c6.akpm@osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1059482410.3862.120.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 29 Jul 2003 08:40:11 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-07-28 at 23:14, Andrew Morton wrote:
> Albert Cahalan <albert@users.sourceforge.net> wrote:

> > OK, I did this. Now, in microseconds, I get:
> > 
> > ------------------------
> > IRQ use      min     max
> > --- -------- --- -------   
> >   0 timer     40  103968
> >   1 i8042     14    1138 (was 389773)
> >   2 cascade    -       -
> >   3 -          -       -
> >   4 serial    29      56
> >   5 uhci-hcd   -       -
> >   6 -        690     690
> >   7 -         40      40
> >   8 -          -       -
> >   9 -          -       -
> >  10 -          -       -
> >  11 eth0      73   31332 (was 1535331)
> >  12 i8042     18     215 (was 102895)
> >  13 -          -       -
> >  14 ide0       7   43846
> >  15 ide1       7      12 
> > ------------------------
> >    
> > boomerang_interrupt itself takes 4 to 59 microseconds.
> 
> So this looks OK, yes?

I suppose boomerang_interrupt itself is OK.
Spending 104 ms in IRQ 0, 31 ms in IRQ 11, and
44 ms in IRQ 14 is not at all OK. I was hoping
to get under 200 microseconds for everything.

> (Is that instrumentation patch productisable? 
> Looks handly, albeit a subset of microstate accounting)

Not really. I printk() when a value exceeds the
saved maximum, then scan my logs for the first
and last values. There's also hard-coded knowledge
of my 1-GHz CPU, which lets me convert to microseconds
as follows:  us = (unsigned)(ns64>>3)/125u;

(that lets me handle up to 32 seconds)

Huh. So the minimum value is really the first value.
Later values could be less, but that's not important.
I suppose that true min/max via a /proc file would
be pretty easy to implement. I like my 1-GHz hack.
I like a TSC that measures in nanoseconds too.

> > Then I switched to 2.6.0-test2. Testing more, I get the
> > problem with or without SMP and with or without
> > preemption. Here's a chunk of my log file:
> > 
> > Loosing too many ticks!
> > TSC cannot be used as a timesource. (Are you running with SpeedStep?)
> > Falling back to a sane timesource.
> > psmouse.c: Lost synchronization, throwing 3 bytes away.
> > psmouse.c: Lost synchronization, throwing 1 bytes away.
> > 
> > Arrrrgh! The TSC is my only good time source!
> 
> Arrrgh!  More PS/2 problems!
> 
> I think the lost synchronisation is the problem, would you agree?

It's one problem. It's a problem other people have seen.
My TSC should be good though; I'd like to use it.
At times ntpd (the NTP daemon) gets really unhappy with
the situation, yanking my clock ahead by up to 10 minutes
to compensate for lost time.

> The person who fixes this gets a Nobel prize.
> 
> > Remember that this is a pretty normal system. I have
> > a Red Hat 8 install w/ required upgrades, ext3, IDE,
> > a 1-GHz Pentium III, a boring VIA chipset, etc.
> > 
> > To reproduce, I do some PS/2 mouse movement while
> > doing one of:
> > 
> > a. Lots of concurrent write() and sync() activity to ext3.
> > b. Lots of NFSv3 traffic.
> 
> ie: lots of interrupt traffic causes the PS2 driver to go whacky?

I guess so. The ext3+IDE behavior seems to lift the blame
from boomerang_interrupt. Using ext3+IDE, I seem to need
a couple minutes to reproduce the problem. NFSv3+Ethernet
will give me the problem almost instantly.



