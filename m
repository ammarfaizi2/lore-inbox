Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267499AbUG2Wbm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267499AbUG2Wbm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 18:31:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267494AbUG2W3Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 18:29:24 -0400
Received: from mx1.elte.hu ([157.181.1.137]:28817 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S267467AbUG2W2K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 18:28:10 -0400
Date: Fri, 30 Jul 2004 00:26:57 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Lee Revell <rlrevell@joe-job.com>,
       Scott Wood <scott@timesys.com>
Subject: [patch] voluntary-preempt-2.6.8-rc2-M5
Message-ID: <20040729222657.GA10449@elte.hu>
References: <40F3F0A0.9080100@vision.ee> <20040713143947.GG21066@holomorphy.com> <1090732537.738.2.camel@mindpipe> <1090795742.719.4.camel@mindpipe> <20040726082330.GA22764@elte.hu> <1090830574.6936.96.camel@mindpipe> <20040726083537.GA24948@elte.hu> <1090832436.6936.105.camel@mindpipe> <20040726124059.GA14005@elte.hu> <20040726204720.GA26561@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040726204720.GA26561@elte.hu>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


i've uploaded the latest version of the voluntary-preempt patch:
 
   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.8-rc2-M5

the biggest change is that i've integrated the irq threads code from
Scott Wood. I've done a number of usability enhancements:

added a new mechanism for finegrained configuration of threadedness /
nonthreadedness at the handler level: there are new:

   /proc/irq/<N>/<handler>/threaded

entries that control this behavior. Writing 0 to such an entry makes
that particular handler 'directly executed', writing 1 to it turns it
back to be handled by its own IRQ kernel thread.

E.g. the following command changes the serial line interrupt back to
non-threaded:

   echo 0 > /proc/irq/*/serial/threaded

the IRQ threads show up at low PID numbers (typically between 100 and
200) and their RT priority can be set via the 'chrt' utility (part of
schedutils). E.g. setting IRQ 10's irq thread priority back to the
non-RT SCHED_OTHER class can be done via:

  chrt --other --pid 0 `pidof 'IRQ 10'`

and to change IRQ 4's thread to SCHED_FIFO and the highest RT priority:

  chrt --fifo --pid 99 `pidof 'IRQ 4'`

to get good audio latencies i'd suggest to set the the audio driver's
and the RT-clock driver's IRQ handler to be non-threaded, and to set
jackd's RT priority to higher than 50 (which is the default of the IRQ
threads).

But it would also be interesting to see how the maximum latencies look
like if both the RT-clock and the audio handlers are threaded, and the
two affected IRQ threads are set to SCHED_FIFO 99 priority - they should
preempt everything. The latency increase compared to the 'direct' setup
should show us the real-life overhead of hardirq redirection.

the patch also changes the way the IDE latencies are avoided: based on
suggestions from Jens the latency-critical portion of the driver is now
done without holding ide_lock - and this makes the driver preemptable if
the handler is running in a thread.

if booting with voluntary-preempt=2/0/1 (the default is 3) then all
interrupts default to being non-threaded. Note that the /proc entries
can be used to turn threadedness back on even in this case - this can be
used to debug problematic drivers.

i made the irq-threads code work on SMP too: the IRQ threads now bind
themselves according to the value of /proc/irq/<N>/smp_affinity and
change the binding of that value is modified. IRQ threads only migrate
when it's safe - there will be no migration to another CPU while
executing a hardirq.

	Ingo
