Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932394AbWBYPx3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932394AbWBYPx3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 10:53:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932469AbWBYPx3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 10:53:29 -0500
Received: from smtp108.mail.mud.yahoo.com ([209.191.85.218]:34896 "HELO
	smtp108.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932394AbWBYPx2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 10:53:28 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type;
  b=rAkaqo90PsB61d3GoPNBgApgVkUIiNXbD2HwppdtTzYtfkzgZZR04B5ekm1XtTrgJ3azY+7shsNIfp8pwUECp4sPie3C0v4N/9V7sxIBKTj3YA0cWs2z3nbcdPv/kjgs67xHc+i40QZ5tAhEiPnVQHJpv3hVZW58nrfnuFJ0gTY=  ;
Message-ID: <44007D6C.6020909@yahoo.com.au>
Date: Sun, 26 Feb 2006 02:53:16 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Robin Holt <holt@SGI.com>
CC: Andrew Morton <akpm@osdl.org>, John McCutchan <john@johnmccutchan.com>,
       linux-kernel@vger.kernel.org, rml@novell.com, hch@lst.de,
       linux-fsdevel@vger.kernel.org
Subject: [patch] inotify: lock avoidance with parent watch status in dentry
References: <20060222134250.GE20786@lnx-holt.americas.sgi.com> <1140626903.13461.5.camel@localhost.localdomain> <20060222175030.GB30556@lnx-holt.americas.sgi.com> <1140648776.1729.5.camel@localhost.localdomain> <20060222151223.5c9061fd.akpm@osdl.org> <1140651662.2985.2.camel@localhost.localdomain> <20060223161425.4388540e.akpm@osdl.org> <20060224054724.GA8593@johnmccutchan.com> <20060223220053.2f7a977e.akpm@osdl.org> <43FEB0BF.6080403@yahoo.com.au> <20060224185632.GB343@lnx-holt.americas.sgi.com>
In-Reply-To: <20060224185632.GB343@lnx-holt.americas.sgi.com>
Content-Type: multipart/mixed;
 boundary="------------050503020504030905020804"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050503020504030905020804
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This is about as far as my inotify/vfs knowledge takes me. Comments
would be appreciated, in particular whether locking and core vfs
parts look OK (eg. inotify_d_instantiate takes ->d_lock - might
that be possible to avoid? is d_move the best place for the move hook?)

The patch is tested with a basic inotify tester, moving files in and
out of watched directory, creating, deleting, overwriting, etc.

(sorry it is an attachment, I'm having technical difficulties)

-- 
SUSE Labs, Novell Inc.

--------------050503020504030905020804
Content-Type: text/plain;
 name="inotify-dentry-flag.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="inotify-dentry-flag.patch"

Previous inotify work avoidance is good when inotify is completely
unused, but it breaks down if even a single watch is in place anywhere
in the system. Robin Holt notices that udev is one such culprit - it
slows down a 512-thread application on a 512 CPU system from 6 seconds
to 22 minutes.

Solve this by adding a flag in the dentry that tells inotify whether
or not its parent inode has a watch on it. Event queueing to parent
will skip taking locks if this flag is cleared. Setting and clearing
of this flag on all child dentries versus event delivery: this is no
different to the way that inode_watches modifications was implemented,
in terms of race cases, and that was shown to be equivalent to always
performing the check.

The essential behaviour is that activity occuring _after_ a watch has
been added and _before_ it has been removed, will generate events. 

Signed-off-by: Nick Piggin <npiggin@suse.de>


Index: linux-2.6/fs/dcache.c
===================================================================
--- linux-2.6.orig/fs/dcache.c
+++ linux-2.6/fs/dcache.c
@@ -799,6 +799,7 @@ void d_instantiate(struct dentry *entry,
 	if (inode)
 		list_add(&entry->d_alias, &inode->i_dentry);
 	entry->d_inode = inode;
+	fsnotify_d_instantiate(entry, inode);
 	spin_unlock(&dcache_lock);
 	security_d_instantiate(entry, inode);
 }
@@ -850,6 +851,7 @@ struct dentry *d_instantiate_unique(stru
 	list_add(&entry->d_alias, &inode->i_dentry);
 do_negative:
 	entry->d_inode = inode;
+	fsnotify_d_instantiate(entry, inode);
 	spin_unlock(&dcache_lock);
 	security_d_instantiate(entry, inode);
 	return NULL;
@@ -980,6 +982,7 @@ struct dentry *d_splice_alias(struct ino
 		new = __d_find_alias(inode, 1);
 		if (new) {
 			BUG_ON(!(new->d_flags & DCACHE_DISCONNECTED));
+			fsnotify_d_instantiate(new, inode);
 			spin_unlock(&dcache_lock);
 			security_d_instantiate(new, inode);
 			d_rehash(dentry);
@@ -989,6 +992,7 @@ struct dentry *d_splice_alias(struct ino
 			/* d_instantiate takes dcache_lock, so we do it by hand */
 			list_add(&dentry->d_alias, &inode->i_dentry);
 			dentry->d_inode = inode;
+			fsnotify_d_instantiate(dentry, inode);
 			spin_unlock(&dcache_lock);
 			security_d_instantiate(dentry, inode);
 			d_rehash(dentry);
@@ -1339,6 +1343,7 @@ already_unhashed:
 
 	list_add(&dentry->d_u.d_child, &dentry->d_parent->d_subdirs);
 	spin_unlock(&target->d_lock);
+	fsnotify_d_move(dentry);
 	spin_unlock(&dentry->d_lock);
 	write_sequnlock(&rename_lock);
 	spin_unlock(&dcache_lock);
Index: linux-2.6/fs/inotify.c
===================================================================
--- linux-2.6.orig/fs/inotify.c
+++ linux-2.6/fs/inotify.c
@@ -38,7 +38,6 @@
 #include <asm/ioctls.h>
 
 static atomic_t inotify_cookie;
-static atomic_t inotify_watches;
 
 static kmem_cache_t *watch_cachep;
 static kmem_cache_t *event_cachep;
@@ -381,6 +380,41 @@ static int find_inode(const char __user 
 }
 
 /*
+ * inotify_inode_watched - returns nonzero if there are watches on this inode
+ * and zero otherwise.  We call this lockless, we do not care if we race.
+ */
+static inline int inotify_inode_watched(struct inode *inode)
+{
+	return !list_empty(&inode->inotify_watches);
+}
+
+/*
+ * Get child dentry flag into synch with parent inode.
+ */
+static void set_dentry_child_flags(struct inode *inode, int watched)
+{
+	struct dentry *alias;
+
+	spin_lock(&dcache_lock);
+	list_for_each_entry(alias, &inode->i_dentry, d_alias) {
+		struct dentry *child;
+
+		list_for_each_entry(child, &alias->d_subdirs, d_u.d_child) {
+			spin_lock(&child->d_lock);
+			if (watched) {
+				WARN_ON(child->d_flags & DCACHE_INOTIFY_PARENT_WATCHED);
+				child->d_flags |= DCACHE_INOTIFY_PARENT_WATCHED;
+			} else {
+				WARN_ON(!(child->d_flags & DCACHE_INOTIFY_PARENT_WATCHED));
+				child->d_flags &= ~DCACHE_INOTIFY_PARENT_WATCHED;
+			}
+			spin_unlock(&child->d_lock);
+		}
+	}
+	spin_unlock(&dcache_lock);
+}
+
+/*
  * create_watch - creates a watch on the given device.
  *
  * Callers must hold dev->sem.  Calls inotify_dev_get_wd() so may sleep.
@@ -426,7 +460,6 @@ static struct inotify_watch *create_watc
 	get_inotify_watch(watch);
 
 	atomic_inc(&dev->user->inotify_watches);
-	atomic_inc(&inotify_watches);
 
 	return watch;
 }
@@ -458,8 +491,10 @@ static void remove_watch_no_event(struct
 	list_del(&watch->i_list);
 	list_del(&watch->d_list);
 
+	if (!inotify_inode_watched(watch->inode))
+		set_dentry_child_flags(watch->inode, 0);
+
 	atomic_dec(&dev->user->inotify_watches);
-	atomic_dec(&inotify_watches);
 	idr_remove(&dev->idr, watch->wd);
 	put_inotify_watch(watch);
 }
@@ -481,16 +516,39 @@ static void remove_watch(struct inotify_
 	remove_watch_no_event(watch, dev);
 }
 
+/* Kernel API */
+
 /*
- * inotify_inode_watched - returns nonzero if there are watches on this inode
- * and zero otherwise.  We call this lockless, we do not care if we race.
+ * inotify_d_instantiate - instantiate dcache entry for inode
  */
-static inline int inotify_inode_watched(struct inode *inode)
+void inotify_d_instantiate(struct dentry *entry, struct inode *inode)
 {
-	return !list_empty(&inode->inotify_watches);
+	struct dentry *parent;
+
+	if (!inode)
+		return;
+
+	WARN_ON(entry->d_flags & DCACHE_INOTIFY_PARENT_WATCHED);
+	spin_lock(&entry->d_lock);
+	parent = entry->d_parent;
+	if (inotify_inode_watched(parent->d_inode))
+		entry->d_flags |= DCACHE_INOTIFY_PARENT_WATCHED;
+	spin_unlock(&entry->d_lock);
 }
 
-/* Kernel API */
+/*
+ * inotify_d_move - dcache entry has been moved
+ */
+void inotify_d_move(struct dentry *entry)
+{
+	struct dentry *parent;
+
+	parent = entry->d_parent;
+	if (inotify_inode_watched(parent->d_inode))
+		entry->d_flags |= DCACHE_INOTIFY_PARENT_WATCHED;
+	else
+		entry->d_flags &= ~DCACHE_INOTIFY_PARENT_WATCHED;
+}
 
 /**
  * inotify_inode_queue_event - queue an event to all watches on this inode
@@ -538,7 +596,7 @@ void inotify_dentry_parent_queue_event(s
 	struct dentry *parent;
 	struct inode *inode;
 
-	if (!atomic_read (&inotify_watches))
+	if (!(dentry->d_flags & DCACHE_INOTIFY_PARENT_WATCHED))
 		return;
 
 	spin_lock(&dentry->d_lock);
@@ -993,6 +1051,9 @@ asmlinkage long sys_inotify_add_watch(in
 		goto out;
 	}
 
+	if (!inotify_inode_watched(inode))
+		set_dentry_child_flags(inode, 1);
+
 	/* Add the watch to the device's and the inode's list */
 	list_add(&watch->d_list, &dev->watches);
 	list_add(&watch->i_list, &inode->inotify_watches);
@@ -1065,7 +1126,6 @@ static int __init inotify_setup(void)
 	inotify_max_user_watches = 8192;
 
 	atomic_set(&inotify_cookie, 0);
-	atomic_set(&inotify_watches, 0);
 
 	watch_cachep = kmem_cache_create("inotify_watch_cache",
 					 sizeof(struct inotify_watch),
Index: linux-2.6/include/linux/dcache.h
===================================================================
--- linux-2.6.orig/include/linux/dcache.h
+++ linux-2.6/include/linux/dcache.h
@@ -162,6 +162,8 @@ d_iput:		no		no		no       yes
 #define DCACHE_REFERENCED	0x0008  /* Recently used, don't discard. */
 #define DCACHE_UNHASHED		0x0010	
 
+#define DCACHE_INOTIFY_PARENT_WATCHED	0x0020 /* Parent inode is watched */
+
 extern spinlock_t dcache_lock;
 
 /**
Index: linux-2.6/include/linux/fsnotify.h
===================================================================
--- linux-2.6.orig/include/linux/fsnotify.h
+++ linux-2.6/include/linux/fsnotify.h
@@ -17,6 +17,25 @@
 #include <linux/inotify.h>
 
 /*
+ * fsnotify_d_instantiate - instantiate a dentry for inode
+ * Called with dcache_lock held.
+ */
+static inline void fsnotify_d_instantiate(struct dentry *entry,
+						struct inode *inode)
+{
+	inotify_d_instantiate(entry, inode);
+}
+
+/*
+ * fsnotify_d_move - entry has been moved
+ * Called with dcache_lock and entry->d_lock held.
+ */
+static inline void fsnotify_d_move(struct dentry *entry)
+{
+	inotify_d_move(entry);
+}
+
+/*
  * fsnotify_move - file old_name at old_dir was moved to new_name at new_dir
  */
 static inline void fsnotify_move(struct inode *old_dir, struct inode *new_dir,
Index: linux-2.6/include/linux/inotify.h
===================================================================
--- linux-2.6.orig/include/linux/inotify.h
+++ linux-2.6/include/linux/inotify.h
@@ -71,6 +71,8 @@ struct inotify_event {
 
 #ifdef CONFIG_INOTIFY
 
+extern void inotify_d_instantiate(struct dentry *, struct inode *);
+extern void inotify_d_move(struct dentry *);
 extern void inotify_inode_queue_event(struct inode *, __u32, __u32,
 				      const char *);
 extern void inotify_dentry_parent_queue_event(struct dentry *, __u32, __u32,
@@ -81,6 +83,14 @@ extern u32 inotify_get_cookie(void);
 
 #else
 
+static inline void inotify_d_instantiate(struct dentry *, struct inode *)
+{
+}
+
+static inline void inotify_d_move(struct dentry *)
+{
+}
+
 static inline void inotify_inode_queue_event(struct inode *inode,
 					     __u32 mask, __u32 cookie,
 					     const char *filename)

--------------050503020504030905020804--
Send instant messages to your online friends http://au.messenger.yahoo.com 
