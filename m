Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268576AbUJSMp0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268576AbUJSMp0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 08:45:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268746AbUJSMp0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 08:45:26 -0400
Received: from mx1.elte.hu ([157.181.1.137]:9395 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S268576AbUJSMpN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 08:45:13 -0400
Date: Tue, 19 Oct 2004 14:46:06 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Mark_H_Johnson@Raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U6
Message-ID: <20041019124605.GA28896@elte.hu>
References: <20041012091501.GA18562@elte.hu> <20041012123318.GA2102@elte.hu> <20041012195424.GA3961@elte.hu> <20041013061518.GA1083@elte.hu> <20041014002433.GA19399@elte.hu> <20041014143131.GA20258@elte.hu> <20041014234202.GA26207@elte.hu> <20041015102633.GA20132@elte.hu> <20041016153344.GA16766@elte.hu> <20041018145008.GA25707@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041018145008.GA25707@elte.hu>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


i have released the -U6 Real-Time Preemption patch:
 
  http://redhat.com/~mingo/realtime-preempt/realtime-preempt-2.6.9-rc4-mm1-U6

this is a fixes-only release.

found and fixed the 'big bug' that was probably the one causing
stability problems for a number of people. There was a small window for
a task double-free race to occur, causing all sorts of crashes later on.
This bug could trigger on UP and SMP systems alike, on SMP being a bit
more frequent.

Also, a common networking deadlock was found and fixed as well, using
the deadlock detector.

Changes since -U5:

- crash bug: fix task double free caused by irq-preemption of 
  do_exit(). This got introduced in -U5 as part of a simplification of
  the zombie-reaping rewrite that the -U series did. That rewrite had an 
  unrobustness which got triggered by -U5 in a subtle way, opening up a
  small window at the end of do_exit() for an interrupt-triggered
  preemption to cause a double-free. This could fix some of the crashes
  reported by Rui Nuno Capela, Mark H Johnson.

- deadlock bug: fix networking deadlock reported by Matthew L Foster.
  Restructured the way the RT-RCU locking of ptype_lock is done - it's
  cleaner and more obvious now (besides being correct). This could also
  fix the deadlock reported by Michal Schmidt.

- deadlock bug: fix NFS startup breakage related to semaphore abuse,
  patch from Thomas Gleixner.

- build bug: fix aha152x.c, based on patch from K.R. Foley.

- build bug: fix compilation error in qla2xxx. (reported by Fernando
  Pablo Lopez-Lezcano and Mark H Johnson)

- build bug: fix !PREEMPT_REALTIME compilation error. (reported by
  Matthew L Foster)

- build bug: fix ipmi-watchdog compilation error. (reported by Mark H 
  Johnson)

- tracer fix: if an assert happens within the tracer then we'd get into
  infinite recursion. The fix was to correctly nest tracing on/off
  points.

- debug enhancement: added a few more asserts to catch underflowing 
  atomic counters. (this made the task double-free trigger earlier.)

- debug enhancement: extended CONFIG_DEBUG_STACKOVERFLOW to be 
  mcount()-driven as well. This helps in catching stack overflows much
  more reliably than the do_IRQ() based method.

to create a -U6 tree from scratch, the patching order is:

   http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.8.tar.bz2
 + http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.9-rc4.bz2
 + http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc4/2.6.9-rc4-mm1/2.6.9-rc4-mm1.bz2
 + http://redhat.com/~mingo/realtime-preempt/realtime-preempt-2.6.9-rc4-mm1-U6

	Ingo
