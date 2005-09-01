Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965025AbVIAB3l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965025AbVIAB3l (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 21:29:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965018AbVIAB3g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 21:29:36 -0400
Received: from ozlabs.org ([203.10.76.45]:15504 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S965025AbVIAB33 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 21:29:29 -0400
To: <jgarzik@pobox.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
       <linuxppc64-dev@ozlabs.org>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 15/18] iseries_veth: Add sysfs support for port structs
In-Reply-To: <1125538127.859382.875909607846.qpush@concordia>
Message-Id: <20050901012921.7BA6B68235@ozlabs.org>
Date: Thu,  1 Sep 2005 11:29:21 +1000 (EST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Also to aid debugging, add sysfs support for iseries_veth's port structures.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 drivers/net/iseries_veth.c |   67 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 67 insertions(+)

Index: veth-dev2/drivers/net/iseries_veth.c
===================================================================
--- veth-dev2.orig/drivers/net/iseries_veth.c
+++ veth-dev2/drivers/net/iseries_veth.c
@@ -167,6 +167,8 @@ struct veth_port {
 	int promiscuous;
 	int num_mcast;
 	u64 mcast_addr[VETH_MAX_MCAST];
+
+	struct kobject kobject;
 };
 
 static HvLpIndex this_lp;
@@ -350,6 +352,62 @@ static struct kobj_type veth_lpar_connec
 	.default_attrs	= veth_cnx_default_attrs
 };
 
+struct veth_port_attribute {
+	struct attribute attr;
+	ssize_t (*show)(struct veth_port *, char *buf);
+	ssize_t (*store)(struct veth_port *, const char *buf);
+};
+
+static ssize_t veth_port_attribute_show(struct kobject *kobj,
+		struct attribute *attr, char *buf)
+{
+	struct veth_port_attribute *port_attr;
+	struct veth_port *port;
+
+	port_attr = container_of(attr, struct veth_port_attribute, attr);
+	port = container_of(kobj, struct veth_port, kobject);
+
+	if (!port_attr->show)
+		return -EIO;
+
+	return port_attr->show(port, buf);
+}
+
+#define CUSTOM_PORT_ATTR(_name, _format, _expression)			\
+static ssize_t _name##_show(struct veth_port *port, char *buf)		\
+{									\
+	return sprintf(buf, _format, _expression);			\
+}									\
+struct veth_port_attribute veth_port_attr_##_name = __ATTR_RO(_name)
+
+#define SIMPLE_PORT_ATTR(_name)	\
+	CUSTOM_PORT_ATTR(_name, "%lu\n", (unsigned long)port->_name)
+
+SIMPLE_PORT_ATTR(promiscuous);
+SIMPLE_PORT_ATTR(num_mcast);
+CUSTOM_PORT_ATTR(lpar_map, "0x%X\n", port->lpar_map);
+CUSTOM_PORT_ATTR(stopped_map, "0x%X\n", port->stopped_map);
+CUSTOM_PORT_ATTR(mac_addr, "0x%lX\n", port->mac_addr);
+
+#define GET_PORT_ATTR(_name)	(&veth_port_attr_##_name.attr)
+static struct attribute *veth_port_default_attrs[] = {
+	GET_PORT_ATTR(mac_addr),
+	GET_PORT_ATTR(lpar_map),
+	GET_PORT_ATTR(stopped_map),
+	GET_PORT_ATTR(promiscuous),
+	GET_PORT_ATTR(num_mcast),
+	NULL
+};
+
+static struct sysfs_ops veth_port_sysfs_ops = {
+	.show = veth_port_attribute_show
+};
+
+static struct kobj_type veth_port_ktype = {
+	.sysfs_ops	= &veth_port_sysfs_ops,
+	.default_attrs	= veth_port_default_attrs
+};
+
 /*
  * LPAR connection code
  */
@@ -992,6 +1050,13 @@ static struct net_device * __init veth_p
 		return NULL;
 	}
 
+	kobject_init(&port->kobject);
+	port->kobject.parent = &dev->class_dev.kobj;
+	port->kobject.ktype  = &veth_port_ktype;
+	kobject_set_name(&port->kobject, "veth_port");
+	if (0 != kobject_add(&port->kobject))
+		veth_error("Failed adding port for %s to sysfs.\n", dev->name);
+
 	veth_info("%s attached to iSeries vlan %d (LPAR map = 0x%.4X)\n",
 			dev->name, vlan, port->lpar_map);
 
@@ -1486,6 +1551,8 @@ static int veth_remove(struct vio_dev *v
 	}
 
 	veth_dev[vdev->unit_address] = NULL;
+	kobject_del(&port->kobject);
+	kobject_put(&port->kobject);
 	unregister_netdev(dev);
 	free_netdev(dev);
 
