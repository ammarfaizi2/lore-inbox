Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750930AbVJNWL6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750930AbVJNWL6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Oct 2005 18:11:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750938AbVJNWL6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Oct 2005 18:11:58 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:52970
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1750917AbVJNWL6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Oct 2005 18:11:58 -0400
Subject: [ANNOUNCE] ktimers high resolution patches - clockevent
	abstraction layer
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: LKML <linux-kernel@vger.kernel.org>
Cc: Steven Rostedt <rostedt@kihontech.com>, Con Kolivas <kernel@kolivas.org>,
       "high-res-timers-discourse@lists.sourceforge.net" 
	<high-res-timers-discourse@lists.sourceforge.net>,
       john cooper <john.cooper@timesys.com>,
       George Anzinger <george@mvista.com>, Doug Niehaus <niehaus@ittc.ku.edu>,
       john stultz <johnstul@us.ibm.com>, Ingo Molnar <mingo@elte.hu>
Content-Type: text/plain
Organization: linutronix
Date: Sat, 15 Oct 2005 00:14:00 +0200
Message-Id: <1129328040.1728.829.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i have released the 2.6.14-rc4-kthrt1 version of the high resolution
timer enabled ktimers subsystem patch, which can be downloaded from

http://www.tglx.de/projects/ktimers/patch-2.6.14-rc4-kthrt1.patch

a broken out version is available from

http://www.tglx.de/projects/ktimers/patch-2.6.14-rc4-kthrt1-broken-out.tar.bz2
or
http://www.tglx.de/projects/ktimers/broken-out/


This is the first release after a couple of proof of concept
implementations on top of ktimers.

The patch consists of following elements:

- ktimers base patch
- a refactored version of John Stultz timeofday patch
  (mostly code moving and some addons to simplify ktimers interface)
- the clockevents abtraction layer
- ktimers high resolution addons
- i386 high resolution enabling code


The patch introduces a new abstraction layer:
	clockevents

clockevents is the logical sibling to John Stultz clocksource
abstraction.

The current implementation of time(r) related event handling is analogue
to time keeping a widely duplicated code across architectures. Looking
at the timer_interrupt() implementations in the various architectures
reviels a mostly 1:1 copy and paste relationship with some architecture
specific quirks. Many of those quirks are related to the variety of
clock event sources which may be unknown at compile time. 

The analysis of time(r) related functionaly reviels following components

- tick handling
- update_process_times
- profiling
Future extensions:
- non tick based events (high resolution timers, dynamic tick)

These functionalities can be handled by a variety of hardware
environments

- Single event source handling everything
- Multiple event sources
- Single event source for ticks and one or more per CPU event sources
for other functionalities.

This introduces a lot of #ifdef and macro magic all over the place.
Adding new functionality e.g. high resolution timers increases the
number of quirks significantly as every potential combination of
handling has to be covered.

The clockevents layer is designed to resolve this complexity in a
central and generic place. The basic idea is to move the assignment of
time(r) related event functionality from the compile time architecture
level to a runtime decision. The architecture/hardware specific code
provides the chip level handling functions and sets the events source up
by calling the generic abstraction code with a description structure.
The clockevent abstraction layer analyses the capabilities of the event
source and assigns the appropriate handling code including a generic
timer interrupt handler where appropriate. The converted i386
architecture does not longer need a seperate timer interrupt function.
The hardware quirks, which were implemented inside the existing timer
interrupt code are handled by callbacks. It's expected that most
architectures can follow this example and delegate this functionality to
the clockevent layer. We have sample code running on PPC and ARM which
needs some cleanup and will be released ASAP. 

The release code implementation is tested on i386 UP and SMP systems and
handles all kinds of hardware scenarios. 

An illustration of the benefits is the UP high resolution mode on i386.
We have following alternatives:
- PIT handles everything (ticks, highres, profiling, update process
times)
- PIT handles ticks, update process times and profiling. LAPIC timer
handles high resolution events.

This must be handled at runtime as we don't know whether "lapic" is
given on the command line or not. The previous implementations needed a
bunch of #ifdefs and a lot of "if (using_apic_timer)" quirks.
clockevents does not need any of them. The required "tick reschulding"
in the PIT-only case is handled automatically by the generic code.

Also note the "enourmous" size of the i386 high resolution enabling
patch:
 hres_i386.patch: 1944 bytes
 Kconfig       |   18 ++++++++++++++++++
 kernel/apic.c |   12 ++++++++++--
 2 files changed, 28 insertions(+), 2 deletions(-)
The Kconfig changes are scheduled to be moved to the generic layer in
the next round of cleanups.

The high resolution functionality is verified against the posix timer
test suite from the HRT project

The clockevent layer provides also a solid ground for a generic solution
of the dynamic tick problem. The infrastructure should provide all the
necessary basics.


I'd like to thank especially
- Ingo Molnar for discussion, review and testing
- John Stultz for his excellent work on the timeofday code and his
openness for ideas and changes affecting his work
- the HRT pioneers Doug Niehaus and George Anzinger for a lot of input
and inspiration

Thanks also to everybody else who helped by providing ideas, criticism,
bugfixes, testing ...


	tglx


