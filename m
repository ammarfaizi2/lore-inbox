Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262581AbTDAOpx>; Tue, 1 Apr 2003 09:45:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262582AbTDAOpx>; Tue, 1 Apr 2003 09:45:53 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:13828 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S262581AbTDAOpw>; Tue, 1 Apr 2003 09:45:52 -0500
Date: Tue, 1 Apr 2003 18:57:07 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: davem@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [patch 2.5] net: severe bug in icmp stats
Message-ID: <20030401185707.A955@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I believe many of those weird crash reports with recent 2.5
kernels can be explained by wrong pointer arithmetic in
ICMP_INC_STATS_xx_FIELD macros.

(*((long *)((void *)ptr) + offt))++

This actually adds "offt" _longs_, not _bytes_ to "ptr",
which causes increment of entirely unrelated kernel data.
Nasty thing is that a result of this corruption usually
shows up much later and depends on kernel layout.
I was "lucky" enough - on one of my boxes ICMP redirect
packets reproducibly caused increment of thread_info->task
pointer of kswapd, so finally I traced this back to icmp.h.

Ivan.

--- 2.5/include/net/icmp.h	Tue Mar 25 01:01:22 2003
+++ linux/include/net/icmp.h	Tue Apr  1 13:34:06 2003
@@ -39,15 +39,15 @@ DECLARE_SNMP_STAT(struct icmp_mib, icmp_
 #define ICMP_INC_STATS_FIELD(offt)					\
 	(*((unsigned long *) ((void *)					\
 			     per_cpu_ptr(icmp_statistics[!in_softirq()],\
-					 smp_processor_id())) + offt))++;
+					 smp_processor_id()) + offt)))++
 #define ICMP_INC_STATS_BH_FIELD(offt)					\
 	(*((unsigned long *) ((void *)					\
 			     per_cpu_ptr(icmp_statistics[0],		\
-					 smp_processor_id())) + offt))++;
+					 smp_processor_id()) + offt)))++
 #define ICMP_INC_STATS_USER_FIELD(offt)					\
 	(*((unsigned long *) ((void *)					\
 			     per_cpu_ptr(icmp_statistics[1],		\
-					 smp_processor_id())) + offt))++;
+					 smp_processor_id()) + offt)))++
 
 extern void	icmp_send(struct sk_buff *skb_in,  int type, int code, u32 info);
 extern int	icmp_rcv(struct sk_buff *skb);
