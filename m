Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750919AbWDMP2c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750919AbWDMP2c (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 11:28:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750946AbWDMP2c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 11:28:32 -0400
Received: from smtp.osdl.org ([65.172.181.4]:3031 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750892AbWDMP2b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 11:28:31 -0400
Date: Thu, 13 Apr 2006 08:28:27 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Andrew Morton <akpm@osdl.org>, Dan Bonachea <bonachead@comcast.net>,
       linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: pthread-safety bug in write(2) on Linux 2.6.x
In-Reply-To: <Pine.LNX.4.64.0604130750240.14565@g5.osdl.org>
Message-ID: <Pine.LNX.4.64.0604130827490.14565@g5.osdl.org>
References: <6.2.5.6.2.20060412173852.033dbb90@cs.berkeley.edu>
 <20060412214613.404cf49f.akpm@osdl.org> <443DE2BD.1080103@yahoo.com.au>
 <Pine.LNX.4.64.0604130750240.14565@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 13 Apr 2006, Linus Torvalds wrote:
> 
> That said, I wouldn't be 100% against it, especially under certain 
> circumstances. However, the circumstances when I think it might be 
> acceptable are fairly specific:
> 
>  - when we use f_pos (ie we'd synchronize write against write, but only 
>    per "struct file", not on an inode basis)
>  - only for files that are marked seekable with FMODE_LSEEK (thus avoiding 
>    the stream-like objects like pipes and sockets)
> 
> Under those two circumstances, I'd certainly be ok with it, and I think we 
> could argue that it is a "good thing". It would be a "f_pos" lock (so we 
> migt do it for reads too), not a "data lock".
> 
> Comments?

Something like this.

NOTE NOTE NOTE! Untested!

		Linus
---
diff --git a/fs/file_table.c b/fs/file_table.c
index bcea199..48728cc 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -120,6 +120,7 @@ struct file *get_empty_filp(void)
 	f->f_uid = tsk->fsuid;
 	f->f_gid = tsk->fsgid;
 	eventpoll_init_file(f);
+	mutex_init(&f->f_pos_lock);
 	/* f->f_version: 0 */
 	return f;
 
diff --git a/fs/read_write.c b/fs/read_write.c
index 5bc0e92..ad9db26 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -329,14 +329,23 @@ ssize_t vfs_write(struct file *file, con
 
 EXPORT_SYMBOL(vfs_write);
 
-static inline loff_t file_pos_read(struct file *file)
+/*
+ * FMODE_LSEEK will never change for a file during its lifetime,
+ * so it's ok to test it independently on the lock/unlock path
+ * rather than explicitly remembering whether we locked it.
+ */
+static inline loff_t file_pos_read_lock(struct file *file)
 {
+	if (file->f_mode & FMODE_LSEEK)
+		mutex_lock(&file->f_pos_lock);
 	return file->f_pos;
 }
 
-static inline void file_pos_write(struct file *file, loff_t pos)
+static inline void file_pos_write_unlock(struct file *file, loff_t pos)
 {
 	file->f_pos = pos;
+	if (file->f_mode & FMODE_LSEEK)
+		mutex_unlock(&file->f_pos_lock);
 }
 
 asmlinkage ssize_t sys_read(unsigned int fd, char __user * buf, size_t count)
@@ -347,9 +356,9 @@ asmlinkage ssize_t sys_read(unsigned int
 
 	file = fget_light(fd, &fput_needed);
 	if (file) {
-		loff_t pos = file_pos_read(file);
+		loff_t pos = file_pos_read_lock(file);
 		ret = vfs_read(file, buf, count, &pos);
-		file_pos_write(file, pos);
+		file_pos_write_unlock(file, pos);
 		fput_light(file, fput_needed);
 	}
 
@@ -365,9 +374,9 @@ asmlinkage ssize_t sys_write(unsigned in
 
 	file = fget_light(fd, &fput_needed);
 	if (file) {
-		loff_t pos = file_pos_read(file);
+		loff_t pos = file_pos_read_lock(file);
 		ret = vfs_write(file, buf, count, &pos);
-		file_pos_write(file, pos);
+		file_pos_write_unlock(file, pos);
 		fput_light(file, fput_needed);
 	}
 
@@ -603,9 +612,9 @@ sys_readv(unsigned long fd, const struct
 
 	file = fget_light(fd, &fput_needed);
 	if (file) {
-		loff_t pos = file_pos_read(file);
+		loff_t pos = file_pos_read_lock(file);
 		ret = vfs_readv(file, vec, vlen, &pos);
-		file_pos_write(file, pos);
+		file_pos_write_unlock(file, pos);
 		fput_light(file, fput_needed);
 	}
 
@@ -624,9 +633,9 @@ sys_writev(unsigned long fd, const struc
 
 	file = fget_light(fd, &fput_needed);
 	if (file) {
-		loff_t pos = file_pos_read(file);
+		loff_t pos = file_pos_read_lock(file);
 		ret = vfs_writev(file, vec, vlen, &pos);
-		file_pos_write(file, pos);
+		file_pos_write_unlock(file, pos);
 		fput_light(file, fput_needed);
 	}
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 162c6e5..1d58cd0 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -643,6 +643,7 @@ struct file {
 	loff_t			f_pos;
 	struct fown_struct	f_owner;
 	unsigned int		f_uid, f_gid;
+	struct mutex		f_pos_lock;
 	struct file_ra_state	f_ra;
 
 	unsigned long		f_version;
