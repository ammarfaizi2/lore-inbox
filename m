Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750948AbWG0U6S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750948AbWG0U6S (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 16:58:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750955AbWG0Uxv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 16:53:51 -0400
Received: from mx2.redhat.com ([66.187.237.31]:49889 "EHLO mx2.redhat.com")
	by vger.kernel.org with ESMTP id S1750936AbWG0UxT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 16:53:19 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 19/30] NFS: Add server and volume lists to /proc [try #11]
Date: Thu, 27 Jul 2006 21:53:09 +0100
To: torvalds@osdl.org, akpm@osdl.org, steved@redhat.com,
       trond.myklebust@fys.uio.no
Cc: linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
       nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org
Message-Id: <20060727205309.8443.91347.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20060727205222.8443.29381.stgit@warthog.cambridge.redhat.com>
References: <20060727205222.8443.29381.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make two new proc files available:

	/proc/fs/nfsfs/servers
	/proc/fs/nfsfs/volumes

The first lists the servers with which we are currently dealing (struct
nfs_client), and the second lists the volumes we have on those servers (struct
nfs_server).

Signed-Off-By: David Howells <dhowells@redhat.com>
Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>
---

 fs/nfs/client.c   |  284 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/nfs/inode.c    |    7 +
 fs/nfs/internal.h |   12 ++
 3 files changed, 303 insertions(+), 0 deletions(-)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index dafba60..27f6478 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -1148,3 +1148,287 @@ out_free_server:
 	dprintk("<-- nfs_clone_server() = error %d\n", error);
 	return ERR_PTR(error);
 }
+
+#ifdef CONFIG_PROC_FS
+static struct proc_dir_entry *proc_fs_nfs;
+
+static int nfs_server_list_open(struct inode *inode, struct file *file);
+static void *nfs_server_list_start(struct seq_file *p, loff_t *pos);
+static void *nfs_server_list_next(struct seq_file *p, void *v, loff_t *pos);
+static void nfs_server_list_stop(struct seq_file *p, void *v);
+static int nfs_server_list_show(struct seq_file *m, void *v);
+
+static struct seq_operations nfs_server_list_ops = {
+	.start	= nfs_server_list_start,
+	.next	= nfs_server_list_next,
+	.stop	= nfs_server_list_stop,
+	.show	= nfs_server_list_show,
+};
+
+static struct file_operations nfs_server_list_fops = {
+	.open		= nfs_server_list_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= seq_release,
+};
+
+static int nfs_volume_list_open(struct inode *inode, struct file *file);
+static void *nfs_volume_list_start(struct seq_file *p, loff_t *pos);
+static void *nfs_volume_list_next(struct seq_file *p, void *v, loff_t *pos);
+static void nfs_volume_list_stop(struct seq_file *p, void *v);
+static int nfs_volume_list_show(struct seq_file *m, void *v);
+
+static struct seq_operations nfs_volume_list_ops = {
+	.start	= nfs_volume_list_start,
+	.next	= nfs_volume_list_next,
+	.stop	= nfs_volume_list_stop,
+	.show	= nfs_volume_list_show,
+};
+
+static struct file_operations nfs_volume_list_fops = {
+	.open		= nfs_volume_list_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= seq_release,
+};
+
+/*
+ * open "/proc/fs/nfsfs/servers" which provides a summary of servers with which
+ * we're dealing
+ */
+static int nfs_server_list_open(struct inode *inode, struct file *file)
+{
+	struct seq_file *m;
+	int ret;
+
+	ret = seq_open(file, &nfs_server_list_ops);
+	if (ret < 0)
+		return ret;
+
+	m = file->private_data;
+	m->private = PDE(inode)->data;
+
+	return 0;
+}
+
+/*
+ * set up the iterator to start reading from the server list and return the first item
+ */
+static void *nfs_server_list_start(struct seq_file *m, loff_t *_pos)
+{
+	struct list_head *_p;
+	loff_t pos = *_pos;
+
+	/* lock the list against modification */
+	spin_lock(&nfs_client_lock);
+
+	/* allow for the header line */
+	if (!pos)
+		return SEQ_START_TOKEN;
+	pos--;
+
+	/* find the n'th element in the list */
+	list_for_each(_p, &nfs_client_list)
+		if (!pos--)
+			break;
+
+	return _p != &nfs_client_list ? _p : NULL;
+}
+
+/*
+ * move to next server
+ */
+static void *nfs_server_list_next(struct seq_file *p, void *v, loff_t *pos)
+{
+	struct list_head *_p;
+
+	(*pos)++;
+
+	_p = v;
+	_p = (v == SEQ_START_TOKEN) ? nfs_client_list.next : _p->next;
+
+	return _p != &nfs_client_list ? _p : NULL;
+}
+
+/*
+ * clean up after reading from the transports list
+ */
+static void nfs_server_list_stop(struct seq_file *p, void *v)
+{
+	spin_unlock(&nfs_client_lock);
+}
+
+/*
+ * display a header line followed by a load of call lines
+ */
+static int nfs_server_list_show(struct seq_file *m, void *v)
+{
+	struct nfs_client *clp;
+
+	/* display header on line 1 */
+	if (v == SEQ_START_TOKEN) {
+		seq_puts(m, "NV SERVER   PORT USE HOSTNAME\n");
+		return 0;
+	}
+
+	/* display one transport per line on subsequent lines */
+	clp = list_entry(v, struct nfs_client, cl_share_link);
+
+	seq_printf(m, "v%d %02x%02x%02x%02x %4hx %3d %s\n",
+		   clp->cl_nfsversion,
+		   NIPQUAD(clp->cl_addr.sin_addr),
+		   ntohs(clp->cl_addr.sin_port),
+		   atomic_read(&clp->cl_count),
+		   clp->cl_hostname);
+
+	return 0;
+}
+
+/*
+ * open "/proc/fs/nfsfs/volumes" which provides a summary of extant volumes
+ */
+static int nfs_volume_list_open(struct inode *inode, struct file *file)
+{
+	struct seq_file *m;
+	int ret;
+
+	ret = seq_open(file, &nfs_volume_list_ops);
+	if (ret < 0)
+		return ret;
+
+	m = file->private_data;
+	m->private = PDE(inode)->data;
+
+	return 0;
+}
+
+/*
+ * set up the iterator to start reading from the volume list and return the first item
+ */
+static void *nfs_volume_list_start(struct seq_file *m, loff_t *_pos)
+{
+	struct list_head *_p;
+	loff_t pos = *_pos;
+
+	/* lock the list against modification */
+	spin_lock(&nfs_client_lock);
+
+	/* allow for the header line */
+	if (!pos)
+		return SEQ_START_TOKEN;
+	pos--;
+
+	/* find the n'th element in the list */
+	list_for_each(_p, &nfs_volume_list)
+		if (!pos--)
+			break;
+
+	return _p != &nfs_volume_list ? _p : NULL;
+}
+
+/*
+ * move to next volume
+ */
+static void *nfs_volume_list_next(struct seq_file *p, void *v, loff_t *pos)
+{
+	struct list_head *_p;
+
+	(*pos)++;
+
+	_p = v;
+	_p = (v == SEQ_START_TOKEN) ? nfs_volume_list.next : _p->next;
+
+	return _p != &nfs_volume_list ? _p : NULL;
+}
+
+/*
+ * clean up after reading from the transports list
+ */
+static void nfs_volume_list_stop(struct seq_file *p, void *v)
+{
+	spin_unlock(&nfs_client_lock);
+}
+
+/*
+ * display a header line followed by a load of call lines
+ */
+static int nfs_volume_list_show(struct seq_file *m, void *v)
+{
+	struct nfs_server *server;
+	struct nfs_client *clp;
+	char dev[8], fsid[17];
+
+	/* display header on line 1 */
+	if (v == SEQ_START_TOKEN) {
+		seq_puts(m, "NV SERVER   PORT DEV     FSID\n");
+		return 0;
+	}
+	/* display one transport per line on subsequent lines */
+	server = list_entry(v, struct nfs_server, master_link);
+	clp = server->nfs_client;
+
+	snprintf(dev, 8, "%u:%u",
+		 MAJOR(server->s_dev), MINOR(server->s_dev));
+
+	snprintf(fsid, 17, "%llx:%llx",
+		 server->fsid.major, server->fsid.minor);
+
+	seq_printf(m, "v%d %02x%02x%02x%02x %4hx %-7s %-17s\n",
+		   clp->cl_nfsversion,
+		   NIPQUAD(clp->cl_addr.sin_addr),
+		   ntohs(clp->cl_addr.sin_port),
+		   dev,
+		   fsid);
+
+	return 0;
+}
+
+/*
+ * initialise the /proc/fs/nfsfs/ directory
+ */
+int __init nfs_fs_proc_init(void)
+{
+	struct proc_dir_entry *p;
+
+	proc_fs_nfs = proc_mkdir("nfsfs", proc_root_fs);
+	if (!proc_fs_nfs)
+		goto error_0;
+
+	proc_fs_nfs->owner = THIS_MODULE;
+
+	/* a file of servers with which we're dealing */
+	p = create_proc_entry("servers", S_IFREG|S_IRUGO, proc_fs_nfs);
+	if (!p)
+		goto error_1;
+
+	p->proc_fops = &nfs_server_list_fops;
+	p->owner = THIS_MODULE;
+
+	/* a file of volumes that we have mounted */
+	p = create_proc_entry("volumes", S_IFREG|S_IRUGO, proc_fs_nfs);
+	if (!p)
+		goto error_2;
+
+	p->proc_fops = &nfs_volume_list_fops;
+	p->owner = THIS_MODULE;
+	return 0;
+
+error_2:
+	remove_proc_entry("servers", proc_fs_nfs);
+error_1:
+	remove_proc_entry("nfsfs", proc_root_fs);
+error_0:
+	return -ENOMEM;
+}
+
+/*
+ * clean up the /proc/fs/nfsfs/ directory
+ */
+void nfs_fs_proc_exit(void)
+{
+	remove_proc_entry("volumes", proc_fs_nfs);
+	remove_proc_entry("servers", proc_fs_nfs);
+	remove_proc_entry("nfsfs", proc_root_fs);
+}
+
+#endif /* CONFIG_PROC_FS */
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 261411a..7665b73 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -1144,6 +1144,10 @@ static int __init init_nfs_fs(void)
 {
 	int err;
 
+	err = nfs_fs_proc_init();
+	if (err)
+		goto out5;
+
 	err = nfs_init_nfspagecache();
 	if (err)
 		goto out4;
@@ -1184,6 +1188,8 @@ out2:
 out3:
 	nfs_destroy_nfspagecache();
 out4:
+	nfs_fs_proc_exit();
+out5:
 	return err;
 }
 
@@ -1198,6 +1204,7 @@ #ifdef CONFIG_PROC_FS
 	rpc_proc_unregister("nfs");
 #endif
 	unregister_nfs_fs();
+	nfs_fs_proc_exit();
 }
 
 /* Not quite true; I just maintain it */
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 3d51eee..1a1312e 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -47,6 +47,18 @@ extern void nfs_free_server(struct nfs_s
 extern struct nfs_server *nfs_clone_server(struct nfs_server *,
 					   struct nfs_fh *,
 					   struct nfs_fattr *);
+#ifdef CONFIG_PROC_FS
+extern int __init nfs_fs_proc_init(void);
+extern void nfs_fs_proc_exit(void);
+#else
+static inline int nfs_fs_proc_init(void)
+{
+	return 0;
+}
+static inline void nfs_fs_proc_exit(void)
+{
+}
+#endif
 
 /* nfs4namespace.c */
 #ifdef CONFIG_NFS_V4
