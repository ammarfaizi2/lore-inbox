Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750789AbVHRGC2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750789AbVHRGC2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 02:02:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750791AbVHRGC1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 02:02:27 -0400
Received: from mx1.redhat.com ([66.187.233.31]:5011 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750789AbVHRGC0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 02:02:26 -0400
Date: Thu, 18 Aug 2005 14:07:50 +0800
From: David Teigland <teigland@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, linux-cluster@redhat.com
Subject: [PATCH 1/3] dlm: use configfs
Message-ID: <20050818060750.GA10133@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use configfs to configure lockspace members and node addresses.  This was
previously done with sysfs and ioctl.

Signed-off-by: David Teigland <teigland@redhat.com>

---

 drivers/dlm/Makefile       |    1 
 drivers/dlm/config.c       |  759 ++++++++++++++++++++++++++++++++++++++++++++-
 drivers/dlm/config.h       |   12 
 drivers/dlm/dlm_internal.h |    2 
 drivers/dlm/lockspace.c    |    7 
 drivers/dlm/lowcomms.c     |  195 +----------
 drivers/dlm/lowcomms.h     |    4 
 drivers/dlm/main.c         |   18 -
 drivers/dlm/member.c       |   40 +-
 drivers/dlm/member_sysfs.c |   76 ----
 drivers/dlm/node_ioctl.c   |  126 -------
 drivers/dlm/requestqueue.c |    2 
 include/linux/dlm_node.h   |   44 --
 13 files changed, 828 insertions(+), 458 deletions(-)

diff -urpN a/drivers/dlm/Makefile b/drivers/dlm/Makefile
--- a/drivers/dlm/Makefile	2005-08-17 17:19:22.000000000 +0800
+++ b/drivers/dlm/Makefile	2005-08-18 13:22:00.718154328 +0800
@@ -12,7 +12,6 @@ dlm-y :=			ast.o \
 				member_sysfs.o \
 				memory.o \
 				midcomms.o \
-				node_ioctl.o \
 				rcom.o \
 				recover.o \
 				recoverd.o \
diff -urpN a/drivers/dlm/config.c b/drivers/dlm/config.c
--- a/drivers/dlm/config.c	2005-08-17 17:19:22.000000000 +0800
+++ b/drivers/dlm/config.c	2005-08-18 13:22:00.719154176 +0800
@@ -11,9 +11,756 @@
 *******************************************************************************
 ******************************************************************************/
 
-#include "dlm_internal.h"
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/configfs.h>
+#include <net/sock.h>
+
 #include "config.h"
 
+/*
+ * /config/dlm/<cluster>/spaces/<space>/nodes/<node>/nodeid
+ * /config/dlm/<cluster>/spaces/<space>/nodes/<node>/weight
+ * /config/dlm/<cluster>/comms/<comm>/nodeid
+ * /config/dlm/<cluster>/comms/<comm>/local
+ * /config/dlm/<cluster>/comms/<comm>/addr
+ * The <cluster> level is useless, but I haven't figured out how to avoid it.
+ */
+
+static struct config_group *space_list;
+static struct config_group *comm_list;
+static struct comm *local_comm;
+
+struct clusters;
+struct cluster;
+struct spaces;
+struct space;
+struct comms;
+struct comm;
+struct nodes;
+struct node;
+
+static struct config_group *make_cluster(struct config_group *, const char *);
+static void drop_cluster(struct config_group *, struct config_item *);
+static void release_cluster(struct config_item *);
+static struct config_group *make_space(struct config_group *, const char *);
+static void drop_space(struct config_group *, struct config_item *);
+static void release_space(struct config_item *);
+static struct config_item *make_comm(struct config_group *, const char *);
+static void drop_comm(struct config_group *, struct config_item *);
+static void release_comm(struct config_item *);
+static struct config_item *make_node(struct config_group *, const char *);
+static void drop_node(struct config_group *, struct config_item *);
+static void release_node(struct config_item *);
+
+static ssize_t show_comm(struct config_item *i, struct configfs_attribute *a,
+			 char *buf);
+static ssize_t store_comm(struct config_item *i, struct configfs_attribute *a,
+			  const char *buf, size_t len);
+static ssize_t show_node(struct config_item *i, struct configfs_attribute *a,
+			 char *buf);
+static ssize_t store_node(struct config_item *i, struct configfs_attribute *a,
+			  const char *buf, size_t len);
+
+static ssize_t comm_nodeid_read(struct comm *cm, char *buf);
+static ssize_t comm_nodeid_write(struct comm *cm, const char *buf, size_t len);
+static ssize_t comm_local_read(struct comm *cm, char *buf);
+static ssize_t comm_local_write(struct comm *cm, const char *buf, size_t len);
+static ssize_t comm_addr_write(struct comm *cm, const char *buf, size_t len);
+static ssize_t node_nodeid_read(struct node *nd, char *buf);
+static ssize_t node_nodeid_write(struct node *nd, const char *buf, size_t len);
+static ssize_t node_weight_read(struct node *nd, char *buf);
+static ssize_t node_weight_write(struct node *nd, const char *buf, size_t len);
+
+enum {
+	COMM_ATTR_NODEID = 0,
+	COMM_ATTR_LOCAL,
+	COMM_ATTR_ADDR,
+};
+
+struct comm_attribute {
+	struct configfs_attribute attr;
+	ssize_t (*show)(struct comm *, char *);
+	ssize_t (*store)(struct comm *, const char *, size_t);
+};
+
+static struct comm_attribute comm_attr_nodeid = {
+	.attr   = { .ca_owner = THIS_MODULE,
+                    .ca_name = "nodeid",
+                    .ca_mode = S_IRUGO | S_IWUSR },
+	.show   = comm_nodeid_read,
+	.store  = comm_nodeid_write,
+};
+
+static struct comm_attribute comm_attr_local = {
+	.attr   = { .ca_owner = THIS_MODULE,
+                    .ca_name = "local",
+                    .ca_mode = S_IRUGO | S_IWUSR },
+	.show   = comm_local_read,
+	.store  = comm_local_write,
+};
+
+static struct comm_attribute comm_attr_addr = {
+	.attr   = { .ca_owner = THIS_MODULE,
+                    .ca_name = "addr",
+                    .ca_mode = S_IRUGO | S_IWUSR },
+	.store  = comm_addr_write,
+};
+
+static struct configfs_attribute *comm_attrs[] = {
+	[COMM_ATTR_NODEID] = &comm_attr_nodeid.attr,
+	[COMM_ATTR_LOCAL] = &comm_attr_local.attr,
+	[COMM_ATTR_ADDR] = &comm_attr_addr.attr,
+	NULL,
+};
+
+enum {
+	NODE_ATTR_NODEID = 0,
+	NODE_ATTR_WEIGHT,
+};
+
+struct node_attribute {
+	struct configfs_attribute attr;
+	ssize_t (*show)(struct node *, char *);
+	ssize_t (*store)(struct node *, const char *, size_t);
+};
+
+static struct node_attribute node_attr_nodeid = {
+	.attr   = { .ca_owner = THIS_MODULE,
+                    .ca_name = "nodeid",
+                    .ca_mode = S_IRUGO | S_IWUSR },
+	.show   = node_nodeid_read,
+	.store  = node_nodeid_write,
+};
+
+static struct node_attribute node_attr_weight = {
+	.attr   = { .ca_owner = THIS_MODULE,
+                    .ca_name = "weight",
+                    .ca_mode = S_IRUGO | S_IWUSR },
+	.show   = node_weight_read,
+	.store  = node_weight_write,
+};
+
+static struct configfs_attribute *node_attrs[] = {
+	[NODE_ATTR_NODEID] = &node_attr_nodeid.attr,
+	[NODE_ATTR_WEIGHT] = &node_attr_weight.attr,
+	NULL,
+};
+
+struct clusters {
+	struct configfs_subsystem subsys;
+};
+
+struct cluster {
+	struct config_group group;
+};
+
+struct spaces {
+	struct config_group ss_group;
+};
+
+struct space {
+	struct config_group group;
+	struct list_head members;
+	struct semaphore members_lock;
+	int members_count;
+};
+
+struct comms {
+	struct config_group cs_group;
+};
+
+struct comm {
+	struct config_item item;
+	int nodeid;
+	int local;
+	int addr_count;
+	struct sockaddr_storage *addr[DLM_MAX_ADDR_COUNT];
+};
+
+struct nodes {
+	struct config_group ns_group;
+};
+
+struct node {
+	struct config_item item;
+	struct list_head list; /* space->members */
+	int nodeid;
+	int weight;
+};
+
+static struct configfs_group_operations clusters_ops = {
+	.make_group = make_cluster,
+	.drop_item = drop_cluster,
+};
+
+static struct configfs_item_operations cluster_ops = {
+	.release = release_cluster,
+};
+
+static struct configfs_group_operations spaces_ops = {
+	.make_group = make_space,
+	.drop_item = drop_space,
+};
+
+static struct configfs_item_operations space_ops = {
+	.release = release_space,
+};
+
+static struct configfs_group_operations comms_ops = {
+	.make_item = make_comm,
+	.drop_item = drop_comm,
+};
+
+static struct configfs_item_operations comm_ops = {
+	.release = release_comm,
+	.show_attribute = show_comm,
+	.store_attribute = store_comm,
+};
+
+static struct configfs_group_operations nodes_ops = {
+	.make_item = make_node,
+	.drop_item = drop_node,
+};
+
+static struct configfs_item_operations node_ops = {
+	.release = release_node,
+	.show_attribute = show_node,
+	.store_attribute = store_node,
+};
+
+static struct config_item_type clusters_type = {
+	.ct_group_ops = &clusters_ops,
+	.ct_owner = THIS_MODULE,
+};
+
+static struct config_item_type cluster_type = {
+	.ct_item_ops = &cluster_ops,
+	.ct_owner = THIS_MODULE,
+};
+
+static struct config_item_type spaces_type = {
+	.ct_group_ops = &spaces_ops,
+	.ct_owner = THIS_MODULE,
+};
+
+static struct config_item_type space_type = {
+	.ct_item_ops = &space_ops,
+	.ct_owner = THIS_MODULE,
+};
+
+static struct config_item_type comms_type = {
+	.ct_group_ops = &comms_ops,
+	.ct_owner = THIS_MODULE,
+};
+
+static struct config_item_type comm_type = {
+	.ct_item_ops = &comm_ops,
+	.ct_attrs = comm_attrs,
+	.ct_owner = THIS_MODULE,
+};
+
+static struct config_item_type nodes_type = {
+	.ct_group_ops = &nodes_ops,
+	.ct_owner = THIS_MODULE,
+};
+
+static struct config_item_type node_type = {
+	.ct_item_ops = &node_ops,
+	.ct_attrs = node_attrs,
+	.ct_owner = THIS_MODULE,
+};
+
+static struct cluster *to_cluster(struct config_item *i)
+{
+	return i ? container_of(to_config_group(i), struct cluster, group):NULL;
+}
+
+static struct space *to_space(struct config_item *i)
+{
+	return i ? container_of(to_config_group(i), struct space, group) : NULL;
+}
+
+static struct comm *to_comm(struct config_item *i)
+{
+	return i ? container_of(i, struct comm, item) : NULL;
+}
+
+static struct node *to_node(struct config_item *i)
+{
+	return i ? container_of(i, struct node, item) : NULL;
+}
+
+static struct config_group *make_cluster(struct config_group *g,
+					 const char *name)
+{
+	struct cluster *cl = NULL;
+	struct spaces *sps = NULL;
+	struct comms *cms = NULL;
+	void *gps = NULL;
+
+	cl = kzalloc(sizeof(struct cluster), GFP_KERNEL);
+	gps = kcalloc(3, sizeof(struct config_group *), GFP_KERNEL);
+	sps = kzalloc(sizeof(struct spaces), GFP_KERNEL);
+	cms = kzalloc(sizeof(struct comms), GFP_KERNEL);
+
+	if (!cl || !gps || !sps || !cms)
+		goto fail;
+
+	config_group_init_type_name(&cl->group, name, &cluster_type);
+	config_group_init_type_name(&sps->ss_group, "spaces", &spaces_type);
+	config_group_init_type_name(&cms->cs_group, "comms", &comms_type);
+
+	cl->group.default_groups = gps;
+	cl->group.default_groups[0] = &sps->ss_group;
+	cl->group.default_groups[1] = &cms->cs_group;
+	cl->group.default_groups[2] = NULL;
+
+	space_list = &sps->ss_group;
+	comm_list = &cms->cs_group;
+	return &cl->group;
+
+ fail:
+	kfree(cl);
+	kfree(gps);
+	kfree(sps);
+	kfree(cms);
+	return NULL;
+}
+
+static void drop_cluster(struct config_group *g, struct config_item *i)
+{
+	struct cluster *cl = to_cluster(i);
+	struct config_item *tmp;
+	int j;
+
+	for (j = 0; cl->group.default_groups[j]; j++) {
+		tmp = &cl->group.default_groups[j]->cg_item;
+		cl->group.default_groups[j] = NULL;
+		config_item_put(tmp);
+	}
+
+	space_list = NULL;
+	comm_list = NULL;
+
+	config_item_put(i);
+}
+
+static void release_cluster(struct config_item *i)
+{
+	struct cluster *cl = to_cluster(i);
+	kfree(cl->group.default_groups);
+	kfree(cl);
+}
+
+static struct config_group *make_space(struct config_group *g, const char *name)
+{
+	struct space *sp = NULL;
+	struct nodes *nds = NULL;
+	void *gps = NULL;
+
+	sp = kzalloc(sizeof(struct space), GFP_KERNEL);
+	gps = kcalloc(2, sizeof(struct config_group *), GFP_KERNEL);
+	nds = kzalloc(sizeof(struct nodes), GFP_KERNEL);
+
+	if (!sp || !gps || !nds)
+		goto fail;
+
+	config_group_init_type_name(&sp->group, name, &space_type);
+	config_group_init_type_name(&nds->ns_group, "nodes", &nodes_type);
+
+	sp->group.default_groups = gps;
+	sp->group.default_groups[0] = &nds->ns_group;
+	sp->group.default_groups[1] = NULL;
+
+	INIT_LIST_HEAD(&sp->members);
+	init_MUTEX(&sp->members_lock);
+	sp->members_count = 0;
+	return &sp->group;
+
+ fail:
+	kfree(sp);
+	kfree(gps);
+	kfree(nds);
+	return NULL;
+}
+
+static void drop_space(struct config_group *g, struct config_item *i)
+{
+	struct space *sp = to_space(i);
+	struct config_item *tmp;
+	int j;
+
+	/* assert list_empty(&sp->members) */
+
+	for (j = 0; sp->group.default_groups[j]; j++) {
+		tmp = &sp->group.default_groups[j]->cg_item;
+		sp->group.default_groups[j] = NULL;
+		config_item_put(tmp);
+	}
+
+	config_item_put(i);
+}
+
+static void release_space(struct config_item *i)
+{
+	struct space *sp = to_space(i);
+	kfree(sp->group.default_groups);
+	kfree(sp);
+}
+
+static struct config_item *make_comm(struct config_group *g, const char *name)
+{
+	struct comm *cm;
+
+	cm = kzalloc(sizeof(struct comm), GFP_KERNEL);
+	if (!cm)
+		return NULL;
+
+	config_item_init_type_name(&cm->item, name, &comm_type);
+	cm->nodeid = -1;
+	cm->local = 0;
+	cm->addr_count = 0;
+	return &cm->item;
+}
+
+static void drop_comm(struct config_group *g, struct config_item *i)
+{
+	struct comm *cm = to_comm(i);
+	if (local_comm == cm)
+		local_comm = NULL;
+	while (cm->addr_count--)
+		kfree(cm->addr[cm->addr_count]);
+	config_item_put(i);
+}
+
+static void release_comm(struct config_item *i)
+{
+	struct comm *cm = to_comm(i);
+	kfree(cm);
+}
+
+static struct config_item *make_node(struct config_group *g, const char *name)
+{
+	struct space *sp = to_space(g->cg_item.ci_parent);
+	struct node *nd;
+
+	nd = kzalloc(sizeof(struct node), GFP_KERNEL);
+	if (!nd)
+		return NULL;
+
+	config_item_init_type_name(&nd->item, name, &node_type);
+	nd->nodeid = -1;
+	nd->weight = 1;  /* default weight of 1 if none is set */
+
+	down(&sp->members_lock);
+	list_add(&nd->list, &sp->members);
+	sp->members_count++;
+	up(&sp->members_lock);
+
+	return &nd->item;
+}
+
+static void drop_node(struct config_group *g, struct config_item *i)
+{
+	struct space *sp = to_space(g->cg_item.ci_parent);
+	struct node *nd = to_node(i);
+
+	down(&sp->members_lock);
+	list_del(&nd->list);
+	sp->members_count--;
+	up(&sp->members_lock);
+
+	config_item_put(i);
+}
+
+static void release_node(struct config_item *i)
+{
+	struct node *nd = to_node(i);
+	kfree(nd);
+}
+
+static struct clusters clusters_root = {
+	.subsys = {
+		.su_group = {
+			.cg_item = {
+				.ci_namebuf = "dlm",
+				.ci_type = &clusters_type,
+			},
+		},
+	},
+};
+
+int dlm_config_init(void)
+{
+	config_group_init(&clusters_root.subsys.su_group);
+	init_MUTEX(&clusters_root.subsys.su_sem);
+	return configfs_register_subsystem(&clusters_root.subsys);
+}
+
+void dlm_config_exit(void)
+{
+	configfs_unregister_subsystem(&clusters_root.subsys);
+}
+
+/*
+ * Functions for user space to read/write attributes
+ */
+
+static ssize_t show_comm(struct config_item *i, struct configfs_attribute *a,
+			 char *buf)
+{
+	struct comm *cm = to_comm(i);
+	struct comm_attribute *cma =
+			container_of(a, struct comm_attribute, attr);
+	return cma->show ? cma->show(cm, buf) : 0;
+}
+
+static ssize_t store_comm(struct config_item *i, struct configfs_attribute *a,
+			  const char *buf, size_t len)
+{
+	struct comm *cm = to_comm(i);
+	struct comm_attribute *cma =
+		container_of(a, struct comm_attribute, attr);
+	return cma->store ? cma->store(cm, buf, len) : -EINVAL;
+}
+
+static ssize_t comm_nodeid_read(struct comm *cm, char *buf)
+{
+	return sprintf(buf, "%d\n", cm->nodeid);
+}
+
+static ssize_t comm_nodeid_write(struct comm *cm, const char *buf, size_t len)
+{
+	cm->nodeid = simple_strtol(buf, NULL, 0);
+	return len;
+}
+
+static ssize_t comm_local_read(struct comm *cm, char *buf)
+{
+	return sprintf(buf, "%d\n", cm->local);
+}
+
+static ssize_t comm_local_write(struct comm *cm, const char *buf, size_t len)
+{
+	cm->local= simple_strtol(buf, NULL, 0);
+	if (cm->local && !local_comm)
+		local_comm = cm;
+	return len;
+}
+
+static ssize_t comm_addr_write(struct comm *cm, const char *buf, size_t len)
+{
+	struct sockaddr_storage *addr;
+
+	if (len != sizeof(struct sockaddr_storage))
+		return -EINVAL;
+
+	if (cm->addr_count >= DLM_MAX_ADDR_COUNT)
+		return -ENOSPC;
+
+	addr = kzalloc(sizeof(*addr), GFP_KERNEL);
+	if (!addr)
+		return -ENOMEM;
+
+	memcpy(addr, buf, len);
+	cm->addr[cm->addr_count++] = addr;
+	return len;
+}
+
+static ssize_t show_node(struct config_item *i, struct configfs_attribute *a,
+			 char *buf)
+{
+	struct node *nd = to_node(i);
+	struct node_attribute *nda =
+			container_of(a, struct node_attribute, attr);
+	return nda->show ? nda->show(nd, buf) : 0;
+}
+
+static ssize_t store_node(struct config_item *i, struct configfs_attribute *a,
+			  const char *buf, size_t len)
+{
+	struct node *nd = to_node(i);
+	struct node_attribute *nda =
+		container_of(a, struct node_attribute, attr);
+	return nda->store ? nda->store(nd, buf, len) : -EINVAL;
+}
+
+static ssize_t node_nodeid_read(struct node *nd, char *buf)
+{
+	return sprintf(buf, "%d\n", nd->nodeid);
+}
+
+static ssize_t node_nodeid_write(struct node *nd, const char *buf, size_t len)
+{
+	nd->nodeid = simple_strtol(buf, NULL, 0);
+	return len;
+}
+
+static ssize_t node_weight_read(struct node *nd, char *buf)
+{
+	return sprintf(buf, "%d\n", nd->weight);
+}
+
+static ssize_t node_weight_write(struct node *nd, const char *buf, size_t len)
+{
+	nd->weight = simple_strtol(buf, NULL, 0);
+	return len;
+}
+
+/*
+ * Functions for the dlm to get the info that's been configured
+ */
+
+static struct space *get_space(char *name)
+{
+	if (!space_list)
+		return NULL;
+	return to_space(config_group_find_obj(space_list, name));
+}
+
+static void put_space(struct space *sp)
+{
+	config_item_put(&sp->group.cg_item);
+}
+
+static struct comm *get_comm(int nodeid, struct sockaddr_storage *addr)
+{
+	struct config_item *i;
+	struct comm *cm;
+	int found = 0;
+
+	if (!comm_list)
+		return NULL;
+
+	list_for_each_entry(i, &comm_list->cg_children, ci_entry) {
+		cm = to_comm(i);
+
+		if (nodeid) {
+			if (cm->nodeid != nodeid)
+				continue;
+			found = 1;
+			break;
+		} else {
+			if (!cm->addr_count ||
+			    memcmp(cm->addr[0], addr, sizeof(*addr)))
+				continue;
+			found = 1;
+			break;
+		}
+	}
+
+	if (found)
+		config_item_get(i);
+	else
+		cm = NULL;
+	return cm;
+}
+
+static void put_comm(struct comm *cm)
+{
+	config_item_put(&cm->item);
+}
+
+/* caller must free mem */
+int dlm_nodeid_list(char *lsname, int **ids_out)
+{
+	struct space *sp;
+	struct node *nd;
+	int i = 0, rv = 0;
+	int *ids;
+
+	sp = get_space(lsname);
+	if (!sp)
+		return -EEXIST;
+
+	down(&sp->members_lock);
+	if (!sp->members_count) {
+		rv = 0;
+		goto out;
+	}
+
+	ids = kcalloc(sp->members_count, sizeof(int), GFP_KERNEL);
+	if (!ids) {
+		rv = -ENOMEM;
+		goto out;
+	}
+
+	rv = sp->members_count;
+	list_for_each_entry(nd, &sp->members, list)
+		ids[i++] = nd->nodeid;
+
+	if (rv != i)
+		printk("bad nodeid count %d %d\n", rv, i);
+
+	*ids_out = ids;
+ out:
+	up(&sp->members_lock);
+	put_space(sp);
+	return rv;
+}
+
+int dlm_node_weight(char *lsname, int nodeid)
+{
+	struct space *sp;
+	struct node *nd;
+	int w = -EEXIST;
+
+	sp = get_space(lsname);
+	if (!sp)
+		goto out;
+
+	down(&sp->members_lock);
+	list_for_each_entry(nd, &sp->members, list) {
+		if (nd->nodeid != nodeid)
+			continue;
+		w = nd->weight;
+		break;
+	}
+	up(&sp->members_lock);
+	put_space(sp);
+ out:
+	return w;
+}
+
+int dlm_nodeid_to_addr(int nodeid, struct sockaddr_storage *addr)
+{
+	struct comm *cm = get_comm(nodeid, NULL);
+	if (!cm)
+		return -EEXIST;
+	if (!cm->addr_count)
+		return -ENOENT;
+	memcpy(addr, cm->addr[0], sizeof(*addr));
+	put_comm(cm);
+	return 0;
+}
+
+int dlm_addr_to_nodeid(struct sockaddr_storage *addr, int *nodeid)
+{
+	struct comm *cm = get_comm(0, addr);
+	if (!cm)
+		return -EEXIST;
+	*nodeid = cm->nodeid;
+	put_comm(cm);
+	return 0;
+}
+
+int dlm_our_nodeid(void)
+{
+	return local_comm ? local_comm->nodeid : 0;
+}
+
+/* num 0 is first addr, num 1 is second addr */
+int dlm_our_addr(struct sockaddr_storage *addr, int num)
+{
+	if (!local_comm)
+		return -1;
+	if (num + 1 > local_comm->addr_count)
+		return -1;
+	memcpy(addr, local_comm->addr[num], sizeof(*addr));
+	return 0;
+}
+
 /* Config file defaults */
 #define DEFAULT_TCP_PORT       21064
 #define DEFAULT_BUFFER_SIZE     4096
@@ -35,13 +782,3 @@ struct dlm_config_info dlm_config = {
 	.scan_secs = DEFAULT_SCAN_SECS
 };
 
-int dlm_config_init(void)
-{
-	/* FIXME: hook the config values into sysfs */
-	return 0;
-}
-
-void dlm_config_exit(void)
-{
-}
-
diff -urpN a/drivers/dlm/config.h b/drivers/dlm/config.h
--- a/drivers/dlm/config.h	2005-08-17 17:19:22.000000000 +0800
+++ b/drivers/dlm/config.h	2005-08-18 13:22:00.720154024 +0800
@@ -14,6 +14,8 @@
 #ifndef __CONFIG_DOT_H__
 #define __CONFIG_DOT_H__
 
+#define DLM_MAX_ADDR_COUNT 3
+
 struct dlm_config_info {
 	int tcp_port;
 	int buffer_size;
@@ -27,8 +29,14 @@ struct dlm_config_info {
 
 extern struct dlm_config_info dlm_config;
 
-extern int dlm_config_init(void);
-extern void dlm_config_exit(void);
+int dlm_config_init(void);
+void dlm_config_exit(void);
+int dlm_node_weight(char *lsname, int nodeid);
+int dlm_nodeid_list(char *lsname, int **ids_out);
+int dlm_nodeid_to_addr(int nodeid, struct sockaddr_storage *addr);
+int dlm_addr_to_nodeid(struct sockaddr_storage *addr, int *nodeid);
+int dlm_our_nodeid(void);
+int dlm_our_addr(struct sockaddr_storage *addr, int num);
 
 #endif				/* __CONFIG_DOT_H__ */
 
diff -urpN a/drivers/dlm/dlm_internal.h b/drivers/dlm/dlm_internal.h
--- a/drivers/dlm/dlm_internal.h	2005-08-17 17:19:22.000000000 +0800
+++ b/drivers/dlm/dlm_internal.h	2005-08-18 13:22:00.720154024 +0800
@@ -457,8 +457,6 @@ struct dlm_ls {
 	int			ls_low_nodeid;
 	int			ls_total_weight;
 	int			*ls_node_array;
-	int			*ls_nodeids_next;
-	int			ls_nodeids_next_count;
 
 	struct dlm_rsb		ls_stub_rsb;	/* for returning errors */
 	struct dlm_lkb		ls_stub_lkb;	/* for returning errors */
diff -urpN a/drivers/dlm/lockspace.c b/drivers/dlm/lockspace.c
--- a/drivers/dlm/lockspace.c	2005-08-18 12:14:09.000000000 +0800
+++ b/drivers/dlm/lockspace.c	2005-08-18 13:22:00.721153872 +0800
@@ -94,6 +94,11 @@ static struct dlm_ls *find_lockspace_nam
 	return ls;
 }
 
+struct dlm_ls *dlm_find_lockspace_name(char *name, int namelen)
+{
+	return find_lockspace_name(name, namelen);
+}
+
 struct dlm_ls *dlm_find_lockspace_global(uint32_t id)
 {
 	struct dlm_ls *ls;
@@ -261,8 +266,6 @@ static int new_lockspace(char *name, int
 	ls->ls_low_nodeid = 0;
 	ls->ls_total_weight = 0;
 	ls->ls_node_array = NULL;
-	ls->ls_nodeids_next = NULL;
-	ls->ls_nodeids_next_count = 0;
 
 	memset(&ls->ls_stub_rsb, 0, sizeof(struct dlm_rsb));
 	ls->ls_stub_rsb.res_ls = ls;
diff -urpN a/drivers/dlm/lowcomms.c b/drivers/dlm/lowcomms.c
--- a/drivers/dlm/lowcomms.c	2005-08-17 17:19:22.000000000 +0800
+++ b/drivers/dlm/lowcomms.c	2005-08-18 13:22:00.722153720 +0800
@@ -50,29 +50,14 @@
 #include <linux/socket.h>
 #include <linux/idr.h>
 
-#include <linux/dlm_node.h>
-
 #include "dlm_internal.h"
 #include "lowcomms.h"
 #include "config.h"
-#include "member.h"
 #include "midcomms.h"
 
 static struct sockaddr_storage *local_addr[DLM_MAX_ADDR_COUNT];
-static int			local_nodeid;
-static int			local_weight;
 static int			local_count;
-static struct list_head		nodes;
-static struct semaphore		nodes_sem;
-
-/* One of these per configured node */
-
-struct dlm_node {
-	struct list_head	list;
-	int			nodeid;
-	int			weight;
-	struct sockaddr_storage	addr;
-};
+static int			local_nodeid;
 
 /* One of these per connected node */
 
@@ -163,89 +148,24 @@ static atomic_t accepting;
 static struct connection sctp_con;
 
 
-static struct dlm_node *search_node(int nodeid)
-{
-	struct dlm_node *node;
-
-	list_for_each_entry(node, &nodes, list) {
-		if (node->nodeid == nodeid)
-			goto out;
-	}
-	node = NULL;
- out:
-	return node;
-}
-
-static struct dlm_node *search_node_addr(struct sockaddr_storage *addr)
-{
-	struct dlm_node *node;
-
-	list_for_each_entry(node, &nodes, list) {
-		if (!memcmp(&node->addr, addr, sizeof(*addr)))
-			goto out;
-	}
-	node = NULL;
- out:
-	return node;
-}
-
-static int _get_node(int nodeid, struct dlm_node **node_ret)
-{
-	struct dlm_node *node;
-	int error = 0;
-
-	node = search_node(nodeid);
-	if (node)
-		goto out;
-
-	node = kmalloc(sizeof(struct dlm_node), GFP_KERNEL);
-	if (!node) {
-		error = -ENOMEM;
-		goto out;
-	}
-	memset(node, 0, sizeof(struct dlm_node));
-	node->nodeid = nodeid;
-	list_add_tail(&node->list, &nodes);
- out:
-	*node_ret = node;
-	return error;
-}
-
-static int addr_to_nodeid(struct sockaddr_storage *addr, int *nodeid)
-{
-	struct dlm_node *node;
-
-	down(&nodes_sem);
-	node = search_node_addr(addr);
-	up(&nodes_sem);
-	if (!node)
-		return -1;
-	*nodeid = node->nodeid;
-	return 0;
-}
-
 static int nodeid_to_addr(int nodeid, struct sockaddr *retaddr)
 {
-	struct dlm_node *node;
-	struct sockaddr_storage *addr;
+	struct sockaddr_storage addr;
+	int error;
 
 	if (!local_count)
 		return -1;
 
-	down(&nodes_sem);
-	node = search_node(nodeid);
-	up(&nodes_sem);
-	if (!node)
-		return -1;
-
-	addr = &node->addr;
+	error = dlm_nodeid_to_addr(nodeid, &addr);
+	if (error)
+		return error;
 
 	if (local_addr[0]->ss_family == AF_INET) {
-	        struct sockaddr_in *in4  = (struct sockaddr_in *) addr;
+	        struct sockaddr_in *in4  = (struct sockaddr_in *) &addr;
 		struct sockaddr_in *ret4 = (struct sockaddr_in *) retaddr;
 		ret4->sin_addr.s_addr = in4->sin_addr.s_addr;
 	} else {
-	        struct sockaddr_in6 *in6  = (struct sockaddr_in6 *) addr;
+	        struct sockaddr_in6 *in6  = (struct sockaddr_in6 *) &addr;
 		struct sockaddr_in6 *ret6 = (struct sockaddr_in6 *) retaddr;
 		memcpy(&ret6->sin6_addr, &in6->sin6_addr,
 		       sizeof(in6->sin6_addr));
@@ -254,67 +174,6 @@ static int nodeid_to_addr(int nodeid, st
 	return 0;
 }
 
-int dlm_node_weight(int nodeid)
-{
-	struct dlm_node *node;
-	int weight = -1;
-
-	down(&nodes_sem);
-	node = search_node(nodeid);
-	if (node)
-		weight = node->weight;
-	up(&nodes_sem);
-	return weight;
-}
-
-int dlm_set_node(int nodeid, int weight, char *addr_buf)
-{
-	struct dlm_node *node;
-	int error;
-
-	down(&nodes_sem);
-	error = _get_node(nodeid, &node);
-	if (!error) {
-		memcpy(&node->addr, addr_buf, sizeof(struct sockaddr_storage));
-		node->weight = weight;
-	}
-	up(&nodes_sem);
-	return error;
-}
-
-int dlm_set_local(int nodeid, int weight, char *addr_buf)
-{
-	struct sockaddr_storage *addr;
-	int i;
-
-	if (local_count > DLM_MAX_ADDR_COUNT - 1) {
-		log_print("too many local addresses set %d", local_count);
-		return -EINVAL;
-	}
-	local_nodeid = nodeid;
-	local_weight = weight;
-
-	addr = kmalloc(sizeof(*addr), GFP_KERNEL);
-	if (!addr)
-		return -ENOMEM;
-	memcpy(addr, addr_buf, sizeof(*addr));
-
-	for (i = 0; i < local_count; i++) {
-		if (!memcmp(local_addr[i], addr, sizeof(*addr))) {
-			kfree(addr);
-			goto out;
-		}
-	}
-	local_addr[local_count++] = addr;
- out:
-	return 0;
-}
-
-int dlm_our_nodeid(void)
-{
-	return local_nodeid;
-}
-
 static struct nodeinfo *nodeid2nodeinfo(int nodeid, int alloc)
 {
 	struct nodeinfo *ni;
@@ -556,7 +415,7 @@ static void process_sctp_notification(st
 				return;
 			}
 			make_sockaddr(&prim.ssp_addr, 0, &addr_len);
-			if (addr_to_nodeid(&prim.ssp_addr, &nodeid)) {
+			if (dlm_addr_to_nodeid(&prim.ssp_addr, &nodeid)) {
 				log_print("reject connect from unknown addr");
 				send_shutdown(prim.ssp_assoc_id);
 				return;
@@ -772,6 +631,24 @@ static int add_bind_addr(struct sockaddr
 	return result;
 }
 
+static void init_local(void)
+{
+	struct sockaddr_storage sas, *addr;
+	int i;
+
+	local_nodeid = dlm_our_nodeid();
+
+	for (i = 0; i < DLM_MAX_ADDR_COUNT - 1; i++) {
+		if (dlm_our_addr(&sas, i))
+			break;
+
+		addr = kmalloc(sizeof(*addr), GFP_KERNEL);
+		if (!addr)
+			break;
+		memcpy(addr, &sas, sizeof(*addr));
+		local_addr[local_count++] = addr;
+	}
+}
 
 /* Initialise SCTP socket and bind to all interfaces */
 static int init_sock(void)
@@ -783,8 +660,11 @@ static int init_sock(void)
 	int result = -EINVAL, num = 1, i, addr_len;
 
 	if (!local_count) {
-		log_print("no local IP address has been set");
-		goto out;
+		init_local();
+		if (!local_count) {
+			log_print("no local IP address has been set");
+			goto out;
+		}
 	}
 
 	result = sock_create_kern(local_addr[0]->ss_family, SOCK_SEQPACKET,
@@ -1323,25 +1203,16 @@ void dlm_lowcomms_stop(void)
 int dlm_lowcomms_init(void)
 {
 	init_waitqueue_head(&lowcomms_recv_wait);
-	INIT_LIST_HEAD(&nodes);
-	init_MUTEX(&nodes_sem);
 	return 0;
 }
 
 void dlm_lowcomms_exit(void)
 {
-	struct dlm_node *node, *safe;
 	int i;
 
 	for (i = 0; i < local_count; i++)
 		kfree(local_addr[i]);
-	local_nodeid = 0;
-	local_weight = 0;
 	local_count = 0;
-
-	list_for_each_entry_safe(node, safe, &nodes, list) {
-		list_del(&node->list);
-		kfree(node);
-	}
+	local_nodeid = 0;
 }
 
diff -urpN a/drivers/dlm/lowcomms.h b/drivers/dlm/lowcomms.h
--- a/drivers/dlm/lowcomms.h	2005-08-17 17:19:22.000000000 +0800
+++ b/drivers/dlm/lowcomms.h	2005-08-18 13:22:00.722153720 +0800
@@ -20,10 +20,6 @@ int dlm_lowcomms_start(void);
 void dlm_lowcomms_stop(void);
 void *dlm_lowcomms_get_buffer(int nodeid, int len, int allocation, char **ppc);
 void dlm_lowcomms_commit_buffer(void *mh);
-int dlm_set_node(int nodeid, int weight, char *addr_buf);
-int dlm_set_local(int nodeid, int weight, char *addr_buf);
-int dlm_our_nodeid(void);
-int dlm_node_weight(int nodeid);
 
 #endif				/* __LOWCOMMS_DOT_H__ */
 
diff -urpN a/drivers/dlm/main.c b/drivers/dlm/main.c
--- a/drivers/dlm/main.c	2005-08-17 17:19:22.000000000 +0800
+++ b/drivers/dlm/main.c	2005-08-18 13:22:00.723153568 +0800
@@ -18,6 +18,7 @@
 #include "device.h"
 #include "memory.h"
 #include "lowcomms.h"
+#include "config.h"
 
 #ifdef CONFIG_DLM_DEBUG
 int dlm_register_debugfs(void);
@@ -27,9 +28,6 @@ static inline int dlm_register_debugfs(v
 static inline void dlm_unregister_debugfs(void) { }
 #endif
 
-int dlm_node_ioctl_init(void);
-void dlm_node_ioctl_exit(void);
-
 static int __init init_dlm(void)
 {
 	int error;
@@ -42,17 +40,17 @@ static int __init init_dlm(void)
 	if (error)
 		goto out_mem;
 
-	error = dlm_node_ioctl_init();
+	error = dlm_member_sysfs_init();
 	if (error)
 		goto out_mem;
 
-	error = dlm_member_sysfs_init();
+	error = dlm_config_init();
 	if (error)
-		goto out_node;
+		goto out_member;
 
 	error = dlm_register_debugfs();
 	if (error)
-		goto out_member;
+		goto out_config;
 
 	error = dlm_lowcomms_init();
 	if (error)
@@ -64,10 +62,10 @@ static int __init init_dlm(void)
 
  out_debug:
 	dlm_unregister_debugfs();
+ out_config:
+	dlm_config_exit();
  out_member:
 	dlm_member_sysfs_exit();
- out_node:
-	dlm_node_ioctl_exit();
  out_mem:
 	dlm_memory_exit();
  out:
@@ -78,7 +76,7 @@ static void __exit exit_dlm(void)
 {
 	dlm_lowcomms_exit();
 	dlm_member_sysfs_exit();
-	dlm_node_ioctl_exit();
+	dlm_config_exit();
 	dlm_memory_exit();
 	dlm_unregister_debugfs();
 }
diff -urpN a/drivers/dlm/member.c b/drivers/dlm/member.c
--- a/drivers/dlm/member.c	2005-08-17 17:19:22.000000000 +0800
+++ b/drivers/dlm/member.c	2005-08-18 13:22:00.724153416 +0800
@@ -11,13 +11,13 @@
 ******************************************************************************/
 
 #include "dlm_internal.h"
-#include "member_sysfs.h"
 #include "lockspace.h"
 #include "member.h"
 #include "recoverd.h"
 #include "recover.h"
 #include "lowcomms.h"
 #include "rcom.h"
+#include "config.h"
 
 /*
  * Following called by dlm_recoverd thread
@@ -50,13 +50,18 @@ static void add_ordered_member(struct dl
 static int dlm_add_member(struct dlm_ls *ls, int nodeid)
 {
 	struct dlm_member *memb;
+	int w;
 
 	memb = kmalloc(sizeof(struct dlm_member), GFP_KERNEL);
 	if (!memb)
 		return -ENOMEM;
 
+	w = dlm_node_weight(ls->ls_name, nodeid);
+	if (w < 0)
+		return w;
+
 	memb->nodeid = nodeid;
-	memb->weight = dlm_node_weight(nodeid);
+	memb->weight = w;
 	add_ordered_member(ls, memb);
 	ls->ls_num_nodes++;
 	return 0;
@@ -262,14 +267,19 @@ int dlm_ls_stop(struct dlm_ls *ls)
 
 int dlm_ls_start(struct dlm_ls *ls)
 {
-	struct dlm_recover *rv, *rv_old;
-	int error = 0;
+	struct dlm_recover *rv = NULL, *rv_old;
+	int *ids = NULL;
+	int error, count;
 
 	rv = kmalloc(sizeof(struct dlm_recover), GFP_KERNEL);
 	if (!rv)
 		return -ENOMEM;
 	memset(rv, 0, sizeof(struct dlm_recover));
 
+	error = count = dlm_nodeid_list(ls->ls_name, &ids);
+	if (error <= 0)
+		goto fail;
+
 	spin_lock(&ls->ls_recover_lock);
 
 	/* the lockspace needs to be stopped before it can be started */
@@ -277,22 +287,12 @@ int dlm_ls_start(struct dlm_ls *ls)
 	if (!dlm_locking_stopped(ls)) {
 		spin_unlock(&ls->ls_recover_lock);
 		log_error(ls, "start ignored: lockspace running");
-		kfree(rv);
-		error = -EINVAL;
-		goto out;
-	}
-
-	if (!ls->ls_nodeids_next) {
-		spin_unlock(&ls->ls_recover_lock);
-		log_error(ls, "start ignored: existing nodeids_next");
-		kfree(rv);
 		error = -EINVAL;
-		goto out;
+		goto fail;
 	}
 
-	rv->nodeids = ls->ls_nodeids_next;
-	ls->ls_nodeids_next = NULL;
-	rv->node_count = ls->ls_nodeids_next_count;
+	rv->nodeids = ids;
+	rv->node_count = count;
 	rv->seq = ++ls->ls_recover_seq;
 	rv_old = ls->ls_recover_args;
 	ls->ls_recover_args = rv;
@@ -304,7 +304,11 @@ int dlm_ls_start(struct dlm_ls *ls)
 	}
 
 	dlm_recoverd_kick(ls);
- out:
+	return 0;
+
+ fail:
+	kfree(rv);
+	kfree(ids);
 	return error;
 }
 
diff -urpN a/drivers/dlm/member_sysfs.c b/drivers/dlm/member_sysfs.c
--- a/drivers/dlm/member_sysfs.c	2005-08-17 17:19:22.000000000 +0800
+++ b/drivers/dlm/member_sysfs.c	2005-08-18 13:22:00.724153416 +0800
@@ -47,77 +47,10 @@ static ssize_t dlm_id_show(struct dlm_ls
 
 static ssize_t dlm_id_store(struct dlm_ls *ls, const char *buf, size_t len)
 {
-	ls->ls_global_id = simple_strtol(buf, NULL, 0);
+	ls->ls_global_id = simple_strtoul(buf, NULL, 0);
 	return len;
 }
 
-static ssize_t dlm_members_show(struct dlm_ls *ls, char *buf)
-{
-	struct dlm_member *memb;
-	ssize_t ret = 0;
-
-	if (!down_read_trylock(&ls->ls_in_recovery))
-		return -EBUSY;
-	list_for_each_entry(memb, &ls->ls_nodes, list)
-		ret += sprintf(buf+ret, "%u ", memb->nodeid);
-	ret += sprintf(buf+ret, "\n");
-	up_read(&ls->ls_in_recovery);
-	return ret;
-}
-
-static ssize_t dlm_members_store(struct dlm_ls *ls, const char *buf, size_t len)
-{
-	int *nodeids, id, count = 1, i;
-	ssize_t ret = len;
-	char *p, *t;
-
-	/* count number of id's in buf, assumes no trailing spaces */
-	for (i = 0; i < len; i++)
-		if (isspace(buf[i]))
-			count++;
-
-	nodeids = kmalloc(sizeof(int) * count, GFP_KERNEL);
-	if (!nodeids)
-		return -ENOMEM;
-
-	p = kmalloc(len+1, GFP_KERNEL);
-	if (!p) {
-		kfree(nodeids);
-		return -ENOMEM;
-	}
-	memcpy(p, buf, len);
-	p[len+1] = '\0';
-
-	for (i = 0; i < count; i++) {
-		if ((t = strsep(&p, " ")) == NULL)
-			break;
-		if (sscanf(t, "%u", &id) != 1)
-			break;
-		nodeids[i] = id;
-	}
-
-	if (i != count) {
-		kfree(nodeids);
-		ret = -EINVAL;
-		goto out;
-	}
-
-	spin_lock(&ls->ls_recover_lock);
-	if (ls->ls_nodeids_next) {
-		kfree(nodeids);
-		ret = -EINVAL;
-		goto out_unlock;
-	}
-	ls->ls_nodeids_next = nodeids;
-	ls->ls_nodeids_next_count = count;
-
- out_unlock:
-	spin_unlock(&ls->ls_recover_lock);
- out:
-	kfree(p);
-	return ret;
-}
-
 struct dlm_attr {
 	struct attribute attr;
 	ssize_t (*show)(struct dlm_ls *, char *);
@@ -140,17 +73,10 @@ static struct dlm_attr dlm_attr_id = {
 	.store = dlm_id_store
 };
 
-static struct dlm_attr dlm_attr_members = {
-	.attr  = {.name = "members", .mode = S_IRUGO | S_IWUSR},
-	.show  = dlm_members_show,
-	.store = dlm_members_store
-};
-
 static struct attribute *dlm_attrs[] = {
 	&dlm_attr_control.attr,
 	&dlm_attr_event.attr,
 	&dlm_attr_id.attr,
-	&dlm_attr_members.attr,
 	NULL,
 };
 
diff -urpN a/drivers/dlm/node_ioctl.c b/drivers/dlm/node_ioctl.c
--- a/drivers/dlm/node_ioctl.c	2005-08-17 17:19:22.000000000 +0800
+++ b/drivers/dlm/node_ioctl.c	1970-01-01 07:30:00.000000000 +0730
@@ -1,126 +0,0 @@
-/******************************************************************************
-*******************************************************************************
-**
-**  Copyright (C) 2005 Red Hat, Inc.  All rights reserved.
-**
-**  This copyrighted material is made available to anyone wishing to use,
-**  modify, copy, or redistribute it subject to the terms and conditions
-**  of the GNU General Public License v.2.
-**
-*******************************************************************************
-******************************************************************************/
-
-#include <linux/miscdevice.h>
-#include <linux/fs.h>
-
-#include <linux/dlm_node.h>
-
-#include "dlm_internal.h"
-#include "lowcomms.h"
-
-
-static int check_version(unsigned int cmd,
-			 struct dlm_node_ioctl __user *u_param)
-{
-	u32 version[3];
-	int error = 0;
-
-	if (copy_from_user(version, u_param->version, sizeof(version)))
-		return -EFAULT;
-
-	if ((DLM_NODE_VERSION_MAJOR != version[0]) ||
-	    (DLM_NODE_VERSION_MINOR < version[1])) {
-		log_print("node_ioctl: interface mismatch: "
-		          "kernel(%u.%u.%u), user(%u.%u.%u), cmd(%d)",
-		          DLM_NODE_VERSION_MAJOR,
-		          DLM_NODE_VERSION_MINOR,
-		          DLM_NODE_VERSION_PATCH,
-		          version[0], version[1], version[2], cmd);
-		error = -EINVAL;
-	}
-
-	version[0] = DLM_NODE_VERSION_MAJOR;
-	version[1] = DLM_NODE_VERSION_MINOR;
-	version[2] = DLM_NODE_VERSION_PATCH;
-
-	if (copy_to_user(u_param->version, version, sizeof(version)))
-		return -EFAULT;
-	return error;
-}
-
-static int node_ioctl(struct inode *inode, struct file *file,
-	              uint command, ulong u)
-{
-	struct dlm_node_ioctl *k_param;
-	struct dlm_node_ioctl __user *u_param;
-	unsigned int cmd, type;
-	int error;
-
-	u_param = (struct dlm_node_ioctl __user *) u;
-
-	if (!capable(CAP_SYS_ADMIN))
-		return -EACCES;
-
-	type = _IOC_TYPE(command);
-	cmd = _IOC_NR(command);
-
-	if (type != DLM_IOCTL) {
-		log_print("node_ioctl: bad ioctl 0x%x 0x%x 0x%x",
-		          command, type, cmd);
-		return -ENOTTY;
-	}
-
-	error = check_version(cmd, u_param);
-	if (error)
-		return error;
-
-	if (cmd == DLM_NODE_VERSION_CMD)
-		return 0;
-
-	k_param = kmalloc(sizeof(*k_param), GFP_KERNEL);
-	if (!k_param)
-		return -ENOMEM;
-
-	if (copy_from_user(k_param, u_param, sizeof(*k_param))) {
-		kfree(k_param);
-		return -EFAULT;
-	}
-
-	if (cmd == DLM_SET_NODE_CMD)
-		error = dlm_set_node(k_param->nodeid, k_param->weight,
-				     k_param->addr);
-	else if (cmd == DLM_SET_LOCAL_CMD)
-		error = dlm_set_local(k_param->nodeid, k_param->weight,
-				      k_param->addr);
-
-	kfree(k_param);
-	return error;
-}
-
-static struct file_operations node_fops = {
-	.ioctl	= node_ioctl,
-	.owner	= THIS_MODULE,
-};
-
-static struct miscdevice node_misc = {
-	.minor	= MISC_DYNAMIC_MINOR,
-	.name	= DLM_NODE_MISC_NAME,
-	.fops	= &node_fops
-};
-
-int dlm_node_ioctl_init(void)
-{
-	int error;
-
-	error = misc_register(&node_misc);
-	if (error)
-		log_print("node_ioctl: misc_register failed %d", error);
-	return error;
-}
-
-void dlm_node_ioctl_exit(void)
-{
-	if (misc_deregister(&node_misc) < 0)
-		log_print("node_ioctl: misc_deregister failed");
-}
-
diff -urpN a/drivers/dlm/requestqueue.c b/drivers/dlm/requestqueue.c
--- a/drivers/dlm/requestqueue.c	2005-08-17 17:19:22.000000000 +0800
+++ b/drivers/dlm/requestqueue.c	2005-08-18 13:22:00.725153264 +0800
@@ -14,7 +14,7 @@
 #include "member.h"
 #include "lock.h"
 #include "dir.h"
-#include "lowcomms.h"
+#include "config.h"
 
 struct rq_entry {
 	struct list_head list;
diff -urpN a/include/linux/dlm_node.h b/include/linux/dlm_node.h
--- a/include/linux/dlm_node.h	2005-08-17 17:19:23.000000000 +0800
+++ b/include/linux/dlm_node.h	1970-01-01 07:30:00.000000000 +0730
@@ -1,44 +0,0 @@
-/******************************************************************************
-*******************************************************************************
-**
-**  Copyright (C) 2005 Red Hat, Inc.  All rights reserved.
-**
-**  This copyrighted material is made available to anyone wishing to use,
-**  modify, copy, or redistribute it subject to the terms and conditions
-**  of the GNU General Public License v.2.
-**
-*******************************************************************************
-******************************************************************************/
-
-#ifndef __DLM_NODE_DOT_H__
-#define __DLM_NODE_DOT_H__
-
-#define DLM_ADDR_LEN			256
-#define DLM_MAX_ADDR_COUNT		3
-#define DLM_NODE_MISC_NAME		"dlm-node"
-
-#define DLM_NODE_VERSION_MAJOR		1
-#define DLM_NODE_VERSION_MINOR		0
-#define DLM_NODE_VERSION_PATCH		0
-
-struct dlm_node_ioctl {
-	__u32	version[3];
-	int	nodeid;
-	int	weight;
-	char	addr[DLM_ADDR_LEN];
-};
-
-enum {
-	DLM_NODE_VERSION_CMD = 0,
-	DLM_SET_NODE_CMD,
-	DLM_SET_LOCAL_CMD,
-};
-
-#define DLM_IOCTL			0xd1
-
-#define DLM_NODE_VERSION _IOWR(DLM_IOCTL, DLM_NODE_VERSION_CMD, struct dlm_node_ioctl)
-#define DLM_SET_NODE     _IOWR(DLM_IOCTL, DLM_SET_NODE_CMD, struct dlm_node_ioctl)
-#define DLM_SET_LOCAL    _IOWR(DLM_IOCTL, DLM_SET_LOCAL_CMD, struct dlm_node_ioctl)
-
-#endif
-
