Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261163AbULJKya@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261163AbULJKya (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 05:54:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261168AbULJKya
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 05:54:30 -0500
Received: from mx1.elte.hu ([157.181.1.137]:46470 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261163AbULJKyZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 05:54:25 -0500
Date: Fri, 10 Dec 2004 11:53:52 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Mark_H_Johnson@raytheon.com
Cc: Amit Shah <amit.shah@codito.com>,
       Karsten Wiese <annabellesgarden@yahoo.de>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, emann@mrv.com,
       Gunther Persoons <gunther_persoons@spymac.com>,
       "K.R. Foley" <kr@cybsft.com>, linux-kernel@vger.kernel.org,
       Florian Schmidt <mista.tapas@gmx.net>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Shane Shrybman <shrybman@aei.ca>, Esben Nielsen <simlo@phys.au.dk>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
Subject: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.32-15
Message-ID: <20041210105352.GA4749@elte.hu>
References: <OF8ABCEBAC.0259E37D-ON86256F65.00727E98@raytheon.com> <20041209225555.GA31588@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20041209225555.GA31588@elte.hu>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-2.201, required 5.9,
	BAYES_00 -4.90, SORTED_RECIPS 2.70
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Ingo Molnar <mingo@elte.hu> wrote:

> this smells too. [...]

found two brown-paperbag bugs that caused bad latencies in the -RT
kernel: when i added PREEMPT_DIRECT (which first showed up in -32-10) i
also added a missed-reschedule bug to try_to_wake_up() and to
mutex/semaphore-unlock (__up()). Oops.

i dont think this bug could explain a msec-range latency because the
syscall return path should catch the missed reschedule and it would need
continuous syscall execution in the milliseconds range by a lowprio task
for a latency to be transported to latencytest, but certainly the bug
doesnt help latencies. The -32-15 kernel can be downloaded from the
usual place:

 http://redhat.com/~mingo/realtime-preempt/

other changes in -32-15: more work on the tracer, cleaner trace output
and the tracing of syscall entries and returns, with arguments and
return values displayed as well (i.e. a simple strace variant). Here is
how a syscall now looks like in /proc/latency_trace:

 loop-tes-3885  0....  100µs > sys_getppid (002fcffc 00000001 0000007b)
 loop-tes-3885  0....  101µs+: sys_getppid (sysenter_past_esp)
 loop-tes-3885  0d...  103µs < (3868)

'< (return-val)' is the syscall return value, '> sys_name(params)' is
the syscall itself. (note that the return path is also used by
interrupts, so it's not purely a syscall-return point) This makes it
easier to track userspace execution.

	Ingo
