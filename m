Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263341AbUJ2OiV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263341AbUJ2OiV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 10:38:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263358AbUJ2OgX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 10:36:23 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:9208 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S263357AbUJ2Oah
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 10:30:37 -0400
Subject: Re: [PATCH] reduce stack consumption in do_mount
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.11   July 24, 2002
Message-ID: <OF0351A2A5.52BB0EFC-ONC1256F3C.004F7CAC-C1256F3C.004FA1B4@de.ibm.com>
From: Andreas Herrmann <AHERRMAN@de.ibm.com>
Date: Fri, 29 Oct 2004 16:29:58 +0200
X-MIMETrack: Serialize by Router on D12ML065/12/M/IBM(Release 6.0.2CF2HF259 | March 11, 2004) at
 29/10/2004 16:30:03
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org





      Denis Vlasenko wrote:

[snip]

> Do it in one go:

>    struct {
>       struct nameidata old_nd, parent_nd;
>    } *loc;
>    loc = kmalloc(sizeof(*loc), GFP_KERNEL);
>    if (loc)
>       return -ENOMEM;

> and add loc-> to every occurrence of old_nd and parent_nd.

> Reduces time, space, fragmentation overhead and code size.

Done. Thanks for the advice.
Below is a new patch.


Regards,

Andreas

--
diff -u linux-2.6.10-rc1/fs/namespace.c linux-2.6.x/fs/namespace.c
--- linux-2.6.10-rc1/fs/namespace.c 2004-10-28 17:29:26.000000000 +0200
+++ linux-2.6.x/fs/namespace.c      2004-10-29 16:04:42.000000000 +0200
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

@@ -695,22 +702,29 @@

 static int do_move_mount(struct nameidata *nd, char *old_name)
 {
-     struct nameidata old_nd, parent_nd;
+     struct {
+           struct nameidata old_nd, parent_nd;
+     } *loc;
      struct vfsmount *p;
      int err = 0;
      if (!capable(CAP_SYS_ADMIN))
            return -EPERM;
      if (!old_name || !*old_name)
            return -EINVAL;
-     err = path_lookup(old_name, LOOKUP_FOLLOW, &old_nd);
-     if (err)
+     loc = kmalloc(sizeof(*loc), GFP_KERNEL);
+     if (!loc)
+           return -ENOMEM;
+     err = path_lookup(old_name, LOOKUP_FOLLOW, &loc->old_nd);
+     if (err) {
+           kfree (loc);
            return err;
+     }

      down_write(&current->namespace->sem);
      while(d_mountpoint(nd->dentry) && follow_down(&nd->mnt, &nd->dentry))
            ;
      err = -EINVAL;
-     if (!check_mnt(nd->mnt) || !check_mnt(old_nd.mnt))
+     if (!check_mnt(nd->mnt) || !check_mnt(loc->old_nd.mnt))
            goto out;

      err = -ENOENT;
@@ -723,28 +737,28 @@
            goto out2;

      err = -EINVAL;
-     if (old_nd.dentry != old_nd.mnt->mnt_root)
+     if (loc->old_nd.dentry != loc->old_nd.mnt->mnt_root)
            goto out2;

-     if (old_nd.mnt == old_nd.mnt->mnt_parent)
+     if (loc->old_nd.mnt == loc->old_nd.mnt->mnt_parent)
            goto out2;

      if (S_ISDIR(nd->dentry->d_inode->i_mode) !=
-           S_ISDIR(old_nd.dentry->d_inode->i_mode))
+           S_ISDIR(loc->old_nd.dentry->d_inode->i_mode))
            goto out2;

      err = -ELOOP;
      for (p = nd->mnt; p->mnt_parent!=p; p = p->mnt_parent)
-           if (p == old_nd.mnt)
+           if (p == loc->old_nd.mnt)
                  goto out2;
      err = 0;

-     detach_mnt(old_nd.mnt, &parent_nd);
-     attach_mnt(old_nd.mnt, nd);
+     detach_mnt(loc->old_nd.mnt, &loc->parent_nd);
+     attach_mnt(loc->old_nd.mnt, nd);

      /* if the mount is moved, it should no longer be expire
       * automatically */
-     list_del_init(&old_nd.mnt->mnt_fslink);
+     list_del_init(&loc->old_nd.mnt->mnt_fslink);
 out2:
      spin_unlock(&vfsmount_lock);
 out1:
@@ -752,8 +766,9 @@
 out:
      up_write(&current->namespace->sem);
      if (!err)
-           path_release(&parent_nd);
-     path_release(&old_nd);
+           path_release(&loc->parent_nd);
+     path_release(&loc->old_nd);
+     kfree(loc);
      return err;
 }

@@ -1009,7 +1024,7 @@
 long do_mount(char * dev_name, char * dir_name, char *type_page,
              unsigned long flags, void *data_page)
 {
-     struct nameidata nd;
+     struct nameidata *nd;
      int retval = 0;
      int mnt_flags = 0;

@@ -1036,27 +1051,34 @@
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

