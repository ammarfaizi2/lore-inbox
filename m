Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266416AbUFQImG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266416AbUFQImG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 04:42:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266417AbUFQImG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 04:42:06 -0400
Received: from [61.49.235.7] ([61.49.235.7]:26599 "EHLO freya.yggdrasil.com")
	by vger.kernel.org with ESMTP id S266416AbUFQIle (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 04:41:34 -0400
Date: Thu, 17 Jun 2004 16:38:26 -0700
From: "Adam J. Richter" <adam@yggdrasil.com>
To: sfr@canb.auug.org.au, linux-kernel@vger.kernel.org
Cc: viro@math.psu.edu
Subject: Patch: 2.6.7/fs/dnotify.c - make dn_lock a regular spinlock
Message-ID: <20040617163826.A4558@freya>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Stephen,

	In linux-2.6.7/fs/dnotify.c, the local varible dn_lock is
declared as rw_lock_t, but the lock is only taken exclusively.
So, let's "document" this fact, save a few bytes and save a few
cycles by changing it to spinlock_t.

	I have tried running the dnotify user level program on
a multiprocessing kernel with this change, and it seems fine.

	In the near future, I expect to try to eliminate dn_lock by
using parent_inode->i_sem instead, as the kmem_cache_t in dnotify.c
does not need to be protected by a separate lock.  However, such a
change would require changes to the callers into dnotify, which
currently make conflicting assumptions about whether they should
be holding parent_inode->i_sem, child_inode->i_sem or neither when
they call dnotify_parent or inode_dnotify, so that will require
modifying many of the places that call into dnotify.  So, I'd like
to integrate this minor change first.

	If this patch looks acceptable to you, could you please
tell the appropriate person to integrate it or advise me what to
do if you want me to proceed some other way?  I don't know if you
submit your patches directly to Linus or through someone else,
like Al Viro.

-- 
                    __     ______________ 
Adam J. Richter        \ /
adam@yggdrasil.com      | g g d r a s i l

--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dnotify.diff"

--- linux-2.6.7/fs/dnotify.c	2004-06-15 22:19:09.000000000 -0700
+++ linux/fs/dnotify.c	2004-06-17 15:07:31.000000000 -0700
@@ -23,7 +23,7 @@
 
 int dir_notify_enable = 1;
 
-static rwlock_t dn_lock = RW_LOCK_UNLOCKED;
+static spinlock_t dn_lock = SPIN_LOCK_UNLOCKED;
 static kmem_cache_t *dn_cache;
 
 static void redo_inode_mask(struct inode *inode)
@@ -46,7 +46,7 @@
 	inode = filp->f_dentry->d_inode;
 	if (!S_ISDIR(inode->i_mode))
 		return;
-	write_lock(&dn_lock);
+	spin_lock(&dn_lock);
 	prev = &inode->i_dnotify;
 	while ((dn = *prev) != NULL) {
 		if ((dn->dn_owner == id) && (dn->dn_filp == filp)) {
@@ -57,7 +57,7 @@
 		}
 		prev = &dn->dn_next;
 	}
-	write_unlock(&dn_lock);
+	spin_unlock(&dn_lock);
 }
 
 int fcntl_dirnotify(int fd, struct file *filp, unsigned long arg)
@@ -81,7 +81,7 @@
 	dn = kmem_cache_alloc(dn_cache, SLAB_KERNEL);
 	if (dn == NULL)
 		return -ENOMEM;
-	write_lock(&dn_lock);
+	spin_lock(&dn_lock);
 	prev = &inode->i_dnotify;
 	while ((odn = *prev) != NULL) {
 		if ((odn->dn_owner == id) && (odn->dn_filp == filp)) {
@@ -105,7 +105,7 @@
 	dn->dn_next = inode->i_dnotify;
 	inode->i_dnotify = dn;
 out:
-	write_unlock(&dn_lock);
+	spin_unlock(&dn_lock);
 	return error;
 out_free:
 	kmem_cache_free(dn_cache, dn);
@@ -119,7 +119,7 @@
 	struct fown_struct *	fown;
 	int			changed = 0;
 
-	write_lock(&dn_lock);
+	spin_lock(&dn_lock);
 	prev = &inode->i_dnotify;
 	while ((dn = *prev) != NULL) {
 		if ((dn->dn_mask & event) == 0) {
@@ -138,7 +138,7 @@
 	}
 	if (changed)
 		redo_inode_mask(inode);
-	write_unlock(&dn_lock);
+	spin_unlock(&dn_lock);
 }
 
 EXPORT_SYMBOL(__inode_dir_notify);

--RnlQjJ0d97Da+TV1--
