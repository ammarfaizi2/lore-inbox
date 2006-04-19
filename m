Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750759AbWDSRcB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750759AbWDSRcB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 13:32:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750776AbWDSRcA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 13:32:00 -0400
Received: from pat.uio.no ([129.240.10.6]:23440 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1750759AbWDSRb7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 13:31:59 -0400
Subject: [GIT] Bugfixes for 2.6.17-rc2 NFS client
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 19 Apr 2006 13:31:50 -0400
Message-Id: <1145467910.8799.16.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.706, required 12,
	autolearn=disabled, AWL 1.29, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the repository at

   git pull git://git.linux-nfs.org/pub/linux/nfs-2.6.git

This will update the following files through the appended changesets.

  Cheers,
    Trond

----
 fs/lockd/svclock.c                    |    2 +-
 fs/nfs/dir.c                          |    5 ++---
 fs/nfs/direct.c                       |    8 +++-----
 fs/nfs/file.c                         |    5 ++---
 fs/nfs/inode.c                        |    5 +----
 fs/nfs/nfs4proc.c                     |   10 ++++++----
 include/linux/sunrpc/metrics.h        |   12 ++++++++++++
 include/linux/sunrpc/xprt.h           |    1 +
 net/sunrpc/auth_gss/auth_gss.c        |    1 -
 net/sunrpc/auth_gss/gss_krb5_crypto.c |   11 +++--------
 net/sunrpc/stats.c                    |    3 ++-
 11 files changed, 33 insertions(+), 30 deletions(-)

commit a5f9145bc9c340bda743ad51e09bdea60fa3ddfa
Author: Eric Sesterhenn <snakebyte@gmx.de>

    SUNRPC: Dead code in net/sunrpc/auth_gss/auth_gss.c

commit 7451c4f0ee53e36fd74168af8df75b28fd04a2aa
Author: Carsten Otte <cotte@de.ibm.com>

    NFS: remove needless check in nfs_opendir()

commit b9d9506d944865876e67281a4e4269d823ce5381
Author: John Hawkes <hawkes@sgi.com>

    NFS: nfs_show_stats; for_each_possible_cpu(), not NR_CPUS

commit ec535ce154f2eaad3d97f2f20a76a6d8bdac33e5
Author: Adrian Bunk <bunk@stusta.de>

    NFS: make 2 functions static

commit e99170ff3b799a9fd43d538932a9231fac1de9d4
Author: Trond Myklebust <Trond.Myklebust@netapp.com>

    NFS,SUNRPC: Fix compiler warnings if CONFIG_PROC_FS & CONFIG_SYSCTL are unset

commit 7866babad542bb5e1dc95deb5800b577abef58dd
Author: Adrian Bunk <bunk@stusta.de>

    NFS: fix PROC_FS=n compile error

commit 95cf959b245832ad49bb333bf88f9805244b225d
Author: Trond Myklebust <Trond.Myklebust@netapp.com>

    VFS: Fix another open intent Oops

commit d4a30e7e66c004da26dfe5229af7c10fe9853a7a
Author: J. Bruce Fields <bfields@fieldses.org>

    RPCSEC_GSS: fix leak in krb5 code caused by superfluous kmalloc

diff --git a/fs/lockd/svclock.c b/fs/lockd/svclock.c
index d2b66ba..3ef7391 100644
--- a/fs/lockd/svclock.c
+++ b/fs/lockd/svclock.c
@@ -650,7 +650,7 @@ static void nlmsvc_grant_callback(struct
 	svc_wake_up(block->b_daemon);
 }
 
-void nlmsvc_grant_release(void *data)
+static void nlmsvc_grant_release(void *data)
 {
 	struct nlm_rqst		*call = data;
 
diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index a23f348..cae74dd 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -128,15 +128,14 @@ #endif /* CONFIG_NFS_V4 */
 static int
 nfs_opendir(struct inode *inode, struct file *filp)
 {
-	int res = 0;
+	int res;
 
 	dfprintk(VFS, "NFS: opendir(%s/%ld)\n",
 			inode->i_sb->s_id, inode->i_ino);
 
 	lock_kernel();
 	/* Call generic open code in order to cache credentials */
-	if (!res)
-		res = nfs_open(inode, filp);
+	res = nfs_open(inode, filp);
 	unlock_kernel();
 	return res;
 }
diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
index 0f583cb..3c72b0c 100644
--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -112,10 +112,9 @@ static void nfs_direct_write_complete(st
  */
 ssize_t nfs_direct_IO(int rw, struct kiocb *iocb, const struct iovec *iov, loff_t pos, unsigned long nr_segs)
 {
-	struct dentry *dentry = iocb->ki_filp->f_dentry;
-
 	dprintk("NFS: nfs_direct_IO (%s) off/no(%Ld/%lu) EINVAL\n",
-			dentry->d_name.name, (long long) pos, nr_segs);
+			iocb->ki_filp->f_dentry->d_name.name,
+			(long long) pos, nr_segs);
 
 	return -EINVAL;
 }
@@ -468,7 +467,6 @@ static const struct rpc_call_ops nfs_com
 static void nfs_direct_commit_schedule(struct nfs_direct_req *dreq)
 {
 	struct nfs_write_data *data = dreq->commit_data;
-	struct rpc_task *task = &data->task;
 
 	data->inode = dreq->inode;
 	data->cred = dreq->ctx->cred;
@@ -489,7 +487,7 @@ static void nfs_direct_commit_schedule(s
 	/* Note: task.tk_ops->rpc_release will free dreq->commit_data */
 	dreq->commit_data = NULL;
 
-	dprintk("NFS: %5u initiated commit call\n", task->tk_pid);
+	dprintk("NFS: %5u initiated commit call\n", data->task.tk_pid);
 
 	lock_kernel();
 	rpc_execute(&data->task);
diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index f1df2c8..fade02c 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -534,10 +534,9 @@ static int nfs_lock(struct file *filp, i
  */
 static int nfs_flock(struct file *filp, int cmd, struct file_lock *fl)
 {
-	struct inode * inode = filp->f_mapping->host;
-
 	dprintk("NFS: nfs_flock(f=%s/%ld, t=%x, fl=%x)\n",
-			inode->i_sb->s_id, inode->i_ino,
+			filp->f_dentry->d_inode->i_sb->s_id,
+			filp->f_dentry->d_inode->i_ino,
 			fl->fl_type, fl->fl_flags);
 
 	/*
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 2f7656b..d0b991a 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -700,12 +700,9 @@ #endif
 	/*
 	 * Display superblock I/O counters
 	 */
-	for (cpu = 0; cpu < NR_CPUS; cpu++) {
+	for_each_possible_cpu(cpu) {
 		struct nfs_iostats *stats;
 
-		if (!cpu_possible(cpu))
-			continue;
-
 		preempt_disable();
 		stats = per_cpu_ptr(nfss->io_stats, cpu);
 
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 47ece1d..d86c0db 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -1218,7 +1218,7 @@ out:
 	return status;
 }
 
-static void nfs4_intent_set_file(struct nameidata *nd, struct dentry *dentry, struct nfs4_state *state)
+static int nfs4_intent_set_file(struct nameidata *nd, struct dentry *dentry, struct nfs4_state *state)
 {
 	struct file *filp;
 
@@ -1227,8 +1227,10 @@ static void nfs4_intent_set_file(struct 
 		struct nfs_open_context *ctx;
 		ctx = (struct nfs_open_context *)filp->private_data;
 		ctx->state = state;
-	} else
-		nfs4_close_state(state, nd->intent.open.flags);
+		return 0;
+	}
+	nfs4_close_state(state, nd->intent.open.flags);
+	return PTR_ERR(filp);
 }
 
 struct dentry *
@@ -1835,7 +1837,7 @@ nfs4_proc_create(struct inode *dir, stru
 			nfs_setattr_update_inode(state->inode, sattr);
 	}
 	if (status == 0 && nd != NULL && (nd->flags & LOOKUP_OPEN))
-		nfs4_intent_set_file(nd, dentry, state);
+		status = nfs4_intent_set_file(nd, dentry, state);
 	else
 		nfs4_close_state(state, flags);
 out:
diff --git a/include/linux/sunrpc/metrics.h b/include/linux/sunrpc/metrics.h
index 8f96e9d..77f78e5 100644
--- a/include/linux/sunrpc/metrics.h
+++ b/include/linux/sunrpc/metrics.h
@@ -69,9 +69,21 @@ struct rpc_clnt;
 /*
  * EXPORTed functions for managing rpc_iostats structures
  */
+
+#ifdef CONFIG_PROC_FS
+
 struct rpc_iostats *	rpc_alloc_iostats(struct rpc_clnt *);
 void			rpc_count_iostats(struct rpc_task *);
 void			rpc_print_iostats(struct seq_file *, struct rpc_clnt *);
 void			rpc_free_iostats(struct rpc_iostats *);
 
+#else  /*  CONFIG_PROC_FS  */
+
+static inline struct rpc_iostats *rpc_alloc_iostats(struct rpc_clnt *clnt) { return NULL; }
+static inline void rpc_count_iostats(struct rpc_task *task) {}
+static inline void rpc_print_iostats(struct seq_file *seq, struct rpc_clnt *clnt) {}
+static inline void rpc_free_iostats(struct rpc_iostats *stats) {}
+
+#endif  /*  CONFIG_PROC_FS  */
+
 #endif /* _LINUX_SUNRPC_METRICS_H */
diff --git a/include/linux/sunrpc/xprt.h b/include/linux/sunrpc/xprt.h
index 7eebbab..e8bbe81 100644
--- a/include/linux/sunrpc/xprt.h
+++ b/include/linux/sunrpc/xprt.h
@@ -53,6 +53,7 @@ struct rpc_timeout {
 
 struct rpc_task;
 struct rpc_xprt;
+struct seq_file;
 
 /*
  * This describes a complete RPC request
diff --git a/net/sunrpc/auth_gss/auth_gss.c b/net/sunrpc/auth_gss/auth_gss.c
index 900ef31..519ebc1 100644
--- a/net/sunrpc/auth_gss/auth_gss.c
+++ b/net/sunrpc/auth_gss/auth_gss.c
@@ -794,7 +794,6 @@ gss_create_cred(struct rpc_auth *auth, s
 
 out_err:
 	dprintk("RPC:      gss_create_cred failed with error %d\n", err);
-	if (cred) gss_destroy_cred(&cred->gc_base);
 	return ERR_PTR(err);
 }
 
diff --git a/net/sunrpc/auth_gss/gss_krb5_crypto.c b/net/sunrpc/auth_gss/gss_krb5_crypto.c
index 97c981f..76b969e 100644
--- a/net/sunrpc/auth_gss/gss_krb5_crypto.c
+++ b/net/sunrpc/auth_gss/gss_krb5_crypto.c
@@ -212,7 +212,6 @@ make_checksum(s32 cksumtype, char *heade
 	char                            *cksumname;
 	struct crypto_tfm               *tfm = NULL; /* XXX add to ctx? */
 	struct scatterlist              sg[1];
-	u32                             code = GSS_S_FAILURE;
 
 	switch (cksumtype) {
 		case CKSUMTYPE_RSA_MD5:
@@ -221,13 +220,11 @@ make_checksum(s32 cksumtype, char *heade
 		default:
 			dprintk("RPC:      krb5_make_checksum:"
 				" unsupported checksum %d", cksumtype);
-			goto out;
+			return GSS_S_FAILURE;
 	}
 	if (!(tfm = crypto_alloc_tfm(cksumname, CRYPTO_TFM_REQ_MAY_SLEEP)))
-		goto out;
+		return GSS_S_FAILURE;
 	cksum->len = crypto_tfm_alg_digestsize(tfm);
-	if ((cksum->data = kmalloc(cksum->len, GFP_KERNEL)) == NULL)
-		goto out;
 
 	crypto_digest_init(tfm);
 	sg_set_buf(sg, header, hdrlen);
@@ -235,10 +232,8 @@ make_checksum(s32 cksumtype, char *heade
 	process_xdr_buf(body, body_offset, body->len - body_offset,
 			checksummer, tfm);
 	crypto_digest_final(tfm, cksum->data);
-	code = 0;
-out:
 	crypto_free_tfm(tfm);
-	return code;
+	return 0;
 }
 
 EXPORT_SYMBOL(make_checksum);
diff --git a/net/sunrpc/stats.c b/net/sunrpc/stats.c
index dea5296..15c2db2 100644
--- a/net/sunrpc/stats.c
+++ b/net/sunrpc/stats.c
@@ -176,7 +176,8 @@ void rpc_count_iostats(struct rpc_task *
 	op_metrics->om_execute += execute;
 }
 
-void _print_name(struct seq_file *seq, unsigned int op, struct rpc_procinfo *procs)
+static void _print_name(struct seq_file *seq, unsigned int op,
+			struct rpc_procinfo *procs)
 {
 	if (procs[op].p_name)
 		seq_printf(seq, "\t%12s: ", procs[op].p_name);


