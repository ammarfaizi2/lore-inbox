Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266425AbTGERHM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jul 2003 13:07:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266423AbTGERHM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jul 2003 13:07:12 -0400
Received: from arbi.Informatik.uni-oldenburg.de ([134.106.1.7]:8210 "EHLO
	arbi.Informatik.Uni-Oldenburg.DE") by vger.kernel.org with ESMTP
	id S266441AbTGERGt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jul 2003 13:06:49 -0400
Subject: PATCH 2.4.21 make open_exec() more readable
To: linux-kernel@vger.kernel.org (kernel linux)
Date: Sat, 5 Jul 2003 19:21:17 +0200 (MEST)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E19Yqir-000ITV-00@grossglockner.Informatik.Uni-Oldenburg.DE>
From: "Walter Harms" <Walter.Harms@Informatik.Uni-Oldenburg.DE>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi list,
i found open_exec() had several indent level. To much to be usefull.
To make it a bit more readable i changed it a bit (adding goto's
this time). The patch contains also cosmetic changes to 
kernel_read() and exec_mmap(). removing some tab's make it larger
that they are.
There are no fuctional changes intended !

Note: this time with diff -u :)

walter
--- fs/exec.c.org       2003-07-02 21:38:15.000000000 +0200
+++ fs/exec.c   2003-07-02 22:00:19.000000000 +0200
@@ -368,33 +368,44 @@
        struct file *file;
        int err = 0;
 
-       err = path_lookup(name, LOOKUP_FOLLOW|LOOKUP_POSITIVE, &nd);
-       file = ERR_PTR(err);
-       if (!err) {
-               inode = nd.dentry->d_inode;
-               file = ERR_PTR(-EACCES);
-               if (!(nd.mnt->mnt_flags & MNT_NOEXEC) &&
-                   S_ISREG(inode->i_mode)) {
-                       int err = permission(inode, MAY_EXEC);
-                       if (!err && !(inode->i_mode & 0111))
-                               err = -EACCES;
+       err = path_lookup(name, LOOKUP_FOLLOW | LOOKUP_POSITIVE, &nd);
+       if (err)
+               return ERR_PTR(err);
+
+       inode = nd.dentry->d_inode;
+       file = ERR_PTR(-EACCES);
+
+       if (!S_ISREG(inode->i_mode))
+               goto error;
+
+       if (nd.mnt->mnt_flags & MNT_NOEXEC)
+               goto error;
+
+       err = permission(inode, MAY_EXEC);
+       if (err) 
+               goto error;
+       /* To check:
+          is this useless ?
+       */
+
+       if (!(inode->i_mode & 0111)) 
+               goto error;
+
+
+       file = dentry_open(nd.dentry, nd.mnt, O_RDONLY);
+       if (!IS_ERR(file)) {
+               err = deny_write_access(file);
+               if (err) {
+                       fput(file);
                        file = ERR_PTR(err);
-                       if (!err) {
-                               file = dentry_open(nd.dentry, nd.mnt, O_RDONLY);
-                               if (!IS_ERR(file)) {
-                                       err = deny_write_access(file);
-                                       if (err) {
-                                               fput(file);
-                                               file = ERR_PTR(err);
-                                       }
-                               }
-out:
-                               return file;
-                       }
                }
-               path_release(&nd);
        }
-       goto out;
+       return file;
+
+      error:
+       path_release(&nd);
+       return file;
+
 }
 
 int kernel_read(struct file *file, unsigned long offset,
@@ -404,20 +415,19 @@
        loff_t pos = offset;
        int result = -ENOSYS;
 
-       if (!file->f_op->read)
-               goto fail;
-       old_fs = get_fs();
-       set_fs(get_ds());
-       result = file->f_op->read(file, addr, count, &pos);
-       set_fs(old_fs);
-fail:
+       if (file->f_op->read) {
+               old_fs = get_fs();
+               set_fs(get_ds());
+               result = file->f_op->read(file, addr, count, &pos);
+               set_fs(old_fs);
+       }
        return result;
 }
 
 static int exec_mmap(void)
 {
        struct mm_struct * mm, * old_mm;
-
+       struct mm_struct *active_mm;
        old_mm = current->mm;
        if (old_mm && atomic_read(&old_mm->mm_users) == 1) {
                mm_release();
@@ -426,36 +436,37 @@
        }
 
        mm = mm_alloc();
-       if (mm) {
-               struct mm_struct *active_mm;
+       if (!mm) {
+               return -ENOMEM;
+       }
+
 
-               if (init_new_context(current, mm)) {
-                       mmdrop(mm);
-                       return -ENOMEM;
-               }
+       if (init_new_context(current, mm)) {
+               mmdrop(mm);
+               return -ENOMEM;
+       }
 
-               /* Add it to the list of mm's */
-               spin_lock(&mmlist_lock);
-               list_add(&mm->mmlist, &init_mm.mmlist);
-               mmlist_nr++;
-               spin_unlock(&mmlist_lock);
-
-               task_lock(current);
-               active_mm = current->active_mm;
-               current->mm = mm;
-               current->active_mm = mm;
-               task_unlock(current);
-               activate_mm(active_mm, mm);
-               mm_release();
-               if (old_mm) {
-                       if (active_mm != old_mm) BUG();
-                       mmput(old_mm);
-                       return 0;
-               }
-               mmdrop(active_mm);
+       /* Add it to the list of mm's */
+       spin_lock(&mmlist_lock);
+       list_add(&mm->mmlist, &init_mm.mmlist);
+       mmlist_nr++;
+       spin_unlock(&mmlist_lock);
+
+       task_lock(current);
+       active_mm = current->active_mm;
+       current->mm = mm;
+       current->active_mm = mm;
+       task_unlock(current);
+       activate_mm(active_mm, mm);
+       mm_release();
+       if (old_mm) {
+               if (active_mm != old_mm) BUG();
+               mmput(old_mm);
                return 0;
        }
-       return -ENOMEM;
+       mmdrop(active_mm);
+       return 0;
+
 }
 
 /*

-- 
