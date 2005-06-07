Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261817AbVFGLEy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261817AbVFGLEy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 07:04:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261813AbVFGLEy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 07:04:54 -0400
Received: from mx1.elte.hu ([157.181.1.137]:58846 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261817AbVFGLEv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 07:04:51 -0400
Date: Tue, 7 Jun 2005 13:04:09 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Subject: [patch] Real-Time Preemption, -RT-2.6.12-rc6-V0.7.47-20
Message-ID: <20050607110409.GA14613@elte.hu>
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


i have released the -V0.7.47-20 Real-Time Preemption patch, which can be 
downloaded from the usual place:

    http://redhat.com/~mingo/realtime-preempt/

i've implemented two new features:

 - new debugging feature: CONFIG_DEBUG_RT_LOCKING_MODE, which
   adds the /proc/sys/kernel/preempt_locks flag (default: 0). This way
   the 'locking model' can be switched runtime - very useful for
   debugging and profiling. Value 0 means that all spinlocks and rwlocks
   are implemented via raw spinlocks/rwlocks. (which disable preemption,
   increase latency, but improve throughput) Value 1 means the kernel 
   will fully preempt all locks again. (NOTE: the only safe runtime 
   switching of the locking model can be done while the system is idle, 
   so i've implemented the flag via two flags where the idle thread 
   propagates the new value from the user-flag to the kernel-flag. You 
   should put a "sleep 1" into scripts that switch the locking mode, to 
   guarantee that the new flag value is picked up.)

 - performance feature: i've implemented a new scheduler feature called 
   'delayed preemption', which turns sync wakeups into guaranteed 
   wakeups, while preserving their workload-batching properties. A 
   delayed preemption request is implemented via the 
   TIF_NEED_RESCHED_DELAYED flag, which runs in parallel to the 
   "immediate preemption" TIF_NEED_RESCHED flag. If this works out fine 
   then it will be a suitable replacement for the upstream sync-wakeups 
   facility as well.

delayed preemption already improved the performance of 'hackbench' under 
PREEMPT_RT quite signifiantly.

to build a -V0.7.47-20 tree, the following patches have to be applied:

   http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.11.tar.bz2
   http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.12-rc6.bz2
   http://redhat.com/~mingo/realtime-preempt/realtime-preempt-2.6.12-rc6-V0.7.47-20

	Ingo
