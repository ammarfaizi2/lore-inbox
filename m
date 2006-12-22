Return-Path: <linux-kernel-owner+w=401wt.eu-S1945957AbWLVIMo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945957AbWLVIMo (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 03:12:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945958AbWLVIMo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 03:12:44 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:40241 "EHLO
	fgwmail6.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945957AbWLVIMn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 03:12:43 -0500
Date: Fri, 22 Dec 2006 17:15:28 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: pj@sgi.com, linux-kernel@vger.kernel.org, akpm@osdl.org,
       y-goto@jp.fujitsu.com, npiggin@suse.de
Subject: [BUG][PATCH] fix oom killer kills current every time if there is
 memory-less-node take2
Message-Id: <20061222171528.cf31bad1.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20061222142448.14836b59.kamezawa.hiroyu@jp.fujitsu.com>
References: <20061222122243.2a46de76.kamezawa.hiroyu@jp.fujitsu.com>
	<20061221211812.4acaede5.pj@sgi.com>
	<20061222142448.14836b59.kamezawa.hiroyu@jp.fujitsu.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed patch comment.

-Kame
==
constrained_alloc(), which is called to detect where oom is from,
checks passed zone_list().
If zone_list doesn't include all nodes, it thinks oom is from mempolicy.

But there is memory-less-node. memory-less-node's zones are never included in
zonelist[].

contstrained_alloc() should get memory_less_node into count. 
Otherwise, it always thinks 'oom is from mempolicy'.
This means that current process dies at any time. This patch fix it.

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

