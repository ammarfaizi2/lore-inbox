Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261530AbVGRGK7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261530AbVGRGK7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Jul 2005 02:10:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261537AbVGRGK7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Jul 2005 02:10:59 -0400
Received: from mx1.redhat.com ([66.187.233.31]:21223 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261530AbVGRGKz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Jul 2005 02:10:55 -0400
Date: Mon, 18 Jul 2005 14:15:53 +0800
From: David Teigland <teigland@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-cluster@redhat.com, ocfs2-devel@oss.oracle.com
Subject: [RFC] nodemanager, ocfs2, dlm
Message-ID: <20050718061553.GA9568@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the comments about the dlm concerned how it's configured (from
user space.)  In particular, there was interest in seeing the dlm and
ocfs2 use common methods for their configuration.

The first area I'm looking at is how we get addresses/ids of other nodes.
Currently, the dlm uses an ioctl on a misc device and ocfs2 uses a
separate kernel module called "ocfs2_nodemanager" that's based on
configfs.

I've taken a stab at generalizing ocfs2_nodemanager so the dlm could use
it (removing ocfs-specific stuff).  It still needs some work, but I'd like
to know if this appeals to the ocfs group and to others who were
interested in seeing some similarity in dlm/ocfs configuration.

Thanks,
Dave


diff -urN a/drivers/Kconfig b/drivers/Kconfig
--- a/drivers/Kconfig	2005-07-18 13:40:31.011368352 +0800
+++ b/drivers/Kconfig	2005-07-18 13:46:17.661669496 +0800
@@ -68,4 +68,6 @@
 
 source "drivers/dlm/Kconfig"
 
+source "drivers/nodemanager/Kconfig"
+
 endmenu
diff -urN a/drivers/Makefile b/drivers/Makefile
--- a/drivers/Makefile	2005-07-18 13:40:31.015367744 +0800
+++ b/drivers/Makefile	2005-07-18 13:46:06.846313680 +0800
@@ -70,3 +70,4 @@
 obj-y				+= firmware/
 obj-$(CONFIG_CRYPTO)		+= crypto/
 obj-$(CONFIG_DLM)		+= dlm/
+obj-$(CONFIG_NODEMANAGER)	+= nodemanager/
diff -urN a/drivers/nodemanager/Kconfig b/drivers/nodemanager/Kconfig
--- a/drivers/nodemanager/Kconfig	1970-01-01 07:30:00.000000000 +0730
+++ b/drivers/nodemanager/Kconfig	2005-07-18 13:52:16.449125512 +0800
@@ -0,0 +1,9 @@
+menu "Node Manager"
+
+config NODEMANAGER
+	tristate "Node Manager"
+	help
+	Node addresses and ID"s are provided from user space and made
+	available to kernel components from this module.
+
+endmenu
diff -urN a/drivers/nodemanager/Makefile b/drivers/nodemanager/Makefile
--- a/drivers/nodemanager/Makefile	1970-01-01 07:30:00.000000000 +0730
+++ b/drivers/nodemanager/Makefile	2005-07-18 13:45:52.620476336 +0800
@@ -0,0 +1,3 @@
+obj-$(CONFIG_NODEMANAGER) +=	nodemanager.o
+
+nodemanager-y :=		nodemanager.o
diff -urN a/drivers/nodemanager/nodemanager.c b/drivers/nodemanager/nodemanager.c
--- a/drivers/nodemanager/nodemanager.c	1970-01-01 07:30:00.000000000 +0730
+++ b/drivers/nodemanager/nodemanager.c	2005-07-18 13:55:17.043670968 +0800
@@ -0,0 +1,655 @@
+/*
+ * nodemanager.c
+ *
+ * Copyright (C) 2004, 2005 Oracle.  All rights reserved.
+ * Copyright (C) 2005 Red Hat, Inc.  All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ * 
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ * 
+ * You should have received a copy of the GNU General Public
+ * License along with this program; if not, write to the
+ * Free Software Foundation, Inc., 59 Temple Place - Suite 330,
+ * Boston, MA 021110-1307, USA.
+ */
+
+/* TODO:
+   - generic addresses (IPV4/6)
+   - multiple addresses per node
+   - more than 255 nodes (no static MAXNODE array)
+   - function to get a list of all nodes
+*/
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/idr.h>
+#include <linux/configfs.h>
+
+#include "nodemanager.h"
+
+enum {
+	NM_NODE_ATTR_NODEID = 0,
+	NM_NODE_ATTR_ADDRESS,
+	NM_NODE_ATTR_LOCAL,
+};
+
+struct clusters;
+struct cluster;
+struct nodes;
+struct node;
+
+static ssize_t node_nodeid_read(struct node *, char *);
+static ssize_t node_nodeid_write(struct node *, const char *, size_t);
+static ssize_t node_ipv4_address_read(struct node *, char *);
+static ssize_t node_ipv4_address_write(struct node *, const char *, size_t);
+static ssize_t node_local_read(struct node *, char *);
+static ssize_t node_local_write(struct node *, const char *, size_t);
+
+static struct config_item *make_node(struct config_group *, const char *);
+static void drop_node(struct config_group *, struct config_item *);
+static void release_node(struct config_item *);
+static struct config_group *make_cluster(struct config_group *, const char *);
+static void drop_cluster(struct config_group *, struct config_item *);
+static void release_cluster(struct config_item *);
+
+static ssize_t show_node(struct config_item *, struct configfs_attribute *,
+			 char *);
+static ssize_t store_node(struct config_item *, struct configfs_attribute *,
+			  const char *, size_t);
+
+
+struct node_attribute {
+	struct configfs_attribute attr;
+	ssize_t (*show)(struct node *, char *);
+	ssize_t (*store)(struct node *, const char *, size_t);
+};
+
+static struct node_attribute node_attr_nodeid = {
+	.attr	= { .ca_owner = THIS_MODULE,
+		    .ca_name = "nodeid",
+		    .ca_mode = S_IRUGO | S_IWUSR },
+	.show	= node_nodeid_read,
+	.store	= node_nodeid_write,
+};
+
+static struct node_attribute node_attr_ipv4_address = {
+	.attr	= { .ca_owner = THIS_MODULE,
+		    .ca_name = "ipv4_address",
+		    .ca_mode = S_IRUGO | S_IWUSR },
+	.show	= node_ipv4_address_read,
+	.store	= node_ipv4_address_write,
+};
+
+static struct node_attribute node_attr_local = {
+	.attr	= { .ca_owner = THIS_MODULE,
+		    .ca_name = "local",
+		    .ca_mode = S_IRUGO | S_IWUSR },
+	.show	= node_local_read,
+	.store	= node_local_write,
+};
+
+static struct configfs_attribute *node_attrs[] = {
+	[NM_NODE_ATTR_NODEID] = &node_attr_nodeid.attr,
+	[NM_NODE_ATTR_ADDRESS] = &node_attr_ipv4_address.attr,
+	[NM_NODE_ATTR_LOCAL] = &node_attr_local.attr,
+	NULL,
+};
+
+/* Hierarchy of four kinds of objects: clusters, cluster, nodes, node.
+
+   'clusters' and 'nodes' are intermediate objects used to group together
+   collections of multiple 'cluster' objects and 'node' objects respectively.
+
+   struct clusters
+   struct cluster
+   struct nodes
+   struct node
+
+   struct config_item_type clusters_type
+   struct config_item_type cluster_type
+   struct config_item_type nodes_type
+   struct config_item_type node_type
+
+   struct configfs_group_operations clusters_ops
+   struct configfs_item_operations cluster_ops
+   struct configfs_group_operations nodes_ops
+   struct configfs_item_operations node_ops
+
+   When loaded, the module initially sets up one global, root 'clusters'
+   object named 'clusters_root' under which all 'cluster' objects will
+   be created.
+
+   When a 'cluster' object is created, a new 'nodes' structure is
+   initialized as part of it, under which multiple 'node' structs
+   can then be created.
+*/
+
+static struct configfs_item_operations node_ops = {
+	.release		= release_node,
+	.show_attribute		= show_node,
+	.store_attribute	= store_node,
+};
+
+static struct configfs_group_operations nodes_ops = {
+	.make_item	= make_node,
+	.drop_item	= drop_node,
+};
+
+static struct configfs_item_operations cluster_ops = {
+	.release	= release_cluster,
+};
+
+static struct configfs_group_operations clusters_ops = {
+	.make_group	= make_cluster,
+	.drop_item	= drop_cluster,
+};
+
+static struct config_item_type node_type = {
+	.ct_group_ops	= NULL,
+	.ct_item_ops	= &node_ops,
+	.ct_attrs	= node_attrs,
+	.ct_owner	= THIS_MODULE,
+};
+
+static struct config_item_type nodes_type = {
+	.ct_group_ops	= &nodes_ops,
+	.ct_item_ops	= NULL,
+	.ct_attrs	= NULL,
+	.ct_owner	= THIS_MODULE,
+};
+
+static struct config_item_type cluster_type = {
+	.ct_group_ops	= NULL,
+	.ct_item_ops	= &cluster_ops,
+	.ct_attrs	= NULL,
+	.ct_owner	= THIS_MODULE,
+};
+
+static struct config_item_type clusters_type = {
+	.ct_group_ops	= &clusters_ops,
+	.ct_item_ops	= NULL,
+	.ct_attrs	= NULL,
+	.ct_owner	= THIS_MODULE,
+};
+
+struct node {
+	spinlock_t		nd_lock;
+	struct config_item	nd_item; 
+	char			nd_name[NODEMANAGER_MAX_NAME_LEN+1];
+	int			nd_nodeid;
+	u32			nd_ipv4_address;
+	struct rb_node		nd_ip_node;
+	int			nd_local;
+	unsigned long		nd_set_attributes;
+	struct idr		nd_status_idr;
+	struct list_head	nd_status_list;
+};
+
+struct nodes {
+	struct config_group ns_group;
+};
+
+struct cluster {
+	struct config_group	cl_group;
+	int			cl_has_local;
+	int			cl_local_node;
+	u32			cl_local_addr;
+	rwlock_t		cl_nodes_lock;
+	struct node		*cl_nodes[NODEMANAGER_MAX_NODES];
+	struct rb_root		cl_node_ip_tree;
+};
+
+struct clusters {
+	struct configfs_subsystem cs_subsys;
+};
+
+static struct clusters clusters_root = {
+	.cs_subsys = {
+		.su_group = {
+			.cg_item = {
+				.ci_namebuf = "cluster",
+				.ci_type = &clusters_type,
+			},
+		},
+	},
+};
+
+/* for now we operate under the assertion that there can be only one
+ * cluster active at a time.  Changing this will require trickling
+ * cluster references throughout where nodes are looked up */
+
+static struct cluster *single_cluster = NULL;
+
+
+static struct cluster *to_cluster(struct config_item *item)
+{
+	return item ?
+		container_of(to_config_group(item), struct cluster, cl_group)
+		: NULL;
+}
+
+static struct node *to_node(struct config_item *item)
+{
+	return item ? container_of(item, struct node, nd_item) : NULL;
+}
+
+static struct cluster *node_to_cluster(struct node *node)
+{
+	return to_cluster(node->nd_item.ci_parent->ci_parent);
+}
+
+static struct node *node_ip_tree_lookup(struct cluster *cluster,
+					u32 addr,
+					struct rb_node ***ret_p,
+					struct rb_node **ret_parent)
+{
+	struct rb_node **p = &cluster->cl_node_ip_tree.rb_node;
+	struct rb_node *parent = NULL;
+	struct node *node, *ret = NULL;
+
+	while (*p) {
+		parent = *p;
+		node = rb_entry(parent, struct node, nd_ip_node);
+
+		if (addr < node->nd_ipv4_address)
+			p = &(*p)->rb_left;
+		else if (addr > node->nd_ipv4_address)
+			p = &(*p)->rb_right;
+		else {
+			ret = node;
+			break;
+		}
+	}
+
+	if (ret_p != NULL)
+		*ret_p = p;
+	if (ret_parent != NULL)
+		*ret_parent = parent;
+
+	return ret;
+}
+
+u32 nodemanager_nodeid_to_addr(int nodeid)
+{
+	struct node *node = NULL;
+	u32 addr = 0;
+
+	if (nodeid >= NODEMANAGER_MAX_NODES || single_cluster == NULL)
+		goto out;
+
+	read_lock(&single_cluster->cl_nodes_lock);
+	node = single_cluster->cl_nodes[nodeid];
+	if (node)
+		addr = node->nd_ipv4_address;
+	read_unlock(&single_cluster->cl_nodes_lock);
+ out:
+	return addr;
+}
+EXPORT_SYMBOL_GPL(nodemanager_nodeid_to_addr);
+
+int nodemanager_addr_to_nodeid(u32 addr)
+{
+	struct node *node = NULL;
+	struct cluster *cluster = single_cluster;
+	int nodeid = NODEMANAGER_MAX_NODES;
+
+	if (cluster == NULL)
+		goto out;
+
+	read_lock(&cluster->cl_nodes_lock);
+	node = node_ip_tree_lookup(cluster, addr, NULL, NULL);
+	if (node)
+		nodeid = node->nd_nodeid;
+	read_unlock(&cluster->cl_nodes_lock);
+ out:
+	return nodeid;
+}
+EXPORT_SYMBOL_GPL(nodemanager_addr_to_nodeid);
+
+int nodemanager_our_nodeid(void)
+{
+	int nodeid = NODEMANAGER_MAX_NODES;
+
+	if (single_cluster && single_cluster->cl_has_local)
+		nodeid = single_cluster->cl_local_node;
+
+	return nodeid;
+}
+EXPORT_SYMBOL_GPL(nodemanager_our_nodeid);
+
+u32 nodemanager_our_addr(void)
+{
+	u32 addr = 0;
+
+	if (single_cluster && single_cluster->cl_has_local)
+		addr = single_cluster->cl_local_addr;
+
+	return addr;
+}
+EXPORT_SYMBOL_GPL(nodemanager_our_addr);
+
+
+static ssize_t node_nodeid_read(struct node *node, char *page)
+{
+	return sprintf(page, "%d\n", node->nd_nodeid);
+}
+
+static ssize_t node_nodeid_write(struct node *node, const char *page,
+				 size_t count)
+{
+	struct cluster *cluster = node_to_cluster(node);
+	unsigned long tmp;
+	char *p = (char *)page;
+
+	tmp = simple_strtoul(p, &p, 0);
+	if (!p || (*p && (*p != '\n')))
+		return -EINVAL;
+
+	if (tmp >= NODEMANAGER_MAX_NODES)
+		return -ERANGE;
+
+	write_lock(&cluster->cl_nodes_lock);
+	if (cluster->cl_nodes[tmp])
+		p = NULL;
+	else  {
+		cluster->cl_nodes[tmp] = node;
+		node->nd_nodeid = tmp;
+	}
+	write_unlock(&cluster->cl_nodes_lock);
+	if (p == NULL)
+		return -EEXIST;
+
+	return count;
+}
+
+static ssize_t node_ipv4_address_read(struct node *node, char *page)
+{
+	return sprintf(page, "%u.%u.%u.%u\n", NIPQUAD(node->nd_ipv4_address));
+}
+
+static ssize_t node_ipv4_address_write(struct node *node, const char *page,
+				       size_t count)
+{
+	struct cluster *cluster = node_to_cluster(node);
+	int ret, i;
+	struct rb_node **p, *parent;
+	unsigned int octets[4];
+	u32 ipv4_addr = 0; /* network order */
+
+	ret = sscanf(page, "%3u.%3u.%3u.%3u", &octets[3], &octets[2],
+		     &octets[1], &octets[0]);
+	if (ret != 4)
+		return -EINVAL;
+
+	for (i = 0; i < ARRAY_SIZE(octets); i++) {
+		if (octets[i] > 255)
+			return -ERANGE;
+		ipv4_addr |= octets[i] << (i * 8);
+	}
+	ipv4_addr = htonl(ipv4_addr);
+
+	ret = 0;
+	write_lock(&cluster->cl_nodes_lock);
+	if (node_ip_tree_lookup(cluster, ipv4_addr, &p, &parent))
+		ret = -EEXIST;
+	else {
+		rb_link_node(&node->nd_ip_node, parent, p);
+		rb_insert_color(&node->nd_ip_node, &cluster->cl_node_ip_tree);
+	}
+	write_unlock(&cluster->cl_nodes_lock);
+	if (ret)
+		return ret;
+
+	memcpy(&node->nd_ipv4_address, &ipv4_addr, sizeof(ipv4_addr));
+
+	return count;
+}
+
+static ssize_t node_local_read(struct node *node, char *page)
+{
+	return sprintf(page, "%d\n", node->nd_local);
+}
+
+static ssize_t node_local_write(struct node *node, const char *page,
+				size_t count)
+{
+	struct cluster *cluster = node_to_cluster(node);
+	unsigned long tmp;
+	char *p = (char *)page;
+
+	tmp = simple_strtoul(p, &p, 0);
+	if (!p || (*p && (*p != '\n')))
+		return -EINVAL;
+
+	tmp = !!tmp; /* boolean of whether this node wants to be local */
+
+	/* the only failure case is trying to set a new local node
+	 * when a different one is already set */
+
+	if (tmp && tmp == cluster->cl_has_local &&
+	    cluster->cl_local_node != node->nd_nodeid)
+		return -EBUSY;
+
+	if (!tmp && cluster->cl_has_local &&
+	    cluster->cl_local_node == node->nd_nodeid) {
+		cluster->cl_local_node = 0;
+	}
+
+	node->nd_local = tmp;
+	if (node->nd_local) {
+		cluster->cl_has_local = tmp;
+		cluster->cl_local_node = node->nd_nodeid;
+		cluster->cl_local_addr = node->nd_ipv4_address;
+	}
+
+	return count;
+}
+
+static int attr_index(struct configfs_attribute *attr)
+{
+	int i;
+	for (i = 0; i < ARRAY_SIZE(node_attrs); i++) {
+		if (attr == node_attrs[i])
+			return i;
+	}
+	BUG();
+	return 0;
+}
+
+static ssize_t show_node(struct config_item *item,
+			 struct configfs_attribute *attr, char *page)
+{
+	struct node *node = to_node(item);
+	struct node_attribute *node_attr =
+			container_of(attr, struct node_attribute, attr);
+	ssize_t ret = 0;
+
+	if (node_attr->show)
+		ret = node_attr->show(node, page);
+	return ret;
+}
+
+static ssize_t store_node(struct config_item *item,
+			  struct configfs_attribute *attr,
+			  const char *page, size_t count)
+{
+	struct node *node = to_node(item);
+	struct node_attribute *node_attr =
+		container_of(attr, struct node_attribute, attr);
+	ssize_t ret;
+	int index = attr_index(attr);
+
+	if (node_attr->store == NULL) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (test_bit(index, &node->nd_set_attributes))
+		return -EBUSY;
+
+	ret = node_attr->store(node, page, count);
+	if (ret < count)
+		goto out;
+
+	set_bit(index, &node->nd_set_attributes);
+ out:
+	return ret;
+}
+
+static struct config_item *make_node(struct config_group *group,
+				     const char *name)
+{
+	struct node *node = NULL;
+	struct config_item *ret = NULL;
+
+	if (strlen(name) > NODEMANAGER_MAX_NAME_LEN)
+		goto out;
+
+	node = kcalloc(1, sizeof(struct node), GFP_KERNEL);
+	if (node == NULL)
+		goto out;
+
+	strcpy(node->nd_name, name); /* use item.ci_namebuf instead? */
+	config_item_init_type_name(&node->nd_item, name, &node_type);
+	spin_lock_init(&node->nd_lock);
+	idr_init(&node->nd_status_idr);
+	INIT_LIST_HEAD(&node->nd_status_list);
+
+	ret = &node->nd_item;
+ out:
+	if (ret == NULL)
+		kfree(node);
+
+	return ret;
+}
+
+static void drop_node(struct config_group *group, struct config_item *item)
+{
+	struct node *node = to_node(item);
+	struct cluster *cluster = to_cluster(group->cg_item.ci_parent);
+
+	if (cluster->cl_has_local &&
+	    (cluster->cl_local_node == node->nd_nodeid)) {
+		cluster->cl_has_local = 0;
+		cluster->cl_local_node = NODEMANAGER_MAX_NODES;
+	}
+
+	write_lock(&cluster->cl_nodes_lock);
+
+	if (node->nd_ipv4_address)
+		rb_erase(&node->nd_ip_node, &cluster->cl_node_ip_tree);
+
+	/* nd_nodeid might be 0 if the node number hasn't been set.. */
+	if (cluster->cl_nodes[node->nd_nodeid] == node)
+		cluster->cl_nodes[node->nd_nodeid] = NULL;
+
+	write_unlock(&cluster->cl_nodes_lock);
+
+	config_item_put(item);
+}
+
+static void release_node(struct config_item *item)
+{
+	struct node *node = to_node(item);
+	kfree(node);
+}
+
+/* a cluster object is created under the one root clusters object */
+
+static struct config_group *make_cluster(struct config_group *group,
+					 const char *name)
+{
+	struct cluster *cluster = NULL;
+	struct nodes *nodes = NULL;
+	struct config_group *ret = NULL;
+	void *defs = NULL;
+
+	if (single_cluster)
+		goto out;
+
+	cluster = kcalloc(1, sizeof(struct cluster), GFP_KERNEL);
+	nodes = kcalloc(1, sizeof(struct nodes), GFP_KERNEL);
+	defs = kcalloc(2, sizeof(struct config_group *), GFP_KERNEL);
+
+	if (!cluster || !nodes || !defs)
+		goto out;
+
+	config_group_init_type_name(&cluster->cl_group, name, &cluster_type);
+
+	config_group_init_type_name(&nodes->ns_group, "nodes", &nodes_type);
+
+	cluster->cl_group.default_groups = defs;
+	cluster->cl_group.default_groups[0] = &nodes->ns_group;
+	cluster->cl_group.default_groups[1] = NULL;
+	rwlock_init(&cluster->cl_nodes_lock);
+	cluster->cl_node_ip_tree = RB_ROOT;
+
+	ret = &cluster->cl_group;
+	single_cluster = cluster;
+ out:
+	if (ret == NULL) {
+		kfree(cluster);
+		kfree(nodes);
+		kfree(defs);
+	}
+
+	return ret;
+}
+
+static void drop_cluster(struct config_group *group, struct config_item *item)
+{
+	struct cluster *cluster = to_cluster(item);
+	struct config_item *killme;
+	int i;
+
+	BUG_ON(single_cluster != cluster);
+	single_cluster = NULL;
+
+	for (i = 0; cluster->cl_group.default_groups[i]; i++) {
+		killme = &cluster->cl_group.default_groups[i]->cg_item;
+		cluster->cl_group.default_groups[i] = NULL;
+		config_item_put(killme);
+	}
+
+	config_item_put(item);
+}
+
+static void release_cluster(struct config_item *item)
+{
+	struct cluster *cluster = to_cluster(item);
+	kfree(cluster->cl_group.default_groups);
+	kfree(cluster);
+}
+
+static int __init init_nodemanager(void)
+{
+	int ret = -1;
+
+	config_group_init(&clusters_root.cs_subsys.su_group);
+	init_MUTEX(&clusters_root.cs_subsys.su_sem);
+
+	ret = configfs_register_subsystem(&clusters_root.cs_subsys);
+	if (ret)
+		printk(KERN_ERR "nodemanager: Registration returned %d\n", ret);
+
+	return ret;
+}
+
+static void __exit exit_nodemanager(void)
+{
+	configfs_unregister_subsystem(&clusters_root.cs_subsys);
+}
+
+MODULE_AUTHOR("Oracle");
+MODULE_LICENSE("GPL");
+
+module_init(init_nodemanager)
+module_exit(exit_nodemanager)
+
diff -urN a/drivers/nodemanager/nodemanager.h b/drivers/nodemanager/nodemanager.h
--- a/drivers/nodemanager/nodemanager.h	1970-01-01 07:30:00.000000000 +0730
+++ b/drivers/nodemanager/nodemanager.h	2005-07-18 13:41:35.377583200 +0800
@@ -0,0 +1,37 @@
+/*
+ * nodemanager.h
+ *
+ * Copyright (C) 2004 Oracle.  All rights reserved.
+ * Copyright (C) 2005 Red Hat, Inc.  All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ * 
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ * 
+ * You should have received a copy of the GNU General Public
+ * License along with this program; if not, write to the
+ * Free Software Foundation, Inc., 59 Temple Place - Suite 330,
+ * Boston, MA 021110-1307, USA.
+ *
+ */
+
+#ifndef NODEMANAGER_H
+#define NODEMANAGER_H
+
+#define NODEMANAGER_MAX_NODES		255
+#define NODEMANAGER_INVALID_NODE_NUM	255
+#define NODEMANAGER_MAX_NAME_LEN	__NEW_UTS_LEN	/* 64 */
+
+u32 nodemanager_nodeid_to_addr(int nodeid);
+int nodemanager_addr_to_nodeid(u32 addr);
+int nodemanager_our_nodeid(void);
+u32 nodemanager_our_addr(void);
+
+#endif
+
