Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268118AbUIBXXo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268118AbUIBXXo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 19:23:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269204AbUIBXVm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 19:21:42 -0400
Received: from mx2.elte.hu ([157.181.151.9]:51342 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S269267AbUIBXUW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 19:20:22 -0400
Date: Fri, 3 Sep 2004 01:21:33 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Andrea Arcangeli <andrea@suse.de>, paul@linuxaudiosystems.com,
       rlrevell@joe-job.com, linux-audio-dev@music.columbia.edu,
       arjanv@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [linux-audio-dev] Re: [announce] [patch] Voluntary Kernel Preemption Patch
Message-ID: <20040902232133.GA31867@elte.hu>
References: <20040713152532.6df4a163.akpm@osdl.org> <20040713223701.GM974@dualathlon.random> <20040713154448.4d29e004.akpm@osdl.org> <20040713225305.GO974@dualathlon.random> <20040713160628.596b96a3.akpm@osdl.org> <20040713231803.GP974@dualathlon.random> <20040719115952.GA13564@elte.hu> <20040902220301.GA18212@x30.random> <20040902152046.1b34d793.akpm@osdl.org> <20040902230336.GA30920@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040902230336.GA30920@elte.hu>
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


* Ingo Molnar <mingo@elte.hu> wrote:

> i have solved the fundamental SMP latency problems in the -Q7 patch,
> by redesigning how SMP preemption is done. Here's the relevant
> changelog entry:

also this changelog explains the core changes that enable good
preemption latencies on SMP:

[...]

i took another look at SMP latencies, the last larger chunk of code that
produced millisec-category latencies. CONFIG_PREEMPT tries to solve some
of the SMP issues but there were still lots of problems remaining: main
problem area is spinlocks nested at multiple levels. If a piece of code
(e.g. the MM or ext3's journalling code) does the following:

        spin_lock(&spinlock_1);
        ...
        spin_lock(&spinlock_2);
        ...

then even with CONFIG_PREEMPT enabled, current kernels may spin on
spinlock_2 indefinitely. A number of critical sections break their long
paths by using cond_resched_lock(), but this does not break the path on
SMP, because need_resched() is not set in the above case.

(The -mm kernel introduced a couple of patches that try to drop
spinlocks unconditionally at a high frequency: but besides being a
kludge it's also a performance problem, we keep
dropping/waiting/retaking locks quite frequently. That solution also
doesnt solve the problem of cond_resched_lock() not working on SMP.)

to solve the problem i've introduced a new spinlock field,
lock->break_lock, which signals towards the holding CPU that a
spinlock-break is requested by another CPU. This field is only set if a
CPU is spinning in __preempt_spin_lock [at any locking depth], so the
default overhead is zero. I've extended cond_resched_lock() to check for
this flag - in this case we can also save a reschedule. I've added the
lock_need_resched(lock) and need_lockbreak(lock) methods to check for
the need to break out of a critical section.

preliminary results on a dual x86 box show a dramatic reduction in
latencies on SMP - where there used to be 5-10 msec latencies there are
close-to-UP latencies now. But it needs more testing.

[...]

	Ingo
