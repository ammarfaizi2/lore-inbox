Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265932AbUIDTud@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265932AbUIDTud (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 15:50:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265943AbUIDTud
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 15:50:33 -0400
Received: from mx1.elte.hu ([157.181.1.137]:34275 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S265932AbUIDTub (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 15:50:31 -0400
Date: Sat, 4 Sep 2004 21:51:41 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Florian Schmidt <mista.tapas@gmx.net>, "K.R. Foley" <kr@cybsft.com>
Cc: linux-kernel@vger.kernel.org, rlrevell@joe-job.com,
       felipe_alfaro@linuxmail.org
Subject: [patch] voluntary-preempt-2.6.9-rc1-bk4-R4
Message-ID: <20040904195141.GA6208@elte.hu>
References: <20040903120957.00665413@mango.fruits.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040903120957.00665413@mango.fruits.de>
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


ok, found and fixed the bug reported by K.R. Foley, and found the bug
reported by Florian Schmidt as well.

the first bug was caused by an unrobustness in cond_resched(). The bug
happens when a task that is in do_exit() happens to be preempted via
cond_resched() - the TASK_ZOMBIE/TASK_DEAD task state is overwritten
with TASK_RUNNING and then the task crashes in the 'final' schedule. To
fix this i've changed cond_resched() to be much closer in behavior to
preempt_schedule() - this makes sense anyway.

Florian's bug triggers if softirq_preemption is disabled: if a softirq
still gets delayed to softirqd (this can happen even in the stock
kernel, under certain circumstances) then it would be executed without
disabling direct softirq execution. While this is safe and intended to
make softirqd preemptable when softirq_preemption==1, it's unsafe and an
illegal preemption when there are indirect softirqs around. The fix is
to properly disable softirqs in this branch too.

i've uploaded -R4 which fixes these two bugs:

  http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc1-bk4-R4

other changes in -R4:

 - add the RX-break-up to e100.c which was promised in -R0 - patch was 
   missing by mistake.

 - small tweaks to the latency_trace header

	Ingo
