Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751141AbVKDXix@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751141AbVKDXix (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 18:38:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751142AbVKDXiQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 18:38:16 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:40375 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1751141AbVKDXhs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 18:37:48 -0500
Date: Fri, 4 Nov 2005 15:37:17 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: akpm@osdl.org
Cc: Hugh Dickins <hugh@veritas.com>, Mike Kravetz <kravetz@us.ibm.com>,
       linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>, linux-mm@kvack.org,
       torvalds@osdl.org, Christoph Lameter <clameter@sgi.com>,
       Hirokazu Takahashi <taka@valinux.co.jp>,
       Magnus Damm <magnus.damm@gmail.com>, Paul Jackson <pj@sgi.com>,
       Dave Hansen <haveblue@us.ibm.com>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Message-Id: <20051104233717.5459.52323.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20051104233712.5459.94627.sendpatchset@schroedinger.engr.sgi.com>
References: <20051104233712.5459.94627.sendpatchset@schroedinger.engr.sgi.com>
Subject: [PATCH 1/7] Direct Migration V1: CONFIG_MIGRATION for swap migration
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add CONFIG_MIGRATION for page migration support

Include page migration if the system is NUMA or having a memory model
that allows distinct areas of memory (SPARSEMEM, DISCONTIGMEM).

And:
- Only include lru_add_drain_per_cpu if building for an SMP system.

This patch is independent of the rest of the direct migration patchset
and is also needed to complete the swap migration patchset.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.14-rc5-mm1/include/linux/swap.h
===================================================================
--- linux-2.6.14-rc5-mm1.orig/include/linux/swap.h	2005-11-02 11:39:01.000000000 -0800
+++ linux-2.6.14-rc5-mm1/include/linux/swap.h	2005-11-02 11:42:00.000000000 -0800
@@ -179,7 +179,9 @@ extern int vm_swappiness;
 extern int isolate_lru_page(struct page *p);
 extern int putback_lru_pages(struct list_head *l);
 
+#ifdef CONFIG_MIGRATION
 extern int migrate_pages(struct list_head *l, struct list_head *t);
+#endif
 
 #ifdef CONFIG_MMU
 /* linux/mm/shmem.c */
Index: linux-2.6.14-rc5-mm1/mm/Kconfig
===================================================================
--- linux-2.6.14-rc5-mm1.orig/mm/Kconfig	2005-10-31 14:10:53.000000000 -0800
+++ linux-2.6.14-rc5-mm1/mm/Kconfig	2005-11-02 11:44:57.000000000 -0800
@@ -132,3 +132,11 @@ config SPLIT_PTLOCK_CPUS
 	default "4096" if ARM && !CPU_CACHE_VIPT
 	default "4096" if PARISC && DEBUG_SPINLOCK && !64BIT
 	default "4"
+
+#
+# support for page migration
+#
+config MIGRATION
+	def_bool y if NUMA || SPARSEMEM || DISCONTIGMEM
+
+
Index: linux-2.6.14-rc5-mm1/mm/vmscan.c
===================================================================
--- linux-2.6.14-rc5-mm1.orig/mm/vmscan.c	2005-11-02 11:39:01.000000000 -0800
+++ linux-2.6.14-rc5-mm1/mm/vmscan.c	2005-11-02 11:54:00.000000000 -0800
@@ -572,6 +572,7 @@ keep:
 	return reclaimed;
 }
 
+#ifdef CONFIG_MIGRATION
 /*
  * swapout a single page
  * page is locked upon entry, unlocked on exit
@@ -721,6 +722,7 @@ retry_later:
 
 	return nr_failed + retry;
 }
+#endif
 
 /*
  * zone->lru_lock is heavily contended.  Some of the functions that
@@ -766,10 +768,12 @@ static int isolate_lru_pages(struct zone
 	return scanned;
 }
 
+#ifdef CONFIG_SMP
 static void lru_add_drain_per_cpu(void *dummy)
 {
 	lru_add_drain();
 }
+#endif
 
 /*
  * Isolate one page from the LRU lists and put it on the

