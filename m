Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932146AbWCWVdE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932146AbWCWVdE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 16:33:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932131AbWCWVdE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 16:33:04 -0500
Received: from mx1.slu.se ([130.238.96.70]:40355 "EHLO mx1.slu.se")
	by vger.kernel.org with ESMTP id S932146AbWCWVdB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 16:33:01 -0500
From: Robert Olsson <Robert.Olsson@data.slu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17443.5126.813111.61346@robur.slu.se>
Date: Thu, 23 Mar 2006 22:32:54 +0100
To: Jesper Dangaard Brouer <hawk@diku.dk>
Cc: "David S. Miller" <davem@davemloft.net>, dipankar@in.ibm.com,
       Robert Olsson <Robert.Olsson@data.slu.se>, jens.laas@data.slu.se,
       hans.liss@its.uu.se, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org, Eric Dumazet <dada1@cosmosbay.com>,
       mike.stroyan@hp.com, Suresh Bhogavilli <sbhogavilli@verisign.com>
Subject: Re: Kernel panic: Route cache, RCU, possibly FIB trie.
In-Reply-To: <Pine.LNX.4.61.0603231536180.29788@ask.diku.dk>
References: <Pine.LNX.4.61.0603211113550.15500@ask.diku.dk>
	<20060321.023705.26111240.davem@davemloft.net>
	<Pine.LNX.4.61.0603211538280.28173@ask.diku.dk>
	<20060321.132514.24407022.davem@davemloft.net>
	<Pine.LNX.4.61.0603231536180.29788@ask.diku.dk>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jesper Dangaard Brouer writes:

 > > It is almost certainly the cause of your crashes, that code
 > > is still extremely raw and that's why it is listed as "EXPERIMENTAL".
 > 
 > It seems your are right :-) (and I'll take more care of using experimental 
 > code on production again). The machine, has now been running for 34 hours 
 > without crashing.  The strange thing is that I'm running the same kernel 
 > on 30 other (similar) machines, which have not crashed.  (I do suspect the 
 > specific traffic load pattern to influence this)

  Sounds good... seems like Dave did the the correct analysis.

 > BUT, I do think I have noticed another problem in the garbage collection 
 > code (route.c), that causes the garbage collector (almost) never to 
 > garbage collect.

  We're trying to avoid most/all periodic GC in hi-flow systems and just to 
  do GC as new entries are created. We use the patch below to create et another 
  (unfortunately) /proc entry to better control this. ip_rt_gc_max_chain_length 
  it also decreases the threshhold for this from 8 to 4 for this.

 Cheers.
						--ro

 
--- linux-2.6.14.5/net/ipv4/route.c.orig	2006-01-02 14:24:00.000000000 +0100
+++ linux-2.6.14.5/net/ipv4/route.c	2006-01-02 15:26:29.000000000 +0100
@@ -126,6 +126,7 @@
 static int ip_rt_error_cost		= HZ;
 static int ip_rt_error_burst		= 5 * HZ;
 static int ip_rt_gc_elasticity		= 8;
+static int ip_rt_gc_max_chain_length	= 4;
 static int ip_rt_mtu_expires		= 10 * 60 * HZ;
 static int ip_rt_min_pmtu		= 512 + 20 + 20;
 static int ip_rt_min_advmss		= 256;
@@ -977,7 +978,7 @@
 		 * The second limit is less certain. At the moment it allows
 		 * only 2 entries per bucket. We will see.
 		 */
-		if (chain_length > ip_rt_gc_elasticity) {
+		if (chain_length > ip_rt_gc_max_chain_length) {
 			*candp = cand->u.rt_next;
 			rt_free(cand);
 		}
@@ -3017,6 +3018,14 @@
 		.proc_handler	= &proc_dointvec,
 	},
 	{
+		.ctl_name	= NET_IPV4_ROUTE_GC_MAX_CHAIN_LENGTH,
+		.procname	= "gc_max_chain_length",
+		.data		= &ip_rt_gc_max_chain_length,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec,
+	},
+	{
 		.ctl_name	= NET_IPV4_ROUTE_MTU_EXPIRES,
 		.procname	= "mtu_expires",
 		.data		= &ip_rt_mtu_expires,
--- linux-2.6.14.5/include/linux/sysctl.h.orig	2006-01-02 14:46:55.000000000 +0100
+++ linux-2.6.14.5/include/linux/sysctl.h	2006-01-02 14:47:01.000000000 +0100
@@ -375,6 +375,7 @@
 	NET_IPV4_ROUTE_MIN_ADVMSS=17,
 	NET_IPV4_ROUTE_SECRET_INTERVAL=18,
 	NET_IPV4_ROUTE_GC_MIN_INTERVAL_MS=19,
+	NET_IPV4_ROUTE_GC_MAX_CHAIN_LENGTH=20,
 };
 
 enum


