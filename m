Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292593AbSCKUI2>; Mon, 11 Mar 2002 15:08:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292588AbSCKUIM>; Mon, 11 Mar 2002 15:08:12 -0500
Received: from air-2.osdl.org ([65.201.151.6]:11398 "EHLO doc.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S292593AbSCKUHt>;
	Mon, 11 Mar 2002 15:07:49 -0500
Date: Mon, 11 Mar 2002 12:07:44 -0800
From: Bob Miller <rem@osdl.org>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.6-pre3 Fix small race in BSD accounting [part 2]
Message-ID: <20020311120744.B5995@doc.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

While looking at the bug fix for part 1 I coded up this patch
to change the BSD accounting code to use a spinlock instead
of the BKL.

This patch assumes that part 1 has been applied.

-- 
Bob Miller					Email: rem@osdl.org
Open Source Development Lab			Phone: 503.626.2455 Ext. 17


diff -ur linux-2.5.6-orig/kernel/acct.c linux-2.5.6/kernel/acct.c
--- linux-2.5.6-orig/kernel/acct.c	Mon Mar 11 11:19:58 2002
+++ linux-2.5.6/kernel/acct.c	Mon Mar 11 11:33:14 2002
@@ -72,14 +72,30 @@
 /*
  * External references and all of the globals.
  */
-
-static volatile int acct_active;
-static volatile int acct_needcheck;
-static struct file *acct_file;
-static struct timer_list acct_timer;
 static void do_acct_process(long, struct file *);
 
 /*
+ * This structure is used so that all the data protected by lock
+ * can be placed in the same cache line as the lock.  This primes
+ * the cache line to have the data after getting the lock.
+ */
+struct acct_glbs {
+	spinlock_t		lock;
+	volatile int		active;
+	volatile int		needcheck;
+	struct file		*file;
+	struct timer_list	timer;
+};
+
+static struct acct_glbs acct_globals __cacheline_aligned = {SPIN_LOCK_UNLOCKED};
+
+#define	acct_lock	acct_globals.lock
+#define	acct_active	acct_globals.active
+#define	acct_needcheck	acct_globals.needcheck
+#define	acct_file	acct_globals.file
+#define	acct_timer	acct_globals.timer
+
+/*
  * Called whenever the timer says to check the free space.
  */
 static void acct_timeout(unsigned long unused)
@@ -96,11 +112,11 @@
 	int res;
 	int act;
 
-	lock_kernel();
+	spin_lock(&acct_lock);
 	res = acct_active;
 	if (!file || !acct_needcheck)
 		goto out;
-	unlock_kernel();
+	spin_unlock(&acct_lock);
 
 	/* May block */
 	if (vfs_statfs(file->f_dentry->d_inode->i_sb, &sbuf))
@@ -117,7 +133,7 @@
 	 * If some joker switched acct_file under us we'ld better be
 	 * silent and _not_ touch anything.
 	 */
-	lock_kernel();
+	spin_lock(&acct_lock);
 	if (file != acct_file) {
 		if (act)
 			res = act>0;
@@ -142,22 +158,26 @@
 	add_timer(&acct_timer);
 	res = acct_active;
 out:
-	unlock_kernel();
+	spin_unlock(&acct_lock);
 	return res;
 }
 
 /*
- *  sys_acct() is the only system call needed to implement process
- *  accounting. It takes the name of the file where accounting records
- *  should be written. If the filename is NULL, accounting will be
- *  shutdown.
+ *  acct_common() is the main routine that implements process accounting.
+ *  It takes the name of the file where accounting records should be
+ *  written. If the filename is NULL, accounting will be shutdown.
  */
-asmlinkage long sys_acct(const char *name)
+long acct_common(const char *name, int locked)
 {
 	struct file *file = NULL, *old_acct = NULL;
 	char *tmp;
 	int error;
 
+	/*
+	 * Should only have locked set when name is NULL (enforce this).
+	 */
+	BUG_ON(locked && name);
+
 	if (!capable(CAP_SYS_PACCT))
 		return -EPERM;
 
@@ -183,7 +203,8 @@
 	}
 
 	error = 0;
-	lock_kernel();
+	if (!locked)
+		spin_lock(&acct_lock);
 	if (acct_file) {
 		old_acct = acct_file;
 		del_timer(&acct_timer);
@@ -201,7 +222,7 @@
 		acct_timer.expires = jiffies + ACCT_TIMEOUT*HZ;
 		add_timer(&acct_timer);
 	}
-	unlock_kernel();
+	spin_unlock(&acct_lock);
 	if (old_acct) {
 		do_acct_process(0,old_acct);
 		filp_close(old_acct, NULL);
@@ -213,12 +234,25 @@
 	goto out;
 }
 
+/*
+ *  sys_acct() is the only system call needed to implement process
+ *  accounting. It takes the name of the file where accounting records
+ *  should be written. If the filename is NULL, accounting will be
+ *  shutdown.
+ */
+asmlinkage long sys_acct(const char *name)
+{
+	return (acct_common(name, 0));
+}
+
 void acct_auto_close(struct super_block *sb)
 {
-	lock_kernel();
-	if (acct_file && acct_file->f_dentry->d_inode->i_sb == sb)
-		sys_acct(NULL);
-	unlock_kernel();
+	spin_lock(&acct_lock);
+	if (acct_file && acct_file->f_dentry->d_inode->i_sb == sb) {
+		(void) acct_common(NULL, 1);
+	} else {
+		spin_unlock(&acct_lock);
+	}
 }
 
 /*
@@ -349,15 +383,15 @@
 int acct_process(long exitcode)
 {
 	struct file *file = NULL;
-	lock_kernel();
+	spin_lock(&acct_lock);
 	if (acct_file) {
 		file = acct_file;
 		get_file(file);
-		unlock_kernel();
+		spin_unlock(&acct_lock);
 		do_acct_process(exitcode, file);
 		fput(file);
 	} else
-		unlock_kernel();
+		spin_unlock(&acct_lock);
 	return 0;
 }
 
