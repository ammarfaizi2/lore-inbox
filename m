Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751040AbWBYGOJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751040AbWBYGOJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 01:14:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750915AbWBYGOJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 01:14:09 -0500
Received: from fgwmail2.fujitsu.co.jp ([164.71.1.135]:37324 "EHLO
	fgwmail2.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1750825AbWBYGOI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 01:14:08 -0500
Date: Sat, 25 Feb 2006 15:13:35 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] for_each_online_pgdat (take2)  [5/5]  remove pgdat_list
Message-Id: <20060225151335.780644e5.kamezawa.hiroyu@jp.fujitsu.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

By using for_each_online_pgdat(), pgdat_list is not necessary now.
This patch removes it.

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

Index: linux-2.6.16-rc4-mm2/mm/page_alloc.c
===================================================================
--- linux-2.6.16-rc4-mm2.orig/mm/page_alloc.c
+++ linux-2.6.16-rc4-mm2/mm/page_alloc.c
@@ -49,7 +49,6 @@ nodemask_t node_online_map __read_mostly
 EXPORT_SYMBOL(node_online_map);
 nodemask_t node_possible_map __read_mostly = NODE_MASK_ALL;
 EXPORT_SYMBOL(node_possible_map);
-struct pglist_data *pgdat_list __read_mostly;
 unsigned long totalram_pages __read_mostly;
 unsigned long totalhigh_pages __read_mostly;
 long nr_swap_pages;
@@ -2243,8 +2242,9 @@ static void *frag_start(struct seq_file 
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
@@ -2255,7 +2255,7 @@ static void *frag_next(struct seq_file *
 	pg_data_t *pgdat = (pg_data_t *)arg;
 
 	(*pos)++;
-	return pgdat->pgdat_next;
+	return next_online_pgdat(pgdat);
 }
 
 static void frag_stop(struct seq_file *m, void *arg)
Index: linux-2.6.16-rc4-mm2/include/linux/mmzone.h
===================================================================
--- linux-2.6.16-rc4-mm2.orig/include/linux/mmzone.h
+++ linux-2.6.16-rc4-mm2/include/linux/mmzone.h
@@ -307,7 +307,6 @@ typedef struct pglist_data {
 	unsigned long node_spanned_pages; /* total size of physical page
 					     range, including holes */
 	int node_id;
-	struct pglist_data *pgdat_next;
 	wait_queue_head_t kswapd_wait;
 	struct task_struct *kswapd;
 	int kswapd_max_order;
@@ -324,8 +323,6 @@ typedef struct pglist_data {
 
 #include <linux/memory_hotplug.h>
 
-extern struct pglist_data *pgdat_list;
-
 void __get_zone_counts(unsigned long *active, unsigned long *inactive,
 			unsigned long *free, struct pglist_data *pgdat);
 void get_zone_counts(unsigned long *active, unsigned long *inactive,
