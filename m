Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265207AbUGISfe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265207AbUGISfe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 14:35:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265218AbUGISfe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 14:35:34 -0400
Received: from mx2.elte.hu ([157.181.151.9]:58257 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S265207AbUGISfP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 14:35:15 -0400
Date: Fri, 9 Jul 2004 20:26:38 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Arjan van de Ven <arjanv@redhat.com>
Subject: [announce] [patch] Voluntary Kernel Preemption Patch
Message-ID: <20040709182638.GA11310@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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


as most of you are probably aware of it, there have been complaints on
lkml that the 2.6 kernel is not suitable for serious audio work due to
high scheduling latencies (e.g. the Jackit people complained). I took a
look at latencies and indeed 2.6.7 is pretty bad - latencies up to 50
msec (!) can be easily triggered using common workloads, on fast 2GHz+
x86 system - even when using the fully preemptible kernel!

to solve this problem, Arjan van de Ven and I went over various kernel
functions to determine their preemptability and we re-created from
scratch a patch that is equivalent in performance to the 2.4 lowlatency
patches but is different in design, impact and approach:

  http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.7-bk20-H2

  (Note to kernel patch reviewers: the split voluntary_resched type of
  APIs, the feature #ifdefs and runtime flags are temporary and were
  only introduced to enable a easy benchmarking/comparisons. I'll split
  this up into small pieces once there's testing feedback and actual
  audio users had their say!)

unlike the lowlatency patches, this patch doesn't add a lot of new
scheduling points to the source code, it rather reuses a rich but
currently inactive set of scheduling points that already exist in the
2.6 tree: the might_sleep() debugging checks. Any code point that does
might_sleep() is in fact ready to sleep at that point. So the patch
activates these debugging checks to be scheduling points. This reduces
complexity and impact quite significantly.

but even using these (over one hundred) might_sleep() points there were
still a number of latency sources in the kernel - we identified and
fixed them by hand, either via additional might_sleep() checks, or via
explicit rescheduling points. Sometimes lock-break was necessary as
well.

as a practical goal, this patch aims to fix all latency sources that
generate higher than ~1 msec latencies. We'd love to learn about
workloads that still cause audio skipping even with this patch applied,
but i've been unable to generate any load that creates higher than 1msec
latencies. (not counting driver initialization routines.)

this patch is also more configurable than the 2.4 lowlatency patches
were: there's a .config option to enable voluntary preemption, and there
are runtime /proc/sys knobs and boot-time flags to turn voluntary
preemption (CONFIG_VOLUNTARY_PREEMPT) and kernel preemption
(CONFIG_PREEMPT) on/off:

        # turn on/off voluntary preemption (if CONFIG_VOLUNTARY_PREEMPT)
	echo 1 > /proc/sys/kernel/voluntary_preemption
	echo 0 > /proc/sys/kernel/voluntary_preemption

        # turn on/off the preemptible kernel feature (if CONFIG_PREEMPT)
	/proc/sys/kernel/kernel_preemption
	/proc/sys/kernel/kernel_preemption

the 'voluntary-preemption=0/1' and 'kernel-preemption=0/1' boot options
can be used to control these flags at boot-time.

all 4 combinations make sense if both CONFIG_PREEMPT and
CONFIG_VOLUNTARY_PREEMPT are enabled - great for performance/latency
testing and comparisons.

The stock 2.6 kernel is equivalent to:

   voluntary_preemption:0 kernel_preemption:0

the 2.6 kernel with voluntary kernel preemption is equivalent to:

   voluntary_preemption:1 kernel_preemption:0

the 2.6 kernel with preemptible kernel enabled is:

   voluntary_preemption:0 kernel_preemption:1

and the preemptible kernel enhanced with additional lock-breaks is 
enabled via:

   voluntary_preemption:1 kernel_preemption:1

it is safe to change these flags anytime.

The patch is against 2.6.7-bk20, and it also includes fixes for kernel
bugs that were uncovered while developing this patch. While it works for
me, be careful when using this patch!

Testreports, comments, suggestions are more than welcome,

	Ingo
