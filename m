Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965199AbVKHFTB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965199AbVKHFTB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 00:19:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965197AbVKHFTB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 00:19:01 -0500
Received: from ns2.suse.de ([195.135.220.15]:15848 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964886AbVKHFTA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 00:19:00 -0500
From: Neil Brown <neilb@suse.de>
To: Greg KH <greg@kroah.com>
Date: Tue, 8 Nov 2005 16:18:44 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17264.13620.366210.529121@cse.unsw.edu.au>
Cc: Al Viro <viro@ftp.linux.org.uk>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       linuxram@us.ibm.com, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 4/18] make /proc/mounts pollable
In-Reply-To: message from Greg KH on Monday November 7
References: <E1EZInj-0001Ej-9n@ZenIV.linux.org.uk>
	<17264.5467.78557.38472@cse.unsw.edu.au>
	<20051108031036.GA1200@kroah.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday November 7, greg@kroah.com wrote:
> On Tue, Nov 08, 2005 at 02:02:51PM +1100, Neil Brown wrote:
> > 
> > Ahh, now this is interesting.
> 
> Yeah, if we do this, we get rid of the "mount"-like kernel uevents, as
> they were in the wrong place.
> 
> > I wonder if there is any chance of attributes in sysfs being pollable
> > too??
> 
> I haven't had anyone ask for this yet.  It might be a bit harder, as we
> would need to have a hook back to sysfs to let userspace know it had
> changed.  As long as it was optional and didn't cause any overhead for
> everyone that does not need it, I don't see why it could not be added.
> 
> All we need now is a patch :)

Here's one.  Untested, but it compiles.
I don't actually have a need for this now, but I might soon, and would
like to know if it is an option.

Comments welcome.

NeilBrown


-------------------------------
Allow sysfs attribute files to be pollable.

This is untested 'strawman' code.

It allows an attribute file in sysfs to be polled for activity.
The 'poll' interface if based on that for /proc/mounts.
I think it works like this:
  Open the file
  Read all the contents.
  Call poll requesting POLLERR
  When poll returns, read from the file again (maybe you need to close
    and reopen, may you need to lseek to the start ???)

Events are signaled by an object manager calling
   sysfs_notify(kobj, dir, attr);

If the dir is non-NULL, it is used to find a subdirectory which
contains the attribute (presumably created by sysfs_create_group).

I have no idea if there is adequate locking anywhere here.
s_event should possibly be atomic_t.

This has a cost of one int and one wait_queue_head per attribute, and
one int per file.

We could probably reduce this cost by having only one wait_queue_head per 
kobject.

The name "sysfs_notify" may be confused with the inotify
functionality.  Maybe it would be nice to support inotify for sysfs
attributes as well?

Comments welcome.

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./fs/sysfs/dir.c        |    1 +
 ./fs/sysfs/file.c       |   34 ++++++++++++++++++++++++++++++++++
 ./fs/sysfs/inode.c      |   20 ++++++++++++++++++++
 ./fs/sysfs/sysfs.h      |    1 +
 ./include/linux/sysfs.h |    3 +++
 5 files changed, 59 insertions(+)

diff ./fs/sysfs/dir.c~current~ ./fs/sysfs/dir.c
--- ./fs/sysfs/dir.c~current~	2005-11-08 15:44:16.000000000 +1100
+++ ./fs/sysfs/dir.c	2005-11-08 16:08:37.000000000 +1100
@@ -45,6 +45,7 @@ static struct sysfs_dirent * sysfs_new_d
 	atomic_set(&sd->s_count, 1);
 	INIT_LIST_HEAD(&sd->s_children);
 	list_add(&sd->s_sibling, &parent_sd->s_children);
+	init_waitqueue_head(&sd->s_poll);
 	sd->s_element = element;
 
 	return sd;

diff ./fs/sysfs/file.c~current~ ./fs/sysfs/file.c
--- ./fs/sysfs/file.c~current~	2005-11-08 15:20:34.000000000 +1100
+++ ./fs/sysfs/file.c	2005-11-08 16:09:16.000000000 +1100
@@ -7,6 +7,7 @@
 #include <linux/kobject.h>
 #include <linux/namei.h>
 #include <linux/limits.h>
+#include <linux/poll.h>
 
 #include <asm/uaccess.h>
 #include <asm/semaphore.h>
@@ -59,6 +60,7 @@ struct sysfs_buffer {
 	struct sysfs_ops	* ops;
 	struct semaphore	sem;
 	int			needs_read_fill;
+	int			event;
 };
 
 
@@ -305,10 +307,12 @@ static int check_perm(struct inode * ino
 	 */
 	buffer = kmalloc(sizeof(struct sysfs_buffer),GFP_KERNEL);
 	if (buffer) {
+		struct sysfs_dirent * sd = file->f_dentry->d_fsdata;
 		memset(buffer,0,sizeof(struct sysfs_buffer));
 		init_MUTEX(&buffer->sem);
 		buffer->needs_read_fill = 1;
 		buffer->ops = ops;
+		buffer->event = sd->s_event;
 		file->private_data = buffer;
 	} else
 		error = -ENOMEM;
@@ -357,12 +361,42 @@ static int sysfs_release(struct inode * 
 	return 0;
 }
 
+static unsigned int sysfs_poll(struct file *filp, poll_table *wait)
+{
+	struct sysfs_buffer * buffer = filp->private_data;
+	struct sysfs_dirent * sd = filp->f_dentry->d_fsdata;
+	int res = 0;
+
+	poll_wait(filp, &sd->s_poll, wait);
+
+	if (buffer->event != sd->s_event) {
+		sd->s_event = buffer->event;
+		res = POLLERR;
+	}
+	return res;
+}
+
+void sysfs_notify(struct kobject * k, char *dir, char *attr)
+{
+	struct sysfs_dirent *sd = k->dentry->d_fsdata;
+	if (sd && dir)
+		sd = sysfs_find(sd, dir);
+	if (sd && attr)
+		sd = sysfs_find(sd, attr);
+	if (sd) {
+		sd->s_event++;
+		wake_up_interruptible(&sd->s_poll);
+	}
+}
+EXPORT_SYMBOL_GPL(sysfs_notify);
+
 struct file_operations sysfs_file_operations = {
 	.read		= sysfs_read_file,
 	.write		= sysfs_write_file,
 	.llseek		= generic_file_llseek,
 	.open		= sysfs_open_file,
 	.release	= sysfs_release,
+	.poll		= sysfs_poll,
 };
 
 

diff ./fs/sysfs/inode.c~current~ ./fs/sysfs/inode.c
--- ./fs/sysfs/inode.c~current~	2005-11-08 15:52:47.000000000 +1100
+++ ./fs/sysfs/inode.c	2005-11-08 16:05:07.000000000 +1100
@@ -247,3 +247,23 @@ void sysfs_hash_and_remove(struct dentry
 }
 
 
+struct sysfs_dirent *sysfs_find(struct sysfs_dirent *dir, const char * name)
+{
+	struct sysfs_dirent * sd, * rv = NULL;
+
+	if (dir->s_dentry == NULL ||
+	    dir->s_dentry->d_inode == NULL)
+		return NULL;
+
+	down(&dir->s_dentry->d_inode->i_sem);
+	list_for_each_entry(sd, &dir->s_children, s_sibling) {
+		if (!sd->s_element)
+			continue;
+		if (!strcmp(sysfs_get_name(sd), name)) {
+			rv = sd;
+			break;
+		}
+	}
+	up(&dir->s_dentry->d_inode->i_sem);
+	return rv;
+}

diff ./fs/sysfs/sysfs.h~current~ ./fs/sysfs/sysfs.h
--- ./fs/sysfs/sysfs.h~current~	2005-11-08 16:07:23.000000000 +1100
+++ ./fs/sysfs/sysfs.h	2005-11-08 16:07:28.000000000 +1100
@@ -10,6 +10,7 @@ extern int sysfs_make_dirent(struct sysf
 
 extern int sysfs_add_file(struct dentry *, const struct attribute *, int);
 extern void sysfs_hash_and_remove(struct dentry * dir, const char * name);
+extern struct sysfs_dirent *sysfs_find(struct sysfs_dirent *dir, const char * name);
 
 extern int sysfs_create_subdir(struct kobject *, const char *, struct dentry **);
 extern void sysfs_remove_subdir(struct dentry *);

diff ./include/linux/sysfs.h~current~ ./include/linux/sysfs.h
--- ./include/linux/sysfs.h~current~	2005-11-08 15:44:52.000000000 +1100
+++ ./include/linux/sysfs.h	2005-11-08 16:01:41.000000000 +1100
@@ -11,6 +11,7 @@
 #define _SYSFS_H_
 
 #include <asm/atomic.h>
+#include <linux/wait.h>
 
 struct kobject;
 struct module;
@@ -74,6 +75,8 @@ struct sysfs_dirent {
 	umode_t			s_mode;
 	struct dentry		* s_dentry;
 	struct iattr		* s_iattr;
+	int			s_event;
+	wait_queue_head_t	s_poll;
 };
 
 #define SYSFS_ROOT		0x0001
