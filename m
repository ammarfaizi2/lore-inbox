Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964824AbVIMQAG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964824AbVIMQAG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 12:00:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964826AbVIMQAF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 12:00:05 -0400
Received: from serv01.siteground.net ([70.85.91.68]:11216 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S964824AbVIMQAC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 12:00:02 -0400
Date: Tue, 13 Sep 2005 08:59:51 -0700
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, dipankar@in.ibm.com, bharata@in.ibm.com,
       shai@scalex86.org, Rusty Russell <rusty@rustcorp.com.au>
Subject: [patch 4/11] mm: Reimplementation of dynamic per-cpu allocator -- change_alloc_percpu_users
Message-ID: <20050913155951.GF3570@localhost.localdomain>
References: <20050913155112.GB3570@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050913155112.GB3570@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - serv01.siteground.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Change all current users of alloc_percpu to the new alloc_percpu interface

Signed-off-by: Ravikiran Thirumalai <kiran@scalex86.org>
Signed-off-by: Shai Fultheim <shai@scalex86.org>

Index: alloc_percpu-2.6.13-rc6/include/linux/genhd.h
===================================================================
--- alloc_percpu-2.6.13-rc6.orig/include/linux/genhd.h	2005-08-15 15:26:40.979596750 -0400
+++ alloc_percpu-2.6.13-rc6/include/linux/genhd.h	2005-08-15 15:27:07.153232500 -0400
@@ -199,7 +199,7 @@
 #ifdef  CONFIG_SMP
 static inline int init_disk_stats(struct gendisk *disk)
 {
-	disk->dkstats = alloc_percpu(struct disk_stats);
+	disk->dkstats = alloc_percpu(struct disk_stats, GFP_KERNEL);
 	if (!disk->dkstats)
 		return 0;
 	return 1;
Index: alloc_percpu-2.6.13-rc6/include/linux/percpu_counter.h
===================================================================
--- alloc_percpu-2.6.13-rc6.orig/include/linux/percpu_counter.h	2005-08-15 15:26:40.983597000 -0400
+++ alloc_percpu-2.6.13-rc6/include/linux/percpu_counter.h	2005-08-15 15:27:07.153232500 -0400
@@ -30,7 +30,7 @@
 {
 	spin_lock_init(&fbc->lock);
 	fbc->count = 0;
-	fbc->counters = alloc_percpu(long);
+	fbc->counters = alloc_percpu(long, GFP_KERNEL);
 }
 
 static inline void percpu_counter_destroy(struct percpu_counter *fbc)
Index: alloc_percpu-2.6.13-rc6/net/core/neighbour.c
===================================================================
--- alloc_percpu-2.6.13-rc6.orig/net/core/neighbour.c	2005-08-15 15:26:40.983597000 -0400
+++ alloc_percpu-2.6.13-rc6/net/core/neighbour.c	2005-08-15 15:27:07.153232500 -0400
@@ -1350,7 +1350,7 @@
 	if (!tbl->kmem_cachep)
 		panic("cannot create neighbour cache");
 
-	tbl->stats = alloc_percpu(struct neigh_statistics);
+	tbl->stats = alloc_percpu(struct neigh_statistics, GFP_KERNEL);
 	if (!tbl->stats)
 		panic("cannot create neighbour cache statistics");
 	
Index: alloc_percpu-2.6.13-rc6/net/ipv4/af_inet.c
===================================================================
--- alloc_percpu-2.6.13-rc6.orig/net/ipv4/af_inet.c	2005-08-15 15:26:40.983597000 -0400
+++ alloc_percpu-2.6.13-rc6/net/ipv4/af_inet.c	2005-08-15 15:27:07.153232500 -0400
@@ -985,16 +985,16 @@
 
 static int __init init_ipv4_mibs(void)
 {
-	net_statistics[0] = alloc_percpu(struct linux_mib);
-	net_statistics[1] = alloc_percpu(struct linux_mib);
-	ip_statistics[0] = alloc_percpu(struct ipstats_mib);
-	ip_statistics[1] = alloc_percpu(struct ipstats_mib);
-	icmp_statistics[0] = alloc_percpu(struct icmp_mib);
-	icmp_statistics[1] = alloc_percpu(struct icmp_mib);
-	tcp_statistics[0] = alloc_percpu(struct tcp_mib);
-	tcp_statistics[1] = alloc_percpu(struct tcp_mib);
-	udp_statistics[0] = alloc_percpu(struct udp_mib);
-	udp_statistics[1] = alloc_percpu(struct udp_mib);
+	net_statistics[0] = alloc_percpu(struct linux_mib, GFP_KERNEL);
+	net_statistics[1] = alloc_percpu(struct linux_mib, GFP_KERNEL);
+	ip_statistics[0] = alloc_percpu(struct ipstats_mib, GFP_KERNEL);
+	ip_statistics[1] = alloc_percpu(struct ipstats_mib, GFP_KERNEL);
+	icmp_statistics[0] = alloc_percpu(struct icmp_mib, GFP_KERNEL);
+	icmp_statistics[1] = alloc_percpu(struct icmp_mib, GFP_KERNEL);
+	tcp_statistics[0] = alloc_percpu(struct tcp_mib, GFP_KERNEL);
+	tcp_statistics[1] = alloc_percpu(struct tcp_mib, GFP_KERNEL);
+	udp_statistics[0] = alloc_percpu(struct udp_mib, GFP_KERNEL);
+	udp_statistics[1] = alloc_percpu(struct udp_mib, GFP_KERNEL);
 	if (!
 	    (net_statistics[0] && net_statistics[1] && ip_statistics[0]
 	     && ip_statistics[1] && tcp_statistics[0] && tcp_statistics[1]
Index: alloc_percpu-2.6.13-rc6/net/ipv4/ipcomp.c
===================================================================
--- alloc_percpu-2.6.13-rc6.orig/net/ipv4/ipcomp.c	2005-08-15 15:26:40.983597000 -0400
+++ alloc_percpu-2.6.13-rc6/net/ipv4/ipcomp.c	2005-08-15 15:27:07.153232500 -0400
@@ -306,7 +306,7 @@
 	if (ipcomp_scratch_users++)
 		return ipcomp_scratches;
 
-	scratches = alloc_percpu(void *);
+	scratches = alloc_percpu(void *, GFP_KERNEL);
 	if (!scratches)
 		return NULL;
 
@@ -380,7 +380,7 @@
 	INIT_LIST_HEAD(&pos->list);
 	list_add(&pos->list, &ipcomp_tfms_list);
 
-	pos->tfms = tfms = alloc_percpu(struct crypto_tfm *);
+	pos->tfms = tfms = alloc_percpu(struct crypto_tfm *, GFP_KERNEL);
 	if (!tfms)
 		goto error;
 
Index: alloc_percpu-2.6.13-rc6/net/ipv4/route.c
===================================================================
--- alloc_percpu-2.6.13-rc6.orig/net/ipv4/route.c	2005-08-15 15:26:40.987597250 -0400
+++ alloc_percpu-2.6.13-rc6/net/ipv4/route.c	2005-08-15 15:27:07.157232750 -0400
@@ -3154,7 +3154,7 @@
 	ipv4_dst_ops.gc_thresh = (rt_hash_mask + 1);
 	ip_rt_max_size = (rt_hash_mask + 1) * 16;
 
-	rt_cache_stat = alloc_percpu(struct rt_cache_stat);
+	rt_cache_stat = alloc_percpu(struct rt_cache_stat, GFP_KERNEL);
 	if (!rt_cache_stat)
 		return -ENOMEM;
 
Index: alloc_percpu-2.6.13-rc6/net/ipv6/ipcomp6.c
===================================================================
--- alloc_percpu-2.6.13-rc6.orig/net/ipv6/ipcomp6.c	2005-08-15 15:26:40.987597250 -0400
+++ alloc_percpu-2.6.13-rc6/net/ipv6/ipcomp6.c	2005-08-15 15:27:07.157232750 -0400
@@ -302,7 +302,7 @@
 	if (ipcomp6_scratch_users++)
 		return ipcomp6_scratches;
 
-	scratches = alloc_percpu(void *);
+	scratches = alloc_percpu(void *, GFP_KERNEL);
 	if (!scratches)
 		return NULL;
 
@@ -376,7 +376,7 @@
 	INIT_LIST_HEAD(&pos->list);
 	list_add(&pos->list, &ipcomp6_tfms_list);
 
-	pos->tfms = tfms = alloc_percpu(struct crypto_tfm *);
+	pos->tfms = tfms = alloc_percpu(struct crypto_tfm *, GFP_KERNEL);
 	if (!tfms)
 		goto error;
 
Index: alloc_percpu-2.6.13-rc6/net/sctp/protocol.c
===================================================================
--- alloc_percpu-2.6.13-rc6.orig/net/sctp/protocol.c	2005-08-15 15:26:40.987597250 -0400
+++ alloc_percpu-2.6.13-rc6/net/sctp/protocol.c	2005-08-15 15:27:07.157232750 -0400
@@ -939,10 +939,10 @@
 
 static int __init init_sctp_mibs(void)
 {
-	sctp_statistics[0] = alloc_percpu(struct sctp_mib);
+	sctp_statistics[0] = alloc_percpu(struct sctp_mib, GFP_KERNEL);
 	if (!sctp_statistics[0])
 		return -ENOMEM;
-	sctp_statistics[1] = alloc_percpu(struct sctp_mib);
+	sctp_statistics[1] = alloc_percpu(struct sctp_mib, GFP_KERNEL);
 	if (!sctp_statistics[1]) {
 		free_percpu(sctp_statistics[0]);
 		return -ENOMEM;
