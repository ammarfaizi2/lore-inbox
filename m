Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311446AbSCNA0F>; Wed, 13 Mar 2002 19:26:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311450AbSCNAZg>; Wed, 13 Mar 2002 19:25:36 -0500
Received: from air-2.osdl.org ([65.201.151.6]:54658 "EHLO doc.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S311446AbSCNAYw>;
	Wed, 13 Mar 2002 19:24:52 -0500
Date: Wed, 13 Mar 2002 16:24:51 -0800
From: Bob Miller <rem@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.7-pre1 Code cleanup for BSD accounting.
Message-ID: <20020313162451.A12134@doc.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Send to Linus but forgot to cc to lkml.


-- 
Bob Miller					Email: rem@osdl.org
Open Source Development Lab			Phone: 503.626.2455 Ext. 17

----- Forwarded message from Bob Miller <rem@osdl.org> -----

Date: Wed, 13 Mar 2002 13:26:57 -0800
To: torvalds@transmeta.com
From: Bob Miller <rem@osdl.org>
Subject: [PATCH] 2.5.7-pre1 Code cleanup for BSD accounting.

Linus,

First off, thanks for taking the other patches.  Robert Love had
some concerns with part 2 and the patch below address his issues.
I also believe the code is much clearer for the effort (thanks Robert
for the push).  Could you apply?  TIA.

-- 
Bob Miller					Email: rem@osdl.org
Open Source Development Lab			Phone: 503.626.2455 Ext. 17


diff -ur /home/rem/views/linux-2.5.7-pre1-orig/kernel/acct.c /home/rem/views/linux-2.5.7-pre1/kernel/acct.c
--- /home/rem/views/linux-2.5.7-pre1-orig/kernel/acct.c	Tue Mar 12 14:46:46 2002
+++ /home/rem/views/linux-2.5.7-pre1/kernel/acct.c	Tue Mar 12 16:40:28 2002
@@ -89,18 +89,12 @@
 
 static struct acct_glbs acct_globals __cacheline_aligned = {SPIN_LOCK_UNLOCKED};
 
-#define	acct_lock	acct_globals.lock
-#define	acct_active	acct_globals.active
-#define	acct_needcheck	acct_globals.needcheck
-#define	acct_file	acct_globals.file
-#define	acct_timer	acct_globals.timer
-
 /*
  * Called whenever the timer says to check the free space.
  */
 static void acct_timeout(unsigned long unused)
 {
-	acct_needcheck = 1;
+	acct_globals.needcheck = 1;
 }
 
 /*
@@ -112,11 +106,11 @@
 	int res;
 	int act;
 
-	spin_lock(&acct_lock);
-	res = acct_active;
-	if (!file || !acct_needcheck)
+	spin_lock(&acct_globals.lock);
+	res = acct_globals.active;
+	if (!file || !acct_globals.needcheck)
 		goto out;
-	spin_unlock(&acct_lock);
+	spin_unlock(&acct_globals.lock);
 
 	/* May block */
 	if (vfs_statfs(file->f_dentry->d_inode->i_sb, &sbuf))
@@ -130,108 +124,73 @@
 		act = 0;
 
 	/*
-	 * If some joker switched acct_file under us we'ld better be
+	 * If some joker switched acct_globals.file under us we'ld better be
 	 * silent and _not_ touch anything.
 	 */
-	spin_lock(&acct_lock);
-	if (file != acct_file) {
+	spin_lock(&acct_globals.lock);
+	if (file != acct_globals.file) {
 		if (act)
 			res = act>0;
 		goto out;
 	}
 
-	if (acct_active) {
+	if (acct_globals.active) {
 		if (act < 0) {
-			acct_active = 0;
+			acct_globals.active = 0;
 			printk(KERN_INFO "Process accounting paused\n");
 		}
 	} else {
 		if (act > 0) {
-			acct_active = 1;
+			acct_globals.active = 1;
 			printk(KERN_INFO "Process accounting resumed\n");
 		}
 	}
 
-	del_timer(&acct_timer);
-	acct_needcheck = 0;
-	acct_timer.expires = jiffies + ACCT_TIMEOUT*HZ;
-	add_timer(&acct_timer);
-	res = acct_active;
+	del_timer(&acct_globals.timer);
+	acct_globals.needcheck = 0;
+	acct_globals.timer.expires = jiffies + ACCT_TIMEOUT*HZ;
+	add_timer(&acct_globals.timer);
+	res = acct_globals.active;
 out:
-	spin_unlock(&acct_lock);
+	spin_unlock(&acct_globals.lock);
 	return res;
 }
 
 /*
- *  acct_common() is the main routine that implements process accounting.
- *  It takes the name of the file where accounting records should be
- *  written. If the filename is NULL, accounting will be shutdown.
+ * Close the old accouting file (if currently open) and then replace
+ * it with file (if non-NULL).
+ *
+ * NOTE: acct_globals.lock MUST be held on entry and exit.
  */
-long acct_common(const char *name, int locked)
+void acct_file_reopen(struct file *file)
 {
-	struct file *file = NULL, *old_acct = NULL;
-	char *tmp;
-	int error;
+	struct file *old_acct = NULL;
 
-	/*
-	 * Should only have locked set when name is NULL (enforce this).
-	 */
-	BUG_ON(locked && name);
+	BUG_ON(!spin_is_locked(&acct_globals.lock));
 
-	if (!capable(CAP_SYS_PACCT))
-		return -EPERM;
-
-	if (name) {
-		tmp = getname(name);
-		error = PTR_ERR(tmp);
-		if (IS_ERR(tmp))
-			goto out;
-		/* Difference from BSD - they don't do O_APPEND */
-		file = filp_open(tmp, O_WRONLY|O_APPEND, 0);
-		putname(tmp);
-		if (IS_ERR(file)) {
-			error = PTR_ERR(file);
-			goto out;
-		}
-		error = -EACCES;
-		if (!S_ISREG(file->f_dentry->d_inode->i_mode)) 
-			goto out_err;
-
-		error = -EIO;
-		if (!file->f_op->write) 
-			goto out_err;
-	}
-
-	error = 0;
-	if (!locked)
-		spin_lock(&acct_lock);
-	if (acct_file) {
-		old_acct = acct_file;
-		del_timer(&acct_timer);
-		acct_active = 0;
-		acct_needcheck = 0;
-		acct_file = NULL;
+	if (acct_globals.file) {
+		old_acct = acct_globals.file;
+		del_timer(&acct_globals.timer);
+		acct_globals.active = 0;
+		acct_globals.needcheck = 0;
+		acct_globals.file = NULL;
 	}
-	if (name) {
-		acct_file = file;
-		acct_needcheck = 0;
-		acct_active = 1;
+	if (file) {
+		acct_globals.file = file;
+		acct_globals.needcheck = 0;
+		acct_globals.active = 1;
 		/* It's been deleted if it was used before so this is safe */
-		init_timer(&acct_timer);
-		acct_timer.function = acct_timeout;
-		acct_timer.expires = jiffies + ACCT_TIMEOUT*HZ;
-		add_timer(&acct_timer);
+		init_timer(&acct_globals.timer);
+		acct_globals.timer.function = acct_timeout;
+		acct_globals.timer.expires = jiffies + ACCT_TIMEOUT*HZ;
+		add_timer(&acct_globals.timer);
 	}
-	spin_unlock(&acct_lock);
 	if (old_acct) {
-		do_acct_process(0,old_acct);
+		spin_unlock(&acct_globals.lock);
+		do_acct_process(0, old_acct);
 		filp_close(old_acct, NULL);
+		spin_lock(&acct_globals.lock);
 	}
-out:
-	return error;
-out_err:
-	filp_close(file, NULL);
-	goto out;
 }
 
 /*
@@ -242,17 +201,53 @@
  */
 asmlinkage long sys_acct(const char *name)
 {
-	return (acct_common(name, 0));
+	struct file *file = NULL;
+	char *tmp;
+
+	if (!capable(CAP_SYS_PACCT))
+		return -EPERM;
+
+	if (name) {
+		tmp = getname(name);
+		if (IS_ERR(tmp)) {
+			return (PTR_ERR(tmp));
+		}
+		/* Difference from BSD - they don't do O_APPEND */
+		file = filp_open(tmp, O_WRONLY|O_APPEND, 0);
+		putname(tmp);
+		if (IS_ERR(file)) {
+			return (PTR_ERR(file));
+		}
+		if (!S_ISREG(file->f_dentry->d_inode->i_mode)) {
+			filp_close(file, NULL);
+			return (-EACCES);
+		}
+
+		if (!file->f_op->write) {
+			filp_close(file, NULL);
+			return (-EIO);
+		}
+	}
+
+	spin_lock(&acct_globals.lock);
+	acct_file_reopen(file);
+	spin_unlock(&acct_globals.lock);
+
+	return (0);
 }
 
+/*
+ * If the accouting is turned on for a file in the filesystem pointed
+ * to by sb, turn accouting off.
+ */
 void acct_auto_close(struct super_block *sb)
 {
-	spin_lock(&acct_lock);
-	if (acct_file && acct_file->f_dentry->d_inode->i_sb == sb) {
-		(void) acct_common(NULL, 1);
-	} else {
-		spin_unlock(&acct_lock);
+	spin_lock(&acct_globals.lock);
+	if (acct_globals.file &&
+	    acct_globals.file->f_dentry->d_inode->i_sb == sb) {
+		acct_file_reopen((struct file *)NULL);
 	}
+	spin_unlock(&acct_globals.lock);
 }
 
 /*
@@ -329,7 +324,8 @@
 	strncpy(ac.ac_comm, current->comm, ACCT_COMM);
 	ac.ac_comm[ACCT_COMM - 1] = '\0';
 
-	ac.ac_btime = CT_TO_SECS(current->start_time) + (xtime.tv_sec - (jiffies / HZ));
+	ac.ac_btime = CT_TO_SECS(current->start_time) +
+		(xtime.tv_sec - (jiffies / HZ));
 	ac.ac_etime = encode_comp_t(jiffies - current->start_time);
 	ac.ac_utime = encode_comp_t(current->times.tms_utime);
 	ac.ac_stime = encode_comp_t(current->times.tms_stime);
@@ -390,15 +386,15 @@
 int acct_process(long exitcode)
 {
 	struct file *file = NULL;
-	spin_lock(&acct_lock);
-	if (acct_file) {
-		file = acct_file;
+	spin_lock(&acct_globals.lock);
+	if (acct_globals.file) {
+		file = acct_globals.file;
 		get_file(file);
-		spin_unlock(&acct_lock);
+		spin_unlock(&acct_globals.lock);
 		do_acct_process(exitcode, file);
 		fput(file);
 	} else
-		spin_unlock(&acct_lock);
+		spin_unlock(&acct_globals.lock);
 	return 0;
 }
 

----- End forwarded message -----
