Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318226AbSGQFXe>; Wed, 17 Jul 2002 01:23:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318227AbSGQFX0>; Wed, 17 Jul 2002 01:23:26 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:19724 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318211AbSGQFUg>;
	Wed, 17 Jul 2002 01:20:36 -0400
Message-ID: <3D35012B.EE9B1ABB@zip.com.au>
Date: Tue, 16 Jul 2002 22:31:23 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 13/13] lseek speedup
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



This is a fairly dopey patch to fix up the i_sem contention in lseek.
Better ideas are welcome, but I'm offline until Monday so don't think
I'm ignoring them...

We need to decide what we really want to lock in there.  If multiple
threads are updating f_pos and/or i_size at the same time then they are
going to see strange results whatever the kernel does.  I'd maintain
that the only real obligation which the kernel has in this situation is
to not oops, to not munch data and to not return competely outlandish
results.

And the only way we can return outlandish results is on 32-bit SMP if
one CPU reads i_size or f_pos while another CPU is in the middle of
modifying it.

- We only need to take i_sem for reading i_size on 32-bit machines
  with SMP or preempt, so add the entertaining down32() and up32()
  functions for that.

- Only take i_sem in the case where we actually need to read i_size:
  SEEK_END.

  So this patch only speeds up SEEK_SET, SEEK_CUR and SEEK_END on
  64-bit.  SEEK_END on 32-bit will continue to bounce i_sem around.

- Introduce a new spinlock in struct file.  Its scope is currently
  for providing atomicity to f_pos updates.

  This lock could also be used for guarding consistency of the
  readahead state.  But after a close walkthrough the readahead code I
  don't think readahead needs any locking (apart from the 32-bit reader
  of i_size!).  Any errors in there will be +/- 1 differences in the
  numbers, and readahead just fixes things like that up anyway.

- Fiddled with the layout of struct file in an attempt to make it
  more cache-friendly.



 fs/file_table.c    |    1 
 fs/read_write.c    |   86 ++++++++++++++++++++++++++++-------------------------
 include/linux/fs.h |   15 ++++++---
 3 files changed, 57 insertions(+), 45 deletions(-)

--- 2.5.26/fs/read_write.c~lseek-speedup	Tue Jul 16 21:47:22 2002
+++ 2.5.26-akpm/fs/read_write.c	Tue Jul 16 21:47:22 2002
@@ -20,53 +20,59 @@ struct file_operations generic_ro_fops =
 	mmap:		generic_file_mmap,
 };
 
+/*
+ * Assume reads and writes of long longs are atomic on 64-bit machines
+ */
+static inline void down32(struct semaphore *sem)
+{
+#if (BITS_PER_LONG != 64) && (defined(CONFIG_SMP) || defined(CONFIG_PREEMPT))
+	down(sem);
+#endif
+}
+
+static inline void up32(struct semaphore *sem)
+{
+#if (BITS_PER_LONG != 64) && (defined(CONFIG_SMP) || defined(CONFIG_PREEMPT))
+	up(sem);
+#endif
+}
+
 loff_t generic_file_llseek(struct file *file, loff_t offset, int origin)
 {
-	long long retval;
+	loff_t retval;
 	struct inode *inode = file->f_dentry->d_inode->i_mapping->host;
 
-	down(&inode->i_sem);
-	switch (origin) {
-		case 2:
-			offset += inode->i_size;
-			break;
-		case 1:
-			offset += file->f_pos;
+	if (origin == 2) {
+		down32(&inode->i_sem);
+		offset += inode->i_size;
+		up32(&inode->i_sem);
+		spin_lock(&file->f_lock);
+	} else if (origin == 1) {
+		spin_lock(&file->f_lock);
+		offset += file->f_pos;
+	} else {
+		spin_lock(&file->f_lock);
 	}
 	retval = -EINVAL;
-	if (offset>=0 && offset<=inode->i_sb->s_maxbytes) {
+	if (offset >= 0 && offset <= inode->i_sb->s_maxbytes) {
 		if (offset != file->f_pos) {
 			file->f_pos = offset;
 			file->f_version = ++event;
 		}
 		retval = offset;
 	}
-	up(&inode->i_sem);
+	spin_unlock(&file->f_lock);
 	return retval;
 }
 
 loff_t remote_llseek(struct file *file, loff_t offset, int origin)
 {
-	long long retval;
+	loff_t ret;
 
 	lock_kernel();
-	switch (origin) {
-		case 2:
-			offset += file->f_dentry->d_inode->i_size;
-			break;
-		case 1:
-			offset += file->f_pos;
-	}
-	retval = -EINVAL;
-	if (offset>=0 && offset<=file->f_dentry->d_inode->i_sb->s_maxbytes) {
-		if (offset != file->f_pos) {
-			file->f_pos = offset;
-			file->f_version = ++event;
-		}
-		retval = offset;
-	}
+	ret = generic_file_llseek(file, offset, origin);
 	unlock_kernel();
-	return retval;
+	return ret;
 }
 
 loff_t no_llseek(struct file *file, loff_t offset, int origin)
@@ -76,15 +82,18 @@ loff_t no_llseek(struct file *file, loff
 
 loff_t default_llseek(struct file *file, loff_t offset, int origin)
 {
+	struct inode *inode = file->f_dentry->d_inode;
 	long long retval;
 
-	lock_kernel();
-	switch (origin) {
-		case 2:
-			offset += file->f_dentry->d_inode->i_size;
-			break;
-		case 1:
-			offset += file->f_pos;
+	if (origin == 2) {
+		down32(&inode->i_sem);
+		offset += inode->i_size;
+		up32(&inode->i_sem);
+	} else if (origin == 1) {
+		spin_lock(&file->f_lock);
+		offset += file->f_pos;
+	} else {
+		spin_lock(&file->f_lock);
 	}
 	retval = -EINVAL;
 	if (offset >= 0) {
@@ -94,18 +103,15 @@ loff_t default_llseek(struct file *file,
 		}
 		retval = offset;
 	}
-	unlock_kernel();
+	spin_unlock(&file->f_lock);
 	return retval;
 }
 
 static inline loff_t llseek(struct file *file, loff_t offset, int origin)
 {
-	loff_t (*fn)(struct file *, loff_t, int);
-
-	fn = default_llseek;
 	if (file->f_op && file->f_op->llseek)
-		fn = file->f_op->llseek;
-	return fn(file, offset, origin);
+		return (*file->f_op->llseek)(file, offset, origin);
+	return default_llseek(file, offset, origin);
 }
 
 asmlinkage off_t sys_lseek(unsigned int fd, off_t offset, unsigned int origin)
--- 2.5.26/include/linux/fs.h~lseek-speedup	Tue Jul 16 21:47:22 2002
+++ 2.5.26-akpm/include/linux/fs.h	Tue Jul 16 21:47:22 2002
@@ -475,20 +475,25 @@ struct file_ra_state {
 };
 
 struct file {
-	struct list_head	f_list;
 	struct dentry		*f_dentry;
+	struct list_head	f_list;
 	struct vfsmount         *f_vfsmnt;
-	struct file_operations	*f_op;
-	atomic_t		f_count;
+
 	unsigned int 		f_flags;
 	mode_t			f_mode;
+	struct file_operations	*f_op;
+	unsigned long		f_version;
+
+	atomic_t		f_count;
+	spinlock_t		f_lock;	/* for f_pos atomicity */
 	loff_t			f_pos;
+
 	struct fown_struct	f_owner;
-	unsigned int		f_uid, f_gid;
+	unsigned int		f_uid;
+	unsigned int		f_gid;
 	int			f_error;
 	struct file_ra_state	f_ra;
 
-	unsigned long		f_version;
 
 	/* needed for tty driver, and maybe others */
 	void			*private_data;
--- 2.5.26/fs/file_table.c~lseek-speedup	Tue Jul 16 21:47:22 2002
+++ 2.5.26-akpm/fs/file_table.c	Tue Jul 16 21:47:22 2002
@@ -44,6 +44,7 @@ struct file * get_empty_filp(void)
 	new_one:
 		memset(f, 0, sizeof(*f));
 		atomic_set(&f->f_count,1);
+		spin_lock_init(&f->f_lock);
 		f->f_version = ++event;
 		f->f_uid = current->fsuid;
 		f->f_gid = current->fsgid;

.
