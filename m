Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751334AbWF3AFx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751334AbWF3AFx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 20:05:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751338AbWF3AFx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 20:05:53 -0400
Received: from rgminet01.oracle.com ([148.87.113.118]:23787 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1751334AbWF3AFv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 20:05:51 -0400
Date: Thu, 29 Jun 2006 17:05:29 -0700
From: Mark Fasheh <mark.fasheh@oracle.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org
Subject: [git patches] ocfs2 updates
Message-ID: <20060630000529.GE4036@ca-server1.us.oracle.com>
Reply-To: Mark Fasheh <mark.fasheh@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Oracle Corporation
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull from 'upstream-linus' branch of
git://git.kernel.org/pub/scm/linux/kernel/git/mfasheh/ocfs2.git

to receive the following updates:

 Documentation/filesystems/configfs/configfs_example.c |   19 +++++-
 fs/Kconfig                                            |   12 ++++
 fs/configfs/dir.c                                     |    6 +-
 fs/configfs/symlink.c                                 |    2 
 fs/ocfs2/aops.c                                       |    9 ---
 fs/ocfs2/cluster/heartbeat.c                          |   20 +++++++
 fs/ocfs2/cluster/masklog.h                            |   22 +++++++-
 fs/ocfs2/cluster/ocfs2_heartbeat.h                    |    1 
 fs/ocfs2/cluster/tcp.c                                |   14 ++---
 fs/ocfs2/dir.c                                        |    6 --
 fs/ocfs2/dlm/dlmcommon.h                              |    2 
 fs/ocfs2/dlm/dlmdomain.c                              |    9 ++-
 fs/ocfs2/dlm/dlmrecovery.c                            |    8 ++
 fs/ocfs2/dlmglue.c                                    |    3 -
 fs/ocfs2/extent_map.c                                 |   29 ++++++++--
 fs/ocfs2/journal.c                                    |    5 -
 fs/ocfs2/mmap.c                                       |    4 -
 fs/ocfs2/ocfs2.h                                      |    4 -
 fs/ocfs2/slot_map.c                                   |    2 
 fs/ocfs2/super.c                                      |   49 ++----------------
 fs/ocfs2/symlink.c                                    |    2 
 21 files changed, 131 insertions(+), 97 deletions(-)

Adrian Bunk:
      ocfs2: OCFS2_FS must depend on SYSFS
      fs/ocfs2/dlm/dlmrecovery.c: make dlm_lockres_master_requery() static

Florin Malita:
      ocfs2: remove redundant NULL checks in ocfs2_direct_IO_get_blocks()

Joel Becker:
      configfs: Release memory in configfs_example.
      configfs: Clear up a few extra spaces where there should be TABs.
      ocfs2: Compile-time disabling of ocfs2 debugging output.
      ocfs2: silence -EEXIST from ocfs2_extent_map_insert/lookup

Mark Fasheh:
      ocfs2: warn the user on a dead timeout mismatch
      ocfs2: silence a debug print
      ocfs2: fix init of uuid_net_key
      ocfs2: clean up some osb fields

Sunil Mushran:
      ocfs2: Cleanup message prints
      ocfs2: silence ENOENT during lookup of broken links

diff --git a/Documentation/filesystems/configfs/configfs_example.c b/Documentation/filesystems/configfs/configfs_example.c
index 3d4713a..2d6a14a 100644
--- a/Documentation/filesystems/configfs/configfs_example.c
+++ b/Documentation/filesystems/configfs/configfs_example.c
@@ -264,6 +264,15 @@ static struct config_item_type simple_ch
 };
 
 
+struct simple_children {
+	struct config_group group;
+};
+
+static inline struct simple_children *to_simple_children(struct config_item *item)
+{
+	return item ? container_of(to_config_group(item), struct simple_children, group) : NULL;
+}
+
 static struct config_item *simple_children_make_item(struct config_group *group, const char *name)
 {
 	struct simple_child *simple_child;
@@ -304,7 +313,13 @@ static ssize_t simple_children_attr_show
 "items have only one attribute that is readable and writeable.\n");
 }
 
+static void simple_children_release(struct config_item *item)
+{
+	kfree(to_simple_children(item));
+}
+
 static struct configfs_item_operations simple_children_item_ops = {
+	.release 	= simple_children_release,
 	.show_attribute	= simple_children_attr_show,
 };
 
@@ -345,10 +360,6 @@ static struct configfs_subsystem simple_
  * children of its own.
  */
 
-struct simple_children {
-	struct config_group group;
-};
-
 static struct config_group *group_children_make_group(struct config_group *group, const char *name)
 {
 	struct simple_children *simple_children;
diff --git a/fs/Kconfig b/fs/Kconfig
index 6dc8cfd..53f5c6d 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -326,7 +326,7 @@ source "fs/xfs/Kconfig"
 
 config OCFS2_FS
 	tristate "OCFS2 file system support (EXPERIMENTAL)"
-	depends on NET && EXPERIMENTAL
+	depends on NET && SYSFS && EXPERIMENTAL
 	select CONFIGFS_FS
 	select JBD
 	select CRC32
@@ -356,6 +356,16 @@ config OCFS2_FS
 	          - POSIX ACLs
 	          - readpages / writepages (not user visible)
 
+config OCFS2_DEBUG_MASKLOG
+	bool "OCFS2 logging support"
+	depends on OCFS2_FS
+	default y
+	help
+	  The ocfs2 filesystem has an extensive logging system.  The system
+	  allows selection of events to log via files in /sys/o2cb/logmask/.
+	  This option will enlarge your kernel, but it allows debugging of
+	  ocfs2 filesystem issues.
+
 config MINIX_FS
 	tristate "Minix fs support"
 	help
diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
index 207f800..df02545 100644
--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -211,7 +211,7 @@ static void remove_dir(struct dentry * d
 	struct configfs_dirent * sd;
 
 	sd = d->d_fsdata;
- 	list_del_init(&sd->s_sibling);
+	list_del_init(&sd->s_sibling);
 	configfs_put(sd);
 	if (d->d_inode)
 		simple_rmdir(parent->d_inode,d);
@@ -330,7 +330,7 @@ static int configfs_detach_prep(struct d
 
 			ret = configfs_detach_prep(sd->s_dentry);
 			if (!ret)
-			       	continue;
+				continue;
 		} else
 			ret = -ENOTEMPTY;
 
@@ -931,7 +931,7 @@ int configfs_rename_dir(struct config_it
 
 	new_dentry = lookup_one_len(new_name, parent, strlen(new_name));
 	if (!IS_ERR(new_dentry)) {
-  		if (!new_dentry->d_inode) {
+		if (!new_dentry->d_inode) {
 			error = config_item_set_name(item, "%s", new_name);
 			if (!error) {
 				d_add(new_dentry, NULL);
diff --git a/fs/configfs/symlink.c b/fs/configfs/symlink.c
index e5512e2..fb65e08 100644
--- a/fs/configfs/symlink.c
+++ b/fs/configfs/symlink.c
@@ -66,7 +66,7 @@ static void fill_item_path(struct config
 }
 
 static int create_link(struct config_item *parent_item,
- 		       struct config_item *item,
+		       struct config_item *item,
 		       struct dentry *dentry)
 {
 	struct configfs_dirent *target_sd = item->ci_dentry->d_fsdata;
diff --git a/fs/ocfs2/aops.c b/fs/ocfs2/aops.c
index cca7131..f1d1c34 100644
--- a/fs/ocfs2/aops.c
+++ b/fs/ocfs2/aops.c
@@ -558,16 +558,9 @@ static int ocfs2_direct_IO_get_blocks(st
 	u64 vbo_max; /* file offset, max_blocks from iblock */
 	u64 p_blkno;
 	int contig_blocks;
-	unsigned char blocksize_bits;
+	unsigned char blocksize_bits = inode->i_sb->s_blocksize_bits;
 	unsigned long max_blocks = bh_result->b_size >> inode->i_blkbits;
 
-	if (!inode || !bh_result) {
-		mlog(ML_ERROR, "inode or bh_result is null\n");
-		return -EIO;
-	}
-
-	blocksize_bits = inode->i_sb->s_blocksize_bits;
-
 	/* This function won't even be called if the request isn't all
 	 * nicely aligned and of the right size, so there's no need
 	 * for us to check any of that. */
diff --git a/fs/ocfs2/cluster/heartbeat.c b/fs/ocfs2/cluster/heartbeat.c
index 1d26cfc..504595d 100644
--- a/fs/ocfs2/cluster/heartbeat.c
+++ b/fs/ocfs2/cluster/heartbeat.c
@@ -517,6 +517,7 @@ static inline void o2hb_prepare_block(st
 	hb_block->hb_seq = cpu_to_le64(cputime);
 	hb_block->hb_node = node_num;
 	hb_block->hb_generation = cpu_to_le64(generation);
+	hb_block->hb_dead_ms = cpu_to_le32(o2hb_dead_threshold * O2HB_REGION_TIMEOUT_MS);
 
 	/* This step must always happen last! */
 	hb_block->hb_cksum = cpu_to_le32(o2hb_compute_block_crc_le(reg,
@@ -645,6 +646,8 @@ static int o2hb_check_slot(struct o2hb_r
 	struct o2nm_node *node;
 	struct o2hb_disk_heartbeat_block *hb_block = reg->hr_tmp_block;
 	u64 cputime;
+	unsigned int dead_ms = o2hb_dead_threshold * O2HB_REGION_TIMEOUT_MS;
+	unsigned int slot_dead_ms;
 
 	memcpy(hb_block, slot->ds_raw_block, reg->hr_block_bytes);
 
@@ -733,6 +736,23 @@ fire_callbacks:
 			      &o2hb_live_slots[slot->ds_node_num]);
 
 		slot->ds_equal_samples = 0;
+
+		/* We want to be sure that all nodes agree on the
+		 * number of milliseconds before a node will be
+		 * considered dead. The self-fencing timeout is
+		 * computed from this value, and a discrepancy might
+		 * result in heartbeat calling a node dead when it
+		 * hasn't self-fenced yet. */
+		slot_dead_ms = le32_to_cpu(hb_block->hb_dead_ms);
+		if (slot_dead_ms && slot_dead_ms != dead_ms) {
+			/* TODO: Perhaps we can fail the region here. */
+			mlog(ML_ERROR, "Node %d on device %s has a dead count "
+			     "of %u ms, but our count is %u ms.\n"
+			     "Please double check your configuration values "
+			     "for 'O2CB_HEARTBEAT_THRESHOLD'\n",
+			     slot->ds_node_num, reg->hr_dev_name, slot_dead_ms,
+			     dead_ms);
+		}
 		goto out;
 	}
 
diff --git a/fs/ocfs2/cluster/masklog.h b/fs/ocfs2/cluster/masklog.h
index 73edad7..a42628b 100644
--- a/fs/ocfs2/cluster/masklog.h
+++ b/fs/ocfs2/cluster/masklog.h
@@ -123,6 +123,17 @@ #ifndef MLOG_MASK_PREFIX
 #define MLOG_MASK_PREFIX 0
 #endif
 
+/*
+ * When logging is disabled, force the bit test to 0 for anything other
+ * than errors and notices, allowing gcc to remove the code completely.
+ * When enabled, allow all masks.
+ */
+#if defined(CONFIG_OCFS2_DEBUG_MASKLOG)
+#define ML_ALLOWED_BITS ~0
+#else
+#define ML_ALLOWED_BITS (ML_ERROR|ML_NOTICE)
+#endif
+
 #define MLOG_MAX_BITS 64
 
 struct mlog_bits {
@@ -187,7 +198,8 @@ #define __mlog_printk(level, fmt, args..
 
 #define mlog(mask, fmt, args...) do {					\
 	u64 __m = MLOG_MASK_PREFIX | (mask);				\
-	if (__mlog_test_u64(__m, mlog_and_bits) &&			\
+	if ((__m & ML_ALLOWED_BITS) &&					\
+	    __mlog_test_u64(__m, mlog_and_bits) &&			\
 	    !__mlog_test_u64(__m, mlog_not_bits)) {			\
 		if (__m & ML_ERROR)					\
 			__mlog_printk(KERN_ERR, "ERROR: "fmt , ##args);	\
@@ -204,6 +216,7 @@ #define mlog_errno(st) do {						\
 		mlog(ML_ERROR, "status = %lld\n", (long long)_st);	\
 } while (0)
 
+#if defined(CONFIG_OCFS2_DEBUG_MASKLOG)
 #define mlog_entry(fmt, args...) do {					\
 	mlog(ML_ENTRY, "ENTRY:" fmt , ##args);				\
 } while (0)
@@ -247,6 +260,13 @@ #define mlog_exit_ptr(ptr) do {						\
 #define mlog_exit_void() do {						\
 	mlog(ML_EXIT, "EXIT\n");					\
 } while (0)
+#else
+#define mlog_entry(...)  do { } while (0)
+#define mlog_entry_void(...)  do { } while (0)
+#define mlog_exit(...)  do { } while (0)
+#define mlog_exit_ptr(...)  do { } while (0)
+#define mlog_exit_void(...)  do { } while (0)
+#endif  /* defined(CONFIG_OCFS2_DEBUG_MASKLOG) */
 
 #define mlog_bug_on_msg(cond, fmt, args...) do {			\
 	if (cond) {							\
diff --git a/fs/ocfs2/cluster/ocfs2_heartbeat.h b/fs/ocfs2/cluster/ocfs2_heartbeat.h
index 9409606..3f4151d 100644
--- a/fs/ocfs2/cluster/ocfs2_heartbeat.h
+++ b/fs/ocfs2/cluster/ocfs2_heartbeat.h
@@ -32,6 +32,7 @@ struct o2hb_disk_heartbeat_block {
 	__u8  hb_pad1[3];
 	__le32 hb_cksum;
 	__le64 hb_generation;
+	__le32 hb_dead_ms;
 };
 
 #endif /* _OCFS2_HEARTBEAT_H */
diff --git a/fs/ocfs2/cluster/tcp.c b/fs/ocfs2/cluster/tcp.c
index 1591eb3..b650efa 100644
--- a/fs/ocfs2/cluster/tcp.c
+++ b/fs/ocfs2/cluster/tcp.c
@@ -396,8 +396,8 @@ static void o2net_set_nn_state(struct o2
 	}
 
 	if (was_valid && !valid) {
-		mlog(ML_NOTICE, "no longer connected to " SC_NODEF_FMT "\n",
-		     SC_NODEF_ARGS(old_sc));
+		printk(KERN_INFO "o2net: no longer connected to "
+		       SC_NODEF_FMT "\n", SC_NODEF_ARGS(old_sc));
 		o2net_complete_nodes_nsw(nn);
 	}
 
@@ -409,10 +409,10 @@ static void o2net_set_nn_state(struct o2
 		 * the only way to start connecting again is to down
 		 * heartbeat and bring it back up. */
 		cancel_delayed_work(&nn->nn_connect_expired);
-		mlog(ML_NOTICE, "%s " SC_NODEF_FMT "\n", 
-		     o2nm_this_node() > sc->sc_node->nd_num ?
-		     	"connected to" : "accepted connection from",
-		     SC_NODEF_ARGS(sc));
+		printk(KERN_INFO "o2net: %s " SC_NODEF_FMT "\n",
+		       o2nm_this_node() > sc->sc_node->nd_num ?
+		       		"connected to" : "accepted connection from",
+		       SC_NODEF_ARGS(sc));
 	}
 
 	/* trigger the connecting worker func as long as we're not valid,
@@ -1280,7 +1280,7 @@ static void o2net_idle_timer(unsigned lo
 
 	do_gettimeofday(&now);
 
-	mlog(ML_NOTICE, "connection to " SC_NODEF_FMT " has been idle for 10 "
+	printk(KERN_INFO "o2net: connection to " SC_NODEF_FMT " has been idle for 10 "
 	     "seconds, shutting it down.\n", SC_NODEF_ARGS(sc));
 	mlog(ML_NOTICE, "here are some times that might help debug the "
 	     "situation: (tmr %ld.%ld now %ld.%ld dr %ld.%ld adv "
diff --git a/fs/ocfs2/dir.c b/fs/ocfs2/dir.c
index ae47f45..3d494d1 100644
--- a/fs/ocfs2/dir.c
+++ b/fs/ocfs2/dir.c
@@ -213,11 +213,9 @@ int ocfs2_find_files_on_disk(const char 
 			     struct ocfs2_dir_entry **dirent)
 {
 	int status = -ENOENT;
-	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
 
-	mlog_entry("(osb=%p, parent=%llu, name='%.*s', blkno=%p, inode=%p)\n",
-		   osb, (unsigned long long)OCFS2_I(inode)->ip_blkno,
-		   namelen, name, blkno, inode);
+	mlog_entry("(name=%.*s, blkno=%p, inode=%p, dirent_bh=%p, dirent=%p)\n",
+		   namelen, name, blkno, inode, dirent_bh, dirent);
 
 	*dirent_bh = ocfs2_find_entry(name, namelen, inode, dirent);
 	if (!*dirent_bh || !*dirent) {
diff --git a/fs/ocfs2/dlm/dlmcommon.h b/fs/ocfs2/dlm/dlmcommon.h
index 9bdc9cf..14530ee 100644
--- a/fs/ocfs2/dlm/dlmcommon.h
+++ b/fs/ocfs2/dlm/dlmcommon.h
@@ -822,8 +822,6 @@ int dlm_begin_reco_handler(struct o2net_
 int dlm_finalize_reco_handler(struct o2net_msg *msg, u32 len, void *data);
 int dlm_do_master_requery(struct dlm_ctxt *dlm, struct dlm_lock_resource *res,
 			  u8 nodenum, u8 *real_master);
-int dlm_lockres_master_requery(struct dlm_ctxt *dlm,
-			       struct dlm_lock_resource *res, u8 *real_master);
 
 
 int dlm_dispatch_assert_master(struct dlm_ctxt *dlm,
diff --git a/fs/ocfs2/dlm/dlmdomain.c b/fs/ocfs2/dlm/dlmdomain.c
index b8c23f7..8d1065f 100644
--- a/fs/ocfs2/dlm/dlmdomain.c
+++ b/fs/ocfs2/dlm/dlmdomain.c
@@ -408,12 +408,13 @@ static void __dlm_print_nodes(struct dlm
 
 	assert_spin_locked(&dlm->spinlock);
 
-	mlog(ML_NOTICE, "Nodes in my domain (\"%s\"):\n", dlm->name);
+	printk(KERN_INFO "ocfs2_dlm: Nodes in domain (\"%s\"): ", dlm->name);
 
 	while ((node = find_next_bit(dlm->domain_map, O2NM_MAX_NODES,
 				     node + 1)) < O2NM_MAX_NODES) {
-		mlog(ML_NOTICE, " node %d\n", node);
+		printk("%d ", node);
 	}
+	printk("\n");
 }
 
 static int dlm_exit_domain_handler(struct o2net_msg *msg, u32 len, void *data)
@@ -429,7 +430,7 @@ static int dlm_exit_domain_handler(struc
 
 	node = exit_msg->node_idx;
 
-	mlog(0, "Node %u leaves domain %s\n", node, dlm->name);
+	printk(KERN_INFO "ocfs2_dlm: Node %u leaves domain %s\n", node, dlm->name);
 
 	spin_lock(&dlm->spinlock);
 	clear_bit(node, dlm->domain_map);
@@ -678,6 +679,8 @@ static int dlm_assert_joined_handler(str
 		set_bit(assert->node_idx, dlm->domain_map);
 		__dlm_set_joining_node(dlm, DLM_LOCK_RES_OWNER_UNKNOWN);
 
+		printk(KERN_INFO "ocfs2_dlm: Node %u joins domain %s\n",
+		       assert->node_idx, dlm->name);
 		__dlm_print_nodes(dlm);
 
 		/* notify anything attached to the heartbeat events */
diff --git a/fs/ocfs2/dlm/dlmrecovery.c b/fs/ocfs2/dlm/dlmrecovery.c
index 29b2845..594745f 100644
--- a/fs/ocfs2/dlm/dlmrecovery.c
+++ b/fs/ocfs2/dlm/dlmrecovery.c
@@ -95,6 +95,9 @@ static void dlm_reco_unlock_ast(void *as
 static void dlm_request_all_locks_worker(struct dlm_work_item *item,
 					 void *data);
 static void dlm_mig_lockres_worker(struct dlm_work_item *item, void *data);
+static int dlm_lockres_master_requery(struct dlm_ctxt *dlm,
+				      struct dlm_lock_resource *res,
+				      u8 *real_master);
 
 static u64 dlm_get_next_mig_cookie(void);
 
@@ -1484,8 +1487,9 @@ leave:
 
 
 
-int dlm_lockres_master_requery(struct dlm_ctxt *dlm,
-			       struct dlm_lock_resource *res, u8 *real_master)
+static int dlm_lockres_master_requery(struct dlm_ctxt *dlm,
+				      struct dlm_lock_resource *res,
+				      u8 *real_master)
 {
 	struct dlm_node_iter iter;
 	int nodenum;
diff --git a/fs/ocfs2/dlmglue.c b/fs/ocfs2/dlmglue.c
index 4acd372..762eb1f 100644
--- a/fs/ocfs2/dlmglue.c
+++ b/fs/ocfs2/dlmglue.c
@@ -2071,8 +2071,7 @@ int ocfs2_dlm_init(struct ocfs2_super *o
 	}
 
 	/* launch vote thread */
-	osb->vote_task = kthread_run(ocfs2_vote_thread, osb, "ocfs2vote-%d",
-				     osb->osb_id);
+	osb->vote_task = kthread_run(ocfs2_vote_thread, osb, "ocfs2vote");
 	if (IS_ERR(osb->vote_task)) {
 		status = PTR_ERR(osb->vote_task);
 		osb->vote_task = NULL;
diff --git a/fs/ocfs2/extent_map.c b/fs/ocfs2/extent_map.c
index 1a5c690..fcd4475 100644
--- a/fs/ocfs2/extent_map.c
+++ b/fs/ocfs2/extent_map.c
@@ -298,7 +298,7 @@ static int ocfs2_extent_map_find_leaf(st
 
 		ret = ocfs2_extent_map_insert(inode, rec,
 					      le16_to_cpu(el->l_tree_depth));
-		if (ret) {
+		if (ret && (ret != -EEXIST)) {
 			mlog_errno(ret);
 			goto out_free;
 		}
@@ -427,6 +427,11 @@ static int ocfs2_extent_map_insert_entry
 /*
  * Simple rule: on any return code other than -EAGAIN, anything left
  * in the insert_context will be freed.
+ *
+ * Simple rule #2: A return code of -EEXIST from this function or
+ * its calls to ocfs2_extent_map_insert_entry() signifies that another
+ * thread beat us to the insert.  It is not an actual error, but it
+ * tells the caller we have no more work to do.
  */
 static int ocfs2_extent_map_try_insert(struct inode *inode,
 				       struct ocfs2_extent_rec *rec,
@@ -448,22 +453,32 @@ static int ocfs2_extent_map_try_insert(s
 		goto out_unlock;
 	}
 
+	/* Since insert_entry failed, the map MUST have old_ent */
 	old_ent = ocfs2_extent_map_lookup(em, le32_to_cpu(rec->e_cpos),
-					  le32_to_cpu(rec->e_clusters), NULL,
-					  NULL);
+					  le32_to_cpu(rec->e_clusters),
+					  NULL, NULL);
 
 	BUG_ON(!old_ent);
 
-	ret = -EEXIST;
-	if (old_ent->e_tree_depth < tree_depth)
+	if (old_ent->e_tree_depth < tree_depth) {
+		/* Another thread beat us to the lower tree_depth */
+		ret = -EEXIST;
 		goto out_unlock;
+	}
 
 	if (old_ent->e_tree_depth == tree_depth) {
+		/*
+		 * Another thread beat us to this tree_depth.
+		 * Let's make sure we agree with that thread (the
+		 * extent_rec should be identical).
+		 */
 		if (!memcmp(rec, &old_ent->e_rec,
 			    sizeof(struct ocfs2_extent_rec)))
 			ret = 0;
+		else
+			/* FIXME: Should this be ESRCH/EBADR??? */
+			ret = -EEXIST;
 
-		/* FIXME: Should this be ESRCH/EBADR??? */
 		goto out_unlock;
 	}
 
@@ -599,7 +614,7 @@ static int ocfs2_extent_map_insert(struc
 						  tree_depth, &ctxt);
 	} while (ret == -EAGAIN);
 
-	if (ret < 0)
+	if ((ret < 0) && (ret != -EEXIST))
 		mlog_errno(ret);
 
 	if (ctxt.left_ent)
diff --git a/fs/ocfs2/journal.c b/fs/ocfs2/journal.c
index 910a601..f92bf1d 100644
--- a/fs/ocfs2/journal.c
+++ b/fs/ocfs2/journal.c
@@ -784,8 +784,7 @@ int ocfs2_journal_load(struct ocfs2_jour
 	}
 
 	/* Launch the commit thread */
-	osb->commit_task = kthread_run(ocfs2_commit_thread, osb, "ocfs2cmt-%d",
-				       osb->osb_id);
+	osb->commit_task = kthread_run(ocfs2_commit_thread, osb, "ocfs2cmt");
 	if (IS_ERR(osb->commit_task)) {
 		status = PTR_ERR(osb->commit_task);
 		osb->commit_task = NULL;
@@ -1118,7 +1117,7 @@ void ocfs2_recovery_thread(struct ocfs2_
 		goto out;
 
 	osb->recovery_thread_task =  kthread_run(__ocfs2_recovery_thread, osb,
-						 "ocfs2rec-%d", osb->osb_id);
+						 "ocfs2rec");
 	if (IS_ERR(osb->recovery_thread_task)) {
 		mlog_errno((int)PTR_ERR(osb->recovery_thread_task));
 		osb->recovery_thread_task = NULL;
diff --git a/fs/ocfs2/mmap.c b/fs/ocfs2/mmap.c
index 843cf9d..83934e3 100644
--- a/fs/ocfs2/mmap.c
+++ b/fs/ocfs2/mmap.c
@@ -46,12 +46,12 @@ static struct page *ocfs2_nopage(struct 
 				 unsigned long address,
 				 int *type)
 {
-	struct inode *inode = area->vm_file->f_dentry->d_inode;
 	struct page *page = NOPAGE_SIGBUS;
 	sigset_t blocked, oldset;
 	int ret;
 
-	mlog_entry("(inode %lu, address %lu)\n", inode->i_ino, address);
+	mlog_entry("(area=%p, address=%lu, type=%p)\n", area, address,
+		   type);
 
 	/* The best way to deal with signals in this path is
 	 * to block them upfront, rather than allowing the
diff --git a/fs/ocfs2/ocfs2.h b/fs/ocfs2/ocfs2.h
index da10930..cd4a6f2 100644
--- a/fs/ocfs2/ocfs2.h
+++ b/fs/ocfs2/ocfs2.h
@@ -184,7 +184,6 @@ struct ocfs2_journal;
 struct ocfs2_journal_handle;
 struct ocfs2_super
 {
-	u32 osb_id;		/* id used by the proc interface */
 	struct task_struct *commit_task;
 	struct super_block *sb;
 	struct inode *root_inode;
@@ -222,13 +221,11 @@ struct ocfs2_super
 	unsigned long s_mount_opt;
 
 	u16 max_slots;
-	u16 num_nodes;
 	s16 node_num;
 	s16 slot_num;
 	int s_sectsize_bits;
 	int s_clustersize;
 	int s_clustersize_bits;
-	struct proc_dir_entry *proc_sub_dir; /* points to /proc/fs/ocfs2/<maj_min> */
 
 	atomic_t vol_state;
 	struct mutex recovery_lock;
@@ -294,7 +291,6 @@ struct ocfs2_super
 };
 
 #define OCFS2_SB(sb)	    ((struct ocfs2_super *)(sb)->s_fs_info)
-#define OCFS2_MAX_OSB_ID             65536
 
 static inline int ocfs2_should_order_data(struct inode *inode)
 {
diff --git a/fs/ocfs2/slot_map.c b/fs/ocfs2/slot_map.c
index 8716279..aa6f5aa 100644
--- a/fs/ocfs2/slot_map.c
+++ b/fs/ocfs2/slot_map.c
@@ -264,7 +264,7 @@ int ocfs2_find_slot(struct ocfs2_super *
 	osb->slot_num = slot;
 	spin_unlock(&si->si_lock);
 
-	mlog(ML_NOTICE, "taking node slot %d\n", osb->slot_num);
+	mlog(0, "taking node slot %d\n", osb->slot_num);
 
 	status = ocfs2_update_disk_slots(osb, si);
 	if (status < 0)
diff --git a/fs/ocfs2/super.c b/fs/ocfs2/super.c
index cdf7339..382706a 100644
--- a/fs/ocfs2/super.c
+++ b/fs/ocfs2/super.c
@@ -68,13 +68,6 @@ #include "vote.h"
 
 #include "buffer_head_io.h"
 
-/*
- * Globals
- */
-static spinlock_t ocfs2_globals_lock = SPIN_LOCK_UNLOCKED;
-
-static u32 osb_id;             /* Keeps track of next available OSB Id */
-
 static kmem_cache_t *ocfs2_inode_cachep = NULL;
 
 kmem_cache_t *ocfs2_lock_cache = NULL;
@@ -642,10 +635,9 @@ static int ocfs2_fill_super(struct super
 
 	ocfs2_complete_mount_recovery(osb);
 
-	printk("ocfs2: Mounting device (%u,%u) on (node %d, slot %d) with %s "
-	       "data mode.\n",
-	       MAJOR(sb->s_dev), MINOR(sb->s_dev), osb->node_num,
-	       osb->slot_num,
+	printk(KERN_INFO "ocfs2: Mounting device (%s) on (node %d, slot %d) "
+	       "with %s data mode.\n",
+	       osb->dev_str, osb->node_num, osb->slot_num,
 	       osb->s_mount_opt & OCFS2_MOUNT_DATA_WRITEBACK ? "writeback" :
 	       "ordered");
 
@@ -800,10 +792,6 @@ static int __init ocfs2_init(void)
 		goto leave;
 	}
 
-	spin_lock(&ocfs2_globals_lock);
-	osb_id = 0;
-	spin_unlock(&ocfs2_globals_lock);
-
 	ocfs2_debugfs_root = debugfs_create_dir("ocfs2", NULL);
 	if (!ocfs2_debugfs_root) {
 		status = -EFAULT;
@@ -1020,7 +1008,7 @@ static int ocfs2_fill_local_node_info(st
 		goto bail;
 	}
 
-	mlog(ML_NOTICE, "I am node %d\n", osb->node_num);
+	mlog(0, "I am node %d\n", osb->node_num);
 
 	status = 0;
 bail:
@@ -1191,8 +1179,8 @@ static void ocfs2_dismount_volume(struct
 
 	atomic_set(&osb->vol_state, VOLUME_DISMOUNTED);
 
-	printk("ocfs2: Unmounting device (%u,%u) on (node %d)\n",
-	       MAJOR(osb->sb->s_dev), MINOR(osb->sb->s_dev), osb->node_num);
+	printk(KERN_INFO "ocfs2: Unmounting device (%s) on (node %d)\n",
+	       osb->dev_str, osb->node_num);
 
 	ocfs2_delete_osb(osb);
 	kfree(osb);
@@ -1212,8 +1200,6 @@ static int ocfs2_setup_osb_uuid(struct o
 	if (osb->uuid_str == NULL)
 		return -ENOMEM;
 
-	memcpy(osb->uuid, uuid, OCFS2_VOL_UUID_LEN);
-
 	for (i = 0, ptr = osb->uuid_str; i < OCFS2_VOL_UUID_LEN; i++) {
 		/* print with null */
 		ret = snprintf(ptr, 3, "%02X", uuid[i]);
@@ -1311,13 +1297,6 @@ static int ocfs2_initialize_super(struct
 		goto bail;
 	}
 
-	osb->uuid = kmalloc(OCFS2_VOL_UUID_LEN, GFP_KERNEL);
-	if (!osb->uuid) {
-		mlog(ML_ERROR, "unable to alloc uuid\n");
-		status = -ENOMEM;
-		goto bail;
-	}
-
 	di = (struct ocfs2_dinode *)bh->b_data;
 
 	osb->max_slots = le16_to_cpu(di->id2.i_super.s_max_slots);
@@ -1327,7 +1306,7 @@ static int ocfs2_initialize_super(struct
 		status = -EINVAL;
 		goto bail;
 	}
-	mlog(ML_NOTICE, "max_slots for this device: %u\n", osb->max_slots);
+	mlog(0, "max_slots for this device: %u\n", osb->max_slots);
 
 	init_waitqueue_head(&osb->osb_wipe_event);
 	osb->osb_orphan_wipes = kcalloc(osb->max_slots,
@@ -1418,7 +1397,7 @@ static int ocfs2_initialize_super(struct
 		goto bail;
 	}
 
-	memcpy(&uuid_net_key, &osb->uuid[i], sizeof(osb->net_key));
+	memcpy(&uuid_net_key, di->id2.i_super.s_uuid, sizeof(uuid_net_key));
 	osb->net_key = le32_to_cpu(uuid_net_key);
 
 	strncpy(osb->vol_label, di->id2.i_super.s_label, 63);
@@ -1484,18 +1463,6 @@ static int ocfs2_initialize_super(struct
 		goto bail;
 	}
 
-	/*  Link this osb onto the global linked list of all osb structures. */
-	/*  The Global Link List is mainted for the whole driver . */
-	spin_lock(&ocfs2_globals_lock);
-	osb->osb_id = osb_id;
-	if (osb_id < OCFS2_MAX_OSB_ID)
-		osb_id++;
-	else {
-		mlog(ML_ERROR, "Too many volumes mounted\n");
-		status = -ENOMEM;
-	}
-	spin_unlock(&ocfs2_globals_lock);
-
 bail:
 	mlog_exit(status);
 	return status;
diff --git a/fs/ocfs2/symlink.c b/fs/ocfs2/symlink.c
index 0c8a129..c0f68aa 100644
--- a/fs/ocfs2/symlink.c
+++ b/fs/ocfs2/symlink.c
@@ -154,7 +154,7 @@ static void *ocfs2_follow_link(struct de
 	}
 
 	status = vfs_follow_link(nd, link);
-	if (status)
+	if (status && status != -ENOENT)
 		mlog_errno(status);
 bail:
 	if (page) {
