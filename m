Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129370AbQKLQuZ>; Sun, 12 Nov 2000 11:50:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129213AbQKLQuO>; Sun, 12 Nov 2000 11:50:14 -0500
Received: from jake.canberra.net.au ([203.29.91.119]:7187 "EHLO
	smtp.canberra.net.au") by vger.kernel.org with ESMTP
	id <S129370AbQKLQuE>; Sun, 12 Nov 2000 11:50:04 -0500
Message-ID: <000901c04cc8$0ff70130$0200a8c0@W2K>
From: "Nick Piggin" <piggin@cyberone.com.au>
To: "Linux-Kernel" <linux-kernel@vger.kernel.org>
Subject: bkl usage
Date: Mon, 13 Nov 2000 03:45:58 +1100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi. In my efforts to understand the linux kernel v2.4 I found the bkl being
used in kernel/acct.c to lock seemingly local data. Would someone please
explain what races this prevents vs. say:


--- linux/kernel/acct.c Mon Oct 30 01:02:56 2000
+++ linux-2.4.0-test10/kernel/acct.c Mon Oct 30 01:10:20 2000
@@ -41,6 +41,10 @@
  * Oh, fsck... Oopsable SMP race in do_process_acct() - we must hold
  * ->mmap_sem to walk the vma list of current->mm. Nasty, since it leaks
  * a struct file opened for write. Fixed. 2/6/2000, AV.
+ *
+ *  2000-10-27 Modified by Nick <piggin@cyberone.com.au> to remove usage
+ *  of the big kernel lock in favour of a local spinlock
+ *
  */

 #include <linux/config.h>
@@ -77,6 +81,7 @@
 static struct file *acct_file;
 static struct timer_list acct_timer;
 static void do_acct_process(long, struct file *);
+static spinlock_t acct_lock = SPIN_LOCK_UNLOCKED;

 /*
  * Called whenever the timer says to check the free space.
@@ -95,11 +100,11 @@
  int res;
  int act;

- lock_kernel();
+        spin_lock(&acct_lock);
  res = acct_active;
  if (!file || !acct_needcheck)
-  goto out;
- unlock_kernel();
+  goto out_unlock;
+        spin_unlock(&acct_lock);

  /* May block */
  if (vfs_statfs(file->f_dentry->d_inode->i_sb, &sbuf))
@@ -113,14 +118,14 @@
   act = 0;

  /*
-  * If some joker switched acct_file under us we'ld better be
+  * If some joker switched acct_file under us we'd better be
   * silent and _not_ touch anything.
   */
- lock_kernel();
+        spin_lock(&acct_lock);
  if (file != acct_file) {
   if (act)
    res = act>0;
-  goto out;
+  goto out_unlock;
  }

  if (acct_active) {
@@ -140,8 +145,8 @@
  acct_timer.expires = jiffies + ACCT_TIMEOUT*HZ;
  add_timer(&acct_timer);
  res = acct_active;
-out:
- unlock_kernel();
+out_unlock:
+        spin_unlock(&acct_lock);
  return res;
 }

@@ -182,7 +187,7 @@
  }

  error = 0;
- lock_kernel();
+        spin_lock(&acct_lock);
  if (acct_file) {
   old_acct = acct_file;
   del_timer(&acct_timer);
@@ -200,7 +205,7 @@
   acct_timer.expires = jiffies + ACCT_TIMEOUT*HZ;
   add_timer(&acct_timer);
  }
- unlock_kernel();
+        spin_unlock(&acct_lock);
  if (old_acct) {
   do_acct_process(0,old_acct);
   filp_close(old_acct, NULL);
@@ -214,10 +219,24 @@

 void acct_auto_close(kdev_t dev)
 {
- lock_kernel();
- if (acct_file && acct_file->f_dentry->d_inode->i_dev == dev)
-  sys_acct(NULL);
- unlock_kernel();
+        struct file *old_acct;
+
+        spin_lock(&acct_lock);
+ if (acct_file && acct_file->f_dentry->d_inode->i_dev == dev) {
+
+                /* Run the same code as sys_acct(NULL) here. This
simplifies locking */
+                old_acct = acct_file;
+                del_timer(&acct_timer);
+                acct_active = 0;
+                acct_needcheck = 0;
+                acct_file = NULL;
+
+                spin_unlock(&acct_lock);
+
+                do_acct_process(0, old_acct);
+                filp_close(old_acct, NULL);
+        } else
+                spin_unlock(&acct_lock);
 }

 /*
@@ -348,15 +367,15 @@
 int acct_process(long exitcode)
 {
  struct file *file = NULL;
- lock_kernel();
+        spin_lock(&acct_lock);
  if (acct_file) {
   file = acct_file;
   get_file(file);
-  unlock_kernel();
+                spin_unlock(&acct_lock);
   do_acct_process(exitcode, acct_file);
   fput(file);
  } else
-  unlock_kernel();
+                spin_unlock(&acct_lock);
  return 0;
 }


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
