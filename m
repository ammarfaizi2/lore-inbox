Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312791AbSDBFMz>; Tue, 2 Apr 2002 00:12:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312792AbSDBFMr>; Tue, 2 Apr 2002 00:12:47 -0500
Received: from Cambot.lecs.CS.UCLA.EDU ([131.179.144.110]:33032 "EHLO
	cambot.lecs.cs.ucla.edu") by vger.kernel.org with ESMTP
	id <S312791AbSDBFMl>; Tue, 2 Apr 2002 00:12:41 -0500
Message-Id: <200204020512.g325CYk19677@cambot.lecs.cs.ucla.edu>
To: linux-kernel@vger.kernel.org
cc: viro@math.psu.edu, mjp@pilcrow.madison.wi.us
Subject: [PATCH] [2.5.7] Deliver SIGIO to FIFO and pipe devices
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <19674.1017724354.1@cambot.lecs.cs.ucla.edu>
Date: Mon, 01 Apr 2002 21:12:34 -0800
From: Jeremy Elson <jelson@circlemud.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ I'm cc:ing this to Al Viro, who (despite his protestations to the
contrary) seems to be the closest thing we have to an FS subsystem
maintainer :-) ]

The patch below lets userspace apps do SIGIO-driven I/O on FIFOs and
pipes.  The semantics are the same as for existing SIGIO-capable
devices such as sockets.  The lack of SIGIO has broken things before
(e.g., http://www.uwsg.iu.edu/hypermail/linux/kernel/0004.3/0179.html
and
http://linux.ucla.edu/pipermail/linux/2001-August/005646.html).

I originally posted this patch (against 2.4.x) to the list last
August, and since then have heard from a half-dozen people who have
used it successfully.  Our lab's 30 workstations have been using it
for 9 months with no problems under 2.4.9.  So, I thought I'd ping the
list again and see if there's any interest in integrating it with the
main line kernel.

The patches for 2.5.7 and 2.4.x are available at:

http://www.circlemud.org/~jelson/linux/fifo-sigio-2.5.7.patch
http://www.circlemud.org/~jelson/linux/fifo-sigio-2.4.patch

The 2.5.7 patch is also attached below.

Best,
Jeremy

diff -u --recursive linux-2.5.7-orig/fs/pipe.c linux-2.5.7/fs/pipe.c
--- linux-2.5.7-orig/fs/pipe.c	Mon Mar 18 12:37:02 2002
+++ linux-2.5.7/fs/pipe.c	Mon Apr  1 20:47:10 2002
@@ -22,6 +22,9 @@
  * 
  * Reads with count = 0 should always return 0.
  * -- Julian Bradfield 1999-06-07.
+ *
+ * FIFOs and Pipes now generate SIGIO for both readers and writers.
+ * -- Jeremy Elson <jelson@circlemud.org> 2001-08-16
  */
 
 /* Drop the inode semaphore and wait for a pipe event, atomically */
@@ -117,12 +120,14 @@
 		 * room.
 		 */
 		wake_up_interruptible(PIPE_WAIT(*inode));
+ 		kill_fasync(PIPE_FASYNC_WRITERS(*inode), SIGIO, POLL_OUT);
 		if (!PIPE_EMPTY(*inode))
 			BUG();
 		goto do_more_read;
 	}
 	/* Signal writers asynchronously that there is more room.  */
 	wake_up_interruptible(PIPE_WAIT(*inode));
+ 	kill_fasync(PIPE_FASYNC_WRITERS(*inode), SIGIO, POLL_OUT);
 
 	ret = read;
 out:
@@ -215,6 +220,7 @@
 			 * to do idle reschedules.
 			 */
 			wake_up_interruptible(PIPE_WAIT(*inode));
+ 			kill_fasync(PIPE_FASYNC_READERS(*inode), SIGIO, POLL_IN);
 			PIPE_WAITING_WRITERS(*inode)++;
 			pipe_wait(inode);
 			PIPE_WAITING_WRITERS(*inode)--;
@@ -228,6 +234,7 @@
 
 	/* Signal readers asynchronously that there is more data.  */
 	wake_up_interruptible(PIPE_WAIT(*inode));
+	kill_fasync(PIPE_FASYNC_READERS(*inode), SIGIO, POLL_IN);
 
 	inode->i_ctime = inode->i_mtime = CURRENT_TIME;
 	mark_inode_dirty(inode);
@@ -308,6 +315,8 @@
 		kfree(info);
 	} else {
 		wake_up_interruptible(PIPE_WAIT(*inode));
+		kill_fasync(PIPE_FASYNC_READERS(*inode), SIGIO, POLL_IN);
+		kill_fasync(PIPE_FASYNC_WRITERS(*inode), SIGIO, POLL_OUT);
 	}
 	up(PIPE_SEM(*inode));
 
@@ -315,14 +324,72 @@
 }
 
 static int
+pipe_read_fasync(int fd, struct file *filp, int on)
+{
+	struct inode *inode = filp->f_dentry->d_inode;
+	int retval;
+
+	down(PIPE_SEM(*inode));
+	retval = fasync_helper(fd, filp, on, PIPE_FASYNC_READERS(*inode));
+	up(PIPE_SEM(*inode));
+
+	if (retval < 0)
+		return retval;
+
+	return 0;
+}
+
+
+static int
+pipe_write_fasync(int fd, struct file *filp, int on)
+{
+	struct inode *inode = filp->f_dentry->d_inode;
+	int retval;
+
+	down(PIPE_SEM(*inode));
+	retval = fasync_helper(fd, filp, on, PIPE_FASYNC_WRITERS(*inode));
+	up(PIPE_SEM(*inode));
+
+	if (retval < 0)
+		return retval;
+
+	return 0;
+}
+
+
+static int
+pipe_rdwr_fasync(int fd, struct file *filp, int on)
+{
+	struct inode *inode = filp->f_dentry->d_inode;
+	int retval;
+
+	down(PIPE_SEM(*inode));
+
+	retval = fasync_helper(fd, filp, on, PIPE_FASYNC_READERS(*inode));
+
+	if (retval >= 0)
+		retval = fasync_helper(fd, filp, on, PIPE_FASYNC_WRITERS(*inode));
+
+	up(PIPE_SEM(*inode));
+
+	if (retval < 0)
+		return retval;
+
+	return 0;
+}
+
+
+static int
 pipe_read_release(struct inode *inode, struct file *filp)
 {
+	pipe_read_fasync(-1, filp, 0);
 	return pipe_release(inode, 1, 0);
 }
 
 static int
 pipe_write_release(struct inode *inode, struct file *filp)
 {
+	pipe_write_fasync(-1, filp, 0);
 	return pipe_release(inode, 0, 1);
 }
 
@@ -331,6 +398,7 @@
 {
 	int decr, decw;
 
+	pipe_rdwr_fasync(-1, filp, 0);
 	decr = (filp->f_mode & FMODE_READ) != 0;
 	decw = (filp->f_mode & FMODE_WRITE) != 0;
 	return pipe_release(inode, decr, decw);
@@ -383,6 +451,7 @@
 	ioctl:		pipe_ioctl,
 	open:		pipe_read_open,
 	release:	pipe_read_release,
+	fasync:         pipe_read_fasync,
 };
 
 struct file_operations write_fifo_fops = {
@@ -393,6 +462,7 @@
 	ioctl:		pipe_ioctl,
 	open:		pipe_write_open,
 	release:	pipe_write_release,
+	fasync:         pipe_write_fasync,
 };
 
 struct file_operations rdwr_fifo_fops = {
@@ -403,6 +473,7 @@
 	ioctl:		pipe_ioctl,
 	open:		pipe_rdwr_open,
 	release:	pipe_rdwr_release,
+	fasync:         pipe_rdwr_fasync,
 };
 
 struct file_operations read_pipe_fops = {
@@ -413,6 +484,7 @@
 	ioctl:		pipe_ioctl,
 	open:		pipe_read_open,
 	release:	pipe_read_release,
+	fasync:         pipe_read_fasync,
 };
 
 struct file_operations write_pipe_fops = {
@@ -423,6 +495,7 @@
 	ioctl:		pipe_ioctl,
 	open:		pipe_write_open,
 	release:	pipe_write_release,
+	fasync:         pipe_write_fasync,
 };
 
 struct file_operations rdwr_pipe_fops = {
@@ -433,6 +506,7 @@
 	ioctl:		pipe_ioctl,
 	open:		pipe_rdwr_open,
 	release:	pipe_rdwr_release,
+	fasync:         pipe_rdwr_fasync,
 };
 
 struct inode* pipe_new(struct inode* inode)
@@ -453,6 +527,7 @@
 	PIPE_READERS(*inode) = PIPE_WRITERS(*inode) = 0;
 	PIPE_WAITING_READERS(*inode) = PIPE_WAITING_WRITERS(*inode) = 0;
 	PIPE_RCOUNTER(*inode) = PIPE_WCOUNTER(*inode) = 1;
+	*PIPE_FASYNC_READERS(*inode) = *PIPE_FASYNC_WRITERS(*inode) = NULL;
 
 	return inode;
 fail_page:
