Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266613AbUIANvG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266613AbUIANvG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 09:51:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267394AbUIANuz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 09:50:55 -0400
Received: from mx2.elte.hu ([157.181.151.9]:54661 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S266806AbUIANtv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 09:49:51 -0400
Date: Wed, 1 Sep 2004 15:51:22 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: "K.R. Foley" <kr@cybsft.com>, Mark_H_Johnson@raytheon.com,
       Lee Revell <rlrevell@joe-job.com>
Subject: [patch] voluntary-preempt-2.6.9-rc1-bk4-Q7
Message-ID: <20040901135122.GA18708@elte.hu>
References: <200408282210.03568.pnambic@unu.nu> <20040828203116.GA29686@elte.hu> <1093727453.8611.71.camel@krustophenia.net> <20040828211334.GA32009@elte.hu> <1093727817.860.1.camel@krustophenia.net> <1093737080.1385.2.camel@krustophenia.net> <1093746912.1312.4.camel@krustophenia.net> <20040829054339.GA16673@elte.hu> <20040830090608.GA25443@elte.hu> <20040901082958.GA22920@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040901082958.GA22920@elte.hu>
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


i've released the -Q7 patch:

  http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc1-bk4-Q7

ontop of:

  http://redhat.com/~mingo/voluntary-preempt/diff-bk-040828-2.6.8.1.bz2

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

there's also an SMP related tracing improvement in -Q7: the NMI tracing
code now traces the other CPUs too - this way if an NMI hits a
particulary long section, we'll have a chance to see what the other CPU
was doing. These show up as double do_nmi() trace entries on a 2-CPU x86
box. The first one is the current CPU, subsequent entries are the other
CPUs in the system.

(-Q7 is not that interesting to uniprocessor kernel users, but it would
still be useful to test it, just to see nothing broke (on the
compilation side), lots of spinlock code had to be changed.)

	Ingo
