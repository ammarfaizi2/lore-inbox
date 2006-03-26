Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751527AbWCZUP4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751527AbWCZUP4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 15:15:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751538AbWCZUPz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 15:15:55 -0500
Received: from smtp2.Stanford.EDU ([171.67.16.125]:56484 "EHLO
	smtp2.Stanford.EDU") by vger.kernel.org with ESMTP id S1751527AbWCZUPz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 15:15:55 -0500
Subject: Re: 2.6.15-rt21, BUG at net/ipv4/netfilter/ip_conntrack_core.c:124
From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
To: Ingo Molnar <mingo@elte.hu>
Cc: nando@ccrma.Stanford.EDU, linux-kernel@vger.kernel.org
In-Reply-To: <20060326163450.GA22411@elte.hu>
References: <1143339628.5527.3.camel@cmn2.stanford.edu>
	 <20060326163056.GC15667@elte.hu>  <20060326163450.GA22411@elte.hu>
Content-Type: text/plain
Date: Sun, 26 Mar 2006 12:15:46 -0800
Message-Id: <1143404146.7768.18.camel@cmn3.stanford.edu>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-03-26 at 18:34 +0200, Ingo Molnar wrote:
> * Ingo Molnar <mingo@elte.hu> wrote:
> 
> > > Mar 23 15:22:48 host kernel: BUG at
> > > net/ipv4/netfilter/ip_conntrack_core.c:124!
> > 
> > does the patch below help?
> 
> updated patch below.

Thanks! I'll test later today. It may take a while to be reasonably sure
whether it makes a difference. The hangs have not been frequent. 

If I try a 2.6.16 based kernel, should I also use this patch?
-- Fernando


> Index: linux/include/linux/netfilter_ipv4/ip_conntrack.h
> ===================================================================
> --- linux.orig/include/linux/netfilter_ipv4/ip_conntrack.h
> +++ linux/include/linux/netfilter_ipv4/ip_conntrack.h
> @@ -336,7 +336,8 @@ ip_conntrack_expect_unregister_notifier(
>  }
>  
>  extern void ip_ct_deliver_cached_events(const struct ip_conntrack *ct);
> -extern void __ip_ct_event_cache_init(struct ip_conntrack *ct);
> +extern void __ip_ct_event_cache_init(struct ip_conntrack_ecache *ecache,
> +				     struct ip_conntrack *ct);
>  
>  static inline void 
>  ip_conntrack_event_cache(enum ip_conntrack_events event,
> @@ -349,7 +350,7 @@ ip_conntrack_event_cache(enum ip_conntra
>  	local_bh_disable();
>  	ecache = &get_cpu_var_locked(ip_conntrack_ecache, &cpu);
>  	if (ct != ecache->ct)
> -		__ip_ct_event_cache_init(ct);
> +		__ip_ct_event_cache_init(ecache, ct);
>  	ecache->events |= event;
>  	put_cpu_var_locked(ip_conntrack_ecache, cpu);
>  	local_bh_enable();
> Index: linux/net/ipv4/netfilter/arp_tables.c
> ===================================================================
> --- linux.orig/net/ipv4/netfilter/arp_tables.c
> +++ linux/net/ipv4/netfilter/arp_tables.c
> @@ -248,7 +248,7 @@ unsigned int arpt_do_table(struct sk_buf
>  	outdev = out ? out->name : nulldevname;
>  
>  	read_lock_bh(&table->lock);
> -	table_base = (void *)private->entries[smp_processor_id()];
> +	table_base = (void *)private->entries[raw_smp_processor_id()];
>  	e = get_entry(table_base, private->hook_entry[hook]);
>  	back = get_entry(table_base, private->underflow[hook]);
>  
> @@ -948,7 +948,7 @@ static int do_add_counters(void __user *
>  
>  	i = 0;
>  	/* Choose the copy that is on our node */
> -	loc_cpu_entry = private->entries[smp_processor_id()];
> +	loc_cpu_entry = private->entries[raw_smp_processor_id()];
>  	ARPT_ENTRY_ITERATE(loc_cpu_entry,
>  			   private->size,
>  			   add_counter_to_entry,
> Index: linux/net/ipv4/netfilter/ip_conntrack_core.c
> ===================================================================
> --- linux.orig/net/ipv4/netfilter/ip_conntrack_core.c
> +++ linux/net/ipv4/netfilter/ip_conntrack_core.c
> @@ -114,13 +114,10 @@ void ip_ct_deliver_cached_events(const s
>  	local_bh_enable();
>  }
>  
> -void __ip_ct_event_cache_init(struct ip_conntrack *ct)
> +void __ip_ct_event_cache_init(struct ip_conntrack_ecache *ecache,
> +			      struct ip_conntrack *ct)
>  {
> -	struct ip_conntrack_ecache *ecache;
> -	int cpu = raw_smp_processor_id();
> -
>  	/* take care of delivering potentially old events */
> -	ecache = &__get_cpu_var_locked(ip_conntrack_ecache, cpu);
>  	BUG_ON(ecache->ct == ct);
>  	if (ecache->ct)
>  		__ip_ct_deliver_cached_events(ecache);
> Index: linux/net/ipv4/netfilter/ip_tables.c
> ===================================================================
> --- linux.orig/net/ipv4/netfilter/ip_tables.c
> +++ linux/net/ipv4/netfilter/ip_tables.c
> @@ -246,7 +246,7 @@ ipt_do_table(struct sk_buff **pskb,
>  
>  	read_lock_bh(&table->lock);
>  	IP_NF_ASSERT(table->valid_hooks & (1 << hook));
> -	table_base = (void *)private->entries[smp_processor_id()];
> +	table_base = (void *)private->entries[raw_smp_processor_id()];
>  	e = get_entry(table_base, private->hook_entry[hook]);
>  
>  	/* For return from builtin chain */


