Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965018AbWJJSVd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965018AbWJJSVd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 14:21:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965015AbWJJSVd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 14:21:33 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:42465 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S965013AbWJJSVS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 14:21:18 -0400
From: Chandra Seetharaman <sekharan@us.ibm.com>
To: akpm@osdl.org, Joel.Becker@oracle.com
Cc: linux-kernel@vger.kernel.org, Chandra Seetharaman <sekharan@us.ibm.com>,
       ckrm-tech@lists.sourceforge.net
Date: Tue, 10 Oct 2006 11:21:13 -0700
Message-Id: <20061010182113.20990.7216.sendpatchset@localhost.localdomain>
In-Reply-To: <20061010182043.20990.83892.sendpatchset@localhost.localdomain>
References: <20061010182043.20990.83892.sendpatchset@localhost.localdomain>
Subject: [PATCH 5/5] Change the existing code to use the new interface
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Changes to the current user of configfs, OCFS2, to use the new
interface of show_attribute().

Signed-Off-By: Chandra Seetharaman <sekharan@us.ibm.com>
--

 fs/ocfs2/cluster/heartbeat.c   |   32 ++++++++++++++++----------------
 fs/ocfs2/cluster/nodemanager.c |   25 ++++++++++++++-----------
 2 files changed, 30 insertions(+), 27 deletions(-)

Index: linux-2.6.18/fs/ocfs2/cluster/heartbeat.c
===================================================================
--- linux-2.6.18.orig/fs/ocfs2/cluster/heartbeat.c
+++ linux-2.6.18/fs/ocfs2/cluster/heartbeat.c
@@ -1111,9 +1111,9 @@ static int o2hb_read_block_input(struct 
 }
 
 static ssize_t o2hb_region_block_bytes_read(struct o2hb_region *reg,
-					    char *page)
+					    struct seq_file *s)
 {
-	return sprintf(page, "%u\n", reg->hr_block_bytes);
+	return seq_printf(s, "%u\n", reg->hr_block_bytes);
 }
 
 static ssize_t o2hb_region_block_bytes_write(struct o2hb_region *reg,
@@ -1139,9 +1139,9 @@ static ssize_t o2hb_region_block_bytes_w
 }
 
 static ssize_t o2hb_region_start_block_read(struct o2hb_region *reg,
-					    char *page)
+					    struct seq_file *s)
 {
-	return sprintf(page, "%llu\n", reg->hr_start_block);
+	return seq_printf(s, "%llu\n", reg->hr_start_block);
 }
 
 static ssize_t o2hb_region_start_block_write(struct o2hb_region *reg,
@@ -1164,9 +1164,9 @@ static ssize_t o2hb_region_start_block_w
 }
 
 static ssize_t o2hb_region_blocks_read(struct o2hb_region *reg,
-				       char *page)
+				       struct seq_file *s)
 {
-	return sprintf(page, "%d\n", reg->hr_blocks);
+	return seq_printf(s, "%d\n", reg->hr_blocks);
 }
 
 static ssize_t o2hb_region_blocks_write(struct o2hb_region *reg,
@@ -1192,12 +1192,12 @@ static ssize_t o2hb_region_blocks_write(
 }
 
 static ssize_t o2hb_region_dev_read(struct o2hb_region *reg,
-				    char *page)
+				    struct seq_file *s)
 {
 	unsigned int ret = 0;
 
 	if (reg->hr_bdev)
-		ret = sprintf(page, "%s\n", reg->hr_dev_name);
+		ret = seq_printf(s, "%s\n", reg->hr_dev_name);
 
 	return ret;
 }
@@ -1443,7 +1443,7 @@ out:
 
 struct o2hb_region_attribute {
 	struct configfs_attribute attr;
-	ssize_t (*show)(struct o2hb_region *, char *);
+	ssize_t (*show)(struct o2hb_region *, struct seq_file *);
 	ssize_t (*store)(struct o2hb_region *, const char *, size_t);
 };
 
@@ -1489,7 +1489,7 @@ static struct configfs_attribute *o2hb_r
 
 static ssize_t o2hb_region_show(struct config_item *item,
 				struct configfs_attribute *attr,
-				char *page)
+				struct seq_file *s)
 {
 	struct o2hb_region *reg = to_o2hb_region(item);
 	struct o2hb_region_attribute *o2hb_region_attr =
@@ -1497,7 +1497,7 @@ static ssize_t o2hb_region_show(struct c
 	ssize_t ret = 0;
 
 	if (o2hb_region_attr->show)
-		ret = o2hb_region_attr->show(reg, page);
+		ret = o2hb_region_attr->show(reg, s);
 	return ret;
 }
 
@@ -1581,13 +1581,13 @@ static void o2hb_heartbeat_group_drop_it
 
 struct o2hb_heartbeat_group_attribute {
 	struct configfs_attribute attr;
-	ssize_t (*show)(struct o2hb_heartbeat_group *, char *);
+	ssize_t (*show)(struct o2hb_heartbeat_group *, struct seq_file *);
 	ssize_t (*store)(struct o2hb_heartbeat_group *, const char *, size_t);
 };
 
 static ssize_t o2hb_heartbeat_group_show(struct config_item *item,
 					 struct configfs_attribute *attr,
-					 char *page)
+					 struct seq_file *s)
 {
 	struct o2hb_heartbeat_group *reg = to_o2hb_heartbeat_group(to_config_group(item));
 	struct o2hb_heartbeat_group_attribute *o2hb_heartbeat_group_attr =
@@ -1595,7 +1595,7 @@ static ssize_t o2hb_heartbeat_group_show
 	ssize_t ret = 0;
 
 	if (o2hb_heartbeat_group_attr->show)
-		ret = o2hb_heartbeat_group_attr->show(reg, page);
+		ret = o2hb_heartbeat_group_attr->show(reg, s);
 	return ret;
 }
 
@@ -1614,9 +1614,9 @@ static ssize_t o2hb_heartbeat_group_stor
 }
 
 static ssize_t o2hb_heartbeat_group_threshold_show(struct o2hb_heartbeat_group *group,
-						     char *page)
+						     struct seq_file *s)
 {
-	return sprintf(page, "%u\n", o2hb_dead_threshold);
+	return seq_printf(s, "%u\n", o2hb_dead_threshold);
 }
 
 static ssize_t o2hb_heartbeat_group_threshold_store(struct o2hb_heartbeat_group *group,
Index: linux-2.6.18/fs/ocfs2/cluster/nodemanager.c
===================================================================
--- linux-2.6.18.orig/fs/ocfs2/cluster/nodemanager.c
+++ linux-2.6.18/fs/ocfs2/cluster/nodemanager.c
@@ -238,9 +238,9 @@ static void o2nm_node_release(struct con
 	kfree(node);
 }
 
-static ssize_t o2nm_node_num_read(struct o2nm_node *node, char *page)
+static ssize_t o2nm_node_num_read(struct o2nm_node *node, struct seq_file *s)
 {
-	return sprintf(page, "%d\n", node->nd_num);
+	return seq_printf(s, "%d\n", node->nd_num);
 }
 
 static struct o2nm_cluster *to_o2nm_cluster_from_node(struct o2nm_node *node)
@@ -293,9 +293,10 @@ static ssize_t o2nm_node_num_write(struc
 
 	return count;
 }
-static ssize_t o2nm_node_ipv4_port_read(struct o2nm_node *node, char *page)
+static ssize_t o2nm_node_ipv4_port_read(struct o2nm_node *node,
+						struct seq_file *s)
 {
-	return sprintf(page, "%u\n", ntohs(node->nd_ipv4_port));
+	return seq_printf(s, "%u\n", ntohs(node->nd_ipv4_port));
 }
 
 static ssize_t o2nm_node_ipv4_port_write(struct o2nm_node *node,
@@ -318,9 +319,10 @@ static ssize_t o2nm_node_ipv4_port_write
 	return count;
 }
 
-static ssize_t o2nm_node_ipv4_address_read(struct o2nm_node *node, char *page)
+static ssize_t o2nm_node_ipv4_address_read(struct o2nm_node *node,
+							struct seq_file *s)
 {
-	return sprintf(page, "%u.%u.%u.%u\n", NIPQUAD(node->nd_ipv4_address));
+	return seq_printf(s, "%u.%u.%u.%u\n", NIPQUAD(node->nd_ipv4_address));
 }
 
 static ssize_t o2nm_node_ipv4_address_write(struct o2nm_node *node,
@@ -361,9 +363,10 @@ static ssize_t o2nm_node_ipv4_address_wr
 	return count;
 }
 
-static ssize_t o2nm_node_local_read(struct o2nm_node *node, char *page)
+static ssize_t o2nm_node_local_read(struct o2nm_node *node,
+					struct seq_file *s)
 {
-	return sprintf(page, "%d\n", node->nd_local);
+	return seq_printf(s, "%d\n", node->nd_local);
 }
 
 static ssize_t o2nm_node_local_write(struct o2nm_node *node, const char *page,
@@ -417,7 +420,7 @@ static ssize_t o2nm_node_local_write(str
 
 struct o2nm_node_attribute {
 	struct configfs_attribute attr;
-	ssize_t (*show)(struct o2nm_node *, char *);
+	ssize_t (*show)(struct o2nm_node *, struct seq_file *);
 	ssize_t (*store)(struct o2nm_node *, const char *, size_t);
 };
 
@@ -474,7 +477,7 @@ static int o2nm_attr_index(struct config
 
 static ssize_t o2nm_node_show(struct config_item *item,
 			      struct configfs_attribute *attr,
-			      char *page)
+			      struct seq_file *s)
 {
 	struct o2nm_node *node = to_o2nm_node(item);
 	struct o2nm_node_attribute *o2nm_node_attr =
@@ -482,7 +485,7 @@ static ssize_t o2nm_node_show(struct con
 	ssize_t ret = 0;
 
 	if (o2nm_node_attr->show)
-		ret = o2nm_node_attr->show(node, page);
+		ret = o2nm_node_attr->show(node, s);
 	return ret;
 }
 

-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------
