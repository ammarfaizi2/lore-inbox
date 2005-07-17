Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263097AbVGNSd7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263097AbVGNSd7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 14:33:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263094AbVGNSdy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 14:33:54 -0400
Received: from ms-smtp-05.texas.rr.com ([24.93.47.44]:727 "EHLO
	ms-smtp-05-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S263081AbVGNSbd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 14:31:33 -0400
Message-Id: <200507141830.j6EIUnRh020517@ms-smtp-05-eri0.texas.rr.com>
From: ericvh@gmail.com
Date: Sun, 17 Jul 2005 08:53:52 -0500
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.13-rc2-mm2 4/7] v9fs: VFS superblock operations and glue (2.0.2)
Cc: v9fs-developer@lists.sourceforge.net, akpm@osdl.org,
       linux-fsdevel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is part [4/7] of the v9fs-2.0.2 patch against Linux 2.6.13-rc2-mm2.

This part of the patch contains VFS superblock and mapping code changes
related to hch's comments.

Signed-off-by: Eric Van Hensbergen <ericvh@gmail.com>


 ----------

 v9fs.c      |  103 +++++++++++++++++++++++++++++++++---------------------------
 v9fs.h      |   27 +++++++++++----
 vfs_super.c |   45 +++++++++++++++++++++++---
 3 files changed, 119 insertions(+), 56 deletions(-)

 ----------

--- a/fs/9p/v9fs.h
+++ b/fs/9p/v9fs.h
@@ -22,6 +22,16 @@
  *
  */
 
+/* 
+  * Idpool structure provides lock and id management 
+  *
+  */
+
+struct v9fs_idpool {
+	struct semaphore lock;
+	struct idr pool;
+};
+
 /*
   * Session structure provides information for an opened session
   *
@@ -36,7 +46,6 @@ struct v9fs_session_info {
 	unsigned short debug;	/* debug level */
 	unsigned short proto;	/* protocol to use */
 	unsigned int afid;	/* authentication fid */
-	unsigned int timeout;	/* transport timeout in msec */
 
 	char *name;		/* user name to mount as */
 	char *remotename;	/* name of remote hierarchy being mounted */
@@ -44,8 +53,8 @@ struct v9fs_session_info {
 	unsigned int gid;	/* default gid for legacy support */
 
 	/* book keeping */
-	struct idpool fidpool;	/* The FID pool for file descriptors */
-	struct idpool tidpool;	/* The TID pool for transactions ids */
+	struct v9fs_idpool fidpool;	/* The FID pool for file descriptors */
+	struct v9fs_idpool tidpool;	/* The TID pool for transactions ids */
 
 	/* transport information */
 	struct v9fs_transport *transport;
@@ -65,10 +74,17 @@ struct v9fs_session_info {
 	struct list_head mux_fcalls;
 };
 
+/* possible values of ->proto */
+enum {
+	PROTO_TCP,
+	PROTO_UNIX,
+};
+
 int v9fs_session_init(struct v9fs_session_info *, const char *, char *);
 struct v9fs_session_info *v9fs_inode2v9ses(struct inode *);
 void v9fs_session_close(struct v9fs_session_info *v9ses);
-
+int v9fs_get_idpool(struct v9fs_idpool *p);
+void v9fs_put_idpool(int id, struct v9fs_idpool *p);
 int v9fs_get_option(char *opts, char *name, char *buf, int buflen);
 long long v9fs_get_int_option(char *opts, char *name, long long dflt);
 int v9fs_parse_tcp_devname(const char *devname, char **addr, char **remotename);
@@ -79,10 +95,7 @@ int v9fs_parse_tcp_devname(const char *d
 #define V9FS_PORT		564
 #define V9FS_DEFUSER	"nobody"
 #define V9FS_DEFANAME	""
-#define V9FS_TIMEOUT 	60000
 
 /* inital pool sizes for fids and tags */
 #define V9FS_START_FIDS 8192
 #define V9FS_START_TIDS 256
-
-#define safe_cache_free(x, y) { if(y) kmem_cache_free(x, y); }
diff --git a/fs/9p/vfs_dentry.c b/fs/9p/vfs_dentry.c
--- a/fs/9p/v9fs.c
+++ b/fs/9p/v9fs.c
@@ -29,9 +29,9 @@
 #include <linux/errno.h>
 #include <linux/fs.h>
 #include <linux/parser.h>
+#include <linux/idr.h>
 
 #include "debug.h"
-#include "idpool.h"
 #include "v9fs.h"
 #include "9p.h"
 #include "v9fs_vfs.h"
@@ -48,13 +48,8 @@ int v9fs_debug_level = 0;	/* feature-rif
   */
 
 enum {
-	PROTO_TCP,
-	PROTO_UNIX,
-};
-
-enum {
 	/* Options that take integer arguments */
-	Opt_port, Opt_msize, Opt_uid, Opt_gid, Opt_afid, Opt_debug, Opt_timeo,
+	Opt_port, Opt_msize, Opt_uid, Opt_gid, Opt_afid, Opt_debug, 
 	/* String options */
 	Opt_name, Opt_remotename,
 	/* Options that take no arguments */
@@ -64,7 +59,6 @@ enum {
 };
 
 static match_table_t tokens = {
-	{Opt_timeo, "timeout=%u"},
 	{Opt_port, "port=%u"},
 	{Opt_msize, "msize=%u"},
 	{Opt_uid, "uid=%u"},
@@ -107,7 +101,6 @@ static void v9fs_parse_options(char *opt
 	v9ses->extended = 1;
 	v9ses->afid = ~0;
 	v9ses->debug = 0;
-	v9ses->timeout = V9FS_TIMEOUT;
 
 	if (!options)
 		return;
@@ -126,9 +119,6 @@ static void v9fs_parse_options(char *opt
 
 		}
 		switch (token) {
-		case Opt_timeo:
-			v9ses->timeout = option;
-			break;
 		case Opt_port:
 			v9ses->port = option;
 			break;
@@ -169,20 +159,6 @@ static void v9fs_parse_options(char *opt
 			continue;
 		}
 	}
-
-	dprintk(DEBUG_9P, "options=\n");
-	dprintk(DEBUG_9P, "	debug: %x\n", v9ses->debug);
-	dprintk(DEBUG_9P, "	port: %u\n", v9ses->port);
-	dprintk(DEBUG_9P, "	msize: %u\n", v9ses->maxdata);
-	dprintk(DEBUG_9P, "	uid: %u\n", v9ses->uid);
-	dprintk(DEBUG_9P, "	gid: %u\n", v9ses->gid);
-	dprintk(DEBUG_9P, "	afid: %d\n", v9ses->afid);
-	dprintk(DEBUG_9P, "	proto: %u\n", v9ses->proto);
-	dprintk(DEBUG_9P, "	extended: %u\n", v9ses->extended);
-	dprintk(DEBUG_9P, "	nomapdev: %u\n", v9ses->nodev);
-	dprintk(DEBUG_9P, "	timeout: %u\n", v9ses->timeout);
-	dprintk(DEBUG_9P, "	name: %s\n", v9ses->name);
-	dprintk(DEBUG_9P, "	remotename: %s\n", v9ses->remotename);
 }
 
 /**
@@ -196,21 +172,58 @@ static void v9fs_parse_options(char *opt
 
 struct v9fs_session_info *v9fs_inode2v9ses(struct inode *inode)
 {
-	if (inode) {
-		if (inode->i_sb) {
-			if (inode->i_sb->s_fs_info)
-				return (inode->i_sb->s_fs_info);
-			else {
-				dprintk(DEBUG_ERROR, "no s_fs_info\n");
-				return NULL;
-			}
-		} else {
-			dprintk(DEBUG_ERROR, "no superblock\n");
-			return NULL;
-		}
+	return (inode->i_sb->s_fs_info);
+}
+
+/**
+ * v9fs_get_idpool - allocate numeric id from pool
+ * @p - pool to allocate from
+ *
+ * XXX - This seems to be an awful generic function, should it be in idr.c with
+ *            the lock included in struct idr?
+ */
+
+int v9fs_get_idpool(struct v9fs_idpool *p)
+{
+	int i = 0;
+	int error;
+
+retry:
+	if (idr_pre_get(&p->pool, GFP_KERNEL) == 0)
+		return 0;
+
+	if (down_interruptible(&p->lock) == -EINTR) {
+		eprintk(KERN_WARNING, "Interrupted while locking\n");
+		return -1;
 	}
-	dprintk(DEBUG_ERROR, "no inode\n");
-	return NULL;
+
+	error = idr_get_new(&p->pool, NULL, &i);
+	up(&p->lock);
+
+	if (error == -EAGAIN)
+		goto retry;
+	else if (error)
+		return -1;
+
+	return i;
+}
+
+/**
+ * v9fs_put_idpool - release numeric id from pool
+ * @p - pool to allocate from
+ *
+ * XXX - This seems to be an awful generic function, should it be in idr.c with
+ *            the lock included in struct idr?
+ */
+
+void v9fs_put_idpool(int id, struct v9fs_idpool *p)
+{
+	if (down_interruptible(&p->lock) == -EINTR) {
+		eprintk(KERN_WARNING, "Interrupted while locking\n");
+		return;
+	}
+	idr_remove(&p->pool, id);
+	up(&p->lock);
 }
 
 /**
@@ -250,8 +263,11 @@ v9fs_session_init(struct v9fs_session_in
 	v9fs_debug_level = v9ses->debug;
 
 	/* id pools that are session-dependent: FIDs and TIDs */
-	v9fs_alloc_idpool(&v9ses->fidpool, V9FS_START_FIDS);
-	v9fs_alloc_idpool(&v9ses->tidpool, V9FS_START_TIDS);
+	idr_init(&v9ses->fidpool.pool);
+	init_MUTEX(&v9ses->fidpool.lock);
+	idr_init(&v9ses->tidpool.pool);
+	init_MUTEX(&v9ses->tidpool.lock);
+
 
 	switch (v9ses->proto) {
 	case PROTO_TCP:
@@ -371,9 +387,6 @@ void v9fs_session_close(struct v9fs_sess
 
 	putname(v9ses->name);
 	putname(v9ses->remotename);
-
-	v9fs_free_idpool(&v9ses->fidpool);
-	v9fs_free_idpool(&v9ses->tidpool);
 }
 
 extern int v9fs_error_init(void);
diff --git a/fs/9p/v9fs.h b/fs/9p/v9fs.h
--- a/fs/9p/vfs_super.c
+++ b/fs/9p/vfs_super.c
@@ -35,9 +35,11 @@
 #include <linux/smp_lock.h>
 #include <linux/inet.h>
 #include <linux/pagemap.h>
+#include <linux/seq_file.h>
+#include <linux/mount.h>
+#include <linux/idr.h>
 
 #include "debug.h"
-#include "idpool.h"
 #include "v9fs.h"
 #include "9p.h"
 #include "v9fs_vfs.h"
@@ -184,7 +186,7 @@ static struct super_block *v9fs_get_sb(s
 	root_fid = v9fs_fid_create(root);
 	if (root_fid == NULL) {
 		retval = -ENOMEM;
-		goto release_inode;
+		goto release_dentry;
 	}
 
 	root_fid->fidopen = 0;
@@ -207,18 +209,20 @@ static struct super_block *v9fs_get_sb(s
 
 	if (stat_result < 0) {
 		retval = stat_result;
-		goto release_inode;
+		goto release_dentry;
 	}
 
 	return sb;
 
+      release_dentry:
+	dput(sb->s_root);
+
       release_inode:
 	iput(inode);
 
       put_back_sb:
 	up_write(&sb->s_umount);
 	deactivate_super(sb);
-
 	v9fs_session_close(v9ses);
 
       free_session:
@@ -248,9 +252,42 @@ static void v9fs_kill_super(struct super
 	dprintk(DEBUG_VFS, "exiting kill_super\n");
 }
 
+/**
+ * v9fs_show_options - Show mount options in /proc/mounts
+ * @m: seq_file to write to
+ * @mnt: mount descriptor
+ *
+ */
+
+static int v9fs_show_options(struct seq_file *m, struct vfsmount *mnt)
+{
+	struct v9fs_session_info *v9ses = mnt->mnt_sb->s_fs_info;
+
+	if (v9ses->debug != 0)
+		seq_printf(m, ",debug=%u", v9ses->debug);
+	if (v9ses->port != V9FS_PORT)
+		seq_printf(m, ",port=%u", v9ses->port);
+	if (v9ses->maxdata != 9000)
+		seq_printf(m, ",msize=%u", v9ses->maxdata);
+	if (v9ses->afid != ~0)
+		seq_printf(m, ",afid=%u", v9ses->afid);
+	if (v9ses->proto == PROTO_UNIX)
+		seq_puts(m, ",proto=unix");
+	if (v9ses->extended == 0)
+		seq_puts(m, ",noextend");
+	if (v9ses->nodev == 1)
+		seq_puts(m, ",nodevmap");
+	seq_printf(m, ",name=%s", v9ses->name);
+	seq_printf(m, ",aname=%s", v9ses->remotename);
+	seq_printf(m, ",uid=%u", v9ses->uid);
+	seq_printf(m, ",gid=%u", v9ses->gid);
+	return 0;
+}
+
 static struct super_operations v9fs_super_ops = {
 	.statfs = simple_statfs,
 	.clear_inode = v9fs_clear_inode,
+	.show_options = v9fs_show_options,
 };
 
 struct file_system_type v9fs_fs_type = {
