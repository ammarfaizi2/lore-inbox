Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932239AbWCPDZt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932239AbWCPDZt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 22:25:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751983AbWCPDZt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 22:25:49 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:4289 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751256AbWCPDZr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 22:25:47 -0500
Date: Thu, 16 Mar 2006 12:24:01 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] for_each_possible_cpu [3/19] network codes.
Message-Id: <20060316122401.11760395.kamezawa.hiroyu@jp.fujitsu.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch replaces for_each_cpu with for_each_possible_cpu

under /net
 bridge/netfilter/ebtables.c        |   12 ++++++------
 core/dev.c                         |    2 +-
 core/flow.c                        |    4 ++--
 core/neighbour.c                   |    2 +-
 core/sock.c                        |    2 +-
 core/utils.c                       |    4 ++--
 ipv4/icmp.c                        |    2 +-
 ipv4/ipcomp.c                      |    8 ++++----
 ipv4/netfilter/arp_tables.c        |    4 ++--
 ipv4/netfilter/ip_conntrack_core.c |    2 +-
 ipv4/netfilter/ip_tables.c         |    4 ++--
 ipv4/proc.c                        |    4 ++--
 ipv4/route.c                       |    2 +-
 ipv6/icmp.c                        |    4 ++--
 ipv6/ipcomp6.c                     |    8 ++++----
 ipv6/netfilter/ip6_tables.c        |    4 ++--
 ipv6/proc.c                        |    4 ++--
 netfilter/nf_conntrack_core.c      |    2 +-
 netfilter/x_tables.c               |    4 ++--
 sctp/proc.c                        |    2 +-
 socket.c                           |    2 +-
 21 files changed, 41 insertions(+), 41 deletions(-)


Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

Index: linux-2.6.16-rc6-mm1/net/bridge/netfilter/ebtables.c
===================================================================
--- linux-2.6.16-rc6-mm1.orig/net/bridge/netfilter/ebtables.c
+++ linux-2.6.16-rc6-mm1/net/bridge/netfilter/ebtables.c
@@ -829,7 +829,7 @@ static int translate_table(struct ebt_re
 				   		* sizeof(struct ebt_chainstack));
 		if (!newinfo->chainstack)
 			return -ENOMEM;
-		for_each_cpu(i) {
+		for_each_possible_cpu(i) {
 			newinfo->chainstack[i] =
 			   vmalloc(udc_cnt * sizeof(struct ebt_chainstack));
 			if (!newinfo->chainstack[i]) {
@@ -901,7 +901,7 @@ static void get_counters(struct ebt_coun
 	       sizeof(struct ebt_counter) * nentries);
 
 	/* add other counters to those of cpu 0 */
-	for_each_cpu(cpu) {
+	for_each_possible_cpu(cpu) {
 		if (cpu == 0)
 			continue;
 		counter_base = COUNTER_BASE(oldcounters, nentries, cpu);
@@ -1036,7 +1036,7 @@ static int do_replace(void __user *user,
 
 	vfree(table->entries);
 	if (table->chainstack) {
-		for_each_cpu(i)
+		for_each_possible_cpu(i)
 			vfree(table->chainstack[i]);
 		vfree(table->chainstack);
 	}
@@ -1054,7 +1054,7 @@ free_counterstmp:
 	vfree(counterstmp);
 	/* can be initialized in translate_table() */
 	if (newinfo->chainstack) {
-		for_each_cpu(i)
+		for_each_possible_cpu(i)
 			vfree(newinfo->chainstack[i]);
 		vfree(newinfo->chainstack);
 	}
@@ -1201,7 +1201,7 @@ free_unlock:
 	mutex_unlock(&ebt_mutex);
 free_chainstack:
 	if (newinfo->chainstack) {
-		for_each_cpu(i)
+		for_each_possible_cpu(i)
 			vfree(newinfo->chainstack[i]);
 		vfree(newinfo->chainstack);
 	}
@@ -1224,7 +1224,7 @@ void ebt_unregister_table(struct ebt_tab
 	mutex_unlock(&ebt_mutex);
 	vfree(table->private->entries);
 	if (table->private->chainstack) {
-		for_each_cpu(i)
+		for_each_possible_cpu(i)
 			vfree(table->private->chainstack[i]);
 		vfree(table->private->chainstack);
 	}
Index: linux-2.6.16-rc6-mm1/net/core/utils.c
===================================================================
--- linux-2.6.16-rc6-mm1.orig/net/core/utils.c
+++ linux-2.6.16-rc6-mm1/net/core/utils.c
@@ -121,7 +121,7 @@ void __init net_random_init(void)
 {
 	int i;
 
-	for_each_cpu(i) {
+	for_each_possible_cpu(i) {
 		struct nrnd_state *state = &per_cpu(net_rand_state,i);
 		__net_srandom(state, i+jiffies);
 	}
@@ -133,7 +133,7 @@ static int net_random_reseed(void)
 	unsigned long seed[NR_CPUS];
 
 	get_random_bytes(seed, sizeof(seed));
-	for_each_cpu(i) {
+	for_each_possible_cpu(i) {
 		struct nrnd_state *state = &per_cpu(net_rand_state,i);
 		__net_srandom(state, seed[i]);
 	}
Index: linux-2.6.16-rc6-mm1/net/core/dev.c
===================================================================
--- linux-2.6.16-rc6-mm1.orig/net/core/dev.c
+++ linux-2.6.16-rc6-mm1/net/core/dev.c
@@ -3278,7 +3278,7 @@ static int __init net_dev_init(void)
 	 *	Initialise the packet receive queues.
 	 */
 
-	for_each_cpu(i) {
+	for_each_possible_cpu(i) {
 		struct softnet_data *queue;
 
 		queue = &per_cpu(softnet_data, i);
Index: linux-2.6.16-rc6-mm1/net/core/flow.c
===================================================================
--- linux-2.6.16-rc6-mm1.orig/net/core/flow.c
+++ linux-2.6.16-rc6-mm1/net/core/flow.c
@@ -79,7 +79,7 @@ static void flow_cache_new_hashrnd(unsig
 {
 	int i;
 
-	for_each_cpu(i)
+	for_each_possible_cpu(i)
 		flow_hash_rnd_recalc(i) = 1;
 
 	flow_hash_rnd_timer.expires = jiffies + FLOW_HASH_RND_PERIOD;
@@ -363,7 +363,7 @@ static int __init flow_cache_init(void)
 	flow_hash_rnd_timer.expires = jiffies + FLOW_HASH_RND_PERIOD;
 	add_timer(&flow_hash_rnd_timer);
 
-	for_each_cpu(i)
+	for_each_possible_cpu(i)
 		flow_cache_cpu_prepare(i);
 
 	hotcpu_notifier(flow_cache_cpu, 0);
Index: linux-2.6.16-rc6-mm1/net/core/neighbour.c
===================================================================
--- linux-2.6.16-rc6-mm1.orig/net/core/neighbour.c
+++ linux-2.6.16-rc6-mm1/net/core/neighbour.c
@@ -1633,7 +1633,7 @@ static int neightbl_fill_info(struct nei
 
 		memset(&ndst, 0, sizeof(ndst));
 
-		for_each_cpu(cpu) {
+		for_each_possible_cpu(cpu) {
 			struct neigh_statistics	*st;
 
 			st = per_cpu_ptr(tbl->stats, cpu);
Index: linux-2.6.16-rc6-mm1/net/core/sock.c
===================================================================
--- linux-2.6.16-rc6-mm1.orig/net/core/sock.c
+++ linux-2.6.16-rc6-mm1/net/core/sock.c
@@ -1494,7 +1494,7 @@ int read_sockets_allocated(struct proto 
 {
 	int total = 0;
 	int cpu;
-	for_each_cpu(cpu)
+	for_each_possible_cpu(cpu)
 		total += *per_cpu_ptr(prot->sockets_allocated, cpu);
 	return total;
 }
Index: linux-2.6.16-rc6-mm1/net/ipv4/ipcomp.c
===================================================================
--- linux-2.6.16-rc6-mm1.orig/net/ipv4/ipcomp.c
+++ linux-2.6.16-rc6-mm1/net/ipv4/ipcomp.c
@@ -291,7 +291,7 @@ static void ipcomp_free_scratches(void)
 	if (!scratches)
 		return;
 
-	for_each_cpu(i) {
+	for_each_possible_cpu(i) {
 		void *scratch = *per_cpu_ptr(scratches, i);
 		if (scratch)
 			vfree(scratch);
@@ -314,7 +314,7 @@ static void **ipcomp_alloc_scratches(voi
 
 	ipcomp_scratches = scratches;
 
-	for_each_cpu(i) {
+	for_each_possible_cpu(i) {
 		void *scratch = vmalloc(IPCOMP_SCRATCH_SIZE);
 		if (!scratch)
 			return NULL;
@@ -345,7 +345,7 @@ static void ipcomp_free_tfms(struct cryp
 	if (!tfms)
 		return;
 
-	for_each_cpu(cpu) {
+	for_each_possible_cpu(cpu) {
 		struct crypto_tfm *tfm = *per_cpu_ptr(tfms, cpu);
 		crypto_free_tfm(tfm);
 	}
@@ -385,7 +385,7 @@ static struct crypto_tfm **ipcomp_alloc_
 	if (!tfms)
 		goto error;
 
-	for_each_cpu(cpu) {
+	for_each_possible_cpu(cpu) {
 		struct crypto_tfm *tfm = crypto_alloc_tfm(alg_name, 0);
 		if (!tfm)
 			goto error;
Index: linux-2.6.16-rc6-mm1/net/ipv4/icmp.c
===================================================================
--- linux-2.6.16-rc6-mm1.orig/net/ipv4/icmp.c
+++ linux-2.6.16-rc6-mm1/net/ipv4/icmp.c
@@ -1107,7 +1107,7 @@ void __init icmp_init(struct net_proto_f
 	struct inet_sock *inet;
 	int i;
 
-	for_each_cpu(i) {
+	for_each_possible_cpu(i) {
 		int err;
 
 		err = sock_create_kern(PF_INET, SOCK_RAW, IPPROTO_ICMP,
Index: linux-2.6.16-rc6-mm1/net/ipv4/route.c
===================================================================
--- linux-2.6.16-rc6-mm1.orig/net/ipv4/route.c
+++ linux-2.6.16-rc6-mm1/net/ipv4/route.c
@@ -3092,7 +3092,7 @@ static int ip_rt_acct_read(char *buffer,
 		memcpy(dst, src, length);
 
 		/* Add the other cpus in, one int at a time */
-		for_each_cpu(i) {
+		for_each_possible_cpu(i) {
 			unsigned int j;
 
 			src = ((u32 *) IP_RT_ACCT_CPU(i)) + offset;
Index: linux-2.6.16-rc6-mm1/net/ipv4/netfilter/ip_tables.c
===================================================================
--- linux-2.6.16-rc6-mm1.orig/net/ipv4/netfilter/ip_tables.c
+++ linux-2.6.16-rc6-mm1/net/ipv4/netfilter/ip_tables.c
@@ -734,7 +734,7 @@ translate_table(const char *name,
 	}
 
 	/* And one copy for every other CPU */
-	for_each_cpu(i) {
+	for_each_possible_cpu(i) {
 		if (newinfo->entries[i] && newinfo->entries[i] != entry0)
 			memcpy(newinfo->entries[i], entry0, newinfo->size);
 	}
@@ -787,7 +787,7 @@ get_counters(const struct xt_table_info 
 			  counters,
 			  &i);
 
-	for_each_cpu(cpu) {
+	for_each_possible_cpu(cpu) {
 		if (cpu == curcpu)
 			continue;
 		i = 0;
Index: linux-2.6.16-rc6-mm1/net/ipv4/netfilter/arp_tables.c
===================================================================
--- linux-2.6.16-rc6-mm1.orig/net/ipv4/netfilter/arp_tables.c
+++ linux-2.6.16-rc6-mm1/net/ipv4/netfilter/arp_tables.c
@@ -646,7 +646,7 @@ static int translate_table(const char *n
 	}
 
 	/* And one copy for every other CPU */
-	for_each_cpu(i) {
+	for_each_possible_cpu(i) {
 		if (newinfo->entries[i] && newinfo->entries[i] != entry0)
 			memcpy(newinfo->entries[i], entry0, newinfo->size);
 	}
@@ -696,7 +696,7 @@ static void get_counters(const struct xt
 			   counters,
 			   &i);
 
-	for_each_cpu(cpu) {
+	for_each_possible_cpu(cpu) {
 		if (cpu == curcpu)
 			continue;
 		i = 0;
Index: linux-2.6.16-rc6-mm1/net/ipv4/proc.c
===================================================================
--- linux-2.6.16-rc6-mm1.orig/net/ipv4/proc.c
+++ linux-2.6.16-rc6-mm1/net/ipv4/proc.c
@@ -49,7 +49,7 @@ static int fold_prot_inuse(struct proto 
 	int res = 0;
 	int cpu;
 
-	for_each_cpu(cpu)
+	for_each_possible_cpu(cpu)
 		res += (*per_cpu_ptr(proto->inuse, cpu));
 
 	return res;
@@ -91,7 +91,7 @@ fold_field(void *mib[], int offt)
 	unsigned long res = 0;
 	int i;
 
-	for_each_cpu(i) {
+	for_each_possible_cpu(i) {
 		res += *(((unsigned long *) per_cpu_ptr(mib[0], i)) + offt);
 		res += *(((unsigned long *) per_cpu_ptr(mib[1], i)) + offt);
 	}
Index: linux-2.6.16-rc6-mm1/net/ipv4/netfilter/ip_conntrack_core.c
===================================================================
--- linux-2.6.16-rc6-mm1.orig/net/ipv4/netfilter/ip_conntrack_core.c
+++ linux-2.6.16-rc6-mm1/net/ipv4/netfilter/ip_conntrack_core.c
@@ -133,7 +133,7 @@ static void ip_ct_event_cache_flush(void
 	struct ip_conntrack_ecache *ecache;
 	int cpu;
 
-	for_each_cpu(cpu) {
+	for_each_possible_cpu(cpu) {
 		ecache = &per_cpu(ip_conntrack_ecache, cpu);
 		if (ecache->ct)
 			ip_conntrack_put(ecache->ct);
Index: linux-2.6.16-rc6-mm1/net/ipv6/icmp.c
===================================================================
--- linux-2.6.16-rc6-mm1.orig/net/ipv6/icmp.c
+++ linux-2.6.16-rc6-mm1/net/ipv6/icmp.c
@@ -717,7 +717,7 @@ int __init icmpv6_init(struct net_proto_
 	struct sock *sk;
 	int err, i, j;
 
-	for_each_cpu(i) {
+	for_each_possible_cpu(i) {
 		err = sock_create_kern(PF_INET6, SOCK_RAW, IPPROTO_ICMPV6,
 				       &per_cpu(__icmpv6_socket, i));
 		if (err < 0) {
@@ -763,7 +763,7 @@ void icmpv6_cleanup(void)
 {
 	int i;
 
-	for_each_cpu(i) {
+	for_each_possible_cpu(i) {
 		sock_release(per_cpu(__icmpv6_socket, i));
 	}
 	inet6_del_protocol(&icmpv6_protocol, IPPROTO_ICMPV6);
Index: linux-2.6.16-rc6-mm1/net/ipv6/ipcomp6.c
===================================================================
--- linux-2.6.16-rc6-mm1.orig/net/ipv6/ipcomp6.c
+++ linux-2.6.16-rc6-mm1/net/ipv6/ipcomp6.c
@@ -285,7 +285,7 @@ static void ipcomp6_free_scratches(void)
 	if (!scratches)
 		return;
 
-	for_each_cpu(i) {
+	for_each_possible_cpu(i) {
 		void *scratch = *per_cpu_ptr(scratches, i);
 
 		vfree(scratch);
@@ -308,7 +308,7 @@ static void **ipcomp6_alloc_scratches(vo
 
 	ipcomp6_scratches = scratches;
 
-	for_each_cpu(i) {
+	for_each_possible_cpu(i) {
 		void *scratch = vmalloc(IPCOMP_SCRATCH_SIZE);
 		if (!scratch)
 			return NULL;
@@ -339,7 +339,7 @@ static void ipcomp6_free_tfms(struct cry
 	if (!tfms)
 		return;
 
-	for_each_cpu(cpu) {
+	for_each_possible_cpu(cpu) {
 		struct crypto_tfm *tfm = *per_cpu_ptr(tfms, cpu);
 		crypto_free_tfm(tfm);
 	}
@@ -379,7 +379,7 @@ static struct crypto_tfm **ipcomp6_alloc
 	if (!tfms)
 		goto error;
 
-	for_each_cpu(cpu) {
+	for_each_possible_cpu(cpu) {
 		struct crypto_tfm *tfm = crypto_alloc_tfm(alg_name, 0);
 		if (!tfm)
 			goto error;
Index: linux-2.6.16-rc6-mm1/net/ipv6/netfilter/ip6_tables.c
===================================================================
--- linux-2.6.16-rc6-mm1.orig/net/ipv6/netfilter/ip6_tables.c
+++ linux-2.6.16-rc6-mm1/net/ipv6/netfilter/ip6_tables.c
@@ -788,7 +788,7 @@ translate_table(const char *name,
 	}
 
 	/* And one copy for every other CPU */
-	for_each_cpu(i) {
+	for_each_possible_cpu(i) {
 		if (newinfo->entries[i] && newinfo->entries[i] != entry0)
 			memcpy(newinfo->entries[i], entry0, newinfo->size);
 	}
@@ -841,7 +841,7 @@ get_counters(const struct xt_table_info 
 			   counters,
 			   &i);
 
-	for_each_cpu(cpu) {
+	for_each_possible_cpu(cpu) {
 		if (cpu == curcpu)
 			continue;
 		i = 0;
Index: linux-2.6.16-rc6-mm1/net/ipv6/proc.c
===================================================================
--- linux-2.6.16-rc6-mm1.orig/net/ipv6/proc.c
+++ linux-2.6.16-rc6-mm1/net/ipv6/proc.c
@@ -38,7 +38,7 @@ static int fold_prot_inuse(struct proto 
 	int res = 0;
 	int cpu;
 
-	for_each_cpu(cpu)
+	for_each_possible_cpu(cpu)
 		res += (*per_cpu_ptr(proto->inuse, cpu));
 
 	return res;
@@ -140,7 +140,7 @@ fold_field(void *mib[], int offt)
         unsigned long res = 0;
         int i;
  
-        for_each_cpu(i) {
+        for_each_possible_cpu(i) {
                 res += *(((unsigned long *)per_cpu_ptr(mib[0], i)) + offt);
                 res += *(((unsigned long *)per_cpu_ptr(mib[1], i)) + offt);
         }
Index: linux-2.6.16-rc6-mm1/net/netfilter/nf_conntrack_core.c
===================================================================
--- linux-2.6.16-rc6-mm1.orig/net/netfilter/nf_conntrack_core.c
+++ linux-2.6.16-rc6-mm1/net/netfilter/nf_conntrack_core.c
@@ -144,7 +144,7 @@ static void nf_ct_event_cache_flush(void
 	struct nf_conntrack_ecache *ecache;
 	int cpu;
 
-	for_each_cpu(cpu) {
+	for_each_possible_cpu(cpu) {
 		ecache = &per_cpu(nf_conntrack_ecache, cpu);
 		if (ecache->ct)
 			nf_ct_put(ecache->ct);
Index: linux-2.6.16-rc6-mm1/net/netfilter/x_tables.c
===================================================================
--- linux-2.6.16-rc6-mm1.orig/net/netfilter/x_tables.c
+++ linux-2.6.16-rc6-mm1/net/netfilter/x_tables.c
@@ -312,7 +312,7 @@ struct xt_table_info *xt_alloc_table_inf
 
 	newinfo->size = size;
 
-	for_each_cpu(cpu) {
+	for_each_possible_cpu(cpu) {
 		if (size <= PAGE_SIZE)
 			newinfo->entries[cpu] = kmalloc_node(size,
 							GFP_KERNEL,
@@ -335,7 +335,7 @@ void xt_free_table_info(struct xt_table_
 {
 	int cpu;
 
-	for_each_cpu(cpu) {
+	for_each_possible_cpu(cpu) {
 		if (info->size <= PAGE_SIZE)
 			kfree(info->entries[cpu]);
 		else
Index: linux-2.6.16-rc6-mm1/net/sctp/proc.c
===================================================================
--- linux-2.6.16-rc6-mm1.orig/net/sctp/proc.c
+++ linux-2.6.16-rc6-mm1/net/sctp/proc.c
@@ -69,7 +69,7 @@ fold_field(void *mib[], int nr)
 	unsigned long res = 0;
 	int i;
 
-	for_each_cpu(i) {
+	for_each_possible_cpu(i) {
 		res +=
 		    *((unsigned long *) (((void *) per_cpu_ptr(mib[0], i)) +
 					 sizeof (unsigned long) * nr));
Index: linux-2.6.16-rc6-mm1/net/socket.c
===================================================================
--- linux-2.6.16-rc6-mm1.orig/net/socket.c
+++ linux-2.6.16-rc6-mm1/net/socket.c
@@ -2134,7 +2134,7 @@ void socket_seq_show(struct seq_file *se
 	int cpu;
 	int counter = 0;
 
-	for_each_cpu(cpu)
+	for_each_possible_cpu(cpu)
 		counter += per_cpu(sockets_in_use, cpu);
 
 	/* It can be negative, by the way. 8) */
