Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262124AbVAJFyi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262124AbVAJFyi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 00:54:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262122AbVAJFx2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 00:53:28 -0500
Received: from pool-151-203-193-191.bos.east.verizon.net ([151.203.193.191]:34052
	"EHLO ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S262110AbVAJFOz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 00:14:55 -0500
Message-Id: <200501100736.j0A7a7PW005850@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, cw@foof.org
Subject: [PATCH 24/28] UML - sparse annotations
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 10 Jan 2005 02:36:07 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lots of sparse annotations from Chris Wright.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.10/arch/um/drivers/mconsole_kern.c
===================================================================
--- linux-2.6.10.orig/arch/um/drivers/mconsole_kern.c	2005-01-09 22:38:32.000000000 -0500
+++ linux-2.6.10/arch/um/drivers/mconsole_kern.c	2005-01-09 22:38:44.000000000 -0500
@@ -499,7 +499,7 @@
 
 __initcall(mconsole_init);
 
-static int write_proc_mconsole(struct file *file, const char *buffer,
+static int write_proc_mconsole(struct file *file, const char __user *buffer,
 			       unsigned long count, void *data)
 {
 	char *buf;
Index: linux-2.6.10/arch/um/drivers/ubd_kern.c
===================================================================
--- linux-2.6.10.orig/arch/um/drivers/ubd_kern.c	2005-01-09 22:38:07.000000000 -0500
+++ linux-2.6.10/arch/um/drivers/ubd_kern.c	2005-01-09 22:38:44.000000000 -0500
@@ -172,7 +172,7 @@
 
 static void make_proc_ide(void)
 {
-	proc_ide_root = proc_mkdir("ide", 0);
+	proc_ide_root = proc_mkdir("ide", NULL);
 	proc_ide = proc_mkdir("ide0", proc_ide_root);
 }
 
@@ -1087,7 +1087,7 @@
 static int ubd_ioctl(struct inode * inode, struct file * file,
 		     unsigned int cmd, unsigned long arg)
 {
-	struct hd_geometry *loc = (struct hd_geometry *) arg;
+	struct hd_geometry __user *loc = (struct hd_geometry __user *) arg;
 	struct ubd *dev = inode->i_bdev->bd_disk->private_data;
 	struct hd_driveid ubd_id = {
 		.cyls		= 0,
@@ -1108,19 +1108,19 @@
 
 	case HDIO_GET_IDENTITY:
 		ubd_id.cyls = dev->size / (128 * 32 * 512);
-		if(copy_to_user((char *) arg, (char *) &ubd_id, 
+		if(copy_to_user((char __user *) arg, (char *) &ubd_id, 
 				 sizeof(ubd_id)))
 			return(-EFAULT);
 		return(0);
 		
 	case CDROMVOLREAD:
-		if(copy_from_user(&volume, (char *) arg, sizeof(volume)))
+		if(copy_from_user(&volume, (char __user *) arg, sizeof(volume)))
 			return(-EFAULT);
 		volume.channel0 = 255;
 		volume.channel1 = 255;
 		volume.channel2 = 255;
 		volume.channel3 = 255;
-		if(copy_to_user((char *) arg, &volume, sizeof(volume)))
+		if(copy_to_user((char __user *) arg, &volume, sizeof(volume)))
 			return(-EFAULT);
 		return(0);
 	}
Index: linux-2.6.10/arch/um/include/um_uaccess.h
===================================================================
--- linux-2.6.10.orig/arch/um/include/um_uaccess.h	2005-01-09 22:38:32.000000000 -0500
+++ linux-2.6.10/arch/um/include/um_uaccess.h	2005-01-09 22:38:44.000000000 -0500
@@ -20,19 +20,19 @@
 #define access_ok(type, addr, size) \
 	CHOOSE_MODE_PROC(access_ok_tt, access_ok_skas, type, addr, size)
 
-static inline int verify_area(int type, const void * addr, unsigned long size)
+static inline int verify_area(int type, const void __user *addr, unsigned long size)
 {
-	return(CHOOSE_MODE_PROC(verify_area_tt, verify_area_skas, type, addr,
+	return (CHOOSE_MODE_PROC(verify_area_tt, verify_area_skas, type, addr,
 				size));
 }
 
-static inline int copy_from_user(void *to, const void *from, int n)
+static inline int copy_from_user(void *to, const void __user *from, int n)
 {
 	return(CHOOSE_MODE_PROC(copy_from_user_tt, copy_from_user_skas, to,
 				from, n));
 }
 
-static inline int copy_to_user(void *to, const void *from, int n)
+static inline int copy_to_user(void __user *to, const void *from, int n)
 {
 	return(CHOOSE_MODE_PROC(copy_to_user_tt, copy_to_user_skas, to, 
 				from, n));
@@ -57,7 +57,7 @@
  * and returns @count.
  */
 
-static inline int strncpy_from_user(char *dst, const char *src, int count)
+static inline int strncpy_from_user(char *dst, const char __user *src, int count)
 {
 	return(CHOOSE_MODE_PROC(strncpy_from_user_tt, strncpy_from_user_skas,
 				dst, src, count));
@@ -89,7 +89,7 @@
  * Returns number of bytes that could not be cleared.
  * On success, this will be zero.
  */
-static inline int clear_user(void *mem, int len)
+static inline int clear_user(void __user *mem, int len)
 {
 	return(CHOOSE_MODE_PROC(clear_user_tt, clear_user_skas, mem, len));
 }
@@ -105,7 +105,7 @@
  * On exception, returns 0.
  * If the string is too long, returns a value greater than @n.
  */
-static inline int strnlen_user(const void *str, long len)
+static inline int strnlen_user(const void __user *str, long len)
 {
 	return(CHOOSE_MODE_PROC(strnlen_user_tt, strnlen_user_skas, str, len));
 }
Index: linux-2.6.10/arch/um/include/uml_uaccess.h
===================================================================
--- linux-2.6.10.orig/arch/um/include/uml_uaccess.h	2005-01-09 22:38:07.000000000 -0500
+++ linux-2.6.10/arch/um/include/uml_uaccess.h	2005-01-09 22:38:44.000000000 -0500
@@ -7,7 +7,7 @@
 #define __UML_UACCESS_H__
 
 extern int __do_copy_to_user(void *to, const void *from, int n,
-				  void **fault_addr, void **fault_catcher);
+			     void **fault_addr, void **fault_catcher);
 extern unsigned long __do_user_copy(void *to, const void *from, int n,
 				    void **fault_addr, void **fault_catcher,
 				    void (*op)(void *to, const void *from,
Index: linux-2.6.10/arch/um/kernel/checksum.c
===================================================================
--- linux-2.6.10.orig/arch/um/kernel/checksum.c	2005-01-09 22:38:07.000000000 -0500
+++ linux-2.6.10/arch/um/kernel/checksum.c	2005-01-09 22:38:44.000000000 -0500
@@ -2,16 +2,16 @@
 #include "linux/errno.h"
 #include "linux/module.h"
 
-extern unsigned int arch_csum_partial(const char *buff, int len, int sum);
+unsigned int arch_csum_partial(const char *buff, int len, int sum);
 
-extern unsigned int csum_partial(char *buff, int len, int sum)
+unsigned int csum_partial(char *buff, int len, int sum)
 {
-	return(arch_csum_partial(buff, len, sum));
+	return arch_csum_partial(buff, len, sum);
 }
 
 EXPORT_SYMBOL(csum_partial);
 
-unsigned int csum_partial_copy_to(const char *src, char *dst, int len, 
+unsigned int csum_partial_copy_to(const char *src, char __user *dst, int len, 
 				  int sum, int *err_ptr)
 {
 	if(copy_to_user(dst, src, len)){
@@ -22,7 +22,7 @@
 	return(arch_csum_partial(src, len, sum));
 }
 
-unsigned int csum_partial_copy_from(const char *src, char *dst, int len, 
+unsigned int csum_partial_copy_from(const char __user *src, char *dst, int len, 
 				    int sum, int *err_ptr)
 {
 	if(copy_from_user(dst, src, len)){
@@ -30,7 +30,7 @@
 		return(-1);
 	}
 
-	return(arch_csum_partial(dst, len, sum));
+	return arch_csum_partial(dst, len, sum);
 }
 
 /*
Index: linux-2.6.10/arch/um/kernel/exec_kern.c
===================================================================
--- linux-2.6.10.orig/arch/um/kernel/exec_kern.c	2005-01-09 22:38:07.000000000 -0500
+++ linux-2.6.10/arch/um/kernel/exec_kern.c	2005-01-09 22:38:44.000000000 -0500
@@ -34,7 +34,8 @@
 
 extern void log_exec(char **argv, void *tty);
 
-static long execve1(char *file, char **argv, char **env)
+static long execve1(char *file, char __user * __user *argv, 
+		    char *__user __user *env)
 {
         long error;
 
@@ -51,7 +52,7 @@
         return(error);
 }
 
-long um_execve(char *file, char **argv, char **env)
+long um_execve(char *file, char __user *__user *argv, char __user *__user *env)
 {
 	long err;
 
@@ -61,13 +62,14 @@
 	return(err);
 }
 
-long sys_execve(char *file, char **argv, char **env)
+long sys_execve(char *file, char __user *__user *argv, 
+		char __user *__user *env)
 {
 	long error;
 	char *filename;
 
 	lock_kernel();
-	filename = getname((char *) file);
+	filename = getname((char __user *) file);
 	error = PTR_ERR(filename);
 	if (IS_ERR(filename)) goto out;
 	error = execve1(filename, argv, env);
Index: linux-2.6.10/arch/um/kernel/exitcode.c
===================================================================
--- linux-2.6.10.orig/arch/um/kernel/exitcode.c	2005-01-09 22:38:07.000000000 -0500
+++ linux-2.6.10/arch/um/kernel/exitcode.c	2005-01-09 22:38:44.000000000 -0500
@@ -27,7 +27,7 @@
 	return(len);
 }
 
-static int write_proc_exitcode(struct file *file, const char *buffer,
+static int write_proc_exitcode(struct file *file, const char __user *buffer,
 			       unsigned long count, void *data)
 {
 	char *end, buf[sizeof("nnnnn\0")];
Index: linux-2.6.10/arch/um/kernel/irq.c
===================================================================
--- linux-2.6.10.orig/arch/um/kernel/irq.c	2005-01-09 22:38:17.000000000 -0500
+++ linux-2.6.10/arch/um/kernel/irq.c	2005-01-09 22:38:44.000000000 -0500
@@ -152,13 +152,13 @@
 	int i;
 
 	irq_desc[TIMER_IRQ].status = IRQ_DISABLED;
-	irq_desc[TIMER_IRQ].action = 0;
+	irq_desc[TIMER_IRQ].action = NULL;
 	irq_desc[TIMER_IRQ].depth = 1;
 	irq_desc[TIMER_IRQ].handler = &SIGVTALRM_irq_type;
 	enable_irq(TIMER_IRQ);
 	for(i=1;i<NR_IRQS;i++){
 		irq_desc[i].status = IRQ_DISABLED;
-		irq_desc[i].action = 0;
+		irq_desc[i].action = NULL;
 		irq_desc[i].depth = 1;
 		irq_desc[i].handler = &SIGIO_irq_type;
 		enable_irq(i);
Index: linux-2.6.10/arch/um/kernel/mem.c
===================================================================
--- linux-2.6.10.orig/arch/um/kernel/mem.c	2005-01-09 22:38:16.000000000 -0500
+++ linux-2.6.10/arch/um/kernel/mem.c	2005-01-09 22:38:44.000000000 -0500
@@ -130,7 +130,7 @@
 	}
 }
 
-#if CONFIG_HIGHMEM
+#ifdef CONFIG_HIGHMEM
 pte_t *kmap_pte;
 pgprot_t kmap_prot;
 
@@ -235,7 +235,7 @@
 	addr = (unsigned long) page_address(page);
 	for(i = 0; i < (1 << order); i++){
 		current->thread.fault_addr = (void *) addr;
-		if(__do_copy_to_user((void *) addr, &zero,
+		if(__do_copy_to_user((void __user *) addr, &zero,
 				     sizeof(zero),
 				     &current->thread.fault_addr,
 				     &current->thread.fault_catcher)){
Index: linux-2.6.10/arch/um/kernel/process_kern.c
===================================================================
--- linux-2.6.10.orig/arch/um/kernel/process_kern.c	2005-01-09 22:38:07.000000000 -0500
+++ linux-2.6.10/arch/um/kernel/process_kern.c	2005-01-09 22:38:44.000000000 -0500
@@ -368,22 +368,22 @@
 	return(&init_thread_union.thread_info.task);
 }
 
-int copy_to_user_proc(void *to, void *from, int size)
+int copy_to_user_proc(void __user *to, void *from, int size)
 {
 	return(copy_to_user(to, from, size));
 }
 
-int copy_from_user_proc(void *to, void *from, int size)
+int copy_from_user_proc(void *to, void __user *from, int size)
 {
 	return(copy_from_user(to, from, size));
 }
 
-int clear_user_proc(void *buf, int size)
+int clear_user_proc(void __user *buf, int size)
 {
 	return(clear_user(buf, size));
 }
 
-int strlen_user_proc(char *str)
+int strlen_user_proc(char __user *str)
 {
 	return(strlen_user(str));
 }
Index: linux-2.6.10/arch/um/kernel/ptrace.c
===================================================================
--- linux-2.6.10.orig/arch/um/kernel/ptrace.c	2005-01-09 22:38:28.000000000 -0500
+++ linux-2.6.10/arch/um/kernel/ptrace.c	2005-01-09 22:40:00.000000000 -0500
@@ -81,7 +81,7 @@
 		copied = access_process_vm(child, addr, &tmp, sizeof(tmp), 0);
 		if (copied != sizeof(tmp))
 			break;
-		ret = put_user(tmp,(unsigned long *) data);
+		ret = put_user(tmp, (unsigned long __user *) data);
 		break;
 	}
 
@@ -103,7 +103,7 @@
 			addr = addr >> 2;
 			tmp = child->thread.arch.debugregs[addr];
 		}
-		ret = put_user(tmp, (unsigned long *) data);
+		ret = put_user(tmp, (unsigned long __user *) data);
 		break;
 	}
 
@@ -201,7 +201,8 @@
 			break;
 		}
 		for ( i = 0; i < FRAME_SIZE_OFFSET; i += sizeof(long) ) {
-			__put_user(getreg(child, i), (unsigned long *) data);
+			__put_user(getreg(child, i), 
+				   (unsigned long __user *) data);
 			data += sizeof(long);
 		}
 		ret = 0;
@@ -217,7 +218,7 @@
 			break;
 		}
 		for ( i = 0; i < FRAME_SIZE_OFFSET; i += sizeof(long) ) {
-			__get_user(tmp, (unsigned long *) data);
+			__get_user(tmp, (unsigned long __user *) data);
 			putreg(child, i, tmp);
 			data += sizeof(long);
 		}
@@ -251,14 +252,14 @@
 		fault = ((struct ptrace_faultinfo) 
 			{ .is_write	= child->thread.err,
 			  .addr		= child->thread.cr2 });
-		ret = copy_to_user((unsigned long *) data, &fault, 
+		ret = copy_to_user((unsigned long __user *) data, &fault, 
 				   sizeof(fault));
 		if(ret)
 			break;
 		break;
 	}
 	case PTRACE_SIGPENDING:
-		ret = copy_to_user((unsigned long *) data, 
+		ret = copy_to_user((unsigned long __user *) data, 
 				   &child->pending.signal,
 				   sizeof(child->pending.signal));
 		break;
@@ -266,7 +267,7 @@
 	case PTRACE_LDT: {
 		struct ptrace_ldt ldt;
 
-		if(copy_from_user(&ldt, (unsigned long *) data, 
+		if(copy_from_user(&ldt, (unsigned long __user *) data, 
 				  sizeof(ldt))){
 			ret = -EIO;
 			break;
Index: linux-2.6.10/arch/um/kernel/signal_kern.c
===================================================================
--- linux-2.6.10.orig/arch/um/kernel/signal_kern.c	2005-01-09 22:38:34.000000000 -0500
+++ linux-2.6.10/arch/um/kernel/signal_kern.c	2005-01-09 22:38:44.000000000 -0500
@@ -196,7 +196,7 @@
 	}
 }
 
-long sys_sigaltstack(const stack_t *uss, stack_t *uoss)
+long sys_sigaltstack(const stack_t __user *uss, stack_t __user *uoss)
 {
 	return(do_sigaltstack(uss, uoss, PT_REGS_SP(&current->thread.regs)));
 }
Index: linux-2.6.10/arch/um/kernel/skas/uaccess.c
===================================================================
--- linux-2.6.10.orig/arch/um/kernel/skas/uaccess.c	2005-01-09 22:38:15.000000000 -0500
+++ linux-2.6.10/arch/um/kernel/skas/uaccess.c	2005-01-09 22:38:44.000000000 -0500
@@ -132,10 +132,10 @@
 	return(0);
 }
 
-int copy_from_user_skas(void *to, const void *from, int n)
+int copy_from_user_skas(void *to, const void __user *from, int n)
 {
 	if(segment_eq(get_fs(), KERNEL_DS)){
-		memcpy(to, from, n);
+		memcpy(to, (__force void*)from, n);
 		return(0);
 	}
 
@@ -153,10 +153,10 @@
 	return(0);
 }
 
-int copy_to_user_skas(void *to, const void *from, int n)
+int copy_to_user_skas(void __user *to, const void *from, int n)
 {
 	if(segment_eq(get_fs(), KERNEL_DS)){
-		memcpy(to, from, n);
+		memcpy((__force void*)to, from, n);
 		return(0);
 	}
 
@@ -179,13 +179,13 @@
 	return(0);
 }
 
-int strncpy_from_user_skas(char *dst, const char *src, int count)
+int strncpy_from_user_skas(char *dst, const char __user *src, int count)
 {
 	int n;
 	char *ptr = dst;
 
 	if(segment_eq(get_fs(), KERNEL_DS)){
-		strncpy(dst, src, count);
+		strncpy(dst, (__force void*)src, count);
 		return(strnlen(dst, count));
 	}
 
@@ -205,15 +205,15 @@
 	return(0);
 }
 
-int __clear_user_skas(void *mem, int len)
+int __clear_user_skas(void __user *mem, int len)
 {
 	return(buffer_op((unsigned long) mem, len, 1, clear_chunk, NULL));
 }
 
-int clear_user_skas(void *mem, int len)
+int clear_user_skas(void __user *mem, int len)
 {
 	if(segment_eq(get_fs(), KERNEL_DS)){
-		memset(mem, 0, len);
+		memset((__force void*)mem, 0, len);
 		return(0);
 	}
 
@@ -233,12 +233,12 @@
 	return(0);
 }
 
-int strnlen_user_skas(const void *str, int len)
+int strnlen_user_skas(const void __user *str, int len)
 {
 	int count = 0, n;
 
 	if(segment_eq(get_fs(), KERNEL_DS))
-		return(strnlen(str, len) + 1);
+		return(strnlen((__force char*)str, len) + 1);
 
 	n = buffer_op((unsigned long) str, len, 0, strnlen_chunk, &count);
 	if(n == 0)
Index: linux-2.6.10/arch/um/kernel/syscall_kern.c
===================================================================
--- linux-2.6.10.orig/arch/um/kernel/syscall_kern.c	2005-01-09 22:38:07.000000000 -0500
+++ linux-2.6.10/arch/um/kernel/syscall_kern.c	2005-01-09 22:38:44.000000000 -0500
@@ -27,10 +27,9 @@
 /*  Unlocked, I don't care if this is a bit off */
 int nsyscalls = 0;
 
-long um_mount(char * dev_name, char * dir_name, char * type,
-	      unsigned long new_flags, void * data)
+long um_mount(char __user * dev_name, char __user * dir_name, 
+	      char __user * type, unsigned long new_flags, void __user * data)
 {
-	if(type == NULL) type = "";
 	return(sys_mount(dev_name, dir_name, type, new_flags, data));
 }
 
@@ -96,7 +95,7 @@
  * sys_pipe() is the normal C calling standard for creating
  * a pipe. It's not the way unix traditionally does this, though.
  */
-long sys_pipe(unsigned long * fildes)
+long sys_pipe(unsigned long __user * fildes)
 {
         int fd[2];
         long error;
Index: linux-2.6.10/arch/um/kernel/time_kern.c
===================================================================
--- linux-2.6.10.orig/arch/um/kernel/time_kern.c	2005-01-09 22:38:07.000000000 -0500
+++ linux-2.6.10/arch/um/kernel/time_kern.c	2005-01-09 22:38:44.000000000 -0500
@@ -111,19 +111,19 @@
 	return(IRQ_HANDLED);
 }
 
-long um_time(int * tloc)
+long um_time(int __user *tloc)
 {
 	struct timeval now;
 
 	do_gettimeofday(&now);
 	if (tloc) {
- 		if (put_user(now.tv_sec,tloc))
+ 		if (put_user(now.tv_sec, tloc))
 			now.tv_sec = -EFAULT;
 	}
 	return now.tv_sec;
 }
 
-long um_stime(int * tptr)
+long um_stime(int __user *tptr)
 {
 	int value;
 	struct timespec new;
Index: linux-2.6.10/arch/um/kernel/tt/uaccess.c
===================================================================
--- linux-2.6.10.orig/arch/um/kernel/tt/uaccess.c	2005-01-09 22:38:07.000000000 -0500
+++ linux-2.6.10/arch/um/kernel/tt/uaccess.c	2005-01-09 22:38:44.000000000 -0500
@@ -6,7 +6,7 @@
 #include "linux/sched.h"
 #include "asm/uaccess.h"
 
-int copy_from_user_tt(void *to, const void *from, int n)
+int copy_from_user_tt(void *to, const void __user *from, int n)
 {
 	if(!access_ok_tt(VERIFY_READ, from, n))
 		return(n);
@@ -15,7 +15,7 @@
 				   &current->thread.fault_catcher));
 }
 
-int copy_to_user_tt(void *to, const void *from, int n)
+int copy_to_user_tt(void __user *to, const void *from, int n)
 {
 	if(!access_ok_tt(VERIFY_WRITE, to, n))
 		return(n);
@@ -24,7 +24,7 @@
 				 &current->thread.fault_catcher));
 }
 
-int strncpy_from_user_tt(char *dst, const char *src, int count)
+int strncpy_from_user_tt(char *dst, const char __user *src, int count)
 {
 	int n;
 
@@ -38,14 +38,14 @@
 	return(n);
 }
 
-int __clear_user_tt(void *mem, int len)
+int __clear_user_tt(void __user *mem, int len)
 {
 	return(__do_clear_user(mem, len,
 			       &current->thread.fault_addr,
 			       &current->thread.fault_catcher));
 }
 
-int clear_user_tt(void *mem, int len)
+int clear_user_tt(void __user *mem, int len)
 {
 	if(!access_ok_tt(VERIFY_WRITE, mem, len))
 		return(len);
@@ -54,7 +54,7 @@
 			       &current->thread.fault_catcher));
 }
 
-int strnlen_user_tt(const void *str, int len)
+int strnlen_user_tt(const void __user *str, int len)
 {
 	return(__do_strnlen_user(str, len,
 				 &current->thread.fault_addr,
Index: linux-2.6.10/arch/um/sys-i386/ldt.c
===================================================================
--- linux-2.6.10.orig/arch/um/sys-i386/ldt.c	2005-01-09 22:38:07.000000000 -0500
+++ linux-2.6.10/arch/um/sys-i386/ldt.c	2005-01-09 22:38:44.000000000 -0500
@@ -15,10 +15,12 @@
 
 /* XXX this needs copy_to_user and copy_from_user */
 
-int sys_modify_ldt_tt(int func, void *ptr, unsigned long bytecount)
+int sys_modify_ldt_tt(int func, void __user *ptr, unsigned long bytecount)
 {
-	if(verify_area(VERIFY_READ, ptr, bytecount)) return(-EFAULT);
-	return(modify_ldt(func, ptr, bytecount));
+	if (verify_area(VERIFY_READ, ptr, bytecount))
+		return -EFAULT;
+
+	return modify_ldt(func, ptr, bytecount);
 }
 #endif
 
@@ -27,7 +29,7 @@
 
 #include "skas_ptrace.h"
 
-int sys_modify_ldt_skas(int func, void *ptr, unsigned long bytecount)
+int sys_modify_ldt_skas(int func, void __user *ptr, unsigned long bytecount)
 {
 	struct ptrace_ldt ldt;
 	void *buf;
@@ -76,7 +78,7 @@
 }
 #endif
 
-int sys_modify_ldt(int func, void *ptr, unsigned long bytecount)
+int sys_modify_ldt(int func, void __user *ptr, unsigned long bytecount)
 {
 	return(CHOOSE_MODE_PROC(sys_modify_ldt_tt, sys_modify_ldt_skas, func, 
 				ptr, bytecount));
Index: linux-2.6.10/arch/um/sys-i386/ptrace.c
===================================================================
--- linux-2.6.10.orig/arch/um/sys-i386/ptrace.c	2005-01-09 22:38:07.000000000 -0500
+++ linux-2.6.10/arch/um/sys-i386/ptrace.c	2005-01-09 22:38:44.000000000 -0500
@@ -3,6 +3,8 @@
  * Licensed under the GPL
  */
 
+#include <linux/config.h>
+#include <linux/compiler.h>
 #include "linux/sched.h"
 #include "asm/elf.h"
 #include "asm/ptrace.h"
@@ -22,7 +24,7 @@
 	unsigned short instr;
 	int n;
 
-	n = copy_from_user(&instr, (void *) addr, sizeof(instr));
+	n = copy_from_user(&instr, (void __user *) addr, sizeof(instr));
 	if(n){
 		printk("is_syscall : failed to read instruction from 0x%lx\n",
 		       addr);
@@ -175,12 +177,12 @@
  */
 
 #ifdef CONFIG_MODE_TT
-static inline int convert_fxsr_to_user_tt(struct _fpstate *buf, 
+static inline int convert_fxsr_to_user_tt(struct _fpstate __user *buf,
 					  struct pt_regs *regs)
 {
 	struct i387_fxsave_struct *fxsave = SC_FXSR_ENV(PT_REGS_SC(regs));
 	unsigned long env[7];
-	struct _fpreg *to;
+	struct _fpreg __user *to;
 	struct _fpxreg *from;
 	int i;
 
@@ -205,7 +207,7 @@
 }
 #endif
 
-static inline int convert_fxsr_to_user(struct _fpstate *buf, 
+static inline int convert_fxsr_to_user(struct _fpstate __user *buf,
 				       struct pt_regs *regs)
 {
 	return(CHOOSE_MODE(convert_fxsr_to_user_tt(buf, regs), 0));
@@ -213,12 +215,12 @@
 
 #ifdef CONFIG_MODE_TT
 static inline int convert_fxsr_from_user_tt(struct pt_regs *regs,
-					    struct _fpstate *buf)
+					    struct _fpstate __user *buf)
 {
 	struct i387_fxsave_struct *fxsave = SC_FXSR_ENV(PT_REGS_SC(regs));
 	unsigned long env[7];
 	struct _fpxreg *to;
-	struct _fpreg *from;
+	struct _fpreg __user *from;
 	int i;
 
 	if ( __copy_from_user( env, buf, 7 * sizeof(long) ) )
@@ -244,7 +246,7 @@
 #endif
 
 static inline int convert_fxsr_from_user(struct pt_regs *regs, 
-					 struct _fpstate *buf)
+					 struct _fpstate __user *buf)
 {
 	return(CHOOSE_MODE(convert_fxsr_from_user_tt(regs, buf), 0));
 }
@@ -253,7 +255,7 @@
 {
 	int err;
 
-	err = convert_fxsr_to_user((struct _fpstate *) buf, 
+	err = convert_fxsr_to_user((struct _fpstate __user *) buf, 
 				   &child->thread.regs);
 	if(err) return(-EFAULT);
 	else return(0);
@@ -264,7 +266,7 @@
 	int err;
 
 	err = convert_fxsr_from_user(&child->thread.regs, 
-				     (struct _fpstate *) buf);
+				     (struct _fpstate __user *) buf);
 	if(err) return(-EFAULT);
 	else return(0);
 }
@@ -276,7 +278,7 @@
 	struct i387_fxsave_struct *fxsave = SC_FXSR_ENV(PT_REGS_SC(regs));
 	int err;
 
-	err = __copy_to_user((void *) buf, fxsave,
+	err = __copy_to_user((void __user *) buf, fxsave,
 			     sizeof(struct user_fxsr_struct));
 	if(err) return -EFAULT;
 	else return 0;
@@ -295,7 +297,7 @@
 	struct i387_fxsave_struct *fxsave = SC_FXSR_ENV(PT_REGS_SC(regs));
 	int err;
 
-	err = __copy_from_user(fxsave, (void *) buf,
+	err = __copy_from_user(fxsave, (void __user *) buf,
 			       sizeof(struct user_fxsr_struct) );
 	if(err) return -EFAULT;
 	else return 0;
Index: linux-2.6.10/arch/um/sys-i386/sigcontext.c
===================================================================
--- linux-2.6.10.orig/arch/um/sys-i386/sigcontext.c	2005-01-09 22:38:07.000000000 -0500
+++ linux-2.6.10/arch/um/sys-i386/sigcontext.c	2005-01-09 22:38:44.000000000 -0500
@@ -22,8 +22,7 @@
 unsigned long *sc_sigmask(void *sc_ptr)
 {
 	struct sigcontext *sc = sc_ptr;
-
-	return(&sc->oldmask);
+	return &sc->oldmask;
 }
 
 int sc_get_fpregs(unsigned long buf, void *sc_ptr)
Index: linux-2.6.10/arch/um/sys-i386/signal.c
===================================================================
--- linux-2.6.10.orig/arch/um/sys-i386/signal.c	2005-01-09 22:38:07.000000000 -0500
+++ linux-2.6.10/arch/um/sys-i386/signal.c	2005-01-09 22:38:44.000000000 -0500
@@ -146,7 +146,7 @@
 }
 #endif
 
-static int copy_sc_from_user(struct pt_regs *to, void *from)
+static int copy_sc_from_user(struct pt_regs *to, void __user *from)
 {
 	int ret;
 
Index: linux-2.6.10/arch/um/sys-i386/syscalls.c
===================================================================
--- linux-2.6.10.orig/arch/um/sys-i386/syscalls.c	2005-01-09 22:38:07.000000000 -0500
+++ linux-2.6.10/arch/um/sys-i386/syscalls.c	2005-01-09 22:38:44.000000000 -0500
@@ -30,7 +30,7 @@
 		    unsigned long prot, unsigned long flags,
 		    unsigned long fd, unsigned long offset);
 
-long old_mmap_i386(struct mmap_arg_struct *arg)
+long old_mmap_i386(struct mmap_arg_struct __user *arg)
 {
 	struct mmap_arg_struct a;
 	int err = -EFAULT;
@@ -45,11 +45,13 @@
 
 struct sel_arg_struct {
 	unsigned long n;
-	fd_set *inp, *outp, *exp;
-	struct timeval *tvp;
+	fd_set __user *inp;
+	fd_set __user *outp;
+	fd_set __user *exp;
+	struct timeval __user *tvp;
 };
 
-long old_select(struct sel_arg_struct *arg)
+long old_select(struct sel_arg_struct __user *arg)
 {
 	struct sel_arg_struct a;
 
@@ -62,8 +64,8 @@
 /* The i386 version skips reading from %esi, the fourth argument. So we must do
  * this, too.
  */
-long sys_clone(unsigned long clone_flags, unsigned long newsp, int *parent_tid,
-	       int unused, int *child_tid)
+long sys_clone(unsigned long clone_flags, unsigned long newsp, 
+	       int __user *parent_tid, int unused, int __user *child_tid)
 {
 	long ret;
 
@@ -86,7 +88,7 @@
  * This is really horribly ugly.
  */
 long sys_ipc (uint call, int first, int second,
-	     int third, void *ptr, long fifth)
+	     int third, void *__user ptr, long fifth)
 {
 	int version, ret;
 
Index: linux-2.6.10/arch/um/sys-x86_64/signal.c
===================================================================
--- linux-2.6.10.orig/arch/um/sys-x86_64/signal.c	2005-01-09 22:38:07.000000000 -0500
+++ linux-2.6.10/arch/um/sys-x86_64/signal.c	2005-01-09 22:38:44.000000000 -0500
@@ -128,7 +128,7 @@
 
 #endif
 
-static int copy_sc_from_user(struct pt_regs *to, void *from)
+static int copy_sc_from_user(struct pt_regs *to, void __user *from)
 {
        int ret;
 
Index: linux-2.6.10/include/asm-um/uaccess.h
===================================================================
--- linux-2.6.10.orig/include/asm-um/uaccess.h	2005-01-09 22:38:07.000000000 -0500
+++ linux-2.6.10/include/asm-um/uaccess.h	2005-01-09 22:38:44.000000000 -0500
@@ -55,7 +55,7 @@
 
 #define get_user(x, ptr) \
 ({ \
-        const __typeof__((*(ptr))) *private_ptr = (ptr); \
+        const __typeof__((*(ptr))) __user *private_ptr = (ptr); \
         (access_ok(VERIFY_READ, private_ptr, sizeof(*private_ptr)) ? \
 	 __get_user(x, private_ptr) : ((x) = 0, -EFAULT)); \
 })
@@ -75,7 +75,7 @@
 
 #define put_user(x, ptr) \
 ({ \
-        __typeof__(*(ptr)) *private_ptr = (ptr); \
+        __typeof__(*(ptr)) __user *private_ptr = (ptr); \
         (access_ok(VERIFY_WRITE, private_ptr, sizeof(*private_ptr)) ? \
 	 __put_user(x, private_ptr) : -EFAULT); \
 })

