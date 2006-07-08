Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751292AbWGHAGB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751292AbWGHAGB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 20:06:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751284AbWGHAF5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 20:05:57 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:2515 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751285AbWGHAFx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 20:05:53 -0400
Date: Fri, 7 Jul 2006 17:05:43 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       Christoph Hellwig <hch@infradead.org>,
       Marcelo Tosatti <marcelo@kvack.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Martin Bligh <mbligh@google.com>, Christoph Lameter <clameter@sgi.com>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
       Andi Kleen <ak@suse.de>
Message-Id: <20060708000543.3829.24370.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20060708000501.3829.25578.sendpatchset@schroedinger.engr.sgi.com>
References: <20060708000501.3829.25578.sendpatchset@schroedinger.engr.sgi.com>
Subject: [RFC 8/8] Optimize mempolicies for a single zone
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use SINGLE_ZONE to remove the highest zone determination

Siged-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.17-mm6/mm/mempolicy.c
===================================================================
--- linux-2.6.17-mm6.orig/mm/mempolicy.c	2006-07-07 16:50:18.790221361 -0700
+++ linux-2.6.17-mm6/mm/mempolicy.c	2006-07-07 16:53:46.057679926 -0700
@@ -103,9 +103,11 @@ static struct kmem_cache *sn_cache;
 
 #define PDprintk(fmt...)
 
+#ifndef SINGLE_ZONE
 /* Highest zone. An specific allocation for a zone below that is not
    policied. */
 int policy_zone = 0;
+#endif
 
 struct mempolicy default_policy = {
 	.refcnt = ATOMIC_INIT(1), /* never free it */
Index: linux-2.6.17-mm6/include/linux/mempolicy.h
===================================================================
--- linux-2.6.17-mm6.orig/include/linux/mempolicy.h	2006-07-03 13:47:21.727467854 -0700
+++ linux-2.6.17-mm6/include/linux/mempolicy.h	2006-07-07 16:53:46.057679926 -0700
@@ -162,12 +162,18 @@ extern struct zonelist *huge_zonelist(st
 		unsigned long addr);
 extern unsigned slab_node(struct mempolicy *policy);
 
+#ifndef SINGLE_ZONE
+#define policy_zone ZONE_NORMAL
+#else
 extern int policy_zone;
+#endif
 
 static inline void check_highest_zone(int k)
 {
+#ifndef SINGLE_ZONE
 	if (k > policy_zone)
 		policy_zone = k;
+#endif
 }
 
 int do_migrate_pages(struct mm_struct *mm,
