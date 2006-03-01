Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751114AbWCAXKz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751114AbWCAXKz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 18:10:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751116AbWCAXKy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 18:10:54 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:26085 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1751114AbWCAXKx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 18:10:53 -0500
Date: Wed, 1 Mar 2006 15:10:34 -0800
From: Mark Fasheh <mark.fasheh@oracle.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org
Subject: [git patches] ocfs2 updates
Message-ID: <20060301231034.GZ20175@ca-server1.us.oracle.com>
Reply-To: Mark Fasheh <mark.fasheh@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Oracle Corporation
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull from 'upstream-linus' branch of
git://oss.oracle.com/home/sourcebo/git/ocfs2.git

to receive the following updates:

 fs/ocfs2/cluster/masklog.c     |    1 
 fs/ocfs2/cluster/masklog.h     |    2 
 fs/ocfs2/cluster/nodemanager.c |    4 -
 fs/ocfs2/cluster/tcp.c         |   14 +++-
 fs/ocfs2/cluster/tcp.h         |    5 -
 fs/ocfs2/dlm/dlmcommon.h       |    8 --
 fs/ocfs2/dlm/dlmdebug.c        |   12 +--
 fs/ocfs2/dlm/dlmdomain.c       |   39 ++++++------
 fs/ocfs2/dlm/dlmmaster.c       |    4 -
 fs/ocfs2/dlm/dlmrecovery.c     |   23 +++----
 fs/ocfs2/extent_map.c          |   38 +++++++++++-
 fs/ocfs2/file.c                |   51 ----------------
 fs/ocfs2/heartbeat.c           |    1 
 fs/ocfs2/inode.c               |   46 ++++++++++++++-
 fs/ocfs2/journal.c             |  124 ++++++++++++++++++++++++++++++-----------
 fs/ocfs2/ocfs2.h               |    7 +-
 fs/ocfs2/ocfs2_fs.h            |    1 
 fs/ocfs2/super.c               |   11 +++
 18 files changed, 249 insertions(+), 142 deletions(-)

Jeff Mahoney:
      ocfs2: fix -Wformat warnings when building UML on x86-64
      ocfs2: complete failure recovery for nodemanager init

Joel Becker:
      ocfs2: Set .owner on masklog sysfs attributes.
      ocfs2: Respond to on-disk corruption in the extent map code.

Mark Fasheh:
      ocfs2: remove pointless max journal size limit
      ocfs2: remove unused code
      ocfs2: remove non existing function prototypes
      ocfs2: fix orphan recovery deadlock
      ocfs2: use hlists for lockres hash

Sunil Mushran:
      ocfs2: added source addr to bind() in o2net_start_connect()

diff --git a/fs/ocfs2/cluster/masklog.c b/fs/ocfs2/cluster/masklog.c
index fd741ce..636593b 100644
--- a/fs/ocfs2/cluster/masklog.c
+++ b/fs/ocfs2/cluster/masklog.c
@@ -74,6 +74,7 @@ struct mlog_attribute {
 #define define_mask(_name) {			\
 	.attr = {				\
 		.name = #_name,			\
+		.owner = THIS_MODULE,		\
 		.mode = S_IRUGO | S_IWUSR,	\
 	},					\
 	.mask = ML_##_name,			\
diff --git a/fs/ocfs2/cluster/masklog.h b/fs/ocfs2/cluster/masklog.h
index e8c56a3..2cadc30 100644
--- a/fs/ocfs2/cluster/masklog.h
+++ b/fs/ocfs2/cluster/masklog.h
@@ -256,7 +256,7 @@ extern struct mlog_bits mlog_and_bits, m
 	}								\
 } while (0)
 
-#if (BITS_PER_LONG == 32) || defined(CONFIG_X86_64)
+#if (BITS_PER_LONG == 32) || defined(CONFIG_X86_64) || (defined(CONFIG_UML_X86) && defined(CONFIG_64BIT))
 #define MLFi64 "lld"
 #define MLFu64 "llu"
 #define MLFx64 "llx"
diff --git a/fs/ocfs2/cluster/nodemanager.c b/fs/ocfs2/cluster/nodemanager.c
index cf7828f..e1fceb8 100644
--- a/fs/ocfs2/cluster/nodemanager.c
+++ b/fs/ocfs2/cluster/nodemanager.c
@@ -756,7 +756,7 @@ static int __init init_o2nm(void)
 	if (!ocfs2_table_header) {
 		printk(KERN_ERR "nodemanager: unable to register sysctl\n");
 		ret = -ENOMEM; /* or something. */
-		goto out;
+		goto out_o2net;
 	}
 
 	ret = o2net_register_hb_callbacks();
@@ -780,6 +780,8 @@ out_callbacks:
 	o2net_unregister_hb_callbacks();
 out_sysctl:
 	unregister_sysctl_table(ocfs2_table_header);
+out_o2net:
+	o2net_exit();
 out:
 	return ret;
 }
diff --git a/fs/ocfs2/cluster/tcp.c b/fs/ocfs2/cluster/tcp.c
index d22d4cf..0f60cc0 100644
--- a/fs/ocfs2/cluster/tcp.c
+++ b/fs/ocfs2/cluster/tcp.c
@@ -1318,7 +1318,7 @@ static void o2net_start_connect(void *ar
 {
 	struct o2net_node *nn = arg;
 	struct o2net_sock_container *sc = NULL;
-	struct o2nm_node *node = NULL;
+	struct o2nm_node *node = NULL, *mynode = NULL;
 	struct socket *sock = NULL;
 	struct sockaddr_in myaddr = {0, }, remoteaddr = {0, };
 	int ret = 0;
@@ -1334,6 +1334,12 @@ static void o2net_start_connect(void *ar
 		goto out;
 	}
 
+	mynode = o2nm_get_node_by_num(o2nm_this_node());
+	if (mynode == NULL) {
+		ret = 0;
+		goto out;
+	}
+
 	spin_lock(&nn->nn_lock);
 	/* see if we already have one pending or have given up */
 	if (nn->nn_sc || nn->nn_persistent_error)
@@ -1361,12 +1367,14 @@ static void o2net_start_connect(void *ar
 	sock->sk->sk_allocation = GFP_ATOMIC;
 
 	myaddr.sin_family = AF_INET;
+	myaddr.sin_addr.s_addr = (__force u32)mynode->nd_ipv4_address;
 	myaddr.sin_port = (__force u16)htons(0); /* any port */
 
 	ret = sock->ops->bind(sock, (struct sockaddr *)&myaddr,
 			      sizeof(myaddr));
 	if (ret) {
-		mlog(0, "bind failed: %d\n", ret);
+		mlog(ML_ERROR, "bind failed with %d at address %u.%u.%u.%u\n",
+		     ret, NIPQUAD(mynode->nd_ipv4_address));
 		goto out;
 	}
 
@@ -1407,6 +1415,8 @@ out:
 		sc_put(sc);
 	if (node)
 		o2nm_node_put(node);
+	if (mynode)
+		o2nm_node_put(mynode);
 
 	return;
 }
diff --git a/fs/ocfs2/cluster/tcp.h b/fs/ocfs2/cluster/tcp.h
index a6f4585..616ff2b 100644
--- a/fs/ocfs2/cluster/tcp.h
+++ b/fs/ocfs2/cluster/tcp.h
@@ -85,13 +85,10 @@ enum {
 	O2NET_DRIVER_READY,
 };
 
-int o2net_init_tcp_sock(struct inode *inode);
 int o2net_send_message(u32 msg_type, u32 key, void *data, u32 len,
 		       u8 target_node, int *status);
 int o2net_send_message_vec(u32 msg_type, u32 key, struct kvec *vec,
 			   size_t veclen, u8 target_node, int *status);
-int o2net_broadcast_message(u32 msg_type, u32 key, void *data, u32 len,
-			    struct inode *group);
 
 int o2net_register_handler(u32 msg_type, u32 key, u32 max_len,
 			   o2net_msg_handler_func *func, void *data,
@@ -107,7 +104,5 @@ void o2net_disconnect_node(struct o2nm_n
 
 int o2net_init(void);
 void o2net_exit(void);
-int o2net_proc_init(struct proc_dir_entry *parent);
-void o2net_proc_exit(struct proc_dir_entry *parent);
 
 #endif /* O2CLUSTER_TCP_H */
diff --git a/fs/ocfs2/dlm/dlmcommon.h b/fs/ocfs2/dlm/dlmcommon.h
index 23ceaa7..9c77258 100644
--- a/fs/ocfs2/dlm/dlmcommon.h
+++ b/fs/ocfs2/dlm/dlmcommon.h
@@ -37,9 +37,7 @@
 #define DLM_THREAD_SHUFFLE_INTERVAL    5     // flush everything every 5 passes
 #define DLM_THREAD_MS                  200   // flush at least every 200 ms
 
-#define DLM_HASH_BITS     7
-#define DLM_HASH_SIZE     (1 << DLM_HASH_BITS)
-#define DLM_HASH_MASK     (DLM_HASH_SIZE - 1)
+#define DLM_HASH_BUCKETS     (PAGE_SIZE / sizeof(struct hlist_head))
 
 enum dlm_ast_type {
 	DLM_AST = 0,
@@ -87,7 +85,7 @@ enum dlm_ctxt_state {
 struct dlm_ctxt
 {
 	struct list_head list;
-	struct list_head *resources;
+	struct hlist_head *lockres_hash;
 	struct list_head dirty_list;
 	struct list_head purge_list;
 	struct list_head pending_asts;
@@ -217,7 +215,7 @@ struct dlm_lock_resource
 {
 	/* WARNING: Please see the comment in dlm_init_lockres before
 	 * adding fields here. */
-	struct list_head list;
+	struct hlist_node hash_node;
 	struct kref      refs;
 
 	/* please keep these next 3 in this order
diff --git a/fs/ocfs2/dlm/dlmdebug.c b/fs/ocfs2/dlm/dlmdebug.c
index f339fe2..54f61b7 100644
--- a/fs/ocfs2/dlm/dlmdebug.c
+++ b/fs/ocfs2/dlm/dlmdebug.c
@@ -117,8 +117,8 @@ EXPORT_SYMBOL_GPL(dlm_print_one_lock);
 void dlm_dump_lock_resources(struct dlm_ctxt *dlm)
 {
 	struct dlm_lock_resource *res;
-	struct list_head *iter;
-	struct list_head *bucket;
+	struct hlist_node *iter;
+	struct hlist_head *bucket;
 	int i;
 
 	mlog(ML_NOTICE, "struct dlm_ctxt: %s, node=%u, key=%u\n",
@@ -129,12 +129,10 @@ void dlm_dump_lock_resources(struct dlm_
 	}
 
 	spin_lock(&dlm->spinlock);
-	for (i=0; i<DLM_HASH_SIZE; i++) {
-		bucket = &(dlm->resources[i]);
-		list_for_each(iter, bucket) {
-			res = list_entry(iter, struct dlm_lock_resource, list);
+	for (i=0; i<DLM_HASH_BUCKETS; i++) {
+		bucket = &(dlm->lockres_hash[i]);
+		hlist_for_each_entry(res, iter, bucket, hash_node)
 			dlm_print_one_lock_resource(res);
-		}
 	}
 	spin_unlock(&dlm->spinlock);
 }
diff --git a/fs/ocfs2/dlm/dlmdomain.c b/fs/ocfs2/dlm/dlmdomain.c
index 6ee3083..8f3a9e3 100644
--- a/fs/ocfs2/dlm/dlmdomain.c
+++ b/fs/ocfs2/dlm/dlmdomain.c
@@ -77,26 +77,26 @@ static void dlm_unregister_domain_handle
 
 void __dlm_unhash_lockres(struct dlm_lock_resource *lockres)
 {
-	list_del_init(&lockres->list);
+	hlist_del_init(&lockres->hash_node);
 	dlm_lockres_put(lockres);
 }
 
 void __dlm_insert_lockres(struct dlm_ctxt *dlm,
 		       struct dlm_lock_resource *res)
 {
-	struct list_head *bucket;
+	struct hlist_head *bucket;
 	struct qstr *q;
 
 	assert_spin_locked(&dlm->spinlock);
 
 	q = &res->lockname;
 	q->hash = full_name_hash(q->name, q->len);
-	bucket = &(dlm->resources[q->hash & DLM_HASH_MASK]);
+	bucket = &(dlm->lockres_hash[q->hash % DLM_HASH_BUCKETS]);
 
 	/* get a reference for our hashtable */
 	dlm_lockres_get(res);
 
-	list_add_tail(&res->list, bucket);
+	hlist_add_head(&res->hash_node, bucket);
 }
 
 struct dlm_lock_resource * __dlm_lookup_lockres(struct dlm_ctxt *dlm,
@@ -104,9 +104,9 @@ struct dlm_lock_resource * __dlm_lookup_
 					 unsigned int len)
 {
 	unsigned int hash;
-	struct list_head *iter;
+	struct hlist_node *iter;
 	struct dlm_lock_resource *tmpres=NULL;
-	struct list_head *bucket;
+	struct hlist_head *bucket;
 
 	mlog_entry("%.*s\n", len, name);
 
@@ -114,11 +114,11 @@ struct dlm_lock_resource * __dlm_lookup_
 
 	hash = full_name_hash(name, len);
 
-	bucket = &(dlm->resources[hash & DLM_HASH_MASK]);
+	bucket = &(dlm->lockres_hash[hash % DLM_HASH_BUCKETS]);
 
 	/* check for pre-existing lock */
-	list_for_each(iter, bucket) {
-		tmpres = list_entry(iter, struct dlm_lock_resource, list);
+	hlist_for_each(iter, bucket) {
+		tmpres = hlist_entry(iter, struct dlm_lock_resource, hash_node);
 		if (tmpres->lockname.len == len &&
 		    memcmp(tmpres->lockname.name, name, len) == 0) {
 			dlm_lockres_get(tmpres);
@@ -193,8 +193,8 @@ static int dlm_wait_on_domain_helper(con
 
 static void dlm_free_ctxt_mem(struct dlm_ctxt *dlm)
 {
-	if (dlm->resources)
-		free_page((unsigned long) dlm->resources);
+	if (dlm->lockres_hash)
+		free_page((unsigned long) dlm->lockres_hash);
 
 	if (dlm->name)
 		kfree(dlm->name);
@@ -303,10 +303,10 @@ static void dlm_migrate_all_locks(struct
 	mlog(0, "Migrating locks from domain %s\n", dlm->name);
 restart:
 	spin_lock(&dlm->spinlock);
-	for (i=0; i<DLM_HASH_SIZE; i++) {
-		while (!list_empty(&dlm->resources[i])) {
-			res = list_entry(dlm->resources[i].next,
-				     struct dlm_lock_resource, list);
+	for (i = 0; i < DLM_HASH_BUCKETS; i++) {
+		while (!hlist_empty(&dlm->lockres_hash[i])) {
+			res = hlist_entry(dlm->lockres_hash[i].first,
+					  struct dlm_lock_resource, hash_node);
 			/* need reference when manually grabbing lockres */
 			dlm_lockres_get(res);
 			/* this should unhash the lockres
@@ -1191,18 +1191,17 @@ static struct dlm_ctxt *dlm_alloc_ctxt(c
 		goto leave;
 	}
 
-	dlm->resources = (struct list_head *) __get_free_page(GFP_KERNEL);
-	if (!dlm->resources) {
+	dlm->lockres_hash = (struct hlist_head *) __get_free_page(GFP_KERNEL);
+	if (!dlm->lockres_hash) {
 		mlog_errno(-ENOMEM);
 		kfree(dlm->name);
 		kfree(dlm);
 		dlm = NULL;
 		goto leave;
 	}
-	memset(dlm->resources, 0, PAGE_SIZE);
 
-	for (i=0; i<DLM_HASH_SIZE; i++)
-		INIT_LIST_HEAD(&dlm->resources[i]);
+	for (i=0; i<DLM_HASH_BUCKETS; i++)
+		INIT_HLIST_HEAD(&dlm->lockres_hash[i]);
 
 	strcpy(dlm->name, domain);
 	dlm->key = key;
diff --git a/fs/ocfs2/dlm/dlmmaster.c b/fs/ocfs2/dlm/dlmmaster.c
index 2e2e95e..847dd3c 100644
--- a/fs/ocfs2/dlm/dlmmaster.c
+++ b/fs/ocfs2/dlm/dlmmaster.c
@@ -564,7 +564,7 @@ static void dlm_lockres_release(struct k
 
 	/* By the time we're ready to blow this guy away, we shouldn't
 	 * be on any lists. */
-	BUG_ON(!list_empty(&res->list));
+	BUG_ON(!hlist_unhashed(&res->hash_node));
 	BUG_ON(!list_empty(&res->granted));
 	BUG_ON(!list_empty(&res->converting));
 	BUG_ON(!list_empty(&res->blocked));
@@ -605,7 +605,7 @@ static void dlm_init_lockres(struct dlm_
 
 	init_waitqueue_head(&res->wq);
 	spin_lock_init(&res->spinlock);
-	INIT_LIST_HEAD(&res->list);
+	INIT_HLIST_NODE(&res->hash_node);
 	INIT_LIST_HEAD(&res->granted);
 	INIT_LIST_HEAD(&res->converting);
 	INIT_LIST_HEAD(&res->blocked);
diff --git a/fs/ocfs2/dlm/dlmrecovery.c b/fs/ocfs2/dlm/dlmrecovery.c
index ed76bda..1e23200 100644
--- a/fs/ocfs2/dlm/dlmrecovery.c
+++ b/fs/ocfs2/dlm/dlmrecovery.c
@@ -1693,7 +1693,10 @@ static void dlm_finish_local_lockres_rec
 					      u8 dead_node, u8 new_master)
 {
 	int i;
-	struct list_head *iter, *iter2, *bucket;
+	struct list_head *iter, *iter2;
+	struct hlist_node *hash_iter;
+	struct hlist_head *bucket;
+
 	struct dlm_lock_resource *res;
 
 	mlog_entry_void();
@@ -1717,10 +1720,9 @@ static void dlm_finish_local_lockres_rec
 	 * for now we need to run the whole hash, clear
 	 * the RECOVERING state and set the owner
 	 * if necessary */
-	for (i=0; i<DLM_HASH_SIZE; i++) {
-		bucket = &(dlm->resources[i]);
-		list_for_each(iter, bucket) {
-			res = list_entry (iter, struct dlm_lock_resource, list);
+	for (i = 0; i < DLM_HASH_BUCKETS; i++) {
+		bucket = &(dlm->lockres_hash[i]);
+		hlist_for_each_entry(res, hash_iter, bucket, hash_node) {
 			if (res->state & DLM_LOCK_RES_RECOVERING) {
 				if (res->owner == dead_node) {
 					mlog(0, "(this=%u) res %.*s owner=%u "
@@ -1852,10 +1854,10 @@ static void dlm_free_dead_locks(struct d
 
 static void dlm_do_local_recovery_cleanup(struct dlm_ctxt *dlm, u8 dead_node)
 {
-	struct list_head *iter;
+	struct hlist_node *iter;
 	struct dlm_lock_resource *res;
 	int i;
-	struct list_head *bucket;
+	struct hlist_head *bucket;
 	struct dlm_lock *lock;
 
 
@@ -1876,10 +1878,9 @@ static void dlm_do_local_recovery_cleanu
 	 *    can be kicked again to see if any ASTs or BASTs
 	 *    need to be fired as a result.
 	 */
-	for (i=0; i<DLM_HASH_SIZE; i++) {
-		bucket = &(dlm->resources[i]);
-		list_for_each(iter, bucket) {
-			res = list_entry (iter, struct dlm_lock_resource, list);
+	for (i = 0; i < DLM_HASH_BUCKETS; i++) {
+		bucket = &(dlm->lockres_hash[i]);
+		hlist_for_each_entry(res, iter, bucket, hash_node) {
  			/* always prune any $RECOVERY entries for dead nodes,
  			 * otherwise hangs can occur during later recovery */
 			if (dlm_is_recovery_lock(res->lockname.name,
diff --git a/fs/ocfs2/extent_map.c b/fs/ocfs2/extent_map.c
index b6ba292..e6f207e 100644
--- a/fs/ocfs2/extent_map.c
+++ b/fs/ocfs2/extent_map.c
@@ -181,6 +181,12 @@ static int ocfs2_extent_map_find_leaf(st
 			ret = -EBADR;
 			if (rec_end > OCFS2_I(inode)->ip_clusters) {
 				mlog_errno(ret);
+				ocfs2_error(inode->i_sb,
+					    "Extent %d at e_blkno %"MLFu64" of inode %"MLFu64" goes past ip_clusters of %u\n",
+					    i,
+					    le64_to_cpu(rec->e_blkno),
+					    OCFS2_I(inode)->ip_blkno,
+					    OCFS2_I(inode)->ip_clusters);
 				goto out_free;
 			}
 
@@ -226,6 +232,12 @@ static int ocfs2_extent_map_find_leaf(st
 			ret = -EBADR;
 			if (blkno) {
 				mlog_errno(ret);
+				ocfs2_error(inode->i_sb,
+					    "Multiple extents for (cpos = %u, clusters = %u) on inode %"MLFu64"; e_blkno %"MLFu64" and rec %d at e_blkno %"MLFu64"\n",
+					    cpos, clusters,
+					    OCFS2_I(inode)->ip_blkno,
+					    blkno, i,
+					    le64_to_cpu(rec->e_blkno));
 				goto out_free;
 			}
 
@@ -238,6 +250,10 @@ static int ocfs2_extent_map_find_leaf(st
 		 */
 		ret = -EBADR;
 		if (!blkno) {
+			ocfs2_error(inode->i_sb,
+				    "No record found for (cpos = %u, clusters = %u) on inode %"MLFu64"\n",
+				    cpos, clusters,
+				    OCFS2_I(inode)->ip_blkno);
 			mlog_errno(ret);
 			goto out_free;
 		}
@@ -266,6 +282,20 @@ static int ocfs2_extent_map_find_leaf(st
 
 	for (i = 0; i < le16_to_cpu(el->l_next_free_rec); i++) {
 		rec = &el->l_recs[i];
+
+		if ((le32_to_cpu(rec->e_cpos) + le32_to_cpu(rec->e_clusters)) >
+		    OCFS2_I(inode)->ip_clusters) {
+			ret = -EBADR;
+			mlog_errno(ret);
+			ocfs2_error(inode->i_sb,
+				    "Extent %d at e_blkno %"MLFu64" of inode %"MLFu64" goes past ip_clusters of %u\n",
+				    i,
+				    le64_to_cpu(rec->e_blkno),
+				    OCFS2_I(inode)->ip_blkno,
+				    OCFS2_I(inode)->ip_clusters);
+			return ret;
+		}
+
 		ret = ocfs2_extent_map_insert(inode, rec,
 					      le16_to_cpu(el->l_tree_depth));
 		if (ret) {
@@ -526,6 +556,10 @@ static int ocfs2_extent_map_insert(struc
 		    OCFS2_I(inode)->ip_map.em_clusters) {
 			ret = -EBADR;
 			mlog_errno(ret);
+			ocfs2_error(inode->i_sb,
+				    "Zero e_clusters on non-tail extent record at e_blkno %"MLFu64" on inode %"MLFu64"\n",
+				    le64_to_cpu(rec->e_blkno),
+				    OCFS2_I(inode)->ip_blkno);
 			return ret;
 		}
 
@@ -588,12 +622,12 @@ static int ocfs2_extent_map_insert(struc
  * Existing record in the extent map:
  *
  *	cpos = 10, len = 10
- * 	|---------|
+ *	|---------|
  *
  * New Record:
  *
  *	cpos = 10, len = 20
- * 	|------------------|
+ *	|------------------|
  *
  * The passed record is the new on-disk record.  The new_clusters value
  * is how many clusters were added to the file.  If the append is a
diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c
index 1715bc9..8a4048b 100644
--- a/fs/ocfs2/file.c
+++ b/fs/ocfs2/file.c
@@ -933,9 +933,6 @@ static ssize_t ocfs2_file_aio_write(stru
 	struct file *filp = iocb->ki_filp;
 	struct inode *inode = filp->f_dentry->d_inode;
 	loff_t newsize, saved_pos;
-#ifdef OCFS2_ORACORE_WORKAROUNDS
-	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
-#endif
 
 	mlog_entry("(0x%p, 0x%p, %u, '%.*s')\n", filp, buf,
 		   (unsigned int)count,
@@ -951,14 +948,6 @@ static ssize_t ocfs2_file_aio_write(stru
 		return -EIO;
 	}
 
-#ifdef OCFS2_ORACORE_WORKAROUNDS
-	/* ugh, work around some applications which open everything O_DIRECT +
-	 * O_APPEND and really don't mean to use O_DIRECT. */
-	if (osb->s_mount_opt & OCFS2_MOUNT_COMPAT_OCFS &&
-	    (filp->f_flags & O_APPEND) && (filp->f_flags & O_DIRECT)) 
-		filp->f_flags &= ~O_DIRECT;
-#endif
-
 	mutex_lock(&inode->i_mutex);
 	/* to match setattr's i_mutex -> i_alloc_sem -> rw_lock ordering */
 	if (filp->f_flags & O_DIRECT) {
@@ -1079,27 +1068,7 @@ static ssize_t ocfs2_file_aio_write(stru
 	/* communicate with ocfs2_dio_end_io */
 	ocfs2_iocb_set_rw_locked(iocb);
 
-#ifdef OCFS2_ORACORE_WORKAROUNDS
-	if (osb->s_mount_opt & OCFS2_MOUNT_COMPAT_OCFS &&
-	    filp->f_flags & O_DIRECT) {
-		unsigned int saved_flags = filp->f_flags;
-		int sector_size = 1 << osb->s_sectsize_bits;
-
-		if ((saved_pos & (sector_size - 1)) ||
-		    (count & (sector_size - 1)) ||
-		    ((unsigned long)buf & (sector_size - 1))) {
-			filp->f_flags |= O_SYNC;
-			filp->f_flags &= ~O_DIRECT;
-		}
-
-		ret = generic_file_aio_write_nolock(iocb, &local_iov, 1,
-						    &iocb->ki_pos);
-
-		filp->f_flags = saved_flags;
-	} else
-#endif
-		ret = generic_file_aio_write_nolock(iocb, &local_iov, 1,
-						    &iocb->ki_pos);
+	ret = generic_file_aio_write_nolock(iocb, &local_iov, 1, &iocb->ki_pos);
 
 	/* buffered aio wouldn't have proper lock coverage today */
 	BUG_ON(ret == -EIOCBQUEUED && !(filp->f_flags & O_DIRECT));
@@ -1140,9 +1109,6 @@ static ssize_t ocfs2_file_aio_read(struc
 	int ret = 0, rw_level = -1, have_alloc_sem = 0;
 	struct file *filp = iocb->ki_filp;
 	struct inode *inode = filp->f_dentry->d_inode;
-#ifdef OCFS2_ORACORE_WORKAROUNDS
-	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
-#endif
 
 	mlog_entry("(0x%p, 0x%p, %u, '%.*s')\n", filp, buf,
 		   (unsigned int)count,
@@ -1155,21 +1121,6 @@ static ssize_t ocfs2_file_aio_read(struc
 		goto bail;
 	}
 
-#ifdef OCFS2_ORACORE_WORKAROUNDS
-	if (osb->s_mount_opt & OCFS2_MOUNT_COMPAT_OCFS) {
-		if (filp->f_flags & O_DIRECT) {
-			int sector_size = 1 << osb->s_sectsize_bits;
-
-			if ((pos & (sector_size - 1)) ||
-			    (count & (sector_size - 1)) ||
-			    ((unsigned long)buf & (sector_size - 1)) ||
-			    (i_size_read(inode) & (sector_size -1))) {
-				filp->f_flags &= ~O_DIRECT;
-			}
-		}
-	}
-#endif
-
 	/* 
 	 * buffered reads protect themselves in ->readpage().  O_DIRECT reads
 	 * need locks to protect pending reads from racing with truncate.
diff --git a/fs/ocfs2/heartbeat.c b/fs/ocfs2/heartbeat.c
index 0bbd22f..cbfd45a 100644
--- a/fs/ocfs2/heartbeat.c
+++ b/fs/ocfs2/heartbeat.c
@@ -67,6 +67,7 @@ void ocfs2_init_node_maps(struct ocfs2_s
 	ocfs2_node_map_init(&osb->mounted_map);
 	ocfs2_node_map_init(&osb->recovery_map);
 	ocfs2_node_map_init(&osb->umount_map);
+	ocfs2_node_map_init(&osb->osb_recovering_orphan_dirs);
 }
 
 static void ocfs2_do_node_down(int node_num,
diff --git a/fs/ocfs2/inode.c b/fs/ocfs2/inode.c
index 8122489..315472a 100644
--- a/fs/ocfs2/inode.c
+++ b/fs/ocfs2/inode.c
@@ -41,6 +41,7 @@
 #include "dlmglue.h"
 #include "extent_map.h"
 #include "file.h"
+#include "heartbeat.h"
 #include "inode.h"
 #include "journal.h"
 #include "namei.h"
@@ -544,6 +545,42 @@ bail:
 	return status;
 }
 
+/* 
+ * Serialize with orphan dir recovery. If the process doing
+ * recovery on this orphan dir does an iget() with the dir
+ * i_mutex held, we'll deadlock here. Instead we detect this
+ * and exit early - recovery will wipe this inode for us.
+ */
+static int ocfs2_check_orphan_recovery_state(struct ocfs2_super *osb,
+					     int slot)
+{
+	int ret = 0;
+
+	spin_lock(&osb->osb_lock);
+	if (ocfs2_node_map_test_bit(osb, &osb->osb_recovering_orphan_dirs, slot)) {
+		mlog(0, "Recovery is happening on orphan dir %d, will skip "
+		     "this inode\n", slot);
+		ret = -EDEADLK;
+		goto out;
+	}
+	/* This signals to the orphan recovery process that it should
+	 * wait for us to handle the wipe. */
+	osb->osb_orphan_wipes[slot]++;
+out:
+	spin_unlock(&osb->osb_lock);
+	return ret;
+}
+
+static void ocfs2_signal_wipe_completion(struct ocfs2_super *osb,
+					 int slot)
+{
+	spin_lock(&osb->osb_lock);
+	osb->osb_orphan_wipes[slot]--;
+	spin_unlock(&osb->osb_lock);
+
+	wake_up(&osb->osb_wipe_event);
+}
+
 static int ocfs2_wipe_inode(struct inode *inode,
 			    struct buffer_head *di_bh)
 {
@@ -555,6 +592,11 @@ static int ocfs2_wipe_inode(struct inode
 	/* We've already voted on this so it should be readonly - no
 	 * spinlock needed. */
 	orphaned_slot = OCFS2_I(inode)->ip_orphaned_slot;
+
+	status = ocfs2_check_orphan_recovery_state(osb, orphaned_slot);
+	if (status)
+		return status;
+
 	orphan_dir_inode = ocfs2_get_system_file_inode(osb,
 						       ORPHAN_DIR_SYSTEM_INODE,
 						       orphaned_slot);
@@ -597,6 +639,7 @@ bail_unlock_dir:
 	brelse(orphan_dir_bh);
 bail:
 	iput(orphan_dir_inode);
+	ocfs2_signal_wipe_completion(osb, orphaned_slot);
 
 	return status;
 }
@@ -822,7 +865,8 @@ void ocfs2_delete_inode(struct inode *in
 
 	status = ocfs2_wipe_inode(inode, di_bh);
 	if (status < 0) {
-		mlog_errno(status);
+		if (status != -EDEADLK)
+			mlog_errno(status);
 		goto bail_unlock_inode;
 	}
 
diff --git a/fs/ocfs2/journal.c b/fs/ocfs2/journal.c
index d329c9d..4be801f 100644
--- a/fs/ocfs2/journal.c
+++ b/fs/ocfs2/journal.c
@@ -1408,21 +1408,17 @@ bail:
 	return status;
 }
 
-static int ocfs2_recover_orphans(struct ocfs2_super *osb,
-				 int slot)
+static int ocfs2_queue_orphans(struct ocfs2_super *osb,
+			       int slot,
+			       struct inode **head)
 {
-	int status = 0;
-	int have_disk_lock = 0;
-	struct inode *inode = NULL;
-	struct inode *iter;
+	int status;
 	struct inode *orphan_dir_inode = NULL;
+	struct inode *iter;
 	unsigned long offset, blk, local;
 	struct buffer_head *bh = NULL;
 	struct ocfs2_dir_entry *de;
 	struct super_block *sb = osb->sb;
-	struct ocfs2_inode_info *oi;
-
-	mlog(0, "Recover inodes from orphan dir in slot %d\n", slot);
 
 	orphan_dir_inode = ocfs2_get_system_file_inode(osb,
 						       ORPHAN_DIR_SYSTEM_INODE,
@@ -1430,17 +1426,15 @@ static int ocfs2_recover_orphans(struct 
 	if  (!orphan_dir_inode) {
 		status = -ENOENT;
 		mlog_errno(status);
-		goto out;
-	}
+		return status;
+	}	
 
 	mutex_lock(&orphan_dir_inode->i_mutex);
 	status = ocfs2_meta_lock(orphan_dir_inode, NULL, NULL, 0);
 	if (status < 0) {
-		mutex_unlock(&orphan_dir_inode->i_mutex);
 		mlog_errno(status);
 		goto out;
 	}
-	have_disk_lock = 1;
 
 	offset = 0;
 	iter = NULL;
@@ -1451,11 +1445,10 @@ static int ocfs2_recover_orphans(struct 
 		if (!bh)
 			status = -EINVAL;
 		if (status < 0) {
-			mutex_unlock(&orphan_dir_inode->i_mutex);
 			if (bh)
 				brelse(bh);
 			mlog_errno(status);
-			goto out;
+			goto out_unlock;
 		}
 
 		local = 0;
@@ -1465,11 +1458,10 @@ static int ocfs2_recover_orphans(struct 
 
 			if (!ocfs2_check_dir_entry(orphan_dir_inode,
 						  de, bh, local)) {
-				mutex_unlock(&orphan_dir_inode->i_mutex);
 				status = -EINVAL;
 				mlog_errno(status);
 				brelse(bh);
-				goto out;
+				goto out_unlock;
 			}
 
 			local += le16_to_cpu(de->rec_len);
@@ -1504,18 +1496,95 @@ static int ocfs2_recover_orphans(struct 
 
 			mlog(0, "queue orphan %"MLFu64"\n",
 			     OCFS2_I(iter)->ip_blkno);
-			OCFS2_I(iter)->ip_next_orphan = inode;
-			inode = iter;
+			/* No locking is required for the next_orphan
+			 * queue as there is only ever a single
+			 * process doing orphan recovery. */
+			OCFS2_I(iter)->ip_next_orphan = *head;
+			*head = iter;
 		}
 		brelse(bh);
 	}
-	mutex_unlock(&orphan_dir_inode->i_mutex);
 
+out_unlock:
 	ocfs2_meta_unlock(orphan_dir_inode, 0);
-	have_disk_lock = 0;
-
+out:
+	mutex_unlock(&orphan_dir_inode->i_mutex);
 	iput(orphan_dir_inode);
-	orphan_dir_inode = NULL;
+	return status;
+}
+
+static int ocfs2_orphan_recovery_can_continue(struct ocfs2_super *osb,
+					      int slot)
+{
+	int ret;
+
+	spin_lock(&osb->osb_lock);
+	ret = !osb->osb_orphan_wipes[slot];
+	spin_unlock(&osb->osb_lock);
+	return ret;
+}
+
+static void ocfs2_mark_recovering_orphan_dir(struct ocfs2_super *osb,
+					     int slot)
+{
+	spin_lock(&osb->osb_lock);
+	/* Mark ourselves such that new processes in delete_inode()
+	 * know to quit early. */
+	ocfs2_node_map_set_bit(osb, &osb->osb_recovering_orphan_dirs, slot);
+	while (osb->osb_orphan_wipes[slot]) {
+		/* If any processes are already in the middle of an
+		 * orphan wipe on this dir, then we need to wait for
+		 * them. */
+		spin_unlock(&osb->osb_lock);
+		wait_event_interruptible(osb->osb_wipe_event,
+					 ocfs2_orphan_recovery_can_continue(osb, slot));
+		spin_lock(&osb->osb_lock);
+	}
+	spin_unlock(&osb->osb_lock);
+}
+
+static void ocfs2_clear_recovering_orphan_dir(struct ocfs2_super *osb,
+					      int slot)
+{
+	ocfs2_node_map_clear_bit(osb, &osb->osb_recovering_orphan_dirs, slot);
+}
+
+/*
+ * Orphan recovery. Each mounted node has it's own orphan dir which we
+ * must run during recovery. Our strategy here is to build a list of
+ * the inodes in the orphan dir and iget/iput them. The VFS does
+ * (most) of the rest of the work.
+ *
+ * Orphan recovery can happen at any time, not just mount so we have a
+ * couple of extra considerations.
+ *
+ * - We grab as many inodes as we can under the orphan dir lock -
+ *   doing iget() outside the orphan dir risks getting a reference on
+ *   an invalid inode.
+ * - We must be sure not to deadlock with other processes on the
+ *   system wanting to run delete_inode(). This can happen when they go
+ *   to lock the orphan dir and the orphan recovery process attempts to
+ *   iget() inside the orphan dir lock. This can be avoided by
+ *   advertising our state to ocfs2_delete_inode().
+ */
+static int ocfs2_recover_orphans(struct ocfs2_super *osb,
+				 int slot)
+{
+	int ret = 0;
+	struct inode *inode = NULL;
+	struct inode *iter;
+	struct ocfs2_inode_info *oi;
+
+	mlog(0, "Recover inodes from orphan dir in slot %d\n", slot);
+
+	ocfs2_mark_recovering_orphan_dir(osb, slot);
+	ret = ocfs2_queue_orphans(osb, slot, &inode);
+	ocfs2_clear_recovering_orphan_dir(osb, slot);
+
+	/* Error here should be noted, but we want to continue with as
+	 * many queued inodes as we've got. */
+	if (ret)
+		mlog_errno(ret);
 
 	while (inode) {
 		oi = OCFS2_I(inode);
@@ -1541,14 +1610,7 @@ static int ocfs2_recover_orphans(struct 
 		inode = iter;
 	}
 
-out:
-	if (have_disk_lock)
-		ocfs2_meta_unlock(orphan_dir_inode, 0);
-
-	if (orphan_dir_inode)
-		iput(orphan_dir_inode);
-
-	return status;
+	return ret;
 }
 
 static int ocfs2_wait_on_mount(struct ocfs2_super *osb)
diff --git a/fs/ocfs2/ocfs2.h b/fs/ocfs2/ocfs2.h
index 8d8e477..e89de9b 100644
--- a/fs/ocfs2/ocfs2.h
+++ b/fs/ocfs2/ocfs2.h
@@ -174,9 +174,6 @@ enum ocfs2_mount_options
 	OCFS2_MOUNT_NOINTR  = 1 << 2,   /* Don't catch signals */
 	OCFS2_MOUNT_ERRORS_PANIC = 1 << 3, /* Panic on errors */
 	OCFS2_MOUNT_DATA_WRITEBACK = 1 << 4, /* No data ordering */
-#ifdef OCFS2_ORACORE_WORKAROUNDS
-	OCFS2_MOUNT_COMPAT_OCFS = 1 << 30, /* ocfs1 compatibility mode */
-#endif
 };
 
 #define OCFS2_OSB_SOFT_RO	0x0001
@@ -290,6 +287,10 @@ struct ocfs2_super
 	struct inode			*osb_tl_inode;
 	struct buffer_head		*osb_tl_bh;
 	struct work_struct		osb_truncate_log_wq;
+
+	struct ocfs2_node_map		osb_recovering_orphan_dirs;
+	unsigned int			*osb_orphan_wipes;
+	wait_queue_head_t		osb_wipe_event;
 };
 
 #define OCFS2_SB(sb)	    ((struct ocfs2_super *)(sb)->s_fs_info)
diff --git a/fs/ocfs2/ocfs2_fs.h b/fs/ocfs2/ocfs2_fs.h
index dfb8a5b..c5b1ac5 100644
--- a/fs/ocfs2/ocfs2_fs.h
+++ b/fs/ocfs2/ocfs2_fs.h
@@ -138,7 +138,6 @@
 
 /* Journal limits (in bytes) */
 #define OCFS2_MIN_JOURNAL_SIZE		(4 * 1024 * 1024)
-#define OCFS2_MAX_JOURNAL_SIZE		(500 * 1024 * 1024)
 
 struct ocfs2_system_inode_info {
 	char	*si_name;
diff --git a/fs/ocfs2/super.c b/fs/ocfs2/super.c
index 046824b..8dd3aaf 100644
--- a/fs/ocfs2/super.c
+++ b/fs/ocfs2/super.c
@@ -1325,6 +1325,16 @@ static int ocfs2_initialize_super(struct
 	}
 	mlog(ML_NOTICE, "max_slots for this device: %u\n", osb->max_slots);
 
+	init_waitqueue_head(&osb->osb_wipe_event);
+	osb->osb_orphan_wipes = kcalloc(osb->max_slots,
+					sizeof(*osb->osb_orphan_wipes),
+					GFP_KERNEL);
+	if (!osb->osb_orphan_wipes) {
+		status = -ENOMEM;
+		mlog_errno(status);
+		goto bail;
+	}
+
 	osb->s_feature_compat =
 		le32_to_cpu(OCFS2_RAW_SB(di)->s_feature_compat);
 	osb->s_feature_ro_compat =
@@ -1638,6 +1648,7 @@ static void ocfs2_delete_osb(struct ocfs
 	if (osb->slot_info)
 		ocfs2_free_slot_info(osb->slot_info);
 
+	kfree(osb->osb_orphan_wipes);
 	/* FIXME
 	 * This belongs in journal shutdown, but because we have to
 	 * allocate osb->journal at the start of ocfs2_initalize_osb(),
