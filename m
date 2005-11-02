Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965217AbVKBUC4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965217AbVKBUC4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 15:02:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965207AbVKBUC4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 15:02:56 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:30945 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S965217AbVKBUC4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 15:02:56 -0500
Date: Wed, 2 Nov 2005 12:00:06 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: Rob Landley <rob@landley.net>, torvalds@osdl.org, kravetz@us.ibm.com,
       raybry@mpdtxmail.amd.com, linux-kernel@vger.kernel.org,
       lee.schermerhorn@hp.com, haveblue@us.ibm.com, magnus.damm@gmail.com,
       pj@sgi.com, marcelo.tosatti@cyclades.com,
       kamezawa.hiroyu@jp.fujitsu.com
Subject: Re: [PATCH 0/5] Swap Migration V5: Overview
In-Reply-To: <200511010208.49662.rob@landley.net>
Message-ID: <Pine.LNX.4.62.0511021158480.22460@schroedinger.engr.sgi.com>
References: <20051101031239.12488.76816.sendpatchset@schroedinger.engr.sgi.com>
 <20051031192506.100d03fa.akpm@osdl.org> <200511010208.49662.rob@landley.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Nov 2005, Rob Landley wrote:

> > Do you think the features which these patches add should be Kconfigurable?
> 
> Yes please.  At least something under CONFIG_EMBEDDED to save poor Matt the 
> trouble of chopping it out himself. :)

I hope this fits the bill?

---

Add CONFIG_MIGRATION for page migration support

Include page migration if the system is NUMA or having a memory model
that allows distinct areas of memory (SPARSEMEM, DISCONTIGMEM).

And:
- Only include lru_add_drain_per_cpu if building for an SMP system.

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

