Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263895AbTHZOIY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 10:08:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263908AbTHZODi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 10:03:38 -0400
Received: from [203.145.184.221] ([203.145.184.221]:4627 "EHLO naturesoft.net")
	by vger.kernel.org with ESMTP id S263734AbTHZOB6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 10:01:58 -0400
Subject: [PATCH 2.6.0-test4][IPv6] ip6_flowlabel.c: timer cleanups
From: Vinay K Nallamothu <vinay-rc@naturesoft.net>
To: netdev@oss.sgi.com
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-11) 
Date: 26 Aug 2003 19:54:41 +0530
Message-Id: <1061907882.1108.28.camel@lima.royalchallenge.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Compiles fine though untested. A similar patch should be applicable to
2.4 also.

net/ipv6/ip6_flowlabel.c:
This patch does the following modifications to timer management:
1. use static timer initializer
2. replace del_timer/add_timer with mod_timer

--- linux-2.6.0-test4/net/ipv6/ip6_flowlabel.c	2003-07-15 17:23:45.000000000 +0530
+++ linux-2.6.0-test4-nvk/net/ipv6/ip6_flowlabel.c	2003-08-26 19:49:34.000000000 +0530
@@ -49,7 +49,8 @@
 static atomic_t fl_size = ATOMIC_INIT(0);
 static struct ip6_flowlabel *fl_ht[FL_HASH_MASK+1];
 
-static struct timer_list ip6_fl_gc_timer;
+static void ip6_fl_gc(unsigned long dummy);
+static struct timer_list ip6_fl_gc_timer = TIMER_INITIALIZER(ip6_fl_gc, 0, 0);
 
 /* FL hash table lock: it protects only of GC */
 
@@ -104,10 +105,9 @@
 			fl->opt = NULL;
 			kfree(opt);
 		}
-		if (!del_timer(&ip6_fl_gc_timer) ||
-		    (long)(ip6_fl_gc_timer.expires - ttd) > 0)
-			ip6_fl_gc_timer.expires = ttd;
-		add_timer(&ip6_fl_gc_timer);
+		if (!timer_pending(&ip6_fl_gc_timer) ||
+		    time_after(ip6_fl_gc_timer.expires, ttd))
+			mod_timer(&ip6_fl_gc_timer, ttd);
 	}
 }
 
@@ -692,10 +692,6 @@
 {
 #ifdef CONFIG_PROC_FS
 	struct proc_dir_entry *p;
-#endif
-	init_timer(&ip6_fl_gc_timer);
-	ip6_fl_gc_timer.function = ip6_fl_gc;
-#ifdef CONFIG_PROC_FS
 	p = create_proc_entry("ip6_flowlabel", S_IRUGO, proc_net);
 	if (p)
 		p->proc_fops = &ip6fl_seq_fops;





