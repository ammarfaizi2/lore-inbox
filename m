Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262106AbVAJGP2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262106AbVAJGP2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 01:15:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262097AbVAJFnT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 00:43:19 -0500
Received: from pool-151-203-193-191.bos.east.verizon.net ([151.203.193.191]:25604
	"EHLO ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S262102AbVAJFO2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 00:14:28 -0500
Message-Id: <200501100735.j0A7ZqPW005810@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 16/28] UML - code tidying
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 10 Jan 2005 02:35:52 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some small cleanups that resulted from the x86_64 merge:
	Some unneeded includes were removed
	Some overlong lines were shortened
	current_thread_info was replaced by a generic version.
	Some warnings were fixed

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: 2.6.10/arch/um/include/process.h
===================================================================
--- 2.6.10.orig/arch/um/include/process.h	2005-01-09 21:46:47.000000000 -0500
+++ 2.6.10/arch/um/include/process.h	2005-01-09 21:47:25.000000000 -0500
@@ -6,7 +6,7 @@
 #ifndef __PROCESS_H__
 #define __PROCESS_H__
 
-#include <asm/sigcontext.h>
+#include <signal.h>
 
 extern void sig_handler(int sig, struct sigcontext sc);
 extern void alarm_handler(int sig, struct sigcontext sc);
Index: 2.6.10/arch/um/kernel/mem.c
===================================================================
--- 2.6.10.orig/arch/um/kernel/mem.c	2005-01-09 21:46:47.000000000 -0500
+++ 2.6.10/arch/um/kernel/mem.c	2005-01-09 21:47:25.000000000 -0500
@@ -173,6 +173,7 @@
 
 static void __init fixaddr_user_init( void)
 {
+#if FIXADDR_USER_START != 0
 	long size = FIXADDR_USER_END - FIXADDR_USER_START;
 	pgd_t *pgd;
 	pmd_t *pmd;
@@ -192,6 +193,7 @@
 		pte = pte_offset_kernel(pmd, vaddr);
 		pte_set_val( (*pte), paddr, PAGE_READONLY);
 	}
+#endif
 }
 
 void paging_init(void)
Index: 2.6.10/arch/um/kernel/mem_user.c
===================================================================
--- 2.6.10.orig/arch/um/kernel/mem_user.c	2005-01-09 21:46:47.000000000 -0500
+++ 2.6.10/arch/um/kernel/mem_user.c	2005-01-09 21:47:25.000000000 -0500
@@ -48,8 +48,6 @@
 #include "tempfile.h"
 #include "kern_constants.h"
 
-extern struct mem_region physmem_region;
-
 #define TEMPNAME_TEMPLATE "vm_file-XXXXXX"
 
 static int create_tmp_file(unsigned long len)
@@ -135,7 +133,7 @@
 
 	addr = mmap(NULL, len, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
 	if(addr == MAP_FAILED){
-		os_print_error((int) addr, "mapping physmem file");
+		perror("mapping physmem file");
 		exit(1);
 	}
 	munmap(addr, len);
Index: 2.6.10/arch/um/kernel/process.c
===================================================================
--- 2.6.10.orig/arch/um/kernel/process.c	2005-01-09 21:46:47.000000000 -0500
+++ 2.6.10/arch/um/kernel/process.c	2005-01-09 21:47:25.000000000 -0500
@@ -13,14 +13,10 @@
 #include <setjmp.h>
 #include <sys/time.h>
 #include <sys/ptrace.h>
-#include <linux/ptrace.h>
 #include <sys/wait.h>
 #include <sys/mman.h>
-#include <asm/ptrace.h>
-#include <asm/sigcontext.h>
 #include <asm/unistd.h>
 #include <asm/page.h>
-#include <asm/user.h>
 #include "user_util.h"
 #include "kern_util.h"
 #include "user.h"
@@ -28,6 +24,7 @@
 #include "signal_kern.h"
 #include "signal_user.h"
 #include "sysdep/ptrace.h"
+#include "sysdep/ptrace_user.h"
 #include "sysdep/sigcontext.h"
 #include "irq_user.h"
 #include "ptrace_user.h"
@@ -331,7 +328,7 @@
 		CATCH_EINTR(n = waitpid(pid, &status, WUNTRACED));
 		if(n < 0)
 			panic("check_ptrace : wait failed, errno = %d", errno);
-		if(!WIFSTOPPED(status) || (WSTOPSIG(status) != (SIGTRAP + 0x80)))
+		if(!WIFSTOPPED(status) || (WSTOPSIG(status) != SIGTRAP + 0x80))
 			panic("check_ptrace : expected SIGTRAP + 0x80, "
 			      "got status = %d", status);
 		
Index: 2.6.10/arch/um/kernel/skas/process.c
===================================================================
--- 2.6.10.orig/arch/um/kernel/skas/process.c	2005-01-09 21:46:47.000000000 -0500
+++ 2.6.10/arch/um/kernel/skas/process.c	2005-01-09 21:47:25.000000000 -0500
@@ -73,7 +73,8 @@
 			      "errno = %d\n", errno);
 
 		CATCH_EINTR(err = waitpid(pid, &status, WUNTRACED));
-		if((err < 0) || !WIFSTOPPED(status) || (WSTOPSIG(status) != (SIGTRAP + 0x80)))
+		if((err < 0) || !WIFSTOPPED(status) || 
+		   (WSTOPSIG(status) != SIGTRAP + 0x80))
 			panic("handle_trap - failed to wait at end of syscall, "
 			      "errno = %d, status = %d\n", errno, status);
 	}
Index: 2.6.10/arch/um/kernel/skas/trap_user.c
===================================================================
--- 2.6.10.orig/arch/um/kernel/skas/trap_user.c	2005-01-09 21:46:47.000000000 -0500
+++ 2.6.10/arch/um/kernel/skas/trap_user.c	2005-01-09 21:47:46.000000000 -0500
@@ -5,7 +5,6 @@
 
 #include <signal.h>
 #include <errno.h>
-#include <asm/sigcontext.h>
 #include "sysdep/ptrace.h"
 #include "signal_user.h"
 #include "user_util.h"
Index: 2.6.10/arch/um/kernel/tt/ptproxy/sysdep.c
===================================================================
--- 2.6.10.orig/arch/um/kernel/tt/ptproxy/sysdep.c	2005-01-09 21:46:47.000000000 -0500
+++ 2.6.10/arch/um/kernel/tt/ptproxy/sysdep.c	2005-01-09 21:47:25.000000000 -0500
@@ -12,7 +12,6 @@
 #include <errno.h>
 #include <sys/types.h>
 #include <sys/ptrace.h>
-#include <asm/ptrace.h>
 #include <linux/unistd.h>
 #include "ptrace_user.h"
 #include "user_util.h"
Index: 2.6.10/arch/um/kernel/tt/ptproxy/wait.c
===================================================================
--- 2.6.10.orig/arch/um/kernel/tt/ptproxy/wait.c	2005-01-09 21:46:47.000000000 -0500
+++ 2.6.10/arch/um/kernel/tt/ptproxy/wait.c	2005-01-09 21:47:25.000000000 -0500
@@ -10,7 +10,6 @@
 #include <signal.h>
 #include <sys/wait.h>
 #include <sys/ptrace.h>
-#include <asm/ptrace.h>
 
 #include "ptproxy.h"
 #include "sysdep.h"
Index: 2.6.10/arch/um/kernel/tt/trap_user.c
===================================================================
--- 2.6.10.orig/arch/um/kernel/tt/trap_user.c	2005-01-09 21:46:47.000000000 -0500
+++ 2.6.10/arch/um/kernel/tt/trap_user.c	2005-01-09 21:47:25.000000000 -0500
@@ -6,7 +6,6 @@
 #include <stdlib.h>
 #include <errno.h>
 #include <signal.h>
-#include <asm/sigcontext.h>
 #include "sysdep/ptrace.h"
 #include "signal_user.h"
 #include "user_util.h"
Index: 2.6.10/arch/um/kernel/um_arch.c
===================================================================
--- 2.6.10.orig/arch/um/kernel/um_arch.c	2005-01-09 21:46:47.000000000 -0500
+++ 2.6.10/arch/um/kernel/um_arch.c	2005-01-09 21:47:25.000000000 -0500
@@ -17,6 +17,7 @@
 #include "linux/sysrq.h"
 #include "linux/seq_file.h"
 #include "linux/delay.h"
+#include "linux/module.h"
 #include "asm/page.h"
 #include "asm/pgtable.h"
 #include "asm/ptrace.h"
@@ -156,6 +157,8 @@
 {
 	printf("%s\n", system_utsname.release);
 	exit(0);
+
+	return 0;
 }
 
 __uml_setup("--version", uml_version_setup,
@@ -256,6 +259,8 @@
  		p++;
  	}
 	exit(0);
+
+	return 0;
 }
 
 __uml_setup("--help", Usage,
Index: 2.6.10/arch/um/os-Linux/Makefile
===================================================================
--- 2.6.10.orig/arch/um/os-Linux/Makefile	2005-01-09 21:46:47.000000000 -0500
+++ 2.6.10/arch/um/os-Linux/Makefile	2005-01-09 21:47:25.000000000 -0500
@@ -11,3 +11,5 @@
 
 $(USER_OBJS) : %.o: %.c
 	$(CC) $(CFLAGS_$(notdir $@)) $(USER_CFLAGS) -c -o $@ $<
+
+CFLAGS_user_syms.o += -DSUBARCH_$(SUBARCH)
Index: 2.6.10/arch/um/os-Linux/elf_aux.c
===================================================================
--- 2.6.10.orig/arch/um/os-Linux/elf_aux.c	2005-01-09 21:46:47.000000000 -0500
+++ 2.6.10/arch/um/os-Linux/elf_aux.c	2005-01-09 21:47:25.000000000 -0500
@@ -26,7 +26,6 @@
 
 unsigned long __kernel_vsyscall;
 
-
 __init void scan_elf_aux( char **envp)
 {
 	long page_size = 0;
Index: 2.6.10/arch/um/os-Linux/user_syms.c
===================================================================
--- 2.6.10.orig/arch/um/os-Linux/user_syms.c	2005-01-09 21:46:47.000000000 -0500
+++ 2.6.10/arch/um/os-Linux/user_syms.c	2005-01-09 21:47:25.000000000 -0500
@@ -26,9 +26,6 @@
 
 EXPORT_SYMBOL(strstr);
 
-EXPORT_SYMBOL(vsyscall_ehdr);
-EXPORT_SYMBOL(vsyscall_end);
-
 /* Here, instead, I can provide a fake prototype. Yes, someone cares: genksyms.
  * However, the modules will use the CRC defined *here*, no matter if it is
  * good; so the versions of these symbols will always match
@@ -37,6 +34,11 @@
        int sym(void);                  \
        EXPORT_SYMBOL(sym);
 
+#ifdef SUBARCH_i386
+EXPORT_SYMBOL(vsyscall_ehdr);
+EXPORT_SYMBOL(vsyscall_end);
+#endif
+
 EXPORT_SYMBOL_PROTO(__errno_location);
 
 EXPORT_SYMBOL_PROTO(access);
Index: 2.6.10/include/asm-um/processor-i386.h
===================================================================
--- 2.6.10.orig/include/asm-um/processor-i386.h	2005-01-09 21:46:47.000000000 -0500
+++ 2.6.10/include/asm-um/processor-i386.h	2005-01-09 21:47:25.000000000 -0500
@@ -24,7 +24,8 @@
  * instruction pointer ("program counter"). Stolen
  * from asm-i386/processor.h
  */
-#define current_text_addr() ({ void *pc; __asm__("movl $1f,%0\n1:":"=g" (pc)); pc; })
+#define current_text_addr() \
+	({ void *pc; __asm__("movl $1f,%0\n1:":"=g" (pc)); pc; })
 
 #include "asm/processor-generic.h"
 
Index: 2.6.10/include/asm-um/thread_info.h
===================================================================
--- 2.6.10.orig/include/asm-um/thread_info.h	2005-01-09 21:46:47.000000000 -0500
+++ 2.6.10/include/asm-um/thread_info.h	2005-01-09 21:47:25.000000000 -0500
@@ -47,7 +47,7 @@
 	struct thread_info *ti;
 	unsigned long mask = PAGE_SIZE *
 		(1 << CONFIG_KERNEL_STACK_ORDER) - 1;
-	__asm__("andl %%esp,%0; ":"=r" (ti) : "0" (~mask));
+        ti = (struct thread_info *) (((unsigned long) &ti) & ~mask);
 	return ti;
 }
 

