Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269257AbUIBXGz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269257AbUIBXGz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 19:06:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269169AbUIBXDl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 19:03:41 -0400
Received: from mx2.elte.hu ([157.181.151.9]:25483 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S269189AbUIBXCE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 19:02:04 -0400
Date: Fri, 3 Sep 2004 01:03:36 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Andrea Arcangeli <andrea@suse.de>, paul@linuxaudiosystems.com,
       rlrevell@joe-job.com, linux-audio-dev@music.columbia.edu,
       arjanv@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [linux-audio-dev] Re: [announce] [patch] Voluntary Kernel Preemption Patch
Message-ID: <20040902230336.GA30920@elte.hu>
References: <20040713220103.GJ974@dualathlon.random> <20040713152532.6df4a163.akpm@osdl.org> <20040713223701.GM974@dualathlon.random> <20040713154448.4d29e004.akpm@osdl.org> <20040713225305.GO974@dualathlon.random> <20040713160628.596b96a3.akpm@osdl.org> <20040713231803.GP974@dualathlon.random> <20040719115952.GA13564@elte.hu> <20040902220301.GA18212@x30.random> <20040902152046.1b34d793.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040902152046.1b34d793.akpm@osdl.org>
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


* Andrew Morton <akpm@osdl.org> wrote:

> None of these approaches improves worst-case latency at all on SMP. 
> If we're not going to address the SMP problem we could just make it
> UP-only, in which case increased locking costs are a non-issue.
> 
> I'd prefer that we find a solution for SMP too though.

i have solved the fundamental SMP latency problems in the -Q7 patch, by
redesigning how SMP preemption is done. Here's the relevant changelog
entry:

[...]

the main change in this patch are more SMP latency fixes. The stock
kernel, even with CONFIG_PREEMPT enabled, didnt have any spin-nicely
preemption logic for the following, commonly used SMP locking
primitives: read_lock(), spin_lock_irqsave(), spin_lock_irq(),
spin_lock_bh(), read_lock_irqsave(), read_lock_irq(), read_lock_bh(),
write_lock_irqsave(), write_lock_irq(), write_lock_bh(). Only
spin_lock() and write_lock() [the two simplest cases] where covered.

In addition to the preemption latency problems, the _irq() variants in
the above list didnt do any IRQ-enabling while spinning - possibly
resulting in excessive irqs-off sections of code!

-Q7 fixes all of these latency problems: we now re-enable interrupts
while spinning in all possible cases, and a spinning op stays
preemptible if this is a beginning of a new critical section.

[...]

feedback from Mark H Johnson:

 http://lkml.org/lkml/2004/8/30/202

the latest patch is:

  http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc1-bk4-R0

i'm already in the process of cleaning up the patch and making it ready
for splitup & merge. The spinlock fixes will be amongst the first
patches i'll send you.

	Ingo
