Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261300AbUDIWDU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Apr 2004 18:03:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261500AbUDIWDU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Apr 2004 18:03:20 -0400
Received: from [217.73.129.129] ([217.73.129.129]:4328 "EHLO linuxhacker.ru")
	by vger.kernel.org with ESMTP id S261300AbUDIWDE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Apr 2004 18:03:04 -0400
Date: Sat, 10 Apr 2004 01:02:38 +0300
Message-Id: <200404092202.i39M2c97012940@car.linuxhacker.ru>
From: Oleg Drokin <green@linuxhacker.ru>
Subject: Re: [PATCH] reiserfs v3 fixes and features
To: mason@suse.com, umka@namesys.com, linux-kernel@vger.kernel.org
References: <1081274618.30828.30.camel@watt.suse.com> <1081343178.3042.2.camel@firefly> <1081344323.30829.534.camel@watt.suse.com> <1081408913.3030.23.camel@firefly>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yury Umanets <umka@namesys.com> wrote:
>> > That would be nice to have also improved locking in this
>> > features-improvements-fixes patch set. Ask Oleg, he had intention to
>> > work on and probably has something done already.
>> I'm assuming you mean getting rid of the BKL, which would be really
>> nice. 
YU> yes
>>  I'd like to get the current patchset stabilized and in the
>> kernel, but even moving to a per fs spin lock instead of the bkl would
>> be a welcome change.
YU> Last time we have discussed this with Oleg, he said, that there are lots
YU> of stuff relying on the fact, that bkl can be acquired many times by the
YU> same process. And simple replacing bkl by per-superblock lock makes life
YU> just horrible ;)
YU> There something like bkl but per-superblock based is needed. Or lots of
YU> code should be changed, which is not good idea.
YU> But anyway, this should be done one day, and if I have free time
YU> (probably vacation) and it will not be done until that time, I'd like to
YU> work on it along with Oleg and you ;)

Well, I have put some work into having real per-fs spinlock in
September/October last year, but it turned to be enormous amount of work
shuffling locks around indeed.
But recently I came across bkl-alike lock implementation in lustre filesystem
and I think similar thing would make perfect sence for reiserfs v3 on
SMP today as some start.
You may find patch below that imports that sort of lock from lustre
(of course I know Hans would not accept it because it is GPL at least),
which is good thing to get at least some testing and justify how much
benefit this would get us before putting more work in that direction.
Patch is against 2.6.4 (though 2.4 would be trivial to do as well).
I only tested it on UP (with spinlock debug enabled so that spinlocks
work a bit) since SMP in 2.6 uml is not working yet it seems.
But I think it should just basically work (and I do not have real
SMP test system anyway so perhaps you Chris can do me a favour and run some
tests with this patch on some real SMP box?).
I hope this time some real progress will be made before I forget about it again.

Bye,
    Oleg

===== fs/reiserfs/dir.c 1.20 vs edited =====
--- 1.20/fs/reiserfs/dir.c	Mon May 26 00:07:50 2003
+++ edited/fs/reiserfs/dir.c	Sat Apr 10 00:19:36 2004
@@ -54,7 +54,7 @@
 
     reiserfs_write_lock(inode->i_sb);
 
-    reiserfs_check_lock_depth("readdir") ;
+    reiserfs_check_lock_depth(inode->i_sb, "readdir") ;
 
     /* form key for search the next directory entry using f_pos field of
        file structure */
===== fs/reiserfs/journal.c 1.78 vs edited =====
--- 1.78/fs/reiserfs/journal.c	Thu Feb 19 05:42:22 2004
+++ edited/fs/reiserfs/journal.c	Sat Apr 10 00:21:12 2004
@@ -328,7 +328,7 @@
 static struct reiserfs_journal_cnode *get_cnode(struct super_block *p_s_sb) {
   struct reiserfs_journal_cnode *cn ;
 
-  reiserfs_check_lock_depth("get_cnode") ;
+  reiserfs_check_lock_depth(p_s_sb, "get_cnode") ;
 
   if (SB_JOURNAL(p_s_sb)->j_cnode_free <= 0) {
     return NULL ;
@@ -352,7 +352,7 @@
 */
 static void free_cnode(struct super_block *p_s_sb, struct reiserfs_journal_cnode *cn) {
 
-  reiserfs_check_lock_depth("free_cnode") ;
+  reiserfs_check_lock_depth(p_s_sb, "free_cnode") ;
 
   SB_JOURNAL(p_s_sb)->j_cnode_used-- ;
   SB_JOURNAL(p_s_sb)->j_cnode_free++ ;
@@ -404,9 +404,9 @@
 /* utility function to force a BUG if it is called without the big
 ** kernel lock held.  caller is the string printed just before calling BUG()
 */
-void reiserfs_check_lock_depth(char *caller) {
+void reiserfs_check_lock_depth(struct super_block *sb, char *caller) {
 #ifdef CONFIG_SMP
-  if (current->lock_depth < 0) {
+  if (!rsb_has_lock(sb)) {
     printk("%s called without kernel lock held\n", caller) ;
     show_reiserfs_locks() ;
     BUG() ;
@@ -619,7 +619,7 @@
   struct buffer_head *tbh = NULL ;
   struct reiserfs_journal_list *other_jl ;
 
-  reiserfs_check_lock_depth("flush_commit_list") ;
+  reiserfs_check_lock_depth(s, "flush_commit_list") ;
 
   if (atomic_read(&jl->j_older_commits_done)) {
     return 0 ;
@@ -2203,7 +2203,7 @@
   time_t now = get_seconds() ;
   int old_trans_id  ;
 
-  reiserfs_check_lock_depth("journal_begin") ;
+  reiserfs_check_lock_depth(p_s_sb, "journal_begin") ;
   RFALSE( p_s_sb->s_flags & MS_RDONLY, 
 	  "clm-2078: calling journal_begin on readonly FS") ;
 
@@ -2367,6 +2367,8 @@
 
   set_bit(BH_JDirty, &bh->b_state) ;
 
+if (!buffer_mapped(bh))
+printk("Sobebody put !mapped buffer in journal\n");
   /* now put this guy on the end */
   if (!cn) {
     cn = get_cnode(p_s_sb) ;
===== fs/reiserfs/super.c 1.72 vs edited =====
--- 1.72/fs/reiserfs/super.c	Tue Dec 30 10:44:59 2003
+++ edited/fs/reiserfs/super.c	Sat Apr 10 00:35:11 2004
@@ -1252,6 +1252,8 @@
     }
     s->s_fs_info = sbi;
     memset (sbi, 0, sizeof (struct reiserfs_sb_info));
+    /* init fs lock */
+    rsb_lock_init(&sbi->fs_lock);
     /* Set default values for options: non-aggressive tails */
     REISERFS_SB(s)->s_mount_opt = ( 1 << REISERFS_SMALLTAIL );
     /* default block allocator option: skip_busy */
@@ -1488,6 +1490,73 @@
 	reiserfs_proc_info_global_done ();
         unregister_filesystem (& reiserfs_fs_type);
 	destroy_inodecache ();
+}
+
+/* The rsb_lock code below was copied from the lustre filesystem,
+   (C) 2001, 2002 Cluster File Systems, Inc. */
+/* invariants:
+ - only the owner of the lock changes l_owner/l_depth
+ - if a non-owner changes or checks the variables a spin lock is taken
+*/
+void rsb_lock_init(struct reiserfs_sb_lock *lock)
+{
+        sema_init(&lock->l_sem, 1);
+        spin_lock_init(&lock->l_spin);
+}
+
+void rsb_lock(struct reiserfs_sb_lock *lock)
+{
+        int owner = 0;
+
+        spin_lock(&lock->l_spin);
+        if (lock->l_owner == current)
+                owner = 1;
+        spin_unlock(&lock->l_spin);
+
+        /* This is safe to increment outside the spinlock because we
+         * can only have 1 CPU running on the current task
+         * (i.e. l_owner == current), regardless of the number of CPUs.
+         */
+        if (owner) {
+                ++lock->l_depth;
+        } else {
+                down(&lock->l_sem);
+                spin_lock(&lock->l_spin);
+                lock->l_owner = current;
+                lock->l_depth = 0;
+                spin_unlock(&lock->l_spin);
+        }
+}
+
+void rsb_unlock(struct reiserfs_sb_lock *lock)
+{
+        if(lock->l_owner != current)
+		BUG();
+        if(lock->l_depth < 0)
+		BUG();
+
+        spin_lock(&lock->l_spin);
+        if (--lock->l_depth < 0) {
+                lock->l_owner = NULL;
+                spin_unlock(&lock->l_spin);
+                up(&lock->l_sem);
+                return;
+        }
+        spin_unlock(&lock->l_spin);
+}
+
+int rsb_has_lock(struct reiserfs_sb_lock *lock)
+{               
+        int depth = -1, owner = 0;
+        
+        spin_lock(&lock->l_spin);
+        if (lock->l_owner == current) {
+                depth = lock->l_depth;
+                owner = 1;
+        }
+        spin_unlock(&lock->l_spin);
+
+        return owner;
 }
 
 struct file_system_type reiserfs_fs_type = {
===== include/linux/reiserfs_fs.h 1.56 vs edited =====
--- 1.56/include/linux/reiserfs_fs.h	Wed Feb  4 07:31:19 2004
+++ edited/include/linux/reiserfs_fs.h	Sat Apr 10 00:22:49 2004
@@ -1716,7 +1716,7 @@
 void reiserfs_wait_on_write_block(struct super_block *s) ;
 void reiserfs_block_writes(struct reiserfs_transaction_handle *th) ;
 void reiserfs_allow_writes(struct super_block *s) ;
-void reiserfs_check_lock_depth(char *caller) ;
+void reiserfs_check_lock_depth(struct super_block *sb, char *caller) ;
 void reiserfs_prepare_for_journal(struct super_block *, struct buffer_head *bh, int wait) ;
 void reiserfs_restore_prepared_buffer(struct super_block *, struct buffer_head *bh) ;
 int journal_init(struct super_block *, const char * j_dev_name, int old_format, unsigned int) ;
@@ -2178,11 +2178,11 @@
 #define REISERFS_IOC_SETVERSION		EXT2_IOC_SETVERSION
 
 /* Locking primitives */
-/* Right now we are still falling back to (un)lock_kernel, but eventually that
-   would evolve into real per-fs locks */
-#define reiserfs_write_lock( sb ) lock_kernel()
-#define reiserfs_write_unlock( sb ) unlock_kernel()
- 			         
+/* Right now we are using one bkl-alike lock per filesystem */
+
+#define reiserfs_write_lock( sb ) rsb_lock(&REISERFS_SB(sb)->fs_lock)
+#define reiserfs_write_unlock( sb ) rsb_unlock(&REISERFS_SB(sb)->fs_lock)
+
 #endif /* _LINUX_REISER_FS_H */
 
 
===== include/linux/reiserfs_fs_sb.h 1.25 vs edited =====
--- 1.25/include/linux/reiserfs_fs_sb.h	Tue Sep 23 07:16:25 2003
+++ edited/include/linux/reiserfs_fs_sb.h	Sat Apr 10 00:22:09 2004
@@ -345,12 +345,32 @@
 {} reiserfs_proc_info_data_t;
 #endif
 
+/* Per-sb bkl-alike lock */
+struct reiserfs_sb_lock {
+        int l_depth;
+        struct task_struct *l_owner;
+        struct semaphore l_sem;
+        spinlock_t l_spin;
+};
+ 
+void rsb_lock_init(struct reiserfs_sb_lock *lock);
+void rsb_lock(struct reiserfs_sb_lock *lock);
+void rsb_unlock(struct reiserfs_sb_lock *lock);
+int rsb_has_lock(struct reiserfs_sb_lock *lock);
+ 
+/* Locking primitives */
+/* Right now we are using one bkl-alike lock per filesystem */
+
+
+
 /* reiserfs union of in-core super block data */
 struct reiserfs_sb_info
 {
     struct buffer_head * s_sbh;                   /* Buffer containing the super block */
 				/* both the comment and the choice of
                                    name are unclear for s_rs -Hans */
+    struct reiserfs_sb_lock fs_lock; /* This is bkl-alike lock for superblock.*/
+
     struct reiserfs_super_block * s_rs;           /* Pointer to the super block in the buffer */
     struct reiserfs_bitmap_info * s_ap_bitmap;
     struct reiserfs_journal *s_journal ;		/* pointer to journal information */
