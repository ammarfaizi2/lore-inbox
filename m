Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263140AbTJJWTZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 18:19:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263141AbTJJWTZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 18:19:25 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:62194 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S263140AbTJJWTX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 18:19:23 -0400
Message-ID: <3F873067.9020805@mvista.com>
Date: Fri, 10 Oct 2003 15:19:19 -0700
From: George Anzinger <george@mvista.com>
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "'high-res-timers-discourse@lists.sourceforge.net'" 
	<high-res-timers-discourse@lists.sourceforge.net>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [ANNOUNCE] VST (tick elimination) is now available
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The first release of the VST package is now available.  VST or 
Variable Scheduling Timeouts (or if you prefer, Variable Sleep Times) 
contains code that, from the idle task, scans the timer list and, if 
no timer is near, skips the timer interrupts that would otherwise be 
generated.  The patch name is hrtimers-vst-*

The net result is that a quite system will use far less power as it 
does not need to wake up ever 1/HZ timer tick.

This patch depends on the high-res-timers patch version
hrtimers-2.4.20-3.0 which must be applied first.

Both of these patchs are on sourceforge at:

http://sourceforge.net/projects/high-res-timers/

Some details:

There is a proc directory (/proc/sys/kernel/vst/) dedicated to vst 
controls.  Root may turn VST on or off here with "echo "0">enable. 
There is also a log option (danger Will Robinson) which, if turned on 
causes " x" where x is the number of ticks being skipped, to be 
printed on the log console.  This will quickly swamp the console, but 
it does show things happening during quite times and no such output 
when the system is busy.  It is also possible to set the threshold 
here.  This is in units of milliseconds and is the time the next timer 
must away from now to trigger a VST sleep.  Currently this is set 
rather large considering that we can sleep only 50ms, but you can 
change it here.

The file .../include/linux/vst.h contains details on the arch 
interface.  The core code is all in .../kernel/timer.c with enabling 
bits in various places.  The arch code for the x86 version is all 
located in .../include/asm-i386/hrtime.h

This is, of course, the first cut at this stuff.  There is a lot left 
to do....

Things left to do:

Currently the PIT is used to wake the system for the next timer.  If 
that timer is further away than about 50ms, the PITs limitations force 
us to use the max PIT time of about 50ms.  We plan to use the rtc 
hardware to do this wake up, thus eliminating this restriction.

SMP imposes further restrictions and, as it currently stands, may 
cause late timers in some cases.  When we port to the 2.6 kernel this 
will change, for the better, we hope :)  This will also allow us to 
use the APIC timers in these systems to do the wake up, thus allowing 
longer sleep times.
-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

