Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261198AbVEOTn7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261198AbVEOTn7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 May 2005 15:43:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261157AbVEOTn7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 May 2005 15:43:59 -0400
Received: from sabe.cs.wisc.edu ([128.105.6.20]:51660 "EHLO sabe.cs.wisc.edu")
	by vger.kernel.org with ESMTP id S261217AbVEOTaf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 May 2005 15:30:35 -0400
Subject: [PATCH 3/3] add open iscsi netlink interface to iscsi transport
	class
From: Mike Christie <michaelc@cs.wisc.edu>
To: open-iscsi@googlegroups.com, netdev@oss.sgi.com,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       inux-iscsi-devel@lists.sourceforge.netl
Content-Type: text/plain
Message-Id: <1116185425.17308.14.camel@mina>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 15 May 2005 12:30:26 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

incorporate the open-iscsi/linux-iscsi netlink interface
into the iscsi transport class. 

See here for details on the sysfs layout
http://marc.theaimsgroup.com/?l=linux-kernel&m=111526269831567&w=2


diff -aurp linux-2.6.12-rc4/drivers/scsi/scsi_transport_iscsi.c linux-2.6.12-rc4.work/drivers/scsi/scsi_transport_iscsi.c
--- linux-2.6.12-rc4/drivers/scsi/scsi_transport_iscsi.c	2005-05-06 22:20:31.000000000 -0700
+++ linux-2.6.12-rc4.work/drivers/scsi/scsi_transport_iscsi.c	2005-05-14 12:20:22.000000000 -0700
@@ -1,8 +1,10 @@
-/* 
+/*
  * iSCSI transport class definitions
  *
  * Copyright (C) IBM Corporation, 2004
- * Copyright (C) Mike Christie, 2004
+ * Copyright (C) Mike Christie, 2004 - 2005
+ * Copyright (C) Dmitry Yusupov, 2004 - 2005
+ * Copyright (C) Alex Aizman, 2004 - 2005
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -19,370 +21,1189 @@
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
+	struct iscsi_transport *iscsi_transport;
+	struct list_head list;
+	/*
+	 * List of sessions for this transport
+	 */
+	struct list_head sessions;
+	/*
+	 * lock to serialize access to the sessions list which must
+	 * be taken after the rx_queue_sema
+	 */
+	spinlock_t session_lock;
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
+	struct transport_container conn_cont;
+	struct class_device_attribute *conn_attrs[ISCSI_CONN_ATTRS + 1];
+	struct transport_container session_cont;
 	struct class_device_attribute *session_attrs[ISCSI_SESSION_ATTRS + 1];
-	struct class_device_attribute *host_attrs[ISCSI_HOST_ATTRS + 1];
 };
 
+/*
+ * list of registered transports and lock that must
+ * be held while accessing list. The iscsi_transport_lock must
+ * be acquired after the rx_queue_sema.
+ */
+static LIST_HEAD(iscsi_transports);
+static DEFINE_SPINLOCK(iscsi_transport_lock);
+
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
+
+static struct sock *nls;
+static int daemon_pid;
+static DECLARE_MUTEX(rx_queue_sema);
+
+struct mempool_zone {
+	mempool_t *pool;
+	atomic_t allocated;
+	int size;
+	int hiwat;
+	struct list_head freequeue;
+	spinlock_t freelock;
+};
+
+static struct mempool_zone z_reply;
+
 /*
- * iSCSI target and session attrs
+ * Z_MAX_* - actual mempool size allocated at the mempool_zone_init() time
+ * Z_HIWAT_* - zone's high watermark when if_error bit will be set to -ENOMEM
+ *             so daemon will notice OOM on NETLINK tranposrt level and will
+ *             be able to predict or change operational behavior
  */
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
+#define Z_MAX_REPLY	8
+#define Z_HIWAT_REPLY	6
+#define Z_MAX_PDU	8
+#define Z_HIWAT_PDU	6
+#define Z_MAX_ERROR	16
+#define Z_HIWAT_ERROR	12
+
+struct iscsi_if_conn {
+	struct list_head conn_list;	/* item in connlist */
+	struct list_head session_list;	/* item in session->connections */
+	iscsi_connh_t connh;
+	int active;			/* must be accessed with the connlock */
+	struct Scsi_Host *host;		/* originated shost */
+	struct device dev;		/* sysfs transport/container device */
+	struct iscsi_transport *transport;
+	struct mempool_zone z_error;
+	struct mempool_zone z_pdu;
+	struct list_head freequeue;
+};
 
+#define iscsi_dev_to_if_conn(_dev) \
+	container_of(_dev, struct iscsi_if_conn, dev)
 
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
+#define iscsi_cdev_to_if_conn(_cdev) \
+	iscsi_dev_to_if_conn(_cdev->dev)
+
+static LIST_HEAD(connlist);
+static DEFINE_SPINLOCK(connlock);
+
+struct iscsi_if_session {
+	struct list_head list;	/* item in session_list */
+	struct list_head connections;
+	iscsi_sessionh_t sessionh;
+	struct iscsi_transport *transport;
+	struct device dev;	/* sysfs transport/container device */
+};
+
+#define iscsi_dev_to_if_session(_dev) \
+	container_of(_dev, struct iscsi_if_session, dev)
+
+#define iscsi_cdev_to_if_session(_cdev) \
+	iscsi_dev_to_if_session(_cdev->dev)
+
+#define iscsi_if_session_to_shost(_session) \
+	dev_to_shost(_session->dev.parent)
+
+static struct iscsi_if_conn*
+iscsi_if_find_conn(uint64_t key)
+{
+	unsigned long flags;
+	struct iscsi_if_conn *conn;
+
+	spin_lock_irqsave(&connlock, flags);
+	list_for_each_entry(conn, &connlist, conn_list)
+		if (conn->connh == key) {
+			spin_unlock_irqrestore(&connlock, flags);
+			return conn;
+		}
+	spin_unlock_irqrestore(&connlock, flags);
+	return NULL;
 }
 
-#define iscsi_session_rd_bool_attr(field)				\
-	iscsi_session_show_bool_fn(field)				\
-static CLASS_DEVICE_ATTR(field, S_IRUGO, show_session_bool_##field, NULL);
+static struct iscsi_internal *
+iscsi_if_transport_lookup(struct iscsi_transport *tt)
+{
+	struct iscsi_internal *priv;
+	unsigned long flags;
 
-iscsi_session_rd_bool_attr(initial_r2t);
-iscsi_session_rd_bool_attr(immediate_data);
-iscsi_session_rd_bool_attr(data_pdu_in_order);
-iscsi_session_rd_bool_attr(data_sequence_in_order);
+	spin_lock_irqsave(&iscsi_transport_lock, flags);
+	list_for_each_entry(priv, &iscsi_transports, list)
+		if (tt == priv->iscsi_transport) {
+			spin_unlock_irqrestore(&iscsi_transport_lock, flags);
+			return priv;
+		}
+	spin_unlock_irqrestore(&iscsi_transport_lock, flags);
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
+static inline struct list_head *skb_to_lh(struct sk_buff *skb)
+{
+	return (struct list_head *)&skb->cb;
 }
 
-#define iscsi_session_rd_digest_attr(field)				\
-	iscsi_session_show_digest_fn(field)				\
-static CLASS_DEVICE_ATTR(field, S_IRUGO, show_##field, NULL);
+static void*
+mempool_zone_alloc_skb(unsigned int gfp_mask, void *pool_data)
+{
+	struct mempool_zone *zone = pool_data;
 
-iscsi_session_rd_digest_attr(header_digest);
-iscsi_session_rd_digest_attr(data_digest);
+	return alloc_skb(zone->size, gfp_mask);
+}
 
-static ssize_t
-show_port(struct class_device *cdev, char *buf)
+static void
+mempool_zone_free_skb(void *element, void *pool_data)
 {
-	struct scsi_target *starget = transport_class_to_starget(cdev);
-	struct Scsi_Host *shost = dev_to_shost(starget->dev.parent);
-	struct iscsi_internal *i = to_iscsi_internal(shost->transportt);
+	kfree_skb(element);
+}
 
-	if (i->fnt->get_port)
-		i->fnt->get_port(starget);
+static void
+mempool_zone_complete(struct mempool_zone *zone)
+{
+	unsigned long flags;
+	struct list_head *lh, *n;
 
-	return snprintf(buf, 20, "%hu\n", ntohs(iscsi_port(starget)));
+	spin_lock_irqsave(&zone->freelock, flags);
+	list_for_each_safe(lh, n, &zone->freequeue) {
+		struct sk_buff *skb = (struct sk_buff *)((char *)lh -
+				offsetof(struct sk_buff, cb));
+		if (!skb_shared(skb)) {
+			list_del(skb_to_lh(skb));
+			mempool_free(skb, zone->pool);
+			atomic_dec(&zone->allocated);
+		}
+	}
+	spin_unlock_irqrestore(&zone->freelock, flags);
 }
-static CLASS_DEVICE_ATTR(port, S_IRUGO, show_port, NULL);
 
-static ssize_t
-show_ip_address(struct class_device *cdev, char *buf)
+static int
+mempool_zone_init(struct mempool_zone *zp, unsigned max, unsigned size,
+		unsigned hiwat)
 {
-	struct scsi_target *starget = transport_class_to_starget(cdev);
-	struct Scsi_Host *shost = dev_to_shost(starget->dev.parent);
-	struct iscsi_internal *i = to_iscsi_internal(shost->transportt);
+	zp->pool = mempool_create(max, mempool_zone_alloc_skb,
+				  mempool_zone_free_skb, zp);
+	if (!zp->pool)
+		return -ENOMEM;
+
+	zp->size = size;
+	zp->hiwat = hiwat;
+
+	INIT_LIST_HEAD(&zp->freequeue);
+	spin_lock_init(&zp->freelock);
+	atomic_set(&zp->allocated, 0);
+
+	return 0;
+}
 
-	if (i->fnt->get_ip_address)
-		i->fnt->get_ip_address(starget);
 
-	if (iscsi_addr_type(starget) == AF_INET)
-		return sprintf(buf, "%u.%u.%u.%u\n",
-			       NIPQUAD(iscsi_sin_addr(starget)));
-	else if(iscsi_addr_type(starget) == AF_INET6)
-		return sprintf(buf, "%04x:%04x:%04x:%04x:%04x:%04x:%04x:%04x\n",
-			       NIP6(iscsi_sin6_addr(starget)));
-	return -EINVAL;
+static struct sk_buff*
+mempool_zone_get_skb(struct mempool_zone *zone)
+{
+	struct sk_buff *skb;
+
+	skb = mempool_alloc(zone->pool, GFP_ATOMIC);
+	if (skb)
+		atomic_inc(&zone->allocated);
+	return skb;
 }
-static CLASS_DEVICE_ATTR(ip_address, S_IRUGO, show_ip_address, NULL);
 
-static ssize_t
-show_isid(struct class_device *cdev, char *buf)
+static int
+iscsi_unicast_skb(struct mempool_zone *zone, struct sk_buff *skb)
 {
-	struct scsi_target *starget = transport_class_to_starget(cdev);
-	struct Scsi_Host *shost = dev_to_shost(starget->dev.parent);
-	struct iscsi_internal *i = to_iscsi_internal(shost->transportt);
+	unsigned long flags;
+	int rc;
+
+	skb_get(skb);
+	rc = netlink_unicast(nls, skb, daemon_pid, MSG_DONTWAIT);
+	if (rc < 0) {
+		mempool_free(skb, zone->pool);
+		printk(KERN_ERR "iscsi: can not unicast skb (%d)\n", rc);
+		return rc;
+	}
 
-	if (i->fnt->get_isid)
-		i->fnt->get_isid(starget);
+	spin_lock_irqsave(&zone->freelock, flags);
+	list_add(skb_to_lh(skb), &zone->freequeue);
+	spin_unlock_irqrestore(&zone->freelock, flags);
 
-	return sprintf(buf, "%02x%02x%02x%02x%02x%02x\n",
-		       iscsi_isid(starget)[0], iscsi_isid(starget)[1],
-		       iscsi_isid(starget)[2], iscsi_isid(starget)[3],
-		       iscsi_isid(starget)[4], iscsi_isid(starget)[5]);
+	return 0;
 }
-static CLASS_DEVICE_ATTR(isid, S_IRUGO, show_isid, NULL);
 
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
+int iscsi_recv_pdu(iscsi_connh_t connh, struct iscsi_hdr *hdr,
+		   char *data, uint32_t data_size)
+{
+	struct nlmsghdr	*nlh;
+	struct sk_buff *skb;
+	struct iscsi_uevent *ev;
+	struct iscsi_if_conn *conn;
+	char *pdu;
+	int len = NLMSG_SPACE(sizeof(*ev) + sizeof(struct iscsi_hdr) +
+			      data_size);
+
+	conn = iscsi_if_find_conn(connh);
+	BUG_ON(!conn);
+
+	mempool_zone_complete(&conn->z_pdu);
+
+	skb = mempool_zone_get_skb(&conn->z_pdu);
+	if (!skb) {
+		iscsi_conn_error(connh, ISCSI_ERR_CONN_FAILED);
+		printk(KERN_ERR "iscsi%d: can not deliver control PDU: OOM\n",
+		       conn->host->host_no);
+		return -ENOMEM;
+	}
+
+	nlh = __nlmsg_put(skb, daemon_pid, 0, 0, (len - sizeof(*nlh)));
+	ev = NLMSG_DATA(nlh);
+	memset(ev, 0, sizeof(*ev));
+	ev->transport_handle = iscsi_handle(conn->transport);
+	ev->type = ISCSI_KEVENT_RECV_PDU;
+	if (atomic_read(&conn->z_pdu.allocated) >= conn->z_pdu.hiwat)
+		ev->iferror = -ENOMEM;
+	ev->r.recv_req.conn_handle = connh;
+	pdu = (char*)ev + sizeof(*ev);
+	memcpy(pdu, hdr, sizeof(struct iscsi_hdr));
+	memcpy(pdu + sizeof(struct iscsi_hdr), data, data_size);
+
+	return iscsi_unicast_skb(&conn->z_pdu, skb);
 }
+EXPORT_SYMBOL_GPL(iscsi_recv_pdu);
 
-#define iscsi_session_rd_str_attr(field)				\
-	iscsi_session_show_str_fn(field)				\
-static CLASS_DEVICE_ATTR(field, S_IRUGO, show_session_str_##field, NULL);
+void iscsi_conn_error(iscsi_connh_t connh, enum iscsi_err error)
+{
+	struct nlmsghdr	*nlh;
+	struct sk_buff	*skb;
+	struct iscsi_uevent *ev;
+	struct iscsi_if_conn *conn;
+	int len = NLMSG_SPACE(sizeof(*ev));
+
+	conn = iscsi_if_find_conn(connh);
+	BUG_ON(!conn);
+
+	mempool_zone_complete(&conn->z_error);
+
+	skb = mempool_zone_get_skb(&conn->z_error);
+	if (!skb) {
+		printk(KERN_ERR "iscsi%d: gracefully ignored conn error (%d)\n",
+		       conn->host->host_no, error);
+		return;
+	}
+
+	nlh = __nlmsg_put(skb, daemon_pid, 0, 0, (len - sizeof(*nlh)));
+	ev = NLMSG_DATA(nlh);
+	ev->transport_handle = iscsi_handle(conn->transport);
+	ev->type = ISCSI_KEVENT_CONN_ERROR;
+	if (atomic_read(&conn->z_error.allocated) >= conn->z_error.hiwat)
+		ev->iferror = -ENOMEM;
+	ev->r.connerror.error = error;
+	ev->r.connerror.conn_handle = connh;
 
-iscsi_session_rd_str_attr(target_name);
-iscsi_session_rd_str_attr(target_alias);
+	iscsi_unicast_skb(&conn->z_error, skb);
+
+	printk(KERN_INFO "iscsi%d: detected conn error (%d)\n",
+	       conn->host->host_no, error);
+}
+EXPORT_SYMBOL_GPL(iscsi_conn_error);
+
+static int
+iscsi_if_send_reply(int pid, int seq, int type, int done, int multi,
+		      void *payload, int size)
+{
+	struct sk_buff	*skb;
+	struct nlmsghdr	*nlh;
+	int len = NLMSG_SPACE(size);
+	int flags = multi ? NLM_F_MULTI : 0;
+	int t = done ? NLMSG_DONE  : type;
+
+	mempool_zone_complete(&z_reply);
+
+	skb = mempool_zone_get_skb(&z_reply);
+	/*
+	 * FIXME:
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
+ *    |------------------| <== hostdata_session(host->hostdata)
+ *    | interface's data |
+ *    *------------------*
  */
 
+#define hostdata_privsize(_t)	(sizeof(unsigned long) + _t->hostdata_size + \
+				 _t->hostdata_size % sizeof(unsigned long) + \
+				 sizeof(struct iscsi_if_session))
+
+#define hostdata_session(_hostdata) ((void*)_hostdata + sizeof(unsigned long) + \
+			((struct iscsi_transport *) \
+			 iscsi_ptr(*(uint64_t *)_hostdata))->hostdata_size)
+
+static void iscsi_if_session_dev_release(struct device *dev)
+{
+	struct iscsi_if_session *session = iscsi_dev_to_if_session(dev);
+	struct iscsi_transport *transport = session->transport;
+	struct Scsi_Host *shost = iscsi_if_session_to_shost(session);
+	struct iscsi_if_conn *conn, *tmp;
+	unsigned long flags;
+
+	/* now free connections */
+	spin_lock_irqsave(&connlock, flags);
+	list_for_each_entry_safe(conn, tmp, &session->connections,
+				 session_list) {
+		list_del(&conn->session_list);
+		mempool_destroy(conn->z_pdu.pool);
+		mempool_destroy(conn->z_error.pool);
+		kfree(conn);
+	}
+	spin_unlock_irqrestore(&connlock, flags);
+	scsi_host_put(shost);
+	module_put(transport->owner);
+}
+
+static int
+iscsi_if_create_session(struct iscsi_internal *priv, struct iscsi_uevent *ev)
+{
+	struct iscsi_transport *transport = priv->iscsi_transport;
+	struct iscsi_if_session *session;
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
+		printk(KERN_ERR "iscsi: can not allocate SCSI host for "
+		       "session\n");
+		error = -ENOMEM;
+		goto out_module_put;
+	}
+	shost->max_id = 1;
+	shost->max_channel = 0;
+	shost->max_lun = transport->max_lun;
+	shost->max_cmd_len = transport->max_cmd_len;
+	shost->transportt = &priv->t;
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
+	/* initialize session */
+	session = hostdata_session(shost->hostdata);
+	INIT_LIST_HEAD(&session->connections);
+	INIT_LIST_HEAD(&session->list);
+	session->sessionh = ev->r.c_session_ret.session_handle;
+	session->transport = transport;
+
+	error = scsi_add_host(shost, NULL);
+	if (error)
+		goto out_destroy_session;
+
+	/*
+	 * this is released in the dev's release function)
+	 */
+	scsi_host_get(shost);
+	snprintf(session->dev.bus_id, BUS_ID_SIZE, "session%u", shost->host_no);
+	session->dev.parent = &shost->shost_gendev;
+	session->dev.release = iscsi_if_session_dev_release;
+	error = device_register(&session->dev);
+	if (error) {
+		printk(KERN_ERR "iscsi: could not register session%d's dev\n",
+		       shost->host_no);
+		goto out_remove_host;
+	}
+	transport_register_device(&session->dev);
+
+	/* add this session to the list of active sessions */
+	spin_lock_irqsave(&priv->session_lock, flags);
+	list_add(&session->list, &priv->sessions);
+	spin_unlock_irqrestore(&priv->session_lock, flags);
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
+iscsi_if_destroy_session(struct iscsi_internal *priv, struct iscsi_uevent *ev)
+{
+	struct iscsi_transport *transport = priv->iscsi_transport;
+	struct Scsi_Host *shost;
+	struct iscsi_if_session *session;
+	unsigned long flags;
+	struct iscsi_if_conn *conn;
+	int error = 0;
+
+	shost = scsi_host_lookup(ev->u.d_session.sid);
+	if (shost == ERR_PTR(-ENXIO))
+		return -EEXIST;
+	session = hostdata_session(shost->hostdata);
+
+	/* check if we have active connections */
+	spin_lock_irqsave(&connlock, flags);
+	list_for_each_entry(conn, &session->connections, session_list) {
+		if (conn->active) {
+			printk(KERN_ERR "iscsi%d: can not destroy session: "
+			       "has active connection (%p)\n",
+			       shost->host_no, iscsi_ptr(conn->connh));
+			spin_unlock_irqrestore(&connlock, flags);
+			error = EIO;
+			goto out_release_ref;
+		}
+	}
+	spin_unlock_irqrestore(&connlock, flags);
+
+	scsi_remove_host(shost);
+	transport->destroy_session(ev->u.d_session.session_handle);
+	transport_unregister_device(&session->dev);
+	device_unregister(&session->dev);
+
+	/* remove this session from the list of active sessions */
+	spin_lock_irqsave(&priv->session_lock, flags);
+	list_del(&session->list);
+	spin_unlock_irqrestore(&priv->session_lock, flags);
+
+	/* ref from host alloc */
+	scsi_host_put(shost);
+ out_release_ref:
+	/* ref from host lookup */
+	scsi_host_put(shost);
+	return error;
+}
+
+static void iscsi_if_conn_dev_release(struct device *dev)
+{
+	struct iscsi_if_conn *conn = iscsi_dev_to_if_conn(dev);
+	struct Scsi_Host *shost = conn->host;
+
+	scsi_host_put(shost);
+}
+
+static int
+iscsi_if_create_conn(struct iscsi_transport *transport, struct iscsi_uevent *ev)
+{
+	struct iscsi_if_session *session;
+	struct Scsi_Host *shost;
+	struct iscsi_if_conn *conn;
+	unsigned long flags;
+	int error;
+
+	shost = scsi_host_lookup(ev->u.c_conn.sid);
+	if (shost == ERR_PTR(-ENXIO))
+		return -EEXIST;
+	session = hostdata_session(shost->hostdata);
+
+	conn = kmalloc(sizeof(struct iscsi_if_conn), GFP_KERNEL);
+	if (!conn) {
+		error = -ENOMEM;
+		goto out_release_ref;
+	}
+	memset(conn, 0, sizeof(struct iscsi_if_conn));
+	INIT_LIST_HEAD(&conn->session_list);
+	INIT_LIST_HEAD(&conn->conn_list);
+	conn->host = shost;
+	conn->transport = transport;
+
+	error = mempool_zone_init(&conn->z_pdu, Z_MAX_PDU,
+			NLMSG_SPACE(sizeof(struct iscsi_uevent) +
+				    sizeof(struct iscsi_hdr) +
+				    DEFAULT_MAX_RECV_DATA_SEGMENT_LENGTH),
+			Z_HIWAT_PDU);
+	if (error) {
+		printk(KERN_ERR "iscsi%d: can not allocate pdu zone for new "
+		       "conn\n", shost->host_no);
+		goto out_free_conn;
+	}
+	error = mempool_zone_init(&conn->z_error, Z_MAX_ERROR,
+			NLMSG_SPACE(sizeof(struct iscsi_uevent)),
+			Z_HIWAT_ERROR);
+	if (error) {
+		printk(KERN_ERR "iscsi%d: can not allocate error zone for "
+		       "new conn\n", shost->host_no);
+		goto out_free_pdu_pool;
+	}
+
+	ev->r.handle = transport->create_conn(ev->u.c_conn.session_handle,
+					ev->u.c_conn.cid);
+	if (!ev->r.handle) {
+		error = -ENODEV;
+		goto out_free_error_pool;
+	}
+
+	conn->connh = ev->r.handle;
+
+	/*
+	 * this is released in the dev's release function
+	 */
+	if (!scsi_host_get(shost))
+		goto out_destroy_conn;
+	snprintf(conn->dev.bus_id, BUS_ID_SIZE, "connection%d:%u",
+		 shost->host_no, ev->u.c_conn.cid);
+	conn->dev.parent = &session->dev;
+	conn->dev.release = iscsi_if_conn_dev_release;
+	error = device_register(&conn->dev);
+	if (error) {
+		printk(KERN_ERR "iscsi%d: could not register connections%u "
+		       "dev\n", shost->host_no, ev->u.c_conn.cid);
+		goto out_release_parent_ref;
+	}
+	transport_register_device(&conn->dev);
+
+	spin_lock_irqsave(&connlock, flags);
+	list_add(&conn->conn_list, &connlist);
+	list_add(&conn->session_list, &session->connections);
+	conn->active = 1;
+	spin_unlock_irqrestore(&connlock, flags);
+
+	scsi_host_put(shost);
+	return 0;
+
+ out_release_parent_ref:
+	scsi_host_put(shost);
+ out_destroy_conn:
+	transport->destroy_conn(ev->r.handle);
+ out_free_error_pool:
+	mempool_destroy(conn->z_error.pool);
+ out_free_pdu_pool:
+	mempool_destroy(conn->z_pdu.pool);
+ out_free_conn:
+	kfree(conn);
+ out_release_ref:
+	scsi_host_put(shost);
+	return error;
+}
+
+static int
+iscsi_if_destroy_conn(struct iscsi_transport *transport, struct iscsi_uevent *ev)
+{
+	unsigned long flags;
+	struct iscsi_if_conn *conn;
+
+	conn = iscsi_if_find_conn(ev->u.d_conn.conn_handle);
+	if (!conn)
+		return -EEXIST;
+
+	transport->destroy_conn(ev->u.d_conn.conn_handle);
+
+	spin_lock_irqsave(&connlock, flags);
+	conn->active = 0;
+	list_del(&conn->conn_list);
+	spin_unlock_irqrestore(&connlock, flags);
+
+	transport_unregister_device(&conn->dev);
+	device_unregister(&conn->dev);
+	return 0;
+}
+
+static int
+iscsi_if_get_stats(struct iscsi_transport *transport, struct sk_buff *skb,
+		   struct nlmsghdr *nlh)
+{
+	struct iscsi_uevent *ev = NLMSG_DATA(nlh);
+	struct iscsi_stats *stats;
+	struct sk_buff *skbstat;
+	struct iscsi_if_conn *conn;
+	struct nlmsghdr	*nlhstat;
+	struct iscsi_uevent *evstat;
+	int len = NLMSG_SPACE(sizeof(*ev) +
+			      sizeof(struct iscsi_stats) +
+			      sizeof(struct iscsi_stats_custom) *
+			      ISCSI_STATS_CUSTOM_MAX);
+	int err = 0;
+
+	conn = iscsi_if_find_conn(ev->u.get_stats.conn_handle);
+	if (!conn)
+		return -EEXIST;
+
+	do {
+		int actual_size;
+
+		mempool_zone_complete(&conn->z_pdu);
+
+		skbstat = mempool_zone_get_skb(&conn->z_pdu);
+		if (!skbstat) {
+			printk(KERN_ERR "iscsi%d: can not deliver stats: OOM\n",
+			       conn->host->host_no);
+			return -ENOMEM;
+		}
+
+		nlhstat = __nlmsg_put(skbstat, daemon_pid, 0, 0,
+				      (len - sizeof(*nlhstat)));
+		evstat = NLMSG_DATA(nlhstat);
+		memset(evstat, 0, sizeof(*evstat));
+		evstat->transport_handle = iscsi_handle(conn->transport);
+		evstat->type = nlh->nlmsg_type;
+		if (atomic_read(&conn->z_pdu.allocated) >= conn->z_pdu.hiwat)
+			evstat->iferror = -ENOMEM;
+		evstat->u.get_stats.conn_handle =
+			ev->u.get_stats.conn_handle;
+		stats = (struct iscsi_stats *)
+			((char*)evstat + sizeof(*evstat));
+		memset(stats, 0, sizeof(*stats));
+
+		transport->get_stats(ev->u.get_stats.conn_handle, stats);
+		actual_size = NLMSG_SPACE(sizeof(struct iscsi_uevent) +
+					  sizeof(struct iscsi_stats) +
+					  sizeof(struct iscsi_stats_custom) *
+					  stats->custom_length);
+		actual_size -= sizeof(*nlhstat);
+		actual_size = NLMSG_LENGTH(actual_size);
+		skb_trim(skb, NLMSG_ALIGN(actual_size));
+		nlhstat->nlmsg_len = actual_size;
+
+		err = iscsi_unicast_skb(&conn->z_pdu, skbstat);
+	} while (err < 0 && err != -ECONNREFUSED);
+
+	return err;
+}
+
+static int
+iscsi_if_recv_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
+{
+	int err = 0;
+	struct iscsi_uevent *ev = NLMSG_DATA(nlh);
+	struct iscsi_transport *transport = NULL;
+	struct iscsi_internal *priv;
+
+	if (NETLINK_CREDS(skb)->uid)
+		return -EPERM;
+
+	priv = iscsi_if_transport_lookup(iscsi_ptr(ev->transport_handle));
+	if (priv)
+		transport = priv->iscsi_transport;
+	else if (nlh->nlmsg_type != ISCSI_UEVENT_TRANS_LIST)
+		return -EEXIST;
+
+	daemon_pid = NETLINK_CREDS(skb)->pid;
+
+	switch (nlh->nlmsg_type) {
+	case ISCSI_UEVENT_TRANS_LIST: {
+		unsigned long flags;
+
+		/*
+		 * this will always succeed for now since there
+		 * is only one transport. We can kill this event
+		 * and just export the info in sysfs when we settle
+		 * the iscsi sysfs layout debate
+		 */
+		spin_lock_irqsave(&iscsi_transport_lock, flags);
+		list_for_each_entry(priv, &iscsi_transports, list) {
+			ev->r.t_list.elements[0].trans_handle =
+					iscsi_handle(priv->iscsi_transport);
+			strncpy(ev->r.t_list.elements[0].name,
+				priv->iscsi_transport->name,
+				ISCSI_TRANSPORT_NAME_MAXLEN);
+		}
+		spin_unlock_irqrestore(&iscsi_transport_lock, flags);
+
+	      } break;
+	case ISCSI_UEVENT_CREATE_SESSION:
+		err = iscsi_if_create_session(priv, ev);
+		break;
+	case ISCSI_UEVENT_DESTROY_SESSION:
+		err = iscsi_if_destroy_session(priv, ev);
+		break;
+	case ISCSI_UEVENT_CREATE_CONN:
+		err = iscsi_if_create_conn(transport, ev);
+		break;
+	case ISCSI_UEVENT_DESTROY_CONN:
+		err = iscsi_if_destroy_conn(transport, ev);
+		break;
+	case ISCSI_UEVENT_BIND_CONN:
+		if (!iscsi_if_find_conn(ev->u.b_conn.conn_handle))
+			return -EEXIST;
+		ev->r.retcode = transport->bind_conn(
+			ev->u.b_conn.session_handle,
+			ev->u.b_conn.conn_handle,
+			ev->u.b_conn.transport_fd,
+			ev->u.b_conn.is_leading);
+		break;
+	case ISCSI_UEVENT_SET_PARAM:
+		if (!iscsi_if_find_conn(ev->u.set_param.conn_handle))
+			return -EEXIST;
+		ev->r.retcode = transport->set_param(
+			ev->u.set_param.conn_handle,
+			ev->u.set_param.param, ev->u.set_param.value);
+		break;
+	case ISCSI_UEVENT_START_CONN:
+		if (!iscsi_if_find_conn(ev->u.start_conn.conn_handle))
+			return -EEXIST;
+		ev->r.retcode = transport->start_conn(
+			ev->u.start_conn.conn_handle);
+		break;
+	case ISCSI_UEVENT_STOP_CONN:
+		if (!iscsi_if_find_conn(ev->u.stop_conn.conn_handle))
+			return -EEXIST;
+		transport->stop_conn(ev->u.stop_conn.conn_handle,
+			ev->u.stop_conn.flag);
+		break;
+	case ISCSI_UEVENT_SEND_PDU:
+		if (!iscsi_if_find_conn(ev->u.send_pdu.conn_handle))
+			return -EEXIST;
+		ev->r.retcode = transport->send_pdu(
+		       ev->u.send_pdu.conn_handle,
+		       (struct iscsi_hdr*)((char*)ev + sizeof(*ev)),
+		       (char*)ev + sizeof(*ev) + ev->u.send_pdu.hdr_size,
+			ev->u.send_pdu.data_size);
+		break;
+	case ISCSI_UEVENT_GET_STATS:
+		err = iscsi_if_get_stats(transport, skb, nlh);
+		break;
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
+	down(&rx_queue_sema);
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
+				if (atomic_read(&z_reply.allocated) >=
+						z_reply.hiwat)
+					ev->iferror = -ENOMEM;
+			} while (err < 0 && err != -ECONNREFUSED);
+			skb_pull(skb, rlen);
+		}
+		kfree_skb(skb);
+	}
+	up(&rx_queue_sema);
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
+#define iscsi_conn_int_attr_show(param, format)				\
 static ssize_t								\
-show_host_str_##field(struct class_device *cdev, char *buf)		\
+show_conn_int_param_##param(struct class_device *cdev, char *buf)	\
 {									\
-	int ret = 0;							\
-	struct Scsi_Host *shost = transport_class_to_shost(cdev);	\
-	struct iscsi_internal *i = to_iscsi_internal(shost->transportt); \
+	uint32_t value = 0;						\
+	struct iscsi_if_conn *conn = iscsi_cdev_to_if_conn(cdev);	\
+	struct iscsi_internal *priv;					\
 									\
-	if (i->fnt->get_##field)					\
-		ret = i->fnt->get_##field(shost, buf, PAGE_SIZE);	\
-	return ret;							\
+	priv = to_iscsi_internal(conn->host->transportt);		\
+	if (priv->param_mask & (1 << param))				\
+		priv->iscsi_transport->get_param(conn->connh, param, &value); \
+	return snprintf(buf, 20, format"\n", value);			\
 }
 
-#define iscsi_host_rd_str_attr(field)					\
-	iscsi_host_show_str_fn(field)					\
-static CLASS_DEVICE_ATTR(field, S_IRUGO, show_host_str_##field, NULL);
+#define iscsi_conn_int_attr(field, param, format)			\
+	iscsi_conn_int_attr_show(param, format)				\
+static CLASS_DEVICE_ATTR(field, S_IRUGO, show_conn_int_param_##param, NULL);
+
+iscsi_conn_int_attr(max_recv_dlength, ISCSI_PARAM_MAX_RECV_DLENGTH, "%u");
+iscsi_conn_int_attr(max_xmit_dlength, ISCSI_PARAM_MAX_XMIT_DLENGTH, "%u");
+iscsi_conn_int_attr(header_digest, ISCSI_PARAM_HDRDGST_EN, "%d");
+iscsi_conn_int_attr(data_digest, ISCSI_PARAM_DATADGST_EN, "%d");
+iscsi_conn_int_attr(ifmarker, ISCSI_PARAM_IFMARKER_EN, "%d");
+iscsi_conn_int_attr(ofmarker, ISCSI_PARAM_OFMARKER_EN, "%d");
 
-iscsi_host_rd_str_attr(initiator_name);
-iscsi_host_rd_str_attr(initiator_alias);
+/*
+ * iSCSI session attrs
+ */
+#define iscsi_session_int_attr_show(param, format)			\
+static ssize_t								\
+show_session_int_param_##param(struct class_device *cdev, char *buf)	\
+{									\
+	uint32_t value = 0;						\
+	struct iscsi_if_session *session = iscsi_cdev_to_if_session(cdev); \
+	struct Scsi_Host *shost = iscsi_if_session_to_shost(session);	\
+	struct iscsi_internal *priv = to_iscsi_internal(shost->transportt); \
+	struct iscsi_if_conn *conn = NULL;				\
+	unsigned long  flags;						\
+									\
+	spin_lock_irqsave(&connlock, flags);				\
+	if (!list_empty(&session->connections)) {			\
+		conn = list_entry(session->connections.next,		\
+				  struct iscsi_if_conn, session_list);	\
+	spin_unlock_irqrestore(&connlock, flags);			\
+									\
+	if (conn && (priv->param_mask & (1 << param)))			\
+			priv->iscsi_transport->get_param(conn->connh,	\
+							 param, &value);\
+	}								\
+	return snprintf(buf, 20, format"\n", value);			\
+}
 
-#define SETUP_SESSION_RD_ATTR(field)					\
-	if (i->fnt->show_##field) {					\
-		i->session_attrs[count] = &class_device_attr_##field;	\
+#define iscsi_session_int_attr(field, param, format)			\
+	iscsi_session_int_attr_show(param, format)			\
+static CLASS_DEVICE_ATTR(field, S_IRUGO, show_session_int_param_##param, NULL);
+
+iscsi_session_int_attr(initial_r2t, ISCSI_PARAM_INITIAL_R2T_EN, "%d");
+iscsi_session_int_attr(max_outstanding_r2t, ISCSI_PARAM_MAX_R2T, "%hu");
+iscsi_session_int_attr(immediate_data, ISCSI_PARAM_IMM_DATA_EN, "%d");
+iscsi_session_int_attr(first_burst_len, ISCSI_PARAM_FIRST_BURST, "%u");
+iscsi_session_int_attr(max_burst_len, ISCSI_PARAM_MAX_BURST, "%u");
+iscsi_session_int_attr(data_pdu_in_order, ISCSI_PARAM_PDU_INORDER_EN, "%d");
+iscsi_session_int_attr(data_seq_in_order, ISCSI_PARAM_DATASEQ_INORDER_EN, "%d");
+iscsi_session_int_attr(erl, ISCSI_PARAM_ERL, "%d");
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
+		priv->conn_attrs[count] = &class_device_attr_##field;	\
 		count++;						\
 	}
 
-static int iscsi_host_match(struct attribute_container *cont,
-			  struct device *dev)
+static int iscsi_is_session_dev(const struct device *dev)
 {
+	return dev->release == iscsi_if_session_dev_release;
+}
+
+static int iscsi_session_match(struct attribute_container *cont,
+			   struct device *dev)
+{
+	struct iscsi_if_session *session;
 	struct Scsi_Host *shost;
-	struct iscsi_internal *i;
+	struct iscsi_internal *priv;
+
+	if (!iscsi_is_session_dev(dev))
+		return 0;
 
-	if (!scsi_is_host_device(dev))
+	session = iscsi_dev_to_if_session(dev);
+	shost = iscsi_if_session_to_shost(session);
+	if (!shost->transportt)
 		return 0;
 
-	shost = dev_to_shost(dev);
-	if (!shost->transportt  || shost->transportt->host_attrs.ac.class
-	    != &iscsi_host_class.class)
+	priv = to_iscsi_internal(shost->transportt);
+	if (priv->session_cont.ac.class != &iscsi_session_class.class)
 		return 0;
 
-	i = to_iscsi_internal(shost->transportt);
-	
-	return &i->t.host_attrs.ac == cont;
+	return &priv->session_cont.ac == cont;
 }
 
-static int iscsi_target_match(struct attribute_container *cont,
-			    struct device *dev)
+static int iscsi_is_conn_dev(const struct device *dev)
 {
+	return dev->release == iscsi_if_conn_dev_release;
+}
+
+static int iscsi_conn_match(struct attribute_container *cont,
+			   struct device *dev)
+{
+	struct iscsi_if_conn *conn;
 	struct Scsi_Host *shost;
-	struct iscsi_internal *i;
+	struct iscsi_internal *priv;
+
+	if (!iscsi_is_conn_dev(dev))
+		return 0;
 
-	if (!scsi_is_target_device(dev))
+	conn = iscsi_dev_to_if_conn(dev);
+	shost = conn->host;
+	if (!shost->transportt)
 		return 0;
 
-	shost = dev_to_shost(dev->parent);
-	if (!shost->transportt  || shost->transportt->host_attrs.ac.class
-	    != &iscsi_host_class.class)
+	priv = to_iscsi_internal(shost->transportt);
+	if (priv->conn_cont.ac.class != &iscsi_connection_class.class)
 		return 0;
 
-	i = to_iscsi_internal(shost->transportt);
-	
-	return &i->t.target_attrs.ac == cont;
+	return &priv->conn_cont.ac == cont;
 }
 
-struct scsi_transport_template *
-iscsi_attach_transport(struct iscsi_function_template *fnt)
+int iscsi_register_transport(struct iscsi_transport *tt)
 {
-	struct iscsi_internal *i = kmalloc(sizeof(struct iscsi_internal),
-					   GFP_KERNEL);
+	struct iscsi_internal *priv;
+	unsigned long flags;
 	int count = 0;
 
-	if (unlikely(!i))
-		return NULL;
+	BUG_ON(!tt);
 
-	memset(i, 0, sizeof(struct iscsi_internal));
-	i->fnt = fnt;
+	priv = iscsi_if_transport_lookup(tt);
+	if (priv)
+		return -EEXIST;
+
+	priv = kmalloc(sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+	memset(priv, 0, sizeof(*priv));
+	INIT_LIST_HEAD(&priv->list);
+	INIT_LIST_HEAD(&priv->sessions);
+	spin_lock_init(&priv->session_lock);
+	priv->iscsi_transport = tt;
+
+	/* setup parameters mask */
+	priv->param_mask = 0xFFFFFFFF;
+	if (!(tt->caps & CAP_MULTI_R2T))
+		priv->param_mask &= ~(1 << ISCSI_PARAM_MAX_R2T);
+	if (!(tt->caps & CAP_HDRDGST))
+		priv->param_mask &= ~(1 << ISCSI_PARAM_HDRDGST_EN);
+	if (!(tt->caps & CAP_DATADGST))
+		priv->param_mask &= ~(1 << ISCSI_PARAM_DATADGST_EN);
+	if (!(tt->caps & CAP_MARKERS)) {
+		priv->param_mask &= ~(1 << ISCSI_PARAM_IFMARKER_EN);
+		priv->param_mask &= ~(1 << ISCSI_PARAM_OFMARKER_EN);
+	}
 
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
+	/* connection parameters */
+	priv->conn_cont.ac.attrs = &priv->conn_attrs[0];
+	priv->conn_cont.ac.class = &iscsi_connection_class.class;
+	priv->conn_cont.ac.match = iscsi_conn_match;
+	transport_container_register(&priv->conn_cont);
+
+	SETUP_CONN_RD_ATTR(max_recv_dlength, ISCSI_PARAM_MAX_RECV_DLENGTH);
+	SETUP_CONN_RD_ATTR(max_xmit_dlength, ISCSI_PARAM_MAX_XMIT_DLENGTH);
+	SETUP_CONN_RD_ATTR(header_digest, ISCSI_PARAM_HDRDGST_EN);
+	SETUP_CONN_RD_ATTR(data_digest, ISCSI_PARAM_DATADGST_EN);
+	SETUP_CONN_RD_ATTR(ifmarker, ISCSI_PARAM_IFMARKER_EN);
+	SETUP_CONN_RD_ATTR(ofmarker, ISCSI_PARAM_OFMARKER_EN);
 
-	BUG_ON(count > ISCSI_SESSION_ATTRS);
-	i->session_attrs[count] = NULL;
+	BUG_ON(count > ISCSI_CONN_ATTRS);
+	priv->conn_attrs[count] = NULL;
+	count = 0;
 
-	i->t.host_attrs.ac.attrs = &i->host_attrs[0];
-	i->t.host_attrs.ac.class = &iscsi_host_class.class;
-	i->t.host_attrs.ac.match = iscsi_host_match;
-	transport_container_register(&i->t.host_attrs);
-	i->t.host_size = 0;
+	/* session parameters */
+	priv->session_cont.ac.attrs = &priv->session_attrs[0];
+	priv->session_cont.ac.class = &iscsi_session_class.class;
+	priv->session_cont.ac.match = iscsi_session_match;
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
 
-	count = 0;
-	SETUP_HOST_RD_ATTR(initiator_name);
-	SETUP_HOST_RD_ATTR(initiator_alias);
+	BUG_ON(count > ISCSI_SESSION_ATTRS);
+	priv->session_attrs[count] = NULL;
 
-	BUG_ON(count > ISCSI_HOST_ATTRS);
-	i->host_attrs[count] = NULL;
+	spin_lock_irqsave(&iscsi_transport_lock, flags);
+	list_add(&priv->list, &iscsi_transports);
+	spin_unlock_irqrestore(&iscsi_transport_lock, flags);
 
-	return &i->t;
+	printk(KERN_NOTICE "iscsi: registered transport (%s)\n", tt->name);
+	return 0;
 }
+EXPORT_SYMBOL_GPL(iscsi_register_transport);
+
+int iscsi_unregister_transport(struct iscsi_transport *tt)
+{
+	struct iscsi_internal *priv;
+	unsigned long flags;
+
+	BUG_ON(!tt);
+
+	down(&rx_queue_sema);
+
+	priv = iscsi_if_transport_lookup(tt);
+	BUG_ON (!priv);
+
+	spin_lock_irqsave(&priv->session_lock, flags);
+	if (!list_empty(&priv->sessions)) {
+		spin_unlock_irqrestore(&priv->session_lock, flags);
+		up(&rx_queue_sema);
+		return -EPERM;
+	}
+	spin_unlock_irqrestore(&priv->session_lock, flags);
+
+	spin_lock_irqsave(&iscsi_transport_lock, flags);
+	list_del(&priv->list);
+	spin_unlock_irqrestore(&iscsi_transport_lock, flags);
+
+	transport_container_unregister(&priv->conn_cont);
+	transport_container_unregister(&priv->session_cont);
+	kfree(priv);
+	up(&rx_queue_sema);
 
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
+
+	if (event == NETLINK_URELEASE &&
+	    n->protocol == NETLINK_ISCSI && n->pid) {
+		struct iscsi_if_conn *conn;
+		unsigned long flags;
+
+		mempool_zone_complete(&z_reply);
+		spin_lock_irqsave(&connlock, flags);
+		list_for_each_entry(conn, &connlist, conn_list) {
+			mempool_zone_complete(&conn->z_error);
+			mempool_zone_complete(&conn->z_pdu);
+		}
+		spin_unlock_irqrestore(&connlock, flags);
+	}
 
-	transport_container_unregister(&i->t.target_attrs);
-	transport_container_unregister(&i->t.host_attrs);
-  
-	kfree(i);
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
+		goto unregister_conn_class;
+
+	netlink_register_notifier(&iscsi_nl_notifier);
+	nls = netlink_kernel_create(NETLINK_ISCSI, iscsi_if_rx);
+	if (!nls) {
+		err = -ENOBUFS;
+		goto unregister_notifier;
+	}
+
+	err = mempool_zone_init(&z_reply, Z_MAX_REPLY,
+		NLMSG_SPACE(sizeof(struct iscsi_uevent)), Z_HIWAT_REPLY);
+	if (!err)
+		return 0;
+
+	sock_release(nls->sk_socket);
+ unregister_notifier:
+	netlink_unregister_notifier(&iscsi_nl_notifier);
+ unregister_conn_class:
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
diff -aurp linux-2.6.12-rc4/include/scsi/scsi_transport_iscsi.h linux-2.6.12-rc4.work/include/scsi/scsi_transport_iscsi.h
--- linux-2.6.12-rc4/include/scsi/scsi_transport_iscsi.h	2005-05-06 22:20:31.000000000 -0700
+++ linux-2.6.12-rc4.work/include/scsi/scsi_transport_iscsi.h	2005-05-14 12:19:35.000000000 -0700
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
+ * @name:		transport name
+ * @caps:		iSCSI Data-Path capabilities
+ * @create_session:	create new iSCSI session object
+ * @destroy_session:	destroy existing iSCSI session object
+ * @create_conn:	create new iSCSI connection
+ * @bind_conn:		associate this connection with existing iSCSI session
+ *			and specified transport descriptor
+ * @destroy_conn:	destroy inactive iSCSI connection
+ * @set_param:		set iSCSI Data-Path operational parameter
+ * @start_conn:		set connection to be operational
+ * @stop_conn:		suspend/recover/terminate connection
+ * @send_pdu:		send iSCSI PDU, Login, Logout, NOP-Out, Reject, Text.
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
+	unsigned int max_conn;
+	unsigned int max_cmd_len;
+	iscsi_sessionh_t (*create_session) (uint32_t initial_cmdsn,
+					    struct Scsi_Host *shost);
+	void (*destroy_session) (iscsi_sessionh_t session);
+	iscsi_connh_t (*create_conn) (iscsi_sessionh_t session, uint32_t cid);
+	int (*bind_conn) (iscsi_sessionh_t session, iscsi_connh_t conn,
+			  uint32_t transport_fd, int is_leading);
+	int (*start_conn) (iscsi_connh_t conn);
+	void (*stop_conn) (iscsi_connh_t conn, int flag);
+	void (*destroy_conn) (iscsi_connh_t conn);
+	int (*set_param) (iscsi_connh_t conn, enum iscsi_param param,
+			  uint32_t value);
+	int (*get_param) (iscsi_connh_t conn, enum iscsi_param param,
+			  uint32_t *value);
+	int (*send_pdu) (iscsi_connh_t conn, struct iscsi_hdr *hdr,
+			 char *data, uint32_t data_size);
+	void (*get_stats) (iscsi_connh_t conn, struct iscsi_stats *stats);
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
+extern void iscsi_conn_error(iscsi_connh_t conn, enum iscsi_err error);
+extern int iscsi_recv_pdu(iscsi_connh_t conn, struct iscsi_hdr *hdr,
+			  char *data, uint32_t data_size);
 
 #endif


