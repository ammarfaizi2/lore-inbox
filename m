Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262021AbUJYP6T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262021AbUJYP6T (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 11:58:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262020AbUJYP6R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 11:58:17 -0400
Received: from brmea-mail-4.Sun.COM ([192.18.98.36]:6047 "EHLO
	brmea-mail-4.sun.com") by vger.kernel.org with ESMTP
	id S261979AbUJYPhn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 11:37:43 -0400
Date: Mon, 25 Oct 2004 11:37:26 -0400
From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: [PATCH 28/28] AUTOFSNG: New autofs filesystem (resend)
In-reply-to: <1098715932358@sun.com>
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc: raven@themaw.net
Message-id: <417D1DB6.8080603@sun.com>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_h6rM5KnL217WIN5TDUxTmw)"
X-Accept-Language: en-us, en
User-Agent: Mozilla Thunderbird 0.8 (X11/20040918)
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
References: <1098715902968@sun.com> <1098715932358@sun.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Boundary_(ID_h6rM5KnL217WIN5TDUxTmw)
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 7BIT

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Enigmail
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBfR22dQs4kOxk3/MRAp3oAJ47d7sziVXF160UzQ4HBzLh3upjcACeNMaE
JUeekjsmZaQsGt/yZgGh2c8=
=WqbX
-----END PGP SIGNATURE-----

--Boundary_(ID_h6rM5KnL217WIN5TDUxTmw)
Content-type: text/x-patch; name=28-autofsng_support.diff
Content-transfer-encoding: 7BIT
Content-disposition: inline; filename=28-autofsng_support.diff

This patch introduces a new fs implementation for the 'autofs' filesystem.
If compiled as a module, the module is called 'autofsng'. NOTE: It may prove
a better idea to simply change the name of the fs to 'autofsng' as well, so
as to not be confused with the two other autofs implementations already in
the kernel.

Please see:
ftp://ftp-eng.cobalt.com/pub/whitepapers/autofs/towards_a_modern_autofs.txt
for a description of how it works.

Signed-off-by: Mike Waychison <michael.waychison@sun.com>
---

 Kconfig              |   26 ++
 Makefile             |    1 
 autofsng/Makefile    |    3 
 autofsng/autofs.h    |   93 +++++++
 autofsng/cachetree.c |  206 ++++++++++++++++
 autofsng/direct.c    |   76 ++++++
 autofsng/indirect.c  |  482 ++++++++++++++++++++++++++++++++++++++
 autofsng/init.c      |   53 ++++
 autofsng/mapcache.c  |  638 +++++++++++++++++++++++++++++++++++++++++++++++++++
 autofsng/request.c   |  295 +++++++++++++++++++++++
 autofsng/super.c     |  234 ++++++++++++++++++
 11 files changed, 2107 insertions(+)

Index: linux-2.6.9-quilt/fs/autofsng/Makefile
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.9-quilt/fs/autofsng/Makefile	2004-10-22 17:17:48.981017896 -0400
@@ -0,0 +1,3 @@
+obj-$(CONFIG_AUTOFSNG_FS) += autofsng.o
+
+autofsng-objs := super.o init.o direct.o request.o indirect.o mapcache.o cachetree.o
Index: linux-2.6.9-quilt/fs/autofsng/init.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.9-quilt/fs/autofsng/init.c	2004-10-22 17:17:48.981017896 -0400
@@ -0,0 +1,53 @@
+/* -*- linux-c -*- --------------------------------------------------------- *
+ *
+ * linux/fs/autofs/init.c
+ *
+ *  Copyright 1997-1998 Transmeta Corporation -- All Rights Reserved
+ *  Copyright 2004 Sun Microsystems Inc. -- All Rights Reserved
+ *
+ * This file is part of the Linux kernel and is made available under
+ * the terms of the GNU General Public License, version 2, or at your
+ * option, any later version, incorporated herein by reference.
+ *
+ * ------------------------------------------------------------------------- */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include "autofs.h"
+
+static struct super_block *autofs_get_sb(struct file_system_type *fs_type,
+	int flags, const char *dev_name, void *data)
+{
+	return get_sb_nodev(fs_type, flags, data, autofs_fill_super);
+}
+
+static struct file_system_type autofsng_fs_type = {
+	.owner		= THIS_MODULE,
+	.name		= "autofs",
+	.get_sb		= autofs_get_sb,
+	.kill_sb	= kill_anon_super,
+};
+
+static int __init init_autofs_fs(void)
+{
+	int ret;
+        ret = register_filesystem(&autofsng_fs_type);
+	if (ret)
+		return ret;
+	ret = mapcache_setup();
+	if (ret) {
+		unregister_filesystem(&autofsng_fs_type);
+		return ret;
+	}
+	return 0;
+}
+                                                                                
+static void __exit exit_autofs_fs(void)
+{
+        unregister_filesystem(&autofsng_fs_type);
+	mapcache_shutdown();
+}
+                                                                                
+module_init(init_autofs_fs)
+module_exit(exit_autofs_fs)
+MODULE_LICENSE("GPL");
Index: linux-2.6.9-quilt/fs/autofsng/direct.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.9-quilt/fs/autofsng/direct.c	2004-10-22 17:17:48.982017744 -0400
@@ -0,0 +1,76 @@
+#include <linux/sched.h>
+#include "autofs.h"
+
+static int autofs_direct_follow_link(struct dentry *dentry, struct nameidata *nd) 
+{
+	/* hold references to ourself for the fall-back case */
+	struct autofs_sb_info *sbi = autofs_sbi(dentry->d_sb);
+	int ret;
+
+	dprintk("direct_follow_link\n");
+	dprintk("\tdentry=%08x, nd->dentry=%08x, nd->mnt=%08x\n",
+			(unsigned)dentry, (unsigned)nd->dentry,
+			(unsigned)nd->mnt);
+
+	/* Set the nd up to point to the current directory, ->mnt is setup by
+	 * the VFS layer. */
+	dput(nd->dentry);
+	nd->dentry = dget(dentry);
+	ret = request_mount(nd, nd->mnt->mnt_devname, sbi->mapkey, 
+			sbi->mapoffset, sbi->mapoptions);
+
+	if (ret) {
+		dprintk("request_mount returned %d\n", ret);
+		/* fail */
+		path_release(nd);
+		return -EPERM;
+	}
+
+	/* Direct mounts act like procfs style magic symlinks to namei.  This is
+	 * critical for the open path when follow_link is hit. */
+	nd->last_type = LAST_BIND;
+
+	return 0;
+}
+
+static struct dentry *autofs_direct_lookup(struct inode *dir, struct dentry
+*dentry, struct nameidata *nd)
+{
+	return ERR_PTR(-ENOENT);
+}
+
+/* If readdir is ever called, it's cause we didn't get an overlayed mount */
+static int autofs_direct_readdir(struct file *filp, void *dirent, filldir_t filldir) {
+        off_t nr;
+                                                                                
+        nr = filp->f_pos;
+                                                                                
+        dprintk("autofs(%x): readdir called on a direct mount. (pid=%d)\n", (unsigned)autofs_sbi(filp->f_vfsmnt->mnt_sb), current->pid);
+                                                                                
+        switch(nr)
+        {
+        case 0:
+                if (filldir(dirent, ".", 1, nr, AUTOFSNG_ROOT_INO, DT_DIR) < 0)
+                        return 0;
+                filp->f_pos = ++nr;
+                /* fall through */
+        case 1:
+                if (filldir(dirent, "..", 2, nr, AUTOFSNG_ROOT_INO, DT_DIR) < 0)
+                        return 0;
+                filp->f_pos = ++nr;
+                /* fall through */
+        }
+        return 0;
+}
+
+
+/* Direct mounts work using follow_link magic.  Nevertheless, we are supposed to
+ * look like a directory, hence the dummy .lookup. */
+struct inode_operations autofs_direct_root_inode_operations = {
+	.follow_link		= autofs_direct_follow_link,
+	.lookup			= autofs_direct_lookup,
+};
+
+struct file_operations autofs_direct_root_operations = {
+	.readdir		= autofs_direct_readdir,
+};
Index: linux-2.6.9-quilt/fs/autofsng/autofs.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.9-quilt/fs/autofsng/autofs.h	2004-10-22 17:17:48.982017744 -0400
@@ -0,0 +1,93 @@
+#include <linux/fs.h>
+#include <linux/namei.h>
+#include <linux/mount.h>
+#include <linux/rbtree.h>
+
+#if 0
+#define DEBUG 1
+#endif
+
+#define AUTOFSNG_SUPER_MAGIC 0x7d92b1a0
+#define AUTOFSNG_ROOT_INO 1
+#define AGENT_PATH "/sbin/autofs"
+
+
+struct autofs_sb_info {
+	int flags;
+	char *mapkey;
+	char *mapoffset;
+	char *mapoptions;  /* Stores string data passed back to the agent */
+	struct mapcache *mapcache;
+};
+
+struct mapcache_entry {
+	atomic_t count;
+	unsigned hash;
+	char name[0];                     /* name of directory */
+};
+
+struct mapcache_treenode {
+	struct rb_node node;
+	struct mapcache_entry *entry;
+};
+
+struct mapcache_tree {
+	atomic_t count;
+	unsigned nentries;
+	struct rb_root root;
+};
+
+#define autofs_sbi(sb) ((struct autofs_sb_info *)(sb->s_fs_info))
+
+#define AUTOFSNG_FDIRECT	0x01
+#define AUTOFSNG_BROWSE		0x02
+
+extern struct super_operations autofs_sops;
+extern struct inode_operations autofs_direct_root_inode_operations;
+extern struct file_operations autofs_direct_root_operations;
+extern struct inode_operations autofs_indirect_root_inode_operations;
+extern struct file_operations autofs_indirect_root_operations;
+extern struct inode_operations autofs_indirect_dir_inode_operations;
+extern struct file_operations autofs_indirect_dir_operations;
+extern struct dentry_operations autofs_indirect_dir_d_operations;
+
+int parse_options(char *options, struct autofs_sb_info *sbi);
+int autofs_fill_super(struct super_block *s, void *data, int silent);
+int request_mount(struct nameidata *mounton, const char *map, const char *key, const char *offset, const char *options);
+
+
+/* setup and teardown a mapcache for a given super_block */
+int mapcache_init(struct super_block *s);
+void mapcache_destroy(struct super_block *s);
+
+/* the following are used to work with snapshots of the tree */
+struct mapcache_tree *get_snapshot(struct super_block *s, const char *mapname);
+void put_snapshot(struct mapcache_tree *tree);
+struct mapcache_treenode *snapshot_first(struct mapcache_tree *tree);
+struct mapcache_treenode *snapshot_next(struct mapcache_treenode *node);
+int snapshot_exists(struct mapcache_tree *tree, const char *name);
+
+/* Setup and teardown the entire mapcache system */
+int mapcache_setup(void);
+void mapcache_shutdown(void);
+
+/* used internally by the cache system */
+struct mapcache_tree *new_tree(void);
+void put_tree(struct mapcache_tree *tree);
+struct mapcache_tree *get_tree(struct mapcache_tree *tree);
+
+struct mapcache_entry *new_entry(const char *name, unsigned hash, 
+		struct mapcache_tree *oldtree);
+struct mapcache_entry *find_entry(struct mapcache_tree *tree, const char *name,
+		unsigned hash);
+void put_entry(struct mapcache_entry *entry);
+int add_entry_to_tree(struct mapcache_entry *entry, struct mapcache_tree *tree);
+unsigned entry_hash(const char *name);
+
+void dump_tree(struct mapcache_tree *tree);
+
+#ifdef DEBUG
+#define dprintk(format, args...) printk(format, ##args)
+#else
+#define dprintk(format, args...) (void)(0)
+#endif
Index: linux-2.6.9-quilt/fs/Makefile
===================================================================
--- linux-2.6.9-quilt.orig/fs/Makefile	2004-10-22 17:17:40.736271288 -0400
+++ linux-2.6.9-quilt/fs/Makefile	2004-10-22 17:17:48.983017592 -0400
@@ -84,6 +84,7 @@ obj-$(CONFIG_ROMFS_FS)		+= romfs/
 obj-$(CONFIG_QNX4FS_FS)		+= qnx4/
 obj-$(CONFIG_AUTOFS_FS)		+= autofs/
 obj-$(CONFIG_AUTOFS4_FS)	+= autofs4/
+obj-$(CONFIG_AUTOFSNG_FS)	+= autofsng/
 obj-$(CONFIG_ADFS_FS)		+= adfs/
 obj-$(CONFIG_UDF_FS)		+= udf/
 obj-$(CONFIG_SUN_OPENPROMFS)	+= openpromfs/
Index: linux-2.6.9-quilt/fs/autofsng/super.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.9-quilt/fs/autofsng/super.c	2004-10-22 17:17:48.983017592 -0400
@@ -0,0 +1,234 @@
+#include <linux/parser.h>
+#include "autofs.h"
+
+enum {	
+	Opt_err, 
+	Opt_mapkey, Opt_mapoffset, 
+	Opt_direct, Opt_indirect,
+	Opt_browse, Opt_nobrowse,
+	Opt_opt,
+};
+
+static match_table_t autofs_tokens = {
+	{Opt_mapkey, "mapkey=%s"},
+	{Opt_mapoffset, "mapoffset=%s"},
+	{Opt_direct, "direct"},
+	{Opt_indirect, "indirect"},
+	{Opt_browse, "browse"},
+	{Opt_nobrowse, "nobrowse"},
+	{Opt_opt, "opt=%s"},		/* Used for option passing */
+	{Opt_err, NULL},
+};
+
+int autofs_fill_super(struct super_block *s, void *data, int silent)
+{
+        struct inode * root_inode;
+        struct dentry * root;
+        struct autofs_sb_info *sbi;
+	int err;
+                                                                                
+	err = -ENOMEM;
+        sbi = kmalloc(sizeof(*sbi), GFP_KERNEL);
+        if ( !sbi )
+                goto fail_unlock;
+        dprintk("autofs: starting up, sbi = %p\n",sbi);
+
+	memset(sbi, 0, sizeof(*sbi));
+
+        err = -EINVAL;
+        if ( parse_options(data, sbi) ) {
+                printk("autofs: called with bogus options\n");
+                goto fail_free;
+        }
+                                                                       
+        s->s_fs_info = sbi;
+	err = mapcache_init(s);
+	if (err)
+		goto fail_parse;
+
+	err = -ENOMEM;
+        s->s_blocksize = 1024;
+        s->s_blocksize_bits = 10;
+        s->s_magic = AUTOFSNG_SUPER_MAGIC;
+        s->s_op = &autofs_sops;
+        root_inode = iget(s, AUTOFSNG_ROOT_INO);
+	if (!root_inode)
+		goto fail_mapcache;
+        root = d_alloc_root(root_inode);
+        if (!root)
+                goto fail_iput;
+                                                                                
+	/*
+         * Success! Install the root dentry now to indicate completion.
+         */
+        s->s_root = root;
+
+	return 0;
+
+fail_iput:
+        printk("autofs: get root dentry failed\n");
+        iput(root_inode);
+fail_mapcache:
+	mapcache_destroy(s);
+fail_parse:
+	kfree(sbi->mapkey);
+	kfree(sbi->mapoffset);
+	kfree(sbi->mapoptions);
+fail_free:
+        kfree(sbi);
+fail_unlock:
+        return err;
+}
+
+static void autofs_read_root_inode(struct inode *inode)
+{
+	struct autofs_sb_info *sbi = autofs_sbi(inode->i_sb);
+	if (sbi->flags & AUTOFSNG_FDIRECT) {
+		inode->i_op = &autofs_direct_root_inode_operations;
+		inode->i_fop = &autofs_direct_root_operations;
+	} else {
+		inode->i_op = &autofs_indirect_root_inode_operations;
+		inode->i_fop = &autofs_indirect_root_operations;
+	}
+}
+
+static void autofs_read_dir_inode(struct inode *inode)
+{
+	struct autofs_sb_info *sbi = autofs_sbi(inode->i_sb);
+	if (sbi->flags & AUTOFSNG_FDIRECT) {
+		printk("autofs_read_dir_inode called in a direct mount!");
+		return;
+	}
+
+	inode->i_op = &autofs_indirect_dir_inode_operations;
+	inode->i_fop = &autofs_indirect_dir_operations;
+}
+
+static void autofs_read_inode(struct inode *inode)
+{
+	ino_t ino = inode->i_ino;
+	
+	/* for the moment, assume all other inodes are directories.. */
+	inode->i_op = &simple_dir_inode_operations;
+	inode->i_fop = &simple_dir_operations;
+	inode->i_mode = S_IFDIR | S_IRUGO | S_IXUGO;
+	inode->i_nlink = 2; /* TODO: empty dirs ? */
+	inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME;
+	inode->i_blocks = 0;
+	inode->i_blksize = 1024;
+
+	if (ino == AUTOFSNG_ROOT_INO) {
+		autofs_read_root_inode(inode);
+	} else {
+		autofs_read_dir_inode(inode);
+	}
+}
+
+int parse_options(char *options, struct autofs_sb_info *sbi)
+{
+	substring_t args[MAX_OPT_ARGS];
+	char *p;
+
+	if (!options)
+		return 0;
+
+	while ((p = strsep(&options, ",")) != NULL) {
+		int token;
+		if (!*p)
+			continue;
+
+		token = match_token(p, autofs_tokens, args);
+		switch(token) {
+		case Opt_direct:
+			sbi->flags |= AUTOFSNG_FDIRECT;
+			break;
+		case Opt_indirect:
+			sbi->flags &= ~AUTOFSNG_FDIRECT;
+			break;
+		case Opt_browse:
+			sbi->flags |= AUTOFSNG_BROWSE;
+			break;
+		case Opt_nobrowse:
+			sbi->flags &= ~AUTOFSNG_BROWSE;
+			break;
+		case Opt_mapkey:
+			if (sbi->mapkey) {
+				printk("autofs: mapkey specified twice\n");
+				goto cleanup;
+			}
+			sbi->mapkey = match_strdup(&args[0]);
+			if (!sbi->mapkey)
+				goto nomem;
+			break;
+		case Opt_mapoffset:
+			if (sbi->mapoffset) {
+				printk("autofs: mapoffset specified twice\n");
+				goto cleanup;
+			}
+			sbi->mapoffset = match_strdup(&args[0]);
+			if (!sbi->mapoffset)
+				goto nomem;
+			break;
+		case Opt_opt:
+			if (sbi->mapoptions) {
+				printk("autofs: opt specified twice\n");
+				goto cleanup;
+			}
+			sbi->mapoptions = match_strdup(&args[0]);
+			if (!sbi->mapoptions)
+				goto nomem;
+			break;
+		default:
+			return 1;
+		}
+	}
+
+	/* check that the options make sense */
+	if (sbi->flags & AUTOFSNG_FDIRECT) {
+		if (!sbi->mapkey) {
+			printk("autofs: mapkey option required for "
+					"direct mounts\n");
+			goto cleanup;
+		}
+		if (!sbi->mapoffset) {
+			printk("autofs: mapoffset option required for "
+					"direct mounts\n");
+			goto cleanup;
+		}
+	} else {
+		if (sbi->mapkey || sbi->mapoffset) {
+			printk("autofs: indirect mounts do not accept the "
+					"mapkey and mapoffset options\n");
+			goto cleanup;
+		}
+	}
+	
+	return 0;
+nomem:
+	printk("autofs: couldn't allocate memory while parsing "
+			"mount options\n");
+cleanup:
+	kfree(sbi->mapkey);
+	kfree(sbi->mapoffset);
+	kfree(sbi->mapoptions);
+	sbi->mapkey    = NULL;
+	sbi->mapoffset = NULL;
+	sbi->mapoptions = NULL;
+	return 1;
+}
+
+static void autofs_put_super(struct super_block *sb)
+{
+	struct autofs_sb_info *sbi = autofs_sbi(sb);
+	mapcache_destroy(sb);
+	kfree(sbi->mapkey);
+	kfree(sbi->mapoffset);
+	kfree(sbi->mapoptions);
+	kfree(sbi);
+}
+
+struct super_operations autofs_sops = {
+	.read_inode	= autofs_read_inode,
+	.put_super	= autofs_put_super,
+	.statfs		= simple_statfs,
+};
Index: linux-2.6.9-quilt/fs/autofsng/request.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.9-quilt/fs/autofsng/request.c	2004-10-22 17:17:48.984017440 -0400
@@ -0,0 +1,295 @@
+#include <linux/sched.h>
+#include <asm/atomic.h>
+#include <linux/list.h>
+#include <linux/kmod.h>
+#include <linux/file.h>
+#include <linux/namespace.h>
+#include <linux/smp_lock.h>
+#include "autofs.h"
+
+struct req {
+	struct list_head list;
+	atomic_t count;
+	struct vfsmount *mnt;
+	struct dentry *dentry;
+	struct completion done;
+	struct file *file;
+	struct namespace *namespace;
+	const char *map;
+	const char *key;
+	const char *offset;
+	const char *options;
+	char buf[];
+};
+#define BUFSIZE (PAGE_SIZE - sizeof(struct req))
+
+static LIST_HEAD(req_list);
+static spinlock_t req_lock = SPIN_LOCK_UNLOCKED;
+
+static struct req *alloc_req(struct vfsmount *mnt, struct dentry *dentry)
+{
+	struct req *req;
+
+	req = (void *)get_zeroed_page(GFP_KERNEL);
+	if (!req)
+		return NULL;
+
+	memset(req, 0, sizeof(*req));
+	INIT_LIST_HEAD(&req->list);
+	atomic_set(&req->count, 2);
+	req->mnt = mntget(mnt);
+	req->dentry = dget(dentry);
+	init_completion(&req->done);
+
+	return req;
+}
+
+static void free_req(struct req *req)
+{
+	dput(req->dentry);
+	mntput(req->mnt);
+	free_page((unsigned long)req);
+}
+
+static void complete_req(struct req *req)
+{
+	spin_lock(&req_lock);
+	list_del_init(&req->list);
+	spin_unlock(&req_lock);
+	atomic_dec(&req->count);
+	complete_all(&req->done);
+}
+
+static void release_req(struct req *req)
+{
+	if (atomic_dec_and_test(&req->count))
+		free_req(req);
+}
+
+static struct req *find_req(struct vfsmount *mnt, struct dentry *dentry)
+{
+	struct req *p;
+
+	list_for_each_entry(p, &req_list, list)
+		if (p->mnt == mnt && p->dentry == dentry)
+			return p;
+	return NULL;
+}
+
+/* TODO: fix locking */
+static int try_to_follow(struct nameidata *nd)
+{
+	int following;
+	struct dentry *d;
+	int rv;
+	int didsomething = 0;
+
+	do {
+		following = 0;
+		while(d_mountpoint(nd->dentry) && follow_down(&nd->mnt, &nd->dentry))
+			following = 1;
+		if (!following)
+			break;
+		didsomething = 1;
+		following = 0;
+		d = nd->dentry;
+		while (d->d_inode->i_op && d->d_inode->i_op->follow_link) {
+			dprintk("autofs: followed a link on ->mnt=%d, ->dentry=%d\n", (unsigned)nd->mnt, (unsigned)nd->dentry);
+			down(&d->d_inode->i_sem);
+			rv = d->d_inode->i_op->follow_link(d, nd);
+			up(&d->d_inode->i_sem);
+			dput(d);
+			if (rv) {
+				path_release(nd);
+				return rv;
+			}
+			/*
+			 * XXX: We should never see a link path in nd.  This is
+			 * because we assume that we are following into a
+			 * mounted filesystem, whose root is a directory.  The
+			 * only people who do this (us and procfs) use symlink
+			 * magic anyway.
+			 */
+			BUG_ON(nd_get_link(nd) != NULL);
+
+			d = nd->dentry;
+			following = 1;
+		}
+	} while (following);
+
+	if (!didsomething) {
+		path_release(nd);
+		return -ENOENT;
+	}
+
+	return 0;
+}
+
+static int wait_for_request(struct req *req, struct nameidata *nd)
+{
+	wait_for_completion(&req->done);
+	/* once complete, we assume the mount is already moved onto the
+	 * follow_link dentry */
+	return try_to_follow(nd);
+}
+
+#define do_envp(index, name, value) \
+	count = snprintf(p, left, (name), (value)); 		\
+	if (count < 0)						\
+		return -ENOMEM;					\
+	envp[(index)] = p;					\
+	p += count + 1;						\
+	left -= count + 1;
+
+static int issue_request_usermode_cb(void *_req)
+{
+	struct req *req = _req;
+	int fd;
+	char *argv[] = { AGENT_PATH, "lookup", NULL };
+	char *envp[8];
+	char *p = req->buf;
+	int count;
+	int left = BUFSIZE - 1;
+	int ret;
+	struct nameidata rootnd;
+
+	p[BUFSIZE-1] = '\0';
+
+	/* handle file magic */
+	fd = get_unused_fd();
+	if (fd < 0)
+		return -ENOMEM;
+	dprintk("installing fd at %d\n", fd);
+	dprintk("req->file is %08x\n", (unsigned)req->file);
+	get_file(req->file);
+	fd_install(fd, req->file);
+	dprintk("after fd_install\n");
+
+	/* pivot namespace ! */
+	put_namespace(current->namespace);
+	get_namespace(req->namespace);
+	current->namespace = req->namespace;
+
+	dprintk("after pivot namespace\n");
+
+	/* 
+	 * pivot root !
+	 * We first have to try_to_follow because the namespace root is most
+	 * likely a rootfs 
+	 */
+	memset(&rootnd, 0, sizeof(rootnd));
+	rootnd.dentry = dget(req->namespace->root->mnt_root);
+	rootnd.mnt  = mntget(req->namespace->root);
+	ret = try_to_follow(&rootnd);
+	if (ret) 
+		return -EBUSY;
+
+	lock_kernel();
+	set_fs_root(current->fs, rootnd.mnt, rootnd.dentry);
+	/*set_fs_altroot(); TODO*/
+	set_fs_pwd(current->fs, rootnd.mnt, rootnd.dentry);
+	unlock_kernel();
+
+	path_release(&rootnd);
+
+	dprintk("after pivot root\n");
+
+	do_envp(0, "MAPNAME=%s", req->map);
+	do_envp(1, "MAPKEY=%s", req->key);
+	do_envp(2, "MAPOFFSET=%s", req->offset);
+	do_envp(3, "MOUNTFD=%d", fd);
+	do_envp(4, "MAPOPTIONS=%s", req->options ? req->options : "");
+	envp[5] = "HOME=/";
+	envp[6] = "PATH=/sbin:/bin:/usr/sbin:/usr/bin";
+	envp[7] = NULL;
+
+	dprintk("after building env\n");
+	
+	dprintk("ABOUT TO EXECUTE\n");
+
+	ret = call_usermodehelper_execve(AGENT_PATH, argv, envp);
+	dprintk("execve returned %d\n", ret);
+	return ret;
+}
+
+static int issue_request(struct req *req, struct nameidata *nd)
+{
+	int ret;
+	struct nameidata follownd;
+	dprintk("in issue_request\n");
+
+	req->file = dentry_open(dget(req->dentry), mntget(req->mnt), O_DIRECTORY | O_RDONLY);
+	if (IS_ERR(req->file)) {
+		printk("dentry_open failed (%ld)\n", PTR_ERR(req->file));
+		return PTR_ERR(req->file);
+	}
+
+	req->namespace = current->namespace;
+	get_namespace(req->namespace);
+
+	dprintk("ABOUT TO CALL_USERMODEHELPER_CB\n");
+	ret = call_usermodehelper_cb(issue_request_usermode_cb, req, 1);
+	if (ret) {
+		printk("call_usermodehelper_cb errored out with returned %d\n", ret);
+		/* fallthrough and try anyway */
+	}
+
+	/* cool beans.  The fs should be mounted on nd->mnt/req->dentry now */
+	/* TODO: this is a mess, do we *need* follownd? */
+	memset(&follownd, 0, sizeof(follownd));
+	follownd.dentry = dget(req->dentry);
+	follownd.mnt  = mntget(nd->mnt);
+	ret = try_to_follow(&follownd);
+	if (ret) {
+		/* oops.  that didn't work :( */
+		dprintk("autofs agent ran, but no mount found\n");
+	} else {
+		/* Switch up the mount we have */
+		path_release(nd);
+		/* move the references in follownd over to nd */
+		nd->mnt = follownd.mnt;
+		nd->dentry = follownd.dentry;
+	}
+
+/* out: */
+	put_namespace(req->namespace);
+	fput(req->file);
+
+	complete_req(req);
+	return ret;
+}
+
+int request_mount(struct nameidata *mounton, const char *map, const char *key, const char *offset, const char *options)
+{
+	struct req *req, *newreq;
+	int err;
+
+	newreq = alloc_req(mounton->mnt, mounton->dentry);
+	if (!newreq)
+		return -ENOMEM;
+
+	newreq->map     = map;
+	newreq->key     = key;
+	newreq->offset  = offset;
+	newreq->options = options;
+
+	spin_lock(&req_lock);
+	req = find_req(mounton->mnt, mounton->dentry);
+	if (req) {
+		/* this request already exists */
+		atomic_inc(&req->count);
+		spin_unlock(&req_lock);
+		release_req(newreq);
+		dprintk("GOING TO WAIT on %p\n", req);
+		err = wait_for_request(req, mounton);
+		release_req(req);
+		return err;
+	}
+	/* add this req to the global list */
+	list_add(&newreq->list, &req_list);
+	spin_unlock(&req_lock);
+	dprintk("ISSUING %p\n", newreq);
+	err = issue_request(newreq, mounton);
+	release_req(newreq);
+	return err;
+}
Index: linux-2.6.9-quilt/fs/Kconfig
===================================================================
--- linux-2.6.9-quilt.orig/fs/Kconfig	2004-08-14 01:37:14.000000000 -0400
+++ linux-2.6.9-quilt/fs/Kconfig	2004-10-22 17:17:48.985017288 -0400
@@ -481,6 +481,32 @@ config AUTOFS4_FS
 	  local network, you probably do not need an automounter, and can say
 	  N here.
 
+config AUTOFSNG_FS
+	tristate "Kernel automounter next-gen support"
+	depends on EXPERIMENTAL
+	help
+	  The automounter is a tool to automatically mount remote file systems
+	  on demand. This implementation is partially kernel-based to reduce
+	  overhead in the already-mounted case;  this is unlike the BSD
+	  automounter (amd), which is a pure user space daemon.
+
+	  Unlike the previous kernel-based automounter solutions, this 'NG'
+	  version does not use a persistent daemon.  Instead, the kernel calls
+	  out to a userspace application much like how the hotplug system works.
+	  This allows the implementation to work well with namespaces and
+	  simplifies the complexity involved.
+
+	  To use the automounter you need the user-space tools from <TODO>; you
+	  also want to answer Y to "NFS file system support".
+
+	  To compile this support as a module, choose M here: the module will be
+	  called autofsng.  You will need to add "alias autofs autofsng" to your
+	  modules configuration file.
+
+	  If you are not a part of a fairly large, distributed network or don't
+	  have a laptop which needs to dynamically reconfiger to the local
+	  network, you probably do not need an automounter, and can say N here.
+
 menu "CD-ROM/DVD Filesystems"
 
 config ISO9660_FS
Index: linux-2.6.9-quilt/fs/autofsng/indirect.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.9-quilt/fs/autofsng/indirect.c	2004-10-22 17:17:48.986017136 -0400
@@ -0,0 +1,482 @@
+#include <linux/sched.h>
+#include "autofs.h"
+
+enum cursor_type {
+	CURSOR_DCACHE,
+	CURSOR_MAPCACHE,
+};
+struct cursor_data {
+	struct dentry *dcursor;
+	struct mapcache_treenode *cpointer;
+	struct mapcache_tree *snapshot;
+	enum cursor_type type;
+};
+
+/* 
+ * return 0 to invalidate
+ * return 1 to validate something is mounted, or we found it in the mapcache
+ */
+static int autofs_indirect_dir_revalidate(struct dentry *dentry, 
+		struct nameidata *nd)
+{
+	struct autofs_sb_info *sbi = autofs_sbi(dentry->d_sb);
+	struct nameidata testnd;
+	int found;
+	int err;
+
+	if (nd == NULL) {
+		/* this came from a lookup_hash for a file creation */
+		return 0;
+	}
+
+	/* is something mounted on us? */
+	testnd.dentry = dget(dentry);
+	testnd.mnt    = mntget(nd->mnt);
+	/* TODO: check locking */
+	found = follow_down(&testnd.mnt, &testnd.dentry);
+	path_release(&testnd);
+
+	if (found)
+		return 1;
+
+	/* 
+	 * If we are browsing, then this entry is fine if it's in the cache.
+	 * If it's not in the cache when we are browsing, we have to try and 
+	 * mount. 
+	 */
+	if (sbi->flags & AUTOFSNG_BROWSE) {
+		struct mapcache_tree *snapshot;
+
+		/* is it in the cache? */
+		snapshot = get_snapshot(dentry->d_sb, nd->mnt->mnt_devname);
+		found = snapshot_exists(snapshot, dentry->d_name.name);	
+		put_snapshot(snapshot);
+
+		if (found)
+			return 1;
+
+		/* 
+		 * we have to try and get something mounted on us.  
+		 * fall through to the nobrowse case.
+		 */
+	}
+
+	/* nobrowse case */
+	testnd.dentry = dget(dentry);
+	testnd.mnt    = mntget(nd->mnt);
+	err = request_mount(&testnd, testnd.mnt->mnt_devname, 
+			dentry->d_name.name, dentry->d_name.name,
+			sbi->mapoptions);
+	path_release(&testnd);
+
+	if (err == 0)
+		return 1;
+	return 0;
+}
+
+/* 
+ * Indirect mounts work as follows:  
+ *   - Create a follow_link directory trap for any ->lookup.
+ *   - We blindly allow all lookups to succeed, as any real work is handled in
+ *     revalidate portion.
+ *   - On root dir readdir, we only show the children that are mounted upon.
+ */
+
+static struct dentry *autofs_indirect_lookup(struct inode *dir, struct dentry
+		*dentry, struct nameidata *nd)
+{
+	struct inode *inode;
+	int ret;
+	ino_t ino;
+
+	/* if nd is null, then this lookup is looking for a negative dentry
+	 * (from lookup_hash). */
+	if (nd == NULL)
+		return ERR_PTR(-EPERM);
+
+	ino = iunique(dir->i_sb, AUTOFSNG_ROOT_INO);
+	inode = iget(dir->i_sb, ino);
+	if (!inode)
+		return ERR_PTR(-EACCES);
+	dentry->d_op = &autofs_indirect_dir_d_operations;
+
+	/*
+	 * Mark the dentry incomplete, but add it. This is needed so
+	 * that the VFS layer knows about the dentry, and we can count
+	 * on catching any lookups through the revalidate.
+	 *
+	 * Let all the hard work be done by the revalidate function that
+	 * needs to be able to do this anyway..
+	 *
+	 * We need to do this before we release the directory semaphore.
+	 */
+
+	d_add(dentry, inode);
+
+	up(&dir->i_sem);
+	ret = autofs_indirect_dir_revalidate(dentry, nd);
+	down(&dir->i_sem);
+
+	if (ret == 0) {
+		struct nameidata testnd;
+		/* 
+		 * need to check again if something is mounted there.  we may
+		 * have raced with a revalidate while waiting for the dir->i_sem
+		 */
+		testnd.dentry = dget(dentry);
+		testnd.mnt    = mntget(nd->mnt);
+		/* TODO: check locking */	 
+		ret = follow_down(&testnd.mnt, &testnd.dentry);
+		path_release(&testnd);
+
+		if (ret == 0) {
+			/* nope, nothing there, we can safely drop the dentry */
+			d_drop(dentry);
+			return ERR_PTR(-ENOENT);
+		}
+	}
+
+	return NULL;
+}
+
+static struct dentry *autofs_indirect_dir_lookup(struct inode *dir, 
+		struct dentry *dentry, struct nameidata *nd)
+{
+	return ERR_PTR(-ENOENT);
+}
+
+/* If readdir is ever called, it's cause we didn't get an overlayed mount */
+static int autofs_indirect_dir_readdir(struct file *filp, void *dirent, filldir_t filldir) {
+        off_t nr;
+                                                                                
+        nr = filp->f_pos;
+                                                                                
+        dprintk("autofs(%x): readdir called on a indirect mount. (pid=%d)\n", (unsigned)autofs_sbi(filp->f_vfsmnt->mnt_sb), current->pid);
+                                                                                
+        switch(nr)
+        {
+        case 0:
+                if (filldir(dirent, ".", 1, nr, AUTOFSNG_ROOT_INO, DT_DIR) < 0)
+                        return 0;
+                filp->f_pos = ++nr;
+                /* fall through */
+        case 1:
+                if (filldir(dirent, "..", 2, nr, AUTOFSNG_ROOT_INO, DT_DIR) < 0)
+                        return 0;
+                filp->f_pos = ++nr;
+                /* fall through */
+        }
+        return 0;
+}
+
+static int autofs_indirect_dir_follow_link(struct dentry *dentry, 
+		struct nameidata *nd)
+{
+	struct autofs_sb_info *sbi = autofs_sbi(dentry->d_sb);
+
+	/* hold references to ourself for the fall-back case */
+	struct dentry *mydentry = dget(dentry);
+	struct vfsmount *mymnt  = mntget(nd->mnt);
+	int ret;
+
+	dprintk("indirect_follow_link\n");
+	dprintk("\tdentry=%08x, nd->dentry=%08x, nd->mnt=%08x\n",
+			(unsigned)dentry, (unsigned)nd->dentry,
+			(unsigned)nd->mnt);
+
+	/* Set the nd up to point to the current directory, ->mnt is setup by
+	 * the VFS layer. */
+	dput(nd->dentry);
+	nd->dentry = dget(dentry);
+	ret = request_mount(nd, nd->mnt->mnt_devname, dentry->d_name.name,
+			dentry->d_name.name, sbi->mapoptions);
+
+	if (ret == -ENOENT) {
+		/* 
+		 * We didn't succeed in mounting anything. Our real return value
+		 * depends on whether we are in the cache or not.
+		 */
+		if (sbi->flags & AUTOFSNG_BROWSE) {
+			struct mapcache_tree *snapshot;
+			snapshot = get_snapshot(dentry->d_sb,
+					nd->mnt->mnt_devname);
+			if (snapshot_exists(snapshot, dentry->d_name.name)) {
+				ret = -EPERM;
+			} else {
+				/* we shouldn't be listing this node */
+				d_drop(dentry);
+			}
+		} else {
+			d_drop(dentry);
+		}
+		path_release(nd);
+	} else if (ret != 0) {
+		/* Any other error */
+		dprintk("request_mount returned %d\n", ret);
+		/* 
+		 * Browsing was disabled.  Don't show directories with nothing
+		 * mounted on them. 
+		 */
+		d_drop(dentry);
+		path_release(nd);
+	} else if (ret == 0) {
+		/* We succeeded in mounting somthing.  We set LAST_BIND as the
+		 * open path requires it */
+		nd->last_type = LAST_BIND;
+	}
+	dput(mydentry);
+	mntput(mymnt);
+	dprintk("out of follow_link: nd->mnt: %d nd->dentry: %d\n",
+			atomic_read(&nd->mnt->mnt_count),
+			atomic_read(&nd->dentry->d_count));
+	return ret;
+}
+
+/* The following directory ops for the root dentry are copied from libfs,
+ * however we also check to make sure that subdirs are mounted upon when doing
+ * the readdir */
+static int autofs_indirect_root_open(struct inode *inode, struct file *file)
+{
+	static struct qstr cursor_name = {.len = 1, .name = "."};
+	struct autofs_sb_info *sbi = autofs_sbi(inode->i_sb);
+	struct cursor_data *cd;
+	int err;
+
+	err = -ENOMEM;
+	cd = kmalloc(sizeof (*cd), GFP_KERNEL);
+	if (!cd)
+		goto out;
+	cd->dcursor = d_alloc(file->f_dentry, &cursor_name);
+	if (!cd->dcursor)
+		goto out_kfree;
+	if (sbi->flags & AUTOFSNG_BROWSE) {
+		cd->snapshot = get_snapshot(inode->i_sb,
+				file->f_vfsmnt->mnt_devname);
+		if (!cd->snapshot)
+			goto out_dput;
+	}
+	cd->cpointer = NULL;
+	cd->type = CURSOR_DCACHE;
+
+	file->private_data = cd;
+
+	return 0;
+out_dput:
+	dput(cd->dcursor);
+out_kfree:
+	kfree(cd);
+out:
+	return err;
+}
+
+static int autofs_indirect_root_close(struct inode *inode, struct file *file)
+{
+	struct cursor_data *cd = file->private_data;
+	struct autofs_sb_info *sbi = autofs_sbi(inode->i_sb);
+
+	if (sbi->flags & AUTOFSNG_BROWSE)
+		put_snapshot(cd->snapshot);
+	dput(cd->dcursor);
+	return 0;
+}
+
+static loff_t autofs_indirect_root_lseek(struct file *file, loff_t offset, 
+		int origin)
+{
+	struct autofs_sb_info *sbi = autofs_sbi(file->f_dentry->d_sb);
+	struct cursor_data *cd = file->private_data;
+
+	down(&file->f_dentry->d_inode->i_sem);
+	switch (origin) {
+		case 1:
+			offset += file->f_pos;
+		case 0:
+			if (offset >= 0)
+				break;
+		default:
+			up(&file->f_dentry->d_inode->i_sem);
+			return -EINVAL;
+	}
+	if (offset != file->f_pos) {
+		file->f_pos = offset;
+		cd->type = CURSOR_DCACHE;
+		if (file->f_pos >= 2) {
+			struct list_head *p;
+			struct dentry *cursor = cd->dcursor;
+			int hiteol = 0;
+			loff_t n = file->f_pos - 2;
+
+			spin_lock(&dcache_lock);
+			list_del(&cursor->d_child);
+			p = file->f_dentry->d_subdirs.next;
+			while (n && p != &file->f_dentry->d_subdirs) {
+				struct dentry *next;
+				next = list_entry(p, struct dentry, d_child);
+				if (!d_unhashed(next) && next->d_inode)
+					n--;
+				p = p->next;
+			}
+			list_add_tail(&cursor->d_child, p);
+			cd->cpointer = NULL;
+			if (cursor->d_child.next == &file->f_dentry->d_subdirs)
+				hiteol = 1;
+			spin_unlock(&dcache_lock);
+			
+			/* now walk into cache if required */
+			if (sbi->flags & AUTOFSNG_BROWSE && hiteol) {
+				struct mapcache_treenode *node;
+
+				cd->type = CURSOR_MAPCACHE;
+				node = snapshot_first(cd->snapshot);
+				while (n && node) {
+					n--;
+					node = snapshot_next(node);
+				}
+				cd->cpointer = node;
+			}
+		}
+	}
+	up(&file->f_dentry->d_inode->i_sem);
+
+	return offset;
+}
+
+struct inode_operations autofs_indirect_root_inode_operations = {
+	.lookup			= autofs_indirect_lookup,
+};
+
+/* Relationship between i_mode and the DT_xxx types */
+static inline unsigned char dt_type(struct inode *inode)
+{
+	return (inode->i_mode >> 12) & 15;
+}
+
+/*
+ * Directory is locked and all positive dentries in it are safe, since
+ * for ramfs-type trees they can't go away without unlink() or rmdir(),
+ * both impossible due to the lock on directory.
+ */
+
+static int autofs_indirect_root_readdir(struct file * filp, void * dirent, 
+		filldir_t filldir)
+{
+	struct dentry *dentry = filp->f_dentry;
+	struct cursor_data *cd = filp->private_data;
+	struct dentry *cursor = cd->dcursor;
+	struct list_head *p, *q = &cursor->d_child;
+	struct autofs_sb_info *sbi = autofs_sbi(filp->f_dentry->d_sb);
+	ino_t ino;
+	int i = filp->f_pos;
+
+	switch (i) {
+		case 0:
+			ino = dentry->d_inode->i_ino;
+			if (filldir(dirent, ".", 1, i, ino, DT_DIR) < 0)
+				break;
+			filp->f_pos++;
+			i++;
+			/* fallthrough */
+		case 1:
+			ino = parent_ino(dentry);
+			if (filldir(dirent, "..", 2, i, ino, DT_DIR) < 0)
+				break;
+			filp->f_pos++;
+			i++;
+			/* fallthrough */
+	}
+	if (cd->type == CURSOR_DCACHE) {
+		spin_lock(&dcache_lock);
+		if (filp->f_pos == 2) {
+			list_del(q);
+			list_add(q, &dentry->d_subdirs);
+		}
+		for (p=q->next; p != &dentry->d_subdirs; p=p->next) {
+			struct dentry *next;
+			struct nameidata nd;
+			int followed = 0;
+	
+			next = list_entry(p, struct dentry, d_child);
+			if (d_unhashed(next) || !next->d_inode)
+				continue;
+	
+			if (!atomic_read(&next->d_count))
+				continue;
+
+			/* is this node from the cache, if so we don't 
+			 * display it */
+			if (sbi->flags & AUTOFSNG_BROWSE
+			    && snapshot_exists(cd->snapshot, next->d_name.name))
+				continue;
+	
+			/* is this node mounted upon? */
+			memset(&nd, 0, sizeof (nd));
+			nd.mnt    = mntget(filp->f_vfsmnt);
+			nd.dentry = dget(next);
+			spin_unlock(&dcache_lock);
+			
+			/* TODO: fix locking */
+			if (d_mountpoint(nd.dentry) 
+				&& follow_down(&nd.mnt, &nd.dentry))
+				followed = 1;
+			dput(nd.dentry);
+			_mntput(nd.mnt);
+			if (!followed) {
+				spin_lock(&dcache_lock);
+				continue;
+			}
+	
+			if (filldir(dirent, next->d_name.name, next->d_name.len, filp->f_pos, next->d_inode->i_ino, dt_type(next->d_inode)) < 0)
+				return 0;
+			spin_lock(&dcache_lock);
+			/* next is still alive */
+			list_del(q);
+			list_add(q, p);
+			p = q;
+			filp->f_pos++;
+		}
+		spin_unlock(&dcache_lock);
+		/* did we just finish the dcache entries? */
+		if (sbi->flags & AUTOFSNG_BROWSE) {
+			cd->type = CURSOR_MAPCACHE;
+			cd->cpointer = snapshot_first(cd->snapshot);
+		}
+	}
+
+	if (cd->type == CURSOR_MAPCACHE) {
+		while (cd->cpointer) {
+			struct mapcache_entry *entry = cd->cpointer->entry;
+			int ret;
+
+			ret = filldir(dirent, entry->name, strlen(entry->name),
+						filp->f_pos, 1, DT_DIR);
+			if (ret < 0)
+				return 0;
+			cd->cpointer = snapshot_next(cd->cpointer);
+			filp->f_pos++;
+		}
+	}
+
+	update_atime(dentry->d_inode);
+	return 0;
+}
+
+struct file_operations autofs_indirect_root_operations = {
+	.open			= autofs_indirect_root_open,
+	.release		= autofs_indirect_root_close,
+	.llseek			= autofs_indirect_root_lseek,
+	.read			= generic_read_dir,
+	.readdir		= autofs_indirect_root_readdir,
+};
+
+struct inode_operations autofs_indirect_dir_inode_operations = {
+	.follow_link		= autofs_indirect_dir_follow_link,
+	.lookup			= autofs_indirect_dir_lookup,
+};
+
+struct file_operations autofs_indirect_dir_operations = {
+	.readdir		= autofs_indirect_dir_readdir,
+};
+
+struct dentry_operations autofs_indirect_dir_d_operations = {
+	.d_revalidate		= autofs_indirect_dir_revalidate,
+};
Index: linux-2.6.9-quilt/fs/autofsng/mapcache.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.9-quilt/fs/autofsng/mapcache.c	2004-10-22 17:17:48.987016984 -0400
@@ -0,0 +1,638 @@
+#include <linux/pagemap.h>
+#include <linux/completion.h>
+#include <linux/jiffies.h>
+#include <linux/init.h>
+#include <linux/file.h>
+#include <linux/module.h>
+#include "autofs.h"
+
+#define TIMEOUT (10 * 60 * HZ)
+
+#define MAPCACHE_MAGIC 0x328d20a2
+
+#define BUFFSIZE PAGE_SIZE
+
+/*
+ * Mapcaches use a global rbtree for lookups (mapcache_rbtree) and are
+ * singly linked for iteration, which is headed by a mapcache_entry_list.
+ * 
+ * Each super_block will have a single mapcache, which in turn has an rbtree
+ * protected by a rwlock.
+ */
+
+/* used for blocking tasks while the rbtree is being updated */
+struct mapcache_update {
+	atomic_t count;
+	struct completion done;
+};
+
+enum mapcache_state {
+	MC_REFRESH,
+	MC_UPDATING,
+	MC_OK,
+};
+
+struct mapcache {
+	enum mapcache_state state;
+	unsigned long lastupdate;         /* time of last update */    
+	struct mapcache_tree *tree;       /* the current tree */
+	struct mapcache_tree *oldtree;    /* reference to old tree */
+	unsigned hits;			  /* count of hits when updating */
+	spinlock_t lock;                  /* protects the state */
+	struct mapcache_update *update;   /* refreshing task sets this
+					     while others wait for refresh */
+};
+
+/* 
+ * Entries in the buffer may only be up to a page long.  If an entry longer than
+ * this is seen, we log an error and silently continue reading it until the next
+ * entry is found.  If we see an entry with illegal char's (/), we also complain
+ * and silently continue reading.
+ */
+struct mapcache_file_buffer {
+	char *buffer;
+	int skip;			/* skip input (entry is invalid) */
+	int pos;			/* end of unflushed buffer data */
+	struct semaphore sem;
+	struct mapcache *mapcache;
+};
+
+static struct vfsmount *mapcache_mnt;
+static void mapcache_read_inode(struct inode *inode);
+static struct super_operations mapcache_fs_ops = {
+	.read_inode = mapcache_read_inode,
+	.statfs     = simple_statfs,
+};
+
+static struct super_block *mapcache_get_sb(struct file_system_type *fs_type,
+	int flags, const char *dev_name, void *data)
+{
+	return get_sb_pseudo(fs_type, "autofsng_mapcache:", &mapcache_fs_ops,
+			MAPCACHE_MAGIC);
+}
+
+static struct file_system_type mapcache_fs_type = {
+	.name    = "mapcachefs",
+	.get_sb  = mapcache_get_sb,
+	.kill_sb = kill_anon_super,
+};
+
+static struct mapcache_file_buffer *
+new_mapcache_file_buffer(struct mapcache *mapcache)
+{
+	struct mapcache_file_buffer *buffer;
+
+	buffer = kmalloc(sizeof(*buffer), GFP_KERNEL);
+	if (!buffer)
+		return NULL;
+	
+	buffer->buffer = (void *)get_zeroed_page(GFP_KERNEL);
+	if (!buffer->buffer) {
+		kfree(buffer);
+		return NULL;
+	}
+
+	init_MUTEX(&buffer->sem);
+	buffer->mapcache = mapcache;
+	buffer->skip = 0;
+	buffer->pos  = 0;
+	return buffer;
+}
+
+static void free_mapcache_file_buffer(struct mapcache_file_buffer *buffer)
+{
+	free_page((unsigned long)buffer->buffer);
+	kfree(buffer);
+}
+
+static int mapcache_file_release(struct inode *inode, struct file *file)
+{
+	struct mapcache_file_buffer *buffer = file->private_data;
+	free_mapcache_file_buffer(buffer);
+	return 0;
+}
+
+static int handle_newline(struct mapcache_file_buffer *buffer)
+{
+	struct mapcache_entry *entry;
+	unsigned hash;
+	int ret;
+
+	/* skip over the null string */
+	if (!buffer->buffer[0])
+		return 0;
+
+	hash = entry_hash(buffer->buffer);
+	entry = new_entry(buffer->buffer, hash, buffer->mapcache->oldtree);
+	if (!entry)
+		return -ENOMEM;
+
+	ret = add_entry_to_tree(entry, buffer->mapcache->tree);
+	if (ret == 0) {
+		/* unique entry added successfully */
+		/* if the entry count is > 1, then we had a hit */
+		if (atomic_read(&entry->count) > 1)
+			buffer->mapcache->hits++;
+	} else if (ret == 1) {
+		/* was a duplicate */
+		ret = 0;
+	} else if (ret < 0) {
+		/* ran out of memory */
+		put_entry(entry);
+	} else 
+		BUG();
+	return ret;
+}
+
+/* 
+ * Fill in the buffer for later reading.  We fill up to the end of the buffer,
+ * at which point we stop.  While flushing, if we see that the entry is larger
+ * than the entire buffer, we mark ->skip and continue blindly slurping in the
+ * text 
+ */
+static ssize_t mapcache_fill_write_buffer(struct mapcache_file_buffer *buffer,
+		const char __user *buf, ssize_t count)
+{
+	int error;
+
+	/* if we are skipping data, we don't care if the buffer is full */
+	if (buffer->skip)
+		buffer->pos = 0;
+
+	if (count + buffer->pos >= BUFFSIZE)
+		count = BUFFSIZE - buffer->pos;
+	error = copy_from_user(&buffer->buffer[buffer->pos], buf, count);
+	return error ? -EFAULT : count;
+}
+
+/* 
+ * Read from ->pos on trying to find the end of the entry.  If we hit the end of
+ * the buffer, we 'skip' the rest of the entry.
+ *
+ * Return the position of the last char we successfully read, or 0 otherwise.
+ */
+static ssize_t mapcache_flush_write_buffer(struct mapcache_file_buffer *buffer,
+		ssize_t new)
+{
+	char *p = &buffer->buffer[buffer->pos];
+	ssize_t charsleft = new;
+
+	while (charsleft--) {
+		/* Is this a delimiter? */
+		if (*p == '\n') {
+			int ret;
+			if (buffer->skip) {
+				/* we were looking for this.. */
+				buffer->skip = 0;
+			} else {
+				/* TODO: do something with this: */
+				*p = '\0';
+				ret = handle_newline(buffer);
+				/* propagate errors back out */
+				if (ret)
+					return ret;
+			}
+			ret = p - &buffer->buffer[buffer->pos] + 1;
+			buffer->pos = 0;
+			return ret;
+		}
+
+		/* illegal char? */
+		if (*p == '/' || *p == '*' || *p == '\0') {
+			buffer->skip = 1;
+		}
+
+		/* Is this the last char in the buffer? */
+		if (p == &buffer->buffer[BUFFSIZE -1]) {
+			buffer->skip = 1;
+			buffer->pos = 0;
+			return new;
+		}
+
+		p++;
+	}
+
+	/* didn't find the end of the entry, slurp it up */
+	buffer->pos += new;
+	return new;
+}
+
+static ssize_t mapcache_file_write(struct file *file, const char __user *buf, 
+		size_t count, loff_t *ppos)
+{
+	struct mapcache_file_buffer *buffer = file->private_data;
+	int filled;
+	int flusheduntil;
+	int ret;
+
+	down(&buffer->sem);
+	ret = filled = mapcache_fill_write_buffer(buffer, buf, count);
+	if (ret < 0)
+		goto out;
+	ret = flusheduntil = mapcache_flush_write_buffer(buffer, filled);
+	if (ret < 0)
+		goto out;
+	*ppos += ret;
+out:
+	up(&buffer->sem);
+	return ret;
+}
+
+static struct file_operations mapcache_file_ops = {
+	.owner   = THIS_MODULE,
+	.write   = mapcache_file_write,
+	.release = mapcache_file_release,
+};
+
+static void mapcache_read_inode(struct inode *inode)
+{
+	inode->i_fop = &mapcache_file_ops;
+	inode->i_mode = S_IFREG | S_IRUGO | S_IXUGO;
+	inode->i_nlink = 1;
+	inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME;
+
+	inode->i_blocks = 0;
+	inode->i_blksize = 1024;
+}
+
+static struct dentry *get_mapcache_dentry(void)
+{
+	static struct qstr qstr = {
+		.name = "mapcachefd",
+		.len  = 10,
+	};
+	struct dentry *dentry;
+	struct inode *inode;
+
+	dentry = d_alloc(mapcache_mnt->mnt_root, &qstr);
+	if (IS_ERR(dentry))
+		return dentry;
+
+	inode = iget(mapcache_mnt->mnt_sb, iunique(mapcache_mnt->mnt_sb, 0));
+	if (IS_ERR(inode)) {
+		int err = PTR_ERR(inode);
+		dput(dentry);
+		return ERR_PTR(err);
+	}
+
+	d_add(dentry, inode);
+
+	return dentry;
+}
+
+static long open_mapcache_file(struct mapcache *mapcache)
+{
+	struct file *file;
+	struct mapcache_file_buffer *buffer;
+	int err;
+	long fd;
+
+	/* We grab a ref count to our module which is used by the mapcache fd */
+	__module_get(THIS_MODULE);
+	err = -ENOMEM;
+	file = get_empty_filp();
+	if (!file)
+		goto out;
+
+	err = -ENFILE;
+	fd = get_unused_fd();
+	if (fd < 0)
+		goto out_putfilp;
+	
+	err = -ENOMEM;
+	file->f_vfsmnt = mntget(mapcache_mnt);
+	file->f_dentry = get_mapcache_dentry();
+	if (IS_ERR(file->f_dentry))
+		goto out_mntput;
+
+	buffer = new_mapcache_file_buffer(mapcache);
+	if (!buffer)
+		goto out_dput;
+
+	/* We need to hold this sem to ensure that we are serialized with all
+	 * other readers of the rbtree */
+	file->private_data = buffer;
+	file->f_op    = &mapcache_file_ops;
+	file->f_mode  = FMODE_WRITE;
+	file->f_flags = O_WRONLY;
+	file->f_pos   = 0;
+
+	fd_install(fd, file);
+
+	return fd;
+
+out_dput:
+	dput(file->f_dentry);
+out_mntput:
+	mntput(file->f_vfsmnt);
+out_putfilp:
+	put_filp(file);
+out:
+	module_put(THIS_MODULE);
+	return err;
+
+}
+
+static struct mapcache_update *new_update(void)
+{
+	struct mapcache_update *update;
+
+	update = kmalloc(sizeof(*update), GFP_KERNEL);
+	if (!update)
+		return NULL;
+	atomic_set(&update->count, 1);
+	init_completion(&update->done);
+	return update;
+}
+
+/* called with mapcache->lock held */
+static void start_update(struct mapcache *mapcache, struct mapcache_update
+		*update)
+{
+	BUG_ON(mapcache->update);
+
+	mapcache->update = update;
+}
+
+/* called with mapcache->lock held */
+static void finish_update(struct mapcache *mapcache)
+{
+	struct mapcache_update *update = mapcache->update;
+	BUG_ON(!mapcache->update);
+	mapcache->update = NULL;
+	complete_all(&update->done);
+}
+
+/* called with mapcache->lock held */
+static struct mapcache_update *get_update(struct mapcache *mapcache)
+{
+	BUG_ON(!mapcache->update);
+	atomic_inc(&mapcache->update->count);
+	return mapcache->update;
+}
+
+/* FIXME: what about signals? */
+static void wait_for_update(struct mapcache_update *update)
+{
+	wait_for_completion(&update->done);
+}
+
+static void put_update(struct mapcache_update *update)
+{
+	might_sleep();
+	if (atomic_dec_and_test(&update->count)) {
+		kfree(update);
+	}
+}
+
+int __init mapcache_setup(void)
+{
+	int err;
+	err = register_filesystem(&mapcache_fs_type);
+	if (err)
+		return err;
+	mapcache_mnt = kern_mount(&mapcache_fs_type);
+	if (!mapcache_mnt)
+		return PTR_ERR(mapcache_mnt);
+	return 0;
+}
+
+void __exit mapcache_shutdown(void)
+{
+	mntput(mapcache_mnt);
+	unregister_filesystem(&mapcache_fs_type);
+}
+
+struct mapcache_refresh_info {
+	struct autofs_sb_info *sbi;
+	const char *mapname;
+};
+
+#define do_envp(index, name, value) \
+	count = snprintf(p, left, (name), (value)); 		\
+	if (count < 0)						\
+		return -ENOMEM;					\
+	envp[(index)] = p;					\
+	p += count + 1;						\
+	left -= count + 1;
+static int mapcache_refresh_cb(void *_info)
+{
+	struct mapcache_refresh_info *info = _info;
+	struct autofs_sb_info *sbi = info->sbi;
+	struct mapcache *mapcache = sbi->mapcache;
+	char *argv[] = { AGENT_PATH, "list", NULL };
+	char *envp[5];
+	char buf[100], *p = buf;   /* FIXME: hard limit */
+	int left = 99;
+	int fd;
+	int count = 0;
+
+
+	fd = open_mapcache_file(mapcache);
+	if (fd < 0)
+		return fd;
+
+	/* FIXME: cleanup on failure */
+	do_envp(0, "MAPNAME=%s", info->mapname);
+	do_envp(1, "WRITEFD=%d", fd);
+	envp[2] = "HOME=/";
+	envp[3] = "PATH=/sbin:/bin:/usr/sbin:/usr/bin";
+	envp[4] = NULL;
+	
+	return call_usermodehelper_execve(AGENT_PATH, argv, envp);
+}
+
+/* Try to update the mapcache.  On error, we clear the cache */
+static int mapcache_refresh(struct super_block *s, const char *mapname)
+{
+	struct autofs_sb_info *sbi = autofs_sbi(s);
+	struct mapcache_refresh_info info;
+	int ret;
+
+	info.sbi     = sbi;
+	info.mapname = mapname;
+
+	/* 
+	 * We can safely pass info from our stack because we are waiting 
+	 * for the usermode helper to return. 
+	 */
+	ret = call_usermodehelper_cb(mapcache_refresh_cb, &info, 1);
+	if (ret) {
+		printk("autofs mapcache: call_usermodehelper_cb errored out"
+				" with ret = %d\n", ret);
+	}
+	return ret;
+}
+
+int mapcache_init(struct super_block *s)
+{
+	struct mapcache *mapcache;	
+	struct autofs_sb_info *sbi = autofs_sbi(s);
+
+	mapcache = kmalloc(sizeof(*mapcache), GFP_KERNEL);
+	if (!mapcache)
+		return -ENOMEM;
+
+	mapcache->state = MC_REFRESH;
+	mapcache->tree = NULL;
+	mapcache->oldtree = NULL;
+	mapcache->update = NULL;
+	spin_lock_init(&mapcache->lock);
+
+	sbi->mapcache = mapcache;
+	
+	return 0;
+}
+
+struct mapcache_tree *get_snapshot(struct super_block *s, const char *mapname)
+{
+	struct autofs_sb_info *sbi = autofs_sbi(s);
+	struct mapcache *mapcache = sbi->mapcache;
+	struct mapcache_update *update, *wait_update;
+	struct mapcache_tree *tree;
+	int err;
+
+	update = new_update();
+	if (!update)
+		return NULL;
+
+	spin_lock(&mapcache->lock);
+again:
+	switch (mapcache->state) {
+		case MC_REFRESH:
+			mapcache->state = MC_UPDATING;
+			start_update(mapcache, update);
+			spin_unlock(&mapcache->lock);
+
+			BUG_ON(mapcache->oldtree != NULL);
+
+			/* store a pointer to the old tree */
+			mapcache->oldtree = mapcache->tree;
+			mapcache->tree = new_tree();
+			if (!mapcache->tree) {
+				/* bail out, try again later.. */
+				spin_lock(&mapcache->lock);
+				finish_update(mapcache);
+				mapcache->state = MC_REFRESH;
+				mapcache->tree = mapcache->oldtree;
+				if (mapcache->tree) 
+					get_tree(mapcache->tree);
+				spin_unlock(&mapcache->lock);
+				
+				put_update(update);
+
+				/* for now, log an error and return the old
+				 * tree if possible */
+				return mapcache->tree;
+			}
+
+			mapcache->hits = 0;
+			err = mapcache_refresh(s, mapname);
+			if (err != 0) {
+				/* get rid of the new defunct tree */
+				put_tree(mapcache->tree);
+				spin_lock(&mapcache->lock);
+				/* restore old tree */
+				mapcache->tree  = mapcache->oldtree;
+				mapcache->oldtree = NULL;
+				mapcache->state = MC_REFRESH;
+				if (mapcache->tree) 
+					get_tree(mapcache->tree);
+				finish_update(mapcache);
+				spin_unlock(&mapcache->lock);
+
+				put_update(update);
+
+				/* again, log an error and return the old tree
+				 * if possible */
+				return mapcache->tree;
+			}
+			
+			/* check to see if the trees are identical */
+			if (mapcache->oldtree
+			    && mapcache->oldtree->nentries ==
+				mapcache->tree->nentries
+			    && mapcache->hits == mapcache->tree->nentries) {
+				/* the trees are the same.  no need to update */
+				put_tree(mapcache->tree);
+				mapcache->tree = mapcache->oldtree;
+				mapcache->oldtree = NULL;
+			} else {
+
+				/* 
+				 * free up the old tree we aren't 
+				 * using anymore 
+				 */
+				put_tree(mapcache->oldtree);
+				mapcache->oldtree = NULL;
+			}
+
+			spin_lock(&mapcache->lock);
+
+			finish_update(mapcache);
+			mapcache->lastupdate = jiffies;
+			mapcache->state = MC_OK;
+			/* fall through */
+		case MC_OK:
+			if (time_after(jiffies, mapcache->lastupdate + TIMEOUT)) {
+				mapcache->state = MC_REFRESH;
+				goto again;
+			}
+			tree = get_tree(mapcache->tree);
+			spin_unlock(&mapcache->lock);
+
+			/* we allocated this unconditionally */
+			put_update(update); 
+			return tree;
+		case MC_UPDATING:
+			wait_update = get_update(mapcache);
+			spin_unlock(&mapcache->lock);
+			wait_for_update(wait_update);
+			put_update(wait_update);
+			spin_lock(&mapcache->lock);
+			goto again;
+		default:
+			BUG();
+	}
+	BUG();
+	return NULL;
+}
+
+void put_snapshot(struct mapcache_tree *tree)
+{
+	put_tree(tree);
+}
+
+struct mapcache_treenode *snapshot_first(struct mapcache_tree *tree)
+{
+	struct rb_node *node;
+	node = rb_first(&tree->root);
+	if (!node)
+		return NULL;
+	return rb_entry(node, struct mapcache_treenode, node);
+}
+
+struct mapcache_treenode *snapshot_next(struct mapcache_treenode *node)
+{
+	struct rb_node *nextnode;
+	nextnode = rb_next(&node->node);
+	if (!nextnode)
+		return NULL;
+	return rb_entry(nextnode, struct mapcache_treenode, node);
+}
+
+int snapshot_exists(struct mapcache_tree *tree, const char *name)
+{
+	unsigned hash = entry_hash(name);
+	return find_entry(tree, name, hash) ? 1 : 0;
+}
+
+void mapcache_destroy(struct super_block *s)
+{
+	struct autofs_sb_info *sbi = autofs_sbi(s);
+
+	if (!sbi->mapcache)
+		return;
+	kfree(sbi->mapcache);
+	sbi->mapcache = NULL;
+}
Index: linux-2.6.9-quilt/fs/autofsng/cachetree.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.9-quilt/fs/autofsng/cachetree.c	2004-10-22 17:17:48.988016832 -0400
@@ -0,0 +1,206 @@
+#include "autofs.h"
+
+static int __node_is_left(const char *namea, unsigned hasha, 
+			  const char *nameb, unsigned hashb)
+{
+	if (hasha < hashb)
+		return 1;
+	if (hasha > hashb)
+		return 0;
+	return strcmp(namea, nameb);
+}
+
+static int __node_is_right(const char *namea, unsigned hasha,
+		           const char *nameb, unsigned hashb)
+{
+	return __node_is_left(nameb, hashb, namea, hasha);
+}
+
+static int node_is_left(struct mapcache_treenode *a, 
+		struct mapcache_treenode *b)
+{
+	return __node_is_left(a->entry->name, a->entry->hash, 
+			      b->entry->name, b->entry->hash);
+}
+
+static int node_is_right(struct mapcache_treenode *a,
+		struct mapcache_treenode *b)
+{
+	return node_is_left(b, a);
+}
+
+struct mapcache_entry *find_entry(struct mapcache_tree *tree, const char *name,
+		unsigned hash)
+{
+	struct rb_node *n = tree->root.rb_node;
+	struct mapcache_treenode *node;
+
+	while (n) {
+		node = rb_entry(n, struct mapcache_treenode, node);
+
+		if (__node_is_left(name, hash, node->entry->name,
+					node->entry->hash))
+			n = n->rb_left;
+		else if (__node_is_right(name, hash, node->entry->name,
+					node->entry->hash))
+			n = n->rb_right;
+		else 
+			return node->entry;
+	}
+	return NULL; 
+}
+
+/* Make a new entry given the name and hash value.  Recycle a value from the
+ * oldtree if available (reference required) */
+struct mapcache_entry *new_entry(const char *name, unsigned hash, 
+		struct mapcache_tree *oldtree)
+{
+	struct mapcache_entry *entry;
+	int len = strlen(name) + 1;
+
+	if (oldtree) {
+		entry = find_entry(oldtree, name, hash);
+		if (entry) {
+			atomic_inc(&entry->count);
+			return entry;
+		}
+	}
+
+	entry = kmalloc(sizeof(*entry) + len, GFP_KERNEL);
+	if (entry) {
+		atomic_set(&entry->count, 1);
+		memcpy(entry->name, name, len);
+		entry->hash = hash;
+	}
+	return entry;
+}
+
+void put_entry(struct mapcache_entry *entry)
+{
+	if (atomic_dec_and_test(&entry->count)) {
+		kfree(entry);
+	}
+}
+
+static struct mapcache_treenode *new_node(void)
+{
+	struct mapcache_treenode *node;
+	node = kmalloc(sizeof(*node), GFP_KERNEL);
+	return node;
+}
+
+static void delete_node(struct mapcache_treenode *node)
+{
+	BUG_ON(!node);
+	put_entry(node->entry);
+	kfree(node);
+}
+
+static struct mapcache_treenode *__add_node_to_tree(
+		struct mapcache_treenode *node, struct mapcache_tree *tree)
+{
+	struct rb_node **p = &tree->root.rb_node;
+	struct rb_node *parent = NULL;
+	struct mapcache_treenode *curnode;
+
+	while (*p) {
+		parent = *p;
+		curnode = rb_entry(parent, struct mapcache_treenode, node);
+
+		if (node_is_left(node, curnode)) 
+			p = &(*p)->rb_left;
+		else if (node_is_right(node, curnode))
+			p = &(*p)->rb_right;
+		else 
+			return curnode;
+	}
+
+	rb_link_node(&node->node, parent, p);
+	return NULL;
+}
+
+/* add a node to the tree, free it if it's a dup */
+static int add_node_to_tree(
+		struct mapcache_treenode *node, struct mapcache_tree *tree)
+{
+	if (__add_node_to_tree(node, tree) != 0) {
+		/* oops, found a duplicate */
+		delete_node(node);
+		return 1;
+	}
+	tree->nentries++;
+	rb_insert_color(&node->node, &tree->root);
+	return 0;
+}
+
+/* 
+ * Add the given entry to tree.  Consumes entry reference.
+ * Returns 0 on success.  Returns 1 on duplicate.  -ENOMEM on error.
+ */
+int add_entry_to_tree(struct mapcache_entry *entry, struct mapcache_tree *tree)
+{
+	struct mapcache_treenode *node;
+
+	node = new_node();
+	if (!node)
+		return -ENOMEM;
+
+	node->entry = entry;
+
+	return add_node_to_tree(node, tree);
+}
+
+struct mapcache_tree *new_tree(void)
+{
+	struct mapcache_tree *tree;
+
+	tree = kmalloc(sizeof(*tree), GFP_KERNEL);
+	if (tree) {
+		atomic_set(&tree->count, 1);
+		tree->root = RB_ROOT;
+		tree->nentries = 0;
+	}
+	return tree;
+}
+
+static void release_tree(struct mapcache_tree *tree)
+{
+	struct rb_node **root = &tree->root.rb_node;
+
+	while (*root != NULL) {
+		struct mapcache_treenode *node = rb_entry(*root, 
+				struct mapcache_treenode, node);
+		rb_erase(&node->node, &tree->root);
+		delete_node(node);
+	}
+}
+
+/* release a tree reference */
+void put_tree(struct mapcache_tree *tree)
+{
+	if (!tree)
+		return;
+	if (atomic_dec_and_test(&tree->count)) {
+		release_tree(tree);
+	}
+}
+
+/* grab a tree reference, called with mapcache locked */
+struct mapcache_tree *get_tree(struct mapcache_tree *tree)
+{
+	if (!tree)
+		BUG();
+	atomic_inc(&tree->count);
+	return tree;
+}
+
+unsigned int entry_hash(const char *name)
+{
+	const unsigned int hash_mult = 2654435387U;
+	unsigned int h = 0;
+
+	while (*name)
+		h = (h + (unsigned int) *name++) * hash_mult;
+
+	return h;
+}

--Boundary_(ID_h6rM5KnL217WIN5TDUxTmw)--
