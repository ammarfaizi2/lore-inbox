Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266524AbUFQOzU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266524AbUFQOzU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 10:55:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266526AbUFQOzS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 10:55:18 -0400
Received: from [61.49.235.7] ([61.49.235.7]:22518 "EHLO adam.yggdrasil.com")
	by vger.kernel.org with ESMTP id S266524AbUFQOy1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 10:54:27 -0400
Date: Thu, 17 Jun 2004 06:45:23 -0700
From: "Adam J. Richter" <adam@yggdrasil.com>
To: Andrew Morton <akpm@osdl.org>
Cc: sfr@canb.auug.org.au, linux-kernel@vger.kernel.org, viro@math.psu.edu
Subject: Re: Patch: 2.6.7/fs/dnotify.c - make dn_lock a regular spinlock
Message-ID: <20040617064523.A7062@adam>
References: <20040617163826.A4558@freya> <20040617035313.6e1d6d93.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="sm4nu43k4a2Rpi4c"
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20040617035313.6e1d6d93.akpm@osdl.org>; from akpm@osdl.org on Thu, Jun 17, 2004 at 03:53:13AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 17, 2004 at 03:53:13AM -0700, Andrew Morton wrote:
> "Adam J. Richter" <adam@yggdrasil.com> wrote:
> >
> > 	In the near future, I expect to try to eliminate dn_lock by
> >  using parent_inode->i_sem instead, as the kmem_cache_t in dnotify.c
> >  does not need to be protected by a separate lock.
> 
> inode->i_lock would be better.  Take care to keep it an "innermost" VFS
> lock though.

	Thank you for the suggestion.  I was not aware of inode->i_lock.

	Looking at other users of inode->i_lock, I believe that using
inode->i_lock should not cause any conflict.  The lock for
inode->i_dnotify is only taken when someone calls the dnotify ioctl
or if there actually is a match to some dnotify event, so the change
in lock contention between a single dn_lock and inode->i_lock (which
is obviously used elsewhere) should be minimal.  The text + data of
the .o file generate on x86 was actually 32 bytes smaller when I
switched to inode->i_lock, and, of course, it made the source code
1 line shorter.

>Move kmem_cache_free() outside the lock altoghter.

	Per your suggestion, I've done that in fcntl_dirnotify().
This wipes out the trivial space saving from switching to
inode->i_lock, but it's probably more important to avoid holding
inode->i_lock unnecessarily anyhow.  My removal of one of the
goto labels had no effect on object code size on my x86
configuration.

	The other places that call kmem_cache_free() with the lock
held do so because they are iterating through inode->i_dnotify, and
may have to call kmem_cache_free() repeatedly.

	Here is an updated patch.


-- 
                    __     ______________
Adam J. Richter        \ /
adam@yggdrasil.com      | g g d r a s i l

--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dnotify.diff2"

--- linux-2.6.7/fs/dnotify.c	2004-06-15 22:19:09.000000000 -0700
+++ linux/fs/dnotify.c	2004-06-17 21:38:07.000000000 -0700
@@ -23,7 +23,6 @@
 
 int dir_notify_enable = 1;
 
-static rwlock_t dn_lock = RW_LOCK_UNLOCKED;
 static kmem_cache_t *dn_cache;
 
 static void redo_inode_mask(struct inode *inode)
@@ -46,7 +45,7 @@
 	inode = filp->f_dentry->d_inode;
 	if (!S_ISDIR(inode->i_mode))
 		return;
-	write_lock(&dn_lock);
+	spin_lock(&inode->i_lock);
 	prev = &inode->i_dnotify;
 	while ((dn = *prev) != NULL) {
 		if ((dn->dn_owner == id) && (dn->dn_filp == filp)) {
@@ -57,7 +56,7 @@
 		}
 		prev = &dn->dn_next;
 	}
-	write_unlock(&dn_lock);
+	spin_unlock(&inode->i_lock);
 }
 
 int fcntl_dirnotify(int fd, struct file *filp, unsigned long arg)
@@ -81,7 +80,7 @@
 	dn = kmem_cache_alloc(dn_cache, SLAB_KERNEL);
 	if (dn == NULL)
 		return -ENOMEM;
-	write_lock(&dn_lock);
+	spin_lock(&inode->i_lock);
 	prev = &inode->i_dnotify;
 	while ((odn = *prev) != NULL) {
 		if ((odn->dn_owner == id) && (odn->dn_filp == filp)) {
@@ -104,12 +103,13 @@
 	inode->i_dnotify_mask |= arg & ~DN_MULTISHOT;
 	dn->dn_next = inode->i_dnotify;
 	inode->i_dnotify = dn;
-out:
-	write_unlock(&dn_lock);
-	return error;
+	spin_unlock(&inode->i_lock);
+	return 0;
+
 out_free:
+	spin_unlock(&inode->i_lock);
 	kmem_cache_free(dn_cache, dn);
-	goto out;
+	return error;
 }
 
 void __inode_dir_notify(struct inode *inode, unsigned long event)
@@ -119,7 +119,7 @@
 	struct fown_struct *	fown;
 	int			changed = 0;
 
-	write_lock(&dn_lock);
+	spin_lock(&inode->i_lock);
 	prev = &inode->i_dnotify;
 	while ((dn = *prev) != NULL) {
 		if ((dn->dn_mask & event) == 0) {
@@ -138,7 +138,7 @@
 	}
 	if (changed)
 		redo_inode_mask(inode);
-	write_unlock(&dn_lock);
+	spin_unlock(&inode->i_lock);
 }
 
 EXPORT_SYMBOL(__inode_dir_notify);

--sm4nu43k4a2Rpi4c--
