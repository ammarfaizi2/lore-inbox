Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131432AbRBMOVJ>; Tue, 13 Feb 2001 09:21:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131620AbRBMOU7>; Tue, 13 Feb 2001 09:20:59 -0500
Received: from [192.234.226.14] ([192.234.226.14]:36164 "EHLO
	smtp.navtechinc.com") by vger.kernel.org with ESMTP
	id <S131432AbRBMOUm>; Tue, 13 Feb 2001 09:20:42 -0500
Message-ID: <3A894282.5070909@navtechinc.com>
Date: Tue, 13 Feb 2001 09:19:46 -0500
From: "N. Jason Kleinbub" <jkleinbub@navtechinc.com>
Organization: Navtech, Inc.
User-Agent: Mozilla/5.0 (Windows; U; Win98; en-US; 0.7) Gecko/20010109
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: robs@mail.navtechinc.com
Subject: Selects on dirs/files.
Content-Type: multipart/mixed;
 boundary="------------000504090708070300050203"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000504090708070300050203
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

People,

Not sure where to go from here but ....

	( Yes I have read the FAQ )

For practical reasons, I have created some modification to the
Linux kernel.  These changes were to make our implementation of
software more convenient (elegant).  Essentially, I have modified the
select() calls to allow the non-trivial use of directories as an 'fd'.

( Aside: this has been in a production environment since 2.4.0pre9 )
( More info on the company and what we are doing via private emails,
just ask )

As this is my virginal experience I have, understandibly, a lot of
questions.

o Is there actually a new experimental kernel 2.5.x?
o Does this belong there, or is this appropriate for 2.4.x?
o What happens if Linus accepts the patchs to fs/* but the ext2/* or
reiserfs/* patches are not accepted?
o Should this be the default function if no poll operation exists? (I
think not)

I have waited until 2.4.0 settled a little bit before charging head 
along.  Additionally, I have avoided simply sending the patches to
the appropriate people because I wanted to illicit a discussion
prior to doing so.

This being my first foray into linux kernel development I crave some
constructive feedback.  For example, I have un-'static'ed the function
llseek() from fs/read_write.c because I wanted to use it in fs/readdir.c
(this was easier then moving the code from fs/readdir.c ->
fs/read_write.c and I am really into easy!)  I thought it was more
appropriate then using sys_lseek(), is this a true statement?

Additionaly you may wonder why I have choosen to examine "." and ".." in 
the filldir instead of switching on d_type.  The reason is that reiserfs 
always returns DT_UNKNOWN and I couldn't figure out,
without doing a stat(), how to put something more meaningful into 
d_type.  Reiserfs is our most likely candidate for our production 
environment so I needed both ext2 and reiserfs to work.

I have avoided using the existing wait_queue (to avoid unecessary
wakeups) and created a seperate poll wait_queue.  Good? Bad? Ugly?

The current scheme only implements the read event. That is all I
currently require. More to come, however, if this generates interest.


Please advise.

Thanks.
+-
N. Jason Kleinbub
Technical Architect/Product Manager
Navtech Weather Systems.



--------------000504090708070300050203
Content-Type: text/plain;
 name="njk.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="njk.patch"

--- /usr/src/linux-2.4.0/fs/read_write.c	Wed Feb  7 10:17:24 2001
+++ /usr/src/linux/fs/read_write.c	Thu Feb  8 12:16:47 2001
@@ -19,6 +19,7 @@
 	mmap:		generic_file_mmap,
 };
 
+
 ssize_t generic_read_dir(struct file *filp, char *buf, size_t siz, loff_t *ppos)
 {
 	return -EISDIR;
@@ -47,7 +48,7 @@
 	return retval;
 }
 
-static inline loff_t llseek(struct file *file, loff_t offset, int origin)
+loff_t llseek(struct file *file, loff_t offset, int origin)
 {
 	loff_t (*fn)(struct file *, loff_t, int);
 	loff_t retval;
--- /usr/src/linux-2.4.0/fs/readdir.c	Wed Feb  7 10:17:26 2001
+++ /usr/src/linux/fs/readdir.c	Thu Feb  8 12:16:47 2001
@@ -11,8 +11,17 @@
 #include <linux/file.h>
 #include <linux/smp_lock.h>
 
+#include <linux/poll.h>
+
 #include <asm/uaccess.h>
 
+struct getdents_callback {
+	struct linux_dirent * current_dir;
+	struct linux_dirent * previous;
+	int count;
+	int error;
+};
+
 int vfs_readdir(struct file *file, filldir_t filler, void *buf)
 {
 	struct inode *inode = file->f_dentry->d_inode;
@@ -33,6 +42,51 @@
 	return res;
 }
 
+static int fillpolldir(void *__buf, const char *name, int namlen, off_t offset,
+                       ino_t ino, unsigned int d_type)
+{
+        struct getdents_callback *buf = (struct getdents_callback *)__buf;
+	
+	/* Best to use d_type. Difficult for non ext2 fs */
+	if (name && strcmp(name, ".") && strcmp(name, "..")){
+		buf->count = 1;
+		return -EINVAL;
+	}
+	return 0;
+}
+
+unsigned int generic_poll_dir(struct file *filp, struct poll_table_struct *ptbl){
+        unsigned int mask;
+        struct inode *inode = filp->f_dentry->d_inode;
+	loff_t curpos;
+	struct getdents_callback buf;
+
+
+	/* Do I really need this.  The function should only be 'hooked' to dirops */
+	if(!S_ISDIR(inode->i_mode))
+		return 0;
+
+	poll_wait(filp, &(inode->i_pollwait), ptbl);
+
+	mask = 0;
+	
+	buf.current_dir = NULL;
+	buf.previous    = NULL;
+	buf.count       = 0;
+	buf.error       = 0;
+
+	/* Read check */
+	curpos = filp->f_pos;
+	llseek(filp, 0, 0);
+	vfs_readdir(filp, fillpolldir, &buf);
+	llseek(filp, curpos, 0);
+	if(buf.count > 0){
+		mask = POLLIN | POLLRDNORM;
+	}
+	
+        return mask;
+}
+      
 /*
  * Directory is locked and all positive dentries in it are safe, since
  * for ramfs-type trees they can't go away without unlink() or rmdir(),
@@ -176,12 +230,6 @@
 	char		d_name[1];
 };
 
-struct getdents_callback {
-	struct linux_dirent * current_dir;
-	struct linux_dirent * previous;
-	int count;
-	int error;
-};
 
 static int filldir(void * __buf, const char * name, int namlen, off_t offset,
 		   ino_t ino, unsigned int d_type)
--- /usr/src/linux-2.4.0/fs/inode.c	Wed Feb  7 10:17:26 2001
+++ /usr/src/linux/fs/inode.c	Wed Feb  7 07:32:22 2001
@@ -99,6 +99,7 @@
 	{
 		memset(inode, 0, sizeof(*inode));
 		init_waitqueue_head(&inode->i_wait);
+		init_waitqueue_head(&inode->i_pollwait);
 		INIT_LIST_HEAD(&inode->i_hash);
 		INIT_LIST_HEAD(&inode->i_data.clean_pages);
 		INIT_LIST_HEAD(&inode->i_data.dirty_pages);
--- /usr/src/linux-2.4.0/fs/namei.c	Wed Feb  7 10:17:27 2001
+++ /usr/src/linux/fs/namei.c	Wed Feb  7 07:31:38 2001
@@ -917,8 +917,10 @@
 	unlock_kernel();
 exit_lock:
 	up(&dir->i_zombie);
-	if (!error)
+	if (!error){
 		inode_dir_notify(dir, DN_CREATE);
+		wake_up_interruptible(&(dir->i_pollwait));
+	}
 	return error;
 }
 
@@ -1197,8 +1199,11 @@
 	unlock_kernel();
 exit_lock:
 	up(&dir->i_zombie);
-	if (!error)
+	if (!error){
 		inode_dir_notify(dir, DN_CREATE);
+		wake_up_interruptible(&(dir->i_pollwait));
+	}
+
 	return error;
 }
 
@@ -1266,8 +1271,11 @@
 
 exit_lock:
 	up(&dir->i_zombie);
-	if (!error)
+	if (!error){
 		inode_dir_notify(dir, DN_CREATE);
+		wake_up_interruptible(&(dir->i_pollwait));
+	}
+
 	return error;
 }
 
@@ -1358,6 +1366,7 @@
 	double_up(&dir->i_zombie, &dentry->d_inode->i_zombie);
 	if (!error) {
 		inode_dir_notify(dir, DN_DELETE);
+		wake_up_interruptible(&(dir->i_pollwait));
 		d_delete(dentry);
 	}
 	dput(dentry);
@@ -1429,8 +1438,10 @@
 		}
 	}
 	up(&dir->i_zombie);
-	if (!error)
+	if (!error){
 		inode_dir_notify(dir, DN_DELETE);
+		wake_up_interruptible(&(dir->i_pollwait));
+	}
 	return error;
 }
 
@@ -1497,8 +1508,10 @@
 
 exit_lock:
 	up(&dir->i_zombie);
-	if (!error)
+	if (!error){
 		inode_dir_notify(dir, DN_CREATE);
+		wake_up_interruptible(&(dir->i_pollwait));
+	}
 	return error;
 }
 
@@ -1571,8 +1584,11 @@
 
 exit_lock:
 	up(&dir->i_zombie);
-	if (!error)
+	if (!error){
 		inode_dir_notify(dir, DN_CREATE);
+		wake_up_interruptible(&(dir->i_pollwait));
+	}
+
 	return error;
 }
 
@@ -1791,6 +1807,8 @@
 			inode_dir_notify(old_dir, DN_DELETE);
 			inode_dir_notify(new_dir, DN_CREATE);
 		}
+		wake_up_interruptible(&(old_dir->i_pollwait));
+
 	}
 	return error;
 }
--- /usr/src/linux-2.4.0/fs/ext2/dir.c	Wed Feb  7 10:17:27 2001
+++ /usr/src/linux/fs/ext2/dir.c	Tue Feb  6 15:47:56 2001
@@ -32,6 +32,7 @@
 	readdir:	ext2_readdir,
 	ioctl:		ext2_ioctl,
 	fsync:		ext2_sync_file,
+	poll:		generic_poll_dir,
 };
 
 int ext2_check_dir_entry (const char * function, struct inode * dir,
--- /usr/src/linux-2.4.0/fs/reiserfs/dir.c	Wed Feb  7 10:17:28 2001
+++ /usr/src/linux/fs/reiserfs/dir.c	Tue Jan  9 19:16:27 2001
@@ -27,6 +27,7 @@
     read:	generic_read_dir,
     readdir:	reiserfs_readdir,
     fsync:	reiserfs_dir_fsync,
+    poll:	generic_poll_dir,
 };
 
 /*
--- /usr/src/linux-2.4.0/include/linux/fs.h	Wed Feb  7 10:17:28 2001
+++ /usr/src/linux/include/linux/fs.h	Thu Feb  8 11:04:53 2001
@@ -423,6 +423,8 @@
 	unsigned long		i_dnotify_mask; /* Directory notify events */
 	struct dnotify_struct	*i_dnotify; /* for directory notifications */
 
+	wait_queue_head_t	i_pollwait;
+
 	unsigned long		i_state;
 
 	unsigned int		i_flags;
@@ -1185,6 +1187,8 @@
 
 /* needed for stackable file system support */
 extern loff_t default_llseek(struct file *file, loff_t offset, int origin);
+extern loff_t llseek(struct file *file, loff_t offset, int origin);
+
 
 extern int __user_walk(const char *, unsigned, struct nameidata *);
 extern int path_init(const char *, unsigned, struct nameidata *);
@@ -1271,6 +1275,7 @@
 extern ssize_t generic_file_write(struct file *, const char *, size_t, loff_t *);
 extern void do_generic_file_read(struct file *, loff_t *, read_descriptor_t *, read_actor_t);
 
+extern unsigned int generic_poll_dir(struct file *filp, struct poll_table_struct *ptbl);
 extern ssize_t generic_read_dir(struct file *, char *, size_t, loff_t *);
 
 extern struct file_operations generic_ro_fops;

--------------000504090708070300050203--

