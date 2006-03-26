Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751463AbWCZQh0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751463AbWCZQh0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 11:37:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751465AbWCZQh0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 11:37:26 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:20373 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751463AbWCZQhZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 11:37:25 -0500
Date: Sun, 26 Mar 2006 18:34:50 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-rt21, BUG at net/ipv4/netfilter/ip_conntrack_core.c:124
Message-ID: <20060326163450.GA22411@elte.hu>
References: <1143339628.5527.3.camel@cmn2.stanford.edu> <20060326163056.GC15667@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060326163056.GC15667@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.6
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.6 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.7 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> > Mar 23 15:22:48 host kernel: BUG at
> > net/ipv4/netfilter/ip_conntrack_core.c:124!
> 
> does the patch below help?

updated patch below.

	Ingo

Index: linux/include/linux/netfilter_ipv4/ip_conntrack.h
===================================================================
--- linux.orig/include/linux/netfilter_ipv4/ip_conntrack.h
+++ linux/include/linux/netfilter_ipv4/ip_conntrack.h
@@ -336,7 +336,8 @@ ip_conntrack_expect_unregister_notifier(
 }
 
 extern void ip_ct_deliver_cached_events(const struct ip_conntrack *ct);
-extern void __ip_ct_event_cache_init(struct ip_conntrack *ct);
+extern void __ip_ct_event_cache_init(struct ip_conntrack_ecache *ecache,
+				     struct ip_conntrack *ct);
 
 static inline void 
 ip_conntrack_event_cache(enum ip_conntrack_events event,
@@ -349,7 +350,7 @@ ip_conntrack_event_cache(enum ip_conntra
 	local_bh_disable();
 	ecache = &get_cpu_var_locked(ip_conntrack_ecache, &cpu);
 	if (ct != ecache->ct)
-		__ip_ct_event_cache_init(ct);
+		__ip_ct_event_cache_init(ecache, ct);
 	ecache->events |= event;
 	put_cpu_var_locked(ip_conntrack_ecache, cpu);
 	local_bh_enable();
Index: linux/net/ipv4/netfilter/arp_tables.c
===================================================================
--- linux.orig/net/ipv4/netfilter/arp_tables.c
+++ linux/net/ipv4/netfilter/arp_tables.c
@@ -248,7 +248,7 @@ unsigned int arpt_do_table(struct sk_buf
 	outdev = out ? out->name : nulldevname;
 
 	read_lock_bh(&table->lock);
-	table_base = (void *)private->entries[smp_processor_id()];
+	table_base = (void *)private->entries[raw_smp_processor_id()];
 	e = get_entry(table_base, private->hook_entry[hook]);
 	back = get_entry(table_base, private->underflow[hook]);
 
@@ -948,7 +948,7 @@ static int do_add_counters(void __user *
 
 	i = 0;
 	/* Choose the copy that is on our node */
-	loc_cpu_entry = private->entries[smp_processor_id()];
+	loc_cpu_entry = private->entries[raw_smp_processor_id()];
 	ARPT_ENTRY_ITERATE(loc_cpu_entry,
 			   private->size,
 			   add_counter_to_entry,
Index: linux/net/ipv4/netfilter/ip_conntrack_core.c
===================================================================
--- linux.orig/net/ipv4/netfilter/ip_conntrack_core.c
+++ linux/net/ipv4/netfilter/ip_conntrack_core.c
@@ -114,13 +114,10 @@ void ip_ct_deliver_cached_events(const s
 	local_bh_enable();
 }
 
-void __ip_ct_event_cache_init(struct ip_conntrack *ct)
+void __ip_ct_event_cache_init(struct ip_conntrack_ecache *ecache,
+			      struct ip_conntrack *ct)
 {
-	struct ip_conntrack_ecache *ecache;
-	int cpu = raw_smp_processor_id();
-
 	/* take care of delivering potentially old events */
-	ecache = &__get_cpu_var_locked(ip_conntrack_ecache, cpu);
 	BUG_ON(ecache->ct == ct);
 	if (ecache->ct)
 		__ip_ct_deliver_cached_events(ecache);
Index: linux/net/ipv4/netfilter/ip_tables.c
===================================================================
--- linux.orig/net/ipv4/netfilter/ip_tables.c
+++ linux/net/ipv4/netfilter/ip_tables.c
@@ -246,7 +246,7 @@ ipt_do_table(struct sk_buff **pskb,
 
 	read_lock_bh(&table->lock);
 	IP_NF_ASSERT(table->valid_hooks & (1 << hook));
-	table_base = (void *)private->entries[smp_processor_id()];
+	table_base = (void *)private->entries[raw_smp_processor_id()];
 	e = get_entry(table_base, private->hook_entry[hook]);
 
 	/* For return from builtin chain */
