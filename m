Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264705AbSKOLZT>; Fri, 15 Nov 2002 06:25:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266108AbSKOLZT>; Fri, 15 Nov 2002 06:25:19 -0500
Received: from holomorphy.com ([66.224.33.161]:26318 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S264705AbSKOLZR>;
	Fri, 15 Nov 2002 06:25:17 -0500
Date: Fri, 15 Nov 2002 03:28:36 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: kernel-janitor-discuss@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: privatize various functions in sched.h
Message-ID: <20021115112836.GU23425@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	kernel-janitor-discuss@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <20021115105403.GS22031@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021115105403.GS22031@holomorphy.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 15, 2002 at 02:54:03AM -0800, William Lee Irwin III wrote:
> This removes a bunch of inlines used only in isolated places from sched.h

Hmm, while I'm at it, this applies atop the previous patch:

This removes d_path() from sched.h and uninlines it. No idea why it was
in sched.h in the first place (or why something this large is inlined).

 fs/dcache.c            |   19 +++++++++++++++++++
 include/linux/dcache.h |    1 +
 include/linux/sched.h  |   20 --------------------
 kernel/ksyms.c         |    1 +
 4 files changed, 21 insertions(+), 20 deletions(-)


diff -urpN cleanup-2.5.47-2/fs/dcache.c cleanup-2.5.47-3/fs/dcache.c
--- cleanup-2.5.47-2/fs/dcache.c	2002-11-14 23:42:01.000000000 -0800
+++ cleanup-2.5.47-3/fs/dcache.c	2002-11-15 02:45:02.000000000 -0800
@@ -1191,6 +1191,25 @@ global_root:
 	return retval;
 }
 
+/* write full pathname into buffer and return start of pathname */
+char * d_path(struct dentry *dentry, struct vfsmount *vfsmnt,
+				char *buf, int buflen)
+{
+	char *res;
+	struct vfsmount *rootmnt;
+	struct dentry *root;
+	read_lock(&current->fs->lock);
+	rootmnt = mntget(current->fs->rootmnt);
+	root = dget(current->fs->root);
+	read_unlock(&current->fs->lock);
+	spin_lock(&dcache_lock);
+	res = __d_path(dentry, vfsmnt, root, rootmnt, buf, buflen);
+	spin_unlock(&dcache_lock);
+	dput(root);
+	mntput(rootmnt);
+	return res;
+}
+
 /*
  * NOTE! The user-level library version returns a
  * character pointer. The kernel system call just
diff -urpN cleanup-2.5.47-2/include/linux/dcache.h cleanup-2.5.47-3/include/linux/dcache.h
--- cleanup-2.5.47-2/include/linux/dcache.h	2002-11-14 23:42:02.000000000 -0800
+++ cleanup-2.5.47-3/include/linux/dcache.h	2002-11-15 02:41:37.000000000 -0800
@@ -240,6 +240,7 @@ extern int d_validate(struct dentry *, s
 
 extern char * __d_path(struct dentry *, struct vfsmount *, struct dentry *,
 	struct vfsmount *, char *, int);
+extern char * d_path(struct dentry *, struct vfsmount *, char *, int);
   
 /* Allocation counts.. */
 
diff -urpN cleanup-2.5.47-2/include/linux/sched.h cleanup-2.5.47-3/include/linux/sched.h
--- cleanup-2.5.47-2/include/linux/sched.h	2002-11-15 01:50:53.000000000 -0800
+++ cleanup-2.5.47-3/include/linux/sched.h	2002-11-15 02:42:06.000000000 -0800
@@ -794,26 +794,6 @@ static inline void task_unlock(struct ta
 {
 	spin_unlock(&p->alloc_lock);
 }
-
-/* write full pathname into buffer and return start of pathname */
-static inline char * d_path(struct dentry *dentry, struct vfsmount *vfsmnt,
-				char *buf, int buflen)
-{
-	char *res;
-	struct vfsmount *rootmnt;
-	struct dentry *root;
-	read_lock(&current->fs->lock);
-	rootmnt = mntget(current->fs->rootmnt);
-	root = dget(current->fs->root);
-	read_unlock(&current->fs->lock);
-	spin_lock(&dcache_lock);
-	res = __d_path(dentry, vfsmnt, root, rootmnt, buf, buflen);
-	spin_unlock(&dcache_lock);
-	dput(root);
-	mntput(rootmnt);
-	return res;
-}
-
  
 /**
  * get_task_mm - acquire a reference to the task's mm
diff -urpN cleanup-2.5.47-2/kernel/ksyms.c cleanup-2.5.47-3/kernel/ksyms.c
--- cleanup-2.5.47-2/kernel/ksyms.c	2002-11-14 23:42:02.000000000 -0800
+++ cleanup-2.5.47-3/kernel/ksyms.c	2002-11-15 02:43:58.000000000 -0800
@@ -166,6 +166,7 @@ EXPORT_SYMBOL(d_alloc);
 EXPORT_SYMBOL(d_alloc_anon);
 EXPORT_SYMBOL(d_splice_alias);
 EXPORT_SYMBOL(d_lookup);
+EXPORT_SYMBOL(d_path);
 EXPORT_SYMBOL(__d_path);
 EXPORT_SYMBOL(mark_buffer_dirty);
 EXPORT_SYMBOL(end_buffer_io_sync);
