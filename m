Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263077AbSJDSCK>; Fri, 4 Oct 2002 14:02:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263078AbSJDSCK>; Fri, 4 Oct 2002 14:02:10 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:3457 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S263077AbSJDSCG>;
	Fri, 4 Oct 2002 14:02:06 -0400
Message-ID: <3D9DD8DC.9040402@colorfullife.com>
Date: Fri, 04 Oct 2002 20:07:24 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/4.0 (compatible; MSIE 5.5; Windows NT 4.0)
X-Accept-Language: en, de
MIME-Version: 1.0
To: akpm@digeo.com, linux-kernel@vger.kernel.org
CC: mbligh@aracnet.com
Subject: [PATCH] patch-slab-split-04-drain
Content-Type: multipart/mixed;
 boundary="------------030200040006050006070707"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030200040006050006070707
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

part 4:

- spin_lock(); within the smp_call_function callback is now permitted, 
remove/cleanup the workaround.


Untested due to lack of SMP test systems, but trivial.

--
	Manfred

--------------030200040006050006070707
Content-Type: text/plain;
 name="patch-slab-split-04-drain"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-slab-split-04-drain"

--- 2.5/mm/slab.c	Fri Oct  4 19:05:15 2002
+++ build-2.5/mm/slab.c	Fri Oct  4 19:36:13 2002
@@ -917,29 +917,19 @@
 
 static void free_block (kmem_cache_t* cachep, void** objpp, int len);
 
-static void drain_cpu_caches(kmem_cache_t *cachep)
+static void do_drain(void *arg)
 {
-	ccupdate_struct_t new;
-	int i;
-
-	memset(&new.new,0,sizeof(new.new));
-
-	new.cachep = cachep;
+	kmem_cache_t *cachep = (kmem_cache_t*)arg;
+	cpucache_t *cc;
 
-	down(&cache_chain_sem);
-	smp_call_function_all_cpus(do_ccupdate_local, (void *)&new);
+	cc = cc_data(cachep);
+	free_block(cachep, &cc_entry(cc)[0], cc->avail);
+	cc->avail = 0;
+}
 
-	for (i = 0; i < NR_CPUS; i++) {
-		cpucache_t* ccold = new.new[i];
-		if (!ccold || (ccold->avail == 0))
-			continue;
-		local_irq_disable();
-		free_block(cachep, cc_entry(ccold), ccold->avail);
-		local_irq_enable();
-		ccold->avail = 0;
-	}
-	smp_call_function_all_cpus(do_ccupdate_local, (void *)&new);
-	up(&cache_chain_sem);
+static void drain_cpu_caches(kmem_cache_t *cachep)
+{
+	smp_call_function_all_cpus(do_drain, cachep);
 }
 
 static int __cache_shrink(kmem_cache_t *cachep)

--------------030200040006050006070707--

