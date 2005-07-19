Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261211AbVGSOPb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261211AbVGSOPb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Jul 2005 10:15:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261330AbVGSOPb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Jul 2005 10:15:31 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:1545 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261211AbVGSOP3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Jul 2005 10:15:29 -0400
Date: Tue, 19 Jul 2005 16:15:25 +0200
From: Adrian Bunk <bunk@stusta.de>
To: sct@redhat.com, adilger@clusterfs.com, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, ext3-users@redhat.com
Subject: [2.6 patch] fs/jbd/: cleanups
Message-ID: <20050719141525.GJ5031@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following cleanups:
- make needlessly global functions static
- journal.c: remove the unused global function __journal_internal_check
             and move the check to journal_init
- remove the following write-only global variable:
  - journal.c: current_journal
- remove the following unneeded EXPORT_SYMBOL:
  - journal.c: journal_recover

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 fs/jbd/journal.c    |   34 ++++++++++++++--------------------
 fs/jbd/revoke.c     |    3 ++-
 include/linux/jbd.h |    1 -
 3 files changed, 16 insertions(+), 22 deletions(-)

--- linux-2.6.12-rc6-mm1-full/include/linux/jbd.h.old	2005-06-14 03:58:20.000000000 +0200
+++ linux-2.6.12-rc6-mm1-full/include/linux/jbd.h	2005-06-14 04:00:56.000000000 +0200
@@ -914,7 +912,6 @@
 extern int	   journal_skip_recovery	(journal_t *);
 extern void	   journal_update_superblock	(journal_t *, int);
 extern void	   __journal_abort_hard	(journal_t *);
-extern void	   __journal_abort_soft	(journal_t *, int);
 extern void	   journal_abort      (journal_t *, int);
 extern int	   journal_errno      (journal_t *);
 extern void	   journal_ack_err    (journal_t *);
--- linux-2.6.12-rc6-mm1-full/fs/jbd/revoke.c.old	2005-06-14 03:58:36.000000000 +0200
+++ linux-2.6.12-rc6-mm1-full/fs/jbd/revoke.c	2005-06-14 03:58:41.000000000 +0200
@@ -116,7 +116,8 @@
 		(block << (hash_shift - 12))) & (table->hash_size - 1);
 }
 
-int insert_revoke_hash(journal_t *journal, unsigned long blocknr, tid_t seq)
+static int insert_revoke_hash(journal_t *journal, unsigned long blocknr,
+			      tid_t seq)
 {
 	struct list_head *hash_list;
 	struct jbd_revoke_record_s *record;

--- linux-2.6.13-rc3-mm1-full/fs/jbd/journal.c.old	2005-07-19 15:53:16.000000000 +0200
+++ linux-2.6.13-rc3-mm1-full/fs/jbd/journal.c	2005-07-19 15:53:39.000000000 +0200
@@ -65,7 +65,6 @@ EXPORT_SYMBOL(journal_set_features);
 EXPORT_SYMBOL(journal_create);
 EXPORT_SYMBOL(journal_load);
 EXPORT_SYMBOL(journal_destroy);
-EXPORT_SYMBOL(journal_recover);
 EXPORT_SYMBOL(journal_update_superblock);
 EXPORT_SYMBOL(journal_abort);
 EXPORT_SYMBOL(journal_errno);
@@ -81,6 +80,7 @@ EXPORT_SYMBOL(journal_try_to_free_buffer
 EXPORT_SYMBOL(journal_force_commit);
 
 static int journal_convert_superblock_v1(journal_t *, journal_superblock_t *);
+static void __journal_abort_soft (journal_t *journal, int errno);
 
 /*
  * Helper function used to manage commit timeouts
@@ -93,16 +93,6 @@ static void commit_timeout(unsigned long
 	wake_up_process(p);
 }
 
-/* Static check for data structure consistency.  There's no code
- * invoked --- we'll just get a linker failure if things aren't right.
- */
-void __journal_internal_check(void)
-{
-	extern void journal_bad_superblock_size(void);
-	if (sizeof(struct journal_superblock_s) != 1024)
-		journal_bad_superblock_size();
-}
-
 /*
  * kjournald: The main thread function used to manage a logging device
  * journal.
@@ -119,16 +109,12 @@ void __journal_internal_check(void)
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
@@ -1441,7 +1427,7 @@ int journal_wipe(journal_t *journal, int
  * device this journal is present.
  */
 
-const char *journal_dev_name(journal_t *journal, char *buffer)
+static const char *journal_dev_name(journal_t *journal, char *buffer)
 {
 	struct block_device *bdev;
 
@@ -1487,7 +1473,7 @@ void __journal_abort_hard(journal_t *jou
 
 /* Soft abort: record the abort error status in the journal superblock,
  * but don't do any other IO. */
-void __journal_abort_soft (journal_t *journal, int errno)
+static void __journal_abort_soft (journal_t *journal, int errno)
 {
 	if (journal->j_flags & JFS_ABORT)
 		return;
@@ -1890,7 +1876,7 @@ EXPORT_SYMBOL(journal_enable_debug);
 
 static struct proc_dir_entry *proc_jbd_debug;
 
-int read_jbd_debug(char *page, char **start, off_t off,
+static int read_jbd_debug(char *page, char **start, off_t off,
 			  int count, int *eof, void *data)
 {
 	int ret;
@@ -1900,7 +1886,7 @@ int read_jbd_debug(char *page, char **st
 	return ret;
 }
 
-int write_jbd_debug(struct file *file, const char __user *buffer,
+static int write_jbd_debug(struct file *file, const char __user *buffer,
 			   unsigned long count, void *data)
 {
 	char buf[32];
@@ -1989,6 +1975,14 @@ static int __init journal_init(void)
 {
 	int ret;
 
+/* Static check for data structure consistency.  There's no code
+ * invoked --- we'll just get a linker failure if things aren't right.
+ */
+	extern void journal_bad_superblock_size(void);
+	if (sizeof(struct journal_superblock_s) != 1024)
+		journal_bad_superblock_size();
+
+
 	ret = journal_init_caches();
 	if (ret != 0)
 		journal_destroy_caches();
