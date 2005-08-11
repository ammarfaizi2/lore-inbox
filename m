Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030246AbVHKLAv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030246AbVHKLAv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 07:00:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030262AbVHKLAu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 07:00:50 -0400
Received: from mx2.elte.hu ([157.181.151.9]:55946 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S1030246AbVHKLAt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 07:00:49 -0400
Date: Thu, 11 Aug 2005 13:00:51 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       george anzinger <george@mvista.com>
Subject: [patch] Real-Time Preemption, -RT-2.6.13-rc4-V0.7.53-01, High Resolution Timers & RCU-tasklist features
Message-ID: <20050811110051.GA20872@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


i have released the -53-01 Real-Time Preemption patch, which can be 
downloaded from:

  http://redhat.com/~mingo/realtime-preempt/

there are two new features in this release, which justified the jump 
from .52 to .53:

 - the inclusion of the High Resolution Timers patch, written by
   George Anzinger, and ported/improved/cleaned-up by Thomas Gleixner.

 - the inclusion of the RCU tasklist_lock patch from Paul McKenney.

the HRT patch from George Anzinger is a crutial piece of real-time 
infrastructure. The version included in the -RT tree supports both PIT 
and local APIC timer driven variable-rate timer interrupts.

Thomas Glexiner, besides porting it to PREEMPT_RT, cleaning it up, 
adding the local APIC timer support has also added the 
CONFIG_HIGH_RES_TIMERS_DYN_PRIO feature, which pushes priority 
inheritance into the high-res timer space. Furthermore, Thomas has 
extended nanosleep to use HR timers, if the task is RT. This makes it 
easier to test HRT functionality.

NOTE: there's a new softirq, softirq-hrtimer (PID 8 on UP x86), which 
should be chrt-ed to higher than SCHED_FIFO-50 if HR timer interrupts 
are the most important latencies in the system. E.g.:

  chrt -f 90 -p 8

the RCU tasklist-lock patch is a small but important feature from Paul 
McKenney which enables good HRT latencies: the HRT patch, when using 
POSIX timers, would use a signal-sending codepath that depends on the 
tasklist_lock, and thus the (quite high) tasklist_lock latencies 
controlled the latency of HR timers - defeating much of the benefits of 
HR timers. With the RCU tasklist-lock the signal sending path is now 
RCU-read locked, with no locking dependency, and thus excellent 
worst-case latencies.

given these changes, some (mostly build-related) regressions are to be 
expected. Only the x86 architecture is expected to work for now.

to build a -V0.7.53-01 tree, the following patches should to be applied:

   http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.12.tar.bz2
   http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.13-rc4.bz2
   http://redhat.com/~mingo/realtime-preempt/realtime-preempt-2.6.13-rc4-RT-V0.7.53-01

patches, bugreports and any other feedback welcome,

	Ingo
