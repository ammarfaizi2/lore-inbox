Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282823AbRLKUki>; Tue, 11 Dec 2001 15:40:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282824AbRLKUk2>; Tue, 11 Dec 2001 15:40:28 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:51702 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S282823AbRLKUkR>; Tue, 11 Dec 2001 15:40:17 -0500
Message-ID: <3C166F19.90701CC7@mvista.com>
Date: Tue, 11 Dec 2001 12:39:53 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: high-res-timers-discourse@lists.sourceforge.net,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Interesting problem with intervals and high-res-timers
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In testing the latest high-res-timer code on a 2-way SMP machine I have
found that it is easy to trigger an NMI oops.  This happens when the
interval is coded to be very short.  Currently I have the resolution set
to 1 micro second.  The test code is trying to set up a timer with 1
micro second interval, something we just don't have the horse power to
do.

This puts the cpu into a loop processing the timer pops and starves the
other cpu causing an NMI.  (As I understand it, each cpu need to handle
at least one interrupt ever 500 ticks to avoid the NMI.  Usually
(always?) this interrupt is provided by the timer, however, the timer,
for some reason, always interrupts on the using (abusing) cpu.  (Any one
who has a better understanding of the NMI watch dog operation, please
help me here.)

Solutions:
It seems prudent to limit the interval so as to keep it large enough to
avoid this issue.  The problem is that, no matter what the limit is, it
can be subverted by starting another timer.  I have considered keeping
track of all active timers with intervals under a jiffie and sliding the
limit based on that, but it seem to me that this is decidedly
unpredictable.

The code I currently have measures the supportable interval at boot time
and then, when ever a timer is about to be requested whose time will
fall in that interval, pushing the timer out (by adding intervals). 
Alarms skipped by this are accounted for in the overrun counter. 
However, as I observed above, this is easily defeated by starting
another timer.

Comments?
-- 
George           george@mvista.com
High-res-timers: http://sourceforge.net/projects/high-res-timers/
Real time sched: http://sourceforge.net/projects/rtsched/
