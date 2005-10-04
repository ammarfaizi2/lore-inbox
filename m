Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964803AbVJDPPU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964803AbVJDPPU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 11:15:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964801AbVJDPPU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 11:15:20 -0400
Received: from smtp.innovsys.com ([66.115.232.196]:16483 "EHLO
	mail.innovsys.com") by vger.kernel.org with ESMTP id S964800AbVJDPPS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 11:15:18 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: clock skew on B/W G3
Date: Tue, 4 Oct 2005 10:15:10 -0500
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B859479@ismail.innsys.innovsys.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: clock skew on B/W G3
thread-index: AcXI4fMb7vX3R4SYSQifBaCQNxjbVQAD/EEA
From: "Rune Torgersen" <runet@innovsys.com>
To: "Paul Mackerras" <paulus@samba.org>
Cc: "Marc" <marvin24@gmx.de>, <linuxppc-dev@ozlabs.org>,
       <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

> -----Original Message-----
> From: Paul Mackerras [mailto:paulus@samba.org] 
> Sent: Tuesday, October 04, 2005 07:49
> Subject: RE: clock skew on B/W G3
>
> I do not believe CLOCK_TICK_RATE affects timekeeping at all on ppc or
> ppc64 machines, but I could be wrong.  Can you show us where and how
> CLOCK_TICK_RATE affects things?

I looked very closely at htis thing earlier this summer because of an
embedded board that drifted quite severly (15sec a day) with a very
accureate BITS clock as clock source.

Here goes:
In arch/ppc/kernel/time.c
timer_interrupt() gets called every decrementer timeout (about every
1/CONFIG_HZ seconds, accuracy depends on how easily your decrementer
cliock can be divided by CONFIG_HZ)
this calls do_timer() to do the timer increment.

do_timer is in kernel/timer.c and calls update_times().
update_times() calls update_wall_time() which in turns calls
update_wall_time_one_tick()

update_wall_time_one_tick()uses tick_nsec to increment xtime.

tick_nsec is defined as: (kernel/timer.c:561)
unsigned long tick_nsec = TICK_NSEC;

TICK_NSEC is defined as: (include/linux/jiffies.h:64)
#define TICK_NSEC (SH_DIV (1000000UL * 1000, ACTHZ, 8))

ACTHZ is defined as: (include/linux/jiffies.h:61)
#define ACTHZ (SH_DIV (CLOCK_TICK_RATE, LATCH, 8))

LATCH is defined as: (include/linux/jiffies.h:46)
#define LATCH  ((CLOCK_TICK_RATE + HZ/2) / HZ)

which means that tick_nsec depends on CLOCK_TICK_RATE to get its value.

defined as:
#define CLOCK_TICK_RATE	1193180 /* Underlying HZ */

this clock is completely wrong for most/all ppc. 
It happens to generate a tick_nsec of 999848 which is close enough to
1000000 that most people does not notice.
(tick_nsec is number of nsec per timer tick)

When HZ is 250, TICK_NSEC becomes 4000250.
While this might not completely explain a 20% change in clock sped, it
it clearly not acurate either.
