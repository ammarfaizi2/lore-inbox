Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261315AbUKWRaX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261315AbUKWRaX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 12:30:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261284AbUKWRaX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 12:30:23 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:57215 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261353AbUKWQQM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 11:16:12 -0500
Cc: openib-general@openib.org, netdev@oss.sgi.com
In-Reply-To: <20041123815.OuqXEOqXJtDtY180@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Tue, 23 Nov 2004 08:16:03 -0800
Message-Id: <20041123816.7BdwvFRYhI45pb9i@topspin.com>
Mime-Version: 1.0
To: linux-kernel@vger.kernel.org
From: Roland Dreier <roland@topspin.com>
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: roland@topspin.com
Subject: [PATCH][RFC/v2][17/21] Add IPoIB (IP-over-InfiniBand) driver
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 23 Nov 2004 16:16:09.0990 (UTC) FILETIME=[BE757A60:01C4D177]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Add a driver that implements the (IPoIB) IP-over-InfiniBand protocol.
This is a network device driver of type ARPHRD_INFINIBAND (and
addr_len INFINIBAND_ALEN bytes).

The ARP/ND implementation for this driver is not completely
straightforward, because InfiniBand requires an additional path lookup
be performed (through an IB-specific mechanism) after a remote
hardware address has been resolved.  We are very open to suggestions
of a better way to handle this than the current implementation.

Although IB has a special multicast group join mode intended to
support IP multicast routing (non member join), no means to identify
different multicast styles has yet been determined, so all joins by
the driver are currently full member joins.  We are looking for
guidance in how to solve this.

The IPoIB protocol/encapsulation is described in the Internet-Drafts
  http://www.ietf.org/internet-drafts/draft-ietf-ipoib-architecture-04.txt
  http://www.ietf.org/internet-drafts/draft-ietf-ipoib-ip-over-infiniband-07.txt

Signed-off-by: Roland Dreier <roland@topspin.com>


--- linux-bk.orig/drivers/infiniband/Kconfig	2004-11-23 08:10:19.036755403 -0800
+++ linux-bk/drivers/infiniband/Kconfig	2004-11-23 08:10:22.620227027 -0800
@@ -10,4 +10,6 @@
 
 source "drivers/infiniband/hw/mthca/Kconfig"
 
+source "drivers/infiniband/ulp/ipoib/Kconfig"
+
 endmenu
--- linux-bk.orig/drivers/infiniband/Makefile	2004-11-23 08:10:18.998761005 -0800
+++ linux-bk/drivers/infiniband/Makefile	2004-11-23 08:10:22.583232481 -0800
@@ -1,2 +1,3 @@
 obj-$(CONFIG_INFINIBAND)		+= core/
 obj-$(CONFIG_INFINIBAND_MTHCA)		+= hw/mthca/
+obj-$(CONFIG_INFINIBAND_IPOIB)		+= ulp/ipoib/
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-bk/drivers/infiniband/ulp/ipoib/Kconfig	2004-11-23 08:10:22.719212431 -0800
@@ -0,0 +1,33 @@
+config INFINIBAND_IPOIB
+	tristate "IP-over-InfiniBand"
+	depends on INFINIBAND && NETDEVICES && INET
+	---help---
+	  Support for the IP-over-InfiniBand protocol (IPoIB). This
+	  transports IP packets over InfiniBand so you can use your IB
+	  device as a fancy NIC.
+
+	  The IPoIB protocol is defined by the IETF ipoib working
+	  group: <http://www.ietf.org/html.charters/ipoib-charter.html>.
+
+config INFINIBAND_IPOIB_DEBUG
+	bool "IP-over-InfiniBand debugging"
+	depends on INFINIBAND_IPOIB
+	---help---
+	  This option causes debugging code to be compiled into the
+	  IPoIB driver.  The output can be turned on via the
+	  debug_level and mcast_debug_level module parameters (which
+	  can also be set after the driver is loaded through sysfs).
+
+	  This option also creates an "ipoib_debugfs," which can be
+	  mounted to expose debugging information about IB multicast
+	  groups used by the IPoIB driver.
+
+config INFINIBAND_IPOIB_DEBUG_DATA
+	bool "IP-over-InfiniBand data path debugging"
+	depends on INFINIBAND_IPOIB_DEBUG
+	---help---
+	  This option compiles debugging code into the the data path
+	  of the IPoIB driver.  The output can be turned on by setting
+	  the debug_level parameter to 2; however, even with output
+	  turned off, this debugging code will have some performance
+	  impact.
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-bk/drivers/infiniband/ulp/ipoib/Makefile	2004-11-23 08:10:22.683217739 -0800
@@ -0,0 +1,11 @@
+EXTRA_CFLAGS += -Idrivers/infiniband/include
+
+obj-$(CONFIG_INFINIBAND_IPOIB)			+= ib_ipoib.o
+
+ib_ipoib-y					:= ipoib_main.o \
+						   ipoib_ib.o \
+						   ipoib_multicast.o \
+						   ipoib_verbs.o \
+						   ipoib_vlan.o
+ib_ipoib-$(CONFIG_INFINIBAND_IPOIB_DEBUG)	+= ipoib_fs.o
+
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-bk/drivers/infiniband/ulp/ipoib/ipoib.h	2004-11-23 08:10:22.764205797 -0800
@@ -0,0 +1,314 @@
+/*
+ * This software is available to you under a choice of one of two
+ * licenses.  You may choose to be licensed under the terms of the GNU
+ * General Public License (GPL) Version 2, available at
+ * <http://www.fsf.org/copyleft/gpl.html>, or the OpenIB.org BSD
+ * license, available in the LICENSE.TXT file accompanying this
+ * software.  These details are also available at
+ * <http://openib.org/license.html>.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+ * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
+ * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
+ * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+ * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+ * SOFTWARE.
+ *
+ * Copyright (c) 2004 Topspin Communications.  All rights reserved.
+ *
+ * $Id: ipoib.h 1275 2004-11-22 23:04:04Z roland $
+ */
+
+#ifndef _IPOIB_H
+#define _IPOIB_H
+
+#include <linux/list.h>
+#include <linux/skbuff.h>
+#include <linux/netdevice.h>
+#include <linux/workqueue.h>
+#include <linux/pci.h>
+#include <linux/config.h>
+#include <linux/kref.h>
+#include <linux/if_infiniband.h>
+
+#include <net/neighbour.h>
+
+#include <asm/atomic.h>
+#include <asm/semaphore.h>
+
+#include <ib_verbs.h>
+#include <ib_pack.h>
+#include <ib_sa.h>
+
+#include "ipoib_proto.h"
+
+/* constants */
+
+enum {
+	IPOIB_PACKET_SIZE         = 2048,
+	IPOIB_BUF_SIZE 		  = IPOIB_PACKET_SIZE + IB_GRH_BYTES,
+
+	IPOIB_ENCAP_LEN 	  = 4,
+
+	IPOIB_RX_RING_SIZE 	  = 128,
+	IPOIB_TX_RING_SIZE 	  = 64,
+
+	IPOIB_NUM_WC 		  = 4,
+
+	IPOIB_MAX_PATH_REC_QUEUE  = 3,
+	IPOIB_MAX_MCAST_QUEUE     = 3,
+
+	IPOIB_FLAG_TX_FULL 	  = 0,
+	IPOIB_FLAG_OPER_UP 	  = 1,
+	IPOIB_FLAG_ADMIN_UP 	  = 2,
+	IPOIB_PKEY_ASSIGNED 	  = 3,
+	IPOIB_PKEY_STOP 	  = 4,
+	IPOIB_FLAG_SUBINTERFACE   = 5,
+	IPOIB_MCAST_RUN 	  = 6,
+	IPOIB_STOP_REAPER         = 7,
+
+	IPOIB_MAX_BACKOFF_SECONDS = 16,
+
+	IPOIB_MCAST_FLAG_FOUND 	  = 0,	/* used in set_multicast_list */
+	IPOIB_MCAST_FLAG_SENDONLY = 1,
+	IPOIB_MCAST_FLAG_BUSY 	  = 2,	/* joining or already joined */
+	IPOIB_MCAST_FLAG_ATTACHED = 3,
+};
+
+/* structs */
+
+struct ipoib_header {
+	u16 proto;
+	u16 reserved;
+};
+
+struct ipoib_pseudoheader {
+	u8  hwaddr[INFINIBAND_ALEN];
+};
+
+struct ipoib_mcast;
+
+struct ipoib_buf {
+	struct sk_buff *skb;
+	DECLARE_PCI_UNMAP_ADDR(mapping)
+};
+
+struct ipoib_dev_priv {
+	spinlock_t lock;
+
+	struct net_device *dev;
+
+	unsigned long flags;
+
+	struct semaphore mcast_mutex;
+	struct semaphore vlan_mutex;
+
+	struct ipoib_mcast *broadcast;
+	struct list_head multicast_list;
+	struct rb_root multicast_tree;
+
+	struct work_struct pkey_task;
+	struct work_struct mcast_task;
+	struct work_struct flush_task;
+	struct work_struct restart_task;
+	struct work_struct ah_reap_task;
+
+	struct ib_device *ca;
+	u8            	  port;
+	u16           	  pkey;
+	struct ib_pd  	 *pd;
+	struct ib_mr  	 *mr;
+	struct ib_cq  	 *cq;
+	struct ib_qp  	 *qp;
+	u32           	  qkey;
+
+	union ib_gid local_gid;
+	u16          local_lid;
+
+	unsigned int admin_mtu;
+	unsigned int mcast_mtu;
+
+	struct ipoib_buf *rx_ring;
+
+	struct ipoib_buf *tx_ring;
+	unsigned tx_head;
+	unsigned tx_tail;
+
+	struct ib_wc ibwc[IPOIB_NUM_WC];
+
+	struct list_head dead_ahs;
+
+	struct ib_event_handler event_handler;
+
+	struct net_device_stats stats;
+
+	struct net_device *parent;
+	struct list_head child_intfs;
+	struct list_head list;
+
+#ifdef CONFIG_INFINIBAND_IPOIB_DEBUG
+	struct list_head fs_list;
+	struct dentry *mcg_dentry;
+#endif
+};
+
+struct ipoib_ah {
+	struct net_device *dev;
+	struct ib_ah      *ah;
+	struct list_head   list;
+	struct kref        ref;
+	unsigned           last_send;
+};
+
+struct ipoib_path {
+	struct ipoib_ah    *ah;
+	struct sk_buff_head queue;
+
+	struct net_device  *dev;
+	struct neighbour   *neighbour;
+};
+
+static inline struct ipoib_path **to_ipoib_path(struct neighbour *neigh)
+{
+	return (struct ipoib_path **) (neigh->ha + 24);
+}
+
+extern struct workqueue_struct *ipoib_workqueue;
+
+/* functions */
+
+void ipoib_ib_completion(struct ib_cq *cq, void *dev_ptr);
+
+struct ipoib_ah *ipoib_create_ah(struct net_device *dev,
+				 struct ib_pd *pd, struct ib_ah_attr *attr);
+void ipoib_free_ah(struct kref *kref);
+static inline void ipoib_put_ah(struct ipoib_ah *ah)
+{
+	kref_put(&ah->ref, ipoib_free_ah);
+}
+
+int ipoib_add_pkey_attr(struct net_device *dev);
+
+void ipoib_send(struct net_device *dev, struct sk_buff *skb,
+		struct ipoib_ah *address, u32 qpn);
+void ipoib_reap_ah(void *dev_ptr);
+
+struct ipoib_dev_priv *ipoib_intf_alloc(const char *format);
+
+int ipoib_ib_dev_init(struct net_device *dev, struct ib_device *ca, int port);
+void ipoib_ib_dev_flush(void *dev);
+void ipoib_ib_dev_cleanup(struct net_device *dev);
+
+int ipoib_ib_dev_open(struct net_device *dev);
+int ipoib_ib_dev_up(struct net_device *dev);
+int ipoib_ib_dev_down(struct net_device *dev);
+int ipoib_ib_dev_stop(struct net_device *dev);
+
+int ipoib_dev_init(struct net_device *dev, struct ib_device *ca, int port);
+void ipoib_dev_cleanup(struct net_device *dev);
+
+void ipoib_mcast_join_task(void *dev_ptr);
+void ipoib_mcast_send(struct net_device *dev, union ib_gid *mgid,
+		      struct sk_buff *skb);
+
+void ipoib_mcast_restart_task(void *dev_ptr);
+int ipoib_mcast_start_thread(struct net_device *dev);
+int ipoib_mcast_stop_thread(struct net_device *dev);
+
+void ipoib_mcast_dev_down(struct net_device *dev);
+void ipoib_mcast_dev_flush(struct net_device *dev);
+
+struct ipoib_mcast_iter *ipoib_mcast_iter_init(struct net_device *dev);
+void ipoib_mcast_iter_free(struct ipoib_mcast_iter *iter);
+int ipoib_mcast_iter_next(struct ipoib_mcast_iter *iter);
+void ipoib_mcast_iter_read(struct ipoib_mcast_iter *iter,
+				  union ib_gid *gid,
+				  unsigned long *created,
+				  unsigned int *queuelen,
+				  unsigned int *complete,
+				  unsigned int *send_only);
+
+int ipoib_mcast_attach(struct net_device *dev, u16 mlid,
+		       union ib_gid *mgid);
+int ipoib_mcast_detach(struct net_device *dev, u16 mlid,
+		       union ib_gid *mgid);
+
+int ipoib_qp_create(struct net_device *dev);
+int ipoib_transport_dev_init(struct net_device *dev, struct ib_device *ca);
+void ipoib_transport_dev_cleanup(struct net_device *dev);
+
+void ipoib_event(struct ib_event_handler *handler,
+		 struct ib_event *record);
+
+int ipoib_vlan_add(struct net_device *pdev, unsigned short pkey);
+int ipoib_vlan_delete(struct net_device *pdev, unsigned short pkey);
+
+void ipoib_pkey_poll(void *dev);
+int ipoib_pkey_dev_delay_open(struct net_device *dev);
+
+#ifdef CONFIG_INFINIBAND_IPOIB_DEBUG
+int ipoib_create_debug_file(struct net_device *dev);
+void ipoib_delete_debug_file(struct net_device *dev);
+int ipoib_register_debugfs(void);
+void ipoib_unregister_debugfs(void);
+#else
+static inline int ipoib_create_debug_file(struct net_device *dev) { return 0; }
+static inline void ipoib_delete_debug_file(struct net_device *dev) { }
+static inline int ipoib_register_debugfs(void) { return 0; }
+static inline void ipoib_unregister_debugfs(void) { }
+#endif
+
+
+#define ipoib_printk(level, priv, format, arg...)	\
+	printk(level "%s: " format, ((struct ipoib_dev_priv *) priv)->dev->name , ## arg)
+#define ipoib_warn(priv, format, arg...)		\
+	ipoib_printk(KERN_WARNING, priv, format , ## arg)
+
+
+#ifdef CONFIG_INFINIBAND_IPOIB_DEBUG
+extern int debug_level;
+extern int mcast_debug_level;
+
+#define ipoib_dbg(priv, format, arg...)			\
+	do {					        \
+		if (debug_level > 0)			\
+			ipoib_printk(KERN_DEBUG, priv, format , ## arg); \
+	} while (0)
+#define ipoib_dbg_mcast(priv, format, arg...)		\
+	do {					        \
+		if (mcast_debug_level > 0)		\
+			ipoib_printk(KERN_DEBUG, priv, format , ## arg); \
+	} while (0)
+#else /* CONFIG_INFINIBAND_IPOIB_DEBUG */
+#define ipoib_dbg(priv, format, arg...)			\
+	do { (void) (priv); } while (0)
+#define ipoib_dbg_mcast(priv, format, arg...)		\
+	do { (void) (priv); } while (0)
+#endif /* CONFIG_INFINIBAND_IPOIB_DEBUG */
+
+#ifdef CONFIG_INFINIBAND_IPOIB_DEBUG_DATA
+#define ipoib_dbg_data(priv, format, arg...)		\
+	do {					        \
+		if (debug_level > 1)			\
+			ipoib_printk(KERN_DEBUG, priv, format , ## arg); \
+	} while (0)
+#else /* CONFIG_INFINIBAND_IPOIB_DEBUG_DATA */
+#define ipoib_dbg_data(priv, format, arg...)		\
+	do { (void) (priv); } while (0)
+#endif /* CONFIG_INFINIBAND_IPOIB_DEBUG_DATA */
+
+
+#define IPOIB_GID_FMT		"%x:%x:%x:%x:%x:%x:%x:%x"
+
+#define IPOIB_GID_ARG(gid)	be16_to_cpup((__be16 *) ((gid).raw +  0)), \
+				be16_to_cpup((__be16 *) ((gid).raw +  2)), \
+				be16_to_cpup((__be16 *) ((gid).raw +  4)), \
+				be16_to_cpup((__be16 *) ((gid).raw +  6)), \
+				be16_to_cpup((__be16 *) ((gid).raw +  8)), \
+				be16_to_cpup((__be16 *) ((gid).raw + 10)), \
+				be16_to_cpup((__be16 *) ((gid).raw + 12)), \
+				be16_to_cpup((__be16 *) ((gid).raw + 14))
+
+#endif /* _IPOIB_H */
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-bk/drivers/infiniband/ulp/ipoib/ipoib_fs.c	2004-11-23 08:10:22.816198131 -0800
@@ -0,0 +1,276 @@
+/*
+ * This software is available to you under a choice of one of two
+ * licenses.  You may choose to be licensed under the terms of the GNU
+ * General Public License (GPL) Version 2, available at
+ * <http://www.fsf.org/copyleft/gpl.html>, or the OpenIB.org BSD
+ * license, available in the LICENSE.TXT file accompanying this
+ * software.  These details are also available at
+ * <http://openib.org/license.html>.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+ * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
+ * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
+ * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+ * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+ * SOFTWARE.
+ *
+ * Copyright (c) 2004 Topspin Communications.  All rights reserved.
+ *
+ * $Id$
+ */
+
+#include <linux/pagemap.h>
+#include <linux/seq_file.h>
+
+#include "ipoib.h"
+
+enum {
+	IPOIB_MAGIC = 0x49504942 /* "IPIB" */
+};
+
+static DECLARE_MUTEX(ipoib_fs_mutex);
+static struct dentry *ipoib_root;
+static struct super_block *ipoib_sb;
+static LIST_HEAD(ipoib_device_list);
+
+static void *ipoib_mcg_seq_start(struct seq_file *file, loff_t *pos)
+{
+	struct ipoib_mcast_iter *iter;
+	loff_t n = *pos;
+
+	iter = ipoib_mcast_iter_init(file->private);
+	if (!iter)
+		return NULL;
+
+	while (n--) {
+		if (ipoib_mcast_iter_next(iter)) {
+			ipoib_mcast_iter_free(iter);
+			return NULL;
+		}
+	}
+
+	return iter;
+}
+
+static void *ipoib_mcg_seq_next(struct seq_file *file, void *iter_ptr,
+				   loff_t *pos)
+{
+	struct ipoib_mcast_iter *iter = iter_ptr;
+
+	(*pos)++;
+
+	if (ipoib_mcast_iter_next(iter)) {
+		ipoib_mcast_iter_free(iter);
+		return NULL;
+	}
+
+	return iter;
+}
+
+static void ipoib_mcg_seq_stop(struct seq_file *file, void *iter_ptr)
+{
+	/* nothing for now */
+}
+
+static int ipoib_mcg_seq_show(struct seq_file *file, void *iter_ptr)
+{
+	struct ipoib_mcast_iter *iter = iter_ptr;
+	char gid_buf[sizeof "ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff"];
+	union ib_gid mgid;
+	int i, n;
+	unsigned long created;
+	unsigned int queuelen, complete, send_only;
+
+	if (iter) {
+		ipoib_mcast_iter_read(iter, &mgid, &created, &queuelen,
+				      &complete, &send_only);
+
+		for (n = 0, i = 0; i < sizeof mgid / 2; ++i) {
+			n += sprintf(gid_buf + n, "%x",
+				     be16_to_cpu(((u16 *)mgid.raw)[i]));
+			if (i < sizeof mgid / 2 - 1)
+				gid_buf[n++] = ':';
+		}
+	}
+
+	seq_printf(file, "GID: %*s", -(1 + (int) sizeof gid_buf), gid_buf);
+
+	seq_printf(file,
+		   " created: %10ld queuelen: %4d complete: %d send_only: %d\n",
+		   created, queuelen, complete, send_only);
+
+	return 0;
+}
+
+static struct seq_operations ipoib_seq_ops = {
+	.start = ipoib_mcg_seq_start,
+	.next  = ipoib_mcg_seq_next,
+	.stop  = ipoib_mcg_seq_stop,
+	.show  = ipoib_mcg_seq_show,
+};
+
+static int ipoib_mcg_open(struct inode *inode, struct file *file)
+{
+	struct seq_file *seq;
+	int ret;
+
+	ret = seq_open(file, &ipoib_seq_ops);
+	if (ret)
+		return ret;
+
+	seq = file->private_data;
+	seq->private = inode->u.generic_ip;
+
+	return 0;
+}
+
+static struct file_operations ipoib_fops = {
+	.owner   = THIS_MODULE,
+	.open    = ipoib_mcg_open,
+	.read    = seq_read,
+	.llseek  = seq_lseek,
+	.release = seq_release
+};
+
+static struct inode *ipoib_get_inode(void)
+{
+	struct inode *inode = new_inode(ipoib_sb);
+
+	if (inode) {
+		inode->i_mode 	 = S_IFREG | S_IRUGO;
+		inode->i_uid 	 = 0;
+		inode->i_gid 	 = 0;
+		inode->i_blksize = PAGE_CACHE_SIZE;
+		inode->i_blocks  = 0;
+		inode->i_atime 	 = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
+		inode->i_fop     = &ipoib_fops;
+	}
+
+	return inode;
+}
+
+static int __ipoib_create_debug_file(struct net_device *dev)
+{
+	struct ipoib_dev_priv *priv = netdev_priv(dev);
+	struct dentry *dentry;
+	struct inode *inode;
+	char name[IFNAMSIZ + sizeof "_mcg"];
+
+	snprintf(name, sizeof name, "%s_mcg", dev->name);
+
+	dentry = d_alloc_name(ipoib_root, name);
+	if (!dentry)
+		return -ENOMEM;
+
+	inode = ipoib_get_inode();
+	if (!inode) {
+		dput(dentry);
+		return -ENOMEM;
+	}
+
+	inode->u.generic_ip = dev;
+	priv->mcg_dentry = dentry;
+
+	d_add(dentry, inode);
+
+	return 0;
+}
+
+int ipoib_create_debug_file(struct net_device *dev)
+{
+	struct ipoib_dev_priv *priv = netdev_priv(dev);
+
+	down(&ipoib_fs_mutex);
+
+	list_add_tail(&priv->fs_list, &ipoib_device_list);
+
+	if (!ipoib_sb) {
+		up(&ipoib_fs_mutex);
+		return 0;
+	}
+
+	up(&ipoib_fs_mutex);
+
+	return __ipoib_create_debug_file(dev);
+}
+
+void ipoib_delete_debug_file(struct net_device *dev)
+{
+	struct ipoib_dev_priv *priv = netdev_priv(dev);
+
+	down(&ipoib_fs_mutex);
+	list_del(&priv->fs_list);
+	if (!ipoib_sb) {
+		up(&ipoib_fs_mutex);
+		return;
+	}
+	up(&ipoib_fs_mutex);
+
+	if (priv->mcg_dentry) {
+		d_drop(priv->mcg_dentry);
+		simple_unlink(ipoib_root->d_inode, priv->mcg_dentry);
+	}
+}
+
+static int ipoib_fill_super(struct super_block *sb, void *data, int silent)
+{
+	static struct tree_descr ipoib_files[] = {
+		{ "" }
+	};
+	struct ipoib_dev_priv *priv;
+	int ret;
+
+	ret = simple_fill_super(sb, IPOIB_MAGIC, ipoib_files);
+	if (ret)
+		return ret;
+
+	ipoib_root = sb->s_root;
+
+	down(&ipoib_fs_mutex);
+
+	ipoib_sb = sb;
+
+	list_for_each_entry(priv, &ipoib_device_list, fs_list) {
+		ret = __ipoib_create_debug_file(priv->dev);
+		if (ret)
+			break;
+	}
+
+	up(&ipoib_fs_mutex);
+
+	return ret;
+}
+
+static struct super_block *ipoib_get_sb(struct file_system_type *fs_type,
+	int flags, const char *dev_name, void *data)
+{
+	return get_sb_single(fs_type, flags, data, ipoib_fill_super);
+}
+
+static void ipoib_kill_sb(struct super_block *sb)
+{
+	down(&ipoib_fs_mutex);
+	ipoib_sb = NULL;
+	up(&ipoib_fs_mutex);
+
+	kill_litter_super(sb);
+}
+
+static struct file_system_type ipoib_fs_type = {
+	.owner		= THIS_MODULE,
+	.name		= "ipoib_debugfs",
+	.get_sb		= ipoib_get_sb,
+	.kill_sb	= ipoib_kill_sb,
+};
+
+int ipoib_register_debugfs(void)
+{
+	return register_filesystem(&ipoib_fs_type);
+}
+
+void ipoib_unregister_debugfs(void)
+{
+	unregister_filesystem(&ipoib_fs_type);
+}
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-bk/drivers/infiniband/ulp/ipoib/ipoib_ib.c	2004-11-23 08:10:22.857192086 -0800
@@ -0,0 +1,626 @@
+/*
+ * This software is available to you under a choice of one of two
+ * licenses.  You may choose to be licensed under the terms of the GNU
+ * General Public License (GPL) Version 2, available at
+ * <http://www.fsf.org/copyleft/gpl.html>, or the OpenIB.org BSD
+ * license, available in the LICENSE.TXT file accompanying this
+ * software.  These details are also available at
+ * <http://openib.org/license.html>.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+ * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
+ * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
+ * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+ * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+ * SOFTWARE.
+ *
+ * Copyright (c) 2004 Topspin Communications.  All rights reserved.
+ *
+ * $Id: ipoib_ib.c 1267 2004-11-18 20:31:22Z roland $
+ */
+
+#include <linux/delay.h>
+
+#include <ib_cache.h>
+
+#include "ipoib.h"
+
+#define	IPOIB_OP_RECV	(1ul << 31)
+
+static DECLARE_MUTEX(pkey_sem);
+
+struct ipoib_ah *ipoib_create_ah(struct net_device *dev,
+				 struct ib_pd *pd, struct ib_ah_attr *attr)
+{
+	struct ipoib_ah *ah;
+
+	ah = kmalloc(sizeof *ah, GFP_KERNEL);
+	if (!ah)
+		return NULL;
+
+	ah->dev       = dev;
+	ah->last_send = 0;
+	kref_init(&ah->ref);
+
+	ah->ah = ib_create_ah(pd, attr);
+	if (IS_ERR(ah->ah)) {
+		kfree(ah);
+		ah = NULL;
+	} else
+		ipoib_dbg(netdev_priv(dev), "Created ah %p\n", ah->ah);
+
+	return ah;
+}
+
+void ipoib_free_ah(struct kref *kref)
+{
+	struct ipoib_ah *ah = container_of(kref, struct ipoib_ah, ref);
+	struct ipoib_dev_priv *priv = netdev_priv(ah->dev);
+
+	unsigned long flags;
+
+	spin_lock_irqsave(&priv->lock, flags);
+	if (ah->last_send <= priv->tx_tail) {
+		ipoib_dbg(priv, "Freeing ah %p\n", ah->ah);
+		ib_destroy_ah(ah->ah);
+		kfree(ah);
+	} else
+		list_add_tail(&ah->list, &priv->dead_ahs);
+	spin_unlock_irqrestore(&priv->lock, flags);
+}
+
+static inline int ipoib_ib_receive(struct ipoib_dev_priv *priv,
+				   unsigned int wr_id,
+				   dma_addr_t addr)
+{
+	struct ib_sge list = {
+		.addr    = addr,
+		.length  = IPOIB_BUF_SIZE,
+		.lkey    = priv->mr->lkey,
+	};
+	struct ib_recv_wr param = {
+		.wr_id 	    = wr_id | IPOIB_OP_RECV,
+		.sg_list    = &list,
+		.num_sge    = 1,
+		.recv_flags = IB_RECV_SIGNALED
+	};
+	struct ib_recv_wr *bad_wr;
+
+	return ib_post_recv(priv->qp, &param, &bad_wr);
+}
+
+static int ipoib_ib_post_receive(struct net_device *dev, int id)
+{
+	struct ipoib_dev_priv *priv = netdev_priv(dev);
+	struct sk_buff *skb;
+	dma_addr_t addr;
+	int ret;
+
+	skb = dev_alloc_skb(IPOIB_BUF_SIZE + 4);
+	if (!skb) {
+		ipoib_warn(priv, "failed to allocate receive buffer\n");
+
+		priv->rx_ring[id].skb = NULL;
+		return -ENOMEM;
+	}
+	skb_reserve(skb, 4);	/* 16 byte align IP header */
+	priv->rx_ring[id].skb = skb;
+	addr = dma_map_single(priv->ca->dma_device,
+			      skb->data, IPOIB_BUF_SIZE,
+			      DMA_FROM_DEVICE);
+	pci_unmap_addr_set(&priv->rx_ring[id], mapping, addr);
+
+	ret = ipoib_ib_receive(priv, id, addr);
+	if (ret) {
+		ipoib_warn(priv, "ipoib_ib_receive failed for buf %d (%d)\n",
+			   id, ret);
+		priv->rx_ring[id].skb = NULL;
+	}
+
+	return ret;
+}
+
+static int ipoib_ib_post_receives(struct net_device *dev)
+{
+	struct ipoib_dev_priv *priv = netdev_priv(dev);
+	int i;
+
+	for (i = 0; i < IPOIB_RX_RING_SIZE; ++i) {
+		if (ipoib_ib_post_receive(dev, i)) {
+			ipoib_warn(priv, "ipoib_ib_post_receive failed for buf %d\n", i);
+			return -EIO;
+		}
+	}
+
+	return 0;
+}
+
+static void ipoib_ib_handle_wc(struct net_device *dev,
+			       struct ib_wc *wc)
+{
+	struct ipoib_dev_priv *priv = netdev_priv(dev);
+	unsigned int wr_id = wc->wr_id;
+
+	ipoib_dbg_data(priv, "called: id %d, op %d, status: %d\n",
+		       wr_id, wc->opcode, wc->status);
+
+	if (wr_id & IPOIB_OP_RECV) {
+		wr_id &= ~IPOIB_OP_RECV;
+
+		if (wr_id < IPOIB_RX_RING_SIZE) {
+			struct sk_buff *skb = priv->rx_ring[wr_id].skb;
+
+			priv->rx_ring[wr_id].skb = NULL;
+
+			dma_unmap_single(priv->ca->dma_device,
+					 pci_unmap_addr(&priv->rx_ring[wr_id],
+							mapping),
+					 IPOIB_BUF_SIZE,
+					 DMA_FROM_DEVICE);
+
+			if (wc->status != IB_WC_SUCCESS) {
+				if (wc->status != IB_WC_WR_FLUSH_ERR)
+					ipoib_warn(priv, "failed recv event "
+						   "(status=%d, wrid=%d vend_err %x)\n",
+						   wc->status, wr_id, wc->vendor_err);
+				dev_kfree_skb_any(skb);
+				return;
+			}
+
+			ipoib_dbg_data(priv, "received %d bytes, SLID 0x%04x\n",
+				       wc->byte_len, wc->slid);
+
+			skb_put(skb, wc->byte_len);
+			skb_pull(skb, IB_GRH_BYTES);
+
+			if (wc->slid != priv->local_lid ||
+			    wc->src_qp != priv->qp->qp_num) {
+				skb->protocol = ((struct ipoib_header *) skb->data)->proto;
+
+				skb_pull(skb, IPOIB_ENCAP_LEN);
+
+				dev->last_rx = jiffies;
+				++priv->stats.rx_packets;
+				priv->stats.rx_bytes += skb->len;
+
+				skb->dev = dev;
+				/* XXX get correct PACKET_ type here */
+				skb->pkt_type = PACKET_HOST;
+				netif_rx_ni(skb);
+			} else {
+				ipoib_dbg_data(priv, "dropping loopback packet\n");
+				dev_kfree_skb_any(skb);
+			}
+
+			/* repost receive */
+			if (ipoib_ib_post_receive(dev, wr_id))
+				ipoib_warn(priv, "ipoib_ib_post_receive failed "
+					   "for buf %d\n", wr_id);
+		} else
+			ipoib_warn(priv, "completion event with wrid %d\n",
+				   wr_id);
+
+	} else {
+		struct ipoib_buf *tx_req;
+		unsigned long flags;
+
+		if (wr_id >= IPOIB_TX_RING_SIZE) {
+			ipoib_warn(priv, "completion event with wrid %d (> %d)\n",
+				   wr_id, IPOIB_TX_RING_SIZE);
+			return;
+		}
+
+		ipoib_dbg_data(priv, "send complete, wrid %d\n", wr_id);
+
+		tx_req = &priv->tx_ring[wr_id];
+
+		dma_unmap_single(priv->ca->dma_device,
+				 pci_unmap_addr(tx_req, mapping),
+				 tx_req->skb->len,
+				 DMA_TO_DEVICE);
+
+		++priv->stats.tx_packets;
+		priv->stats.tx_bytes += tx_req->skb->len;
+
+		dev_kfree_skb_any(tx_req->skb);
+
+		spin_lock_irqsave(&priv->lock, flags);
+		++priv->tx_tail;
+		if (priv->tx_head - priv->tx_tail <= IPOIB_TX_RING_SIZE / 2)
+			netif_wake_queue(dev);
+		spin_unlock_irqrestore(&priv->lock, flags);
+
+		if (wc->status != IB_WC_SUCCESS &&
+		    wc->status != IB_WC_WR_FLUSH_ERR)
+			ipoib_warn(priv, "failed send event "
+				   "(status=%d, wrid=%d vend_err %x)\n",
+				   wc->status, wr_id, wc->vendor_err);
+	}
+}
+
+void ipoib_ib_completion(struct ib_cq *cq, void *dev_ptr)
+{
+	struct net_device *dev = (struct net_device *) dev_ptr;
+	struct ipoib_dev_priv *priv = netdev_priv(dev);
+	int n, i;
+
+	ib_req_notify_cq(cq, IB_CQ_NEXT_COMP);
+	do {
+		n = ib_poll_cq(cq, IPOIB_NUM_WC, priv->ibwc);
+		for (i = 0; i < n; ++i)
+			ipoib_ib_handle_wc(dev, priv->ibwc + i);
+	} while (n == IPOIB_NUM_WC);
+}
+
+static inline int post_send(struct ipoib_dev_priv *priv,
+			    unsigned int wr_id,
+			    struct ib_ah *address, u32 qpn,
+			    dma_addr_t addr, int len)
+{
+	struct ib_sge list = {
+		.addr    = addr,
+		.length  = len,
+		.lkey    = priv->mr->lkey,
+	};
+	struct ib_send_wr param = {
+		.wr_id = wr_id,
+		.opcode = IB_WR_SEND,
+		.sg_list = &list,
+		.num_sge = 1,
+		.wr = {
+			.ud = {
+				 .remote_qpn = qpn,
+				 .remote_qkey = priv->qkey,
+				 .ah = address
+			 },
+		},
+		.send_flags = IB_SEND_SIGNALED,
+	};
+	struct ib_send_wr *bad_wr;
+
+	return ib_post_send(priv->qp, &param, &bad_wr);
+}
+
+void ipoib_send(struct net_device *dev, struct sk_buff *skb,
+		struct ipoib_ah *address, u32 qpn)
+{
+	struct ipoib_dev_priv *priv = netdev_priv(dev);
+	struct ipoib_buf *tx_req;
+	dma_addr_t addr;
+
+	if (skb->len > dev->mtu + INFINIBAND_ALEN) {
+		ipoib_warn(priv, "packet len %d (> %d) too long to send, dropping\n",
+			   skb->len, dev->mtu + INFINIBAND_ALEN);
+		++priv->stats.tx_dropped;
+		++priv->stats.tx_errors;
+		dev_kfree_skb_any(skb);
+		return;
+	}
+
+	if (!(skb = skb_unshare(skb, GFP_ATOMIC))) {
+		ipoib_warn(priv, "failed to unshare sk_buff. Dropping\n");
+		++priv->stats.tx_dropped;
+		++priv->stats.tx_errors;
+		return;
+	}
+
+	ipoib_dbg_data(priv, "sending packet, length=%d address=%p qpn=0x%06x\n",
+		       skb->len, address, qpn);
+
+	/*
+	 * We put the skb into the tx_ring _before_ we call post_send()
+	 * because it's entirely possible that the completion handler will
+	 * run before we execute anything after the post_send().  That
+	 * means we have to make sure everything is properly recorded and
+	 * our state is consistent before we call post_send().
+	 */
+	tx_req = &priv->tx_ring[priv->tx_head & (IPOIB_TX_RING_SIZE - 1)];
+	tx_req->skb = skb;
+	addr = dma_map_single(priv->ca->dma_device,
+			      skb->data, skb->len,
+			      DMA_TO_DEVICE);
+	pci_unmap_addr_set(tx_req, mapping, addr);
+
+	if (post_send(priv, priv->tx_head & (IPOIB_TX_RING_SIZE - 1),
+		      address->ah, qpn, addr, skb->len)) {
+		ipoib_warn(priv, "post_send failed\n");
+		++priv->stats.tx_errors;
+		dev_kfree_skb_any(skb);
+	} else {
+		unsigned long flags;
+
+		dev->trans_start = jiffies;
+
+		address->last_send = priv->tx_head;
+		++priv->tx_head;
+
+		spin_lock_irqsave(&priv->lock, flags);
+		if (priv->tx_head - priv->tx_tail == IPOIB_TX_RING_SIZE) {
+			ipoib_dbg(priv, "TX ring full, stopping kernel net queue\n");
+			netif_stop_queue(dev);
+		}
+		spin_unlock_irqrestore(&priv->lock, flags);
+	}
+}
+
+void __ipoib_reap_ah(struct net_device *dev)
+{
+	struct ipoib_dev_priv *priv = netdev_priv(dev);
+	struct ipoib_ah *ah, *tah;
+	LIST_HEAD(remove_list);
+
+	spin_lock_irq(&priv->lock);
+	list_for_each_entry_safe(ah, tah, &priv->dead_ahs, list)
+		if (ah->last_send <= priv->tx_tail) {
+			list_del(&ah->list);
+			list_add_tail(&ah->list, &remove_list);
+		}
+	spin_unlock_irq(&priv->lock);
+
+	list_for_each_entry_safe(ah, tah, &remove_list, list) {
+		ipoib_dbg(priv, "Reaping ah %p\n", ah->ah);
+		ib_destroy_ah(ah->ah);
+		kfree(ah);
+	}
+}
+
+void ipoib_reap_ah(void *dev_ptr)
+{
+	struct net_device *dev = dev_ptr;
+	struct ipoib_dev_priv *priv = netdev_priv(dev);
+
+	__ipoib_reap_ah(dev);
+
+	if (!test_bit(IPOIB_STOP_REAPER, &priv->flags))
+		queue_delayed_work(ipoib_workqueue, &priv->ah_reap_task, HZ);
+}
+
+int ipoib_ib_dev_open(struct net_device *dev)
+{
+	struct ipoib_dev_priv *priv = netdev_priv(dev);
+	int ret;
+
+	ret = ipoib_qp_create(dev);
+	if (ret) {
+		ipoib_warn(priv, "ipoib_qp_create returned %d\n", ret);
+		return -1;
+	}
+
+	ret = ipoib_ib_post_receives(dev);
+	if (ret) {
+		ipoib_warn(priv, "ipoib_ib_post_receives returned %d\n", ret);
+		return -1;
+	}
+
+	clear_bit(IPOIB_STOP_REAPER, &priv->flags);
+	queue_delayed_work(ipoib_workqueue, &priv->ah_reap_task, HZ);
+
+	return 0;
+}
+
+int ipoib_ib_dev_up(struct net_device *dev)
+{
+	struct ipoib_dev_priv *priv = netdev_priv(dev);
+
+	set_bit(IPOIB_FLAG_OPER_UP, &priv->flags);
+
+	return ipoib_mcast_start_thread(dev);
+}
+
+int ipoib_ib_dev_down(struct net_device *dev)
+{
+	struct ipoib_dev_priv *priv = netdev_priv(dev);
+
+	ipoib_dbg(priv, "downing ib_dev\n");
+
+	clear_bit(IPOIB_FLAG_OPER_UP, &priv->flags);
+	netif_carrier_off(dev);
+
+	/* Shutdown the P_Key thread if still active */
+	if (!test_bit(IPOIB_PKEY_ASSIGNED, &priv->flags)) {
+		down(&pkey_sem);
+		set_bit(IPOIB_PKEY_STOP, &priv->flags);
+		cancel_delayed_work(&priv->pkey_task);
+		up(&pkey_sem);
+		flush_workqueue(ipoib_workqueue);
+	}
+
+	ipoib_mcast_stop_thread(dev);
+
+	/*
+	 * Flush the multicast groups first so we stop any multicast joins. The
+	 * completion thread may have already died and we may deadlock waiting
+	 * for the completion thread to finish some multicast joins.
+	 */
+	ipoib_mcast_dev_flush(dev);
+
+	/* Delete broadcast and local addresses since they will be recreated */
+	ipoib_mcast_dev_down(dev);
+
+	return 0;
+}
+
+static int recvs_pending(struct net_device *dev)
+{
+	struct ipoib_dev_priv *priv = netdev_priv(dev);
+	int i;
+
+	for (i = 0; i < IPOIB_RX_RING_SIZE; ++i)
+		if (priv->rx_ring[i].skb)
+			return 1;
+
+	return 0;
+}
+
+int ipoib_ib_dev_stop(struct net_device *dev)
+{
+	struct ipoib_dev_priv *priv = netdev_priv(dev);
+	struct ib_qp_attr qp_attr;
+	int attr_mask;
+	int i;
+
+	/* Kill the existing QP and allocate a new one */
+	qp_attr.qp_state = IB_QPS_ERR;
+	attr_mask        = IB_QP_STATE;
+	if (ib_modify_qp(priv->qp, &qp_attr, attr_mask))
+		ipoib_warn(priv, "Failed to modify QP to ERROR state\n");
+
+	/* Wait for all sends and receives to complete */
+	while (priv->tx_head != priv->tx_tail || recvs_pending(dev))
+		yield();
+
+	ipoib_dbg(priv, "All sends and receives done.\n");
+
+	qp_attr.qp_state = IB_QPS_RESET;
+	attr_mask        = IB_QP_STATE;
+	if (ib_modify_qp(priv->qp, &qp_attr, attr_mask))
+		ipoib_warn(priv, "Failed to modify QP to RESET state\n");
+
+	/* Wait for all AHs to be reaped */
+	set_bit(IPOIB_STOP_REAPER, &priv->flags);
+	cancel_delayed_work(&priv->ah_reap_task);
+	flush_workqueue(ipoib_workqueue);
+	while (!list_empty(&priv->dead_ahs)) {
+		__ipoib_reap_ah(dev);
+		yield();
+	}
+
+	for (i = 0; i < IPOIB_RX_RING_SIZE; ++i)
+		if (priv->rx_ring[i].skb)
+			ipoib_warn(priv, "Recv skb still around @ %d\n", i);
+
+	return 0;
+}
+
+int ipoib_ib_dev_init(struct net_device *dev, struct ib_device *ca, int port)
+{
+	struct ipoib_dev_priv *priv = netdev_priv(dev);
+
+	priv->ca = ca;
+	priv->port = port;
+	priv->qp = NULL;
+
+	if (ipoib_transport_dev_init(dev, ca)) {
+		printk(KERN_WARNING "%s: ipoib_transport_dev_init failed\n", ca->name);
+		return -ENODEV;
+	}
+
+	if (dev->flags & IFF_UP) {
+		if (ipoib_ib_dev_open(dev)) {
+			ipoib_transport_dev_cleanup(dev);
+			return -ENODEV;
+		}
+	}
+
+	return 0;
+}
+
+void ipoib_ib_dev_flush(void *_dev)
+{
+	struct net_device *dev = (struct net_device *)_dev;
+	struct ipoib_dev_priv *priv = netdev_priv(dev), *cpriv;
+
+	if (!test_bit(IPOIB_FLAG_ADMIN_UP, &priv->flags))
+		return;
+
+	ipoib_dbg(priv, "flushing\n");
+
+	ipoib_ib_dev_down(dev);
+
+	/*
+	 * The device could have been brought down between the start and when
+	 * we get here, don't bring it back up if it's not configured up
+	 */
+	if (test_bit(IPOIB_FLAG_ADMIN_UP, &priv->flags))
+		ipoib_ib_dev_up(dev);
+
+	/* Flush any child interfaces too */
+	list_for_each_entry(cpriv, &priv->child_intfs, list)
+		ipoib_ib_dev_flush(&cpriv->dev);
+}
+
+void ipoib_ib_dev_cleanup(struct net_device *dev)
+{
+	struct ipoib_dev_priv *priv = netdev_priv(dev);
+
+	ipoib_dbg(priv, "cleaning up ib_dev\n");
+
+	ipoib_mcast_stop_thread(dev);
+
+	/* Delete the broadcast address and the local address */
+	ipoib_mcast_dev_down(dev);
+
+	ipoib_transport_dev_cleanup(dev);
+}
+
+/*
+ * Delayed P_Key Assigment Interim Support
+ *
+ * The following is initial implementation of delayed P_Key assigment
+ * mechanism. It is using the same approach implemented for the multicast
+ * group join. The single goal of this implementation is to quickly address
+ * Bug #2507. This implementation will probably be removed when the P_Key
+ * change async notification is available.
+ */
+int ipoib_open(struct net_device *dev);
+
+static void ipoib_pkey_dev_check_presence(struct net_device *dev)
+{
+	struct ipoib_dev_priv *priv = netdev_priv(dev);
+	u16 pkey_index = 0;
+
+	if (ib_cached_pkey_find(priv->ca, priv->port, priv->pkey, &pkey_index))
+		clear_bit(IPOIB_PKEY_ASSIGNED, &priv->flags);
+	else
+		set_bit(IPOIB_PKEY_ASSIGNED, &priv->flags);
+}
+
+void ipoib_pkey_poll(void *dev_ptr)
+{
+	struct net_device *dev = dev_ptr;
+	struct ipoib_dev_priv *priv = netdev_priv(dev);
+
+	ipoib_pkey_dev_check_presence(dev);
+
+	if (test_bit(IPOIB_PKEY_ASSIGNED, &priv->flags))
+		ipoib_open(dev);
+	else {
+		down(&pkey_sem);
+		if (!test_bit(IPOIB_PKEY_STOP, &priv->flags))
+			queue_delayed_work(ipoib_workqueue,
+					   &priv->pkey_task,
+					   HZ);
+		up(&pkey_sem);
+	}
+}
+
+int ipoib_pkey_dev_delay_open(struct net_device *dev)
+{
+	struct ipoib_dev_priv *priv = netdev_priv(dev);
+
+	/* Look for the interface pkey value in the IB Port P_Key table and */
+	/* set the interface pkey assigment flag                            */
+	ipoib_pkey_dev_check_presence(dev);
+
+	/* P_Key value not assigned yet - start polling */
+	if (!test_bit(IPOIB_PKEY_ASSIGNED, &priv->flags)) {
+		down(&pkey_sem);
+		clear_bit(IPOIB_PKEY_STOP, &priv->flags);
+		queue_delayed_work(ipoib_workqueue,
+				   &priv->pkey_task,
+				   HZ);
+		up(&pkey_sem);
+		return 1;
+	}
+
+	return 0;
+}
+
+/*
+  Local Variables:
+  c-file-style: "linux"
+  indent-tabs-mode: t
+  End:
+*/
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-bk/drivers/infiniband/ulp/ipoib/ipoib_main.c	2004-11-23 08:10:22.898186042 -0800
@@ -0,0 +1,954 @@
+/*
+ * This software is available to you under a choice of one of two
+ * licenses.  You may choose to be licensed under the terms of the GNU
+ * General Public License (GPL) Version 2, available at
+ * <http://www.fsf.org/copyleft/gpl.html>, or the OpenIB.org BSD
+ * license, available in the LICENSE.TXT file accompanying this
+ * software.  These details are also available at
+ * <http://openib.org/license.html>.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+ * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
+ * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
+ * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+ * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+ * SOFTWARE.
+ *
+ * Copyright (c) 2004 Topspin Communications.  All rights reserved.
+ *
+ * $Id: ipoib_main.c 1273 2004-11-22 22:59:30Z roland $
+ */
+
+#include "ipoib.h"
+
+#include <linux/version.h>
+#include <linux/module.h>
+
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/vmalloc.h>
+
+#include <linux/if_arp.h>	/* For ARPHRD_xxx */
+
+#include <linux/ip.h>
+#include <linux/in.h>
+
+MODULE_AUTHOR("Roland Dreier");
+MODULE_DESCRIPTION("IP-over-InfiniBand net driver");
+MODULE_LICENSE("Dual BSD/GPL");
+
+#ifdef CONFIG_INFINIBAND_IPOIB_DEBUG
+int debug_level;
+
+#ifdef CONFIG_INFINIBAND_IPOIB_DEBUG_DATA
+#define DATA_PATH_DEBUG_HELP " and data path tracing if > 1"
+#else
+#define DATA_PATH_DEBUG_HELP ""
+#endif
+
+module_param(debug_level, int, 0644);
+MODULE_PARM_DESC(debug_level, "Enable debug tracing if > 0" DATA_PATH_DEBUG_HELP);
+
+int mcast_debug_level;
+
+module_param(mcast_debug_level, int, 0644);
+MODULE_PARM_DESC(mcast_debug_level,
+		 "Enable multicast debug tracing if > 0");
+#endif
+
+static const u8 ipv4_bcast_addr[] = {
+	0x00, 0xff, 0xff, 0xff,
+	0xff, 0x12, 0x40, 0x1b,	0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00,	0xff, 0xff, 0xff, 0xff
+};
+
+struct workqueue_struct *ipoib_workqueue;
+
+static void ipoib_add_one(struct ib_device *device);
+static void ipoib_remove_one(struct ib_device *device);
+
+static struct ib_client ipoib_client = {
+	.name   = "ipoib",
+	.add    = ipoib_add_one,
+	.remove = ipoib_remove_one
+};
+
+int ipoib_device_handle(struct net_device *dev, struct ib_device **ca,
+			u8 *port_num, union ib_gid *gid, u16 *pkey)
+{
+	struct ipoib_dev_priv *priv = netdev_priv(dev);
+
+	*ca       = priv->ca;
+	*port_num = priv->port;
+	*gid      = priv->local_gid;
+	*pkey     = priv->pkey;
+
+	return 0;
+}
+EXPORT_SYMBOL(ipoib_device_handle);
+
+int ipoib_open(struct net_device *dev)
+{
+	struct ipoib_dev_priv *priv = netdev_priv(dev);
+
+	ipoib_dbg(priv, "bringing up interface\n");
+
+	set_bit(IPOIB_FLAG_ADMIN_UP, &priv->flags);
+
+	if (ipoib_pkey_dev_delay_open(dev))
+		return 0;
+
+	if (ipoib_ib_dev_open(dev))
+		return -EINVAL;
+
+	if (ipoib_ib_dev_up(dev))
+		return -EINVAL;
+
+	if (!test_bit(IPOIB_FLAG_SUBINTERFACE, &priv->flags)) {
+		struct ipoib_dev_priv *cpriv;
+
+		/* Bring up any child interfaces too */
+		down(&priv->vlan_mutex);
+		list_for_each_entry(cpriv, &priv->child_intfs, list) {
+			int flags;
+
+			flags = cpriv->dev->flags;
+			if (flags & IFF_UP)
+				continue;
+
+			dev_change_flags(cpriv->dev, flags | IFF_UP);
+		}
+		up(&priv->vlan_mutex);
+	}
+
+	netif_start_queue(dev);
+
+	return 0;
+}
+
+static int ipoib_stop(struct net_device *dev)
+{
+	struct ipoib_dev_priv *priv = netdev_priv(dev);
+
+	ipoib_dbg(priv, "stopping interface\n");
+
+	clear_bit(IPOIB_FLAG_ADMIN_UP, &priv->flags);
+
+	netif_stop_queue(dev);
+
+	ipoib_ib_dev_down(dev);
+	ipoib_ib_dev_stop(dev);
+
+	if (!test_bit(IPOIB_FLAG_SUBINTERFACE, &priv->flags)) {
+		struct ipoib_dev_priv *cpriv;
+
+		/* Bring down any child interfaces too */
+		down(&priv->vlan_mutex);
+		list_for_each_entry(cpriv, &priv->child_intfs, list) {
+			int flags;
+
+			flags = cpriv->dev->flags;
+			if (!(flags & IFF_UP))
+				continue;
+
+			dev_change_flags(cpriv->dev, flags & ~IFF_UP);
+		}
+		up(&priv->vlan_mutex);
+	}
+
+	return 0;
+}
+
+static int ipoib_change_mtu(struct net_device *dev, int new_mtu)
+{
+	struct ipoib_dev_priv *priv = netdev_priv(dev);
+
+	if (new_mtu > IPOIB_PACKET_SIZE - IPOIB_ENCAP_LEN)
+		return -EINVAL;
+
+	priv->admin_mtu = new_mtu;
+
+	dev->mtu = min(priv->mcast_mtu, priv->admin_mtu);
+
+	return 0;
+}
+
+static void path_rec_completion(int status,
+				struct ib_sa_path_rec *pathrec,
+				void *path_ptr)
+{
+	struct ipoib_path *path = path_ptr;
+	struct ipoib_dev_priv *priv = netdev_priv(path->dev);
+	struct sk_buff *skb;
+	struct ipoib_ah *ah;
+
+	ipoib_dbg(priv, "status %d, LID 0x%04x for GID " IPOIB_GID_FMT "\n",
+		  status, be16_to_cpu(pathrec->dlid), IPOIB_GID_ARG(pathrec->dgid));
+
+	if (status != IB_WC_SUCCESS)
+		goto err;
+
+	{
+		struct ib_ah_attr av = {
+			.dlid 	       = be16_to_cpu(pathrec->dlid),
+			.sl 	       = pathrec->sl,
+			.src_path_bits = 0,
+			.static_rate   = 0,
+			.ah_flags      = 0,
+			.port_num      = priv->port
+		};
+
+		ah = ipoib_create_ah(path->dev, priv->pd, &av);
+	}
+
+	if (!ah)
+		goto err;
+
+	path->ah = ah;
+
+	ipoib_dbg(priv, "created address handle %p for LID 0x%04x, SL %d\n",
+		  ah, pathrec->dlid, pathrec->sl);
+
+	while ((skb = __skb_dequeue(&path->queue))) {
+		skb->dev = path->dev;
+		if (dev_queue_xmit(skb))
+			ipoib_warn(priv, "dev_queue_xmit failed "
+				   "to requeue packet\n");
+	}
+
+	return;
+
+err:
+	while ((skb = __skb_dequeue(&path->queue)))
+		dev_kfree_skb(skb);
+	
+	if (path->neighbour)
+		*to_ipoib_path(path->neighbour) = NULL;
+
+	kfree(path);
+}
+
+static int path_rec_start(struct sk_buff *skb, struct net_device *dev)
+{
+	struct ipoib_dev_priv *priv = netdev_priv(dev);
+	struct ipoib_path *path = kmalloc(sizeof *path, GFP_ATOMIC);
+	struct ib_sa_path_rec rec = {
+		.numb_path = 1
+	};
+	struct ib_sa_query *query;
+
+	if (!path)
+		goto err;
+
+	path->ah  = NULL;
+	path->dev = dev;
+	skb_queue_head_init(&path->queue);
+	__skb_queue_tail(&path->queue, skb);
+	path->neighbour = NULL;
+
+	rec.sgid = priv->local_gid;
+	memcpy(rec.dgid.raw, skb->dst->neighbour->ha + 4, 16);
+	rec.pkey = cpu_to_be16(priv->pkey);
+
+	/*
+	 * XXX there's a race here if path record completion runs
+	 * before we get to finish up.  Add a lock to path struct?
+	 */
+	if (ib_sa_path_rec_get(priv->ca, priv->port, &rec,
+			       IB_SA_PATH_REC_DGID	|
+			       IB_SA_PATH_REC_SGID	|
+			       IB_SA_PATH_REC_NUMB_PATH	|
+			       IB_SA_PATH_REC_PKEY,
+			       1000, GFP_ATOMIC,
+			       path_rec_completion,
+			       path, &query) < 0) {
+		ipoib_warn(priv, "ib_sa_path_rec_get failed\n");
+		goto err;
+	}
+
+	path->neighbour = skb->dst->neighbour;
+	*to_ipoib_path(skb->dst->neighbour) = path;
+	return 0;
+
+err:
+	kfree(path);
+	++priv->stats.tx_dropped;
+	dev_kfree_skb_any(skb);
+
+	return 0;
+}
+
+static int path_lookup(struct sk_buff *skb, struct net_device *dev)
+{
+	struct ipoib_dev_priv *priv = netdev_priv(skb->dev);
+
+	/* Look up path record for unicasts */
+	if (skb->dst->neighbour->ha[4] != 0xff)
+		return path_rec_start(skb, dev);
+
+	/* Add in the P_Key */
+	skb->dst->neighbour->ha[8] = (priv->pkey >> 8) & 0xff;
+	skb->dst->neighbour->ha[9] = priv->pkey & 0xff;
+	ipoib_mcast_send(dev,
+			 (union ib_gid *) (skb->dst->neighbour->ha + 4),
+			 skb);
+	return 0;
+}
+
+static void unicast_arp_completion(int status,
+				   struct ib_sa_path_rec *pathrec,
+				   void *skb_ptr)
+{
+	struct sk_buff *skb = skb_ptr;
+	struct ipoib_dev_priv *priv = netdev_priv(skb->dev);
+	struct ipoib_ah *ah;
+
+	ipoib_dbg(priv, "status %d, LID 0x%04x for GID " IPOIB_GID_FMT "\n",
+		  status, be16_to_cpu(pathrec->dlid), IPOIB_GID_ARG(pathrec->dgid));
+
+	if (status)
+		goto err;
+
+	{
+		struct ib_ah_attr av = {
+			.dlid 	       = be16_to_cpu(pathrec->dlid),
+			.sl 	       = pathrec->sl,
+			.src_path_bits = 0,
+			.static_rate   = 0,
+			.ah_flags      = 0,
+			.port_num      = priv->port
+		};
+
+		ah = ipoib_create_ah(skb->dev, priv->pd, &av);
+	}
+
+	if (!ah)
+		goto err;
+
+	*(struct ipoib_ah **) skb->cb = ah;
+
+	if (dev_queue_xmit(skb))
+		ipoib_warn(priv, "dev_queue_xmit failed "
+			   "to requeue ARP packet\n");
+
+	return;
+
+err:
+	dev_kfree_skb(skb);
+}
+
+static void unicast_arp_finish(struct sk_buff *skb)
+{
+	struct ipoib_dev_priv *priv = netdev_priv(skb->dev);
+	struct ipoib_ah *ah = *(struct ipoib_ah **) skb->cb;
+	unsigned long flags;
+
+	if (ah) {
+		spin_lock_irqsave(&priv->lock, flags);
+		list_add_tail(&ah->list, &priv->dead_ahs);
+		spin_unlock_irqrestore(&priv->lock, flags);
+	}
+}
+
+/*
+ * For unicast packets with no skb->dst->neighbour (unicast ARPs are
+ * the main example), we fire off a path record query for each packet.
+ * This is pretty bad for scalability (since this is going to hammer
+ * the SM on a big fabric) but it's the best I can think of for now.
+ *
+ * Also we might have a problem if a path changes, because ARPs will
+ * still go through (since we'll get the new path from the SM for
+ * these queries) so we'll never update the neighbour.
+ */
+static int unicast_arp_start(struct sk_buff *skb, struct net_device *dev,
+			     struct ipoib_pseudoheader *phdr)
+{
+	struct ipoib_dev_priv *priv = netdev_priv(dev);
+	struct sk_buff *tmp_skb;
+	struct ib_sa_path_rec rec = {
+		.numb_path = 1
+	};
+	struct ib_sa_query *query;
+
+	if (skb->destructor) {
+		tmp_skb = skb;
+		skb = skb_clone(tmp_skb, GFP_ATOMIC);
+		dev_kfree_skb_any(tmp_skb);
+		if (!skb) {
+			++priv->stats.tx_dropped;
+			return 0;
+		}
+	}
+
+	skb->dev        = dev;
+	skb->destructor = unicast_arp_finish;
+	memset(skb->cb, 0, sizeof skb->cb);
+
+	rec.sgid = priv->local_gid;
+	memcpy(rec.dgid.raw, phdr->hwaddr + 4, 16);
+	rec.pkey = cpu_to_be16(priv->pkey);
+
+	/*
+	 * XXX We need to keep a record of the skb and TID somewhere
+	 * so that we can cancel the request if the device goes down
+	 * before it finishes.
+	 */
+	if (ib_sa_path_rec_get(priv->ca, priv->port, &rec,
+			       IB_SA_PATH_REC_DGID	|
+			       IB_SA_PATH_REC_SGID	|
+			       IB_SA_PATH_REC_NUMB_PATH	|
+			       IB_SA_PATH_REC_PKEY,
+			       1000, GFP_ATOMIC,
+			       unicast_arp_completion,
+			       skb, &query) < 0) {
+		ipoib_warn(priv, "ib_sa_path_rec_get failed\n");
+		++priv->stats.tx_dropped;
+		dev_kfree_skb_any(skb);
+	}
+
+	return 0;
+}
+
+static int ipoib_start_xmit(struct sk_buff *skb, struct net_device *dev)
+{
+	struct ipoib_dev_priv *priv = netdev_priv(dev);
+	struct ipoib_path *path;
+
+	if (skb->dst && skb->dst->neighbour) {
+		if (unlikely(!*to_ipoib_path(skb->dst->neighbour)))
+			return path_lookup(skb, dev);
+
+		path = *to_ipoib_path(skb->dst->neighbour);
+
+		if (likely(path->ah)) {
+			ipoib_send(dev, skb, path->ah,
+				   be32_to_cpup((__be32 *) skb->dst->neighbour->ha));
+			return 0;
+		}
+
+		if (skb_queue_len(&path->queue) < IPOIB_MAX_PATH_REC_QUEUE)
+			__skb_queue_tail(&path->queue, skb);
+		else
+			goto err;
+	} else {
+		struct ipoib_pseudoheader *phdr =
+			(struct ipoib_pseudoheader *) skb->data;
+		skb_pull(skb, sizeof *phdr);
+
+		if (phdr->hwaddr[4] == 0xff) {
+			/* Add in the P_Key */
+			phdr->hwaddr[8] = (priv->pkey >> 8) & 0xff;
+			phdr->hwaddr[9] = priv->pkey & 0xff;
+
+			ipoib_mcast_send(dev, (union ib_gid *) (phdr->hwaddr + 4), skb);
+		}
+		else {
+			/* unicast GID -- ARP reply?? */
+
+			/*
+			 * If destructor is unicast_arp_finish, we've
+			 * already been through the path lookup and
+			 * now we can just send the packet.
+			 */
+			if (skb->destructor == unicast_arp_finish) {
+				ipoib_send(dev, skb, *(struct ipoib_ah **) skb->cb,
+					   be32_to_cpup((u32 *) phdr->hwaddr));
+				return 0;
+			}
+
+			if (be16_to_cpup((u16 *) skb->data) != ETH_P_ARP) {
+				ipoib_warn(priv, "Unicast, no %s: type %04x, QPN %06x "
+					   IPOIB_GID_FMT "\n",
+					   skb->dst ? "neigh" : "dst",
+					   be16_to_cpup((u16 *) skb->data),
+					   be32_to_cpup((u32 *) phdr->hwaddr),
+					   IPOIB_GID_ARG(*(union ib_gid *) (phdr->hwaddr + 4)));
+				dev_kfree_skb_any(skb);
+				++priv->stats.tx_dropped;
+				return 0;
+			}
+
+			/* put the pseudoheader back on */			  
+			skb_push(skb, sizeof *phdr);
+			return unicast_arp_start(skb, dev, phdr);
+		}
+	}
+
+	return 0;
+
+err:
+	++priv->stats.tx_dropped;
+	dev_kfree_skb_any(skb);
+
+	return 0;
+}
+
+struct net_device_stats *ipoib_get_stats(struct net_device *dev)
+{
+	struct ipoib_dev_priv *priv = netdev_priv(dev);
+
+	return &priv->stats;
+}
+
+static void ipoib_timeout(struct net_device *dev)
+{
+	struct ipoib_dev_priv *priv = netdev_priv(dev);
+
+	ipoib_warn(priv, "transmit timeout: latency %ld\n",
+		   jiffies - dev->trans_start);
+	/* XXX reset QP, etc. */
+}
+
+static int ipoib_hard_header(struct sk_buff *skb,
+			     struct net_device *dev,
+			     unsigned short type,
+			     void *daddr, void *saddr, unsigned len)
+{
+	struct ipoib_header *header;
+
+	header = (struct ipoib_header *) skb_push(skb, sizeof *header);
+
+	header->proto = htons(type);
+	header->reserved = 0;
+
+	/*
+	 * If we don't have a neighbour structure, stuff the
+	 * destination address onto the front of the skb so we can
+	 * figure out where to send the packet later.
+	 */
+	if (!skb->dst || !skb->dst->neighbour) {
+		struct ipoib_pseudoheader *phdr =
+			(struct ipoib_pseudoheader *) skb_push(skb, sizeof *phdr);
+		memcpy(phdr->hwaddr, daddr, INFINIBAND_ALEN);
+	}
+
+	return 0;
+}
+
+static void ipoib_set_mcast_list(struct net_device *dev)
+{
+	struct ipoib_dev_priv *priv = netdev_priv(dev);
+
+	schedule_work(&priv->restart_task);
+}
+
+static void ipoib_neigh_destructor(struct neighbour *neigh)
+{
+	struct ipoib_path     *path = *to_ipoib_path(neigh);
+
+	ipoib_dbg(netdev_priv(neigh->dev),
+		  "neigh_destructor for %06x " IPOIB_GID_FMT "\n",
+		  be32_to_cpup((__be32 *) neigh->ha),
+		  IPOIB_GID_ARG(*((union ib_gid *) (neigh->ha + 4))));
+
+	if (path && path->ah) {
+		ipoib_put_ah(path->ah);
+		kfree(path);
+	}
+}
+
+static int ipoib_neigh_setup(struct neighbour *neigh)
+{
+	/*
+	 * Is this kosher?  I can't find anybody in the kernel that
+	 * sets neigh->destructor, so we should be able to set it here
+	 * without trouble.
+	 */
+	neigh->ops->destructor = ipoib_neigh_destructor;
+
+	return 0;
+}
+
+static int ipoib_neigh_setup_dev(struct net_device *dev, struct neigh_parms *parms)
+{
+	parms->neigh_setup = ipoib_neigh_setup;
+
+	return 0;
+}
+
+int ipoib_dev_init(struct net_device *dev, struct ib_device *ca, int port)
+{
+	struct ipoib_dev_priv *priv = netdev_priv(dev);
+
+	/* Allocate RX/TX "rings" to hold queued skbs */
+
+	priv->rx_ring =	kmalloc(IPOIB_RX_RING_SIZE * sizeof (struct ipoib_buf),
+				GFP_KERNEL);
+	if (!priv->rx_ring) {
+		printk(KERN_WARNING "%s: failed to allocate RX ring (%d entries)\n",
+		       ca->name, IPOIB_RX_RING_SIZE);
+		goto out;
+	}
+	memset(priv->rx_ring, 0,
+	       IPOIB_RX_RING_SIZE * sizeof (struct ipoib_buf));
+
+	priv->tx_ring = kmalloc(IPOIB_TX_RING_SIZE * sizeof (struct ipoib_buf),
+				GFP_KERNEL);
+	if (!priv->tx_ring) {
+		printk(KERN_WARNING "%s: failed to allocate TX ring (%d entries)\n",
+		       ca->name, IPOIB_TX_RING_SIZE);
+		goto out_rx_ring_cleanup;
+	}
+	memset(priv->tx_ring, 0,
+	       IPOIB_TX_RING_SIZE * sizeof (struct ipoib_buf));
+
+	/* priv->tx_head & tx_tail are already 0 */
+
+	if (ipoib_ib_dev_init(dev, ca, port))
+		goto out_tx_ring_cleanup;
+
+	return 0;
+
+out_tx_ring_cleanup:
+	kfree(priv->tx_ring);
+
+out_rx_ring_cleanup:
+	kfree(priv->rx_ring);
+
+out:
+	return -ENOMEM;
+}
+
+void ipoib_dev_cleanup(struct net_device *dev)
+{
+	struct ipoib_dev_priv *priv = netdev_priv(dev), *cpriv, *tcpriv;
+
+	ipoib_delete_debug_file(dev);
+
+	/* Delete any child interfaces first */
+	list_for_each_entry_safe(cpriv, tcpriv, &priv->child_intfs, list) {
+		unregister_netdev(cpriv->dev);
+		ipoib_dev_cleanup(cpriv->dev);
+		free_netdev(cpriv->dev);
+	}
+
+	ipoib_ib_dev_cleanup(dev);
+
+	if (priv->rx_ring) {
+		kfree(priv->rx_ring);
+		priv->rx_ring = NULL;
+	}
+
+	if (priv->tx_ring) {
+		kfree(priv->tx_ring);
+		priv->tx_ring = NULL;
+	}
+}
+
+static void ipoib_setup(struct net_device *dev)
+{
+	struct ipoib_dev_priv *priv = netdev_priv(dev);
+
+	dev->open 		 = ipoib_open;
+	dev->stop 		 = ipoib_stop;
+	dev->change_mtu 	 = ipoib_change_mtu;
+	dev->hard_start_xmit 	 = ipoib_start_xmit;
+	dev->get_stats 		 = ipoib_get_stats;
+	dev->tx_timeout 	 = ipoib_timeout;
+	dev->hard_header 	 = ipoib_hard_header;
+	dev->set_multicast_list  = ipoib_set_mcast_list;
+	dev->neigh_setup         = ipoib_neigh_setup_dev;
+
+	dev->watchdog_timeo 	 = HZ;
+
+	dev->rebuild_header 	 = NULL;
+	dev->set_mac_address 	 = NULL;
+	dev->header_cache_update = NULL;
+
+	dev->flags              |= IFF_BROADCAST | IFF_MULTICAST;
+	
+	/*
+	 * We add in INFINIBAND_ALEN to allow for the destination
+	 * address "pseudoheader" for skbs without neighbour struct.
+	 */
+	dev->hard_header_len 	 = IPOIB_ENCAP_LEN + INFINIBAND_ALEN;
+	dev->addr_len 		 = INFINIBAND_ALEN;
+	dev->type 		 = ARPHRD_INFINIBAND;
+	dev->tx_queue_len 	 = IPOIB_TX_RING_SIZE * 2;
+	dev->features            = NETIF_F_VLAN_CHALLENGED;
+
+	/* MTU will be reset when mcast join happens */
+	dev->mtu 		 = IPOIB_PACKET_SIZE - IPOIB_ENCAP_LEN;
+	priv->mcast_mtu 	 = priv->admin_mtu = dev->mtu;
+
+	memcpy(dev->broadcast, ipv4_bcast_addr, INFINIBAND_ALEN);
+
+	netif_carrier_off(dev);
+
+	SET_MODULE_OWNER(dev);
+
+	priv->dev = dev;
+
+	spin_lock_init(&priv->lock);
+
+	init_MUTEX(&priv->mcast_mutex);
+	init_MUTEX(&priv->vlan_mutex);
+
+	INIT_LIST_HEAD(&priv->child_intfs);
+	INIT_LIST_HEAD(&priv->dead_ahs);
+	INIT_LIST_HEAD(&priv->multicast_list);
+
+	INIT_WORK(&priv->pkey_task,    ipoib_pkey_poll,          priv->dev);
+	INIT_WORK(&priv->mcast_task,   ipoib_mcast_join_task,    priv->dev);
+	INIT_WORK(&priv->flush_task,   ipoib_ib_dev_flush,       priv->dev);
+	INIT_WORK(&priv->restart_task, ipoib_mcast_restart_task, priv->dev);
+	INIT_WORK(&priv->ah_reap_task, ipoib_reap_ah,            priv->dev);
+}
+
+struct ipoib_dev_priv *ipoib_intf_alloc(const char *name)
+{
+	struct net_device *dev;
+
+	dev = alloc_netdev((int) sizeof (struct ipoib_dev_priv), name,
+			   ipoib_setup);
+	if (!dev)
+		return NULL;
+
+	return netdev_priv(dev);
+}
+
+static ssize_t show_pkey(struct class_device *cdev, char *buf)
+{
+	struct ipoib_dev_priv *priv =
+		netdev_priv(container_of(cdev, struct net_device, class_dev));
+
+	return sprintf(buf, "0x%04x\n", priv->pkey);
+}
+static CLASS_DEVICE_ATTR(pkey, S_IRUGO, show_pkey, NULL);
+
+static ssize_t create_child(struct class_device *cdev,
+			    const char *buf, size_t count)
+{
+	int pkey;
+	int ret;
+
+	if (sscanf(buf, "%i", &pkey) != 1)
+		return -EINVAL;
+
+	if (pkey < 0 || pkey > 0xffff)
+		return -EINVAL;
+
+	ret = ipoib_vlan_add(container_of(cdev, struct net_device, class_dev),
+			     pkey);
+
+	return ret ? ret : count;
+}
+static CLASS_DEVICE_ATTR(create_child, S_IWUGO, NULL, create_child);
+
+static ssize_t delete_child(struct class_device *cdev,
+			    const char *buf, size_t count)
+{
+	int pkey;
+	int ret;
+
+	if (sscanf(buf, "%i", &pkey) != 1)
+		return -EINVAL;
+
+	if (pkey < 0 || pkey > 0xffff)
+		return -EINVAL;
+
+	ret = ipoib_vlan_delete(container_of(cdev, struct net_device, class_dev),
+				pkey);
+
+	return ret ? ret : count;
+
+}
+static CLASS_DEVICE_ATTR(delete_child, S_IWUGO, NULL, delete_child);
+
+int ipoib_add_pkey_attr(struct net_device *dev)
+{
+	return class_device_create_file(&dev->class_dev,
+					&class_device_attr_pkey);
+}
+
+static struct net_device *ipoib_add_port(const char *format,
+					 struct ib_device *hca, u8 port)
+{
+	struct ipoib_dev_priv *priv;
+	int result = -ENOMEM;
+
+	priv = ipoib_intf_alloc(format);
+	if (!priv)
+		goto alloc_mem_failed;
+
+	SET_NETDEV_DEV(priv->dev, hca->dma_device);
+
+	result = ib_query_pkey(hca, port, 0, &priv->pkey);
+	if (result) {
+		printk(KERN_WARNING "%s: ib_query_pkey port %d failed (ret = %d)\n",
+		       hca->name, port, result);
+		goto alloc_mem_failed;
+	}
+
+	priv->dev->broadcast[8] = priv->pkey >> 8;
+	priv->dev->broadcast[9] = priv->pkey & 0xff;
+
+	result = ib_query_gid(hca, port, 0, &priv->local_gid);
+	if (result) {
+		printk(KERN_WARNING "%s: ib_query_gid port %d failed (ret = %d)\n",
+		       hca->name, port, result);
+		goto alloc_mem_failed;
+	} else
+		memcpy(priv->dev->dev_addr + 4, priv->local_gid.raw, sizeof (union ib_gid));
+
+
+	result = ipoib_dev_init(priv->dev, hca, port);
+	if (result < 0) {
+		printk(KERN_WARNING "%s: failed to initialize port %d (ret = %d)\n",
+		       hca->name, port, result);
+		goto device_init_failed;
+	}
+
+	INIT_IB_EVENT_HANDLER(&priv->event_handler,
+			      priv->ca, ipoib_event);
+	result = ib_register_event_handler(&priv->event_handler);
+	if (result < 0) {
+		printk(KERN_WARNING "%s: ib_register_event_handler failed for "
+		       "port %d (ret = %d)\n",
+		       hca->name, port, result);
+		goto event_failed;
+	}
+
+	result = register_netdev(priv->dev);
+	if (result) {
+		printk(KERN_WARNING "%s: couldn't register ipoib port %d; error %d\n",
+		       hca->name, port, result);
+		goto register_failed;
+	}
+
+	if (ipoib_create_debug_file(priv->dev))
+		goto debug_failed;
+
+	if (ipoib_add_pkey_attr(priv->dev))
+		goto sysfs_failed;
+	if (class_device_create_file(&priv->dev->class_dev,
+				     &class_device_attr_create_child))
+		goto sysfs_failed;
+	if (class_device_create_file(&priv->dev->class_dev,
+				     &class_device_attr_delete_child))
+		goto sysfs_failed;
+
+	return priv->dev;
+
+sysfs_failed:
+	ipoib_delete_debug_file(priv->dev);
+
+debug_failed:
+	unregister_netdev(priv->dev);
+
+register_failed:
+	ib_unregister_event_handler(&priv->event_handler);
+
+event_failed:
+	ipoib_dev_cleanup(priv->dev);
+
+device_init_failed:
+	free_netdev(priv->dev);
+
+alloc_mem_failed:
+	return ERR_PTR(result);
+}
+
+static void ipoib_add_one(struct ib_device *device)
+{
+	struct list_head *dev_list;
+	struct net_device *dev;
+	struct ipoib_dev_priv *priv;
+	int s, e, p;
+
+	dev_list = kmalloc(sizeof *dev_list, GFP_KERNEL);
+	if (!dev_list)
+		return;
+
+	INIT_LIST_HEAD(dev_list);
+
+	if (device->node_type == IB_NODE_SWITCH) {
+		s = 0;
+		e = 0;
+	} else {
+		s = 1;
+		e = device->phys_port_cnt;
+	}
+
+	for (p = s; p <= e; ++p) {
+		dev = ipoib_add_port("ib%d", device, p);
+		if (!IS_ERR(dev)) {
+			priv = netdev_priv(dev);
+			list_add_tail(&priv->list, dev_list);
+		}
+	}
+
+	ib_set_client_data(device, &ipoib_client, dev_list);
+}
+
+static void ipoib_remove_one(struct ib_device *device)
+{
+	struct ipoib_dev_priv *priv, *tmp;
+	struct list_head *dev_list;
+
+	dev_list = ib_get_client_data(device, &ipoib_client);
+
+	list_for_each_entry_safe(priv, tmp, dev_list, list) {
+		ib_unregister_event_handler(&priv->event_handler);
+
+		unregister_netdev(priv->dev);
+		ipoib_dev_cleanup(priv->dev);
+		free_netdev(priv->dev);
+	}
+}
+
+static int __init ipoib_init_module(void)
+{
+	int ret;
+
+	ret = ipoib_register_debugfs();
+	if (ret)
+		return ret;
+
+	/*
+	 * We create our own workqueue mainly because we want to be
+	 * able to flush it when devices are being removed.  We can't
+	 * use schedule_work()/flush_scheduled_work() because both
+	 * unregister_netdev() and linkwatch_event take the rtnl lock,
+	 * so flush_scheduled_work() can deadlock during device
+	 * removal.
+	 */
+	ipoib_workqueue = create_singlethread_workqueue("ipoib");
+	if (!ipoib_workqueue) {
+		ret = -ENOMEM;
+		goto err_fs;
+	}
+
+	ret = ib_register_client(&ipoib_client);
+	if (ret)
+		goto err_wq;
+
+	return 0;
+
+err_fs:
+	ipoib_unregister_debugfs();
+
+err_wq:
+	destroy_workqueue(ipoib_workqueue);
+
+	return ret;
+}
+
+static void __exit ipoib_cleanup_module(void)
+{
+	ipoib_unregister_debugfs();
+	ib_unregister_client(&ipoib_client);
+	destroy_workqueue(ipoib_workqueue);
+}
+
+module_init(ipoib_init_module);
+module_exit(ipoib_cleanup_module);
+
+/*
+  Local Variables:
+  c-file-style: "linux"
+  indent-tabs-mode: t
+  End:
+*/
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-bk/drivers/infiniband/ulp/ipoib/ipoib_multicast.c	2004-11-23 08:10:22.940179850 -0800
@@ -0,0 +1,928 @@
+/*
+ * This software is available to you under a choice of one of two
+ * licenses.  You may choose to be licensed under the terms of the GNU
+ * General Public License (GPL) Version 2, available at
+ * <http://www.fsf.org/copyleft/gpl.html>, or the OpenIB.org BSD
+ * license, available in the LICENSE.TXT file accompanying this
+ * software.  These details are also available at
+ * <http://openib.org/license.html>.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+ * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
+ * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
+ * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+ * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+ * SOFTWARE.
+ *
+ * Copyright (c) 2004 Topspin Communications.  All rights reserved.
+ *
+ * $Id: ipoib_multicast.c 1277 2004-11-23 01:08:07Z roland $
+ */
+
+#include <linux/skbuff.h>
+#include <linux/rtnetlink.h>
+#include <linux/ip.h>
+#include <linux/in.h>
+#include <linux/igmp.h>
+#include <linux/inetdevice.h>
+#include <linux/delay.h>
+#include <linux/completion.h>
+
+#include "ipoib.h"
+
+static DECLARE_MUTEX(mcast_mutex);
+
+/* Used for all multicast joins (broadcast, IPv4 mcast and IPv6 mcast) */
+struct ipoib_mcast {
+	struct ib_sa_mcmember_rec mcmember;
+	struct ipoib_ah          *ah;
+
+	struct rb_node    rb_node;
+	struct list_head  list;
+	struct completion done;
+	
+	int                 query_id;
+	struct ib_sa_query *query;
+
+	unsigned long created;
+	unsigned long backoff;
+
+	unsigned long flags;
+	unsigned char logcount;
+
+	struct sk_buff_head pkt_queue;
+
+	struct net_device *dev;
+};
+
+struct ipoib_mcast_iter {
+	struct net_device *dev;
+	union ib_gid       mgid;
+	unsigned long      created;
+	unsigned int       queuelen;
+	unsigned int       complete;
+	unsigned int       send_only;
+};
+
+static void ipoib_mcast_free(struct ipoib_mcast *mcast)
+{
+	struct net_device *dev = mcast->dev;
+
+	ipoib_dbg_mcast(netdev_priv(dev),
+			"deleting multicast group " IPOIB_GID_FMT "\n",
+			IPOIB_GID_ARG(mcast->mcmember.mgid));
+
+	if (mcast->ah)
+		ipoib_put_ah(mcast->ah);
+
+	while (!skb_queue_empty(&mcast->pkt_queue)) {
+		struct sk_buff *skb = skb_dequeue(&mcast->pkt_queue);
+
+		skb->dev = dev;
+		dev_kfree_skb_any(skb);
+	}
+
+	kfree(mcast);
+}
+
+static struct ipoib_mcast *ipoib_mcast_alloc(struct net_device *dev,
+					     int can_sleep)
+{
+	struct ipoib_mcast *mcast;
+
+	mcast = kmalloc(sizeof (*mcast), can_sleep ? GFP_KERNEL : GFP_ATOMIC);
+	if (!mcast)
+		return NULL;
+
+	memset(mcast, 0, sizeof (*mcast));
+
+	init_completion(&mcast->done);
+
+	mcast->dev = dev;
+	mcast->created = jiffies;
+	mcast->backoff = HZ;
+	mcast->logcount = 0;
+
+	INIT_LIST_HEAD(&mcast->list);
+	skb_queue_head_init(&mcast->pkt_queue);
+
+	mcast->ah    = NULL;
+	mcast->query = NULL;
+
+	return mcast;
+}
+
+static struct ipoib_mcast *__ipoib_mcast_find(struct net_device *dev, union ib_gid *mgid)
+{
+	struct ipoib_dev_priv *priv = netdev_priv(dev);
+	struct rb_node *n = priv->multicast_tree.rb_node;
+
+	while (n) {
+		struct ipoib_mcast *mcast;
+		int ret;
+
+		mcast = rb_entry(n, struct ipoib_mcast, rb_node);
+
+		ret = memcmp(mgid->raw, mcast->mcmember.mgid.raw,
+			     sizeof (union ib_gid));
+		if (ret < 0)
+			n = n->rb_left;
+		else if (ret > 0)
+			n = n->rb_right;
+		else
+			return mcast;
+	}
+
+	return NULL;
+}
+
+static int __ipoib_mcast_add(struct net_device *dev, struct ipoib_mcast *mcast)
+{
+	struct ipoib_dev_priv *priv = netdev_priv(dev);
+	struct rb_node **n = &priv->multicast_tree.rb_node, *pn = NULL;
+
+	while (*n) {
+		struct ipoib_mcast *tmcast;
+		int ret;
+
+		pn = *n;
+		tmcast = rb_entry(pn, struct ipoib_mcast, rb_node);
+
+		ret = memcmp(mcast->mcmember.mgid.raw, tmcast->mcmember.mgid.raw,
+			     sizeof (union ib_gid));
+		if (ret < 0)
+			n = &pn->rb_left;
+		else if (ret > 0)
+			n = &pn->rb_right;
+		else
+			return -EEXIST;
+	}
+
+	rb_link_node(&mcast->rb_node, pn, n);
+	rb_insert_color(&mcast->rb_node, &priv->multicast_tree);
+
+	return 0;
+}
+
+static int ipoib_mcast_join_finish(struct ipoib_mcast *mcast,
+				   struct ib_sa_mcmember_rec *mcmember)
+{
+	struct net_device *dev = mcast->dev;
+	struct ipoib_dev_priv *priv = netdev_priv(dev);
+	int ret;
+
+	mcast->mcmember = *mcmember;
+
+	/* Set the cached Q_Key before we attach if it's the broadcast group */
+	if (!memcmp(mcast->mcmember.mgid.raw, priv->dev->broadcast + 4,
+		    sizeof (union ib_gid)))
+		priv->qkey = be32_to_cpu(priv->broadcast->mcmember.qkey);
+
+	if (!test_bit(IPOIB_MCAST_FLAG_SENDONLY, &mcast->flags)) {
+		if (test_and_set_bit(IPOIB_MCAST_FLAG_ATTACHED, &mcast->flags)) {
+			ipoib_warn(priv, "multicast group " IPOIB_GID_FMT
+				   " already attached\n",
+				   IPOIB_GID_ARG(mcast->mcmember.mgid));
+
+			return 0;
+		}
+
+		ret = ipoib_mcast_attach(dev, be16_to_cpu(mcast->mcmember.mlid),
+					 &mcast->mcmember.mgid);
+		if (ret < 0) {
+			ipoib_warn(priv, "couldn't attach QP to multicast group "
+				   IPOIB_GID_FMT "\n",
+				   IPOIB_GID_ARG(mcast->mcmember.mgid));
+
+			clear_bit(IPOIB_MCAST_FLAG_ATTACHED, &mcast->flags);
+			return ret;
+		}
+	}
+
+	{
+		struct ib_ah_attr av = {
+			.dlid	       = be16_to_cpu(mcast->mcmember.mlid),
+			.port_num      = priv->port,
+			.sl	       = mcast->mcmember.sl,
+			.src_path_bits = 0,
+			.static_rate   = 0,
+			.ah_flags      = IB_AH_GRH,
+			.grh	       = {
+				.flow_label    = be32_to_cpu(mcast->mcmember.flow_label),
+				.hop_limit     = mcast->mcmember.hop_limit,
+				.sgid_index    = 0,
+				.traffic_class = mcast->mcmember.traffic_class
+			}
+		};
+
+		av.grh.dgid = mcast->mcmember.mgid;
+
+		mcast->ah = ipoib_create_ah(dev, priv->pd, &av);
+		if (!mcast->ah) {
+			ipoib_warn(priv, "ib_address_create failed\n");
+		} else {
+			ipoib_dbg_mcast(priv, "MGID " IPOIB_GID_FMT
+					" AV %p, LID 0x%04x, SL %d\n",
+					IPOIB_GID_ARG(mcast->mcmember.mgid),
+					mcast->ah->ah,
+					be16_to_cpu(mcast->mcmember.mlid),
+					mcast->mcmember.sl);
+		}
+	}
+
+	/* actually send any queued packets */
+	while (!skb_queue_empty(&mcast->pkt_queue)) {
+		struct sk_buff *skb = skb_dequeue(&mcast->pkt_queue);
+
+		skb->dev = dev;
+
+		if (dev_queue_xmit(skb))
+			ipoib_warn(priv, "dev_queue_xmit failed to requeue packet\n");
+	}
+
+	return 0;
+}
+
+static void
+ipoib_mcast_sendonly_join_complete(int status,
+				   struct ib_sa_mcmember_rec *mcmember,
+				   void *mcast_ptr)
+{
+	struct ipoib_mcast *mcast = mcast_ptr;
+	struct net_device *dev = mcast->dev;
+
+	if (!status)
+		ipoib_mcast_join_finish(mcast, mcmember);
+	else {
+		if (mcast->logcount++ < 20)
+			ipoib_dbg_mcast(netdev_priv(dev), "multicast join failed for "
+					IPOIB_GID_FMT ", status %d\n",
+					IPOIB_GID_ARG(mcast->mcmember.mgid), status);
+
+		/* Flush out any queued packets */
+		while (!skb_queue_empty(&mcast->pkt_queue)) {
+			struct sk_buff *skb = skb_dequeue(&mcast->pkt_queue);
+
+			skb->dev = dev;
+
+			dev_kfree_skb_any(skb);
+		}
+
+		/* Clear the busy flag so we try again */
+		clear_bit(IPOIB_MCAST_FLAG_BUSY, &mcast->flags);
+	}
+
+	complete(&mcast->done);
+}
+
+static int ipoib_mcast_sendonly_join(struct ipoib_mcast *mcast)
+{
+	struct net_device *dev = mcast->dev;
+	struct ipoib_dev_priv *priv = netdev_priv(dev);
+	struct ib_sa_mcmember_rec rec = {
+#if 0				/* Some SMs don't support send-only yet */
+		.join_state = 4
+#else
+		.join_state = 1
+#endif
+	};
+	int ret = 0;
+
+	if (!test_bit(IPOIB_FLAG_OPER_UP, &priv->flags)) {
+		ipoib_dbg_mcast(priv, "device shutting down, no multicast joins\n");
+		return -ENODEV;
+	}
+
+	if (test_and_set_bit(IPOIB_MCAST_FLAG_BUSY, &mcast->flags)) {
+		ipoib_dbg_mcast(priv, "multicast entry busy, skipping\n");
+		return -EBUSY;
+	}
+
+	rec.mgid     = mcast->mcmember.mgid;
+	rec.port_gid = priv->local_gid;
+	rec.pkey     = be16_to_cpu(priv->pkey);
+
+	ret = ib_sa_mcmember_rec_set(priv->ca, priv->port, &rec,
+				     IB_SA_MCMEMBER_REC_MGID		|
+				     IB_SA_MCMEMBER_REC_PORT_GID	|
+				     IB_SA_MCMEMBER_REC_PKEY		|
+				     IB_SA_MCMEMBER_REC_JOIN_STATE,
+				     1000, GFP_ATOMIC,
+				     ipoib_mcast_sendonly_join_complete,
+				     mcast, &mcast->query);
+	if (ret < 0) {
+		ipoib_warn(priv, "ib_sa_mcmember_rec_set failed (ret = %d)\n",
+			   ret);
+	} else {
+		ipoib_dbg_mcast(priv, "no multicast record for " IPOIB_GID_FMT
+				", starting join\n",
+				IPOIB_GID_ARG(mcast->mcmember.mgid));
+
+		mcast->query_id = ret;
+	}
+
+	return ret;
+}
+
+static void ipoib_mcast_join_complete(int status,
+				      struct ib_sa_mcmember_rec *mcmember,
+				      void *mcast_ptr)
+{
+	struct ipoib_mcast *mcast = mcast_ptr;
+	struct net_device *dev = mcast->dev;
+	struct ipoib_dev_priv *priv = netdev_priv(dev);
+
+	ipoib_dbg_mcast(priv, "join completion for " IPOIB_GID_FMT
+			" (status %d)\n",
+			IPOIB_GID_ARG(mcast->mcmember.mgid), status);
+
+	if (!status && !ipoib_mcast_join_finish(mcast, mcmember)) {
+		mcast->backoff = HZ;
+		down(&mcast_mutex);
+		if (test_bit(IPOIB_MCAST_RUN, &priv->flags))
+			queue_work(ipoib_workqueue, &priv->mcast_task);
+		up(&mcast_mutex);
+		complete(&mcast->done);
+		return;
+	}
+
+	if (status == -EINTR) {
+		complete(&mcast->done);
+		return;
+	}
+
+	if (status && mcast->logcount++ < 20) {
+		if (status == -ETIMEDOUT || status == -EINTR) {
+			ipoib_dbg_mcast(priv, "multicast join failed for " IPOIB_GID_FMT
+					", status %d\n",
+					IPOIB_GID_ARG(mcast->mcmember.mgid),
+					status);
+		} else {
+			ipoib_warn(priv, "multicast join failed for "
+				   IPOIB_GID_FMT ", status %d\n",
+				   IPOIB_GID_ARG(mcast->mcmember.mgid),
+				   status);
+		}
+	}
+
+	mcast->backoff *= 2;
+	if (mcast->backoff > IPOIB_MAX_BACKOFF_SECONDS)
+		mcast->backoff = IPOIB_MAX_BACKOFF_SECONDS;
+
+	mcast->query = NULL;
+
+	down(&mcast_mutex);
+	if (test_bit(IPOIB_MCAST_RUN, &priv->flags)) {
+		if (status == -ETIMEDOUT)
+			queue_work(ipoib_workqueue, &priv->mcast_task);
+		else
+			queue_delayed_work(ipoib_workqueue, &priv->mcast_task,
+					   mcast->backoff * HZ);
+	} else
+		complete(&mcast->done);
+	up(&mcast_mutex);
+
+	return;
+}
+
+static void ipoib_mcast_join(struct net_device *dev, struct ipoib_mcast *mcast,
+			     int create)
+{
+	struct ipoib_dev_priv *priv = netdev_priv(dev);
+	struct ib_sa_mcmember_rec rec = {
+		.join_state = 1
+	};
+	ib_sa_comp_mask comp_mask;
+	int ret = 0;
+
+	ipoib_dbg_mcast(priv, "joining MGID " IPOIB_GID_FMT "\n",
+			IPOIB_GID_ARG(mcast->mcmember.mgid));
+
+	rec.mgid     = mcast->mcmember.mgid;
+	rec.port_gid = priv->local_gid;
+	rec.pkey     = be16_to_cpu(priv->pkey);
+
+	comp_mask =
+		IB_SA_MCMEMBER_REC_MGID		|
+		IB_SA_MCMEMBER_REC_PORT_GID	|
+		IB_SA_MCMEMBER_REC_PKEY		|
+		IB_SA_MCMEMBER_REC_JOIN_STATE;
+
+	if (create) {
+		comp_mask |=
+			IB_SA_MCMEMBER_REC_QKEY		|
+			IB_SA_MCMEMBER_REC_SL		|
+			IB_SA_MCMEMBER_REC_FLOW_LABEL	|
+			IB_SA_MCMEMBER_REC_TRAFFIC_CLASS;
+
+		rec.qkey	  = priv->broadcast->mcmember.qkey;
+		rec.sl		  = priv->broadcast->mcmember.sl;
+		rec.flow_label	  = priv->broadcast->mcmember.flow_label;
+		rec.traffic_class = priv->broadcast->mcmember.traffic_class;
+	}
+
+	ret = ib_sa_mcmember_rec_set(priv->ca, priv->port, &rec, comp_mask,
+				     mcast->backoff * 1000, GFP_ATOMIC,
+				     ipoib_mcast_join_complete,
+				     mcast, &mcast->query);
+
+	if (ret < 0) {
+		ipoib_warn(priv, "ib_sa_mcmember_rec_set failed, status %d\n", ret);
+
+		mcast->backoff *= 2;
+		if (mcast->backoff > IPOIB_MAX_BACKOFF_SECONDS)
+			mcast->backoff = IPOIB_MAX_BACKOFF_SECONDS;
+
+		down(&mcast_mutex);
+		if (test_bit(IPOIB_MCAST_RUN, &priv->flags))
+			queue_delayed_work(ipoib_workqueue,
+					   &priv->mcast_task,
+					   mcast->backoff);
+		up(&mcast_mutex);
+	} else
+		mcast->query_id = ret;
+}
+
+void ipoib_mcast_join_task(void *dev_ptr)
+{
+	struct net_device *dev = dev_ptr;
+	struct ipoib_dev_priv *priv = netdev_priv(dev);
+
+	if (!test_bit(IPOIB_MCAST_RUN, &priv->flags))
+		return;
+
+	if (ib_query_gid(priv->ca, priv->port, 0, &priv->local_gid))
+		ipoib_warn(priv, "ib_gid_entry_get() failed\n");
+	else
+		memcpy(priv->dev->dev_addr + 4, priv->local_gid.raw, sizeof (union ib_gid));
+
+	if (!priv->broadcast) {
+		priv->broadcast = ipoib_mcast_alloc(dev, 1);
+		if (!priv->broadcast) {
+			ipoib_warn(priv, "failed to allocate broadcast group\n");
+			down(&mcast_mutex);
+			if (test_bit(IPOIB_MCAST_RUN, &priv->flags))
+				queue_delayed_work(ipoib_workqueue,
+						   &priv->mcast_task, HZ);
+			up(&mcast_mutex);
+			return;
+		}
+
+		memcpy(priv->broadcast->mcmember.mgid.raw, priv->dev->broadcast + 4,
+		       sizeof (union ib_gid));
+
+		spin_lock_irq(&priv->lock);
+		__ipoib_mcast_add(dev, priv->broadcast);
+		spin_unlock_irq(&priv->lock);
+	}
+
+	if (!test_bit(IPOIB_MCAST_FLAG_ATTACHED, &priv->broadcast->flags)) {
+		ipoib_mcast_join(dev, priv->broadcast, 0);
+		return;
+	}
+
+	while (1) {
+		struct ipoib_mcast *mcast = NULL;
+
+		spin_lock_irq(&priv->lock);
+		list_for_each_entry(mcast, &priv->multicast_list, list) {
+			if (!test_bit(IPOIB_MCAST_FLAG_SENDONLY, &mcast->flags)
+			    && !test_bit(IPOIB_MCAST_FLAG_BUSY, &mcast->flags)
+			    && !test_bit(IPOIB_MCAST_FLAG_ATTACHED, &mcast->flags)) {
+				/* Found the next unjoined group */
+				break;
+			}
+		}
+		spin_unlock_irq(&priv->lock);
+
+		if (&mcast->list == &priv->multicast_list) {
+			/* All done */
+			break;
+		}
+
+		ipoib_mcast_join(dev, mcast, 1);
+		return;
+	}
+
+	{
+		struct ib_port_attr attr;
+
+		if (!ib_query_port(priv->ca, priv->port, &attr))
+			priv->local_lid = attr.lid;
+		else
+			ipoib_warn(priv, "ib_query_port failed\n");
+	}
+
+	priv->mcast_mtu = ib_mtu_enum_to_int(priv->broadcast->mcmember.mtu) -
+		IPOIB_ENCAP_LEN;
+	dev->mtu = min(priv->mcast_mtu, priv->admin_mtu);
+
+	ipoib_dbg_mcast(priv, "successfully joined all multicast groups\n");
+
+	clear_bit(IPOIB_MCAST_RUN, &priv->flags);
+	netif_carrier_on(dev);
+}
+
+int ipoib_mcast_start_thread(struct net_device *dev)
+{
+	struct ipoib_dev_priv *priv = netdev_priv(dev);
+
+	ipoib_dbg_mcast(priv, "starting multicast thread\n");
+
+	down(&mcast_mutex);
+	if (!test_and_set_bit(IPOIB_MCAST_RUN, &priv->flags))
+		queue_work(ipoib_workqueue, &priv->mcast_task);
+	up(&mcast_mutex);
+
+	return 0;
+}
+
+int ipoib_mcast_stop_thread(struct net_device *dev)
+{
+	struct ipoib_dev_priv *priv = netdev_priv(dev);
+	struct ipoib_mcast *mcast;
+
+	ipoib_dbg_mcast(priv, "stopping multicast thread\n");
+
+	down(&mcast_mutex);
+	clear_bit(IPOIB_MCAST_RUN, &priv->flags);
+	cancel_delayed_work(&priv->mcast_task);
+	up(&mcast_mutex);
+
+	flush_workqueue(ipoib_workqueue);
+
+	if (priv->broadcast && priv->broadcast->query) {
+		ib_sa_cancel_query(priv->broadcast->query_id, priv->broadcast->query);
+		priv->broadcast->query = NULL;
+		ipoib_dbg_mcast(priv, "waiting for bcast\n");
+		wait_for_completion(&priv->broadcast->done);
+	}
+
+	list_for_each_entry(mcast, &priv->multicast_list, list) {
+		if (mcast->query) {
+			ib_sa_cancel_query(mcast->query_id, mcast->query);
+			mcast->query = NULL;
+			ipoib_dbg_mcast(priv, "waiting for MGID " IPOIB_GID_FMT "\n",
+					IPOIB_GID_ARG(mcast->mcmember.mgid));
+			wait_for_completion(&mcast->done);
+		}
+	}
+
+	return 0;
+}
+
+int ipoib_mcast_leave(struct net_device *dev, struct ipoib_mcast *mcast)
+{
+	struct ipoib_dev_priv *priv = netdev_priv(dev);
+	struct ib_sa_mcmember_rec rec = {
+		.join_state = 1
+	};
+	int ret = 0;
+
+	if (!test_and_clear_bit(IPOIB_MCAST_FLAG_ATTACHED, &mcast->flags))
+		return 0;
+
+	ipoib_dbg_mcast(priv, "leaving MGID " IPOIB_GID_FMT "\n",
+			IPOIB_GID_ARG(mcast->mcmember.mgid));
+
+	rec.mgid     = mcast->mcmember.mgid;
+	rec.port_gid = priv->local_gid;
+	rec.pkey     = be16_to_cpu(priv->pkey);
+
+	/* Remove ourselves from the multicast group */
+	ret = ipoib_mcast_detach(dev, be16_to_cpu(mcast->mcmember.mlid),
+				 &mcast->mcmember.mgid);
+	if (ret)
+		ipoib_warn(priv, "ipoib_mcast_detach failed (result = %d)\n", ret);
+
+	/*
+	 * Just make one shot at leaving and don't wait for a reply;
+	 * if we fail, too bad.
+	 */
+	ret = ib_sa_mcmember_rec_delete(priv->ca, priv->port, &rec,
+					IB_SA_MCMEMBER_REC_MGID		|
+					IB_SA_MCMEMBER_REC_PORT_GID	|
+					IB_SA_MCMEMBER_REC_PKEY		|
+					IB_SA_MCMEMBER_REC_JOIN_STATE,
+					0, GFP_ATOMIC, NULL,
+					mcast, &mcast->query);
+	if (ret < 0)
+		ipoib_warn(priv, "ib_sa_mcmember_rec_delete failed "
+			   "for leave (result = %d)\n", ret);
+
+	return 0;
+}
+
+void ipoib_mcast_send(struct net_device *dev, union ib_gid *mgid,
+		      struct sk_buff *skb)
+{
+	struct ipoib_dev_priv *priv = netdev_priv(dev);
+	struct ipoib_mcast *mcast;
+	unsigned long flags;
+
+	spin_lock_irqsave(&priv->lock, flags);
+	mcast = __ipoib_mcast_find(dev, mgid);
+	if (!mcast) {
+		/* Let's create a new send only group now */
+		ipoib_dbg_mcast(priv, "setting up send only multicast group for "
+				IPOIB_GID_FMT "\n", IPOIB_GID_ARG(*mgid));
+
+		mcast = ipoib_mcast_alloc(dev, 0);
+		if (!mcast) {
+			ipoib_warn(priv, "unable to allocate memory for "
+				   "multicast structure\n");
+			dev_kfree_skb_any(skb);
+			goto out;
+		}
+
+		set_bit(IPOIB_MCAST_FLAG_SENDONLY, &mcast->flags);
+		mcast->mcmember.mgid = *mgid;
+		__ipoib_mcast_add(dev, mcast);
+		list_add_tail(&mcast->list, &priv->multicast_list);
+	}
+
+	if (!mcast->ah) {
+		if (skb_queue_len(&mcast->pkt_queue) < IPOIB_MAX_MCAST_QUEUE)
+			skb_queue_tail(&mcast->pkt_queue, skb);
+		else
+			dev_kfree_skb_any(skb);
+
+		if (mcast->query)
+			ipoib_dbg_mcast(priv, "no address vector, "
+					"but multicast join already started\n");
+		else if (test_bit(IPOIB_MCAST_FLAG_SENDONLY, &mcast->flags))
+			ipoib_mcast_sendonly_join(mcast);
+
+		/*
+		 * If lookup completes between here and out:, don't
+		 * want to send packet twice.
+		 */
+		mcast = NULL;
+	}
+
+out:
+	spin_unlock_irqrestore(&priv->lock, flags);
+	if (mcast && mcast->ah) {
+		if (skb->dst            &&
+		    skb->dst->neighbour &&
+		    !*to_ipoib_path(skb->dst->neighbour)) {
+			struct ipoib_path *path = kmalloc(sizeof *path, GFP_ATOMIC);
+
+			if (path) {
+				kref_get(&mcast->ah->ref);
+				path->ah  	= mcast->ah;
+				path->dev 	= dev;
+				path->neighbour = skb->dst->neighbour;
+				*to_ipoib_path(skb->dst->neighbour) = path;
+			}
+		}
+
+		ipoib_send(dev, skb, mcast->ah, IB_MULTICAST_QPN);
+	}
+}
+
+void ipoib_mcast_dev_flush(struct net_device *dev)
+{
+	struct ipoib_dev_priv *priv = netdev_priv(dev);
+	LIST_HEAD(remove_list);
+	struct ipoib_mcast *mcast, *tmcast, *nmcast;
+	unsigned long flags;
+
+	ipoib_dbg_mcast(priv, "flushing multicast list\n");
+
+	spin_lock_irqsave(&priv->lock, flags);
+	list_for_each_entry_safe(mcast, tmcast, &priv->multicast_list, list) {
+		nmcast = ipoib_mcast_alloc(dev, 0);
+		if (nmcast) {
+			nmcast->flags =
+				mcast->flags & (1 << IPOIB_MCAST_FLAG_SENDONLY);
+
+			nmcast->mcmember.mgid = mcast->mcmember.mgid;
+
+			/* Add the new group in before the to-be-destroyed group */
+			list_add_tail(&nmcast->list, &mcast->list);
+			list_del_init(&mcast->list);
+
+			rb_replace_node(&mcast->rb_node, &nmcast->rb_node,
+					&priv->multicast_tree);
+
+			list_add_tail(&mcast->list, &remove_list);
+		} else {
+			ipoib_warn(priv, "could not reallocate multicast group "
+				   IPOIB_GID_FMT "\n",
+				   IPOIB_GID_ARG(mcast->mcmember.mgid));
+		}
+	}
+
+	if (priv->broadcast) {
+		nmcast = ipoib_mcast_alloc(dev, 0);
+		if (nmcast) {
+			nmcast->mcmember.mgid = priv->broadcast->mcmember.mgid;
+
+			rb_replace_node(&priv->broadcast->rb_node,
+					&nmcast->rb_node,
+					&priv->multicast_tree);
+
+			list_add_tail(&priv->broadcast->list, &remove_list);
+		}
+
+		priv->broadcast = nmcast;
+	}
+
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	list_for_each_entry(mcast, &remove_list, list) {
+		ipoib_mcast_leave(dev, mcast);
+		ipoib_mcast_free(mcast);
+	}
+}
+
+void ipoib_mcast_dev_down(struct net_device *dev)
+{
+	struct ipoib_dev_priv *priv = netdev_priv(dev);
+	unsigned long flags;
+
+	/* Delete broadcast since it will be recreated */
+	if (priv->broadcast) {
+		ipoib_dbg_mcast(priv, "deleting broadcast group\n");
+
+		spin_lock_irqsave(&priv->lock, flags);
+		rb_erase(&priv->broadcast->rb_node, &priv->multicast_tree);
+		spin_unlock_irqrestore(&priv->lock, flags);
+		ipoib_mcast_leave(dev, priv->broadcast);
+		ipoib_mcast_free(priv->broadcast);
+		priv->broadcast = NULL;
+	}
+}
+
+void ipoib_mcast_restart_task(void *dev_ptr)
+{
+	struct net_device *dev = dev_ptr;
+	struct ipoib_dev_priv *priv = netdev_priv(dev);
+	struct dev_mc_list *mclist;
+	struct ipoib_mcast *mcast, *tmcast;
+	LIST_HEAD(remove_list);
+	unsigned long flags;
+
+	ipoib_dbg_mcast(priv, "restarting multicast task\n");
+
+	ipoib_mcast_stop_thread(dev);
+
+	spin_lock_irqsave(&priv->lock, flags);
+
+	/*
+	 * Unfortunately, the networking core only gives us a list of all of
+	 * the multicast hardware addresses. We need to figure out which ones
+	 * are new and which ones have been removed
+	 */
+
+	/* Clear out the found flag */
+	list_for_each_entry(mcast, &priv->multicast_list, list)
+		clear_bit(IPOIB_MCAST_FLAG_FOUND, &mcast->flags);
+
+	/* Mark all of the entries that are found or don't exist */
+	for (mclist = dev->mc_list; mclist; mclist = mclist->next) {
+		union ib_gid mgid;
+
+		memcpy(mgid.raw, mclist->dmi_addr + 4, sizeof mgid);
+
+		/* Add in the P_Key */
+		mgid.raw[4] = (priv->pkey >> 8) & 0xff;
+		mgid.raw[5] = priv->pkey & 0xff;
+
+		mcast = __ipoib_mcast_find(dev, &mgid);
+		if (!mcast || test_bit(IPOIB_MCAST_FLAG_SENDONLY, &mcast->flags)) {
+			struct ipoib_mcast *nmcast;
+
+			/* Not found or send-only group, let's add a new entry */
+			ipoib_dbg_mcast(priv, "adding multicast entry for mgid "
+					IPOIB_GID_FMT "\n", IPOIB_GID_ARG(mgid));
+
+			nmcast = ipoib_mcast_alloc(dev, 0);
+			if (!nmcast) {
+				ipoib_warn(priv, "unable to allocate memory for multicast structure\n");
+				continue;
+			}
+
+			set_bit(IPOIB_MCAST_FLAG_FOUND, &nmcast->flags);
+
+			nmcast->mcmember.mgid = mgid;
+
+			if (mcast) {
+				/* Destroy the send only entry */
+				list_del(&mcast->list);
+				list_add_tail(&mcast->list, &remove_list);
+
+				rb_replace_node(&mcast->rb_node,
+						&nmcast->rb_node,
+						&priv->multicast_tree);
+			} else
+				__ipoib_mcast_add(dev, nmcast);
+
+			list_add_tail(&nmcast->list, &priv->multicast_list);
+		}
+
+		if (mcast)
+			set_bit(IPOIB_MCAST_FLAG_FOUND, &mcast->flags);
+	}
+
+	/* Remove all of the entries don't exist anymore */
+	list_for_each_entry_safe(mcast, tmcast, &priv->multicast_list, list) {
+		if (!test_bit(IPOIB_MCAST_FLAG_FOUND, &mcast->flags) &&
+		    !test_bit(IPOIB_MCAST_FLAG_SENDONLY, &mcast->flags)) {
+			ipoib_dbg_mcast(priv, "deleting multicast group " IPOIB_GID_FMT "\n",
+					IPOIB_GID_ARG(mcast->mcmember.mgid));
+
+			rb_erase(&mcast->rb_node, &priv->multicast_tree);
+
+			/* Move to the remove list */
+			list_del(&mcast->list);
+			list_add_tail(&mcast->list, &remove_list);
+		}
+	}
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	/* We have to cancel outside of the spinlock */
+	list_for_each_entry(mcast, &remove_list, list) {
+		ipoib_mcast_leave(mcast->dev, mcast);
+		ipoib_mcast_free(mcast);
+	}
+
+	if (test_bit(IPOIB_FLAG_ADMIN_UP, &priv->flags))
+		ipoib_mcast_start_thread(dev);
+}
+
+struct ipoib_mcast_iter *ipoib_mcast_iter_init(struct net_device *dev)
+{
+	struct ipoib_mcast_iter *iter;
+
+	iter = kmalloc(sizeof *iter, GFP_KERNEL);
+	if (!iter)
+		return NULL;
+
+	iter->dev = dev;
+	memset(iter->mgid.raw, 0, sizeof iter->mgid);
+
+	if (ipoib_mcast_iter_next(iter)) {
+		ipoib_mcast_iter_free(iter);
+		return NULL;
+	}
+
+	return iter;
+}
+
+void ipoib_mcast_iter_free(struct ipoib_mcast_iter *iter)
+{
+	kfree(iter);
+}
+
+int ipoib_mcast_iter_next(struct ipoib_mcast_iter *iter)
+{
+	struct ipoib_dev_priv *priv = netdev_priv(iter->dev);
+	struct rb_node *n;
+	struct ipoib_mcast *mcast;
+	int ret = 1;
+
+	spin_lock_irq(&priv->lock);
+
+	n = rb_first(&priv->multicast_tree);
+
+	while (n) {
+		mcast = rb_entry(n, struct ipoib_mcast, rb_node);
+
+		if (memcmp(iter->mgid.raw, mcast->mcmember.mgid.raw,
+			   sizeof (union ib_gid)) < 0) {
+			iter->mgid      = mcast->mcmember.mgid;
+			iter->created   = mcast->created;
+			iter->queuelen  = skb_queue_len(&mcast->pkt_queue);
+			iter->complete  = !!mcast->ah;
+			iter->send_only = !!(mcast->flags & (1 << IPOIB_MCAST_FLAG_SENDONLY));
+
+			ret = 0;
+
+			break;
+		}
+
+		n = rb_next(n);
+	}
+
+	spin_unlock_irq(&priv->lock);
+
+	return ret;
+}
+
+void ipoib_mcast_iter_read(struct ipoib_mcast_iter *iter,
+			   union ib_gid *mgid,
+			   unsigned long *created,
+			   unsigned int *queuelen,
+			   unsigned int *complete,
+			   unsigned int *send_only)
+{
+	*mgid      = iter->mgid;
+	*created   = iter->created;
+	*queuelen  = iter->queuelen;
+	*complete  = iter->complete;
+	*send_only = iter->send_only;
+}
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-bk/drivers/infiniband/ulp/ipoib/ipoib_proto.h	2004-11-23 08:10:22.978174248 -0800
@@ -0,0 +1,37 @@
+/*
+ * This software is available to you under a choice of one of two
+ * licenses.  You may choose to be licensed under the terms of the GNU
+ * General Public License (GPL) Version 2, available at
+ * <http://www.fsf.org/copyleft/gpl.html>, or the OpenIB.org BSD
+ * license, available in the LICENSE.TXT file accompanying this
+ * software.  These details are also available at
+ * <http://openib.org/license.html>.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+ * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
+ * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
+ * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+ * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+ * SOFTWARE.
+ *
+ * Copyright (c) 2004 Topspin Communications.  All rights reserved.
+ *
+ * $Id: ipoib_proto.h 1254 2004-11-17 17:19:12Z roland $
+ */
+
+#ifndef _IPOIB_PROTO_H
+#define _IPOIB_PROTO_H
+
+#include <linux/netdevice.h>
+#include <ib_verbs.h>
+
+/*
+ * Public functions
+ */
+
+int ipoib_device_handle(struct net_device *dev, struct ib_device **ca,
+			u8 *port_num, union ib_gid *gid, u16 *pkey);
+
+#endif /* _IPOIB_PROTO_H */
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-bk/drivers/infiniband/ulp/ipoib/ipoib_verbs.c	2004-11-23 08:10:23.018168351 -0800
@@ -0,0 +1,248 @@
+/*
+ * This software is available to you under a choice of one of two
+ * licenses.  You may choose to be licensed under the terms of the GNU
+ * General Public License (GPL) Version 2, available at
+ * <http://www.fsf.org/copyleft/gpl.html>, or the OpenIB.org BSD
+ * license, available in the LICENSE.TXT file accompanying this
+ * software.  These details are also available at
+ * <http://openib.org/license.html>.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+ * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
+ * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
+ * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+ * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+ * SOFTWARE.
+ *
+ * Copyright (c) 2004 Topspin Communications.  All rights reserved.
+ *
+ * $Id: ipoib_verbs.c 1262 2004-11-18 17:38:36Z roland $
+ */
+
+#include <ib_cache.h>
+
+#include "ipoib.h"
+
+int ipoib_mcast_attach(struct net_device *dev, u16 mlid, union ib_gid *mgid)
+{
+	struct ipoib_dev_priv *priv = netdev_priv(dev);
+	struct ib_qp_attr *qp_attr;
+	int attr_mask;
+	int ret;
+	u16 pkey_index;
+
+	ret = -ENOMEM;
+	qp_attr = kmalloc(sizeof *qp_attr, GFP_KERNEL);
+	if (!qp_attr)
+		goto out;
+
+	if (ib_cached_pkey_find(priv->ca, priv->port, priv->pkey, &pkey_index)) {
+		clear_bit(IPOIB_PKEY_ASSIGNED, &priv->flags);
+		ret = -ENXIO;
+		goto out;
+	}
+	set_bit(IPOIB_PKEY_ASSIGNED, &priv->flags);
+
+	/* set correct QKey for QP */
+	qp_attr->qkey = priv->qkey;
+	attr_mask = IB_QP_QKEY;
+	ret = ib_modify_qp(priv->qp, qp_attr, attr_mask);
+	if (ret) {
+		ipoib_warn(priv, "failed to modify QP, ret = %d\n", ret);
+		goto out;
+	}
+
+	/* attach QP to multicast group */
+	down(&priv->mcast_mutex);
+	ret = ib_attach_mcast(priv->qp, mgid, mlid);
+	up(&priv->mcast_mutex);
+	if (ret)
+		ipoib_warn(priv, "failed to attach to multicast group, ret = %d\n", ret);
+
+out:
+	kfree(qp_attr);
+	return ret;
+}
+
+int ipoib_mcast_detach(struct net_device *dev, u16 mlid, union ib_gid *mgid)
+{
+	struct ipoib_dev_priv *priv = netdev_priv(dev);
+	int ret;
+
+	down(&priv->mcast_mutex);
+	ret = ib_detach_mcast(priv->qp, mgid, mlid);
+	up(&priv->mcast_mutex);
+	if (ret)
+		ipoib_warn(priv, "ib_detach_mcast failed (result = %d)\n", ret);
+
+	return ret;
+}
+
+int ipoib_qp_create(struct net_device *dev)
+{
+	struct ipoib_dev_priv *priv = netdev_priv(dev);
+	int ret;
+	u16 pkey_index;
+	struct ib_qp_attr qp_attr;
+	int attr_mask;
+
+	/*
+	 * Search through the port P_Key table for the requested pkey value.
+	 * The port has to be assigned to the respective IB partition in
+	 * advance.
+	 */
+	ret = ib_cached_pkey_find(priv->ca, priv->port, priv->pkey, &pkey_index);
+	if (ret) {
+		clear_bit(IPOIB_PKEY_ASSIGNED, &priv->flags);
+		return ret;
+	}
+	set_bit(IPOIB_PKEY_ASSIGNED, &priv->flags);
+
+	qp_attr.qp_state = IB_QPS_INIT;
+	qp_attr.qkey = 0;
+	qp_attr.port_num = priv->port;
+	qp_attr.pkey_index = pkey_index;
+	attr_mask =
+	    IB_QP_QKEY |
+	    IB_QP_PORT |
+	    IB_QP_PKEY_INDEX |
+	    IB_QP_STATE;
+	ret = ib_modify_qp(priv->qp, &qp_attr, attr_mask);
+	if (ret) {
+		ipoib_warn(priv, "failed to modify QP to init, ret = %d\n", ret);
+		goto out_fail;
+	}
+
+	qp_attr.qp_state = IB_QPS_RTR;
+	/* Can't set this in a INIT->RTR transition */
+	attr_mask &= ~IB_QP_PORT;
+	ret = ib_modify_qp(priv->qp, &qp_attr, attr_mask);
+	if (ret) {
+		ipoib_warn(priv, "failed to modify QP to RTR, ret = %d\n", ret);
+		goto out_fail;
+	}
+
+	qp_attr.qp_state = IB_QPS_RTS;
+	qp_attr.sq_psn = 0;
+	attr_mask |= IB_QP_SQ_PSN;
+	attr_mask &= ~IB_QP_PKEY_INDEX;
+	ret = ib_modify_qp(priv->qp, &qp_attr, attr_mask);
+	if (ret) {
+		ipoib_warn(priv, "failed to modify QP to RTS, ret = %d\n", ret);
+		goto out_fail;
+	}
+
+	return 0;
+
+out_fail:
+	ib_destroy_qp(priv->qp);
+	priv->qp = NULL;
+
+	return -EINVAL;
+}
+
+int ipoib_transport_dev_init(struct net_device *dev, struct ib_device *ca)
+{
+	struct ipoib_dev_priv *priv = netdev_priv(dev);
+	struct ib_qp_init_attr init_attr = {
+		.cap = {
+			.max_send_wr  = IPOIB_TX_RING_SIZE,
+			.max_recv_wr  = IPOIB_RX_RING_SIZE,
+			.max_send_sge = 1,
+			.max_recv_sge = 1
+		},
+		.sq_sig_type = IB_SIGNAL_ALL_WR,
+		.rq_sig_type = IB_SIGNAL_ALL_WR,
+		.qp_type     = IB_QPT_UD
+	};
+
+	priv->pd = ib_alloc_pd(priv->ca);
+	if (IS_ERR(priv->pd)) {
+		printk(KERN_WARNING "%s: failed to allocate PD\n", ca->name);
+		return -ENODEV;
+	}
+
+	priv->cq = ib_create_cq(priv->ca, ipoib_ib_completion, NULL, dev,
+				IPOIB_TX_RING_SIZE + IPOIB_RX_RING_SIZE + 1);
+	if (IS_ERR(priv->cq)) {
+		printk(KERN_WARNING "%s: failed to create CQ\n", ca->name);
+		goto out_free_pd;
+	}
+
+	if (ib_req_notify_cq(priv->cq, IB_CQ_NEXT_COMP))
+		goto out_free_cq;
+
+	priv->mr = ib_get_dma_mr(priv->pd, IB_ACCESS_LOCAL_WRITE);
+	if (IS_ERR(priv->mr)) {
+		printk(KERN_WARNING "%s: ib_reg_phys_mr failed\n", ca->name);
+		goto out_free_cq;
+	}
+
+	init_attr.send_cq = priv->cq;
+	init_attr.recv_cq = priv->cq,
+
+	priv->qp = ib_create_qp(priv->pd, &init_attr);
+	if (IS_ERR(priv->qp)) {
+		printk(KERN_WARNING "%s: failed to create QP\n", ca->name);
+		goto out_free_mr;
+	}
+
+	priv->dev->dev_addr[1] = (priv->qp->qp_num >> 16) & 0xff;
+	priv->dev->dev_addr[2] = (priv->qp->qp_num >>  8) & 0xff;
+	priv->dev->dev_addr[3] = (priv->qp->qp_num      ) & 0xff;
+
+	return 0;
+
+out_free_mr:
+	ib_dereg_mr(priv->mr);
+
+out_free_cq:
+	ib_destroy_cq(priv->cq);
+
+out_free_pd:
+	ib_dealloc_pd(priv->pd);
+	return -ENODEV;
+}
+
+void ipoib_transport_dev_cleanup(struct net_device *dev)
+{
+	struct ipoib_dev_priv *priv = netdev_priv(dev);
+
+	if (priv->qp) {
+		if (ib_destroy_qp(priv->qp))
+			ipoib_warn(priv, "ib_qp_destroy failed\n");
+
+		priv->qp = NULL;
+		clear_bit(IPOIB_PKEY_ASSIGNED, &priv->flags);
+	}
+
+	if (ib_dereg_mr(priv->mr))
+		ipoib_warn(priv, "ib_dereg_mr failed\n");
+
+	if (ib_destroy_cq(priv->cq))
+		ipoib_warn(priv, "ib_cq_destroy failed\n");
+
+	if (ib_dealloc_pd(priv->pd))
+		ipoib_warn(priv, "ib_dealloc_pd failed\n");
+}
+
+void ipoib_event(struct ib_event_handler *handler,
+		 struct ib_event *record)
+{
+	struct ipoib_dev_priv *priv =
+		container_of(handler, struct ipoib_dev_priv, event_handler);
+
+	if (record->event == IB_EVENT_PORT_ACTIVE) {
+		ipoib_dbg(priv, "Port active event\n");
+		schedule_work(&priv->flush_task);
+	}
+}
+
+/*
+  Local Variables:
+  c-file-style: "linux"
+  indent-tabs-mode: t
+  End:
+*/
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-bk/drivers/infiniband/ulp/ipoib/ipoib_vlan.c	2004-11-23 08:10:23.043164665 -0800
@@ -0,0 +1,166 @@
+/*
+ * This software is available to you under a choice of one of two
+ * licenses.  You may choose to be licensed under the terms of the GNU
+ * General Public License (GPL) Version 2, available at
+ * <http://www.fsf.org/copyleft/gpl.html>, or the OpenIB.org BSD
+ * license, available in the LICENSE.TXT file accompanying this
+ * software.  These details are also available at
+ * <http://openib.org/license.html>.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+ * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
+ * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
+ * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+ * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+ * SOFTWARE.
+ *
+ * Copyright (c) 2004 Topspin Communications.  All rights reserved.
+ *
+ * $Id: ipoib_vlan.c 1271 2004-11-18 22:11:29Z roland $
+ */
+
+#include <linux/version.h>
+#include <linux/module.h>
+
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/seq_file.h>
+
+#include <asm/uaccess.h>
+
+#include "ipoib.h"
+
+static ssize_t show_parent(struct class_device *class_dev, char *buf)
+{
+	struct net_device *dev =
+		container_of(class_dev, struct net_device, class_dev);
+	struct ipoib_dev_priv *priv = netdev_priv(dev);
+
+	return sprintf(buf, "%s\n", priv->parent->name);
+}
+static CLASS_DEVICE_ATTR(parent, S_IRUGO, show_parent, NULL);
+
+int ipoib_vlan_add(struct net_device *pdev, unsigned short pkey)
+{
+	struct ipoib_dev_priv *ppriv, *priv;
+	char intf_name[IFNAMSIZ];
+	int result;
+
+	if (!capable(CAP_NET_ADMIN))
+		return -EPERM;
+
+	ppriv = netdev_priv(pdev);
+
+	down(&ppriv->vlan_mutex);
+
+	/*
+	 * First ensure this isn't a duplicate. We check the parent device and
+	 * then all of the child interfaces to make sure the Pkey doesn't match.
+	 */
+	if (ppriv->pkey == pkey) {
+		result = -ENOTUNIQ;
+		goto err;
+	}
+
+	list_for_each_entry(priv, &ppriv->child_intfs, list) {
+		if (priv->pkey == pkey) {
+			result = -ENOTUNIQ;
+			goto err;
+		}
+	}
+
+	snprintf(intf_name, sizeof intf_name, "%s.%04x",
+		 ppriv->dev->name, pkey);
+	priv = ipoib_intf_alloc(intf_name);
+	if (!priv) {
+		result = -ENOMEM;
+		goto err;
+	}
+
+	set_bit(IPOIB_FLAG_SUBINTERFACE, &priv->flags);
+
+	priv->pkey = pkey;
+
+	memcpy(priv->dev->dev_addr, ppriv->dev->dev_addr, INFINIBAND_ALEN);
+	priv->dev->broadcast[8] = pkey >> 8;
+	priv->dev->broadcast[9] = pkey & 0xff;
+
+	result = ipoib_dev_init(priv->dev, ppriv->ca, ppriv->port);
+	if (result < 0) {
+		ipoib_warn(ppriv, "failed to initialize subinterface: "
+			   "device %s, port %d",
+			   ppriv->ca->name, ppriv->port);
+		goto device_init_failed;
+	}
+
+	result = register_netdev(priv->dev);
+	if (result) {
+		ipoib_warn(priv, "failed to initialize; error %i", result);
+		goto register_failed;
+	}
+
+	priv->parent = ppriv->dev;
+
+	if (ipoib_create_debug_file(priv->dev))
+		goto debug_failed;
+
+	if (ipoib_add_pkey_attr(priv->dev))
+		goto sysfs_failed;
+
+	if (class_device_create_file(&priv->dev->class_dev,
+				     &class_device_attr_parent))
+		goto sysfs_failed;
+
+	list_add_tail(&priv->list, &ppriv->child_intfs);
+
+	up(&ppriv->vlan_mutex);
+
+	return 0;
+
+sysfs_failed:
+	ipoib_delete_debug_file(priv->dev);
+
+debug_failed:
+	unregister_netdev(priv->dev);
+
+register_failed:
+	ipoib_dev_cleanup(priv->dev);
+
+device_init_failed:
+	free_netdev(priv->dev);
+
+err:
+	up(&ppriv->vlan_mutex);
+	return result;
+}
+
+int ipoib_vlan_delete(struct net_device *pdev, unsigned short pkey)
+{
+	struct ipoib_dev_priv *ppriv, *priv, *tpriv;
+	int ret = -ENOENT;
+
+	if (!capable(CAP_NET_ADMIN))
+		return -EPERM;
+
+	ppriv = netdev_priv(pdev);
+
+	down(&ppriv->vlan_mutex);
+	list_for_each_entry_safe(priv, tpriv, &ppriv->child_intfs, list) {
+		if (priv->pkey == pkey) {
+			unregister_netdev(priv->dev);
+			ipoib_dev_cleanup(priv->dev);
+
+			list_del(&priv->list);
+
+			kfree(priv);
+
+			ret = 0;
+			break;
+		}
+	}
+	up(&ppriv->vlan_mutex);
+
+	return ret;
+}

