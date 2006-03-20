Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932142AbWCTGz3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932142AbWCTGz3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 01:55:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932144AbWCTGz2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 01:55:28 -0500
Received: from mx1.suse.de ([195.135.220.2]:25760 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932142AbWCTGz2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 01:55:28 -0500
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>
Date: Mon, 20 Mar 2006 17:53:53 +1100
Message-Id: <1060320065353.30933@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH-RESEND] Allow sysfs attribute files to be pollable.
References: <20060320174929.30913.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a resend of my 'make sysfs pollable' patch, which was dropped from
-mm for independant reasons.

Changes:
  Previously there was an original patch and a fix.  Now there is just
    one patch.
  The changelog mentions .../md/sync_action, but that bit was missing
    from the patch before, it is now present.
  It has been suggested that it is unfortunate that poll on an attribute 
    that doesn't support polling will block forever.  This may be unfortunate,
    but there is no real alternative as poll and select to not support 
    an error status of 'one of those fds cannot be polled'.  A comment
    above sysfs_poll explains the situation in a little more detail.

NeilBrown

### Comments for Changeset


It works like this:
  Open the file
  Read all the contents.
  Call poll requesting POLLERR or POLLPRI (so select/exceptfds works)
  When poll returns, 
     close the file and go to top of loop.
   or lseek to start of file and go back to the 'read'.

Events are signaled by an object manager calling
   sysfs_notify(kobj, dir, attr);

If the dir is non-NULL, it is used to find a subdirectory which
contains the attribute (presumably created by sysfs_create_group).

This has a cost of one int  per attribute, one wait_queuehead per kobject,
one int per open file.

The name "sysfs_notify" may be confused with the inotify
functionality.  Maybe it would be nice to support inotify for sysfs
attributes as well?

This patch also uses sysfs_notify to allow /sys/block/md*/md/sync_action
to be pollable

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./drivers/md/md.c         |    1 
 ./fs/sysfs/dir.c          |    1 
 ./fs/sysfs/file.c         |   76 ++++++++++++++++++++++++++++++++++++++++++++++
 ./fs/sysfs/sysfs.h        |    1 
 ./include/linux/kobject.h |    2 +
 ./include/linux/sysfs.h   |    6 +++
 ./lib/kobject.c           |    1 
 7 files changed, 88 insertions(+)

diff ./drivers/md/md.c~current~ ./drivers/md/md.c
--- ./drivers/md/md.c~current~	2006-03-19 15:54:13.000000000 +1100
+++ ./drivers/md/md.c	2006-03-20 16:20:31.000000000 +1100
@@ -163,6 +163,7 @@ void md_new_event(mddev_t *mddev)
 {
 	atomic_inc(&md_event_count);
 	wake_up(&md_event_waiters);
+	sysfs_notify(&mddev->kobj, NULL, "sync_action");
 }
 EXPORT_SYMBOL_GPL(md_new_event);
 /*

diff ./fs/sysfs/dir.c~current~ ./fs/sysfs/dir.c
--- ./fs/sysfs/dir.c~current~	2006-03-17 21:01:04.000000000 +1100
+++ ./fs/sysfs/dir.c	2006-03-20 15:48:27.000000000 +1100
@@ -43,6 +43,7 @@ static struct sysfs_dirent * sysfs_new_d
 
 	memset(sd, 0, sizeof(*sd));
 	atomic_set(&sd->s_count, 1);
+	atomic_set(&sd->s_event, 0);
 	INIT_LIST_HEAD(&sd->s_children);
 	list_add(&sd->s_sibling, &parent_sd->s_children);
 	sd->s_element = element;

diff ./fs/sysfs/file.c~current~ ./fs/sysfs/file.c
--- ./fs/sysfs/file.c~current~	2006-03-20 15:48:22.000000000 +1100
+++ ./fs/sysfs/file.c	2006-03-20 17:25:23.000000000 +1100
@@ -6,6 +6,7 @@
 #include <linux/fsnotify.h>
 #include <linux/kobject.h>
 #include <linux/namei.h>
+#include <linux/poll.h>
 #include <linux/limits.h>
 
 #include <asm/uaccess.h>
@@ -62,6 +63,7 @@ struct sysfs_buffer {
 	struct sysfs_ops	* ops;
 	struct semaphore	sem;
 	int			needs_read_fill;
+	int			event;
 };
 
 
@@ -77,6 +79,7 @@ struct sysfs_buffer {
  */
 static int fill_read_buffer(struct dentry * dentry, struct sysfs_buffer * buffer)
 {
+	struct sysfs_dirent * sd = dentry->d_fsdata;
 	struct attribute * attr = to_attr(dentry);
 	struct kobject * kobj = to_kobj(dentry->d_parent);
 	struct sysfs_ops * ops = buffer->ops;
@@ -88,6 +91,7 @@ static int fill_read_buffer(struct dentr
 	if (!buffer->page)
 		return -ENOMEM;
 
+	buffer->event = atomic_read(&sd->s_event);
 	count = ops->show(kobj,attr,buffer->page);
 	buffer->needs_read_fill = 0;
 	BUG_ON(count > (ssize_t)PAGE_SIZE);
@@ -362,12 +366,84 @@ static int sysfs_release(struct inode * 
 	return 0;
 }
 
+/* Sysfs attribute files are pollable.  The idea is that you read
+ * the content and then you use 'poll' or 'select' to wait for
+ * the content to change.  When the content changes (assuming the
+ * manager for the kobject supports notification), poll will
+ * return POLLERR|POLLPRI, and select will return the fd whether
+ * it is waiting for read, write, or exceptions.
+ * Once poll/select indicates that the value has changed, you
+ * need to close and re-open the file, as simply seeking and reading
+ * again will not get new data, or reset the state of 'poll'.
+ * Reminder: this only works for attributes which actively support
+ * it, and it is not possible to test an attribute from userspace
+ * to see if it supports poll (Nether 'poll' or 'select' return
+ * an appropriate error code).  When in doubt, set a suitable timeout value.
+ */
+static unsigned int sysfs_poll(struct file *filp, poll_table *wait)
+{
+	struct sysfs_buffer * buffer = filp->private_data;
+	struct kobject * kobj = to_kobj(filp->f_dentry->d_parent);
+	struct sysfs_dirent * sd = filp->f_dentry->d_fsdata;
+	int res = 0;
+
+	poll_wait(filp, &kobj->poll, wait);
+
+	if (buffer->event != atomic_read(&sd->s_event)) {
+		res = POLLERR|POLLPRI;
+		buffer->needs_read_fill = 1;
+	}
+
+	return res;
+}
+
+
+static struct dentry *step_down(struct dentry *dir, const char * name)
+{
+	struct dentry * de;
+
+	if (dir == NULL || dir->d_inode == NULL)
+		return NULL;
+
+	mutex_lock(&dir->d_inode->i_mutex);
+	de = lookup_one_len(name, dir, strlen(name));
+	mutex_unlock(&dir->d_inode->i_mutex);
+	dput(dir);
+	if (IS_ERR(de))
+		return NULL;
+	if (de->d_inode == NULL) {
+		dput(de);
+		return NULL;
+	}
+	return de;
+}
+
+void sysfs_notify(struct kobject * k, char *dir, char *attr)
+{
+	struct dentry *de = k->dentry;
+	if (de)
+		dget(de);
+	if (de && dir)
+		de = step_down(de, dir);
+	if (de && attr)
+		de = step_down(de, attr);
+	if (de) {
+		struct sysfs_dirent * sd = de->d_fsdata;
+		if (sd)
+			atomic_inc(&sd->s_event);
+		wake_up_interruptible(&k->poll);
+		dput(de);
+	}
+}
+EXPORT_SYMBOL_GPL(sysfs_notify);
+
 const struct file_operations sysfs_file_operations = {
 	.read		= sysfs_read_file,
 	.write		= sysfs_write_file,
 	.llseek		= generic_file_llseek,
 	.open		= sysfs_open_file,
 	.release	= sysfs_release,
+	.poll		= sysfs_poll,
 };
 
 

diff ./fs/sysfs/sysfs.h~current~ ./fs/sysfs/sysfs.h
--- ./fs/sysfs/sysfs.h~current~	2006-03-20 15:48:22.000000000 +1100
+++ ./fs/sysfs/sysfs.h	2006-03-20 15:48:27.000000000 +1100
@@ -11,6 +11,7 @@ extern int sysfs_make_dirent(struct sysf
 
 extern int sysfs_add_file(struct dentry *, const struct attribute *, int);
 extern void sysfs_hash_and_remove(struct dentry * dir, const char * name);
+extern struct sysfs_dirent *sysfs_find(struct sysfs_dirent *dir, const char * name);
 
 extern int sysfs_create_subdir(struct kobject *, const char *, struct dentry **);
 extern void sysfs_remove_subdir(struct dentry *);

diff ./include/linux/kobject.h~current~ ./include/linux/kobject.h
--- ./include/linux/kobject.h~current~	2006-03-20 15:48:22.000000000 +1100
+++ ./include/linux/kobject.h	2006-03-20 15:48:27.000000000 +1100
@@ -24,6 +24,7 @@
 #include <linux/rwsem.h>
 #include <linux/kref.h>
 #include <linux/kernel.h>
+#include <linux/wait.h>
 #include <asm/atomic.h>
 
 #define KOBJ_NAME_LEN			20
@@ -56,6 +57,7 @@ struct kobject {
 	struct kset		* kset;
 	struct kobj_type	* ktype;
 	struct dentry		* dentry;
+	wait_queue_head_t	poll;
 };
 
 extern int kobject_set_name(struct kobject *, const char *, ...)

diff ./include/linux/sysfs.h~current~ ./include/linux/sysfs.h
--- ./include/linux/sysfs.h~current~	2006-03-20 15:48:22.000000000 +1100
+++ ./include/linux/sysfs.h	2006-03-20 15:49:23.000000000 +1100
@@ -103,6 +103,7 @@ struct sysfs_dirent {
 	umode_t			s_mode;
 	struct dentry		*s_dentry;
 	struct iattr		*s_iattr;
+	atomic_t		s_event;
 };
 
 #define SYSFS_ROOT		0x0001
@@ -149,6 +150,7 @@ int sysfs_create_group(struct kobject *,
 void sysfs_remove_group(struct kobject *, const struct attribute_group *);
 
 void sysfs_printk_last_file(void);
+void sysfs_notify(struct kobject * k, char *dir, char *attr);
 
 #else /* CONFIG_SYSFS */
 
@@ -227,5 +229,9 @@ static inline void sysfs_printk_last_fil
 {
 }
 
+static inline void sysfs_notify(struct kobject * k, char *dir, char *attr)
+{
+}
+
 #endif /* CONFIG_SYSFS */
 #endif /* _SYSFS_H_ */

diff ./lib/kobject.c~current~ ./lib/kobject.c
--- ./lib/kobject.c~current~	2006-03-20 15:48:22.000000000 +1100
+++ ./lib/kobject.c	2006-03-20 15:48:27.000000000 +1100
@@ -128,6 +128,7 @@ void kobject_init(struct kobject * kobj)
 {
 	kref_init(&kobj->kref);
 	INIT_LIST_HEAD(&kobj->entry);
+	init_waitqueue_head(&kobj->poll);
 	kobj->kset = kset_get(kobj->kset);
 }
 
