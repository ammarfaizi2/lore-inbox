Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263956AbSJJURm>; Thu, 10 Oct 2002 16:17:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263906AbSJJUQF>; Thu, 10 Oct 2002 16:16:05 -0400
Received: from mg03.austin.ibm.com ([192.35.232.20]:23519 "EHLO
	mg03.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S262220AbSJJUFe>; Thu, 10 Oct 2002 16:05:34 -0400
Content-Type: text/plain; charset=US-ASCII
From: Kevin Corry <corryk@us.ibm.com>
Organization: IBM
To: torvalds@transmeta.com
Subject: [PATCH] EVMS core (4/9) passthru.c
Date: Thu, 10 Oct 2002 14:37:14 -0500
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org, evms-devel@lists.sourceforge.net
References: <02101014305502.17770@boiler>
In-Reply-To: <02101014305502.17770@boiler>
MIME-Version: 1.0
Message-Id: <02101014371406.17770@boiler>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

Part 4 of the EVMS core driver.

This file provides the Passthru pseudo-plugin, which simply recognizes
EVMS volume labels. It is always bound to the core driver instead of
being a full, separate plugin.

Kevin Corry
corryk@us.ibm.com
http://evms.sourceforge.net/



diff -Naur linux-2.5.41/drivers/evms/core/passthru.c linux-2.5.41-evms/drivers/evms/core/passthru.c
--- linux-2.5.41/drivers/evms/core/passthru.c	Wed Dec 31 18:00:00 1969
+++ linux-2.5.41-evms/drivers/evms/core/passthru.c	Thu Oct 10 11:16:58 2002
@@ -0,0 +1,373 @@
+/*
+ *   Copyright (c) International Business Machines  Corp., 2000
+ *
+ *   This program is free software;  you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ *   the GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program;  if not, write to the Free Software
+ *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+/*
+ * EVMS Volume Passthru Manager
+ *
+ * Passthru is a "special" EVMS plugin. It provides all of the services that
+ * a regular plugin provides (volume discovery/delete, I/O and ioctl handling)
+ * but it must always be loaded with the core. Thus, this plugin is not built
+ * as a separate kernel module (like the regular plugins). Instead, it is bound
+ * to the EVMS core module. It also does not have a module_init() or
+ * module_exit(). Instead, the EVMS core will call Passthru's init/exit
+ * functions manually when the core is loaded/unloaded. Also, since it is not a
+ * separate module, it will not do increments/decrements on the module reference
+ * count.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/config.h>
+#include <linux/bio.h>
+#include <linux/evms.h>
+
+#define LOG_PREFIX "passthru: "
+#define EVMS_PASSTHRU_ID 0
+
+static int passthru_discover(struct list_head *);
+static int passthru_delete(struct evms_logical_node *);
+static void passthru_submit_io(struct evms_logical_node *, struct bio *);
+static int passthru_ioctl(struct evms_logical_node *, struct inode *, 
+			  struct file *, unsigned int, unsigned long);
+static int passthru_init_io(struct evms_logical_node *, int, u64, u64, 
+			    void *);
+static int passthru_open(struct evms_logical_node *, struct inode *, 
+			 struct file *);
+static int passthru_release(struct evms_logical_node *, struct inode *, 
+			    struct file *);
+static int passthru_check_media_change(struct evms_logical_node *, kdev_t);
+static int passthru_revalidate(struct evms_logical_node *, kdev_t);
+static int passthru_quiesce(struct evms_logical_node *, int);
+static int passthru_get_geo(struct evms_logical_node *, u64 *, uint *, 
+			    uint *, u64 *);
+static int passthru_device_list(struct evms_logical_node *, 
+				struct list_head *);
+static int passthru_device_status(struct evms_logical_node *, int *);
+
+static struct evms_plugin_fops fops = {
+	.discover	= passthru_discover,
+	.delete		= passthru_delete,
+	.submit_io	= passthru_submit_io,
+	.sync_io	= passthru_init_io,
+	.ioctl		= passthru_ioctl,
+	.open		= passthru_open,
+	.release	= passthru_release,
+	.check_media_change = passthru_check_media_change,
+	.revalidate	= passthru_revalidate,
+	.quiesce	= passthru_quiesce,
+	.get_geo	= passthru_get_geo,
+	.device_list	= passthru_device_list,
+	.device_status	= passthru_device_status
+};
+
+static struct evms_plugin_header plugin_header = {
+	.id = SetPluginID(IBM_OEM_ID,
+			  EVMS_FEATURE,
+			  EVMS_PASSTHRU_ID),
+	.version = {
+		.major		= 1,
+		.minor		= 1,
+		.patchlevel	= 1
+	},
+	.fops = &fops
+};
+
+/*******************************/
+/* Discovery support functions */
+/*******************************/
+
+static int
+process_passthru_data(struct evms_logical_node **pp)
+{
+	int rc, size_in_sectors;
+	struct evms_logical_node *node, *new_node;
+
+	node = *pp;
+
+	size_in_sectors =
+	    evms_cs_size_in_vsectors(sizeof (struct evms_feature_header));
+
+	/* allocate "parent" node */
+	rc = evms_cs_allocate_logical_node(&new_node);
+	if (rc) {
+		/* on any fatal error, delete the node */
+		int rc2 = DELETE(node);
+		if (rc2) {
+			LOG_DEFAULT("error(%d) attempting to delete node(%s)\n",
+				    rc2, node->name);
+		}
+		return rc;
+	}
+	/* initialize "parent" node */
+	new_node->private = node;
+	new_node->flags = node->flags;
+	new_node->plugin = &plugin_header;
+	new_node->system_id = node->system_id;
+	new_node->block_size = node->block_size;
+	new_node->hardsector_size = node->hardsector_size;
+	new_node->total_vsectors = node->total_vsectors;
+	new_node->total_vsectors -= (size_in_sectors << 1) +
+				     node->feature_header->alignment_padding;
+	new_node->volume_info = node->volume_info;
+	strcpy(new_node->name, node->name);
+	if (strlen(node->feature_header->object_name))
+		strcat(new_node->name,
+		       node->feature_header->object_name);
+	else
+		strcat(new_node->name, "_Passthru");
+        /* return "parent" node to caller */
+	*pp = new_node;
+
+	LOG_DETAILS("feature header found on '%s', created '%s'.\n",
+		    node->name, new_node->name);
+	/* we're done with the passthru feature headers
+	 * so lets delete them now.
+	 */
+	kfree(node->feature_header);
+	node->feature_header = NULL;
+	return 0;
+}
+
+/********** Required Plugin Functions **********/
+
+/**
+ * passthru_discover
+ **/
+static int
+passthru_discover(struct list_head *discover_list)
+{
+	struct evms_logical_node *node, *next_node;
+	struct list_head tmp_list_head;
+
+	INIT_LIST_HEAD(&tmp_list_head);
+	list_splice_init(discover_list, &tmp_list_head);
+	list_for_each_entry_safe(node, next_node, &tmp_list_head, discover) {
+		list_del_init(&node->discover);
+		if (!process_passthru_data(&node)) {
+			if (node) {
+				list_add_tail(&node->discover, discover_list);
+			}
+		}
+	}
+	return 0;
+}
+
+/**
+ * passthru_delete
+ **/
+static int
+passthru_delete(struct evms_logical_node *node)
+{
+	int rc;
+	struct evms_logical_node *p;
+
+	LOG_DETAILS("deleting '%s'.\n", node->name);
+
+	p = node->private;
+	rc = DELETE(p);
+	if (!rc) {
+		evms_cs_deallocate_logical_node(node);
+	} else {
+		LOG_DEFAULT("error(%d) attempting to delete node(%s).\n",
+			    rc, node->name);
+	}
+	return rc;
+}
+
+/**
+ * passthru_submit_io
+ **/
+static void
+passthru_submit_io(struct evms_logical_node *node, struct bio *bio)
+{
+	if (bio->bi_sector + bio_sectors(bio) <= node->total_vsectors) {
+		SUBMIT_IO((struct evms_logical_node *) (node->private), bio);
+	} else {
+		LOG_SERIOUS("I/O request on (%s) at rsector ("PFU64") "
+			    "beyond boundary ("PFU64").\n",
+			    node->name, node->total_vsectors - 1,
+			    (u64) bio->bi_sector);
+		bio_io_error(bio, bio->bi_size);
+	}
+}
+
+/**
+ * passthru_ioctl
+ **/
+static int
+passthru_ioctl(struct evms_logical_node *node, struct inode *inode,
+		   struct file *file, unsigned int cmd, unsigned long arg)
+{
+	return IOCTL(((struct evms_logical_node *) (node->private)),
+		     inode, file, cmd, arg);
+}
+
+/**
+ * passthru_init_io
+ **/
+static int
+passthru_init_io(struct evms_logical_node *node, int rw,
+		     u64 sect_nr, u64 num_sects, void *buf_addr)
+{
+	if (sect_nr + num_sects > node->total_vsectors) {
+		return -EINVAL;
+	}
+
+	return INIT_IO(((struct evms_logical_node *) (node->private)),
+			rw, sect_nr, num_sects, buf_addr);
+}
+
+/**
+ * passthru_open - route operation to node
+ * @node:	target node
+ * @inode:     	VFS required parameter
+ * @file:     	VFS required parameter
+ *
+ * returns:
+ *	0 on success
+ *	error code otherwise
+ */
+static int
+passthru_open(struct evms_logical_node *node,
+	       struct inode *inode, struct file *file)
+{
+	return OPEN((struct evms_logical_node *)node->private, inode, file);
+}
+
+/**
+ * passthru_release - route operation to node
+ * @node:	target node
+ * @inode:     	VFS required parameter
+ * @file:     	VFS required parameter
+ *
+ * returns:
+ *	0 on success
+ *	error code otherwise
+ */
+static int
+passthru_release(struct evms_logical_node *node,
+	       struct inode *inode, struct file *file)
+{
+	return CLOSE((struct evms_logical_node *)node->private, inode, file);
+}
+
+/**
+ * passthru_check_media_change - route operation to node
+ * @node:	target node
+ * @dev:       	VFS required parameter
+ *
+ * returns:
+ *	0 on no change detected,
+ *	1 on change detected,
+ *	error code otherwise
+ */
+static int
+passthru_check_media_change(struct evms_logical_node *node, kdev_t dev)
+{
+	return CHECK_MEDIA_CHANGE((struct evms_logical_node *)node->private, dev);
+}
+
+/**
+ * passthru_revalidate - route operation to node
+ * @node:	target node
+ * @dev:       	VFS required parameter
+ *
+ * returns:
+ *	0 on success
+ *	error code otherwise
+ */
+static int
+passthru_revalidate(struct evms_logical_node *node, kdev_t dev)
+{
+	return REVALIDATE((struct evms_logical_node *)node->private, dev);
+}
+
+/**
+ * passthru_quiesce - route operation to node
+ * @node:	target node
+ * @dev:       	VFS required parameter
+ *
+ * returns:
+ *	0 on success
+ *	error code otherwise
+ */
+static int
+passthru_quiesce(struct evms_logical_node *node, int command)
+{
+	return QUIESCE((struct evms_logical_node *)node->private, command);
+}
+
+/**
+ * passthru_get_geo - route operation to node
+ * @node:	target node
+ * @dev:       	VFS required parameter
+ *
+ * returns:
+ *	0 on success
+ *	error code otherwise
+ */
+static int
+passthru_get_geo(struct evms_logical_node *node, u64 *cylinders,
+		    uint *heads, uint *sects, u64 *start)
+{
+	return GET_GEO((struct evms_logical_node *)node->private, 
+			cylinders, heads, sects, start);
+}
+
+/**
+ * passthru_device_list - route operation to node
+ * @node:	target node
+ * @dev:       	VFS required parameter
+ *
+ * returns:
+ *	0 on success
+ *	error code otherwise
+ */
+static int
+passthru_device_list(struct evms_logical_node *node, struct list_head *list)
+{
+	return DEVICE_LIST((struct evms_logical_node *)node->private, list);
+}
+
+/**
+ * passthru_device_status - route operation to node
+ * @node:	target node
+ * @dev:       	VFS required parameter
+ *
+ * returns:
+ *	0 on success
+ *	error code otherwise
+ */
+static int
+passthru_device_status(struct evms_logical_node *node, int *status)
+{
+	return DEVICE_STATUS((struct evms_logical_node *)node->private, 
+			     status);
+}
+
+int
+evms_passthru_init(void)
+{
+	return evms_cs_register_plugin(&plugin_header);
+}
+
+void
+evms_passthru_exit(void)
+{
+	evms_cs_unregister_plugin(&plugin_header);
+}
+
