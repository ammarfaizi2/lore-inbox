Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272273AbTHDWiP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 18:38:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272279AbTHDWiP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 18:38:15 -0400
Received: from fw.osdl.org ([65.172.181.6]:59021 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S272273AbTHDWiM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 18:38:12 -0400
Date: Mon, 4 Aug 2003 15:39:38 -0700
From: Andrew Morton <akpm@osdl.org>
To: jbarnes@sgi.com (Jesse Barnes)
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] make lookup_create non-static
Message-Id: <20030804153938.492cc92c.akpm@osdl.org>
In-Reply-To: <20030804223037.GA2214@sgi.com>
References: <20030804213543.GA1697@sgi.com>
	<20030804144129.3dfe4aac.akpm@osdl.org>
	<20030804214412.GA1788@sgi.com>
	<20030804145723.533e77f7.akpm@osdl.org>
	<20030804223037.GA2214@sgi.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jbarnes@sgi.com (Jesse Barnes) wrote:
>
> Ok, how does this look?

OK.  I grew it a bit:


 fs/intermezzo/vfs.c    |   22 ----------------------
 fs/namei.c             |   11 +++++++++--
 include/linux/dcache.h |    2 ++
 include/linux/fs.h     |    0 
 kernel/ksyms.c         |    1 +
 5 files changed, 12 insertions(+), 24 deletions(-)

diff -puN fs/namei.c~export-lookup_create fs/namei.c
--- 25/fs/namei.c~export-lookup_create	2003-08-04 15:36:39.000000000 -0700
+++ 25-akpm/fs/namei.c	2003-08-04 15:36:39.000000000 -0700
@@ -1375,8 +1375,15 @@ do_link:
 	goto do_last;
 }
 
-/* SMP-safe */
-static struct dentry *lookup_create(struct nameidata *nd, int is_dir)
+/**
+ * lookup_create - lookup a dentry, creating it if it doesn't exist
+ * @nd: nameidata info
+ * @is_dir: directory flag
+ *
+ * Simple function to lookup and return a dentry and create it
+ * if it doesn't exist.  Is SMP-safe.
+ */
+struct dentry *lookup_create(struct nameidata *nd, int is_dir)
 {
 	struct dentry *dentry;
 
diff -puN include/linux/fs.h~export-lookup_create include/linux/fs.h
diff -puN include/linux/dcache.h~export-lookup_create include/linux/dcache.h
--- 25/include/linux/dcache.h~export-lookup_create	2003-08-04 15:38:18.000000000 -0700
+++ 25-akpm/include/linux/dcache.h	2003-08-04 15:38:35.000000000 -0700
@@ -309,6 +309,8 @@ static inline int d_mountpoint(struct de
 }
 
 extern struct vfsmount *lookup_mnt(struct vfsmount *, struct dentry *);
+extern struct dentry *lookup_create(struct nameidata *nd, int is_dir);
+
 #endif /* __KERNEL__ */
 
 #endif	/* __LINUX_DCACHE_H */
diff -puN kernel/ksyms.c~export-lookup_create kernel/ksyms.c
--- 25/kernel/ksyms.c~export-lookup_create	2003-08-04 15:38:40.000000000 -0700
+++ 25-akpm/kernel/ksyms.c	2003-08-04 15:38:52.000000000 -0700
@@ -156,6 +156,7 @@ EXPORT_SYMBOL(inode_init_once);
 EXPORT_SYMBOL(follow_up);
 EXPORT_SYMBOL(follow_down);
 EXPORT_SYMBOL(lookup_mnt);
+EXPORT_SYMBOL(lookup_create);
 EXPORT_SYMBOL(path_lookup);
 EXPORT_SYMBOL(path_walk);
 EXPORT_SYMBOL(path_release);
diff -puN fs/intermezzo/vfs.c~export-lookup_create fs/intermezzo/vfs.c
--- 25/fs/intermezzo/vfs.c~export-lookup_create	2003-08-04 15:38:56.000000000 -0700
+++ 25-akpm/fs/intermezzo/vfs.c	2003-08-04 15:39:02.000000000 -0700
@@ -664,28 +664,6 @@ int presto_do_create(struct presto_file_
         return error;
 }
 
-/* from namei.c */
-static struct dentry *lookup_create(struct nameidata *nd, int is_dir)
-{
-        struct dentry *dentry;
-
-        down(&nd->dentry->d_inode->i_sem);
-        dentry = ERR_PTR(-EEXIST);
-        if (nd->last_type != LAST_NORM)
-                goto fail;
-        dentry = lookup_hash(&nd->last, nd->dentry);
-        if (IS_ERR(dentry))
-                goto fail;
-        if (!is_dir && nd->last.name[nd->last.len] && !dentry->d_inode)
-                goto enoent;
-        return dentry;
-enoent:
-        dput(dentry);
-        dentry = ERR_PTR(-ENOENT);
-fail:
-        return dentry;
-}
-
 int lento_create(const char *name, int mode, struct lento_vfs_context *info)
 {
         int error;

_

