Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263276AbVGOKbv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263276AbVGOKbv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 06:31:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263273AbVGOKbu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 06:31:50 -0400
Received: from mx1.redhat.com ([66.187.233.31]:46482 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261858AbVGOKbX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 06:31:23 -0400
Date: Fri, 15 Jul 2005 18:36:07 +0800
From: David Teigland <teigland@redhat.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [patch 04/12] dlm: node weights
Message-ID: <20050715103607.GG17316@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="node-weights.patch"
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use node weights in directory mapping.  Allows nodes to be configured to
be responsible for more or less of the directory.

Signed-off-by: David Teigland <teigland@redhat.com>

Index: linux-2.6.12-mm1/drivers/dlm/dir.c
===================================================================
--- linux-2.6.12-mm1.orig/drivers/dlm/dir.c
+++ linux-2.6.12-mm1/drivers/dlm/dir.c
@@ -89,13 +89,17 @@ int dlm_dir_name2nodeid(struct dlm_ls *l
 	}
 
 	hash = dlm_hash(name, length);
-	node = (hash >> 16) % ls->ls_num_nodes;
 
 	if (ls->ls_node_array) {
+		node = (hash >> 16) % ls->ls_total_weight;
 		nodeid = ls->ls_node_array[node];
 		goto out;
 	}
 
+	/* make_member_array() failed to kmalloc ls_node_array... */
+
+	node = (hash >> 16) % ls->ls_num_nodes;
+
 	list_for_each(tmp, &ls->ls_nodes) {
 		if (n++ != node)
 			continue;
Index: linux-2.6.12-mm1/drivers/dlm/dlm_internal.h
===================================================================
--- linux-2.6.12-mm1.orig/drivers/dlm/dlm_internal.h
+++ linux-2.6.12-mm1/drivers/dlm/dlm_internal.h
@@ -134,6 +134,7 @@ struct dlm_member {
 	struct list_head	list;
 	int			nodeid;
 	int			gone_event;
+	int			weight;
 };
 
 /*
@@ -457,6 +458,7 @@ struct dlm_ls {
 	struct list_head	ls_nodes_gone;	/* dead node list, recovery */
 	int			ls_num_nodes;	/* number of nodes in ls */
 	int			ls_low_nodeid;
+	int			ls_total_weight;
 	int			*ls_node_array;
 	int			*ls_nodeids_next;
 	int			ls_nodeids_next_count;
Index: linux-2.6.12-mm1/drivers/dlm/lowcomms.c
===================================================================
--- linux-2.6.12-mm1.orig/drivers/dlm/lowcomms.c
+++ linux-2.6.12-mm1/drivers/dlm/lowcomms.c
@@ -254,6 +254,19 @@ static int nodeid_to_addr(int nodeid, st
 	return 0;
 }
 
+int dlm_node_weight(int nodeid)
+{
+	struct dlm_node *node;
+	int weight = -1;
+
+	down(&nodes_sem);
+	node = search_node(nodeid);
+	if (node)
+		weight = node->weight;
+	up(&nodes_sem);
+	return weight;
+}
+
 int dlm_set_node(int nodeid, int weight, char *addr_buf)
 {
 	struct dlm_node *node;
Index: linux-2.6.12-mm1/drivers/dlm/lowcomms.h
===================================================================
--- linux-2.6.12-mm1.orig/drivers/dlm/lowcomms.h
+++ linux-2.6.12-mm1/drivers/dlm/lowcomms.h
@@ -23,6 +23,7 @@ void dlm_lowcomms_commit_buffer(void *mh
 int dlm_set_node(int nodeid, int weight, char *addr_buf);
 int dlm_set_local(int nodeid, int weight, char *addr_buf);
 int dlm_our_nodeid(void);
+int dlm_node_weight(int nodeid);
 
 #endif				/* __LOWCOMMS_DOT_H__ */
 
Index: linux-2.6.12-mm1/drivers/dlm/member.c
===================================================================
--- linux-2.6.12-mm1.orig/drivers/dlm/member.c
+++ linux-2.6.12-mm1/drivers/dlm/member.c
@@ -56,6 +56,7 @@ static int dlm_add_member(struct dlm_ls 
 		return -ENOMEM;
 
 	memb->nodeid = nodeid;
+	memb->weight = dlm_node_weight(nodeid);
 	add_ordered_member(ls, memb);
 	ls->ls_num_nodes++;
 	return 0;
@@ -126,19 +127,43 @@ void dlm_clear_members_finish(struct dlm
 static void make_member_array(struct dlm_ls *ls)
 {
 	struct dlm_member *memb;
-	int i = 0, *array;
+	int i, w, x = 0, total = 0, all_zero = 0, *array;
 
-	if (ls->ls_node_array) {
-		kfree(ls->ls_node_array);
-		ls->ls_node_array = NULL;
+	kfree(ls->ls_node_array);
+	ls->ls_node_array = NULL;
+
+	list_for_each_entry(memb, &ls->ls_nodes, list) {
+		if (memb->weight)
+			total += memb->weight;
 	}
 
-	array = kmalloc(sizeof(int) * ls->ls_num_nodes, GFP_KERNEL);
+	/* all nodes revert to weight of 1 if all have weight 0 */
+
+	if (!total) {
+		total = ls->ls_num_nodes;
+		all_zero = 1;
+	}
+
+	ls->ls_total_weight = total;
+
+	array = kmalloc(sizeof(int) * total, GFP_KERNEL);
 	if (!array)
 		return;
 
-	list_for_each_entry(memb, &ls->ls_nodes, list)
-		array[i++] = memb->nodeid;
+	list_for_each_entry(memb, &ls->ls_nodes, list) {
+		if (!all_zero && !memb->weight)
+			continue;
+
+		if (all_zero)
+			w = 1;
+		else
+			w = memb->weight;
+
+		DLM_ASSERT(x < total, printk("total %d x %d\n", total, x););
+
+		for (i = 0; i < w; i++)
+			array[x++] = memb->nodeid;
+	}
 
 	ls->ls_node_array = array;
 }

--
