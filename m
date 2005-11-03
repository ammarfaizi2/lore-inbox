Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964785AbVKCKMf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964785AbVKCKMf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 05:12:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964791AbVKCKMf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 05:12:35 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:43428 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964785AbVKCKMe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 05:12:34 -0500
Date: Thu, 3 Nov 2005 11:12:49 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: =?utf-8?B?UGF3ZcWC?= Sikora <pluto@agmk.net>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       netfilter-devel@lists.netfilter.org
Subject: Re: [2.6.14-rt1] slowdown / oops.
Message-ID: <20051103101249.GB18467@elte.hu>
References: <200511021420.28104.pluto@agmk.net> <20051102134723.GB13468@elte.hu> <20051102135516.GA16175@elte.hu> <20051102140025.GA17385@elte.hu> <20051102142533.GA18453@elte.hu> <20051102151242.GA23809@elte.hu> <20051102153352.GA26115@elte.hu> <1130983742.8734.19.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1130983742.8734.19.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.4
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Rusty Russell <rusty@rustcorp.com.au> wrote:

> > -	local_bh_disable();
> > +	read_lock_bh(&ip_conntrack_lock);

> This kind of change is troubling.  I suppose we could go to per-cpu 
> locks, but it's still a loss.

yeah, that's the right solution i think - with a small twist that should 
address your remaining concern: in the -rt tree there is already an API 
variant that gives us per-cpu locks on PREEMPT_RT but which maps to a 
plain per-cpu data structure on non-PREEMPT_RT builds. The idea is to 
pick a CPU once, and to stick to that choice during the critical 
section. This gives us nice per-CPU scalability, keeps the locks 
finegrained so that are no unnecessary interactions between critical 
sections - and keeps things fully preemptible at a small cost.

the patch below shows the API usage - it's pretty straightforward, and 
this has solved the bug too. Conversion is easy: all places that needed 
changing were triggered at build-time, and once converted the first 
attempt booted and worked just fine.

I dont yet want to submit this approach upstream because right now only 
PREEMPT_RT needs it, but what do you think about the approach? It could 
be used by the upstream kernel too, to enable the use of PER_CPU data 
structures in cases where preemption can not always be avoided.

	Ingo

Index: linux/include/linux/netfilter_ipv4/ip_conntrack.h
===================================================================
--- linux.orig/include/linux/netfilter_ipv4/ip_conntrack.h
+++ linux/include/linux/netfilter_ipv4/ip_conntrack.h
@@ -460,10 +460,8 @@ struct ip_conntrack_ecache {
 	struct ip_conntrack *ct;
 	unsigned int events;
 };
-DECLARE_PER_CPU(struct ip_conntrack_ecache, ip_conntrack_ecache);
+DECLARE_PER_CPU_LOCKED(struct ip_conntrack_ecache, ip_conntrack_ecache);
 
-#define CONNTRACK_ECACHE(x)	(__get_cpu_var(ip_conntrack_ecache).x)
- 
 extern struct notifier_block *ip_conntrack_chain;
 extern struct notifier_block *ip_conntrack_expect_chain;
 
@@ -498,12 +496,14 @@ ip_conntrack_event_cache(enum ip_conntra
 {
 	struct ip_conntrack *ct = (struct ip_conntrack *)skb->nfct;
 	struct ip_conntrack_ecache *ecache;
-	
+	int cpu;
+
 	local_bh_disable();
-	ecache = &__get_cpu_var(ip_conntrack_ecache);
+	ecache = &get_cpu_var_locked(ip_conntrack_ecache, &cpu);
 	if (ct != ecache->ct)
 		__ip_ct_event_cache_init(ct);
 	ecache->events |= event;
+	put_cpu_var_locked(ip_conntrack_ecache, cpu);
 	local_bh_enable();
 }
 
Index: linux/net/ipv4/netfilter/ip_conntrack_core.c
===================================================================
--- linux.orig/net/ipv4/netfilter/ip_conntrack_core.c
+++ linux/net/ipv4/netfilter/ip_conntrack_core.c
@@ -83,7 +83,7 @@ static unsigned int ip_conntrack_expect_
 struct notifier_block *ip_conntrack_chain;
 struct notifier_block *ip_conntrack_expect_chain;
 
-DEFINE_PER_CPU(struct ip_conntrack_ecache, ip_conntrack_ecache);
+DEFINE_PER_CPU_LOCKED(struct ip_conntrack_ecache, ip_conntrack_ecache);
 
 /* deliver cached events and clear cache entry - must be called with locally
  * disabled softirqs */
@@ -104,20 +104,23 @@ __ip_ct_deliver_cached_events(struct ip_
 void ip_ct_deliver_cached_events(const struct ip_conntrack *ct)
 {
 	struct ip_conntrack_ecache *ecache;
-	
+	int cpu;
+
 	local_bh_disable();
-	ecache = &__get_cpu_var(ip_conntrack_ecache);
+	ecache = &get_cpu_var_locked(ip_conntrack_ecache, &cpu);
 	if (ecache->ct == ct)
 		__ip_ct_deliver_cached_events(ecache);
+	put_cpu_var_locked(ip_conntrack_ecache, cpu);
 	local_bh_enable();
 }
 
 void __ip_ct_event_cache_init(struct ip_conntrack *ct)
 {
 	struct ip_conntrack_ecache *ecache;
+	int cpu = raw_smp_processor_id();
 
 	/* take care of delivering potentially old events */
-	ecache = &__get_cpu_var(ip_conntrack_ecache);
+	ecache = &__get_cpu_var_locked(ip_conntrack_ecache, cpu);
 	BUG_ON(ecache->ct == ct);
 	if (ecache->ct)
 		__ip_ct_deliver_cached_events(ecache);
@@ -133,8 +136,11 @@ static void ip_ct_event_cache_flush(void
 	struct ip_conntrack_ecache *ecache;
 	int cpu;
 
+	/*
+	 * First get all locks, then do the flush and drop the locks.
+	 */
 	for_each_cpu(cpu) {
-		ecache = &per_cpu(ip_conntrack_ecache, cpu);
+		ecache = &__get_cpu_var_locked(ip_conntrack_ecache, cpu);
 		if (ecache->ct)
 			ip_conntrack_put(ecache->ct);
 	}
Index: linux/net/ipv4/netfilter/ip_conntrack_standalone.c
===================================================================
--- linux.orig/net/ipv4/netfilter/ip_conntrack_standalone.c
+++ linux/net/ipv4/netfilter/ip_conntrack_standalone.c
@@ -977,7 +977,7 @@ EXPORT_SYMBOL_GPL(ip_conntrack_expect_ch
 EXPORT_SYMBOL_GPL(ip_conntrack_register_notifier);
 EXPORT_SYMBOL_GPL(ip_conntrack_unregister_notifier);
 EXPORT_SYMBOL_GPL(__ip_ct_event_cache_init);
-EXPORT_PER_CPU_SYMBOL_GPL(ip_conntrack_ecache);
+EXPORT_PER_CPU_LOCKED_SYMBOL_GPL(ip_conntrack_ecache);
 #endif
 EXPORT_SYMBOL(ip_conntrack_protocol_register);
 EXPORT_SYMBOL(ip_conntrack_protocol_unregister);
