Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751132AbWBVLKY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751132AbWBVLKY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 06:10:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751262AbWBVLKX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 06:10:23 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:21438 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751132AbWBVLKV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 06:10:21 -0500
Date: Wed, 22 Feb 2006 20:09:56 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Yasunori Goto <y-goto@jp.fujitsu.com>
Subject: [PATCH] refine for_each_pgdat() [4/4] remove pgdat_list
Message-Id: <20060222200956.61143076.kamezawa.hiroyu@jp.fujitsu.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

By modifing for_each_pgdat() to use node_online_map, pgdat_list
is not necessary now. This patch removes it.

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

Index: linux-2.6.16-rc4/mm/page_alloc.c
===================================================================
--- linux-2.6.16-rc4.orig/mm/page_alloc.c
+++ linux-2.6.16-rc4/mm/page_alloc.c
@@ -49,7 +49,6 @@ nodemask_t node_online_map __read_mostly
 EXPORT_SYMBOL(node_online_map);
 nodemask_t node_possible_map __read_mostly = NODE_MASK_ALL;
 EXPORT_SYMBOL(node_possible_map);
-struct pglist_data *pgdat_list __read_mostly;
 unsigned long totalram_pages __read_mostly;
 unsigned long totalhigh_pages __read_mostly;
 long nr_swap_pages;
@@ -2154,8 +2153,9 @@ static void *frag_start(struct seq_file 
 {
 	pg_data_t *pgdat;
 	loff_t node = *pos;
-
-	for (pgdat = pgdat_list; pgdat && node; pgdat = pgdat->pgdat_next)
+	for (pgdat = first_online_pgdat();
+	     pgdat && node;
+	     pgdat = next_online_pgdat(pgdat))
 		--node;
 
 	return pgdat;
@@ -2166,7 +2166,7 @@ static void *frag_next(struct seq_file *
 	pg_data_t *pgdat = (pg_data_t *)arg;
 
 	(*pos)++;
-	return pgdat->pgdat_next;
+	return next_online_pgdat(pgdat);
 }
 
 static void frag_stop(struct seq_file *m, void *arg)
Index: linux-2.6.16-rc4/include/linux/mmzone.h
===================================================================
--- linux-2.6.16-rc4.orig/include/linux/mmzone.h
+++ linux-2.6.16-rc4/include/linux/mmzone.h
@@ -308,7 +308,6 @@ typedef struct pglist_data {
 	unsigned long node_spanned_pages; /* total size of physical page
 					     range, including holes */
 	int node_id;
-	struct pglist_data *pgdat_next;
 	wait_queue_head_t kswapd_wait;
 	struct task_struct *kswapd;
 	int kswapd_max_order;
@@ -325,8 +324,6 @@ typedef struct pglist_data {
 
 #include <linux/memory_hotplug.h>
 
-extern struct pglist_data *pgdat_list;
-
 void __get_zone_counts(unsigned long *active, unsigned long *inactive,
 			unsigned long *free, struct pglist_data *pgdat);
 void get_zone_counts(unsigned long *active, unsigned long *inactive,

