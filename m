Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270322AbTG2DEw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 23:04:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270373AbTG2DEw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 23:04:52 -0400
Received: from sccrmhc11.comcast.net ([204.127.202.55]:3210 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S270322AbTG2DEu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 23:04:50 -0400
Subject: Re: another must-fix: major PS/2 mouse problem
From: Albert Cahalan <albert@users.sf.net>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Andrew Morton <akpm@osdl.org>,
       Albert Cahalan <albert@users.sourceforge.net>, linux-yoann@ifrance.com,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>, vortex@scyld.com, jgarzik@pobox.com
In-Reply-To: <Pine.LNX.4.53.0307261112590.12159@montezuma.mastecende.com>
References: <1054431962.22103.744.camel@cube> <3EDCF47A.1060605@ifrance.com>
	 <1054681254.22103.3750.camel@cube> <3EDD8850.9060808@ifrance.com>
	 <1058921044.943.12.camel@cube> <20030724103047.31e91a96.akpm@osdl.org>
	 <1059097601.1220.75.camel@cube> <20030725201914.644b020c.akpm@osdl.org>
	 <Pine.LNX.4.53.0307261112590.12159@montezuma.mastecende.com>
Content-Type: text/plain
Organization: 
Message-Id: <1059447325.3862.86.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 28 Jul 2003 22:55:26 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-07-26 at 11:16, Zwane Mwaikambo wrote:
> On Fri, 25 Jul 2003, Andrew Morton wrote:
> 
> > But did your instrumentation account for nested interrupts?  What happens
> > if a slow i8042 interrupt happens in the middle of a 3c59x interrupt?
> 
> Just to verify that, he could remove the local_irq_enable for 
> !SA_INTERRUPT.

OK, I did this. Now, in microseconds, I get:

------------------------
IRQ use      min     max
--- -------- --- -------   
  0 timer     40  103968
  1 i8042     14    1138 (was 389773)
  2 cascade    -       -
  3 -          -       -
  4 serial    29      56
  5 uhci-hcd   -       -
  6 -        690     690
  7 -         40      40
  8 -          -       -
  9 -          -       -
 10 -          -       -
 11 eth0      73   31332 (was 1535331)
 12 i8042     18     215 (was 102895)
 13 -          -       -
 14 ide0       7   43846
 15 ide1       7      12 
------------------------
   
boomerang_interrupt itself takes 4 to 59 microseconds.

Then I switched to 2.6.0-test2. Testing more, I get the
problem with or without SMP and with or without
preemption. Here's a chunk of my log file:

Loosing too many ticks!
TSC cannot be used as a timesource. (Are you running with SpeedStep?)
Falling back to a sane timesource.
psmouse.c: Lost synchronization, throwing 3 bytes away.
psmouse.c: Lost synchronization, throwing 1 bytes away.

Arrrrgh! The TSC is my only good time source!

Remember that this is a pretty normal system. I have
a Red Hat 8 install w/ required upgrades, ext3, IDE,
a 1-GHz Pentium III, a boring VIA chipset, etc.

To reproduce, I do some PS/2 mouse movement while
doing one of:

a. Lots of concurrent write() and sync() activity to ext3.
b. Lots of NFSv3 traffic.


