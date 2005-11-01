Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965005AbVKAD6X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965005AbVKAD6X (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 22:58:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965006AbVKAD6X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 22:58:23 -0500
Received: from soundwarez.org ([217.160.171.123]:38028 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S965005AbVKAD6W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 22:58:22 -0500
Date: Tue, 1 Nov 2005 04:58:16 +0100
From: Kay Sievers <kay.sievers@vrfy.org>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Sergey Vlasov <vsu@altlinux.ru>, Roderich.Schupp.extern@mch.siemens.de,
       linux-kernel@vger.kernel.org, linux-hotplug-devel@lists.sourceforge.net,
       Greg KH <greg@kroah.com>
Subject: Re: Race between "mount" uevent and /proc/mounts?
Message-ID: <20051101035816.GA7788@vrfy.org>
References: <0AD07C7729CA42458B22AFA9C72E7011C8EF@mhha22kc.mchh.siemens.de> <20051025140041.GO7992@ftp.linux.org.uk> <20051026142710.1c3fa2da.vsu@altlinux.ru> <20051026111506.GQ7992@ftp.linux.org.uk> <20051026143417.GA18949@vrfy.org> <20051026192858.GR7992@ftp.linux.org.uk> <20051101002846.GA5097@vrfy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051101002846.GA5097@vrfy.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 01, 2005 at 01:28:46AM +0100, Kay Sievers wrote:
> On Wed, Oct 26, 2005 at 08:28:59PM +0100, Al Viro wrote:
> > On Wed, Oct 26, 2005 at 04:34:17PM +0200, Kay Sievers wrote:
> > > > Semantics for events depends on which objects you are interested in.
> > > > Existing ones do not match _any_ of the real objects and I have no
> > > > idea what exactly had been intended for them.  I've asked gregkh, but
> > > > he didn't remember that either.  Apparently they are used by different
> > > > people as (bad) approximations to different things.  Which doesn't work
> > > > well.  And until somebody cares to describe what exactly are they trying
> > > > to watch the situation obviously won't improve.
> > > 
> > > They are actually events for claim/release of a block device. As uevents
> > > are bound to kobjects we needed to send these events from an existing device
> > > which is the blockdev itself.
> > > 
> > > Sure, the event itself, has nothing to do with a filesystem. The names are
> > > like this for historical reasons and "CLAIM/RELEASE" may be less confusing.
> > > The events are used as a trigger to rescan /proc/mounts instead of polling
> > > it constantly.
> > 
> > But that makes no sense.  /proc/*/mounts changes when mount tree changes.
> > Which is obviously not an event happening to block devices.  Moreover,
> > changes of mount tree may involve no changes in the set of active filesystems
> > or be separated in time from such changes by arbitrary intervals.
> > 
> > Looks like seriously wrong assumptions in userland code working with these
> > events...  _IF_ you want to keep track of /proc/*/mounts changes, the obvious
> > solution would be to implement ->poll() for them.
> 
> Ok, makes sense. The attached seems to work for me. If we can get
> something like this, we can remove the superblock claim/release events
> completely and just read the events from the /proc/mounts file itself.

New patch. Missed a check for namespace == NULL in detach_mnt().

Thanks,
Kay

diff --git a/fs/namespace.c b/fs/namespace.c
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -26,6 +26,7 @@
 #include <asm/unistd.h>
 
 extern int __init init_rootfs(void);
+DECLARE_WAIT_QUEUE_HEAD(mounts_wait);
 
 #ifdef CONFIG_SYSFS
 extern int __init sysfs_init(void);
@@ -120,6 +121,10 @@ static void detach_mnt(struct vfsmount *
 	list_del_init(&mnt->mnt_child);
 	list_del_init(&mnt->mnt_hash);
 	old_nd->dentry->d_mounted--;
+	if (current->namespace) {
+		current->namespace->mounts_poll_pending = 1;
+		wake_up_interruptible(&mounts_wait);
+	}
 }
 
 static void attach_mnt(struct vfsmount *mnt, struct nameidata *nd)
@@ -129,6 +134,8 @@ static void attach_mnt(struct vfsmount *
 	list_add(&mnt->mnt_hash, mount_hashtable+hash(nd->mnt, nd->dentry));
 	list_add_tail(&mnt->mnt_child, &nd->mnt->mnt_mounts);
 	nd->dentry->d_mounted++;
+	current->namespace->mounts_poll_pending = 1;
+	wake_up_interruptible(&mounts_wait);
 }
 
 static struct vfsmount *next_mnt(struct vfsmount *p, struct vfsmount *root)
@@ -1093,6 +1100,7 @@ int copy_namespace(int flags, struct tas
 	atomic_set(&new_ns->count, 1);
 	init_rwsem(&new_ns->sem);
 	INIT_LIST_HEAD(&new_ns->list);
+	new_ns->mounts_poll_pending = 0;
 
 	down_write(&tsk->namespace->sem);
 	/* First pass: copy the tree topology */
@@ -1395,6 +1403,7 @@ static void __init init_mount_tree(void)
 	list_add(&mnt->mnt_list, &namespace->list);
 	namespace->root = mnt;
 	mnt->mnt_namespace = namespace;
+	namespace->mounts_poll_pending = 0;
 
 	init_task.namespace = namespace;
 	read_lock(&tasklist_lock);
diff --git a/fs/proc/base.c b/fs/proc/base.c
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -57,6 +57,7 @@
 #include <linux/init.h>
 #include <linux/file.h>
 #include <linux/string.h>
+#include <linux/poll.h>
 #include <linux/seq_file.h>
 #include <linux/namei.h>
 #include <linux/namespace.h>
@@ -660,6 +661,8 @@ static struct file_operations proc_smaps
 #endif
 
 extern struct seq_operations mounts_op;
+extern wait_queue_head_t mounts_wait;
+
 static int mounts_open(struct inode *inode, struct file *file)
 {
 	struct task_struct *task = proc_task(inode);
@@ -692,10 +695,36 @@ static int mounts_release(struct inode *
 	return seq_release(inode, file);
 }
 
+static unsigned int mounts_poll(struct file *file, poll_table *wait)
+{
+	struct task_struct *task = proc_task(file->f_dentry->d_inode);
+	struct namespace *namespace;
+	int ret = 0;
+
+	task_lock(task);
+	namespace = task->namespace;
+	if (namespace)
+		get_namespace(namespace);
+	task_unlock(task);
+
+	if (!namespace)
+		return -EINVAL;
+
+	poll_wait(file, &mounts_wait, wait);
+	if (namespace->mounts_poll_pending) {
+		namespace->mounts_poll_pending = 0;
+		ret = POLLIN | POLLRDNORM;
+	}
+	put_namespace(namespace);
+
+	return ret;
+}
+
 static struct file_operations proc_mounts_operations = {
 	.open		= mounts_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
+	.poll		= mounts_poll,
 	.release	= mounts_release,
 };
 
diff --git a/include/linux/namespace.h b/include/linux/namespace.h
--- a/include/linux/namespace.h
+++ b/include/linux/namespace.h
@@ -10,6 +10,7 @@ struct namespace {
 	struct vfsmount *	root;
 	struct list_head	list;
 	struct rw_semaphore	sem;
+	int			mounts_poll_pending;
 };
 
 extern int copy_namespace(int, struct task_struct *);

