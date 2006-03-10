Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932190AbWCJUPy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932190AbWCJUPy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 15:15:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752075AbWCJUPy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 15:15:54 -0500
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:39081 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S1752039AbWCJUPy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 15:15:54 -0500
Subject: /proc/pid/mem and mem_write
From: "Charles P. Wright" <cwright@cs.sunysb.edu>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Fri, 10 Mar 2006 15:15:53 -0500
Message-Id: <1142021753.2010.18.camel@polarbear.fsl.cs.sunysb.edu>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The /proc/pid/mem file provides a much more convenient and efficient
interface for accesses a process's memory than PTRACE_PEEKDATA using
read.  In the past, it also provided write access, but this was (most
recently disabled in 2.4.0-test10) with the vague comment that it is
a "security hazard."

After digging a little bit deeper, it was disabled in the 2.2 kernel
series (with a more descriptive comment):
/*
 * mem_write isn't really a good idea right now. It needs
 * to check a lot more: if the process we try to write to
 * dies in the middle right now, mem_write will overwrite
 * kernel memory.. This disables it altogether.
 */

In Linux 2.3.27 it mem_write was rewritten (to be close to its current
form) and enabled again.  Then in 2.4.0-test10 it was disabled, and with
the comment "/* This is a security hazard */".  I tried searching
mailing list archives to see what the reason for this comment is, but
couldn't find anything.

The functionality provided is no different than what PTRACE_POKEDATA
does, so the problems must be implementation related.  The version of
the function that is in the latest kernels has clearly atrophied, but if
the mem_read function is secure, with updates the mem_write function
should be secure as well.

The problem that was originally described has since been solved in
mem_read (by adding a get_mm), but not in mem_write.  The following
patch updates mem_write to be similar to the mem_read function, and
removes the #define that comments it out.

Charles

Signed-off-by: Charles P. Wright <cwright@cs.sunysb.edu>
--- linux-2.6.15-vanilla/fs/proc/base.c	2006-01-02 22:21:10.000000000 -0500
+++ linux-2.6.15-mem_write/fs/proc/base.c	2006-03-10 14:40:22.000000000 -0500
@@ -825,49 +825,67 @@
 	return ret;
 }
 
-#define mem_write NULL
-
-#ifndef mem_write
-/* This is a security hazard */
 static ssize_t mem_write(struct file * file, const char * buf,
 			 size_t count, loff_t *ppos)
 {
-	int copied = 0;
-	char *page;
 	struct task_struct *task = proc_task(file->f_dentry->d_inode);
+	char *page;
 	unsigned long dst = *ppos;
+	int ret = -ESRCH;
+	struct mm_struct *mm;
 
 	if (!MAY_PTRACE(task) || !ptrace_may_attach(task))
-		return -ESRCH;
+		goto out;
 
+	ret = -ENOMEM;
 	page = (char *)__get_free_page(GFP_USER);
 	if (!page)
-		return -ENOMEM;
+		goto out;
+
+	ret = 0;
+
+	mm = get_task_mm(task);
+	if (!mm)
+		goto out_free;
+
+	ret = -EIO;
+
+	if (file->private_data != (void*)((long)current->self_exec_id))
+		goto out_put;
+
+	ret = 0;
 
 	while (count > 0) {
 		int this_len, retval;
 
 		this_len = (count > PAGE_SIZE) ? PAGE_SIZE : count;
 		if (copy_from_user(page, buf, this_len)) {
-			copied = -EFAULT;
+			ret = -EFAULT;
 			break;
 		}
 		retval = access_process_vm(task, dst, page, this_len, 1);
-		if (!retval) {
-			if (!copied)
-				copied = -EIO;
+
+		if (!retval || !MAY_PTRACE(task) || !ptrace_may_attach(task)) {
+			if (!ret)
+				ret = -EIO;
 			break;
 		}
-		copied += retval;
-		buf += retval;
+
+		ret += retval;
 		dst += retval;
-		count -= retval;			
+		buf += retval;
+		count -= retval;
 	}
 	*ppos = dst;
+
+
+out_put:
+	mmput(mm);
+out_free:
 	free_page((unsigned long) page);
-	return copied;
+out:
+	return ret;
 }
-#endif
 
 static loff_t mem_lseek(struct file * file, loff_t offset, int orig)
 {

