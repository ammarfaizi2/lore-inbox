Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262806AbSJaQAe>; Thu, 31 Oct 2002 11:00:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262799AbSJaP77>; Thu, 31 Oct 2002 10:59:59 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:32519 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S262795AbSJaP72>; Thu, 31 Oct 2002 10:59:28 -0500
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15809.21553.465056.374030@laputa.namesys.com>
Date: Thu, 31 Oct 2002 19:02:57 +0300
X-PGP-Fingerprint: 43CE 9384 5A1D CD75 5087  A876 A1AA 84D0 CCAA AC92
X-PGP-Key-ID: CCAAAC92
X-PGP-Key-At: http://wwwkeys.pgp.net:11371/pks/lookup?op=get&search=0xCCAAAC92
To: Linus Torvalds <Torvalds@Transmeta.COM>
Cc: Linux Kernel Mailing List <Linux-Kernel@Vger.Kernel.ORG>,
       Reiserfs mail-list <Reiserfs-List@Namesys.COM>
Subject: [PATCH]: reiser4 [6/8] share ->journal_info
X-Mailer: VM 7.07 under 21.5  (beta6) "bok choi" XEmacs Lucid
X-Windows: even your dog won't like it.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Linus,

    this patch changes declaration of ->journal_info in the struct
    task_struct and updates the only user (ext3) correspondingly.

    ->journal_info is supposed to hold some file system data per-thread
    per-file-system-invocation. Problem is that it is possible (through
    VM call backs or page faults, for example) for invocations of file
    system drivers to nest. This patch changes ->journal_info from void*
    to a pointer to the struct fs_activation. struct fs_activation
    contains only one field ->owner: it can be used by file system to
    tell whether it can continue within given "parent" context:
    generally journalling file system cannot be called from within
    different journalling file system, because of deadlocks.

    struct fs_activation will be usually embedded into some file system
    specific object (like transaction handle for ext3, or
    reiser4_context for, well, reiser4) and it is file system
    responsibility to save original value of ->journal_info on entry and
    restore it on exit.

    Also, ->journal_info is renamed to less specific ->fs_context.

    Thanks to Stephen Tweedie for useful comments.

Please apply.
Nikita.
diff -rup -X dontdiff linus-bk-2.5/fs/jbd/transaction.c linux-2.5-reiser4/fs/jbd/transaction.c
--- linus-bk-2.5/fs/jbd/transaction.c	Tue Oct 15 20:56:59 2002
+++ linux-2.5-reiser4/fs/jbd/transaction.c	Mon Oct 21 13:43:51 2002
@@ -101,6 +101,7 @@ static int start_this_handle(journal_t *
 
 	jbd_debug(3, "New handle %p going live.\n", handle);
 
+	handle->h_journal = journal;
 repeat:
 
 	lock_journal(journal);
@@ -223,6 +224,23 @@ static handle_t *new_handle(int nblocks)
 }
 
 /*
+ * push @handle into ->fs_context stack
+ */
+static void push_handle(handle_t *handle)
+{
+	handle->h_parent = current->fs_context;
+	current->fs_context = (struct fs_activation *) handle;
+}
+
+/*
+ * pop top of ->fs_context stack
+ */
+static void pop_handle(handle_t *handle)
+{
+	current->fs_context = (struct fs_activation *) handle->h_parent;
+}
+
+/*
  * Obtain a new handle.  
  *
  * We make sure that the transaction can guarantee at least nblocks of
@@ -243,7 +261,7 @@ handle_t *journal_start(journal_t *journ
 	if (!journal)
 		return ERR_PTR(-EROFS);
 
-	if (handle) {
+	if (handle && handle->h_journal == journal) {
 		J_ASSERT(handle->h_transaction->t_journal == journal);
 		handle->h_ref++;
 		return handle;
@@ -253,12 +271,12 @@ handle_t *journal_start(journal_t *journ
 	if (!handle)
 		return ERR_PTR(-ENOMEM);
 
-	current->journal_info = handle;
+	push_handle(handle);
 
 	err = start_this_handle(journal, handle);
 	if (err < 0) {
+		pop_handle(handle);
 		kfree(handle);
-		current->journal_info = NULL;
 		return ERR_PTR(err);
 	}
 
@@ -336,7 +354,7 @@ handle_t *journal_try_start(journal_t *j
 	if (!journal)
 		return ERR_PTR(-EROFS);
 
-	if (handle) {
+	if (handle && handle->h_journal == journal) {
 		jbd_debug(4, "h_ref %d -> %d\n",
 				handle->h_ref,
 				handle->h_ref + 1);
@@ -356,12 +374,12 @@ handle_t *journal_try_start(journal_t *j
 	if (!handle)
 		return ERR_PTR(-ENOMEM);
 
-	current->journal_info = handle;
+	push_handle(handle);
 
 	err = try_start_this_handle(journal, handle);
 	if (err < 0) {
+		pop_handle(handle);
 		kfree(handle);
-		current->journal_info = NULL;
 		return ERR_PTR(err);
 	}
 
@@ -1441,7 +1459,7 @@ int journal_stop(handle_t *handle)
 		} while (old_handle_count != transaction->t_handle_count);
 	}
 
-	current->journal_info = NULL;
+	pop_handle(handle);
 	transaction->t_outstanding_credits -= handle->h_buffer_credits;
 	transaction->t_updates--;
 	if (!transaction->t_updates) {
diff -rup -X dontdiff linus-bk-2.5/include/linux/init_task.h linux-2.5-reiser4/include/linux/init_task.h
--- linus-bk-2.5/include/linux/init_task.h	Tue Oct 15 20:57:02 2002
+++ linux-2.5-reiser4/include/linux/init_task.h	Mon Oct 21 13:43:57 2002
@@ -95,7 +95,7 @@
 	.blocked	= {{0}},					\
 	.alloc_lock	= SPIN_LOCK_UNLOCKED,				\
 	.switch_lock	= SPIN_LOCK_UNLOCKED,				\
-	.journal_info	= NULL,						\
+	.fs_context	= NULL,				\
 }
 
 
diff -rup -X dontdiff linus-bk-2.5/include/linux/jbd.h linux-2.5-reiser4/include/linux/jbd.h
--- linus-bk-2.5/include/linux/jbd.h	Tue Oct 15 20:57:02 2002
+++ linux-2.5-reiser4/include/linux/jbd.h	Mon Oct 21 13:43:58 2002
@@ -274,6 +274,14 @@ struct jbd_revoke_table_s;
 
 struct handle_s 
 {
+	/* Which journal this handle belongs to.  This has to be first
+	 * field, because current->fs_context points here. */
+	journal_t             * h_journal;
+
+	/* Previous file system context. NULL if we are top-most
+	 * call. */
+	struct fs_activation  * h_parent;
+
 	/* Which compound transaction is this update a part of? */
 	transaction_t	      * h_transaction;
 
@@ -637,7 +645,7 @@ static inline void unlock_journal(journa
 
 static inline handle_t *journal_current_handle(void)
 {
-	return current->journal_info;
+	return (handle_t*) current->fs_context;
 }
 
 /* The journaling code user interface:
diff -rup -X dontdiff linus-bk-2.5/include/linux/sched.h linux-2.5-reiser4/include/linux/sched.h
--- linus-bk-2.5/include/linux/sched.h	Sat Oct 19 03:01:12 2002
+++ linux-2.5-reiser4/include/linux/sched.h	Mon Oct 21 13:43:58 2002
@@ -268,6 +268,24 @@ extern struct user_struct root_user;
 typedef struct prio_array prio_array_t;
 struct backing_dev_info;
 
+/*
+ * Some file systems need context associated with current thread during
+ * one system call (transaction handle, for example). This context in
+ * attached to current->fs_context.
+ *
+ * As it is possible for file system calls to nest (through quota of VM
+ * call backs), every file system using current->fs_context should store
+ * original ->fs_context value of entrance and restore in on exit.
+ */
+struct fs_activation {
+	/*
+	 * cookie allowing to distinguish file system instances
+	 * (mounts). Usually this is pointer to the super block, but not
+	 * necessary. This is used to tell reentrance.
+	 */
+	void *owner;
+};
+
 struct task_struct {
 	volatile long state;	/* -1 unrunnable, 0 runnable, >0 stopped */
 	struct thread_info *thread_info;
@@ -387,8 +405,8 @@ struct task_struct {
 /* context-switch lock */
 	spinlock_t switch_lock;
 
-/* journalling filesystem info */
-	void *journal_info;
+/* info about current file system activation */
+	struct fs_activation *fs_context;
 	struct dentry *proc_dentry;
 	struct backing_dev_info *backing_dev_info;
 };
