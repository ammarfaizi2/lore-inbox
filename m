Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261462AbVAMAeZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261462AbVAMAeZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 19:34:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261510AbVALWBJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 17:01:09 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:39078 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261495AbVALVs3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 16:48:29 -0500
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
In-Reply-To: <20051121347.GID20pY2t5GaCSiw@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Wed, 12 Jan 2005 13:47:58 -0800
Message-Id: <20051121347.YiTPGKcPKdqWU1cs@topspin.com>
Mime-Version: 1.0
To: akpm@osdl.org
From: Roland Dreier <roland@topspin.com>
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: roland@topspin.com
Subject: [PATCH][10/18] InfiniBand/core: add node_type and phys_state sysfs attrs
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 12 Jan 2005 21:48:04.0860 (UTC) FILETIME=[654CFBC0:01C4F8F0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add per-device "node_type" and per-port "phys_state" sysfs attributes
for InfiniBand devices.

Signed-off-by: Roland Dreier <roland@topspin.com>

--- linux/drivers/infiniband/include/ib_verbs.h	(revision 1480)
+++ linux/drivers/infiniband/include/ib_verbs.h	(revision 1490)
@@ -212,6 +212,7 @@
 	u8			init_type_reply;
 	u8			active_width;
 	u8			active_speed;
+	u8                      phys_state;
 };
 
 enum ib_device_modify_flags {
--- linux/drivers/infiniband/core/sysfs.c	(revision 1480)
+++ linux/drivers/infiniband/core/sysfs.c	(revision 1490)
@@ -197,6 +197,29 @@
 		       ib_width_enum_to_int(attr.active_width), speed);
 }
 
+static ssize_t phys_state_show(struct ib_port *p, struct port_attribute *unused,
+			       char *buf)
+{
+	struct ib_port_attr attr;
+
+	ssize_t ret;
+
+	ret = ib_query_port(p->ibdev, p->port_num, &attr);
+	if (ret)
+		return ret;
+
+	switch (attr.phys_state) {
+	case 1:  return sprintf(buf, "1: Sleep\n");
+	case 2:  return sprintf(buf, "2: Polling\n");
+	case 3:  return sprintf(buf, "3: Disabled\n");
+	case 4:  return sprintf(buf, "4: PortConfigurationTraining\n");
+	case 5:  return sprintf(buf, "5: LinkUp\n");
+	case 6:  return sprintf(buf, "6: LinkErrorRecovery\n");
+	case 7:  return sprintf(buf, "7: Phy Test\n");
+	default: return sprintf(buf, "%d: <unknown>\n", attr.phys_state);
+	}
+}
+
 static PORT_ATTR_RO(state);
 static PORT_ATTR_RO(lid);
 static PORT_ATTR_RO(lid_mask_count);
@@ -204,6 +227,7 @@
 static PORT_ATTR_RO(sm_sl);
 static PORT_ATTR_RO(cap_mask);
 static PORT_ATTR_RO(rate);
+static PORT_ATTR_RO(phys_state);
 
 static struct attribute *port_default_attrs[] = {
 	&port_attr_state.attr,
@@ -213,6 +237,7 @@
 	&port_attr_sm_sl.attr,
 	&port_attr_cap_mask.attr,
 	&port_attr_rate.attr,
+	&port_attr_phys_state.attr,
 	NULL
 };
 
@@ -572,6 +597,18 @@
 	return ret;
 }
 
+static ssize_t show_node_type(struct class_device *cdev, char *buf)
+{
+	struct ib_device *dev = container_of(cdev, struct ib_device, class_dev);
+
+	switch (dev->node_type) {
+	case IB_NODE_CA:     return sprintf(buf, "%d: CA\n", dev->node_type);
+	case IB_NODE_SWITCH: return sprintf(buf, "%d: switch\n", dev->node_type);
+	case IB_NODE_ROUTER: return sprintf(buf, "%d: router\n", dev->node_type);
+	default:             return sprintf(buf, "%d: <unknown>\n", dev->node_type);
+	}
+}
+
 static ssize_t show_sys_image_guid(struct class_device *cdev, char *buf)
 {
 	struct ib_device *dev = container_of(cdev, struct ib_device, class_dev);
@@ -606,10 +643,12 @@
 		       be16_to_cpu(((u16 *) &attr.node_guid)[3]));
 }
 
+static CLASS_DEVICE_ATTR(node_type, S_IRUGO, show_node_type, NULL);
 static CLASS_DEVICE_ATTR(sys_image_guid, S_IRUGO, show_sys_image_guid, NULL);
 static CLASS_DEVICE_ATTR(node_guid, S_IRUGO, show_node_guid, NULL);
 
 static struct class_device_attribute *ib_class_attributes[] = {
+	&class_device_attr_node_type,
 	&class_device_attr_sys_image_guid,
 	&class_device_attr_node_guid
 };
--- linux/drivers/infiniband/hw/mthca/mthca_provider.c	(revision 1480)
+++ linux/drivers/infiniband/hw/mthca/mthca_provider.c	(revision 1490)
@@ -119,6 +119,7 @@
 	props->sm_lid            = be16_to_cpup((u16 *) (out_mad->data + 18));
 	props->sm_sl             = out_mad->data[36] & 0xf;
 	props->state             = out_mad->data[32] & 0xf;
+	props->phys_state        = out_mad->data[33] >> 4;
 	props->port_cap_flags    = be32_to_cpup((u32 *) (out_mad->data + 20));
 	props->gid_tbl_len       = to_mdev(ibdev)->limits.gid_table_len;
 	props->pkey_tbl_len      = to_mdev(ibdev)->limits.pkey_table_len;
--- linux/Documentation/infiniband/sysfs.txt	(revision 1480)
+++ linux/Documentation/infiniband/sysfs.txt	(revision 1490)
@@ -3,6 +3,7 @@
   For each InfiniBand device, the InfiniBand drivers create the
   following files under /sys/class/linux/drivers/infiniband/<device name>:
 
+    node_type      - Node type (CA, switch or router)
     node_guid      - Node GUID
     sys_image_guid - System image GUID
 
@@ -25,6 +26,7 @@
     sm_lid         - Subnet manager LID for port's subnet
     sm_sl          - Subnet manager SL for port's subnet
     state          - Port state (DOWN, INIT, ARMED, ACTIVE or ACTIVE_DEFER)
+    phys_state     - Port physical state (Sleep, Polling, LinkUp, etc)
 
   There is also a "counters" subdirectory, with files
 

