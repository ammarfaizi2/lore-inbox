Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161061AbWBIS3S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161061AbWBIS3S (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 13:29:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965250AbWBIS3S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 13:29:18 -0500
Received: from ns1.siteground.net ([207.218.208.2]:6065 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S965247AbWBIS3S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 13:29:18 -0500
Date: Thu, 9 Feb 2006 10:29:24 -0800
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Christoph Lameter <clameter@engr.sgi.com>,
       Manfred Spraul <manfred@colorfullife.com>, vatsa@in.ibm.com,
       penberg@cs.Helsinki.FI,
       "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>
Subject: [patch] slab: Avoid deadlock at kmem_cache_create/kmem_cache_destroy
Message-ID: <20060209182923.GA3576@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

Prevents deadlock situation between kmem_cache_create()/kmem_cache_destory(),
and kmem_cache_create() /cpu hotplug.  The locking order probably got 
moved over time.

Signed-off-by: Ravikiran Thirumalai <kiran@scalex86.org>
Signed-off-by: Shai Fultheim <shai@scalex86.org>

Index: linux-2.6/mm/slab.c
===================================================================
--- linux-2.6.orig/mm/slab.c	2006-02-08 13:13:23.000000000 -0800
+++ linux-2.6/mm/slab.c	2006-02-09 01:58:02.000000000 -0800
@@ -1718,6 +1718,13 @@ kmem_cache_create (const char *name, siz
 		BUG();
 	}
 
+	/* 
+	 * Don't let CPUs to come and go.
+	 * Note: preserve lock taking order -- lock_cpu_hotplug first,
+	 * cache_chain_mutex then.
+	 */
+	lock_cpu_hotplug();
+
 	mutex_lock(&cache_chain_mutex);
 
 	list_for_each(p, &cache_chain) {
@@ -1918,8 +1925,6 @@ kmem_cache_create (const char *name, siz
 	cachep->dtor = dtor;
 	cachep->name = name;
 
-	/* Don't let CPUs to come and go */
-	lock_cpu_hotplug();
 
 	if (g_cpucache_up == FULL) {
 		enable_cpucache(cachep);
@@ -1978,12 +1983,12 @@ kmem_cache_create (const char *name, siz
 
 	/* cache setup completed, link it into the list */
 	list_add(&cachep->next, &cache_chain);
-	unlock_cpu_hotplug();
       oops:
 	if (!cachep && (flags & SLAB_PANIC))
 		panic("kmem_cache_create(): failed to create slab `%s'\n",
 		      name);
 	mutex_unlock(&cache_chain_mutex);
+	unlock_cpu_hotplug();
 	return cachep;
 }
 EXPORT_SYMBOL(kmem_cache_create);
