Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293203AbSGPJMW>; Tue, 16 Jul 2002 05:12:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312601AbSGPJMV>; Tue, 16 Jul 2002 05:12:21 -0400
Received: from d12lmsgate.de.ibm.com ([195.212.91.199]:31473 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id <S311898AbSGPJL4> convert rfc822-to-8bit; Tue, 16 Jul 2002 05:11:56 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: linux-kernel@vger.kernel.org
Subject: Re: Periodic clock tick considered harmful (was: Re: HZ, preferably as small as possible)
Date: Tue, 16 Jul 2002 11:10:18 +0200
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200207161110.18145.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>We have a Linux kernel (2.4.18-rmk2) running on the IBM Linux Watch which
>skips timer ticks, but only when there's no work to be done. We have dubbed
>this timing scheme the Work Dependent Timing scheme.  Briefly, on every
>return to the "Linux idle loop", the kernel checks if there's more work to
>be done by parsing relevant lists and queues. If there's no current work to
>be done, nor any work to be done in the next timer tick, the software timer
>with the nearest timeout is retrieved and a hardware timer is programmed
>accordingly with the nearest timeout to wake up the system in time to service
>the associated software timer.

In principle that is what the version 2 of the s/390 timer patch does. My
timer patch is a bit more complicated since it has to cope with an SMP system
but that are just details in the backend code that deal with the question
which cpu is doing the calls to do_timer(). The idea is to stop the hz timer
for every cpu going idle. The last cpu going idle has to check if something is
on tq_timer. If there is work on tq_timer then the clock is not reprogrammed
and the next hz tick comes in normally. If there is nothing on tq_timer
then the next timer event is calculated from the tv1-tv5 arrays and the
clock comparator is reprogrammed. With that all cpus are truly doing nothing
until either the clock comparator or another hardware interrupt comes in.
That is where the monitor call instruction on s/390 comes into play. This neat
instruction either causes a program check or does nothing (a nop). This is
controlled by a bit in control register 8. So the additional cost on the
system entry path is just one cycle for the nop if a cpu is running normally.
The amount of additional work on the system entry path was the main backdraw
of version 1 of the timer patch.

Version 1 of the s/390 timer patch is even more radical. It eliminates the hz
timer completly. Timer events are done with the clock comparator and process
related timer (time slice, itimer and profiling timer) are done with the cpu
timer. Since there isn't a periodic check anymore every change related to
timers has to be notified to the architecture backend. That makes it necessary
to introduce two hooks timer_notify and itimer_notify that are called from
common code. Not really nice but necessary for this approach. A second, more
severe backdraw is the need to check on every system entry if a jiffy update
needs to be done and to do the calculations for proper process time accounting
(in fact the jiffy variable is replaced by a macro and is not a problem but
the wall_time and other internal timing stuff have to get updated).
This makes up for about 60 cycles in the system entry path. This shows up on
some micro benchmarks and was the reason to do version 2.

blue skies,
   Martin

P.S. the two timer patches are available on developer works:
http://www10.software.ibm.com/developerworks/opensource/linux390/current2_4_17.shtml#jun132002-timer
http://www10.software.ibm.com/developerworks/opensource/linux390/current2_4_17-may2002.shtml#timer20020531

Linux/390 Design & Development, IBM Deutschland Entwicklung GmbH
Schönaicherstr. 220, D-71032 Böblingen, Telefon: 49 - (0)7031 - 16-2247
E-Mail: schwidefsky@de.ibm.com

