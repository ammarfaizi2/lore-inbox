Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290674AbSBRTvj>; Mon, 18 Feb 2002 14:51:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290500AbSBRTvU>; Mon, 18 Feb 2002 14:51:20 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:42247 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S284180AbSBRTvR>; Mon, 18 Feb 2002 14:51:17 -0500
Subject: Unchecked use of __get_user in shmfs
To: linux-kernel@vger.kernel.org
Date: Mon, 18 Feb 2002 20:05:34 +0000 (GMT)
Cc: marcelo@conectiva.com.br
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16cu2Y-0006dR-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The fix below seems rather important.

--- ../linux/mm/shmem.c	Fri Dec 21 17:42:05 2001
+++ mm/shmem.c	Mon Feb 18 19:46:04 2002
@@ -740,6 +749,13 @@
 static struct inode_operations shmem_symlink_inode_operations;
 static struct inode_operations shmem_symlink_inline_operations;
 
+/*
+ *	This is a copy of generic_file_write slightly modified. It would
+ *	help no end if it were kept remotely up to date with the
+ *	generic_file_write changes. I don't alas see a good way to merge
+ *	it back and use the generic one -- Alan
+ */
+ 
 static ssize_t
 shmem_file_write(struct file *file,const char *buf,size_t count,loff_t *ppos)
 {
@@ -751,7 +767,12 @@
 	unsigned long	written;
 	long		status;
 	int		err;
 
+	if ((ssize_t) count < 0)
+		return -EINVAL;
+
+	if (!access_ok(VERIFY_READ, buf, count))
+		return -EFAULT;
 
 	down(&inode->i_sem);
 

