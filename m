Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269689AbUINSnJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269689AbUINSnJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 14:43:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269184AbUINSk3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 14:40:29 -0400
Received: from [12.177.129.25] ([12.177.129.25]:30915 "EHLO
	ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S269701AbUINSaH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 14:30:07 -0400
Message-Id: <200409141933.i8EJXs4W003557@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] - UML - copy_user fixes
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 14 Sep 2004 15:33:54 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes some copy_user bugs:
	kernelspace page faults that happen on behalf of a process are now
correctly handled
	add copy_user treatment so a fault handler which looks at the faulting
instruction
	added a note to do the same with the ldt stuff some day

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: 2.6.9-rc2/arch/um/include/user_util.h
===================================================================
--- 2.6.9-rc2.orig/arch/um/include/user_util.h	2004-09-14 13:43:32.000000000 -0400
+++ 2.6.9-rc2/arch/um/include/user_util.h	2004-09-14 14:04:25.000000000 -0400
@@ -88,6 +88,7 @@
 extern void forward_pending_sigio(int target);
 extern int can_do_skas(void);
 extern void arch_init_thread(void);
+extern int setjmp_wrapper(void (*proc)(void *, void *), ...);
 
 extern int __raw(int fd, int complain, int now);
 #define raw(fd, complain) __raw((fd), (complain), 1)
Index: 2.6.9-rc2/arch/um/kernel/skas/uaccess.c
===================================================================
--- 2.6.9-rc2.orig/arch/um/kernel/skas/uaccess.c	2004-09-14 13:43:32.000000000 -0400
+++ 2.6.9-rc2/arch/um/kernel/skas/uaccess.c	2004-09-14 14:04:25.000000000 -0400
@@ -12,6 +12,7 @@
 #include "asm/pgtable.h"
 #include "asm/uaccess.h"
 #include "kern_util.h"
+#include "user_util.h"
 
 extern void *um_virt_to_phys(struct task_struct *task, unsigned long addr,
 			     pte_t *pte_out);
@@ -51,37 +52,67 @@
 	return(n);
 }
 
-static int buffer_op(unsigned long addr, int len, int is_write,
-		     int (*op)(unsigned long addr, int len, void *arg),
-		     void *arg)
+static void do_buffer_op(void *jmpbuf, void *arg_ptr)
 {
+	va_list args = *((va_list *) arg_ptr);
+	unsigned long addr = va_arg(args, unsigned long);
+	int len = va_arg(args, int);
+	int is_write = va_arg(args, int);
+	int (*op)(unsigned long, int, void *) = va_arg(args, void *);
+	void *arg = va_arg(args, void *);
+	int *res = va_arg(args, int *);
 	int size = min(PAGE_ALIGN(addr) - addr, (unsigned long) len);
 	int remain = len, n;
 
+	current->thread.fault_catcher = jmpbuf;
 	n = do_op(addr, size, is_write, op, arg);
-	if(n != 0)
-		return(n < 0 ? remain : 0);
+	if(n != 0){
+		*res = (n < 0 ? remain : 0);
+		goto out;
+	}
 
 	addr += size;
 	remain -= size;
-	if(remain == 0)
-		return(0);
+	if(remain == 0){
+		*res = 0;
+		goto out;
+	}
 
 	while(addr < ((addr + remain) & PAGE_MASK)){
 		n = do_op(addr, PAGE_SIZE, is_write, op, arg);
-		if(n != 0)
-			return(n < 0 ? remain : 0);
+		if(n != 0){
+			*res = (n < 0 ? remain : 0);
+			goto out;
+		}
 
 		addr += PAGE_SIZE;
 		remain -= PAGE_SIZE;
 	}
-	if(remain == 0)
-		return(0);
+	if(remain == 0){
+		*res = 0;
+		goto out;
+	}
 
 	n = do_op(addr, remain, is_write, op, arg);
 	if(n != 0)
-		return(n < 0 ? remain : 0);
-	return(0);
+		*res = (n < 0 ? remain : 0);
+	else *res = 0;
+ out:
+	current->thread.fault_catcher = NULL;
+}
+
+static int buffer_op(unsigned long addr, int len, int is_write,
+		     int (*op)(unsigned long addr, int len, void *arg),
+		     void *arg)
+{
+	int faulted, res;
+
+	faulted = setjmp_wrapper(do_buffer_op, addr, len, is_write, op, arg, 
+				 &res);
+	if(!faulted)
+		return(res);
+
+	return(addr + len - (unsigned long) current->thread.fault_addr);
 }
 
 static int copy_chunk_from_user(unsigned long from, int len, void *arg)
Index: 2.6.9-rc2/arch/um/kernel/user_util.c
===================================================================
--- 2.6.9-rc2.orig/arch/um/kernel/user_util.c	2004-09-14 13:43:32.000000000 -0400
+++ 2.6.9-rc2/arch/um/kernel/user_util.c	2004-09-14 14:04:25.000000000 -0400
@@ -8,6 +8,7 @@
 #include <unistd.h>
 #include <limits.h>
 #include <sys/mman.h> 
+#include <setjmp.h>
 #include <sys/stat.h>
 #include <sys/ptrace.h>
 #include <sys/utsname.h>
@@ -169,6 +170,21 @@
 		host.release, host.version, host.machine);
 }
 
+int setjmp_wrapper(void (*proc)(void *, void *), ...)
+{
+        va_list args;
+	sigjmp_buf buf;
+	int n;
+
+	n = sigsetjmp(buf, 1);
+	if(n == 0){
+		va_start(args, proc);
+		(*proc)(&buf, &args);
+	}
+	va_end(args);
+	return(n);
+}
+
 /*
  * Overrides for Emacs so that we follow Linus's tabbing style.
  * Emacs will notice this stuff at the end of the file and automatically
Index: 2.6.9-rc2/arch/um/sys-i386/bugs.c
===================================================================
--- 2.6.9-rc2.orig/arch/um/sys-i386/bugs.c	2004-09-14 13:43:32.000000000 -0400
+++ 2.6.9-rc2/arch/um/sys-i386/bugs.c	2004-09-14 14:04:25.000000000 -0400
@@ -183,15 +183,16 @@
 
 int arch_handle_signal(int sig, union uml_pt_regs *regs)
 {
-	unsigned long ip;
+	unsigned char tmp[2];
 
 	/* This is testing for a cmov (0x0f 0x4x) instruction causing a
 	 * SIGILL in init.
 	 */
 	if((sig != SIGILL) || (TASK_PID(get_current()) != 1)) return(0);
 
-	ip = UPT_IP(regs);
-	if((*((char *) ip) != 0x0f) || ((*((char *) (ip + 1)) & 0xf0) != 0x40))
+	if (copy_from_user_proc(tmp, (void *) UPT_IP(regs), 2))
+		panic("SIGILL in init, could not read instructions!\n");
+	if((tmp[0] != 0x0f) || ((tmp[1] & 0xf0) != 0x40))
 		return(0);
 
 	if(host_has_cmov == 0)
Index: 2.6.9-rc2/arch/um/sys-i386/ldt.c
===================================================================
--- 2.6.9-rc2.orig/arch/um/sys-i386/ldt.c	2004-09-14 13:43:32.000000000 -0400
+++ 2.6.9-rc2/arch/um/sys-i386/ldt.c	2004-09-14 14:04:25.000000000 -0400
@@ -13,6 +13,8 @@
 #ifdef CONFIG_MODE_TT
 extern int modify_ldt(int func, void *ptr, unsigned long bytecount);
 
+/* XXX this needs copy_to_user and copy_from_user */
+
 int sys_modify_ldt_tt(int func, void *ptr, unsigned long bytecount)
 {
 	if(verify_area(VERIFY_READ, ptr, bytecount)) return(-EFAULT);

