Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161092AbWJROwa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161092AbWJROwa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 10:52:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161091AbWJROwa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 10:52:30 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:65198 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1161092AbWJROw3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 10:52:29 -0400
Date: Wed, 18 Oct 2006 07:53:21 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       John Stultz <johnstul@us.ibm.com>, Dipankar Sarma <dipankar@in.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>, Mike Galbraith <efault@gmx.de>,
       Daniel Walker <dwalker@mvista.com>,
       Manish Lachwani <mlachwani@mvista.com>, bastien.dugue@bull.net,
       Lee Revell <rlrevell@joe-job.com>
Subject: Re: 2.6.18-rt6
Message-ID: <20061018145321.GD1902@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20061018083921.GA10993@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20061018083921.GA10993@elte.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2006 at 10:39:21AM +0200, Ingo Molnar wrote:
> 
> i've released the 2.6.18-rt6 tree, which can be downloaded from the 
> usual place:
> 
>   http://redhat.com/~mingo/realtime-preempt/
> 
> this is a fixes-mostly release. Changes since -rt4:
> 
>  - fix for module loading / symbol table crash (John Stultz)
>  - scheduler fix (Mike Galbraith)
>  - fix x86_64 NMI watchdog & preempt-rcu interaction
>  - fix time-warp false positives
>  - jiffies_to_timespec export fix (Steven Rostedt)
>  - ll_rw_block.c warning fix (Mike Galbraith)
>  - PPC updates (Daniel Walker)
>  - MIPS updates (Manish Lachwani)
>  - ARM oprofile fix (Kevin Hilman)
>  - traditional futexes queued via plists (Séstien Duguése)
>  - (various other smaller fixes)
> 
> to build a 2.6.18-rt6 tree, the following patches should be applied:
> 
>   http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.18.tar.bz2
>   http://redhat.com/~mingo/realtime-preempt/patch-2.6.18-rt6
> 
> as usual, bugreports, fixes and suggestions are welcome,

A nit from IPv6, since I happened by chance to run this on an IPv6
machine -- there are a couple of smp_processor_id() calls that need
to be raw_smp_processor_id() to suppress warnings.  I believe that this
is the correct change, as it seems to me that the locking protects
things so that preemption is not a problem.  That said, I cannot claim
to be an IPv6 expert.  Tested on x86.

Signed-off-by: Paul E. McKenney <paulmck@us.ibm.com>
---

 ip6_tables.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -urpNa -X dontdiff linux-2.6.18-rt3/net/ipv6/netfilter/ip6_tables.c linux-2.6.18-rt3-ip6t_do_table/net/ipv6/netfilter/ip6_tables.c
--- linux-2.6.18-rt3/net/ipv6/netfilter/ip6_tables.c	2006-09-19 20:42:06.000000000 -0700
+++ linux-2.6.18-rt3-ip6t_do_table/net/ipv6/netfilter/ip6_tables.c	2006-10-17 17:44:55.000000000 -0700
@@ -285,7 +285,7 @@ ip6t_do_table(struct sk_buff **pskb,
 	read_lock_bh(&table->lock);
 	private = table->private;
 	IP_NF_ASSERT(table->valid_hooks & (1 << hook));
-	table_base = (void *)private->entries[smp_processor_id()];
+	table_base = (void *)private->entries[raw_smp_processor_id()];
 	e = get_entry(table_base, private->hook_entry[hook]);
 
 	/* For return from builtin chain */
@@ -1110,7 +1110,7 @@ do_add_counters(void __user *user, unsig
 
 	i = 0;
 	/* Choose the copy that is on our node */
-	loc_cpu_entry = private->entries[smp_processor_id()];
+	loc_cpu_entry = private->entries[raw_smp_processor_id()];
 	IP6T_ENTRY_ITERATE(loc_cpu_entry,
 			  private->size,
 			  add_counter_to_entry,
