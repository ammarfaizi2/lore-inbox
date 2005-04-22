Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261353AbVDVX6n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261353AbVDVX6n (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Apr 2005 19:58:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261357AbVDVX6n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Apr 2005 19:58:43 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:16145 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261353AbVDVX5T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Apr 2005 19:57:19 -0400
Date: Sat, 23 Apr 2005 01:57:17 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, sct@redhat.com, adilger@clusterfs.com
Cc: linux-kernel@vger.kernel.org, ext3-users@redhat.com
Subject: [2.6 patch] fs/jbd/: possible cleanups
Message-ID: <20050422235717.GI4355@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following possible cleanups:
- make needlessly global functions static
- #if 0 the following unused global functions:
  - journal.c: __journal_internal_check
  - journal.c: journal_ack_err
- remove the following write-only global variable:
  - journal.c: current_journal
- remove the following unneeded EXPORT_SYMBOL's:
  - journal.c: journal_check_used_features
  - journal.c: journal_recover
  - journal.c: journal_ack_err

Please check which of these changes do make sense.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 fs/jbd/journal.c    |   28 ++++++++++++++--------------
 fs/jbd/revoke.c     |    3 ++-
 include/linux/jbd.h |    4 ----
 3 files changed, 16 insertions(+), 19 deletions(-)

--- linux-2.6.12-rc2-mm3-full/include/linux/jbd.h.old	2005-04-21 03:39:15.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/include/linux/jbd.h	2005-04-21 03:43:21.000000000 +0200
@@ -900,8 +900,6 @@
 				int start, int len, int bsize);
 extern journal_t * journal_init_inode (struct inode *);
 extern int	   journal_update_format (journal_t *);
-extern int	   journal_check_used_features 
-		   (journal_t *, unsigned long, unsigned long, unsigned long);
 extern int	   journal_check_available_features 
 		   (journal_t *, unsigned long, unsigned long, unsigned long);
 extern int	   journal_set_features 
@@ -914,10 +912,8 @@
 extern int	   journal_skip_recovery	(journal_t *);
 extern void	   journal_update_superblock	(journal_t *, int);
 extern void	   __journal_abort_hard	(journal_t *);
-extern void	   __journal_abort_soft	(journal_t *, int);
 extern void	   journal_abort      (journal_t *, int);
 extern int	   journal_errno      (journal_t *);
-extern void	   journal_ack_err    (journal_t *);
 extern int	   journal_clear_err  (journal_t *);
 extern int	   journal_bmap(journal_t *, unsigned long, unsigned long *);
 extern int	   journal_force_commit(journal_t *);
--- linux-2.6.12-rc2-mm3-full/fs/jbd/journal.c.old	2005-04-21 03:39:53.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/fs/jbd/journal.c	2005-04-21 03:45:07.000000000 +0200
@@ -59,17 +59,14 @@
 EXPORT_SYMBOL(journal_init_dev);
 EXPORT_SYMBOL(journal_init_inode);
 EXPORT_SYMBOL(journal_update_format);
-EXPORT_SYMBOL(journal_check_used_features);
 EXPORT_SYMBOL(journal_check_available_features);
 EXPORT_SYMBOL(journal_set_features);
 EXPORT_SYMBOL(journal_create);
 EXPORT_SYMBOL(journal_load);
 EXPORT_SYMBOL(journal_destroy);
-EXPORT_SYMBOL(journal_recover);
 EXPORT_SYMBOL(journal_update_superblock);
 EXPORT_SYMBOL(journal_abort);
 EXPORT_SYMBOL(journal_errno);
-EXPORT_SYMBOL(journal_ack_err);
 EXPORT_SYMBOL(journal_clear_err);
 EXPORT_SYMBOL(log_wait_commit);
 EXPORT_SYMBOL(journal_start_commit);
@@ -81,6 +78,7 @@
 EXPORT_SYMBOL(journal_force_commit);
 
 static int journal_convert_superblock_v1(journal_t *, journal_superblock_t *);
+static void __journal_abort_soft (journal_t *journal, int errno);
 
 /*
  * Helper function used to manage commit timeouts
@@ -96,12 +94,14 @@
 /* Static check for data structure consistency.  There's no code
  * invoked --- we'll just get a linker failure if things aren't right.
  */
+#if 0
 void __journal_internal_check(void)
 {
 	extern void journal_bad_superblock_size(void);
 	if (sizeof(struct journal_superblock_s) != 1024)
 		journal_bad_superblock_size();
 }
+#endif  /*  0  */
 
 /*
  * kjournald: The main thread function used to manage a logging device
@@ -119,16 +119,12 @@
  *    known as checkpointing, and this thread is responsible for that job.
  */
 
-journal_t *current_journal;		// AKPM: debug
-
-int kjournald(void *arg)
+static int kjournald(void *arg)
 {
 	journal_t *journal = (journal_t *) arg;
 	transaction_t *transaction;
 	struct timer_list timer;
 
-	current_journal = journal;
-
 	daemonize("kjournald");
 
 	/* Set up an interval timer which can be used to trigger a
@@ -1181,8 +1177,10 @@
  * features.  Return true (non-zero) if it does. 
  **/
 
-int journal_check_used_features (journal_t *journal, unsigned long compat,
-				 unsigned long ro, unsigned long incompat)
+static int journal_check_used_features (journal_t *journal,
+					unsigned long compat,
+					unsigned long ro,
+					unsigned long incompat)
 {
 	journal_superblock_t *sb;
 
@@ -1439,7 +1437,7 @@
  * device this journal is present.
  */
 
-const char *journal_dev_name(journal_t *journal, char *buffer)
+static const char *journal_dev_name(journal_t *journal, char *buffer)
 {
 	struct block_device *bdev;
 
@@ -1485,7 +1483,7 @@
 
 /* Soft abort: record the abort error status in the journal superblock,
  * but don't do any other IO. */
-void __journal_abort_soft (journal_t *journal, int errno)
+static void __journal_abort_soft (journal_t *journal, int errno)
 {
 	if (journal->j_flags & JFS_ABORT)
 		return;
@@ -1601,6 +1599,7 @@
  * An error must be cleared or Acked to take a FS out of readonly
  * mode.
  */
+#if 0
 void journal_ack_err(journal_t *journal)
 {
 	spin_lock(&journal->j_state_lock);
@@ -1608,6 +1607,7 @@
 		journal->j_flags |= JFS_ACK_ERR;
 	spin_unlock(&journal->j_state_lock);
 }
+#endif  /*  0  */
 
 int journal_blocks_per_page(struct inode *inode)
 {
@@ -1888,7 +1888,7 @@
 
 static struct proc_dir_entry *proc_jbd_debug;
 
-int read_jbd_debug(char *page, char **start, off_t off,
+static int read_jbd_debug(char *page, char **start, off_t off,
 			  int count, int *eof, void *data)
 {
 	int ret;
@@ -1898,7 +1898,7 @@
 	return ret;
 }
 
-int write_jbd_debug(struct file *file, const char __user *buffer,
+static int write_jbd_debug(struct file *file, const char __user *buffer,
 			   unsigned long count, void *data)
 {
 	char buf[32];
--- linux-2.6.12-rc2-mm3-full/fs/jbd/revoke.c.old	2005-04-21 03:44:18.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/fs/jbd/revoke.c	2005-04-21 03:44:31.000000000 +0200
@@ -116,7 +116,8 @@
 		(block << (hash_shift - 12))) & (table->hash_size - 1);
 }
 
-int insert_revoke_hash(journal_t *journal, unsigned long blocknr, tid_t seq)
+static int insert_revoke_hash(journal_t *journal, unsigned long blocknr,
+			      tid_t seq)
 {
 	struct list_head *hash_list;
 	struct jbd_revoke_record_s *record;


