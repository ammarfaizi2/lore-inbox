Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932558AbVHNQPd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932558AbVHNQPd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Aug 2005 12:15:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932560AbVHNQPd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Aug 2005 12:15:33 -0400
Received: from liaag1ad.mx.compuserve.com ([149.174.40.30]:43981 "EHLO
	liaag1ad.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S932558AbVHNQPd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Aug 2005 12:15:33 -0400
Date: Sun, 14 Aug 2005 12:12:52 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [patch 2.6.13-rc6] Fix kmem read on 32-bit archs
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andi Kleen <ak@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       Chuck Ebbert <76306.1226@compuserve.com>
Message-ID: <200508141214_MC3-1-A731-BBE9@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  The first thing drivers/char/mem.c:read_kmem does is convert the
loff_t it gets as the offset for reading into an unsigned int.  This
patch makes the kmem driver's llseek operator do that up-front, so
that fs/read_write.c:rw_verify_area doesn't return -EINVAL when
we try to read from higher addresses.

  It's ugly but so is the existing code.  And it won't fix 64-bit
archs AFAICT.  Tested on 2.6.11, patch offsets fixed up for 2.6.13-rc6.

Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>

Index: 2.6.13-rc6/drivers/char/mem.c
===================================================================
--- 2.6.13-rc6.orig/drivers/char/mem.c	2005-08-14 11:49:11.000000000 -0400
+++ 2.6.13-rc6/drivers/char/mem.c	2005-08-14 11:51:15.000000000 -0400
@@ -747,6 +747,29 @@
 	return ret;
 }
 
+static loff_t kmem_lseek(struct file * file, loff_t offset, int orig)
+{
+	loff_t ret = -EINVAL;
+
+	if (orig == 2)  /* sys_seek/llseek has checked orig = {012} */
+		goto out;
+
+	down(&file->f_dentry->d_inode->i_sem);
+	switch (orig) {
+		case 0:
+			file->f_pos = offset;
+			break;
+		case 1:
+			file->f_pos += offset;
+	}
+	ret = file->f_pos;
+	file->f_pos = (loff_t)(unsigned long)file->f_pos;
+	force_successful_syscall_return();
+	up(&file->f_dentry->d_inode->i_sem);
+out:
+	return ret;
+}
+
 static int open_port(struct inode * inode, struct file * filp)
 {
 	return capable(CAP_SYS_RAWIO) ? 0 : -EPERM;
@@ -769,7 +792,7 @@
 };
 
 static struct file_operations kmem_fops = {
-	.llseek		= memory_lseek,
+	.llseek		= kmem_lseek,
 	.read		= read_kmem,
 	.write		= write_kmem,
 	.mmap		= mmap_kmem,
__
Chuck
