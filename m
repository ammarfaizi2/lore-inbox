Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030366AbWGZIUx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030366AbWGZIUx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 04:20:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030419AbWGZIUx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 04:20:53 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:50060 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1030366AbWGZIUw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 04:20:52 -0400
Date: Wed, 26 Jul 2006 10:14:42 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Tim Chen <tim.c.chen@linux.intel.com>
Cc: arjan@infradead.org, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Reducing local_bh_enable/disable overhead in irqtrace
Message-ID: <20060726081442.GB11604@elte.hu>
References: <1153758155.10345.8.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1153758155.10345.8.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.3
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.3 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Tim Chen <tim.c.chen@linux.intel.com> wrote:

> Ingo,
> 
> The recent changes from irqtrace feature has added overheads to 
> local_bh_disable and local_bh_enable that reduces UDP performance 
> across x86_64 and IA64, even though IA64 does not support the irqtrace 
> feature. Patch in question is
> 
> [PATCH]lockdep: irqtrace subsystem, core
> http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=c
> ommit;h=de30a2b355ea85350ca2f58f3b9bf4e5bc007986
> 
> Prior to this patch, local_bh_disable was a short macro. Now it is a 
> function which calls __local_bh_disable with added irq flags save and 
> restore.  The irq flags save and restore were also added to 
> local_bh_enable, probably for injecting the trace irqs code.  This 
> overhead is on the generic code path across all architectures.  On a 
> IA_64 test machine (Itanium-2 1.6 GHz) running a benchmark like 
> netperf's UDP streaming test, the added overhead results in a drop of 
> 3% in throughput, as udp_sendmsg calls the local_bh_enable/disable 
> several times. Other workloads that have heavy usages of 
> local_bh_enable/disable could also be affected. The patch ideally 
> should not have affected IA-64 performance as it does not have IRQ 
> tracing support.  A significant portion of the overhead is in the 
> added irq flags save and restore, which I think is not needed if IRQ 
> tracing is unused. A suggested patch is attached below that recovers 
> the lost performance.  However, the "ifdef"s in the patch are a bit 
> ugly.

agreed - this side-effect of irqtracing should not happen. The #ifdefs 
are ugly, but i can see no better way either.

> Signed-off-by: Tim Chen <tim.c.chen@intel.com>

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
