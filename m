Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964850AbWDCFVq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964850AbWDCFVq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 01:21:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964849AbWDCFV0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 01:21:26 -0400
Received: from ns.suse.de ([195.135.220.2]:48053 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964850AbWDCFVI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 01:21:08 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Mon, 3 Apr 2006 15:19:20 +1000
Message-Id: <1060403051920.1905@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 015 of 16] knfsd: nfsd4: limit number of delegations handed out.
References: <20060403151452.1567.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It's very easy for the server to DOS itself by just giving out too many
delegations.

For now we just solve the problem with a dumb hard limit.  Eventually we'll
want a smarter policy.

Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./fs/nfsd/nfs4state.c |   73 ++++++++++++++++++++++++++------------------------
 1 file changed, 39 insertions(+), 34 deletions(-)

diff ./fs/nfsd/nfs4state.c~current~ ./fs/nfsd/nfs4state.c
--- ./fs/nfsd/nfs4state.c~current~	2006-04-03 15:12:16.000000000 +1000
+++ ./fs/nfsd/nfs4state.c	2006-04-03 15:12:17.000000000 +1000
@@ -147,6 +147,41 @@ get_nfs4_file(struct nfs4_file *fi)
 	kref_get(&fi->fi_ref);
 }
 
+int num_delegations = 0;
+/*
+ * Open owner state (share locks)
+ */
+
+/* hash tables for nfs4_stateowner */
+#define OWNER_HASH_BITS              8
+#define OWNER_HASH_SIZE             (1 << OWNER_HASH_BITS)
+#define OWNER_HASH_MASK             (OWNER_HASH_SIZE - 1)
+
+#define ownerid_hashval(id) \
+        ((id) & OWNER_HASH_MASK)
+#define ownerstr_hashval(clientid, ownername) \
+        (((clientid) + opaque_hashval((ownername.data), (ownername.len))) & OWNER_HASH_MASK)
+
+static struct list_head	ownerid_hashtbl[OWNER_HASH_SIZE];
+static struct list_head	ownerstr_hashtbl[OWNER_HASH_SIZE];
+
+/* hash table for nfs4_file */
+#define FILE_HASH_BITS                   8
+#define FILE_HASH_SIZE                  (1 << FILE_HASH_BITS)
+#define FILE_HASH_MASK                  (FILE_HASH_SIZE - 1)
+/* hash table for (open)nfs4_stateid */
+#define STATEID_HASH_BITS              10
+#define STATEID_HASH_SIZE              (1 << STATEID_HASH_BITS)
+#define STATEID_HASH_MASK              (STATEID_HASH_SIZE - 1)
+
+#define file_hashval(x) \
+        hash_ptr(x, FILE_HASH_BITS)
+#define stateid_hashval(owner_id, file_id)  \
+        (((owner_id) + (file_id)) & STATEID_HASH_MASK)
+
+static struct list_head file_hashtbl[FILE_HASH_SIZE];
+static struct list_head stateid_hashtbl[STATEID_HASH_SIZE];
+
 static struct nfs4_delegation *
 alloc_init_deleg(struct nfs4_client *clp, struct nfs4_stateid *stp, struct svc_fh *current_fh, u32 type)
 {
@@ -155,9 +190,12 @@ alloc_init_deleg(struct nfs4_client *clp
 	struct nfs4_callback *cb = &stp->st_stateowner->so_client->cl_callback;
 
 	dprintk("NFSD alloc_init_deleg\n");
+	if (num_delegations > STATEID_HASH_SIZE * 4)
+		return NULL;
 	dp = kmem_cache_alloc(deleg_slab, GFP_KERNEL);
 	if (dp == NULL)
 		return dp;
+	num_delegations++;
 	INIT_LIST_HEAD(&dp->dl_perfile);
 	INIT_LIST_HEAD(&dp->dl_perclnt);
 	INIT_LIST_HEAD(&dp->dl_recall_lru);
@@ -192,6 +230,7 @@ nfs4_put_delegation(struct nfs4_delegati
 		dprintk("NFSD: freeing dp %p\n",dp);
 		put_nfs4_file(dp->dl_file);
 		kmem_cache_free(deleg_slab, dp);
+		num_delegations--;
 	}
 }
 
@@ -943,40 +982,6 @@ out:
 	return status;
 }
 
-/* 
- * Open owner state (share locks)
- */
-
-/* hash tables for nfs4_stateowner */
-#define OWNER_HASH_BITS              8
-#define OWNER_HASH_SIZE             (1 << OWNER_HASH_BITS)
-#define OWNER_HASH_MASK             (OWNER_HASH_SIZE - 1)
-
-#define ownerid_hashval(id) \
-        ((id) & OWNER_HASH_MASK)
-#define ownerstr_hashval(clientid, ownername) \
-        (((clientid) + opaque_hashval((ownername.data), (ownername.len))) & OWNER_HASH_MASK)
-
-static struct list_head	ownerid_hashtbl[OWNER_HASH_SIZE];
-static struct list_head	ownerstr_hashtbl[OWNER_HASH_SIZE];
-
-/* hash table for nfs4_file */
-#define FILE_HASH_BITS                   8
-#define FILE_HASH_SIZE                  (1 << FILE_HASH_BITS)
-#define FILE_HASH_MASK                  (FILE_HASH_SIZE - 1)
-/* hash table for (open)nfs4_stateid */
-#define STATEID_HASH_BITS              10
-#define STATEID_HASH_SIZE              (1 << STATEID_HASH_BITS)
-#define STATEID_HASH_MASK              (STATEID_HASH_SIZE - 1)
-
-#define file_hashval(x) \
-        hash_ptr(x, FILE_HASH_BITS)
-#define stateid_hashval(owner_id, file_id)  \
-        (((owner_id) + (file_id)) & STATEID_HASH_MASK)
-
-static struct list_head file_hashtbl[FILE_HASH_SIZE];
-static struct list_head stateid_hashtbl[STATEID_HASH_SIZE];
-
 /* OPEN Share state helper functions */
 static inline struct nfs4_file *
 alloc_init_file(struct inode *ino)
