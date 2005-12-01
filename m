Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751397AbVLAAZr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751397AbVLAAZr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 19:25:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751402AbVLAAZr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 19:25:47 -0500
Received: from mail.cainetworks.com ([69.12.176.98]:28176 "EHLO
	mail.cainetworks.com") by vger.kernel.org with ESMTP
	id S1751400AbVLAAZq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 19:25:46 -0500
Message-ID: <438E4307.10508@freeshell.org>
Date: Wed, 30 Nov 2005 16:25:43 -0800
From: Devin Bayer <devin@freeshell.org>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] allow core_patten to be a FIFO, kernel 2.6.14
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FIFO coredump files are useful for a remote system with contrained
resources that likely still contains some fatal bugs.
It allows a daemon to listen on the FIFO and mail the crashes
to the maintainer. The restriction that core_patten point to a
regular file is arbitrary anyway.

To get this to work, I had modify the wrappers to
file->f_op->{write,llseek} in binfmt_elf.c to act more like those
for a regular file. Instead I could have modified pipe_write and
no_llseek, which would be cleaner, but this was the change is localized.

I'm looking for comments, testing and inclusion in the next release.
I have tested it in UML and one i686 build. The coredump files
produced were valid.

Thanks, Devin Bayer.

diff -aur fs.orig/binfmt_elf.c linux/fs/binfmt_elf.c
--- fs.orig/binfmt_elf.c	2005-10-27 17:02:08.000000000 -0700
+++ linux/fs/binfmt_elf.c	2005-11-18 10:29:30.000000000 -0800
@@ -38,6 +38,7 @@
 #include <linux/security.h>
 #include <linux/syscalls.h>
 #include <linux/random.h>
+#include <linux/poll.h>
 
 #include <asm/uaccess.h>
 #include <asm/param.h>
@@ -1121,14 +1122,43 @@
  * These are the only things you should do on a core-file: use only these
  * functions to write out all the necessary info.
  */
+#define POLLOUT_SET (POLLWRBAND | POLLWRNORM | POLLOUT | POLLERR)
 static int dump_write(struct file *file, const void *addr, int nr)
 {
+	if(file->f_op->llseek == no_llseek) {
+		long timeout = msecs_to_jiffies(5000); 
+		unsigned long mask;
+		struct poll_wqueues table;
+		poll_initwait(&table);
+
+		while(timeout > 0) {
+			mask = (*file->f_op->poll)(file, &table.pt);
+			if (mask & POLLOUT_SET)
+			    break;
+
+			cond_resched();
+			set_current_state(TASK_INTERRUPTIBLE);
+			timeout = schedule_timeout(timeout);
+		}
+		
+		poll_freewait(&table);
+		file->f_pos += nr;
+	}
+	
 	return file->f_op->write(file, addr, nr, &file->f_pos) == nr;
 }
 
 static int dump_seek(struct file *file, loff_t off)
 {
-	if (file->f_op->llseek) {
+	if (off == file->f_pos) 
+		return 1;
+	if (file->f_op->llseek == no_llseek && off > file->f_pos) {
+		int nr = off - file->f_pos;
+		char zeros[nr];
+
+		memset(zeros,0,nr);
+		return dump_write(file, zeros, nr);
+	} else if (file->f_op->llseek) {
 		if (file->f_op->llseek(file, off, 0) != off)
 			return 0;
 	} else
diff -aur fs.orig/exec.c linux/fs/exec.c
--- fs.orig/exec.c	2005-10-27 17:02:08.000000000 -0700
+++ linux/fs/exec.c	2005-11-18 10:29:38.000000000 -0800
@@ -65,6 +65,7 @@
 
 static struct linux_binfmt *formats;
 static DEFINE_RWLOCK(binfmt_lock);
+static DEFINE_SPINLOCK(fifo_core_lock);
 
 int register_binfmt(struct linux_binfmt * fmt)
 {
@@ -1492,7 +1493,7 @@
  	lock_kernel();
 	format_corename(corename, core_pattern, signr);
 	unlock_kernel();
-	file = filp_open(corename, O_CREAT | 2 | O_NOFOLLOW | O_LARGEFILE | flag, 0600);
+	file = filp_open(corename, O_CREAT | 2 | O_NOFOLLOW | O_LARGEFILE | O_NONBLOCK | flag, 0600);
 	if (IS_ERR(file))
 		goto fail_unlock;
 	inode = file->f_dentry->d_inode;
@@ -1500,18 +1501,27 @@
 		goto close_fail;	/* multiple links - don't dump */
 	if (d_unhashed(file->f_dentry))
 		goto close_fail;
-
-	if (!S_ISREG(inode->i_mode))
-		goto close_fail;
+	
 	if (!file->f_op)
 		goto close_fail;
 	if (!file->f_op->write)
 		goto close_fail;
-	if (do_truncate(file->f_dentry, 0) != 0)
-		goto close_fail;
+	if (S_ISFIFO(inode->i_mode)) {
+		flush_signals(current);
+		recalc_sigpending();
+		spin_lock(&fifo_core_lock);
+	} else {
+	    if (!S_ISREG(inode->i_mode))
+		    goto close_fail;
+	    if (do_truncate(file->f_dentry, 0) != 0)
+		    goto close_fail;
+	}
 
 	retval = binfmt->core_dump(signr, regs, file);
 
+	if(S_ISFIFO(inode->i_mode))
+	    spin_unlock(&fifo_core_lock);
+
 	if (retval)
 		current->signal->group_exit_code |= 0x80;
 close_fail:
