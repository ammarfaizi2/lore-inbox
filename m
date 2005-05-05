Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261857AbVEEDFu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261857AbVEEDFu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 23:05:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261879AbVEEDFu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 23:05:50 -0400
Received: from sabe.cs.wisc.edu ([128.105.6.20]:10133 "EHLO sabe.cs.wisc.edu")
	by vger.kernel.org with ESMTP id S261857AbVEECy3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 22:54:29 -0400
Message-ID: <42798ADD.5070803@cs.wisc.edu>
Date: Wed, 04 May 2005 19:54:21 -0700
From: Mike Christie <michaelc@cs.wisc.edu>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux-scsi <linux-scsi@vger.kernel.org>,
       netdev <netdev@oss.sgi.com>
Subject: [PATCH 3/3] add open iscsi netlink interface to iscsi transport class
Content-Type: multipart/mixed;
 boundary="------------070207010201080506090305"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070207010201080506090305
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

attached integrate-iscsi-netlink.patch - incorporate the 
open-iscsi/linux-iscsi netlink interface into the iscsi transport class.

This patch also removes the iscsi_host class and breaks the 
iscsi_transport class into a iscsi_connection and iscsi_session class. 
The iscsi_host class is removed becuase the open-iscsi/linux-iscsi 
netlink framework pushes login to usersapce so there is no need to store 
long strings like the initiatorname and alias in the kernel anymore. And 
breaking out the session and connection from the old 
/sys/class/iscsi_transport was necessary becuase the session and 
connection creation and destruction is driven from userspace and it may 
end up where you have a session but no scsi target (in which case 
/sys/class/iscsi_transport would not show up previously). Having the 
session/connection represented in this case is useful for iscsi async 
events and their userpace handlers.

We followed the FC transport class strategy for the sysfs layout which 
uses struct devices and driver model transport_classes so the format 
looks like the following:

[root@mina class]# cd iscsi_session/
[root@mina iscsi_session]# ls
session2
[root@mina iscsi_session]# cd session2/
[root@mina session2]# ls
data_pdu_in_order  device  first_burst_len  initial_r2t 
max_outstanding_r2t
data_seq_in_order  erl     immediate_data   max_burst_len
[root@mina class]# cd iscsi_connection/
[root@mina iscsi_connection]# ls
connection2:0
[root@mina iscsi_connection]# cd connection2\:0/
[root@mina connection2:0]# ls
device  header_digest  ifmarker  max_recv_dlength  max_xmit_dlength 
ofmarker

A session's connection is linked by the device links:

[root@mina host2]# tree
.
|-- detach_state
|-- power
|   `-- state
`-- session2
     |-- connection2:0
     |   |-- detach_state
     |   `-- power
     |       `-- state
     |-- detach_state
     `-- power
         `-- state

We are perfectly fine with adding a different parent of the session or 
making the class_devices linked rather than the devices or ditching the 
device usage for kobjects or something else. We were not sure if the FC 
transport class model was the preferred model for us to follow though.


Thanks,

Linux-iscsi Team

Signed-off-by: Alex Aizman <itn780@yahoo.com>
Signed-off-by: Dmitry Yusupov <dmitry_yus@yahoo.com>
Signed-off-by: Mike Christie <michaelc@cs.wisc.edu>

--------------070207010201080506090305
Content-Type: text/x-patch;
 name="integrate-iscsi-netlink.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="integrate-iscsi-netlink.patch"

diff -aurp linux-2.6.12-rc3.orig/drivers/scsi/scsi_transport_iscsi.c linux-2.6.12-rc3.work/drivers/scsi/scsi_transport_iscsi.c
--- linux-2.6.12-rc3.orig/drivers/scsi/scsi_transport_iscsi.c	2005-04-20 17:03:15.000000000 -0700
+++ linux-2.6.12-rc3.work/drivers/scsi/scsi_transport_iscsi.c	2005-05-04 18:44:04.000000000 -0700
@@ -1,8 +1,8 @@
-/* 
+/*
  * iSCSI transport class definitions
  *
  * Copyright (C) IBM Corporation, 2004
- * Copyright (C) Mike Christie, 2004
+ * Copyright (C) Mike Christie, Dmitry Yusupov, Alex Aizman, 2004 - 2005
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -19,370 +19,1126 @@
  * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
  */
 #include <linux/module.h>
+#include <linux/mempool.h>
+#include <net/tcp.h>
 #include <scsi/scsi.h>
 #include <scsi/scsi_host.h>
 #include <scsi/scsi_device.h>
 #include <scsi/scsi_transport.h>
 #include <scsi/scsi_transport_iscsi.h>
+#include <scsi/iscsi_ifev.h>
 
-#define ISCSI_SESSION_ATTRS 20
-#define ISCSI_HOST_ATTRS 2
+#define ISCSI_SESSION_ATTRS 8
+#define ISCSI_CONN_ATTRS 6
 
 struct iscsi_internal {
 	struct scsi_transport_template t;
-	struct iscsi_function_template *fnt;
+	struct iscsi_transport *tt;
+
+	/*
+	 * based on transport capabilities, at register time we sets these
+	 * bits to tell the transport class it wants the attributes
+	 * displayed in sysfs.
+	 */
+	uint32_t param_mask;
+
 	/*
 	 * We do not have any private or other attrs.
 	 */
+	struct transport_container connection_cont;
+	struct class_device_attribute *connection_attrs[ISCSI_CONN_ATTRS + 1];
+	struct transport_container session_cont;
 	struct class_device_attribute *session_attrs[ISCSI_SESSION_ATTRS + 1];
-	struct class_device_attribute *host_attrs[ISCSI_HOST_ATTRS + 1];
 };
 
 #define to_iscsi_internal(tmpl) container_of(tmpl, struct iscsi_internal, t)
 
-static DECLARE_TRANSPORT_CLASS(iscsi_transport_class,
-			       "iscsi_transport",
+static DECLARE_TRANSPORT_CLASS(iscsi_session_class,
+			       "iscsi_session",
 			       NULL,
 			       NULL,
 			       NULL);
 
-static DECLARE_TRANSPORT_CLASS(iscsi_host_class,
-			       "iscsi_host",
+static DECLARE_TRANSPORT_CLASS(iscsi_connection_class,
+			       "iscsi_connection",
 			       NULL,
 			       NULL,
 			       NULL);
-/*
- * iSCSI target and session attrs
- */
-#define iscsi_session_show_fn(field, format)				\
-									\
-static ssize_t								\
-show_session_##field(struct class_device *cdev, char *buf)		\
-{									\
-	struct scsi_target *starget = transport_class_to_starget(cdev);	\
-	struct Scsi_Host *shost = dev_to_shost(starget->dev.parent);	\
-	struct iscsi_internal *i = to_iscsi_internal(shost->transportt); \
-									\
-	if (i->fnt->get_##field)					\
-		i->fnt->get_##field(starget);				\
-	return snprintf(buf, 20, format"\n", iscsi_##field(starget));	\
-}
-
-#define iscsi_session_rd_attr(field, format)				\
-	iscsi_session_show_fn(field, format)				\
-static CLASS_DEVICE_ATTR(field, S_IRUGO, show_session_##field, NULL);
-
-iscsi_session_rd_attr(tpgt, "%hu");
-iscsi_session_rd_attr(tsih, "%2x");
-iscsi_session_rd_attr(max_recv_data_segment_len, "%u");
-iscsi_session_rd_attr(max_burst_len, "%u");
-iscsi_session_rd_attr(first_burst_len, "%u");
-iscsi_session_rd_attr(def_time2wait, "%hu");
-iscsi_session_rd_attr(def_time2retain, "%hu");
-iscsi_session_rd_attr(max_outstanding_r2t, "%hu");
-iscsi_session_rd_attr(erl, "%d");
 
+static struct iscsi_transport *transport_table[ISCSI_TRANSPORT_MAX];
+static struct sock *nls;
+static int daemon_pid;
+static DECLARE_MUTEX(callsema);
+
+struct mempool_zone {
+	mempool_t *pool;
+	volatile int allocated;
+	int size;
+	int max;
+	int hiwat;
+	struct list_head freequeue;
+	spinlock_t freelock;
+};
 
-#define iscsi_session_show_bool_fn(field)				\
-									\
-static ssize_t								\
-show_session_bool_##field(struct class_device *cdev, char *buf)		\
-{									\
-	struct scsi_target *starget = transport_class_to_starget(cdev);	\
-	struct Scsi_Host *shost = dev_to_shost(starget->dev.parent);	\
-	struct iscsi_internal *i = to_iscsi_internal(shost->transportt); \
-									\
-	if (i->fnt->get_##field)					\
-		i->fnt->get_##field(starget);				\
-									\
-	if (iscsi_##field(starget))					\
-		return sprintf(buf, "Yes\n");				\
-	return sprintf(buf, "No\n");					\
+static struct mempool_zone z_reply;
+
+#define Z_SIZE_REPLY	NLMSG_SPACE(sizeof(struct iscsi_uevent))
+#define Z_MAX_REPLY	8
+#define Z_HIWAT_REPLY	6
+
+#define Z_SIZE_PDU	NLMSG_SPACE(sizeof(struct iscsi_uevent) + \
+				    sizeof(struct iscsi_hdr) + \
+				    DEFAULT_MAX_RECV_DATA_SEGMENT_LENGTH)
+#define Z_MAX_PDU	8
+#define Z_HIWAT_PDU	6
+
+#define Z_SIZE_ERROR	NLMSG_SPACE(sizeof(struct iscsi_uevent))
+#define Z_MAX_ERROR	16
+#define Z_HIWAT_ERROR	12
+
+struct iscsi_if_cnx {
+	struct list_head item;		/* item in cnxlist */
+	struct list_head snxitem;	/* item in snx->connections */
+	iscsi_cnx_t cnxh;
+	volatile int active;
+	struct Scsi_Host *host;		/* originated shost */
+	struct device dev;		/* sysfs transport/container device */
+	struct iscsi_transport *transport;
+	struct mempool_zone z_error;
+	struct mempool_zone z_pdu;
+	struct list_head freequeue;
+};
+
+#define iscsi_dev_to_if_cnx(_dev) \
+	container_of(_dev, struct iscsi_if_cnx, dev)
+
+#define iscsi_cdev_to_if_cnx(_cdev) \
+	iscsi_dev_to_if_cnx(_cdev->dev)
+
+static LIST_HEAD(cnxlist);
+static DEFINE_SPINLOCK(cnxlock);
+
+struct iscsi_if_snx {
+	struct list_head item;	/* item in snxlist */
+	struct list_head connections;
+	iscsi_snx_t snxh;
+	struct iscsi_transport *transport;
+	struct device dev;	/* sysfs transport/container device */
+};
+
+#define iscsi_dev_to_if_snx(_dev) \
+	container_of(_dev, struct iscsi_if_snx, dev)
+
+#define iscsi_cdev_to_if_snx(_cdev) \
+	iscsi_dev_to_if_snx(_cdev->dev)
+
+#define iscsi_if_snx_to_shost(_snx) \
+	dev_to_shost(_snx->dev.parent)
+
+static LIST_HEAD(snxlist);
+static DEFINE_SPINLOCK(snxlock);
+
+#define H_TYPE_TRANS	1
+#define H_TYPE_HOST	2
+static struct iscsi_if_cnx*
+iscsi_if_find_cnx(uint64_t key, int type)
+{
+	unsigned long flags;
+	struct iscsi_if_cnx *cnx;
+
+	spin_lock_irqsave(&cnxlock, flags);
+	list_for_each_entry(cnx, &cnxlist, item) {
+		if ((type == H_TYPE_TRANS && cnx->cnxh == key) ||
+		    (type == H_TYPE_HOST && cnx->host == iscsi_ptr(key))) {
+			spin_unlock_irqrestore(&cnxlock, flags);
+			return cnx;
+		}
+	}
+	spin_unlock_irqrestore(&cnxlock, flags);
+	return NULL;
 }
 
-#define iscsi_session_rd_bool_attr(field)				\
-	iscsi_session_show_bool_fn(field)				\
-static CLASS_DEVICE_ATTR(field, S_IRUGO, show_session_bool_##field, NULL);
+static struct iscsi_if_snx*
+iscsi_if_find_snx(struct iscsi_transport *t)
+{
+	unsigned long flags;
+	struct iscsi_if_snx *snx;
 
-iscsi_session_rd_bool_attr(initial_r2t);
-iscsi_session_rd_bool_attr(immediate_data);
-iscsi_session_rd_bool_attr(data_pdu_in_order);
-iscsi_session_rd_bool_attr(data_sequence_in_order);
+	spin_lock_irqsave(&snxlock, flags);
+	list_for_each_entry(snx, &snxlist, item) {
+		if (snx->transport == t) {
+			spin_unlock_irqrestore(&snxlock, flags);
+			return snx;
+		}
+	}
+	spin_unlock_irqrestore(&snxlock, flags);
+	return NULL;
+}
 
-#define iscsi_session_show_digest_fn(field)				\
-									\
-static ssize_t								\
-show_##field(struct class_device *cdev, char *buf)			\
-{									\
-	struct scsi_target *starget = transport_class_to_starget(cdev);	\
-	struct Scsi_Host *shost = dev_to_shost(starget->dev.parent);	\
-	struct iscsi_internal *i = to_iscsi_internal(shost->transportt); \
-									\
-	if (i->fnt->get_##field)					\
-		i->fnt->get_##field(starget);				\
-									\
-	if (iscsi_##field(starget))					\
-		return sprintf(buf, "CRC32C\n");			\
-	return sprintf(buf, "None\n");					\
+static int
+iscsi_if_transport_lookup(struct iscsi_transport *t)
+{
+	int i;
+
+	for (i = 0; i < ISCSI_TRANSPORT_MAX; i++)
+		if (transport_table[i] == t)
+			return i;
+	return -1;
+}
+
+static void*
+mempool_zone_alloc_skb(unsigned int gfp_mask, void *pool_data)
+{
+	struct mempool_zone *zone = pool_data;
+
+	return alloc_skb(zone->size, gfp_mask);
+}
+
+static void
+mempool_zone_free_skb(void *element, void *pool_data)
+{
+	kfree_skb(element);
 }
 
-#define iscsi_session_rd_digest_attr(field)				\
-	iscsi_session_show_digest_fn(field)				\
-static CLASS_DEVICE_ATTR(field, S_IRUGO, show_##field, NULL);
+static void
+mempool_zone_complete(struct mempool_zone *zone)
+{
+	unsigned long flags;
+	struct list_head *lh, *n;
+
+	spin_lock_irqsave(&zone->freelock, flags);
+	list_for_each_safe(lh, n, &zone->freequeue) {
+		struct sk_buff *skb = (struct sk_buff *)((char *)lh -
+				offsetof(struct sk_buff, cb));
+		if (!skb_shared(skb)) {
+			list_del((void*)&skb->cb);
+			mempool_free(skb, zone->pool);
+			zone->allocated--;
+			BUG_ON(zone->allocated < 0);
+		}
+	}
+	spin_unlock_irqrestore(&zone->freelock, flags);
+}
+
+static int zone_init(struct mempool_zone *zp, unsigned max,
+		     unsigned size, unsigned hiwat)
+{
+	zp->pool = mempool_create(max, mempool_zone_alloc_skb,
+				  mempool_zone_free_skb, zp);
+	if (!zp->pool)
+		return -ENOMEM;
+
+	zp->max = max;
+	zp->size = size;
+	zp->hiwat = hiwat;
+
+	INIT_LIST_HEAD(&zp->freequeue);
+	spin_lock_init(&zp->freelock);
+	zp->allocated = 0;
+
+	return 0;
+}
 
-iscsi_session_rd_digest_attr(header_digest);
-iscsi_session_rd_digest_attr(data_digest);
 
-static ssize_t
-show_port(struct class_device *cdev, char *buf)
+static struct sk_buff*
+mempool_zone_get_skb(struct mempool_zone *zone)
 {
-	struct scsi_target *starget = transport_class_to_starget(cdev);
-	struct Scsi_Host *shost = dev_to_shost(starget->dev.parent);
-	struct iscsi_internal *i = to_iscsi_internal(shost->transportt);
+	struct sk_buff *skb;
 
-	if (i->fnt->get_port)
-		i->fnt->get_port(starget);
+	if (zone->allocated < zone->max) {
+		skb = mempool_alloc(zone->pool, GFP_ATOMIC);
+		BUG_ON(!skb);
+		zone->allocated++;
+	} else
+		return NULL;
 
-	return snprintf(buf, 20, "%hu\n", ntohs(iscsi_port(starget)));
+	return skb;
 }
-static CLASS_DEVICE_ATTR(port, S_IRUGO, show_port, NULL);
 
-static ssize_t
-show_ip_address(struct class_device *cdev, char *buf)
+static int
+iscsi_unicast_skb(struct mempool_zone *zone, struct sk_buff *skb)
 {
-	struct scsi_target *starget = transport_class_to_starget(cdev);
-	struct Scsi_Host *shost = dev_to_shost(starget->dev.parent);
-	struct iscsi_internal *i = to_iscsi_internal(shost->transportt);
+	unsigned long flags;
+	int rc;
 
-	if (i->fnt->get_ip_address)
-		i->fnt->get_ip_address(starget);
+	skb_get(skb);
+	rc = netlink_unicast(nls, skb, daemon_pid, MSG_DONTWAIT);
+	if (rc < 0) {
+		mempool_free(skb, zone->pool);
+		printk("iscsi: can not unicast skb (%d)\n", rc);
+		return rc;
+	}
+
+	spin_lock_irqsave(&zone->freelock, flags);
+	list_add((void*)&skb->cb, &zone->freequeue);
+	spin_unlock_irqrestore(&zone->freelock, flags);
 
-	if (iscsi_addr_type(starget) == AF_INET)
-		return sprintf(buf, "%u.%u.%u.%u\n",
-			       NIPQUAD(iscsi_sin_addr(starget)));
-	else if(iscsi_addr_type(starget) == AF_INET6)
-		return sprintf(buf, "%04x:%04x:%04x:%04x:%04x:%04x:%04x:%04x\n",
-			       NIP6(iscsi_sin6_addr(starget)));
-	return -EINVAL;
+	return 0;
 }
-static CLASS_DEVICE_ATTR(ip_address, S_IRUGO, show_ip_address, NULL);
 
-static ssize_t
-show_isid(struct class_device *cdev, char *buf)
+int iscsi_recv_pdu(iscsi_cnx_t cnxh, struct iscsi_hdr *hdr,
+				char *data, uint32_t data_size)
 {
-	struct scsi_target *starget = transport_class_to_starget(cdev);
-	struct Scsi_Host *shost = dev_to_shost(starget->dev.parent);
-	struct iscsi_internal *i = to_iscsi_internal(shost->transportt);
+	struct nlmsghdr	*nlh;
+	struct sk_buff *skb;
+	struct iscsi_uevent *ev;
+	struct iscsi_if_cnx *cnx;
+	char *pdu;
+	int len = NLMSG_SPACE(sizeof(*ev) + sizeof(struct iscsi_hdr) +
+			      data_size);
+
+	cnx = iscsi_if_find_cnx(cnxh, H_TYPE_TRANS);
+	BUG_ON(!cnx);
+
+	mempool_zone_complete(&cnx->z_pdu);
+
+	skb = mempool_zone_get_skb(&cnx->z_pdu);
+	if (!skb) {
+		iscsi_cnx_error(cnxh, ISCSI_ERR_CNX_FAILED);
+		printk("iscsi%d: can not deliver control PDU: OOM\n",
+		       cnx->host->host_no);
+		return -ENOMEM;
+	}
 
-	if (i->fnt->get_isid)
-		i->fnt->get_isid(starget);
+	nlh = __nlmsg_put(skb, daemon_pid, 0, 0, (len - sizeof(*nlh)));
+	ev = NLMSG_DATA(nlh);
+	memset(ev, 0, sizeof(*ev));
+	ev->transport_handle = iscsi_handle(cnx->transport);
+	ev->type = ISCSI_KEVENT_RECV_PDU;
+	if (cnx->z_pdu.allocated >= cnx->z_pdu.hiwat)
+		ev->iferror = -ENOMEM;
+	ev->r.recv_req.cnx_handle = cnxh;
+	pdu = (char*)ev + sizeof(*ev);
+	memcpy(pdu, hdr, sizeof(struct iscsi_hdr));
+	memcpy(pdu + sizeof(struct iscsi_hdr), data, data_size);
 
-	return sprintf(buf, "%02x%02x%02x%02x%02x%02x\n",
-		       iscsi_isid(starget)[0], iscsi_isid(starget)[1],
-		       iscsi_isid(starget)[2], iscsi_isid(starget)[3],
-		       iscsi_isid(starget)[4], iscsi_isid(starget)[5]);
+	return iscsi_unicast_skb(&cnx->z_pdu, skb);
 }
-static CLASS_DEVICE_ATTR(isid, S_IRUGO, show_isid, NULL);
+EXPORT_SYMBOL_GPL(iscsi_recv_pdu);
 
-/*
- * This is used for iSCSI names. Normally, we follow
- * the transport class convention of having the lld
- * set the field, but in these cases the value is
- * too large.
- */
-#define iscsi_session_show_str_fn(field)				\
-									\
-static ssize_t								\
-show_session_str_##field(struct class_device *cdev, char *buf)		\
-{									\
-	ssize_t ret = 0;						\
-	struct scsi_target *starget = transport_class_to_starget(cdev);	\
-	struct Scsi_Host *shost = dev_to_shost(starget->dev.parent);	\
-	struct iscsi_internal *i = to_iscsi_internal(shost->transportt); \
-									\
-	if (i->fnt->get_##field)					\
-		ret = i->fnt->get_##field(starget, buf, PAGE_SIZE);	\
-	return ret;							\
+void iscsi_cnx_error(iscsi_cnx_t cnxh, enum iscsi_err error)
+{
+	struct nlmsghdr	*nlh;
+	struct sk_buff	*skb;
+	struct iscsi_uevent *ev;
+	struct iscsi_if_cnx *cnx;
+	int len = NLMSG_SPACE(sizeof(*ev));
+
+	cnx = iscsi_if_find_cnx(cnxh, H_TYPE_TRANS);
+	BUG_ON(!cnx);
+
+	mempool_zone_complete(&cnx->z_error);
+
+	skb = mempool_zone_get_skb(&cnx->z_error);
+	if (!skb) {
+		printk("iscsi%d: gracefully ignored cnx error (%d)\n",
+		       cnx->host->host_no, error);
+		return;
+	}
+
+	nlh = __nlmsg_put(skb, daemon_pid, 0, 0, (len - sizeof(*nlh)));
+	ev = NLMSG_DATA(nlh);
+	ev->transport_handle = iscsi_handle(cnx->transport);
+	ev->type = ISCSI_KEVENT_CNX_ERROR;
+	if (cnx->z_error.allocated >= cnx->z_error.hiwat)
+		ev->iferror = -ENOMEM;
+	ev->r.cnxerror.error = error;
+	ev->r.cnxerror.cnx_handle = cnxh;
+
+	iscsi_unicast_skb(&cnx->z_error, skb);
+
+	printk("iscsi%d: detected cnx error (%d)\n", cnx->host->host_no, error);
 }
+EXPORT_SYMBOL_GPL(iscsi_cnx_error);
 
-#define iscsi_session_rd_str_attr(field)				\
-	iscsi_session_show_str_fn(field)				\
-static CLASS_DEVICE_ATTR(field, S_IRUGO, show_session_str_##field, NULL);
+static int
+iscsi_if_send_reply(int pid, int seq, int type, int done, int multi,
+		      void *payload, int size)
+{
+	struct sk_buff	*skb;
+	struct nlmsghdr	*nlh;
+	int len = NLMSG_SPACE(size);
+	int flags = multi ? NLM_F_MULTI : 0;
+	int t = done ? NLMSG_DONE  : type;
 
-iscsi_session_rd_str_attr(target_name);
-iscsi_session_rd_str_attr(target_alias);
+	mempool_zone_complete(&z_reply);
+
+	skb = mempool_zone_get_skb(&z_reply);
+	/*
+	 * user is supposed to react on iferror == -ENOMEM;
+	 * see iscsi_if_rx().
+	 */
+	BUG_ON(!skb);
+
+	nlh = __nlmsg_put(skb, pid, seq, t, (len - sizeof(*nlh)));
+	nlh->nlmsg_flags = flags;
+	memcpy(NLMSG_DATA(nlh), payload, size);
+	return iscsi_unicast_skb(&z_reply, skb);
+}
 
 /*
- * iSCSI host attrs
+ * iSCSI Session's hostdata organization:
+ *
+ *    *------------------* <== host->hostdata
+ *    | transport        |
+ *    |------------------| <== iscsi_hostdata(host->hostdata)
+ *    | transport's data |
+ *    |------------------| <== hostdata_snx(host->hostdata)
+ *    | interface's data |
+ *    *------------------*
  */
 
+#define hostdata_privsize(_t)	(sizeof(unsigned long) + _t->hostdata_size + \
+				 _t->hostdata_size % sizeof(unsigned long) + \
+				 sizeof(struct iscsi_if_snx))
+
+#define hostdata_snx(_hostdata)	((void*)_hostdata + sizeof(unsigned long) + \
+			((struct iscsi_transport *) \
+			 iscsi_ptr(*(uint64_t *)_hostdata))->hostdata_size)
+
+static void iscsi_if_snx_dev_release(struct device *dev)
+{
+	struct iscsi_if_snx *snx = iscsi_dev_to_if_snx(dev);
+	struct iscsi_transport *transport = snx->transport;
+	struct Scsi_Host *shost = iscsi_if_snx_to_shost(snx);
+	struct iscsi_if_cnx *cnx;
+	unsigned long flags;
+
+	/* now free connections */
+	spin_lock_irqsave(&cnxlock, flags);
+	list_for_each_entry(cnx, &snx->connections, snxitem) {
+		list_del(&cnx->item);
+		mempool_destroy(cnx->z_pdu.pool);
+		mempool_destroy(cnx->z_error.pool);
+		kfree(cnx);
+	}
+	spin_unlock_irqrestore(&cnxlock, flags);
+	scsi_host_put(shost);
+	module_put(transport->owner);
+}
+
+static int
+iscsi_if_create_snx(struct iscsi_transport *transport, struct iscsi_uevent *ev)
+{
+	struct iscsi_if_snx *snx;
+	struct Scsi_Host *shost;
+	unsigned long flags;
+	int error;
+
+	if (!try_module_get(transport->owner))
+		return -EPERM;
+
+	shost = scsi_host_alloc(transport->host_template,
+				hostdata_privsize(transport));
+	if (!shost) {
+		ev->r.c_session_ret.session_handle = iscsi_handle(NULL);
+		printk("iscsi: can not allocate SCSI host for session\n");
+		error = -ENOMEM;
+		goto out_module_put;
+	}
+	shost->max_id = 1;
+	shost->max_channel = 0;
+	shost->max_lun = transport->max_lun;
+	shost->max_cmd_len = transport->max_cmd_len;
+	shost->transportt = transport->scsi_transport;
+
+	/* store struct iscsi_transport in hostdata */
+	*(uint64_t*)shost->hostdata = ev->transport_handle;
+
+	ev->r.c_session_ret.session_handle = transport->create_session(
+					ev->u.c_session.initial_cmdsn, shost);
+	if (ev->r.c_session_ret.session_handle == iscsi_handle(NULL)) {
+		error = 0;
+		goto out_host_put;
+	}
+
+	/* host_no becomes assigned SID */
+	ev->r.c_session_ret.sid = shost->host_no;
+	/* initialize snx */
+	snx = hostdata_snx(shost->hostdata);
+	INIT_LIST_HEAD(&snx->connections);
+	snx->snxh = ev->r.c_session_ret.session_handle;
+	snx->transport = transport;
+
+	error = scsi_add_host(shost, NULL);
+	if (error)
+		goto out_destroy_session;
+
+	/*
+	 * this is released in the dev's release function)
+	 */
+	scsi_host_get(shost);
+	snprintf(snx->dev.bus_id, BUS_ID_SIZE, "session%u", shost->host_no);
+	snx->dev.parent = &shost->shost_gendev;
+	snx->dev.release = iscsi_if_snx_dev_release;
+	if (device_register(&snx->dev)) {
+		printk(KERN_ERR "iscsi: could not register session%d's dev\n",
+		       shost->host_no);
+		goto out_remove_host;
+	}
+	transport_register_device(&snx->dev);
+
+	/* add this session to the list of active sessions */
+	spin_lock_irqsave(&snxlock, flags);
+	list_add(&snx->item, &snxlist);
+	spin_unlock_irqrestore(&snxlock, flags);
+
+	return 0;
+
+ out_remove_host:
+	scsi_remove_host(shost);
+ out_destroy_session:
+	transport->destroy_session(ev->r.c_session_ret.session_handle);
+	ev->r.c_session_ret.session_handle = iscsi_handle(NULL);
+ out_host_put:
+	scsi_host_put(shost);
+ out_module_put:
+	module_put(transport->owner);
+	return error;
+}
+
+static int
+iscsi_if_destroy_snx(struct iscsi_transport *transport, struct iscsi_uevent *ev)
+{
+	struct Scsi_Host *shost;
+	struct iscsi_if_snx *snx;
+	unsigned long flags;
+	struct iscsi_if_cnx *cnx;
+
+	shost = scsi_host_lookup(ev->u.d_session.sid);
+	if (shost == ERR_PTR(-ENXIO))
+		return -EEXIST;
+	scsi_host_put(shost);
+	snx = hostdata_snx(shost->hostdata);
+
+	/* check if we have active connections */
+	spin_lock_irqsave(&cnxlock, flags);
+	list_for_each_entry(cnx, &snx->connections, snxitem) {
+		if (cnx->active) {
+			printk("iscsi%d: can not destroy session: "
+			       "has active connection (%p)\n",
+			       shost->host_no, iscsi_ptr(cnx->cnxh));
+			spin_unlock_irqrestore(&cnxlock, flags);
+			return -EIO;
+		}
+	}
+	spin_unlock_irqrestore(&cnxlock, flags);
+
+	scsi_remove_host(shost);
+	transport->destroy_session(ev->u.d_session.session_handle);
+	transport_unregister_device(&snx->dev);
+	device_unregister(&snx->dev);
+
+	/* remove this session from the list of active sessions */
+	spin_lock_irqsave(&snxlock, flags);
+	list_del(&snx->item);
+	spin_unlock_irqrestore(&snxlock, flags);
+
+	scsi_host_put(shost);
+	return 0;
+}
+
+static void iscsi_if_cnx_dev_release(struct device *dev)
+{
+	struct iscsi_if_cnx *cnx = iscsi_dev_to_if_cnx(dev);
+	struct Scsi_Host *shost = cnx->host;
+
+	scsi_host_put(shost);
+}
+
+static int
+iscsi_if_create_cnx(struct iscsi_transport *transport, struct iscsi_uevent *ev)
+{
+	struct iscsi_if_snx *snx;
+	struct Scsi_Host *shost;
+	struct iscsi_if_cnx *cnx;
+	unsigned long flags;
+	int error;
+
+	shost = scsi_host_lookup(ev->u.c_cnx.sid);
+	if (shost == ERR_PTR(-ENXIO))
+		return -EEXIST;
+	scsi_host_put(shost);
+	snx = hostdata_snx(shost->hostdata);
+
+	cnx = kmalloc(sizeof(struct iscsi_if_cnx), GFP_KERNEL);
+	if (!cnx)
+		return -ENOMEM;
+	memset(cnx, 0, sizeof(struct iscsi_if_cnx));
+	cnx->host = shost;
+	snx->transport = transport;
+
+	error = zone_init(&cnx->z_pdu, Z_MAX_PDU, Z_SIZE_PDU, Z_HIWAT_PDU);
+	if (error) {
+		printk("iscsi%d: can not allocate pdu zone for new cnx\n",
+		       shost->host_no);
+		goto out_free_cnx;
+	}
+	error = zone_init(&cnx->z_error, Z_MAX_ERROR,
+			  Z_SIZE_ERROR, Z_HIWAT_ERROR);
+	if (error) {
+		printk("iscsi%d: can not allocate error zone for new cnx\n",
+		       shost->host_no);
+		goto out_free_pdu_pool;
+	}
+
+	ev->r.handle = transport->create_cnx(ev->u.c_cnx.session_handle,
+					ev->u.c_cnx.cid);
+	if (!ev->r.handle) {
+		error = -ENODEV;
+		goto out_free_error_pool;
+	}
+
+	cnx->cnxh = ev->r.handle;
+
+	/*
+	 * this is released in the dev's release function)
+	 */
+	scsi_host_get(shost);
+	snprintf(cnx->dev.bus_id, BUS_ID_SIZE, "connection%d:%u",
+		 shost->host_no, ev->u.c_cnx.cid);
+	cnx->dev.parent = &snx->dev;
+	cnx->dev.release = iscsi_if_cnx_dev_release;
+	if (device_register(&cnx->dev)) {
+		printk(KERN_ERR "iscsi%d: could not register connections%u "
+		       "dev\n", shost->host_no, ev->u.c_cnx.cid);
+		goto out_destroy_cnx;
+	}
+	transport_register_device(&cnx->dev);
+
+	spin_lock_irqsave(&cnxlock, flags);
+	list_add(&cnx->item, &cnxlist);
+	list_add(&cnx->snxitem, &snx->connections);
+	spin_unlock_irqrestore(&cnxlock, flags);
+
+	cnx->active = 1;
+	return 0;
+
+ out_destroy_cnx:
+	transport->destroy_cnx(ev->r.handle);
+ out_free_error_pool:
+	mempool_destroy(cnx->z_error.pool);
+ out_free_pdu_pool:
+	mempool_destroy(cnx->z_pdu.pool);
+ out_free_cnx:
+	kfree(cnx);
+	return error;
+}
+
+static int
+iscsi_if_destroy_cnx(struct iscsi_transport *transport, struct iscsi_uevent *ev)
+{
+	unsigned long flags;
+	struct iscsi_if_cnx *cnx;
+
+	cnx = iscsi_if_find_cnx(ev->u.d_cnx.cnx_handle, H_TYPE_TRANS);
+	if (!cnx)
+		return -EEXIST;
+
+	transport->destroy_cnx(ev->u.d_cnx.cnx_handle);
+	cnx->active = 0;
+
+	spin_lock_irqsave(&cnxlock, flags);
+	list_del(&cnx->snxitem);
+	spin_unlock_irqrestore(&cnxlock, flags);
+
+	transport_unregister_device(&cnx->dev);
+	device_unregister(&cnx->dev);
+	return 0;
+}
+
+static int
+iscsi_if_recv_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
+{
+	int err = 0;
+	struct iscsi_uevent *ev = NLMSG_DATA(nlh);
+	struct iscsi_transport *transport = iscsi_ptr(ev->transport_handle);
+
+	if (nlh->nlmsg_type != ISCSI_UEVENT_TRANS_LIST &&
+	    iscsi_if_transport_lookup(transport) < 0)
+		return -EEXIST;
+
+	daemon_pid = NETLINK_CREDS(skb)->pid;
+
+	switch (nlh->nlmsg_type) {
+	case ISCSI_UEVENT_TRANS_LIST: {
+		int i;
+
+		for (i = 0; i < ISCSI_TRANSPORT_MAX; i++) {
+			if (transport_table[i]) {
+				ev->r.t_list.elements[i].trans_handle =
+					iscsi_handle(transport_table[i]);
+				strncpy(ev->r.t_list.elements[i].name,
+					transport_table[i]->name,
+					ISCSI_TRANSPORT_NAME_MAXLEN);
+			} else
+				ev->r.t_list.elements[i].trans_handle =
+					iscsi_handle(NULL);
+		}
+	      } break;
+	case ISCSI_UEVENT_CREATE_SESSION:
+		err = iscsi_if_create_snx(transport, ev);
+		break;
+	case ISCSI_UEVENT_DESTROY_SESSION:
+		err = iscsi_if_destroy_snx(transport, ev);
+		break;
+	case ISCSI_UEVENT_CREATE_CNX:
+		err = iscsi_if_create_cnx(transport, ev);
+		break;
+	case ISCSI_UEVENT_DESTROY_CNX:
+		err = iscsi_if_destroy_cnx(transport, ev);
+		break;
+	case ISCSI_UEVENT_BIND_CNX:
+		if (!iscsi_if_find_cnx(ev->u.b_cnx.cnx_handle, H_TYPE_TRANS))
+			return -EEXIST;
+		ev->r.retcode = transport->bind_cnx(
+			ev->u.b_cnx.session_handle,
+			ev->u.b_cnx.cnx_handle,
+			ev->u.b_cnx.transport_fd,
+			ev->u.b_cnx.is_leading);
+		break;
+	case ISCSI_UEVENT_SET_PARAM:
+		if (!iscsi_if_find_cnx(ev->u.set_param.cnx_handle,
+				       H_TYPE_TRANS))
+			return -EEXIST;
+		ev->r.retcode = transport->set_param(
+			ev->u.set_param.cnx_handle,
+			ev->u.set_param.param, ev->u.set_param.value);
+		break;
+	case ISCSI_UEVENT_START_CNX:
+		if (!iscsi_if_find_cnx(ev->u.start_cnx.cnx_handle,
+				       H_TYPE_TRANS))
+			return -EEXIST;
+		ev->r.retcode = transport->start_cnx(
+			ev->u.start_cnx.cnx_handle);
+		break;
+	case ISCSI_UEVENT_STOP_CNX:
+		if (!iscsi_if_find_cnx(ev->u.stop_cnx.cnx_handle, H_TYPE_TRANS))
+			return -EEXIST;
+		transport->stop_cnx(ev->u.stop_cnx.cnx_handle,
+			ev->u.stop_cnx.flag);
+		break;
+	case ISCSI_UEVENT_SEND_PDU:
+		if (!iscsi_if_find_cnx(ev->u.send_pdu.cnx_handle,
+				       H_TYPE_TRANS))
+			return -EEXIST;
+		ev->r.retcode = transport->send_pdu(
+		       ev->u.send_pdu.cnx_handle,
+		       (struct iscsi_hdr*)((char*)ev + sizeof(*ev)),
+		       (char*)ev + sizeof(*ev) + ev->u.send_pdu.hdr_size,
+			ev->u.send_pdu.data_size);
+		break;
+	case ISCSI_UEVENT_GET_STATS: {
+		struct iscsi_stats *stats;
+		struct sk_buff *skbstat;
+		struct iscsi_if_cnx *cnx;
+		struct nlmsghdr	*nlhstat;
+		struct iscsi_uevent *evstat;
+		int len = NLMSG_SPACE(sizeof(*ev) +
+				sizeof(struct iscsi_stats) +
+                                sizeof(struct iscsi_stats_custom) *
+                                                ISCSI_STATS_CUSTOM_MAX);
+		int err;
+
+		cnx = iscsi_if_find_cnx(ev->u.get_stats.cnx_handle,
+					H_TYPE_TRANS);
+		if (!cnx)
+			return -EEXIST;
+
+		do {
+			int actual_size;
+
+			skbstat = mempool_zone_get_skb(&cnx->z_pdu);
+			if (!skbstat) {
+				printk("iscsi%d: can not deliver stats: OOM\n",
+				       cnx->host->host_no);
+				return -ENOMEM;
+			}
+
+			nlhstat = __nlmsg_put(skbstat, daemon_pid, 0, 0,
+						(len - sizeof(*nlhstat)));
+			evstat = NLMSG_DATA(nlhstat);
+			memset(evstat, 0, sizeof(*evstat));
+			evstat->transport_handle = iscsi_handle(cnx->transport);
+			evstat->type = nlh->nlmsg_type;
+			if (cnx->z_pdu.allocated >= cnx->z_pdu.hiwat)
+				evstat->iferror = -ENOMEM;
+			evstat->u.get_stats.cnx_handle =
+					ev->u.get_stats.cnx_handle;
+			stats = (struct iscsi_stats *)
+					((char*)evstat + sizeof(*evstat));
+			memset(stats, 0, sizeof(*stats));
+
+			transport->get_stats(ev->u.get_stats.cnx_handle, stats);
+			actual_size = NLMSG_SPACE(sizeof(struct iscsi_uevent) +
+					sizeof(struct iscsi_stats) +
+                                	sizeof(struct iscsi_stats_custom) *
+						stats->custom_length);
+			actual_size -= sizeof(*nlhstat);
+			actual_size = NLMSG_LENGTH(actual_size);
+			skb_trim(skb, NLMSG_ALIGN(actual_size));
+			nlhstat->nlmsg_len = actual_size;
+
+			err = iscsi_unicast_skb(&cnx->z_pdu, skbstat);
+		} while (err < 0 && err != -ECONNREFUSED);
+		} break;
+	default:
+		err = -EINVAL;
+		break;
+	}
+
+	return err;
+}
+
+/* Get message from skb (based on rtnetlink_rcv_skb).  Each message is
+ * processed by iscsi_if_recv_msg.  Malformed skbs with wrong length are
+ * discarded silently.  */
+static void
+iscsi_if_rx(struct sock *sk, int len)
+{
+	struct sk_buff *skb;
+
+	down(&callsema);
+	while ((skb = skb_dequeue(&sk->sk_receive_queue)) != NULL) {
+		while (skb->len >= NLMSG_SPACE(0)) {
+			int err;
+			uint32_t rlen;
+			struct nlmsghdr	*nlh;
+			struct iscsi_uevent *ev;
+
+			nlh = (struct nlmsghdr *)skb->data;
+			if (nlh->nlmsg_len < sizeof(*nlh) ||
+			    skb->len < nlh->nlmsg_len) {
+				break;
+			}
+			ev = NLMSG_DATA(nlh);
+			rlen = NLMSG_ALIGN(nlh->nlmsg_len);
+			if (rlen > skb->len)
+				rlen = skb->len;
+			err = iscsi_if_recv_msg(skb, nlh);
+			if (err) {
+				ev->type = ISCSI_KEVENT_IF_ERROR;
+				ev->iferror = err;
+			}
+			do {
+				/*
+				 * special case for GET_STATS:
+				 * on success - sending reply and stats from
+				 * inside of if_recv_msg(),
+				 * on error - fall through.
+				 */
+				if (ev->type == ISCSI_UEVENT_GET_STATS && !err)
+					break;
+				err = iscsi_if_send_reply(
+					NETLINK_CREDS(skb)->pid, nlh->nlmsg_seq,
+					nlh->nlmsg_type, 0, 0, ev, sizeof(*ev));
+				if (z_reply.allocated >= z_reply.hiwat)
+					ev->iferror = -ENOMEM;
+			} while (err < 0 && err != -ECONNREFUSED);
+			skb_pull(skb, rlen);
+		}
+		kfree_skb(skb);
+	}
+	up(&callsema);
+}
+
 /*
- * Again, this is used for iSCSI names. Normally, we follow
- * the transport class convention of having the lld set
- * the field, but in these cases the value is too large.
+ * iSCSI connection attrs
  */
-#define iscsi_host_show_str_fn(field)					\
-									\
+#define iscsi_cnx_int_attr_show(param, format)				\
 static ssize_t								\
-show_host_str_##field(struct class_device *cdev, char *buf)		\
+show_cnx_int_param_##param(struct class_device *cdev, char *buf)	\
 {									\
-	int ret = 0;							\
-	struct Scsi_Host *shost = transport_class_to_shost(cdev);	\
-	struct iscsi_internal *i = to_iscsi_internal(shost->transportt); \
+	uint32_t value = 0;						\
+	struct iscsi_if_cnx *cnx = iscsi_cdev_to_if_cnx(cdev);		\
+	struct iscsi_internal *priv;					\
 									\
-	if (i->fnt->get_##field)					\
-		ret = i->fnt->get_##field(shost, buf, PAGE_SIZE);	\
-	return ret;							\
+	priv = to_iscsi_internal(cnx->host->transportt);		\
+	if (priv->param_mask & (1 << param))				\
+		priv->tt->get_param(cnx->cnxh, param, &value);		\
+	return snprintf(buf, 20, format"\n", value);			\
 }
 
-#define iscsi_host_rd_str_attr(field)					\
-	iscsi_host_show_str_fn(field)					\
-static CLASS_DEVICE_ATTR(field, S_IRUGO, show_host_str_##field, NULL);
+#define iscsi_cnx_int_attr(field, param, format)			\
+	iscsi_cnx_int_attr_show(param, format)				\
+static CLASS_DEVICE_ATTR(field, S_IRUGO, show_cnx_int_param_##param, NULL);
+
+iscsi_cnx_int_attr(max_recv_dlength, ISCSI_PARAM_MAX_RECV_DLENGTH, "%u");
+iscsi_cnx_int_attr(max_xmit_dlength, ISCSI_PARAM_MAX_XMIT_DLENGTH, "%u");
+iscsi_cnx_int_attr(header_digest, ISCSI_PARAM_HDRDGST_EN, "%d");
+iscsi_cnx_int_attr(data_digest, ISCSI_PARAM_DATADGST_EN, "%d");
+iscsi_cnx_int_attr(ifmarker, ISCSI_PARAM_IFMARKER_EN, "%d");
+iscsi_cnx_int_attr(ofmarker, ISCSI_PARAM_OFMARKER_EN, "%d");
 
-iscsi_host_rd_str_attr(initiator_name);
-iscsi_host_rd_str_attr(initiator_alias);
+/*
+ * iSCSI session attrs
+ */
+#define iscsi_snx_int_attr_show(param, format)				\
+static ssize_t								\
+show_snx_int_param_##param(struct class_device *cdev, char *buf)	\
+{									\
+	uint32_t value = 0;						\
+	struct iscsi_if_snx *snx = iscsi_cdev_to_if_snx(cdev);		\
+	struct Scsi_Host *shost = iscsi_if_snx_to_shost(snx);		\
+	struct iscsi_internal *priv = to_iscsi_internal(		\
+						shost->transportt);	\
+	struct iscsi_if_cnx *cnx = iscsi_if_find_cnx(			\
+				     iscsi_handle(shost), H_TYPE_HOST);	\
+	if (cnx)							\
+		if (priv->param_mask & (1 << param))			\
+			priv->tt->get_param(cnx->cnxh, param, &value);	\
+	return snprintf(buf, 20, format"\n", value);			\
+}
 
-#define SETUP_SESSION_RD_ATTR(field)					\
-	if (i->fnt->show_##field) {					\
-		i->session_attrs[count] = &class_device_attr_##field;	\
+#define iscsi_snx_int_attr(field, param, format)			\
+	iscsi_snx_int_attr_show(param, format)				\
+static CLASS_DEVICE_ATTR(field, S_IRUGO, show_snx_int_param_##param, NULL);
+
+iscsi_snx_int_attr(initial_r2t, ISCSI_PARAM_INITIAL_R2T_EN, "%d");
+iscsi_snx_int_attr(max_outstanding_r2t, ISCSI_PARAM_MAX_R2T, "%hu");
+iscsi_snx_int_attr(immediate_data, ISCSI_PARAM_IMM_DATA_EN, "%d");
+iscsi_snx_int_attr(first_burst_len, ISCSI_PARAM_FIRST_BURST, "%u");
+iscsi_snx_int_attr(max_burst_len, ISCSI_PARAM_MAX_BURST, "%u");
+iscsi_snx_int_attr(data_pdu_in_order, ISCSI_PARAM_PDU_INORDER_EN, "%d");
+iscsi_snx_int_attr(data_seq_in_order, ISCSI_PARAM_DATASEQ_INORDER_EN, "%d");
+iscsi_snx_int_attr(erl, ISCSI_PARAM_ERL, "%d");
+
+#define SETUP_SESSION_RD_ATTR(field, param)				\
+	if (priv->param_mask & (1 << param)) {				\
+		priv->session_attrs[count] = &class_device_attr_##field;\
 		count++;						\
 	}
 
-#define SETUP_HOST_RD_ATTR(field)					\
-	if (i->fnt->show_##field) {					\
-		i->host_attrs[count] = &class_device_attr_##field;	\
+#define SETUP_CONN_RD_ATTR(field, param)				\
+	if (priv->param_mask & (1 << param)) {				\
+		priv->connection_attrs[count] = &class_device_attr_##field;\
 		count++;						\
 	}
 
-static int iscsi_host_match(struct attribute_container *cont,
-			  struct device *dev)
+static int iscsi_is_snx_dev(const struct device *dev)
+{
+	return dev->release == iscsi_if_snx_dev_release;
+}
+
+static int iscsi_snx_match(struct attribute_container *cont,
+			   struct device *dev)
 {
+	struct iscsi_if_snx *snx;
 	struct Scsi_Host *shost;
-	struct iscsi_internal *i;
+	struct iscsi_internal *priv;
 
-	if (!scsi_is_host_device(dev))
+	if (!iscsi_is_snx_dev(dev))
 		return 0;
 
-	shost = dev_to_shost(dev);
-	if (!shost->transportt  || shost->transportt->host_attrs.ac.class
-	    != &iscsi_host_class.class)
+	snx = iscsi_dev_to_if_snx(dev);
+	shost = iscsi_if_snx_to_shost(snx);
+	if (!shost->transportt)
 		return 0;
 
-	i = to_iscsi_internal(shost->transportt);
-	
-	return &i->t.host_attrs.ac == cont;
+	priv = to_iscsi_internal(shost->transportt);
+	if (priv->session_cont.ac.class != &iscsi_session_class.class)
+		return 0;
+
+	return &priv->session_cont.ac == cont;
 }
 
-static int iscsi_target_match(struct attribute_container *cont,
-			    struct device *dev)
+static int iscsi_is_cnx_dev(const struct device *dev)
 {
+	return dev->release == iscsi_if_cnx_dev_release;
+}
+
+static int iscsi_cnx_match(struct attribute_container *cont,
+			   struct device *dev)
+{
+	struct iscsi_if_cnx *cnx;
 	struct Scsi_Host *shost;
-	struct iscsi_internal *i;
+	struct iscsi_internal *priv;
 
-	if (!scsi_is_target_device(dev))
+	if (!iscsi_is_cnx_dev(dev))
 		return 0;
 
-	shost = dev_to_shost(dev->parent);
-	if (!shost->transportt  || shost->transportt->host_attrs.ac.class
-	    != &iscsi_host_class.class)
+	cnx = iscsi_dev_to_if_cnx(dev);
+	shost = cnx->host;
+	if (!shost->transportt)
 		return 0;
 
-	i = to_iscsi_internal(shost->transportt);
-	
-	return &i->t.target_attrs.ac == cont;
+	priv = to_iscsi_internal(shost->transportt);
+	if (priv->connection_cont.ac.class != &iscsi_connection_class.class)
+		return 0;
+
+	return &priv->connection_cont.ac == cont;
 }
 
-struct scsi_transport_template *
-iscsi_attach_transport(struct iscsi_function_template *fnt)
+int iscsi_register_transport(struct iscsi_transport *tt)
 {
-	struct iscsi_internal *i = kmalloc(sizeof(struct iscsi_internal),
-					   GFP_KERNEL);
-	int count = 0;
+	struct iscsi_internal *priv;
+	int count = 0, i, id = -1;
 
-	if (unlikely(!i))
-		return NULL;
+	BUG_ON(!tt);
+	for (i = 0; i < ISCSI_TRANSPORT_MAX; i++) {
+		if (transport_table[i] == tt)
+			return -EEXIST;
+		if (!transport_table[i]) {
+			id = i;
+			break;
+		}
+	}
+	if (id == -1)
+		return -EPERM;
 
-	memset(i, 0, sizeof(struct iscsi_internal));
-	i->fnt = fnt;
+	priv = kmalloc(sizeof(struct iscsi_internal), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+	memset(priv, 0, sizeof(struct iscsi_internal));
+
+	priv->tt = tt;
+
+	/* setup parameters mask */
+	priv->param_mask = 0xFFFFFFFF;
+	if (!(tt->caps & CAP_MULTI_R2T))
+		priv->param_mask &= ~(1 << ISCSI_PARAM_MAX_R2T);
+	if (!(tt->caps & CAP_HDRDGST))
+		priv->param_mask &= ~(1 << ISCSI_PARAM_HDRDGST_EN);
+	if (!(tt->caps & CAP_DATADGST))
+		priv->param_mask &= ~(1 << ISCSI_PARAM_DATADGST_EN);
+
+	/* connection parameters */
+	priv->connection_cont.ac.attrs = &priv->connection_attrs[0];
+	priv->connection_cont.ac.class = &iscsi_connection_class.class;
+	priv->connection_cont.ac.match = iscsi_cnx_match;
+	transport_container_register(&priv->connection_cont);
+
+	SETUP_CONN_RD_ATTR(max_recv_dlength, ISCSI_PARAM_MAX_RECV_DLENGTH);
+	SETUP_CONN_RD_ATTR(max_xmit_dlength, ISCSI_PARAM_MAX_XMIT_DLENGTH);
+	SETUP_CONN_RD_ATTR(header_digest, ISCSI_PARAM_HDRDGST_EN);
+	SETUP_CONN_RD_ATTR(data_digest, ISCSI_PARAM_DATADGST_EN);
+	SETUP_CONN_RD_ATTR(ifmarker, ISCSI_PARAM_IFMARKER_EN);
+	SETUP_CONN_RD_ATTR(ofmarker, ISCSI_PARAM_OFMARKER_EN);
 
-	i->t.target_attrs.ac.attrs = &i->session_attrs[0];
-	i->t.target_attrs.ac.class = &iscsi_transport_class.class;
-	i->t.target_attrs.ac.match = iscsi_target_match;
-	transport_container_register(&i->t.target_attrs);
-	i->t.target_size = sizeof(struct iscsi_class_session);
-
-	SETUP_SESSION_RD_ATTR(tsih);
-	SETUP_SESSION_RD_ATTR(isid);
-	SETUP_SESSION_RD_ATTR(header_digest);
-	SETUP_SESSION_RD_ATTR(data_digest);
-	SETUP_SESSION_RD_ATTR(target_name);
-	SETUP_SESSION_RD_ATTR(target_alias);
-	SETUP_SESSION_RD_ATTR(port);
-	SETUP_SESSION_RD_ATTR(tpgt);
-	SETUP_SESSION_RD_ATTR(ip_address);
-	SETUP_SESSION_RD_ATTR(initial_r2t);
-	SETUP_SESSION_RD_ATTR(immediate_data);
-	SETUP_SESSION_RD_ATTR(max_recv_data_segment_len);
-	SETUP_SESSION_RD_ATTR(max_burst_len);
-	SETUP_SESSION_RD_ATTR(first_burst_len);
-	SETUP_SESSION_RD_ATTR(def_time2wait);
-	SETUP_SESSION_RD_ATTR(def_time2retain);
-	SETUP_SESSION_RD_ATTR(max_outstanding_r2t);
-	SETUP_SESSION_RD_ATTR(data_pdu_in_order);
-	SETUP_SESSION_RD_ATTR(data_sequence_in_order);
-	SETUP_SESSION_RD_ATTR(erl);
+	BUG_ON(count > ISCSI_CONN_ATTRS);
+	priv->connection_attrs[count] = NULL;
+	count = 0;
+
+	/* session parameters */
+	priv->session_cont.ac.attrs = &priv->session_attrs[0];
+	priv->session_cont.ac.class = &iscsi_session_class.class;
+	priv->session_cont.ac.match = iscsi_snx_match;
+	transport_container_register(&priv->session_cont);
+
+	SETUP_SESSION_RD_ATTR(initial_r2t, ISCSI_PARAM_INITIAL_R2T_EN);
+	SETUP_SESSION_RD_ATTR(max_outstanding_r2t, ISCSI_PARAM_MAX_R2T);
+	SETUP_SESSION_RD_ATTR(immediate_data, ISCSI_PARAM_IMM_DATA_EN);
+	SETUP_SESSION_RD_ATTR(first_burst_len, ISCSI_PARAM_FIRST_BURST);
+	SETUP_SESSION_RD_ATTR(max_burst_len, ISCSI_PARAM_MAX_BURST);
+	SETUP_SESSION_RD_ATTR(data_pdu_in_order, ISCSI_PARAM_PDU_INORDER_EN);
+	SETUP_SESSION_RD_ATTR(data_seq_in_order,ISCSI_PARAM_DATASEQ_INORDER_EN)
+	SETUP_SESSION_RD_ATTR(erl, ISCSI_PARAM_ERL);
 
 	BUG_ON(count > ISCSI_SESSION_ATTRS);
-	i->session_attrs[count] = NULL;
+	priv->session_attrs[count] = NULL;
 
-	i->t.host_attrs.ac.attrs = &i->host_attrs[0];
-	i->t.host_attrs.ac.class = &iscsi_host_class.class;
-	i->t.host_attrs.ac.match = iscsi_host_match;
-	transport_container_register(&i->t.host_attrs);
-	i->t.host_size = 0;
+	transport_table[id] = tt;
+	tt->scsi_transport = &priv->t;
+	printk("iscsi: registered transport (%d - %s)\n", id, tt->name);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(iscsi_register_transport);
 
-	count = 0;
-	SETUP_HOST_RD_ATTR(initiator_name);
-	SETUP_HOST_RD_ATTR(initiator_alias);
+int iscsi_unregister_transport(struct iscsi_transport *tt)
+{
+	struct iscsi_internal *priv = to_iscsi_internal(tt->scsi_transport);
+	int id;
 
-	BUG_ON(count > ISCSI_HOST_ATTRS);
-	i->host_attrs[count] = NULL;
+	BUG_ON(!tt);
 
-	return &i->t;
-}
+	down(&callsema);
+	if (iscsi_if_find_snx(tt)) {
+		up(&callsema);
+		return -EPERM;
+	}
+	id = iscsi_if_transport_lookup(tt);
+	BUG_ON (id < 0);
+	transport_container_unregister(&priv->connection_cont);
+	transport_container_unregister(&priv->session_cont);
+	kfree(priv);
+	transport_table[id] = NULL;
+	up(&callsema);
 
-EXPORT_SYMBOL(iscsi_attach_transport);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(iscsi_unregister_transport);
 
-void iscsi_release_transport(struct scsi_transport_template *t)
+static int
+iscsi_rcv_nl_event(struct notifier_block *this, unsigned long event, void *ptr)
 {
-	struct iscsi_internal *i = to_iscsi_internal(t);
+	struct netlink_notify *n = ptr;
 
-	transport_container_unregister(&i->t.target_attrs);
-	transport_container_unregister(&i->t.host_attrs);
-  
-	kfree(i);
+	if (event == NETLINK_URELEASE &&
+	    n->protocol == NETLINK_ISCSI && n->pid) {
+		struct iscsi_if_cnx *cnx;
+		unsigned long flags;
+
+		mempool_zone_complete(&z_reply);
+		spin_lock_irqsave(&cnxlock, flags);
+		list_for_each_entry(cnx, &cnxlist, item) {
+			mempool_zone_complete(&cnx->z_error);
+			mempool_zone_complete(&cnx->z_pdu);
+		}
+		spin_unlock_irqrestore(&cnxlock, flags);
+	}
+
+	return NOTIFY_DONE;
 }
 
-EXPORT_SYMBOL(iscsi_release_transport);
+static struct notifier_block iscsi_nl_notifier = {
+	.notifier_call	= iscsi_rcv_nl_event,
+};
 
 static __init int iscsi_transport_init(void)
 {
-	int err = transport_class_register(&iscsi_transport_class);
+	int err;
 
+	err = transport_class_register(&iscsi_connection_class);
 	if (err)
 		return err;
-	return transport_class_register(&iscsi_host_class);
+
+	err = transport_class_register(&iscsi_session_class);
+	if (err)
+		goto unregister_cnx_class;
+
+	netlink_register_notifier(&iscsi_nl_notifier);
+	nls = netlink_kernel_create(NETLINK_ISCSI, iscsi_if_rx);
+	if (!nls) {
+		err = -ENOBUFS;
+		goto unregister_notifier;
+	}
+
+	err = zone_init(&z_reply, Z_MAX_REPLY, Z_SIZE_REPLY, Z_HIWAT_REPLY);
+	if (!err)
+		return 0;
+
+	sock_release(nls->sk_socket);
+ unregister_notifier:
+	netlink_unregister_notifier(&iscsi_nl_notifier);
+ unregister_cnx_class:
+	transport_class_unregister(&iscsi_connection_class);
+	return err;
 }
 
 static void __exit iscsi_transport_exit(void)
 {
-	transport_class_unregister(&iscsi_host_class);
-	transport_class_unregister(&iscsi_transport_class);
+	mempool_destroy(z_reply.pool);
+	sock_release(nls->sk_socket);
+	netlink_unregister_notifier(&iscsi_nl_notifier);
+	transport_class_unregister(&iscsi_connection_class);
+	transport_class_unregister(&iscsi_session_class);
 }
 
 module_init(iscsi_transport_init);
 module_exit(iscsi_transport_exit);
 
-MODULE_AUTHOR("Mike Christie");
-MODULE_DESCRIPTION("iSCSI Transport Attributes");
+MODULE_AUTHOR("Mike Christie <michaelc@cs.wisc.edu>, "
+	      "Dmitry Yusupov <dmitry_yus@yahoo.com>, "
+	      "Alex Aizman <itn780@yahoo.com>");
+MODULE_DESCRIPTION("iSCSI Transport Interface");
 MODULE_LICENSE("GPL");
diff -aurp linux-2.6.12-rc3.orig/include/scsi/scsi_transport_iscsi.h linux-2.6.12-rc3.work/include/scsi/scsi_transport_iscsi.h
--- linux-2.6.12-rc3.orig/include/scsi/scsi_transport_iscsi.h	2005-04-20 17:03:16.000000000 -0700
+++ linux-2.6.12-rc3.work/include/scsi/scsi_transport_iscsi.h	2005-05-04 18:43:50.000000000 -0700
@@ -1,8 +1,8 @@
-/* 
+/*
  * iSCSI transport class definitions
  *
  * Copyright (C) IBM Corporation, 2004
- * Copyright (C) Mike Christie, 2004
+ * Copyright (C) Mike Christie, Dmitry Yusupov, Alex Aizman, 2004 - 2005
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -21,158 +21,68 @@
 #ifndef SCSI_TRANSPORT_ISCSI_H
 #define SCSI_TRANSPORT_ISCSI_H
 
-#include <linux/config.h>
-#include <linux/in6.h>
-#include <linux/in.h>
-
-struct scsi_transport_template;
+#include <scsi/iscsi_if.h>
 
-struct iscsi_class_session {
-	uint8_t isid[6];
-	uint16_t tsih;
-	int header_digest;		/* 1 CRC32, 0 None */
-	int data_digest;		/* 1 CRC32, 0 None */
-	uint16_t tpgt;
-	union {
-		struct in6_addr sin6_addr;
-		struct in_addr sin_addr;
-	} u;
-	sa_family_t addr_type;		/* must be AF_INET or AF_INET6 */
-	uint16_t port;			/* must be in network byte order */
-	int initial_r2t;		/* 1 Yes, 0 No */
-	int immediate_data;		/* 1 Yes, 0 No */
-	uint32_t max_recv_data_segment_len;
-	uint32_t max_burst_len;
-	uint32_t first_burst_len;
-	uint16_t def_time2wait;
-	uint16_t def_time2retain;
-	uint16_t max_outstanding_r2t;
-	int data_pdu_in_order;		/* 1 Yes, 0 No */
-	int data_sequence_in_order;	/* 1 Yes, 0 No */
-	int erl;
+/**
+ * struct iscsi_transport - iSCSI Transport template
+ *
+ * @name:        transport name
+ * @caps:        iSCSI Data-Path capabilities
+ * @create_snx:  create new iSCSI session object
+ * @destroy_snx: destroy existing iSCSI session object
+ * @create_cnx:  create new iSCSI connection
+ * @bind_cnx:    associate this connection with existing iSCSI session and
+ *               specified transport descriptor
+ * @destroy_cnx: destroy inactive iSCSI connection
+ * @set_param:   set iSCSI Data-Path operational parameter
+ * @start_cnx:   set connection to be operational
+ * @stop_cnx:    suspend/recover/terminate connection
+ * @send_pdu:    send iSCSI PDU, Login, Logout, NOP-Out, Reject, Text.
+ *
+ * Template API provided by iSCSI Transport
+ */
+struct iscsi_transport {
+	struct module *owner;
+	char *name;
+	unsigned int caps;
+	struct scsi_host_template *host_template;
+	int hostdata_size;
+	int max_lun;
+	unsigned int max_cnx;
+	unsigned int max_cmd_len;
+	iscsi_snx_t (*create_session) (uint32_t initial_cmdsn,
+				       struct Scsi_Host *shost);
+	void (*destroy_session) (iscsi_snx_t snx);
+	iscsi_cnx_t (*create_cnx) (iscsi_snx_t snx, uint32_t cid);
+	int (*bind_cnx) (iscsi_snx_t snx, iscsi_cnx_t cnx,
+			uint32_t transport_fd, int is_leading);
+	int (*start_cnx) (iscsi_cnx_t cnx);
+	void (*stop_cnx) (iscsi_cnx_t cnx, int flag);
+	void (*destroy_cnx) (iscsi_cnx_t cnx);
+	int (*set_param) (iscsi_cnx_t cnx, enum iscsi_param param,
+			  uint32_t value);
+	int (*get_param) (iscsi_cnx_t cnx, enum iscsi_param param,
+			  uint32_t *value);
+	int (*send_pdu) (iscsi_cnx_t cnx, struct iscsi_hdr *hdr,
+			 char *data, uint32_t data_size);
+	void (*get_stats) (iscsi_cnx_t cnx, struct iscsi_stats *stats);
+	/*
+	 * transport class private data
+	 */
+	struct scsi_transport_template *scsi_transport;
 };
 
 /*
- * accessor macros
+ * transport registration upcalls
  */
-#define iscsi_isid(x) \
-	(((struct iscsi_class_session *)&(x)->starget_data)->isid)
-#define iscsi_tsih(x) \
-	(((struct iscsi_class_session *)&(x)->starget_data)->tsih)
-#define iscsi_header_digest(x) \
-	(((struct iscsi_class_session *)&(x)->starget_data)->header_digest)
-#define iscsi_data_digest(x) \
-	(((struct iscsi_class_session *)&(x)->starget_data)->data_digest)
-#define iscsi_port(x) \
-	(((struct iscsi_class_session *)&(x)->starget_data)->port)
-#define iscsi_addr_type(x) \
-	(((struct iscsi_class_session *)&(x)->starget_data)->addr_type)
-#define iscsi_sin_addr(x) \
-	(((struct iscsi_class_session *)&(x)->starget_data)->u.sin_addr)
-#define iscsi_sin6_addr(x) \
-	(((struct iscsi_class_session *)&(x)->starget_data)->u.sin6_addr)
-#define iscsi_tpgt(x) \
-	(((struct iscsi_class_session *)&(x)->starget_data)->tpgt)
-#define iscsi_initial_r2t(x) \
-	(((struct iscsi_class_session *)&(x)->starget_data)->initial_r2t)
-#define iscsi_immediate_data(x) \
-	(((struct iscsi_class_session *)&(x)->starget_data)->immediate_data)
-#define iscsi_max_recv_data_segment_len(x) \
-	(((struct iscsi_class_session *)&(x)->starget_data)->max_recv_data_segment_len)
-#define iscsi_max_burst_len(x) \
-	(((struct iscsi_class_session *)&(x)->starget_data)->max_burst_len)
-#define iscsi_first_burst_len(x) \
-	(((struct iscsi_class_session *)&(x)->starget_data)->first_burst_len)
-#define iscsi_def_time2wait(x) \
-	(((struct iscsi_class_session *)&(x)->starget_data)->def_time2wait)
-#define iscsi_def_time2retain(x) \
-	(((struct iscsi_class_session *)&(x)->starget_data)->def_time2retain)
-#define iscsi_max_outstanding_r2t(x) \
-	(((struct iscsi_class_session *)&(x)->starget_data)->max_outstanding_r2t)
-#define iscsi_data_pdu_in_order(x) \
-	(((struct iscsi_class_session *)&(x)->starget_data)->data_pdu_in_order)
-#define iscsi_data_sequence_in_order(x) \
-	(((struct iscsi_class_session *)&(x)->starget_data)->data_sequence_in_order)
-#define iscsi_erl(x) \
-	(((struct iscsi_class_session *)&(x)->starget_data)->erl)
+extern int iscsi_register_transport(struct iscsi_transport *tt);
+extern int iscsi_unregister_transport(struct iscsi_transport *tt);
 
 /*
- * The functions by which the transport class and the driver communicate
+ * control plane upcalls
  */
-struct iscsi_function_template {
-	/*
-	 * target attrs
-	 */
-	void (*get_isid)(struct scsi_target *);
-	void (*get_tsih)(struct scsi_target *);
-	void (*get_header_digest)(struct scsi_target *);
-	void (*get_data_digest)(struct scsi_target *);
-	void (*get_port)(struct scsi_target *);
-	void (*get_tpgt)(struct scsi_target *);
-	/*
-	 * In get_ip_address the lld must set the address and
-	 * the address type
-	 */
-	void (*get_ip_address)(struct scsi_target *);
-	/*
-	 * The lld should snprintf the name or alias to the buffer
-	 */
-	ssize_t (*get_target_name)(struct scsi_target *, char *, ssize_t);
-	ssize_t (*get_target_alias)(struct scsi_target *, char *, ssize_t);
-	void (*get_initial_r2t)(struct scsi_target *);
-	void (*get_immediate_data)(struct scsi_target *);
-	void (*get_max_recv_data_segment_len)(struct scsi_target *);
-	void (*get_max_burst_len)(struct scsi_target *);
-	void (*get_first_burst_len)(struct scsi_target *);
-	void (*get_def_time2wait)(struct scsi_target *);
-	void (*get_def_time2retain)(struct scsi_target *);
-	void (*get_max_outstanding_r2t)(struct scsi_target *);
-	void (*get_data_pdu_in_order)(struct scsi_target *);
-	void (*get_data_sequence_in_order)(struct scsi_target *);
-	void (*get_erl)(struct scsi_target *);
-
-	/*
-	 * host atts
-	 */
-
-	/*
-	 * The lld should snprintf the name or alias to the buffer
-	 */
-	ssize_t (*get_initiator_alias)(struct Scsi_Host *, char *, ssize_t);
-	ssize_t (*get_initiator_name)(struct Scsi_Host *, char *, ssize_t);
-	/*
-	 * The driver sets these to tell the transport class it
-	 * wants the attributes displayed in sysfs.  If the show_ flag
-	 * is not set, the attribute will be private to the transport
-	 * class. We could probably just test if a get_ fn was set
-	 * since we only use the values for sysfs but this is how
-	 * fc does it too.
-	 */
-	unsigned long show_isid:1;
-	unsigned long show_tsih:1;
-	unsigned long show_header_digest:1;
-	unsigned long show_data_digest:1;
-	unsigned long show_port:1;
-	unsigned long show_tpgt:1;
-	unsigned long show_ip_address:1;
-	unsigned long show_target_name:1;
-	unsigned long show_target_alias:1;
-	unsigned long show_initial_r2t:1;
-	unsigned long show_immediate_data:1;
-	unsigned long show_max_recv_data_segment_len:1;
-	unsigned long show_max_burst_len:1;
-	unsigned long show_first_burst_len:1;
-	unsigned long show_def_time2wait:1;
-	unsigned long show_def_time2retain:1;
-	unsigned long show_max_outstanding_r2t:1;
-	unsigned long show_data_pdu_in_order:1;
-	unsigned long show_data_sequence_in_order:1;
-	unsigned long show_erl:1;
-	unsigned long show_initiator_name:1;
-	unsigned long show_initiator_alias:1;
-};
-
-struct scsi_transport_template *iscsi_attach_transport(struct iscsi_function_template *);
-void iscsi_release_transport(struct scsi_transport_template *);
+extern void iscsi_cnx_error(iscsi_cnx_t cnx, enum iscsi_err error);
+extern int iscsi_recv_pdu(iscsi_cnx_t cnx, struct iscsi_hdr *hdr,
+				char *data, uint32_t data_size);
 
 #endif

--------------070207010201080506090305--
