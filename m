Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261169AbUDUM3G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261169AbUDUM3G (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 08:29:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261186AbUDUM3G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 08:29:06 -0400
Received: from wombat.indigo.net.au ([202.0.185.19]:46084 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S261169AbUDUM25 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 08:28:57 -0400
Date: Wed, 21 Apr 2004 20:31:38 +0800 (WST)
From: raven@themaw.net
To: Christoph Hellwig <hch@infradead.org>
cc: Andrew Morton <akpm@osdl.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.6-rc1-mm1
In-Reply-To: <20040421100835.A3577@infradead.org>
Message-ID: <Pine.LNX.4.58.0404212022370.3740@donald.themaw.net>
References: <20040418230131.285aa8ae.akpm@osdl.org> <20040419202538.A15701@infradead.org>
 <Pine.LNX.4.58.0404200911090.12229@wombat.indigo.net.au>
 <20040419182657.7870aee9.akpm@osdl.org> <20040421100835.A3577@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-2.2, required 8,
	EMAIL_ATTRIBUTION, IN_REP_TO, NO_REAL_NAME, PATCH_UNIFIED_DIFF,
	QUOTED_EMAIL_TEXT, REFERENCES, REPLY_WITH_QUOTES, USER_AGENT_PINE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Apr 2004, Christoph Hellwig wrote:

> On Mon, Apr 19, 2004 at 06:26:57PM -0700, Andrew Morton wrote:
> > May as well rename that function to may_umount(), document it, suck it into
> > fs/namespace.c or fs/namei.c and export it to modules.
> > 
> > That does increase the size of the static kernel a little, so arguably we
> > shouldn't make this change until/unless we see a second user of the
> > function.
> 
> That's what I meant.  Simply exporting vfsmount_lock to modules is a no-go.
> 

Cool.

If it is decided to do this then would something like this be approiate 
Andrew?

I have
- renamed autofs4_may_umount to may_umount_tree and moved
  it to namespace.c
- removed the EXPORT_SYMBOL for vfsmount_lock
- updated autofs4 to suit

It is not possible to merge the functionality of may_umount into this as, 
it stands, as autofs v3 requires a slightly different semantic. That is if 
there are submounts that are not busy then it should return -EBUSY but 
may_umount_tree would return not busy.

--- linux-2.6.6-rc1-mm1.orig/fs/namespace.c	2004-04-20 22:08:41.000000000 +0800
+++ linux-2.6.6-rc1-mm1/fs/namespace.c	2004-04-20 23:10:08.000000000 +0800
@@ -37,8 +37,6 @@
 /* spinlock for vfsmount related operations, inplace of dcache_lock */
 spinlock_t vfsmount_lock __cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
 
-EXPORT_SYMBOL(vfsmount_lock);
-
 static struct list_head *mount_hashtable;
 static int hash_mask, hash_bits;
 static kmem_cache_t *mnt_cache; 
@@ -262,6 +260,55 @@
 	.show	= show_vfsmnt
 };
 
+/**
+ * may_umount_tree - check if a mount tree is busy
+ * @mnt: root of mount tree
+ *
+ * This is called to check if a tree of mounts has any
+ * open files, pwds or chroots. ie. if it is busy.
+ */
+int may_umount_tree(struct vfsmount *mnt)
+{
+	struct list_head *next;
+	struct vfsmount *this_parent = mnt;
+	int actual_refs;
+	int minimum_refs;
+
+	spin_lock(&vfsmount_lock);
+	actual_refs = atomic_read(&mnt->mnt_count);
+	minimum_refs = 2;
+repeat:
+	next = this_parent->mnt_mounts.next;
+resume:
+	while (next != &this_parent->mnt_mounts) {
+		struct vfsmount *p = list_entry(next, struct vfsmount, mnt_child);
+
+		next = next->next;
+
+		actual_refs += atomic_read(&p->mnt_count);
+		minimum_refs += 2;
+
+		if ( !list_empty(&p->mnt_mounts) ) {
+			this_parent = p;
+			goto repeat;
+		}
+	}
+
+	if (this_parent != mnt) {
+		next = this_parent->mnt_child.next;
+		this_parent = this_parent->mnt_parent;
+		goto resume;
+	}
+	spin_unlock(&vfsmount_lock);
+
+	if (actual_refs > minimum_refs)
+		return -EBUSY;
+
+	return 0;
+}
+
+EXPORT_SYMBOL(may_umount_tree);
+
 /*
  * Doesn't take quota and stuff into account. IOW, in some cases it will
  * give false negatives. The main reason why it's here is that we need
--- linux-2.6.6-rc1-mm1.orig/fs/autofs4/expire.c	2004-04-20 23:27:18.000000000 +0800
+++ linux-2.6.6-rc1-mm1/fs/autofs4/expire.c	2004-04-20 23:13:43.000000000 +0800
@@ -45,47 +45,6 @@
 	return 1;
 }
 
-/* Sorry I can't solve the problem without using counts either */
-static int autofs4_may_umount(struct vfsmount *mnt)
-{
-	struct list_head *next;
-	struct vfsmount *this_parent = mnt;
-	int actual_refs;
-	int minimum_refs;
-
-	spin_lock(&vfsmount_lock);
-	actual_refs = atomic_read(&mnt->mnt_count);
-	minimum_refs = 2;
-repeat:
-	next = this_parent->mnt_mounts.next;
-resume:
-	while (next != &this_parent->mnt_mounts) {
-		struct vfsmount *p = list_entry(next, struct vfsmount, mnt_child);
-
-		next = next->next;
-
-		actual_refs += atomic_read(&p->mnt_count);
-		minimum_refs += 2;
-
-		if ( !list_empty(&p->mnt_mounts) ) {
-			this_parent = p;
-			goto repeat;
-		}
-	}
-
-	if (this_parent != mnt) {
-		next = this_parent->mnt_child.next;
-		this_parent = this_parent->mnt_parent;
-		goto resume;
-	}
-	spin_unlock(&vfsmount_lock);
-
-	DPRINTK(("autofs4_may_umount: done actual = %d, minimum = %d\n",
-		 actual_refs, minimum_refs));
-
-	return actual_refs > minimum_refs;
-}
-
 /* Check a mount point for busyness return 1 if not busy, otherwise */
 static int autofs4_check_mount(struct vfsmount *mnt, struct dentry *dentry)
 {
@@ -108,7 +67,7 @@
 		goto done;
 
 	/* The big question */
-	if (autofs4_may_umount(mnt) == 0)
+	if (may_umount_tree(mnt) == 0)
 		status = 1;
 done:
 	DPRINTK(("autofs4_check_mount: returning = %d\n", status));
