Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964769AbWIAEjm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964769AbWIAEjm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 00:39:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932152AbWIAEjl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 00:39:41 -0400
Received: from cantor.suse.de ([195.135.220.2]:2522 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932112AbWIAEjI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 00:39:08 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Fri, 1 Sep 2006 14:39:00 +1000
Message-Id: <1060901043900.27536@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc: Olaf Kirch <okir@suse.de>
Subject: [PATCH 010 of 19] knfsd: Change nlm_file to use a hlist
References: <20060901141639.27206.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Olaf Kirch <okir@suse.de>

  This changes struct nlm_file and the nlm_files hash table
  to use a hlist instead of the home-grown lists.

  This allows us to remove f_hash which was only used to find the right
  hash chain to delete an entry from.

  It also increases the size of the nlm_files hash table from
  32 to 128.

Signed-off-by: Olaf Kirch <okir@suse.de>
Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./fs/lockd/svcsubs.c          |   42 ++++++++++++++++--------------------------
 ./include/linux/lockd/lockd.h |    3 +--
 2 files changed, 17 insertions(+), 28 deletions(-)

diff .prev/fs/lockd/svcsubs.c ./fs/lockd/svcsubs.c
--- .prev/fs/lockd/svcsubs.c	2006-09-01 10:42:51.000000000 +1000
+++ ./fs/lockd/svcsubs.c	2006-09-01 10:45:16.000000000 +1000
@@ -25,9 +25,9 @@
 /*
  * Global file hash table
  */
-#define FILE_HASH_BITS		5
+#define FILE_HASH_BITS		7
 #define FILE_NRHASH		(1<<FILE_HASH_BITS)
-static struct nlm_file *	nlm_files[FILE_NRHASH];
+static struct hlist_head	nlm_files[FILE_NRHASH];
 static DEFINE_MUTEX(nlm_file_mutex);
 
 #ifdef NFSD_DEBUG
@@ -82,6 +82,7 @@ u32
 nlm_lookup_file(struct svc_rqst *rqstp, struct nlm_file **result,
 					struct nfs_fh *f)
 {
+	struct hlist_node *pos;
 	struct nlm_file	*file;
 	unsigned int	hash;
 	u32		nfserr;
@@ -93,7 +94,7 @@ nlm_lookup_file(struct svc_rqst *rqstp, 
 	/* Lock file table */
 	mutex_lock(&nlm_file_mutex);
 
-	for (file = nlm_files[hash]; file; file = file->f_next)
+	hlist_for_each_entry(file, pos, &nlm_files[hash], f_list)
 		if (!nfs_compare_fh(&file->f_handle, f))
 			goto found;
 
@@ -105,8 +106,8 @@ nlm_lookup_file(struct svc_rqst *rqstp, 
 		goto out_unlock;
 
 	memcpy(&file->f_handle, f, sizeof(struct nfs_fh));
-	file->f_hash = hash;
 	init_MUTEX(&file->f_sema);
+	INIT_HLIST_NODE(&file->f_list);
 	INIT_LIST_HEAD(&file->f_blocks);
 
 	/* Open the file. Note that this must not sleep for too long, else
@@ -120,8 +121,7 @@ nlm_lookup_file(struct svc_rqst *rqstp, 
 		goto out_free;
 	}
 
-	file->f_next = nlm_files[hash];
-	nlm_files[hash] = file;
+	hlist_add_head(&file->f_list, &nlm_files[hash]);
 
 found:
 	dprintk("lockd: found file %p (count %d)\n", file, file->f_count);
@@ -150,22 +150,14 @@ out_free:
 static inline void
 nlm_delete_file(struct nlm_file *file)
 {
-	struct nlm_file	**fp, *f;
-
 	nlm_debug_print_file("closing file", file);
-
-	fp = nlm_files + file->f_hash;
-	while ((f = *fp) != NULL) {
-		if (f == file) {
-			*fp = file->f_next;
-			nlmsvc_ops->fclose(file->f_file);
-			kfree(file);
-			return;
-		}
-		fp = &f->f_next;
+	if (!hlist_unhashed(&file->f_list)) {
+		hlist_del(&file->f_list);
+		nlmsvc_ops->fclose(file->f_file);
+		kfree(file);
+	} else {
+		printk(KERN_WARNING "lockd: attempt to release unknown file!\n");
 	}
-
-	printk(KERN_WARNING "lockd: attempt to release unknown file!\n");
 }
 
 /*
@@ -236,13 +228,13 @@ nlm_inspect_file(struct nlm_host *host, 
 static int
 nlm_traverse_files(struct nlm_host *host, int action)
 {
-	struct nlm_file	*file, **fp;
+	struct hlist_node *pos, *next;
+	struct nlm_file	*file;
 	int i, ret = 0;
 
 	mutex_lock(&nlm_file_mutex);
 	for (i = 0; i < FILE_NRHASH; i++) {
-		fp = nlm_files + i;
-		while ((file = *fp) != NULL) {
+		hlist_for_each_entry_safe(file, pos, next, &nlm_files[i], f_list) {
 			file->f_count++;
 			mutex_unlock(&nlm_file_mutex);
 
@@ -256,11 +248,9 @@ nlm_traverse_files(struct nlm_host *host
 			/* No more references to this file. Let go of it. */
 			if (list_empty(&file->f_blocks) && !file->f_locks
 			 && !file->f_shares && !file->f_count) {
-				*fp = file->f_next;
+				hlist_del(&file->f_list);
 				nlmsvc_ops->fclose(file->f_file);
 				kfree(file);
-			} else {
-				fp = &file->f_next;
 			}
 		}
 	}

diff .prev/include/linux/lockd/lockd.h ./include/linux/lockd/lockd.h
--- .prev/include/linux/lockd/lockd.h	2006-09-01 10:42:51.000000000 +1000
+++ ./include/linux/lockd/lockd.h	2006-09-01 10:45:16.000000000 +1000
@@ -105,7 +105,7 @@ struct nlm_rqst {
  * an NFS client.
  */
 struct nlm_file {
-	struct nlm_file *	f_next;		/* linked list */
+	struct hlist_node	f_list;		/* linked list */
 	struct nfs_fh		f_handle;	/* NFS file handle */
 	struct file *		f_file;		/* VFS file pointer */
 	struct nlm_share *	f_shares;	/* DOS shares */
@@ -113,7 +113,6 @@ struct nlm_file {
 	unsigned int		f_locks;	/* guesstimate # of locks */
 	unsigned int		f_count;	/* reference count */
 	struct semaphore	f_sema;		/* avoid concurrent access */
-	int		       	f_hash;		/* hash of f_handle */
 };
 
 /*
