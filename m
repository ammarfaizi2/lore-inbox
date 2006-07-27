Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751080AbWG0U6P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751080AbWG0U6P (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 16:58:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751137AbWG0U5Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 16:57:24 -0400
Received: from mx1.redhat.com ([66.187.233.31]:14040 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750996AbWG0Ux6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 16:53:58 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 02/30] NFS: Fix up split of fs/nfs/inode.c [try #11]
Date: Thu, 27 Jul 2006 21:52:27 +0100
To: torvalds@osdl.org, akpm@osdl.org, steved@redhat.com,
       trond.myklebust@fys.uio.no
Cc: linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
       nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org
Message-Id: <20060727205227.8443.77016.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20060727205222.8443.29381.stgit@warthog.cambridge.redhat.com>
References: <20060727205222.8443.29381.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix ups for the splitting of the superblock stuff out of fs/nfs/inode.c,
including:

 (*) Move the callback tcpport module param into callback.c.

 (*) Move the idmap cache timeout module param into idmap.c.

 (*) Changes to internal.h:

     (*) namespace-nfs4.c was renamed to nfs4namespace.c.

     (*) nfs_stat_to_errno() is in nfs2xdr.c, not nfs4xdr.c.

     (*) nfs4xdr.c is contingent on CONFIG_NFS_V4.

     (*) nfs4_path() is only uses if CONFIG_NFS_V4 is set.

Plus also:

 (*) The sec_flavours[] table should really be const.

Signed-Off-By: David Howells <dhowells@redhat.com>
Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>
---

 fs/nfs/callback.c |   15 +++++++++++++++
 fs/nfs/idmap.c    |   14 ++++++++++++++
 fs/nfs/internal.h |   12 ++++++------
 fs/nfs/super.c    |   40 ++++------------------------------------
 4 files changed, 39 insertions(+), 42 deletions(-)

diff --git a/fs/nfs/callback.c b/fs/nfs/callback.c
index fe0a6b8..d6c4bae 100644
--- a/fs/nfs/callback.c
+++ b/fs/nfs/callback.c
@@ -36,6 +36,21 @@ static struct svc_program nfs4_callback_
 
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
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index e4f4e5d..94a7870 100644
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
