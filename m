Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264477AbRFTCJS>; Tue, 19 Jun 2001 22:09:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264482AbRFTCJJ>; Tue, 19 Jun 2001 22:09:09 -0400
Received: from smtp1.Stanford.EDU ([171.64.14.23]:49593 "EHLO
	smtp1.Stanford.EDU") by vger.kernel.org with ESMTP
	id <S264477AbRFTCIv>; Tue, 19 Jun 2001 22:08:51 -0400
Date: Tue, 19 Jun 2001 19:08:35 -0700
From: "Zack Weinberg" <zackw@stanford.edu>
To: linux-kernel@vger.kernel.org
Subject: 2.2 PATCH: check return from copy_*_user in fs/pipe.c
Message-ID: <20010619184802.D5679@stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The anonymous pipe code in 2.2 does not check the return value of
copy_*_user.  This can lead to silent loss of data.

The appended patch fixes the bug.  It has been in continuous use on my
machine since May 13 (2.2.19) with no problems.  It will apply to any
2.2 kernel from at least 2.2.18, there have been no changes to pipe.c
since then.

2.4 pipe.c has been completely rewritten and does not have the bug.

-- 
zw         > Having been converted to bagels in the US, ...
           Good Lord! You must have -really- offended a Jewish wizard.
           	-- Niall McAuley and Kip Williams in rec.arts.sf.fandom

--- pipe.c.zw	Tue Jun 19 18:37:13 2001
+++ pipe.c	Tue Jun 19 18:37:16 2001
@@ -31,10 +31,9 @@
 			 size_t count, loff_t *ppos)
 {
 	struct inode * inode = filp->f_dentry->d_inode;
-	ssize_t chars = 0, size = 0, read = 0;
+	ssize_t chars = 0, size = 0, read = 0, nleft = 0;
         char *pipebuf;
 
-
 	if (ppos != &filp->f_pos)
 		return -ESPIPE;
 
@@ -59,19 +58,22 @@
 		interruptible_sleep_on(&PIPE_WAIT(*inode));
 	}
 	PIPE_LOCK(*inode)++;
-	while (count>0 && (size = PIPE_SIZE(*inode))) {
+	while (count>0 && (size = PIPE_SIZE(*inode)) && nleft == 0) {
 		chars = PIPE_MAX_RCHUNK(*inode);
 		if (chars > count)
 			chars = count;
 		if (chars > size)
 			chars = size;
-		read += chars;
                 pipebuf = PIPE_BASE(*inode)+PIPE_START(*inode);
+
+		nleft = copy_to_user(buf, pipebuf, chars);
+		chars -= nleft;
+
+		read += chars;
 		PIPE_START(*inode) += chars;
 		PIPE_START(*inode) &= (PIPE_BUF-1);
 		PIPE_LEN(*inode) -= chars;
 		count -= chars;
-		copy_to_user(buf, pipebuf, chars );
 		buf += chars;
 	}
 	PIPE_LOCK(*inode)--;
@@ -80,6 +82,8 @@
 		UPDATE_ATIME(inode);
 		return read;
 	}
+	if (nleft)
+		return -EFAULT;
 	if (PIPE_WRITERS(*inode))
 		return -EAGAIN;
 	return 0;
@@ -89,7 +93,7 @@
 			  size_t count, loff_t *ppos)
 {
 	struct inode * inode = filp->f_dentry->d_inode;
-	ssize_t chars = 0, free = 0, written = 0, err=0;
+	ssize_t chars = 0, free = 0, written = 0, err = 0, nleft = 0;
 	char *pipebuf;
 
 	if (ppos != &filp->f_pos)
@@ -127,29 +131,38 @@
 			interruptible_sleep_on(&PIPE_WAIT(*inode));
 		}
 		PIPE_LOCK(*inode)++;
-		while (count>0 && (free = PIPE_FREE(*inode))) {
+		while (count>0 && (free = PIPE_FREE(*inode)) && nleft == 0) {
 			chars = PIPE_MAX_WCHUNK(*inode);
 			if (chars > count)
 				chars = count;
 			if (chars > free)
 				chars = free;
                         pipebuf = PIPE_BASE(*inode)+PIPE_END(*inode);
+
+			nleft = copy_from_user(pipebuf, buf, chars);
+			chars -= nleft;
 			written += chars;
 			PIPE_LEN(*inode) += chars;
 			count -= chars;
-			copy_from_user(pipebuf, buf, chars );
 			buf += chars;
 		}
 		PIPE_LOCK(*inode)--;
 		wake_up_interruptible(&PIPE_WAIT(*inode));
 		free = 1;
+		if (nleft) {
+			err = -EFAULT;
+			goto errout;
+		}
 	}
-	inode->i_ctime = inode->i_mtime = CURRENT_TIME;
-	mark_inode_dirty(inode);
 errout:
+	if (written) {
+		inode->i_ctime = inode->i_mtime = CURRENT_TIME;
+		mark_inode_dirty(inode);
+		err = written;
+	}
 	up(&inode->i_atomic_write);
 	down(&inode->i_sem);
-	return written ? written : err;
+	return err;
 }
 
 static long long pipe_lseek(struct file * file, long long offset, int orig)
