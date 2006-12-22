Return-Path: <linux-kernel-owner+w=401wt.eu-S1945922AbWLVDT2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945922AbWLVDT2 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 22:19:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945924AbWLVDT2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 22:19:28 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:55333 "EHLO
	fgwmail6.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945922AbWLVDT1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 22:19:27 -0500
Date: Fri, 22 Dec 2006 12:22:43 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, GOTO <y-goto@jp.fujitsu.com>,
       npiggin@suse.de
Subject: [BUG][PATCH] fix oom killer kills current every time if there is
 memory-less-node
Message-Id: <20061222122243.2a46de76.kamezawa.hiroyu@jp.fujitsu.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

constrained_alloc(), which is called to detect where oom is from,
checks passed zone_list().
If zone_list includes all nodes, it thinks oom is from mempolicy.

But there is memory-less-node. contstrained_alloc() should get
memory_less_node into count. Otherwise, current process will die
at any time. This patch fix it.

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>



 mm/oom_kill.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletion(-)

Index: devel-2.6.20-rc1-mm1/mm/oom_kill.c
===================================================================
--- devel-2.6.20-rc1-mm1.orig/mm/oom_kill.c	2006-12-16 13:47:59.000000000 +0900
+++ devel-2.6.20-rc1-mm1/mm/oom_kill.c	2006-12-22 12:11:55.000000000 +0900
@@ -174,7 +174,12 @@
 {
 #ifdef CONFIG_NUMA
 	struct zone **z;
-	nodemask_t nodes = node_online_map;
+	nodemask_t nodes;
+	int node;
+	/* node has memory ? */
+	for_each_online_node(node)
+		if (NODE_DATA(node)->node_present_pages)
+			node_set(node, nodes);
 
 	for (z = zonelist->zones; *z; z++)
 		if (cpuset_zone_allowed_softwall(*z, gfp_mask))

