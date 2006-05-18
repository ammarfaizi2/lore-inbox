Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932093AbWERP4n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932093AbWERP4n (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 11:56:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932089AbWERP4n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 11:56:43 -0400
Received: from lea.cs.unibo.it ([130.136.1.101]:38329 "EHLO lea.cs.unibo.it")
	by vger.kernel.org with ESMTP id S1751358AbWERP4l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 11:56:41 -0400
Date: Thu, 18 May 2006 17:56:40 +0200
To: linux-kernel@vger.kernel.org
Cc: osd@cs.unibo.it
Subject: [PATCH] 1-access_process_vm_user
Message-ID: <20060518155640.GB17498@cs.unibo.it>
References: <20060518155337.GA17498@cs.unibo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060518155337.GA17498@cs.unibo.it>
User-Agent: Mutt/1.5.6+20040907i
From: renzo@cs.unibo.it (Renzo Davoli)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch modifies the functions ptrace_readdata and
ptrace_writedata already included in kernel/ptrace.c. Basically this is a more
efficient implementation of the same features.
A third function ptrace_readstringdata has been added to optimize the data
transfer of null terminated char strings (like pathnames).

A new function, access_process_vm_user(), takes care to get data from userspace
memory of a given process or to write to userspace memory, in a similar way of
the already existent access_process_vm() function.
It uses only an additional parameter: the flag "string" specify if making
checks on data, that should be a well-formed string ( null terminated ):

static int access_process_vm_user(struct task_struct *tsk, unsigned long addr, char __user *ubuf, int len, int write, int string)

We think this is a better implementation of readdata and writedata, because it
retains in cache entire memory pages, while the current implementation uses only
128 bytes buffers.

Signed-off-by: renzo davoli <renzo@cs.unibo.it>

diff -Naur linux-2.6.17-rc1-bulk/include/linux/ptrace.h linux-2.6.17-rc1-access/include/linux/ptrace.h
--- linux-2.6.17-rc1-bulk/include/linux/ptrace.h	2006-04-03 05:22:10.000000000 +0200
+++ linux-2.6.17-rc1-access/include/linux/ptrace.h	2006-04-04 10:01:33.000000000 +0200
@@ -81,6 +81,7 @@
 extern struct task_struct *ptrace_get_task_struct(pid_t pid);
 extern int ptrace_traceme(void);
 extern int ptrace_readdata(struct task_struct *tsk, unsigned long src, char __user *dst, int len);
+extern int ptrace_readstringdata(struct task_struct *tsk, unsigned long src, char __user *dst, int len);
 extern int ptrace_writedata(struct task_struct *tsk, char __user *src, unsigned long dst, int len);
 extern int ptrace_attach(struct task_struct *tsk);
 extern int ptrace_detach(struct task_struct *, unsigned int);
diff -Naur linux-2.6.17-rc1-bulk/kernel/ptrace.c linux-2.6.17-rc1-access/kernel/ptrace.c
--- linux-2.6.17-rc1-bulk/kernel/ptrace.c	2006-04-03 05:22:10.000000000 +0200
+++ linux-2.6.17-rc1-access/kernel/ptrace.c	2006-04-04 10:01:33.000000000 +0200
@@ -263,54 +263,90 @@
 	return buf - old_buf;
 }
 
-int ptrace_readdata(struct task_struct *tsk, unsigned long src, char __user *dst, int len)
+/*
+ * Access another process' address space to/from user space
+ * Do not walk the page table directly, use get_user_pages
+ */
+static int access_process_vm_user(struct task_struct *tsk, unsigned long addr, char __user *ubuf, int len, int write, int string)
 {
-	int copied = 0;
-
-	while (len > 0) {
-		char buf[128];
-		int this_len, retval;
-
-		this_len = (len > sizeof(buf)) ? sizeof(buf) : len;
-		retval = access_process_vm(tsk, src, buf, this_len, 0);
-		if (!retval) {
-			if (copied)
+	struct mm_struct *mm;
+	struct vm_area_struct *vma;
+	struct page *page;
+	char *buf;
+	unsigned long old_addr = addr;
+
+	mm = get_task_mm(tsk);
+	if (!mm)
+		return 0;
+
+	buf=kmalloc(PAGE_SIZE, GFP_KERNEL);
+	down_read(&mm->mmap_sem);
+	/* ignore errors, just check how much was sucessfully transfered */
+	while (len) {
+		int bytes, ret, offset;
+		void *maddr;
+
+		ret = get_user_pages(tsk, mm, addr, 1,
+				write, 1, &page, &vma);
+		if (ret <= 0)
 				break;
-			return -EIO;
+
+		bytes = len;
+		offset = addr & (PAGE_SIZE-1);
+		if (bytes > PAGE_SIZE-offset)
+			bytes = PAGE_SIZE-offset;
+
+		maddr = kmap(page);
+		if (write) {
+			__copy_from_user(buf,ubuf,bytes);
+			copy_to_user_page(vma, page, addr,
+					maddr + offset, buf, bytes);
+			if (!PageCompound(page))
+				set_page_dirty_lock(page);
+		} else {
+			copy_from_user_page(vma, page, addr,
+					buf, maddr + offset, bytes);
+			if (string) {
+				for (offset=0;offset<bytes;offset++)
+					if (buf[offset]==0)
+						break;
+				if (offset < bytes)
+					bytes=len=offset+1;
 		}
-		if (copy_to_user(dst, buf, retval))
-			return -EFAULT;
-		copied += retval;
-		src += retval;
-		dst += retval;
-		len -= retval;			
+			__copy_to_user(ubuf,buf,bytes);
 	}
-	return copied;
+		kunmap(page);
+		page_cache_release(page);
+		len -= bytes;
+		ubuf += bytes;
+		addr += bytes;
 }
+	up_read(&mm->mmap_sem);
+	mmput(mm);
 
-int ptrace_writedata(struct task_struct *tsk, char __user *src, unsigned long dst, int len)
-{
-	int copied = 0;
+	kfree(buf);
+	return addr - old_addr;
+}
 
-	while (len > 0) {
-		char buf[128];
-		int this_len, retval;
-
-		this_len = (len > sizeof(buf)) ? sizeof(buf) : len;
-		if (copy_from_user(buf, src, this_len))
-			return -EFAULT;
-		retval = access_process_vm(tsk, dst, buf, this_len, 1);
-		if (!retval) {
-			if (copied)
-				break;
+int ptrace_readdata(struct task_struct *tsk, unsigned long src, char __user *dst, int len)
+{
+	if (!access_ok(VERIFY_WRITE, dst ,len))
 			return -EIO;
+	return access_process_vm_user(tsk, src, dst, len, 0, 0);
 		}
-		copied += retval;
-		src += retval;
-		dst += retval;
-		len -= retval;			
+
+int ptrace_readstringdata(struct task_struct *tsk, unsigned long src, char __user *dst, int len)
+{
+	if (!access_ok(VERIFY_WRITE, dst ,len))
+		return -EIO;
+	return access_process_vm_user(tsk, src, dst, len, 0, 1);
 	}
-	return copied;
+
+int ptrace_writedata(struct task_struct *tsk, char __user *src, unsigned long dst, int len)
+{
+	if (!access_ok(VERIFY_READ, dst ,len))
+		return -EIO;
+	return access_process_vm_user(tsk, dst, src, len, 1, 0);
 }
 
 static int ptrace_setoptions(struct task_struct *child, long data)
