Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932427AbWBYHIO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932427AbWBYHIO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 02:08:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932414AbWBYHIO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 02:08:14 -0500
Received: from fgwmail2.fujitsu.co.jp ([164.71.1.135]:33958 "EHLO
	fgwmail2.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932427AbWBYHIN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 02:08:13 -0500
Date: Sat, 25 Feb 2006 16:07:36 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] for_each_online_pgdat (take2)  [1/5]  define
 for_each_online_pgdat
Message-Id: <20060225160736.56f9393e.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20060225152218.a9e74acf.kamezawa.hiroyu@jp.fujitsu.com>
References: <20060225150528.98386921.kamezawa.hiroyu@jp.fujitsu.com>
	<20060224221651.58950b8c.akpm@osdl.org>
	<20060225152218.a9e74acf.kamezawa.hiroyu@jp.fujitsu.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Feb 2006 15:22:18 +0900
KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com> wrote:

> On Fri, 24 Feb 2006 22:16:51 -0800
> Andrew Morton <akpm@osdl.org> wrote:
> > 
> > Some of these things must generate a large amount of code - would you have
> > time to look into uninlining them, see what impact that has on .text size?
> 
> Okay, I'll do soon on ia64.
> 
I compared inlined and out-of-lined vmlinux on ia64 NUMA config kernel.

	inline		out-of-line
.text   005c0680        005bf6a0

005c0680 - 005bf6a0 = FE0 = 4Kbytes. 

Considering the usage of this loop,  above size looks big ;)

I attaches a patch which makes pgdat_walk funcs out-of-line.
I'll rewrite this if necessary.
(make this patch depends on some config or move the place of funcs...)

--Kame

==
Helper function for for_each_online_pgdat / for_each_zone looks too big to
be inlined. Speed of these helper macro itself is not very important.
(inner loops are tend to do more work than this)

This patch make helper function to be out-of-lined.

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>



Index: linux-2.6.16-rc4-mm2/include/linux/mmzone.h
===================================================================
--- linux-2.6.16-rc4-mm2.orig/include/linux/mmzone.h	2006-02-25 13:58:52.000000000 +0900
+++ linux-2.6.16-rc4-mm2/include/linux/mmzone.h	2006-02-25 15:27:49.000000000 +0900
@@ -418,20 +418,9 @@
 
 #endif /* !CONFIG_NEED_MULTIPLE_NODES */
 
-static inline struct pglist_data *first_online_pgdat(void)
-{
-	return NODE_DATA(first_online_node);
-}
-
-static inline struct pglist_data *next_online_pgdat(struct pglist_data *pgdat)
-{
-	int nid = next_online_node(pgdat->node_id);
-
-	if (nid == MAX_NUMNODES)
-		return NULL;
-	return NODE_DATA(nid);
-}
-
+extern struct pglist_data *first_online_pgdat(void);
+extern struct pglist_data *next_online_pgdat(struct pglist_data *pgdat);
+extern struct zone *next_zone(struct zone *zone);
 
 /**
  * for_each_pgdat - helper macro to iterate over all nodes
@@ -441,27 +430,6 @@
 	for (pgdat = first_online_pgdat();		\
 	     pgdat;					\
 	     pgdat = next_online_pgdat(pgdat))
-
-/*
- * next_zone - helper magic for for_each_zone()
- * Thanks to William Lee Irwin III for this piece of ingenuity.
- */
-static inline struct zone *next_zone(struct zone *zone)
-{
-	pg_data_t *pgdat = zone->zone_pgdat;
-
-	if (zone < pgdat->node_zones + MAX_NR_ZONES - 1)
-		zone++;
-	else {
-		pgdat = next_online_pgdat(pgdat);
-		if (pgdat)
-			zone = pgdat->node_zones;
-		else
-			zone = NULL;
-	}
-	return zone;
-}
-
 /**
  * for_each_zone - helper macro to iterate over all memory zones
  * @zone - pointer to struct zone variable
Index: linux-2.6.16-rc4-mm2/mm/mmzone.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.16-rc4-mm2/mm/mmzone.c	2006-02-25 15:32:31.000000000 +0900
@@ -0,0 +1,50 @@
+/*
+ * linux/mm/mmzone.c
+ *
+ * management codes for pgdats and zones.
+ */
+
+
+#include <linux/config.h>
+#include <linux/stddef.h>
+#include <linux/mmzone.h>
+#include <linux/module.h>
+
+struct pglist_data *first_online_pgdat(void)
+{
+	return NODE_DATA(first_online_node);
+}
+
+EXPORT_SYMBOL(first_online_pgdat);
+
+struct pglist_data *next_online_pgdat(struct pglist_data *pgdat)
+{
+	int nid = next_online_node(pgdat->node_id);
+
+	if (nid == MAX_NUMNODES)
+		return NULL;
+	return NODE_DATA(nid);
+}
+EXPORT_SYMBOL(next_online_pgdat);
+
+
+/*
+ * next_zone - helper magic for for_each_zone()
+ */
+struct zone *next_zone(struct zone *zone)
+{
+	pg_data_t *pgdat = zone->zone_pgdat;
+
+	if (zone < pgdat->node_zones + MAX_NR_ZONES - 1)
+		zone++;
+	else {
+		pgdat = next_online_pgdat(pgdat);
+		if (pgdat)
+			zone = pgdat->node_zones;
+		else
+			zone = NULL;
+	}
+	return zone;
+}
+EXPORT_SYMBOL(next_zone);
+


