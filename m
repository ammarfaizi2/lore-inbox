Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263871AbTLTKzW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Dec 2003 05:55:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263883AbTLTKzW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Dec 2003 05:55:22 -0500
Received: from mx2.elte.hu ([157.181.151.9]:18130 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S263871AbTLTKzR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Dec 2003 05:55:17 -0500
Date: Sat, 20 Dec 2003 11:50:31 +0100
From: Ingo Molnar <mingo@elte.hu>
To: John Hawkes <hawkes@babylon.engr.sgi.com>
Cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       johnstul@us.ibm.com, Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC][PATCH] 2.6.0-test11 sched_clock() broken for "drifty ITC"
Message-ID: <20031220105031.GA17848@elte.hu>
References: <200312182044.hBIKiCLY5477429@babylon.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200312182044.hBIKiCLY5477429@babylon.engr.sgi.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: SpamAssassin ELTE 1.0
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* John Hawkes <hawkes@babylon.engr.sgi.com> wrote:

> Some amount of code would need to be added to sched.c to deal with
> unsynchronized values: scheduler_tick() remembers a local jiffies-
> granularity sched_clock() in the runqueue struct, and load_balance's
> can_migrate_task() uses that saved timestamp to compare against the
> tested task->timestamp to determine cache-hot-or-not, rather than
> using the local CPU's sched_clock() value.  Also, task->timestamp
> needs to be readjusted when the task migrates:

this is a tough problem that wont go away.

Even platforms where the per-CPU clock is supposed to be synchronized,
sometimes it isnt. (this is a recurring problem on x86 SMP - so x86 will
benefit from it too.)

the relaxation means the effective granularity reduction of the
migration decisions - but this is not a problem, migration latencies are
always a high multiple of the timer irq frequency. The cycle accuracy of
sched_clock() is otherwise very important for correct interactivity
decisions - but this is only used locally and is thus preserved by the
patch. The only area where this change can reduce the quality of
interactivity estimatio is when a task oscillates very quickly between
multiple CPUs and is also somehow relevant to interactivity.

So i believe the generic relaxing of sched_clock() synchronization is
the right thing to do. I like your patch. It adds minimal overhead and
solves a hard problem - nice work! Andrew, please apply it.

	Ingo
