Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269894AbRHQI3H>; Fri, 17 Aug 2001 04:29:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269918AbRHQI3C>; Fri, 17 Aug 2001 04:29:02 -0400
Received: from Cambot.lecs.CS.UCLA.EDU ([131.179.144.110]:57100 "EHLO
	cambot.lecs.cs.ucla.edu") by vger.kernel.org with ESMTP
	id <S269894AbRHQI2t>; Fri, 17 Aug 2001 04:28:49 -0400
Message-Id: <200108170828.f7H8Svk27088@cambot.lecs.cs.ucla.edu>
To: linux-kernel@vger.kernel.org
cc: alan@redhat.com, jelson@circlemud.org
Subject: [PATCH] SIGIO for FIFOs (fs/pipe.c, kernel 2.4.x)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <27085.998036937.1@cambot.lecs.cs.ucla.edu>
Date: Fri, 17 Aug 2001 01:28:57 -0700
From: Jeremy Elson <jelson@circlemud.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've taken a stab at implementing SIGIO generation for FIFOs and
pipes.  After some searching, it seems that the topic has come up on
the list before:

http://uwsg.iu.edu/hypermail/linux/kernel/0004.3/0179.html

...but no patch seems to have been integrated as a result of that
thread, since the feature is still missing from 2.4.9.

The discussion above mainly concerned the right way to deal with
locking.  I was a little perplexed by this, because FIFOs are always
read/written in process context and already have their own
inode-specific semaphores.  Forgive me if I'm missing something - but,
I just went ahead and used that same semaphore in my code.

The patch (against 2.4.9, but patches cleanly at least as far back as
2.4.4) adds two fields to the private data used by pipe inodes, but
does not add anything to the inode structure itself.

Regards,
Jeremy


diff -u --recursive linux-2.4.9-orig/fs/pipe.c linux-2.4.9/fs/pipe.c
--- linux-2.4.9-orig/fs/pipe.c	Sun Aug 12 18:58:52 2001
+++ linux-2.4.9/fs/pipe.c	Fri Aug 17 01:03:44 2001
@@ -21,6 +21,9 @@
  * 
  * Reads with count = 0 should always return 0.
  * -- Julian Bradfield 1999-06-07.
+ *
+ * FIFOs and Pipes now generate SIGIO for both readers and writers.
+ * -- Jeremy Elson <jelson@circlemud.org> 2001-08-16
  */
 
 /* Drop the inode semaphore and wait for a pipe event, atomically */
@@ -116,12 +119,14 @@
 		 * room.
 		 */
 		wake_up_interruptible_sync(PIPE_WAIT(*inode));
+		kill_fasync(PIPE_FASYNC_WRITERS(*inode), SIGIO, POLL_OUT);
 		if (!PIPE_EMPTY(*inode))
 			BUG();
 		goto do_more_read;
 	}
 	/* Signal writers asynchronously that there is more room.  */
 	wake_up_interruptible(PIPE_WAIT(*inode));
+	kill_fasync(PIPE_FASYNC_WRITERS(*inode), SIGIO, POLL_OUT);
 
 	ret = read;
 out:
@@ -214,6 +219,7 @@
 			 * to do idle reschedules.
 			 */
 			wake_up_interruptible_sync(PIPE_WAIT(*inode));
+			kill_fasync(PIPE_FASYNC_READERS(*inode), SIGIO, POLL_IN);
 			PIPE_WAITING_WRITERS(*inode)++;
 			pipe_wait(inode);
 			PIPE_WAITING_WRITERS(*inode)--;
@@ -227,6 +233,7 @@
 
 	/* Signal readers asynchronously that there is more data.  */
 	wake_up_interruptible(PIPE_WAIT(*inode));
+	kill_fasync(PIPE_FASYNC_READERS(*inode), SIGIO, POLL_IN);
 
 	inode->i_ctime = inode->i_mtime = CURRENT_TIME;
 	mark_inode_dirty(inode);
@@ -313,6 +320,8 @@
 		kfree(info);
 	} else {
 		wake_up_interruptible(PIPE_WAIT(*inode));
+		kill_fasync(PIPE_FASYNC_READERS(*inode), SIGIO, POLL_IN);
+		kill_fasync(PIPE_FASYNC_WRITERS(*inode), SIGIO, POLL_OUT);
 	}
 	up(PIPE_SEM(*inode));
 
@@ -320,14 +329,72 @@
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
 
@@ -336,6 +403,7 @@
 {
 	int decr, decw;
 
+	pipe_rdwr_fasync(-1, filp, 0);
 	decr = (filp->f_mode & FMODE_READ) != 0;
 	decw = (filp->f_mode & FMODE_WRITE) != 0;
 	return pipe_release(inode, decr, decw);
@@ -388,6 +456,7 @@
 	ioctl:		pipe_ioctl,
 	open:		pipe_read_open,
 	release:	pipe_read_release,
+	fasync:         pipe_read_fasync,
 };
 
 struct file_operations write_fifo_fops = {
@@ -398,6 +467,7 @@
 	ioctl:		pipe_ioctl,
 	open:		pipe_write_open,
 	release:	pipe_write_release,
+	fasync:         pipe_write_fasync,
 };
 
 struct file_operations rdwr_fifo_fops = {
@@ -408,6 +478,7 @@
 	ioctl:		pipe_ioctl,
 	open:		pipe_rdwr_open,
 	release:	pipe_rdwr_release,
+	fasync:         pipe_rdwr_fasync,
 };
 
 struct file_operations read_pipe_fops = {
@@ -418,6 +489,7 @@
 	ioctl:		pipe_ioctl,
 	open:		pipe_read_open,
 	release:	pipe_read_release,
+	fasync:         pipe_read_fasync,
 };
 
 struct file_operations write_pipe_fops = {
@@ -428,6 +500,7 @@
 	ioctl:		pipe_ioctl,
 	open:		pipe_write_open,
 	release:	pipe_write_release,
+	fasync:         pipe_write_fasync,
 };
 
 struct file_operations rdwr_pipe_fops = {
@@ -438,6 +511,7 @@
 	ioctl:		pipe_ioctl,
 	open:		pipe_rdwr_open,
 	release:	pipe_rdwr_release,
+	fasync:         pipe_rdwr_fasync,
 };
 
 struct inode* pipe_new(struct inode* inode)
@@ -458,6 +532,7 @@
 	PIPE_READERS(*inode) = PIPE_WRITERS(*inode) = 0;
 	PIPE_WAITING_READERS(*inode) = PIPE_WAITING_WRITERS(*inode) = 0;
 	PIPE_RCOUNTER(*inode) = PIPE_WCOUNTER(*inode) = 1;
+	*PIPE_FASYNC_READERS(*inode) = *PIPE_FASYNC_WRITERS(*inode) = NULL;
 
 	return inode;
 fail_page:
diff -u --recursive linux-2.4.9-orig/include/linux/pipe_fs_i.h linux-2.4.9/include/linux/pipe_fs_i.h
--- linux-2.4.9-orig/include/linux/pipe_fs_i.h	Wed Apr 25 14:18:23 2001
+++ linux-2.4.9/include/linux/pipe_fs_i.h	Fri Aug 17 01:03:44 2001
@@ -13,6 +13,8 @@
 	unsigned int waiting_writers;
 	unsigned int r_counter;
 	unsigned int w_counter;
+	struct fasync_struct *fasync_readers;
+	struct fasync_struct *fasync_writers;
 };
 
 /* Differs from PIPE_BUF in that PIPE_SIZE is the length of the actual
@@ -30,6 +32,8 @@
 #define PIPE_WAITING_WRITERS(inode)	((inode).i_pipe->waiting_writers)
 #define PIPE_RCOUNTER(inode)	((inode).i_pipe->r_counter)
 #define PIPE_WCOUNTER(inode)	((inode).i_pipe->w_counter)
+#define PIPE_FASYNC_READERS(inode)	(&((inode).i_pipe->fasync_readers))
+#define PIPE_FASYNC_WRITERS(inode)	(&((inode).i_pipe->fasync_writers))
 
 #define PIPE_EMPTY(inode)	(PIPE_LEN(inode) == 0)
 #define PIPE_FULL(inode)	(PIPE_LEN(inode) == PIPE_SIZE)

