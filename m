Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261561AbSKXSUU>; Sun, 24 Nov 2002 13:20:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261574AbSKXSUU>; Sun, 24 Nov 2002 13:20:20 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:57865 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261561AbSKXSUT>;
	Sun, 24 Nov 2002 13:20:19 -0500
Date: Sun, 24 Nov 2002 18:27:31 +0000
From: Matthew Wilcox <willy@debian.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org,
       Janitors <kernel-janitor-discuss@lists.sourceforge.net>,
       Trivial Kernel Patches <trivial@rustcorp.com.au>
Subject: [PATCH] Tidy up dupfd() a little
Message-ID: <20021124182731.D2800@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Walter Harms pointed out the locking was rather obtuse in dupfd.  This
patch makes it much clearer.

diff -urpNX dontdiff linux-2.5.49/fs/fcntl.c linux-2.5.49-flock/fs/fcntl.c
--- linux-2.5.49/fs/fcntl.c	2002-10-16 05:21:24.000000000 -0700
+++ linux-2.5.49-flock/fs/fcntl.c	2002-11-24 10:14:09.000000000 -0800
@@ -75,8 +75,8 @@ static int expand_files(struct files_str
 
 /*
  * locate_fd finds a free file descriptor in the open_fds fdset,
- * expanding the fd arrays if necessary.  The files write lock will be
- * held on exit to ensure that the fd can be entered atomically.
+ * expanding the fd arrays if necessary.  Must be called with the
+ * file_lock held for write.
  */
 
 static int locate_fd(struct files_struct *files, 
@@ -86,8 +86,6 @@ static int locate_fd(struct files_struct
 	int error;
 	int start;
 
-	write_lock(&files->file_lock);
-	
 	error = -EINVAL;
 	if (orig_start >= current->rlim[RLIMIT_NOFILE].rlim_cur)
 		goto out;
@@ -131,30 +129,24 @@ out:
 	return error;
 }
 
-static inline void allocate_fd(struct files_struct *files, 
-					struct file *file, int fd)
-{
-	FD_SET(fd, files->open_fds);
-	FD_CLR(fd, files->close_on_exec);
-	write_unlock(&files->file_lock);
-	fd_install(fd, file);
-}
-
 static int dupfd(struct file *file, int start)
 {
 	struct files_struct * files = current->files;
-	int ret;
+	int fd;
 
-	ret = locate_fd(files, file, start);
-	if (ret < 0) 
-		goto out_putf;
-	allocate_fd(files, file, ret);
-	return ret;
+	write_lock(&files->file_lock);
+	fd = locate_fd(files, file, start);
+	if (fd >= 0) {
+		FD_SET(fd, files->open_fds);
+		FD_CLR(fd, files->close_on_exec);
+		write_unlock(&files->file_lock);
+		fd_install(fd, file);
+	} else {
+		write_unlock(&files->file_lock);
+		fput(file);
+	}
 
-out_putf:
-	write_unlock(&files->file_lock);
-	fput(file);
-	return ret;
+	return fd;
 }
 
 asmlinkage long sys_dup2(unsigned int oldfd, unsigned int newfd)

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
