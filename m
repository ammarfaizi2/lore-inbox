Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965027AbVIABdJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965027AbVIABdJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 21:33:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965056AbVIABct
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 21:32:49 -0400
Received: from ozlabs.org ([203.10.76.45]:12432 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S965027AbVIAB3Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 21:29:25 -0400
To: <jgarzik@pobox.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
       <linuxppc64-dev@ozlabs.org>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 14/18] iseries_veth: Add sysfs support for connection structs
In-Reply-To: <1125538127.859382.875909607846.qpush@concordia>
Message-Id: <20050901012920.5D74D68231@ozlabs.org>
Date: Thu,  1 Sep 2005 11:29:20 +1000 (EST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

To aid in field debugging, add sysfs support for iseries_veth's connection
structures. At the moment this is all read-only, however we could think about
adding write support for some attributes in future.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 drivers/net/iseries_veth.c |   94 +++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 90 insertions(+), 4 deletions(-)

Index: veth-dev2/drivers/net/iseries_veth.c
===================================================================
--- veth-dev2.orig/drivers/net/iseries_veth.c
+++ veth-dev2/drivers/net/iseries_veth.c
@@ -182,10 +182,6 @@ static void veth_release_connection(stru
 static void veth_timed_ack(unsigned long ptr);
 static void veth_timed_reset(unsigned long ptr);
 
-static struct kobj_type veth_lpar_connection_ktype = {
-	.release	= veth_release_connection
-};
-
 /*
  * Utility functions
  */
@@ -280,6 +276,81 @@ static int veth_allocate_events(HvLpInde
 }
 
 /*
+ * sysfs support
+ */
+
+struct veth_cnx_attribute {
+	struct attribute attr;
+	ssize_t (*show)(struct veth_lpar_connection *, char *buf);
+	ssize_t (*store)(struct veth_lpar_connection *, const char *buf);
+};
+
+static ssize_t veth_cnx_attribute_show(struct kobject *kobj,
+		struct attribute *attr, char *buf)
+{
+	struct veth_cnx_attribute *cnx_attr;
+	struct veth_lpar_connection *cnx;
+
+	cnx_attr = container_of(attr, struct veth_cnx_attribute, attr);
+	cnx = container_of(kobj, struct veth_lpar_connection, kobject);
+
+	if (!cnx_attr->show)
+		return -EIO;
+
+	return cnx_attr->show(cnx, buf);
+}
+
+#define CUSTOM_CNX_ATTR(_name, _format, _expression)			\
+static ssize_t _name##_show(struct veth_lpar_connection *cnx, char *buf)\
+{									\
+	return sprintf(buf, _format, _expression);			\
+}									\
+struct veth_cnx_attribute veth_cnx_attr_##_name = __ATTR_RO(_name)
+
+#define SIMPLE_CNX_ATTR(_name)	\
+	CUSTOM_CNX_ATTR(_name, "%lu\n", (unsigned long)cnx->_name)
+
+SIMPLE_CNX_ATTR(outstanding_tx);
+SIMPLE_CNX_ATTR(remote_lp);
+SIMPLE_CNX_ATTR(num_events);
+SIMPLE_CNX_ATTR(src_inst);
+SIMPLE_CNX_ATTR(dst_inst);
+SIMPLE_CNX_ATTR(num_pending_acks);
+SIMPLE_CNX_ATTR(num_ack_events);
+CUSTOM_CNX_ATTR(ack_timeout, "%d\n", jiffies_to_msecs(cnx->ack_timeout));
+CUSTOM_CNX_ATTR(reset_timeout, "%d\n", jiffies_to_msecs(cnx->reset_timeout));
+CUSTOM_CNX_ATTR(state, "0x%.4lX\n", cnx->state);
+CUSTOM_CNX_ATTR(last_contact, "%d\n", cnx->last_contact ?
+		jiffies_to_msecs(jiffies - cnx->last_contact) : 0);
+
+#define GET_CNX_ATTR(_name)	(&veth_cnx_attr_##_name.attr)
+
+static struct attribute *veth_cnx_default_attrs[] = {
+	GET_CNX_ATTR(outstanding_tx),
+	GET_CNX_ATTR(remote_lp),
+	GET_CNX_ATTR(num_events),
+	GET_CNX_ATTR(reset_timeout),
+	GET_CNX_ATTR(last_contact),
+	GET_CNX_ATTR(state),
+	GET_CNX_ATTR(src_inst),
+	GET_CNX_ATTR(dst_inst),
+	GET_CNX_ATTR(num_pending_acks),
+	GET_CNX_ATTR(num_ack_events),
+	GET_CNX_ATTR(ack_timeout),
+	NULL
+};
+
+static struct sysfs_ops veth_cnx_sysfs_ops = {
+		.show = veth_cnx_attribute_show
+};
+
+static struct kobj_type veth_lpar_connection_ktype = {
+	.release	= veth_release_connection,
+	.sysfs_ops	= &veth_cnx_sysfs_ops,
+	.default_attrs	= veth_cnx_default_attrs
+};
+
+/*
  * LPAR connection code
  */
 
@@ -1493,6 +1564,8 @@ void __exit veth_module_cleanup(void)
 		if (!cnx)
 			continue;
 
+		/* Remove the connection from sysfs */
+		kobject_del(&cnx->kobject);
 		/* Drop the driver's reference to the connection */
 		kobject_put(&cnx->kobject);
 	}
@@ -1523,6 +1596,19 @@ int __init veth_module_init(void)
 	if (rc != 0)
 		goto error;
 
+	for (i = 0; i < HVMAXARCHITECTEDLPS; ++i) {
+		struct kobject *kobj;
+
+		if (!veth_cnx[i])
+			continue;
+
+		kobj = &veth_cnx[i]->kobject;
+		kobj->parent = &veth_driver.driver.kobj;
+		/* If the add failes, complain but otherwise continue */
+		if (0 != kobject_add(kobj))
+			veth_error("cnx %d: Failed adding to sysfs.\n", i);
+	}
+
 	return 0;
 
 error:
