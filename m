Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267183AbTBDJVf>; Tue, 4 Feb 2003 04:21:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267184AbTBDJVf>; Tue, 4 Feb 2003 04:21:35 -0500
Received: from ophelia.ess.nec.de ([193.141.139.8]:25731 "EHLO
	ophelia.hpce.nec.com") by vger.kernel.org with ESMTP
	id <S267183AbTBDJVd> convert rfc822-to-8bit; Tue, 4 Feb 2003 04:21:33 -0500
Content-Type: text/plain; charset=US-ASCII
From: Erich Focht <efocht@ess.nec.de>
To: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: [patch] HT scheduler, sched-2.5.59-E2
Date: Tue, 4 Feb 2003 10:31:20 +0100
User-Agent: KMail/1.4.3
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       Andrew Theurer <habanero@us.ibm.com>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>,
       Matthew Dobson <colpatch@us.ibm.com>,
       Christoph Hellwig <hch@infradead.org>, Robert Love <rml@tech9.net>,
       Linus Torvalds <torvalds@transmeta.com>,
       lse-tech <lse-tech@lists.sourceforge.net>,
       Anton Blanchard <anton@samba.org>, Andrea Arcangeli <andrea@suse.de>
References: <Pine.LNX.4.44.0302031812500.12700-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.44.0302031812500.12700-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200302041031.20394.efocht@ess.nec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

On Monday 03 February 2003 19:23, Ingo Molnar wrote:
> -#define
> CAN_MIGRATE_TASK(p,rq,this_cpu)                                        \
> -       ((jiffies - (p)->sleep_timestamp > cache_decay_ticks) &&        \
> -               !task_running(rq, p) &&                                 \
> -                       ((p)->cpus_allowed & (1UL << (this_cpu)))) +#define
> CAN_MIGRATE_TASK(p,rq,cpu)                                     \
> +       ((idle || (jiffies - (p)->last_run > cache_decay_ticks)) && \
> +               !task_running(p) && task_allowed(p, cpu))

at least for NUMA systems this is too aggressive (though I believe
normal SMP systems could be hurt, too).

The problem: freshly forked tasks are stolen by idle cpus on the same
node before they exec. This actually disables the sched_balance_exec()
mechanism as the tasks to be balanced already run alone on other
CPUs. Which means: the whole benefit of having balanced nodes
(maximize the memory bandwidth) is gone.

The change below is less aggressive but in the same philosophy. Could
you please take it instead?

> CAN_MIGRATE_TASK(p,rq,cpu)                                     \
> +       ((jiffies - (p)->last_run > (cache_decay_ticks >> idle)) && \
> +               !task_running(p) && task_allowed(p, cpu))

Regards,
Erich

