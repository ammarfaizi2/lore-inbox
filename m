Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316961AbSFQTrj>; Mon, 17 Jun 2002 15:47:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316962AbSFQTri>; Mon, 17 Jun 2002 15:47:38 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:10491 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S316961AbSFQTrh>; Mon, 17 Jun 2002 15:47:37 -0400
Date: Mon, 17 Jun 2002 15:47:38 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [patch] 2.5.22 add __fput for aio
Message-ID: <20020617154738.B1457@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

This patch splits fput into fput and __fput.  __fput is needed by aio 
to construct a mechanism for performing fput during io completion, 
which typically occurs during interrupt context.

		-ben
-- 
"You will be reincarnated as a toad; and you will be much happier."

diff -urN v2.5.22/fs/file_table.c fput-v2.5.22/fs/file_table.c
--- v2.5.22/fs/file_table.c	Thu Jun  6 00:35:32 2002
+++ fput-v2.5.22/fs/file_table.c	Mon Jun 17 15:43:10 2002
@@ -100,31 +100,38 @@
 
 void fput(struct file * file)
 {
+	if (atomic_dec_and_test(&file->f_count))
+		__fput(file);
+}
+
+/* __fput is needed for aio, which provides a mechanism for doing fput 
+ * from an interrupt handler.
+ */
+void __fput(struct file * file)
+{
 	struct dentry * dentry = file->f_dentry;
 	struct vfsmount * mnt = file->f_vfsmnt;
 	struct inode * inode = dentry->d_inode;
 
-	if (atomic_dec_and_test(&file->f_count)) {
-		locks_remove_flock(file);
+	locks_remove_flock(file);
 
-		if (file->f_iobuf)
-			free_kiovec(1, &file->f_iobuf);
+	if (file->f_iobuf)
+		free_kiovec(1, &file->f_iobuf);
 
-		if (file->f_op && file->f_op->release)
-			file->f_op->release(inode, file);
-		fops_put(file->f_op);
-		if (file->f_mode & FMODE_WRITE)
-			put_write_access(inode);
-		file_list_lock();
-		file->f_dentry = NULL;
-		file->f_vfsmnt = NULL;
-		list_del(&file->f_list);
-		list_add(&file->f_list, &free_list);
-		files_stat.nr_free_files++;
-		file_list_unlock();
-		dput(dentry);
-		mntput(mnt);
-	}
+	if (file->f_op && file->f_op->release)
+		file->f_op->release(inode, file);
+	fops_put(file->f_op);
+	if (file->f_mode & FMODE_WRITE)
+		put_write_access(inode);
+	file_list_lock();
+	file->f_dentry = NULL;
+	file->f_vfsmnt = NULL;
+	list_del(&file->f_list);
+	list_add(&file->f_list, &free_list);
+	files_stat.nr_free_files++;
+	file_list_unlock();
+	dput(dentry);
+	mntput(mnt);
 }
 
 struct file * fget(unsigned int fd)
diff -urN v2.5.22/include/linux/file.h fput-v2.5.22/include/linux/file.h
--- v2.5.22/include/linux/file.h	Thu Jun  6 00:35:16 2002
+++ fput-v2.5.22/include/linux/file.h	Mon Jun 17 15:43:11 2002
@@ -33,6 +33,7 @@
         struct file * fd_array[NR_OPEN_DEFAULT];
 };
 
+extern void FASTCALL(__fput(struct file *));
 extern void FASTCALL(fput(struct file *));
 extern struct file * FASTCALL(fget(unsigned int fd));
 extern void FASTCALL(set_close_on_exec(unsigned int fd, int flag));
