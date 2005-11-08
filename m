Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965279AbVKHGa6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965279AbVKHGa6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 01:30:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965283AbVKHGaz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 01:30:55 -0500
Received: from ams-iport-1.cisco.com ([144.254.224.140]:8290 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S965261AbVKHGac (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 01:30:32 -0500
Subject: [git patch review 3/6] [IPoIB] add path record information in debugfs
From: Roland Dreier <rolandd@cisco.com>
Date: Tue, 08 Nov 2005 06:30:19 +0000
To: linux-kernel@vger.kernel.org, openib-general@openib.org
X-Mailer: IB-patch-reviewer
Content-Transfer-Encoding: 8bit
Message-ID: <1131431419060-dda308f068edb6f9@cisco.com>
In-Reply-To: <1131431419060-1bf7238b3fe2f830@cisco.com>
X-OriginalArrivalTime: 08 Nov 2005 06:30:20.0240 (UTC) FILETIME=[E427C500:01C5E42D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add ibX_path files to debugfs that contain information about the IPoIB
path cache.  IPoIB ARP only gives GIDs, which the IPoIB driver must
resolve to real IB paths through the ib_sa module.  For debugging,
when the ARP table looks OK but traffic isn't flowing, it's useful to
be able to see if the resolution from GID to path worked.

Also clean up the formatting of the existing _mcg debugfs files.

Signed-off-by: Roland Dreier <rolandd@cisco.com>

---

 drivers/infiniband/ulp/ipoib/ipoib.h           |   15 +-
 drivers/infiniband/ulp/ipoib/ipoib_fs.c        |  179 +++++++++++++++++++++---
 drivers/infiniband/ulp/ipoib/ipoib_main.c      |   72 +++++++++-
 drivers/infiniband/ulp/ipoib/ipoib_multicast.c |    9 -
 drivers/infiniband/ulp/ipoib/ipoib_vlan.c      |    7 -
 5 files changed, 233 insertions(+), 49 deletions(-)

applies-to: f681c9c9ea858c5b14f593077e7cadf9e93ad255
3924a6898a88a805d6297029f0705743cbfff587
diff --git a/drivers/infiniband/ulp/ipoib/ipoib.h b/drivers/infiniband/ulp/ipoib/ipoib.h
index 0095acc..9923a15 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib.h
+++ b/drivers/infiniband/ulp/ipoib/ipoib.h
@@ -179,6 +179,7 @@ struct ipoib_dev_priv {
 #ifdef CONFIG_INFINIBAND_IPOIB_DEBUG
 	struct list_head fs_list;
 	struct dentry *mcg_dentry;
+	struct dentry *path_dentry;
 #endif
 };
 
@@ -270,7 +271,6 @@ void ipoib_mcast_dev_flush(struct net_de
 
 #ifdef CONFIG_INFINIBAND_IPOIB_DEBUG
 struct ipoib_mcast_iter *ipoib_mcast_iter_init(struct net_device *dev);
-void ipoib_mcast_iter_free(struct ipoib_mcast_iter *iter);
 int ipoib_mcast_iter_next(struct ipoib_mcast_iter *iter);
 void ipoib_mcast_iter_read(struct ipoib_mcast_iter *iter,
 				  union ib_gid *gid,
@@ -278,6 +278,11 @@ void ipoib_mcast_iter_read(struct ipoib_
 				  unsigned int *queuelen,
 				  unsigned int *complete,
 				  unsigned int *send_only);
+
+struct ipoib_path_iter *ipoib_path_iter_init(struct net_device *dev);
+int ipoib_path_iter_next(struct ipoib_path_iter *iter);
+void ipoib_path_iter_read(struct ipoib_path_iter *iter,
+			  struct ipoib_path *path);
 #endif
 
 int ipoib_mcast_attach(struct net_device *dev, u16 mlid,
@@ -299,13 +304,13 @@ void ipoib_pkey_poll(void *dev);
 int ipoib_pkey_dev_delay_open(struct net_device *dev);
 
 #ifdef CONFIG_INFINIBAND_IPOIB_DEBUG
-int ipoib_create_debug_file(struct net_device *dev);
-void ipoib_delete_debug_file(struct net_device *dev);
+void ipoib_create_debug_files(struct net_device *dev);
+void ipoib_delete_debug_files(struct net_device *dev);
 int ipoib_register_debugfs(void);
 void ipoib_unregister_debugfs(void);
 #else
-static inline int ipoib_create_debug_file(struct net_device *dev) { return 0; }
-static inline void ipoib_delete_debug_file(struct net_device *dev) { }
+static inline void ipoib_create_debug_files(struct net_device *dev) { }
+static inline void ipoib_delete_debug_files(struct net_device *dev) { }
 static inline int ipoib_register_debugfs(void) { return 0; }
 static inline void ipoib_unregister_debugfs(void) { }
 #endif
diff --git a/drivers/infiniband/ulp/ipoib/ipoib_fs.c b/drivers/infiniband/ulp/ipoib/ipoib_fs.c
index 38b150f..a5b8bb4 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_fs.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_fs.c
@@ -43,6 +43,18 @@ struct file_operations;
 
 static struct dentry *ipoib_root;
 
+static void format_gid(union ib_gid *gid, char *buf)
+{
+	int i, n;
+
+	for (n = 0, i = 0; i < 8; ++i) {
+		n += sprintf(buf + n, "%x",
+			     be16_to_cpu(((__be16 *) gid->raw)[i]));
+		if (i < 7)
+			buf[n++] = ':';
+	}
+}
+
 static void *ipoib_mcg_seq_start(struct seq_file *file, loff_t *pos)
 {
 	struct ipoib_mcast_iter *iter;
@@ -54,7 +66,7 @@ static void *ipoib_mcg_seq_start(struct 
 
 	while (n--) {
 		if (ipoib_mcast_iter_next(iter)) {
-			ipoib_mcast_iter_free(iter);
+			kfree(iter);
 			return NULL;
 		}
 	}
@@ -70,7 +82,7 @@ static void *ipoib_mcg_seq_next(struct s
 	(*pos)++;
 
 	if (ipoib_mcast_iter_next(iter)) {
-		ipoib_mcast_iter_free(iter);
+		kfree(iter);
 		return NULL;
 	}
 
@@ -91,28 +103,29 @@ static int ipoib_mcg_seq_show(struct seq
 	unsigned long created;
 	unsigned int queuelen, complete, send_only;
 
-	if (iter) {
-		ipoib_mcast_iter_read(iter, &mgid, &created, &queuelen,
-				      &complete, &send_only);
-
-		for (n = 0, i = 0; i < sizeof mgid / 2; ++i) {
-			n += sprintf(gid_buf + n, "%x",
-				     be16_to_cpu(((__be16 *) mgid.raw)[i]));
-			if (i < sizeof mgid / 2 - 1)
-				gid_buf[n++] = ':';
-		}
-	}
+	if (!iter)
+		return 0;
+
+	ipoib_mcast_iter_read(iter, &mgid, &created, &queuelen,
+			      &complete, &send_only);
 
-	seq_printf(file, "GID: %*s", -(1 + (int) sizeof gid_buf), gid_buf);
+	format_git(&mgid, gid_buf);
 
 	seq_printf(file,
-		   " created: %10ld queuelen: %4d complete: %d send_only: %d\n",
-		   created, queuelen, complete, send_only);
+		   "GID: %s\n"
+		   "  created: %10ld\n"
+		   "  queuelen: %9d\n"
+		   "  complete: %9s\n"
+		   "  send_only: %8s\n"
+		   "\n",
+		   gid_buf, created, queuelen,
+		   complete ? "yes" : "no",
+		   send_only ? "yes" : "no");
 
 	return 0;
 }
 
-static struct seq_operations ipoib_seq_ops = {
+static struct seq_operations ipoib_mcg_seq_ops = {
 	.start = ipoib_mcg_seq_start,
 	.next  = ipoib_mcg_seq_next,
 	.stop  = ipoib_mcg_seq_stop,
@@ -124,7 +137,7 @@ static int ipoib_mcg_open(struct inode *
 	struct seq_file *seq;
 	int ret;
 
-	ret = seq_open(file, &ipoib_seq_ops);
+	ret = seq_open(file, &ipoib_mcg_seq_ops);
 	if (ret)
 		return ret;
 
@@ -134,7 +147,7 @@ static int ipoib_mcg_open(struct inode *
 	return 0;
 }
 
-static struct file_operations ipoib_fops = {
+static struct file_operations ipoib_mcg_fops = {
 	.owner   = THIS_MODULE,
 	.open    = ipoib_mcg_open,
 	.read    = seq_read,
@@ -142,25 +155,139 @@ static struct file_operations ipoib_fops
 	.release = seq_release
 };
 
-int ipoib_create_debug_file(struct net_device *dev)
+static void *ipoib_path_seq_start(struct seq_file *file, loff_t *pos)
+{
+	struct ipoib_path_iter *iter;
+	loff_t n = *pos;
+
+	iter = ipoib_path_iter_init(file->private);
+	if (!iter)
+		return NULL;
+
+	while (n--) {
+		if (ipoib_path_iter_next(iter)) {
+			kfree(iter);
+			return NULL;
+		}
+	}
+
+	return iter;
+}
+
+static void *ipoib_path_seq_next(struct seq_file *file, void *iter_ptr,
+				   loff_t *pos)
+{
+	struct ipoib_path_iter *iter = iter_ptr;
+
+	(*pos)++;
+
+	if (ipoib_path_iter_next(iter)) {
+		kfree(iter);
+		return NULL;
+	}
+
+	return iter;
+}
+
+static void ipoib_path_seq_stop(struct seq_file *file, void *iter_ptr)
+{
+	/* nothing for now */
+}
+
+static int ipoib_path_seq_show(struct seq_file *file, void *iter_ptr)
+{
+	struct ipoib_path_iter *iter = iter_ptr;
+	char gid_buf[sizeof "ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff"];
+	struct ipoib_path path;
+	int i, n;
+	int rate;
+
+	if (!iter)
+		return 0;
+
+	ipoib_path_iter_read(iter, &path);
+
+	format_git(&path.pathrec.dgid, gid_buf);
+
+	seq_printf(file,
+		   "GID: %s\n"
+		   "  complete: %6s\n",
+		   gid_buf, path.pathrec.dlid ? "yes" : "no");
+
+	if (path.pathrec.dlid) {
+		rate = ib_sa_rate_enum_to_int(path.pathrec.rate) * 25;
+
+		seq_printf(file,
+			   "  DLID:     0x%04x\n"
+			   "  SL: %12d\n"
+			   "  rate: %*d%s Gb/sec\n",
+			   be16_to_cpu(path.pathrec.dlid),
+			   path.pathrec.sl,
+			   10 - ((rate % 10) ? 2 : 0),
+			   rate / 10, rate % 10 ? ".5" : "");
+	}
+
+	seq_putc(file, '\n');
+
+	return 0;
+}
+
+static struct seq_operations ipoib_path_seq_ops = {
+	.start = ipoib_path_seq_start,
+	.next  = ipoib_path_seq_next,
+	.stop  = ipoib_path_seq_stop,
+	.show  = ipoib_path_seq_show,
+};
+
+static int ipoib_path_open(struct inode *inode, struct file *file)
+{
+	struct seq_file *seq;
+	int ret;
+
+	ret = seq_open(file, &ipoib_path_seq_ops);
+	if (ret)
+		return ret;
+
+	seq = file->private_data;
+	seq->private = inode->u.generic_ip;
+
+	return 0;
+}
+
+static struct file_operations ipoib_path_fops = {
+	.owner   = THIS_MODULE,
+	.open    = ipoib_path_open,
+	.read    = seq_read,
+	.llseek  = seq_lseek,
+	.release = seq_release
+};
+
+void ipoib_create_debug_files(struct net_device *dev)
 {
 	struct ipoib_dev_priv *priv = netdev_priv(dev);
-	char name[IFNAMSIZ + sizeof "_mcg"];
+	char name[IFNAMSIZ + sizeof "_path"];
 
 	snprintf(name, sizeof name, "%s_mcg", dev->name);
-
 	priv->mcg_dentry = debugfs_create_file(name, S_IFREG | S_IRUGO,
-					       ipoib_root, dev, &ipoib_fops);
-
-	return priv->mcg_dentry ? 0 : -ENOMEM;
+					       ipoib_root, dev, &ipoib_mcg_fops);
+	if (!priv->mcg_dentry)
+		ipoib_warn(priv, "failed to create mcg debug file\n");
+
+	snprintf(name, sizeof name, "%s_path", dev->name);
+	priv->path_dentry = debugfs_create_file(name, S_IFREG | S_IRUGO,
+						ipoib_root, dev, &ipoib_path_fops);
+	if (!priv->path_dentry)
+		ipoib_warn(priv, "failed to create path debug file\n");
 }
 
-void ipoib_delete_debug_file(struct net_device *dev)
+void ipoib_delete_debug_files(struct net_device *dev)
 {
 	struct ipoib_dev_priv *priv = netdev_priv(dev);
 
 	if (priv->mcg_dentry)
 		debugfs_remove(priv->mcg_dentry);
+	if (priv->path_dentry)
+		debugfs_remove(priv->path_dentry);
 }
 
 int ipoib_register_debugfs(void)
diff --git a/drivers/infiniband/ulp/ipoib/ipoib_main.c b/drivers/infiniband/ulp/ipoib/ipoib_main.c
index ce02962..2fa3075 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_main.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_main.c
@@ -58,6 +58,11 @@ module_param_named(debug_level, ipoib_de
 MODULE_PARM_DESC(debug_level, "Enable debug tracing if > 0");
 #endif
 
+struct ipoib_path_iter {
+	struct net_device *dev;
+	struct ipoib_path  path;
+};
+
 static const u8 ipv4_bcast_addr[] = {
 	0x00, 0xff, 0xff, 0xff,
 	0xff, 0x12, 0x40, 0x1b,	0x00, 0x00, 0x00, 0x00,
@@ -250,6 +255,64 @@ static void path_free(struct net_device 
 	kfree(path);
 }
 
+#ifdef CONFIG_INFINIBAND_IPOIB_DEBUG
+
+struct ipoib_path_iter *ipoib_path_iter_init(struct net_device *dev)
+{
+	struct ipoib_path_iter *iter;
+
+	iter = kmalloc(sizeof *iter, GFP_KERNEL);
+	if (!iter)
+		return NULL;
+
+	iter->dev = dev;
+	memset(iter->path.pathrec.dgid.raw, 0, 16);
+
+	if (ipoib_path_iter_next(iter)) {
+		kfree(iter);
+		return NULL;
+	}
+
+	return iter;
+}
+
+int ipoib_path_iter_next(struct ipoib_path_iter *iter)
+{
+	struct ipoib_dev_priv *priv = netdev_priv(iter->dev);
+	struct rb_node *n;
+	struct ipoib_path *path;
+	int ret = 1;
+
+	spin_lock_irq(&priv->lock);
+
+	n = rb_first(&priv->path_tree);
+
+	while (n) {
+		path = rb_entry(n, struct ipoib_path, rb_node);
+
+		if (memcmp(iter->path.pathrec.dgid.raw, path->pathrec.dgid.raw,
+			   sizeof (union ib_gid)) < 0) {
+			iter->path = *path;
+			ret = 0;
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
+void ipoib_path_iter_read(struct ipoib_path_iter *iter,
+			  struct ipoib_path *path)
+{
+	*path = iter->path;
+}
+
+#endif /* CONFIG_INFINIBAND_IPOIB_DEBUG */
+
 void ipoib_flush_paths(struct net_device *dev)
 {
 	struct ipoib_dev_priv *priv = netdev_priv(dev);
@@ -763,7 +826,7 @@ void ipoib_dev_cleanup(struct net_device
 {
 	struct ipoib_dev_priv *priv = netdev_priv(dev), *cpriv, *tcpriv;
 
-	ipoib_delete_debug_file(dev);
+	ipoib_delete_debug_files(dev);
 
 	/* Delete any child interfaces first */
 	list_for_each_entry_safe(cpriv, tcpriv, &priv->child_intfs, list) {
@@ -972,8 +1035,7 @@ static struct net_device *ipoib_add_port
 		goto register_failed;
 	}
 
-	if (ipoib_create_debug_file(priv->dev))
-		goto debug_failed;
+	ipoib_create_debug_files(priv->dev);
 
 	if (ipoib_add_pkey_attr(priv->dev))
 		goto sysfs_failed;
@@ -987,9 +1049,7 @@ static struct net_device *ipoib_add_port
 	return priv->dev;
 
 sysfs_failed:
-	ipoib_delete_debug_file(priv->dev);
-
-debug_failed:
+	ipoib_delete_debug_files(priv->dev);
 	unregister_netdev(priv->dev);
 
 register_failed:
diff --git a/drivers/infiniband/ulp/ipoib/ipoib_multicast.c b/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
index 3ecf78a..8709693 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
@@ -928,21 +928,16 @@ struct ipoib_mcast_iter *ipoib_mcast_ite
 		return NULL;
 
 	iter->dev = dev;
-	memset(iter->mgid.raw, 0, sizeof iter->mgid);
+	memset(iter->mgid.raw, 0, 16);
 
 	if (ipoib_mcast_iter_next(iter)) {
-		ipoib_mcast_iter_free(iter);
+		kfree(iter);
 		return NULL;
 	}
 
 	return iter;
 }
 
-void ipoib_mcast_iter_free(struct ipoib_mcast_iter *iter)
-{
-	kfree(iter);
-}
-
 int ipoib_mcast_iter_next(struct ipoib_mcast_iter *iter)
 {
 	struct ipoib_dev_priv *priv = netdev_priv(iter->dev);
diff --git a/drivers/infiniband/ulp/ipoib/ipoib_vlan.c b/drivers/infiniband/ulp/ipoib/ipoib_vlan.c
index 332d730..d280b34 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_vlan.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_vlan.c
@@ -113,8 +113,7 @@ int ipoib_vlan_add(struct net_device *pd
 
 	priv->parent = ppriv->dev;
 
-	if (ipoib_create_debug_file(priv->dev))
-		goto debug_failed;
+	ipoib_create_debug_files(priv->dev);
 
 	if (ipoib_add_pkey_attr(priv->dev))
 		goto sysfs_failed;
@@ -130,9 +129,7 @@ int ipoib_vlan_add(struct net_device *pd
 	return 0;
 
 sysfs_failed:
-	ipoib_delete_debug_file(priv->dev);
-
-debug_failed:
+	ipoib_delete_debug_files(priv->dev);
 	unregister_netdev(priv->dev);
 
 register_failed:
---
0.99.9e
