Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965151AbWDNULd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965151AbWDNULd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 16:11:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965145AbWDNULM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 16:11:12 -0400
Received: from mail.kroah.org ([69.55.234.183]:4749 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965147AbWDNULG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 16:11:06 -0400
Cc: NeilBrown <neilb@suse.de>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 1/7] sysfs: Allow sysfs attribute files to be pollable
In-Reply-To: <20060414200037.GA5478@kroah.com>
X-Mailer: git-send-email
Date: Fri, 14 Apr 2006 13:09:56 -0700
Message-Id: <11450453963619-git-send-email-greg@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---

 drivers/md/md.c         |    1 +
 fs/sysfs/dir.c          |    1 +
 fs/sysfs/file.c         |   76 +++++++++++++++++++++++++++++++++++++++++++++++
 fs/sysfs/sysfs.h        |    1 +
 include/linux/kobject.h |    2 +
 include/linux/sysfs.h   |    6 ++++
 lib/kobject.c           |    1 +
 7 files changed, 88 insertions(+), 0 deletions(-)

4508a7a734b111b8b7e39986237d84acb1168dd0
diff --git a/drivers/md/md.c b/drivers/md/md.c
index 1ed5152..434ca39 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -163,6 +163,7 @@ void md_new_event(mddev_t *mddev)
 {
 	atomic_inc(&md_event_count);
 	wake_up(&md_event_waiters);
+	sysfs_notify(&mddev->kobj, NULL, "sync_action");
 }
 EXPORT_SYMBOL_GPL(md_new_event);
 
diff --git a/fs/sysfs/dir.c b/fs/sysfs/dir.c
index 6cfdc9a..610b5bd 100644
--- a/fs/sysfs/dir.c
+++ b/fs/sysfs/dir.c
@@ -43,6 +43,7 @@ static struct sysfs_dirent * sysfs_new_d
 
 	memset(sd, 0, sizeof(*sd));
 	atomic_set(&sd->s_count, 1);
+	atomic_set(&sd->s_event, 0);
 	INIT_LIST_HEAD(&sd->s_children);
 	list_add(&sd->s_sibling, &parent_sd->s_children);
 	sd->s_element = element;
diff --git a/fs/sysfs/file.c b/fs/sysfs/file.c
index f1cb1dd..cf37866 100644
--- a/fs/sysfs/file.c
+++ b/fs/sysfs/file.c
@@ -6,6 +6,7 @@
 #include <linux/fsnotify.h>
 #include <linux/kobject.h>
 #include <linux/namei.h>
+#include <linux/poll.h>
 #include <asm/uaccess.h>
 #include <asm/semaphore.h>
 
@@ -57,6 +58,7 @@ struct sysfs_buffer {
 	struct sysfs_ops	* ops;
 	struct semaphore	sem;
 	int			needs_read_fill;
+	int			event;
 };
 
 
@@ -72,6 +74,7 @@ struct sysfs_buffer {
  */
 static int fill_read_buffer(struct dentry * dentry, struct sysfs_buffer * buffer)
 {
+	struct sysfs_dirent * sd = dentry->d_fsdata;
 	struct attribute * attr = to_attr(dentry);
 	struct kobject * kobj = to_kobj(dentry->d_parent);
 	struct sysfs_ops * ops = buffer->ops;
@@ -83,6 +86,7 @@ static int fill_read_buffer(struct dentr
 	if (!buffer->page)
 		return -ENOMEM;
 
+	buffer->event = atomic_read(&sd->s_event);
 	count = ops->show(kobj,attr,buffer->page);
 	buffer->needs_read_fill = 0;
 	BUG_ON(count > (ssize_t)PAGE_SIZE);
@@ -348,12 +352,84 @@ static int sysfs_release(struct inode * 
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
 
 
diff --git a/fs/sysfs/sysfs.h b/fs/sysfs/sysfs.h
index 32958a7..3651ffb 100644
--- a/fs/sysfs/sysfs.h
+++ b/fs/sysfs/sysfs.h
@@ -11,6 +11,7 @@ extern int sysfs_make_dirent(struct sysf
 
 extern int sysfs_add_file(struct dentry *, const struct attribute *, int);
 extern void sysfs_hash_and_remove(struct dentry * dir, const char * name);
+extern struct sysfs_dirent *sysfs_find(struct sysfs_dirent *dir, const char * name);
 
 extern int sysfs_create_subdir(struct kobject *, const char *, struct dentry **);
 extern void sysfs_remove_subdir(struct dentry *);
diff --git a/include/linux/kobject.h b/include/linux/kobject.h
index 4cb1214..dcd0623 100644
--- a/include/linux/kobject.h
+++ b/include/linux/kobject.h
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
diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
index 392da5a..1ea5d3c 100644
--- a/include/linux/sysfs.h
+++ b/include/linux/sysfs.h
@@ -74,6 +74,7 @@ struct sysfs_dirent {
 	umode_t			s_mode;
 	struct dentry		* s_dentry;
 	struct iattr		* s_iattr;
+	atomic_t		s_event;
 };
 
 #define SYSFS_ROOT		0x0001
@@ -117,6 +118,7 @@ int sysfs_remove_bin_file(struct kobject
 
 int sysfs_create_group(struct kobject *, const struct attribute_group *);
 void sysfs_remove_group(struct kobject *, const struct attribute_group *);
+void sysfs_notify(struct kobject * k, char *dir, char *attr);
 
 #else /* CONFIG_SYSFS */
 
@@ -185,6 +187,10 @@ static inline void sysfs_remove_group(st
 	;
 }
 
+static inline void sysfs_notify(struct kobject * k, char *dir, char *attr)
+{
+}
+
 #endif /* CONFIG_SYSFS */
 
 #endif /* _SYSFS_H_ */
diff --git a/lib/kobject.c b/lib/kobject.c
index 25204a4..01d9575 100644
--- a/lib/kobject.c
+++ b/lib/kobject.c
@@ -128,6 +128,7 @@ void kobject_init(struct kobject * kobj)
 {
 	kref_init(&kobj->kref);
 	INIT_LIST_HEAD(&kobj->entry);
+	init_waitqueue_head(&kobj->poll);
 	kobj->kset = kset_get(kobj->kset);
 }
 
-- 
1.2.6


