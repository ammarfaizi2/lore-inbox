Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751575AbWFVRCI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751575AbWFVRCI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 13:02:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751526AbWFVRCI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 13:02:08 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:58327 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751441AbWFVRCG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 13:02:06 -0400
Subject: Re: [RFC][PATCH 03/20] Add vfsmount writer count
From: Dave Hansen <haveblue@us.ibm.com>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       herbert@13thfloor.at
In-Reply-To: <20060620212000.GV27946@ftp.linux.org.uk>
References: <20060616231213.D4C5D6AF@localhost.localdomain>
	 <20060616231215.09D54036@localhost.localdomain>
	 <20060618183320.GZ27946@ftp.linux.org.uk>
	 <1150736536.10515.52.camel@localhost.localdomain>
	 <20060620212000.GV27946@ftp.linux.org.uk>
Content-Type: text/plain
Date: Thu, 22 Jun 2006 10:01:48 -0700
Message-Id: <1150995708.10515.183.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-06-20 at 22:20 +0100, Al Viro wrote:
> On Mon, Jun 19, 2006 at 10:02:16AM -0700, Dave Hansen wrote:
> > Very true.  How about this to fix it?
> > 
> > --- lxc/fs//open.c~C8.1-fix-faccesat    2006-06-19 09:59:41.000000000 -0700
> > +++ lxc-dave/fs//open.c 2006-06-19 10:01:25.000000000 -0700
> > @@ -546,8 +546,12 @@ asmlinkage long sys_faccessat(int dfd, c
> >            special_file(nd.dentry->d_inode->i_mode))
> >                 goto out_path_release;
> > 
> > -       if(__mnt_is_readonly(nd.mnt) || IS_RDONLY(nd.dentry->d_inode))
> > -               res = -EROFS;
> > +       res = mnt_want_write(nd.mnt);
> > +       if (!res) {
> > +               mnt_drop_write(nd.mnt);
> > +               if(IS_RDONLY(nd.dentry->d_inode))
> > +                       res = -EROFS;
> > +       }
> 
> So access() can make remount r/o fail?  Uh-oh...

Good point.  Thanks for catching that.

There are probably two solutions here: rework the atomics to always give
a consistent view, even during mnt_make_readonly() calls, or keep the
mnt_make_readonly() side from executing.

We're already protecting this mnt_make_readonly() from races with itself
with a write on the mnt->mnt_sb->s_umount semaphore.  We should be able
to use a read lock on the same semaphore to exclude the
mnt_make_readonly() callers.

Thoughts?

diff -puN include/linux/mount.h~C-D8-actually-add-flags include/linux/mount.h
--- robind/include/linux/mount.h~C-D8-actually-add-flags        2006-06-20 14:11:15.000000000 -0700
+++ robind-dave/include/linux/mount.h   2006-06-20 16:01:11.000000000 -0700
@@ -91,6 +91,25 @@ static inline int __mnt_is_readonly(stru
        return (atomic_read(&mnt->mnt_writers) == 0);
 }

+/*
+ * This needs to get a consistent look at mnt_writers.
+ * Without the lock, it can race against mnt_make_readonly()
+ * and mistake a temporarily decremented mnt_writers
+ * for a real read-only mount.
+ *
+ * Note: this is never suitable if you need to perform any
+ * write *operations* on the mount, only as a snapshot.
+ */
+static inline int mnt_is_readonly(struct vfsmount *mnt)
+{
+       int ret;
+
+       down_read(&mnt->mnt_sb->s_umount);
+       ret = __mnt_is_readonly(mnt);
+       up_read(&mnt->mnt_sb->s_umount);
+       return ret;
+}
+
 static inline int mnt_want_write(struct vfsmount *mnt)
 {
        int ret = 0;
--- lxc/fs/open.c~C8.1-fix-faccesat     2006-06-22 09:43:01.000000000 -0700
+++ lxc-dave/fs/open.c  2006-06-22 09:43:01.000000000 -0700
@@ -546,8 +546,12 @@ asmlinkage long sys_faccessat(int dfd, c
           special_file(nd.dentry->d_inode->i_mode))
                goto out_path_release;

-       if(__mnt_is_readonly(nd.mnt) || IS_RDONLY(nd.dentry->d_inode))
+       if(mnt_is_readonly(nd.mnt) || IS_RDONLY(nd.dentry->d_inode))
                res = -EROFS;

 out_path_release:
        path_release(&nd);


-- Dave

