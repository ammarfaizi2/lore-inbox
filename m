Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751607AbVJMTBg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751607AbVJMTBg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 15:01:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751610AbVJMTBg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 15:01:36 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:58025 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751607AbVJMTBf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 15:01:35 -0400
Date: Thu, 13 Oct 2005 12:01:33 -0700 (PDT)
From: hawkes@sgi.com
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: hawkes@sgi.com
Message-Id: <20051013190133.13192.46039.sendpatchset@tomahawk.engr.sgi.com>
Subject: [PATCH] 2.6.14-rc4: wider use of for_each_*cpu() in net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In 'net' change the explicit use of for-loops and NR_CPUS into the
general for_each_cpu() or for_each_online_cpu() constructs, as
appropriate.  This widens the scope of potential future optimizations
of the general constructs, as well as takes advantage of the existing
optimizations of first_cpu() and next_cpu(), which is advantageous
when the true CPU count is much smaller than NR_CPUS.

Signed-off-by: John Hawkes <hawkes@sgi.com>


Index: linux/net/core/neighbour.c
===================================================================
--- linux.orig/net/core/neighbour.c	2005-10-13 09:29:54.000000000 -0700
+++ linux/net/core/neighbour.c	2005-10-13 09:30:31.000000000 -0700
@@ -1641,12 +1641,9 @@
 
 		memset(&ndst, 0, sizeof(ndst));
 
-		for (cpu = 0; cpu < NR_CPUS; cpu++) {
+		for_each_cpu(cpu) {
 			struct neigh_statistics	*st;
 
-			if (!cpu_possible(cpu))
-				continue;
-
 			st = per_cpu_ptr(tbl->stats, cpu);
 			ndst.ndts_allocs		+= st->allocs;
 			ndst.ndts_destroys		+= st->destroys;
Index: linux/net/core/pktgen.c
===================================================================
--- linux.orig/net/core/pktgen.c	2005-10-13 09:29:54.000000000 -0700
+++ linux/net/core/pktgen.c	2005-10-13 09:30:31.000000000 -0700
@@ -3065,12 +3065,9 @@
 	/* Register us to receive netdevice events */
 	register_netdevice_notifier(&pktgen_notifier_block);
         
-	for (cpu = 0; cpu < NR_CPUS ; cpu++) {
+	for_each_online_cpu(cpu) {
 		char buf[30];
 
-		if (!cpu_online(cpu))
-			continue;
-
                 sprintf(buf, "kpktgend_%i", cpu);
                 pktgen_create_thread(buf, cpu);
         }
Index: linux/net/ipv4/icmp.c
===================================================================
--- linux.orig/net/ipv4/icmp.c	2005-10-13 09:29:54.000000000 -0700
+++ linux/net/ipv4/icmp.c	2005-10-13 09:30:31.000000000 -0700
@@ -1108,12 +1108,9 @@
 	struct inet_sock *inet;
 	int i;
 
-	for (i = 0; i < NR_CPUS; i++) {
+	for_each_cpu(i) {
 		int err;
 
-		if (!cpu_possible(i))
-			continue;
-
 		err = sock_create_kern(PF_INET, SOCK_RAW, IPPROTO_ICMP,
 				       &per_cpu(__icmp_socket, i));
 
Index: linux/net/ipv4/proc.c
===================================================================
--- linux.orig/net/ipv4/proc.c	2005-10-13 09:29:54.000000000 -0700
+++ linux/net/ipv4/proc.c	2005-10-13 09:30:31.000000000 -0700
@@ -90,9 +90,7 @@
 	unsigned long res = 0;
 	int i;
 
-	for (i = 0; i < NR_CPUS; i++) {
-		if (!cpu_possible(i))
-			continue;
+	for_each_cpu(i) {
 		res += *(((unsigned long *) per_cpu_ptr(mib[0], i)) + offt);
 		res += *(((unsigned long *) per_cpu_ptr(mib[1], i)) + offt);
 	}
Index: linux/net/ipv6/proc.c
===================================================================
--- linux.orig/net/ipv6/proc.c	2005-10-13 09:29:54.000000000 -0700
+++ linux/net/ipv6/proc.c	2005-10-13 09:30:31.000000000 -0700
@@ -140,9 +140,7 @@
         unsigned long res = 0;
         int i;
  
-        for (i = 0; i < NR_CPUS; i++) {
-                if (!cpu_possible(i))
-                        continue;
+        for_each_cpu(i) {
                 res += *(((unsigned long *)per_cpu_ptr(mib[0], i)) + offt);
                 res += *(((unsigned long *)per_cpu_ptr(mib[1], i)) + offt);
         }
Index: linux/net/ipv6/icmp.c
===================================================================
--- linux.orig/net/ipv6/icmp.c	2005-10-13 09:29:54.000000000 -0700
+++ linux/net/ipv6/icmp.c	2005-10-13 09:30:31.000000000 -0700
@@ -700,10 +700,7 @@
 	struct sock *sk;
 	int err, i, j;
 
-	for (i = 0; i < NR_CPUS; i++) {
-		if (!cpu_possible(i))
-			continue;
-
+	for_each_cpu(i) {
 		err = sock_create_kern(PF_INET6, SOCK_RAW, IPPROTO_ICMPV6,
 				       &per_cpu(__icmpv6_socket, i));
 		if (err < 0) {
@@ -749,9 +746,7 @@
 {
 	int i;
 
-	for (i = 0; i < NR_CPUS; i++) {
-		if (!cpu_possible(i))
-			continue;
+	for_each_cpu(i) {
 		sock_release(per_cpu(__icmpv6_socket, i));
 	}
 	inet6_del_protocol(&icmpv6_protocol, IPPROTO_ICMPV6);
Index: linux/net/sctp/proc.c
===================================================================
--- linux.orig/net/sctp/proc.c	2005-10-13 09:29:54.000000000 -0700
+++ linux/net/sctp/proc.c	2005-10-13 09:30:31.000000000 -0700
@@ -69,9 +69,7 @@
 	unsigned long res = 0;
 	int i;
 
-	for (i = 0; i < NR_CPUS; i++) {
-		if (!cpu_possible(i))
-			continue;
+	for_each_cpu(i) {
 		res +=
 		    *((unsigned long *) (((void *) per_cpu_ptr(mib[0], i)) +
 					 sizeof (unsigned long) * nr));
