Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262612AbUJ1RTP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262612AbUJ1RTP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 13:19:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262895AbUJ1RTP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 13:19:15 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:30685 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S262612AbUJ1RO5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 13:14:57 -0400
Subject: [PATCH] reduce stack consumption in do_mount
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.11   July 24, 2002
Message-ID: <OF2D3B25A6.EBF2AF62-ONC1256F3B.005D01ED-C1256F3B.005EBAFF@de.ibm.com>
From: Andreas Herrmann <AHERRMAN@de.ibm.com>
Date: Thu, 28 Oct 2004 19:14:52 +0200
X-MIMETrack: Serialize by Router on D12ML065/12/M/IBM(Release 6.0.2CF2HF259 | March 11, 2004) at
 28/10/2004 19:14:55
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org





I have seen a kernel stack overflow during mount of a SCSI disk on
s390, 31bit, with 4K stack size.

The backtrace showed that there were 3 functions with stack
consumption of above 200 bytes.

These are do_mount (328 bytes stack size), ext3_fill_super (288 bytes)
and mpage_writepages (352 bytes).

For the latter 2 functions the large stack consumption seems to be
just due to extensive inlining of GCC 3.4.

But do_mount and friends store one or more struct nameidata on the
stack.  The size of this structure is 64 bytes on s390.

I suggest to kmalloc this structure in do_mount, do_loopback and
do_move_mount.

Applying the patch, stack size consumption of do_mount is 80 bytes
instead of 328 bytes. This would have avoided the kernel stack
overflow that I have encountered.

The patch is against linux-2.6.10-rc1.


Regards,

Andreas

--

diff -bBrauN linux-2.6.10-rc1/fs/namespace.c linux-2.6.x/fs/namespace.c
--- linux-2.6.10-rc1/fs/namespace.c 2004-10-28 17:29:26.000000000 +0200
+++ linux-2.6.x/fs/namespace.c      2004-10-28 17:29:56.000000000 +0200
@@ -621,25 +621,31 @@
  */
 static int do_loopback(struct nameidata *nd, char *old_name, int recurse)
 {
-     struct nameidata old_nd;
+     struct nameidata *old_nd;
      struct vfsmount *mnt = NULL;
      int err = mount_is_safe(nd);
      if (err)
            return err;
      if (!old_name || !*old_name)
            return -EINVAL;
-     err = path_lookup(old_name, LOOKUP_FOLLOW, &old_nd);
-     if (err)
+
+     old_nd = kmalloc(sizeof(*old_nd), GFP_KERNEL);
+     if (!old_nd)
+           return -ENOMEM;
+     err = path_lookup(old_name, LOOKUP_FOLLOW, old_nd);
+     if (err) {
+           kfree(old_nd);
            return err;
+     }

      down_write(&current->namespace->sem);
      err = -EINVAL;
-     if (check_mnt(nd->mnt) && (!recurse || check_mnt(old_nd.mnt))) {
+     if (check_mnt(nd->mnt) && (!recurse || check_mnt(old_nd->mnt))) {
            err = -ENOMEM;
            if (recurse)
-                 mnt = copy_tree(old_nd.mnt, old_nd.dentry);
+                 mnt = copy_tree(old_nd->mnt, old_nd->dentry);
            else
-                 mnt = clone_mnt(old_nd.mnt, old_nd.dentry);
+                 mnt = clone_mnt(old_nd->mnt, old_nd->dentry);
      }

      if (mnt) {
@@ -658,7 +664,8 @@
      }

      up_write(&current->namespace->sem);
-     path_release(&old_nd);
+     path_release(old_nd);
+     kfree(old_nd);
      return err;
 }

@@ -695,22 +702,27 @@

 static int do_move_mount(struct nameidata *nd, char *old_name)
 {
-     struct nameidata old_nd, parent_nd;
+     struct nameidata *old_nd, *parent_nd = NULL;
      struct vfsmount *p;
      int err = 0;
      if (!capable(CAP_SYS_ADMIN))
            return -EPERM;
      if (!old_name || !*old_name)
            return -EINVAL;
-     err = path_lookup(old_name, LOOKUP_FOLLOW, &old_nd);
-     if (err)
+     old_nd = kmalloc(sizeof(*old_nd), GFP_KERNEL);
+     if (!old_nd)
+           return -ENOMEM;
+     err = path_lookup(old_name, LOOKUP_FOLLOW, old_nd);
+     if (err) {
+           kfree(old_nd);
            return err;
+     }

      down_write(&current->namespace->sem);
      while(d_mountpoint(nd->dentry) && follow_down(&nd->mnt, &nd->dentry))
            ;
      err = -EINVAL;
-     if (!check_mnt(nd->mnt) || !check_mnt(old_nd.mnt))
+     if (!check_mnt(nd->mnt) || !check_mnt(old_nd->mnt))
            goto out;

      err = -ENOENT;
@@ -723,37 +735,45 @@
            goto out2;

      err = -EINVAL;
-     if (old_nd.dentry != old_nd.mnt->mnt_root)
+     if (old_nd->dentry != old_nd->mnt->mnt_root)
            goto out2;

-     if (old_nd.mnt == old_nd.mnt->mnt_parent)
+     if (old_nd->mnt == old_nd->mnt->mnt_parent)
            goto out2;

      if (S_ISDIR(nd->dentry->d_inode->i_mode) !=
-           S_ISDIR(old_nd.dentry->d_inode->i_mode))
+           S_ISDIR(old_nd->dentry->d_inode->i_mode))
            goto out2;

      err = -ELOOP;
      for (p = nd->mnt; p->mnt_parent!=p; p = p->mnt_parent)
-           if (p == old_nd.mnt)
+           if (p == old_nd->mnt)
                  goto out2;
      err = 0;

-     detach_mnt(old_nd.mnt, &parent_nd);
-     attach_mnt(old_nd.mnt, nd);
+     parent_nd = kmalloc(sizeof(*parent_nd), GFP_ATOMIC);
+     if (!parent_nd) {
+           err = -ENOMEM;
+           goto out2;
+     }
+     detach_mnt(old_nd->mnt, parent_nd);
+     attach_mnt(old_nd->mnt, nd);

      /* if the mount is moved, it should no longer be expire
       * automatically */
-     list_del_init(&old_nd.mnt->mnt_fslink);
+     list_del_init(&old_nd->mnt->mnt_fslink);
 out2:
      spin_unlock(&vfsmount_lock);
 out1:
      up(&nd->dentry->d_inode->i_sem);
 out:
      up_write(&current->namespace->sem);
-     if (!err)
-           path_release(&parent_nd);
-     path_release(&old_nd);
+     if (!err) {
+           path_release(parent_nd);
+           kfree(parent_nd);
+     }
+     path_release(old_nd);
+     kfree(old_nd);
      return err;
 }

@@ -1009,7 +1029,7 @@
 long do_mount(char * dev_name, char * dir_name, char *type_page,
              unsigned long flags, void *data_page)
 {
-     struct nameidata nd;
+     struct nameidata *nd;
      int retval = 0;
      int mnt_flags = 0;

@@ -1036,27 +1056,34 @@
            mnt_flags |= MNT_NOEXEC;
      flags &= ~(MS_NOSUID|MS_NOEXEC|MS_NODEV|MS_ACTIVE);

+     nd = kmalloc(sizeof(*nd), GFP_KERNEL);
+     if (!nd)
+           return -ENOMEM;
+
      /* ... and get the mountpoint */
-     retval = path_lookup(dir_name, LOOKUP_FOLLOW, &nd);
-     if (retval)
+     retval = path_lookup(dir_name, LOOKUP_FOLLOW, nd);
+     if (retval) {
+           kfree(nd);
            return retval;
+     }

-     retval = security_sb_mount(dev_name, &nd, type_page, flags, data_page);
+     retval = security_sb_mount(dev_name, nd, type_page, flags, data_page);
      if (retval)
            goto dput_out;

      if (flags & MS_REMOUNT)
-           retval = do_remount(&nd, flags & ~MS_REMOUNT, mnt_flags,
+           retval = do_remount(nd, flags & ~MS_REMOUNT, mnt_flags,
                            data_page);
      else if (flags & MS_BIND)
-           retval = do_loopback(&nd, dev_name, flags & MS_REC);
+           retval = do_loopback(nd, dev_name, flags & MS_REC);
      else if (flags & MS_MOVE)
-           retval = do_move_mount(&nd, dev_name);
+           retval = do_move_mount(nd, dev_name);
      else
-           retval = do_new_mount(&nd, type_page, flags, mnt_flags,
+           retval = do_new_mount(nd, type_page, flags, mnt_flags,
                              dev_name, data_page);
 dput_out:
-     path_release(&nd);
+     path_release(nd);
+     kfree(nd);
      return retval;
 }

