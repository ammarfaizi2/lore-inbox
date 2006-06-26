Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964964AbWFZJ7W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964964AbWFZJ7W (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 05:59:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964965AbWFZJ7V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 05:59:21 -0400
Received: from mx1.redhat.com ([66.187.233.31]:23435 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964964AbWFZJ7V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 05:59:21 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060625201844.GA58650@muc.de> 
References: <20060625201844.GA58650@muc.de> 
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org, dhowells@redhat.com,
       trond.myklebust@fys.uio.no
Subject: Re: [PATCH] Fix NFS compilation in -git9 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Mon, 26 Jun 2006 10:59:09 +0100
Message-ID: <14188.1151315949@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@muc.de> wrote:

> +#ifndef INTERNAL_H
> +#define INTERNAL_H 1

Is the wrong fix.  "internal.h" should not be included more than once per C
file.  One of the C files has acquired two inclusions of "internal.h",
probably due to a git merge tool error.

I've given Trond the attached patch to fix things up.  Note the change to
nfs2xdr.c.

David

---
[PATCH] NFS: Fix up split of fs/nfs/inode.c

From: David Howells <dhowells@redhat.com>

Fix ups for the splitting of the superblock stuff out of fs/nfs/inode.c,
including:

 (*) Move the callback tcpport module param into callback.c.

 (*) Move the idmap cache timeout module param into idmap.c.

 (*) Changes to internal.h:

     (*) namespace-nfs4.c was renamed to nfs4namespace.c.

     (*) nfs_stat_to_errno() is in nfs2xdr.c, not nfs4xdr.c.

     (*) nfs4xdr.c is contingent on CONFIG_NFS_V4.

     (*) nfs4_path() is only uses if CONFIG_NFS_V4 is set.

 (*) nfs2xdr.c shouldn't include internal.h twice.

Plus also:

 (*) The sec_flavours[] table should really be const.

 (*) A bit seems to have been lost from the changes to nfs_clear_inode().  The
     BUG_ON() was replaced with nfs_wb_all().

     !!! This needs checking by Trond !!!

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 fs/nfs/callback.c |   15 +++++++++++++++
 fs/nfs/idmap.c    |   14 ++++++++++++++
 fs/nfs/inode.c    |    5 +----
 fs/nfs/internal.h |   12 ++++++------
 fs/nfs/nfs2xdr.c  |    2 --
 fs/nfs/super.c    |   40 ++++------------------------------------
 6 files changed, 40 insertions(+), 48 deletions(-)

diff --git a/fs/nfs/callback.c b/fs/nfs/callback.c
index d53f8c6..bef4c10 100644
--- a/fs/nfs/callback.c
+++ b/fs/nfs/callback.c
@@ -37,6 +37,21 @@ static struct svc_program nfs4_callback_
 
 unsigned int nfs_callback_set_tcpport;
 unsigned short nfs_callback_tcpport;
+static const int nfs_set_port_min = 0;
+static const int nfs_set_port_max = 65535;
+
+static int param_set_port(const char *val, struct kernel_param *kp)
+{
+	char *endp;
+	int num = simple_strtol(val, &endp, 0);
+	if (endp == val || *endp || num < nfs_set_port_min || num > nfs_set_port_max)
+		return -EINVAL;
+	*((int *)kp->arg) = num;
+	return 0;
+}
+
+module_param_call(callback_tcpport, param_set_port, param_get_int,
+		 &nfs_callback_set_tcpport, 0644);
 
 /*
  * This is the callback kernel thread.
diff --git a/fs/nfs/idmap.c b/fs/nfs/idmap.c
index b81e7ed..447ae91 100644
--- a/fs/nfs/idmap.c
+++ b/fs/nfs/idmap.c
@@ -57,6 +57,20 @@ #define IDMAP_HASH_SZ          128
 /* Default cache timeout is 10 minutes */
 unsigned int nfs_idmap_cache_timeout = 600 * HZ;
 
+static int param_set_idmap_timeout(const char *val, struct kernel_param *kp)
+{
+	char *endp;
+	int num = simple_strtol(val, &endp, 0);
+	int jif = num * HZ;
+	if (endp == val || *endp || num < 0 || jif < num)
+		return -EINVAL;
+	*((int *)kp->arg) = jif;
+	return 0;
+}
+
+module_param_call(idmap_cache_timeout, param_set_idmap_timeout, param_get_int,
+		 &nfs_idmap_cache_timeout, 0644);
+
 struct idmap_hashent {
 	unsigned long ih_expires;
 	__u32 ih_id;
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 51bc88b..4f074f8 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -80,10 +80,7 @@ void nfs_clear_inode(struct inode *inode
 	struct nfs_inode *nfsi = NFS_I(inode);
 	struct rpc_cred *cred;
 
-	/*
-	 * The following should never happen...
-	 */
-	BUG_ON(nfs_have_writebacks(inode));
+	nfs_wb_all(inode);
 	BUG_ON (!list_empty(&nfsi->open_files));
 	nfs_zap_acl_cache(inode);
 	cred = nfsi->cache_access.cred;
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index bd2815e..6c0b652 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -15,7 +15,7 @@ struct nfs_clone_mount {
 	rpc_authflavor_t authflavor;
 };
 
-/* namespace-nfs4.c */
+/* nfs4namespace.c */
 #ifdef CONFIG_NFS_V4
 extern struct vfsmount *nfs_do_refmount(const struct vfsmount *mnt_parent, struct dentry *dentry);
 #else
@@ -46,6 +46,7 @@ #define nfs_destroy_directcache() do {} 
 #endif
 
 /* nfs2xdr.c */
+extern int nfs_stat_to_errno(int);
 extern struct rpc_procinfo nfs_procedures[];
 extern u32 * nfs_decode_dirent(u32 *, struct nfs_entry *, int);
 
@@ -54,8 +55,9 @@ extern struct rpc_procinfo nfs3_procedur
 extern u32 *nfs3_decode_dirent(u32 *, struct nfs_entry *, int);
 
 /* nfs4xdr.c */
-extern int nfs_stat_to_errno(int);
+#ifdef CONFIG_NFS_V4
 extern u32 *nfs4_decode_dirent(u32 *p, struct nfs_entry *entry, int plus);
+#endif
 
 /* nfs4proc.c */
 #ifdef CONFIG_NFS_V4
@@ -94,15 +96,13 @@ extern char *nfs_path(const char *base, 
 /*
  * Determine the mount path as a string
  */
+#ifdef CONFIG_NFS_V4
 static inline char *
 nfs4_path(const struct dentry *dentry, char *buffer, ssize_t buflen)
 {
-#ifdef CONFIG_NFS_V4
 	return nfs_path(NFS_SB(dentry->d_sb)->mnt_path, dentry, buffer, buflen);
-#else
-	return NULL;
-#endif
 }
+#endif
 
 /*
  * Determine the device name as a string
diff --git a/fs/nfs/nfs2xdr.c b/fs/nfs/nfs2xdr.c
index 3b939e0..67391ee 100644
--- a/fs/nfs/nfs2xdr.c
+++ b/fs/nfs/nfs2xdr.c
@@ -25,8 +25,6 @@ #include <linux/nfs2.h>
 #include <linux/nfs_fs.h>
 #include "internal.h"
 
-#include "internal.h"
-
 #define NFSDBG_FACILITY		NFSDBG_XDR
 /* #define NFS_PARANOIA 1 */
 
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index e8a9bee..1c20ff0 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -187,40 +187,6 @@ static struct super_operations nfs4_sops
 };
 #endif
 
-#ifdef CONFIG_NFS_V4
-static const int nfs_set_port_min = 0;
-static const int nfs_set_port_max = 65535;
-
-static int param_set_port(const char *val, struct kernel_param *kp)
-{
-	char *endp;
-	int num = simple_strtol(val, &endp, 0);
-	if (endp == val || *endp || num < nfs_set_port_min || num > nfs_set_port_max)
-		return -EINVAL;
-	*((int *)kp->arg) = num;
-	return 0;
-}
-
-module_param_call(callback_tcpport, param_set_port, param_get_int,
-		 &nfs_callback_set_tcpport, 0644);
-#endif
-
-#ifdef CONFIG_NFS_V4
-static int param_set_idmap_timeout(const char *val, struct kernel_param *kp)
-{
-	char *endp;
-	int num = simple_strtol(val, &endp, 0);
-	int jif = num * HZ;
-	if (endp == val || *endp || num < 0 || jif < num)
-		return -EINVAL;
-	*((int *)kp->arg) = jif;
-	return 0;
-}
-
-module_param_call(idmap_cache_timeout, param_set_idmap_timeout, param_get_int,
-		 &nfs_idmap_cache_timeout, 0644);
-#endif
-
 /*
  * Register the NFS filesystems
  */
@@ -323,9 +289,12 @@ static int nfs_statfs(struct dentry *den
 
 }
 
+/*
+ * Map the security flavour number to a name
+ */
 static const char *nfs_pseudoflavour_to_name(rpc_authflavor_t flavour)
 {
-	static struct {
+	static const struct {
 		rpc_authflavor_t flavour;
 		const char *str;
 	} sec_flavours[] = {
@@ -1363,7 +1332,6 @@ static int nfs4_get_sb(struct file_syste
 	}
 
 	s = sget(fs_type, nfs4_compare_super, nfs_set_super, server);
-
 	if (IS_ERR(s)) {
 		error = PTR_ERR(s);
 		goto out_free;
