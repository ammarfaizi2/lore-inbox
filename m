Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262116AbVDFGSy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262116AbVDFGSy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 02:18:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262118AbVDFGSy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 02:18:54 -0400
Received: from mx2.elte.hu ([157.181.151.9]:41922 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262116AbVDFGSu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 02:18:50 -0400
Date: Wed, 6 Apr 2005 08:18:38 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Subject: Re: [patch 4/5] sched: RCU sched domains
Message-ID: <20050406061838.GB5973@elte.hu>
References: <425322E0.9070307@yahoo.com.au> <42532317.5000901@yahoo.com.au> <42532346.5050308@yahoo.com.au> <425323A1.5030603@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <425323A1.5030603@yahoo.com.au>
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


* Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> 4/5

> One of the problems with the multilevel balance-on-fork/exec is that 
> it needs to jump through hoops to satisfy sched-domain's locking 
> semantics (that is, you may traverse your own domain when not 
> preemptable, and you may traverse others' domains when holding their 
> runqueue lock).
> 
> balance-on-exec had to potentially migrate between more than one CPU 
> before finding a final CPU to migrate to, and balance-on-fork needed 
> to potentially take multiple runqueue locks.
> 
> So bite the bullet and make sched-domains go completely RCU. This 
> actually simplifies the code quite a bit.
> 
> Signed-off-by: Nick Piggin <nickpiggin@yahoo.com.au>

i like it conceptually, so:

Acked-by: Ingo Molnar <mingo@elte.hu>

from now on, all domain-tree readonly uses have to be rcu_read_lock()-ed 
(or otherwise have to be in a non-preemptible section). But there's a 
bug in show_shedstats() which does a for_each_domain() from within a 
preemptible section. (It was a bug with the current hotplug logic too i 
think.)

At a minimum i think we need the fix+comment below.

	Ingo

Signed-off-by: Ingo Molnar <mingo@elte.hu>

--- linux/kernel/sched.c.orig
+++ linux/kernel/sched.c
@@ -260,6 +260,10 @@ struct runqueue {
 
 static DEFINE_PER_CPU(struct runqueue, runqueues);
 
+/*
+ * The domain tree (rq->sd) is RCU locked. I.e. it may only be accessed
+ * from within an rcu_read_lock() [or otherwise preempt-disabled] sections.
+ */
 #define for_each_domain(cpu, domain) \
 	for (domain = cpu_rq(cpu)->sd; domain; domain = domain->parent)
 
@@ -338,6 +342,7 @@ static int show_schedstat(struct seq_fil
 
 #ifdef CONFIG_SMP
 		/* domain-specific stats */
+		rcu_read_lock();
 		for_each_domain(cpu, sd) {
 			enum idle_type itype;
 			char mask_str[NR_CPUS];
@@ -361,6 +366,7 @@ static int show_schedstat(struct seq_fil
 			    sd->sbe_pushed, sd->sbe_attempts,
 			    sd->ttwu_wake_remote, sd->ttwu_move_affine, sd->ttwu_move_balance);
 		}
+		rcu_read_unlock();
 #endif
 	}
 	return 0;
 
