Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268450AbUHTRxx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268450AbUHTRxx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 13:53:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268457AbUHTRxx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 13:53:53 -0400
Received: from [12.177.129.25] ([12.177.129.25]:43715 "EHLO
	ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S268450AbUHTRww (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 13:52:52 -0400
Message-Id: <200408201854.i7KIsfIF003754@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: [ PATCH ] 2.6.8.1-mm3 - Make UML build and run
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 20 Aug 2004 14:54:41 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch includes the following -
	updated defconfig
	move uml.lds.S and main.c from arch/um to arch/um/kernel per Sam's
suggestions
	steal bitops.c from arch/i386
	convert all calls to open_private_file to dentry_open

				Jeff
	

Index: 2.6.8.1-mm3/arch/um/Makefile
===================================================================
--- 2.6.8.1-mm3.orig/arch/um/Makefile	2004-08-20 13:01:54.000000000 -0400
+++ 2.6.8.1-mm3/arch/um/Makefile	2004-08-20 13:35:16.000000000 -0400
@@ -86,8 +86,6 @@
 
 LDFLAGS_vmlinux = -r
 
-vmlinux: $(ARCH_DIR)/main.o 
-
 # These aren't in Makefile-tt because they are needed in the !CONFIG_MODE_TT +
 # CONFIG_MODE_SKAS + CONFIG_STATIC_LINK case.
 
@@ -120,14 +118,11 @@
 
 export CPPFLAGS_$(LD_SCRIPT-y) = $(CPPFLAGS_vmlinux.lds) -P -C -Uum
 
-LD_SCRIPT-y := $(ARCH_DIR)/$(LD_SCRIPT-y)
-
-#$(LD_SCRIPT-y) : $(LD_SCRIPT-y:.s=.S) scripts FORCE
-#	$(call if_changed_dep,as_s_S)
+LD_SCRIPT-y := $(ARCH_DIR)/kernel/$(LD_SCRIPT-y)
 
 linux: vmlinux $(LD_SCRIPT-y)
 	$(CC) -Wl,-T,$(LD_SCRIPT-y) $(LINK-y) $(LINK_WRAPS) \
-		-o linux $(ARCH_DIR)/main.o vmlinux -L/usr/lib -lutil
+		-o linux vmlinux -L/usr/lib -lutil
 
 USER_CFLAGS := $(patsubst -I%,,$(CFLAGS))
 USER_CFLAGS := $(patsubst -Derrno=kernel_errno,,$(USER_CFLAGS))
@@ -162,10 +157,6 @@
 MRPROPER_FILES += $(SYMLINK_HEADERS) $(ARCH_SYMLINKS) \
 	$(addprefix $(ARCH_DIR)/kernel/,$(KERN_SYMLINKS))
 
-$(ARCH_DIR)/main.o: $(ARCH_DIR)/main.c sys_prepare
-	@ echo '  MAIN    $@'
-	@ $(CC) $(USER_CFLAGS) $(EXTRA_CFLAGS) -c -o $@ $<
-
 archmrproper:
 	@:
 
Index: 2.6.8.1-mm3/arch/um/defconfig
===================================================================
--- 2.6.8.1-mm3.orig/arch/um/defconfig	2004-08-20 13:01:53.000000000 -0400
+++ 2.6.8.1-mm3/arch/um/defconfig	2004-08-20 13:03:18.000000000 -0400
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.8.1-mm1
-# Mon Aug 16 22:34:07 2004
+# Linux kernel version: 2.6.8.1-mm3
+# Fri Aug 20 13:03:03 2004
 #
 CONFIG_USERMODE=y
 CONFIG_MMU=y
@@ -43,7 +43,6 @@
 # CONFIG_POSIX_MQUEUE is not set
 CONFIG_BSD_PROCESS_ACCT=y
 # CONFIG_BSD_PROCESS_ACCT_V3 is not set
-# CONFIG_PAGG is not set
 CONFIG_SYSCTL=y
 # CONFIG_AUDIT is not set
 CONFIG_LOG_BUF_SHIFT=14
@@ -55,6 +54,7 @@
 # CONFIG_KALLSYMS_EXTRA_PASS is not set
 CONFIG_FUTEX=y
 CONFIG_EPOLL=y
+# CONFIG_CPUSETS is not set
 CONFIG_IOSCHED_NOOP=y
 CONFIG_IOSCHED_AS=y
 CONFIG_IOSCHED_DEADLINE=y
@@ -236,6 +236,9 @@
 # CONFIG_EXT2_FS_XATTR is not set
 # CONFIG_EXT3_FS is not set
 # CONFIG_JBD is not set
+CONFIG_REISER4_FS=y
+CONFIG_REISER4_LARGE_KEY=y
+# CONFIG_REISER4_CHECK is not set
 CONFIG_REISERFS_FS=y
 # CONFIG_REISERFS_CHECK is not set
 # CONFIG_REISERFS_PROC_INFO is not set
Index: 2.6.8.1-mm3/arch/um/kernel/Makefile
===================================================================
--- 2.6.8.1-mm3.orig/arch/um/kernel/Makefile	2004-08-20 13:01:54.000000000 -0400
+++ 2.6.8.1-mm3/arch/um/kernel/Makefile	2004-08-20 13:34:38.000000000 -0400
@@ -3,10 +3,10 @@
 # Licensed under the GPL
 #
 
-extra-y := vmlinux.lds
+extra-y := vmlinux.lds uml.lds
 
 obj-y = checksum.o config.o exec_kern.o exitcode.o frame_kern.o frame.o \
-	helper.o init_task.o irq.o irq_user.o ksyms.o mem.o mem_user.o \
+	helper.o init_task.o irq.o irq_user.o ksyms.o main.o mem.o mem_user.o \
 	physmem.o process.o process_kern.o ptrace.o reboot.o resource.o \
 	sigio_user.o sigio_kern.o signal_kern.o signal_user.o smp.o \
 	syscall_kern.o syscall_user.o sysrq.o sys_call_table.o tempfile.o \
@@ -24,7 +24,7 @@
 user-objs-$(CONFIG_TTY_LOG) += tty_log.o
 
 USER_OBJS := $(filter %_user.o,$(obj-y))  $(user-objs-y) config.o helper.o \
-	process.o tempfile.o time.o tty_log.o umid.o user_util.o
+	main.o process.o tempfile.o time.o tty_log.o umid.o user_util.o
 USER_OBJS := $(foreach file,$(USER_OBJS),$(obj)/$(file))
 
 CFLAGS_frame.o := $(patsubst -fomit-frame-pointer,,$(USER_CFLAGS))
Index: 2.6.8.1-mm3/arch/um/kernel/main.c
===================================================================
--- 2.6.8.1-mm3.orig/arch/um/kernel/main.c	2003-09-15 09:40:47.000000000 -0400
+++ 2.6.8.1-mm3/arch/um/kernel/main.c	2004-08-20 13:34:06.000000000 -0400
@@ -0,0 +1,230 @@
+/* 
+ * Copyright (C) 2000, 2001 Jeff Dike (jdike@karaya.com)
+ * Licensed under the GPL
+ */
+
+#include <unistd.h>
+#include <stdio.h> 
+#include <stdlib.h>
+#include <string.h>
+#include <signal.h>
+#include <errno.h>
+#include <sys/resource.h>
+#include <sys/mman.h>
+#include <sys/user.h>
+#include <asm/page.h>
+#include "user_util.h"
+#include "kern_util.h"
+#include "mem_user.h"
+#include "signal_user.h"
+#include "user.h"
+#include "init.h"
+#include "mode.h"
+#include "choose-mode.h"
+#include "uml-config.h"
+
+/* Set in set_stklim, which is called from main and __wrap_malloc.  
+ * __wrap_malloc only calls it if main hasn't started.
+ */
+unsigned long stacksizelim;
+
+/* Set in main */
+char *linux_prog;
+
+#define PGD_BOUND (4 * 1024 * 1024)
+#define STACKSIZE (8 * 1024 * 1024)
+#define THREAD_NAME_LEN (256)
+
+static void set_stklim(void)
+{
+	struct rlimit lim;
+
+	if(getrlimit(RLIMIT_STACK, &lim) < 0){
+		perror("getrlimit");
+		exit(1);
+	}
+	if((lim.rlim_cur == RLIM_INFINITY) || (lim.rlim_cur > STACKSIZE)){
+		lim.rlim_cur = STACKSIZE;
+		if(setrlimit(RLIMIT_STACK, &lim) < 0){
+			perror("setrlimit");
+			exit(1);
+		}
+	}
+	stacksizelim = (lim.rlim_cur + PGD_BOUND - 1) & ~(PGD_BOUND - 1);
+}
+
+static __init void do_uml_initcalls(void)
+{
+	initcall_t *call;
+
+	call = &__uml_initcall_start;
+	while (call < &__uml_initcall_end){;
+		(*call)();
+		call++;
+	}
+}
+
+static void last_ditch_exit(int sig)
+{
+	CHOOSE_MODE(kmalloc_ok = 0, (void) 0);
+	signal(SIGINT, SIG_DFL);
+	signal(SIGTERM, SIG_DFL);
+	signal(SIGHUP, SIG_DFL);
+	uml_cleanup();
+	exit(1);
+}
+
+extern int uml_exitcode;
+
+int main(int argc, char **argv, char **envp)
+{
+	char **new_argv;
+	sigset_t mask;
+	int ret, i;
+
+	/* Enable all signals except SIGIO - in some environments, we can 
+	 * enter with some signals blocked
+	 */
+
+	sigemptyset(&mask);
+	sigaddset(&mask, SIGIO);
+	if(sigprocmask(SIG_SETMASK, &mask, NULL) < 0){
+		perror("sigprocmask");
+		exit(1);
+	}
+
+#ifdef UML_CONFIG_MODE_TT
+	/* Allocate memory for thread command lines */
+	if(argc < 2 || strlen(argv[1]) < THREAD_NAME_LEN - 1){
+
+		char padding[THREAD_NAME_LEN] = { 
+			[ 0 ...  THREAD_NAME_LEN - 2] = ' ', '\0' 
+		};
+
+		new_argv = malloc((argc + 2) * sizeof(char*));
+		if(!new_argv) {
+			perror("Allocating extended argv");
+			exit(1);
+		}	
+		
+		new_argv[0] = argv[0];
+		new_argv[1] = padding;
+		
+		for(i = 2; i <= argc; i++)
+			new_argv[i] = argv[i - 1];
+		new_argv[argc + 1] = NULL;
+		
+		execvp(new_argv[0], new_argv);
+		perror("execing with extended args");
+		exit(1);
+	}	
+#endif
+
+	linux_prog = argv[0];
+
+	set_stklim();
+
+	new_argv = malloc((argc + 1) * sizeof(char *));
+	if(new_argv == NULL){
+		perror("Mallocing argv");
+		exit(1);
+	}
+	for(i=0;i<argc;i++){
+		new_argv[i] = strdup(argv[i]);
+		if(new_argv[i] == NULL){
+			perror("Mallocing an arg");
+			exit(1);
+		}
+	}
+	new_argv[argc] = NULL;
+
+	set_handler(SIGINT, last_ditch_exit, SA_ONESHOT | SA_NODEFER, -1);
+	set_handler(SIGTERM, last_ditch_exit, SA_ONESHOT | SA_NODEFER, -1);
+	set_handler(SIGHUP, last_ditch_exit, SA_ONESHOT | SA_NODEFER, -1);
+
+	do_uml_initcalls();
+	ret = linux_main(argc, argv);
+	
+	/* Reboot */
+	if(ret){
+		printf("\n");
+		execvp(new_argv[0], new_argv);
+		perror("Failed to exec kernel");
+		ret = 1;
+	}
+	printf("\n");
+	return(uml_exitcode);
+}
+
+#define CAN_KMALLOC() \
+	(kmalloc_ok && CHOOSE_MODE((getpid() != tracing_pid), 1))
+
+extern void *__real_malloc(int);
+
+void *__wrap_malloc(int size)
+{
+	void *ret;
+
+	if(!CAN_KMALLOC())
+		return(__real_malloc(size));
+	else if(size <= PAGE_SIZE) /* finding contiguos pages can be hard*/
+		ret = um_kmalloc(size);
+	else ret = um_vmalloc(size);
+
+	/* glibc people insist that if malloc fails, errno should be
+	 * set by malloc as well. So we do.
+	 */
+	if(ret == NULL)
+		errno = ENOMEM;
+
+	return(ret);
+}
+
+void *__wrap_calloc(int n, int size)
+{
+	void *ptr = __wrap_malloc(n * size);
+
+	if(ptr == NULL) return(NULL);
+	memset(ptr, 0, n * size);
+	return(ptr);
+}
+
+extern void __real_free(void *);
+
+extern unsigned long high_physmem;
+
+void __wrap_free(void *ptr)
+{
+	unsigned long addr = (unsigned long) ptr;
+
+	/* We need to know how the allocation happened, so it can be correctly
+	 * freed.  This is done by seeing what region of memory the pointer is
+	 * in -
+	 * 	physical memory - kmalloc/kfree
+	 *	kernel virtual memory - vmalloc/vfree
+	 * 	anywhere else - malloc/free
+	 * If kmalloc is not yet possible, then the kernel memory regions
+	 * may not be set up yet, and the variables not initialized.  So,
+	 * free is called.
+	 */
+	if(CAN_KMALLOC()){
+		if((addr >= uml_physmem) && (addr <= high_physmem))
+			kfree(ptr);
+		else if((addr >= start_vm) && (addr <= end_vm))
+			vfree(ptr);
+		else
+			__real_free(ptr);
+	}
+	else __real_free(ptr);
+}
+
+/*
+ * Overrides for Emacs so that we follow Linus's tabbing style.
+ * Emacs will notice this stuff at the end of the file and automatically
+ * adjust the settings for this buffer only.  This must remain at the end
+ * of the file.
+ * ---------------------------------------------------------------------------
+ * Local variables:
+ * c-file-style: "linux"
+ * End:
+ */
Index: 2.6.8.1-mm3/arch/um/kernel/uml.lds.S
===================================================================
--- 2.6.8.1-mm3.orig/arch/um/kernel/uml.lds.S	2003-09-15 09:40:47.000000000 -0400
+++ 2.6.8.1-mm3/arch/um/kernel/uml.lds.S	2004-08-20 13:13:21.000000000 -0400
@@ -0,0 +1,96 @@
+#include <asm-generic/vmlinux.lds.h>
+	
+OUTPUT_FORMAT(ELF_FORMAT)
+OUTPUT_ARCH(ELF_ARCH)
+ENTRY(_start)
+jiffies = jiffies_64;
+
+SECTIONS
+{
+  . = START + SIZEOF_HEADERS;
+
+  __binary_start = .;
+#ifdef MODE_TT
+  .thread_private : {
+    __start_thread_private = .;
+    errno = .;
+    . += 4;
+    arch/um/kernel/tt/unmap_fin.o (.data)
+    __end_thread_private = .;
+  }
+  . = ALIGN(4096);
+  .remap : { arch/um/kernel/tt/unmap_fin.o (.text) }
+#endif
+
+  . = ALIGN(4096);		/* Init code and data */
+  _stext = .;
+  __init_begin = .;
+  .init.text : {
+	_sinittext = .;
+	*(.init.text)
+	_einittext = .;
+  }
+  . = ALIGN(4096);
+  .text      :
+  {
+    *(.text)
+    SCHED_TEXT
+    /* .gnu.warning sections are handled specially by elf32.em.  */
+    *(.gnu.warning)
+    *(.gnu.linkonce.t*)
+  }
+
+  #include "asm/common.lds.S"
+
+  init.data : { *(init.data) }
+  .data    :
+  {
+    . = ALIGN(KERNEL_STACK_SIZE);		/* init_task */
+    *(.data.init_task)
+    *(.data)
+    *(.gnu.linkonce.d*)
+    CONSTRUCTORS
+  }
+  .data1   : { *(.data1) }
+  .ctors         :
+  {
+    *(.ctors)
+  }
+  .dtors         :
+  {
+    *(.dtors)
+  }
+
+  .got           : { *(.got.plt) *(.got) }
+  .dynamic       : { *(.dynamic) }
+  /* We want the small data sections together, so single-instruction offsets
+     can access them all, and initialized data all before uninitialized, so
+     we can shorten the on-disk segment size.  */
+  .sdata     : { *(.sdata) }
+  _edata  =  .;
+  PROVIDE (edata = .);
+  . = ALIGN(0x1000);
+  .sbss      : 
+  {
+   __bss_start = .;
+   PROVIDE(_bss_start = .);
+   *(.sbss) 
+   *(.scommon) 
+  }
+  .bss       :
+  {
+   *(.dynbss)
+   *(.bss)
+   *(COMMON)
+  }
+  _end = . ;
+  PROVIDE (end = .);
+  /* Stabs debugging sections.  */
+  .stab 0 : { *(.stab) }
+  .stabstr 0 : { *(.stabstr) }
+  .stab.excl 0 : { *(.stab.excl) }
+  .stab.exclstr 0 : { *(.stab.exclstr) }
+  .stab.index 0 : { *(.stab.index) }
+  .stab.indexstr 0 : { *(.stab.indexstr) }
+  .comment 0 : { *(.comment) }
+}
Index: 2.6.8.1-mm3/arch/um/main.c
===================================================================
--- 2.6.8.1-mm3.orig/arch/um/main.c	2004-08-20 13:01:54.000000000 -0400
+++ 2.6.8.1-mm3/arch/um/main.c	2003-09-15 09:40:47.000000000 -0400
@@ -1,230 +0,0 @@
-/* 
- * Copyright (C) 2000, 2001 Jeff Dike (jdike@karaya.com)
- * Licensed under the GPL
- */
-
-#include <unistd.h>
-#include <stdio.h> 
-#include <stdlib.h>
-#include <string.h>
-#include <signal.h>
-#include <errno.h>
-#include <sys/resource.h>
-#include <sys/mman.h>
-#include <sys/user.h>
-#include <asm/page.h>
-#include "user_util.h"
-#include "kern_util.h"
-#include "mem_user.h"
-#include "signal_user.h"
-#include "user.h"
-#include "init.h"
-#include "mode.h"
-#include "choose-mode.h"
-#include "uml-config.h"
-
-/* Set in set_stklim, which is called from main and __wrap_malloc.  
- * __wrap_malloc only calls it if main hasn't started.
- */
-unsigned long stacksizelim;
-
-/* Set in main */
-char *linux_prog;
-
-#define PGD_BOUND (4 * 1024 * 1024)
-#define STACKSIZE (8 * 1024 * 1024)
-#define THREAD_NAME_LEN (256)
-
-static void set_stklim(void)
-{
-	struct rlimit lim;
-
-	if(getrlimit(RLIMIT_STACK, &lim) < 0){
-		perror("getrlimit");
-		exit(1);
-	}
-	if((lim.rlim_cur == RLIM_INFINITY) || (lim.rlim_cur > STACKSIZE)){
-		lim.rlim_cur = STACKSIZE;
-		if(setrlimit(RLIMIT_STACK, &lim) < 0){
-			perror("setrlimit");
-			exit(1);
-		}
-	}
-	stacksizelim = (lim.rlim_cur + PGD_BOUND - 1) & ~(PGD_BOUND - 1);
-}
-
-static __init void do_uml_initcalls(void)
-{
-	initcall_t *call;
-
-	call = &__uml_initcall_start;
-	while (call < &__uml_initcall_end){;
-		(*call)();
-		call++;
-	}
-}
-
-static void last_ditch_exit(int sig)
-{
-	CHOOSE_MODE(kmalloc_ok = 0, (void) 0);
-	signal(SIGINT, SIG_DFL);
-	signal(SIGTERM, SIG_DFL);
-	signal(SIGHUP, SIG_DFL);
-	uml_cleanup();
-	exit(1);
-}
-
-extern int uml_exitcode;
-
-int main(int argc, char **argv, char **envp)
-{
-	char **new_argv;
-	sigset_t mask;
-	int ret, i;
-
-	/* Enable all signals except SIGIO - in some environments, we can 
-	 * enter with some signals blocked
-	 */
-
-	sigemptyset(&mask);
-	sigaddset(&mask, SIGIO);
-	if(sigprocmask(SIG_SETMASK, &mask, NULL) < 0){
-		perror("sigprocmask");
-		exit(1);
-	}
-
-#ifdef UML_CONFIG_MODE_TT
-	/* Allocate memory for thread command lines */
-	if(argc < 2 || strlen(argv[1]) < THREAD_NAME_LEN - 1){
-
-		char padding[THREAD_NAME_LEN] = { 
-			[ 0 ...  THREAD_NAME_LEN - 2] = ' ', '\0' 
-		};
-
-		new_argv = malloc((argc + 2) * sizeof(char*));
-		if(!new_argv) {
-			perror("Allocating extended argv");
-			exit(1);
-		}	
-		
-		new_argv[0] = argv[0];
-		new_argv[1] = padding;
-		
-		for(i = 2; i <= argc; i++)
-			new_argv[i] = argv[i - 1];
-		new_argv[argc + 1] = NULL;
-		
-		execvp(new_argv[0], new_argv);
-		perror("execing with extended args");
-		exit(1);
-	}	
-#endif
-
-	linux_prog = argv[0];
-
-	set_stklim();
-
-	new_argv = malloc((argc + 1) * sizeof(char *));
-	if(new_argv == NULL){
-		perror("Mallocing argv");
-		exit(1);
-	}
-	for(i=0;i<argc;i++){
-		new_argv[i] = strdup(argv[i]);
-		if(new_argv[i] == NULL){
-			perror("Mallocing an arg");
-			exit(1);
-		}
-	}
-	new_argv[argc] = NULL;
-
-	set_handler(SIGINT, last_ditch_exit, SA_ONESHOT | SA_NODEFER, -1);
-	set_handler(SIGTERM, last_ditch_exit, SA_ONESHOT | SA_NODEFER, -1);
-	set_handler(SIGHUP, last_ditch_exit, SA_ONESHOT | SA_NODEFER, -1);
-
-	do_uml_initcalls();
-	ret = linux_main(argc, argv);
-	
-	/* Reboot */
-	if(ret){
-		printf("\n");
-		execvp(new_argv[0], new_argv);
-		perror("Failed to exec kernel");
-		ret = 1;
-	}
-	printf("\n");
-	return(uml_exitcode);
-}
-
-#define CAN_KMALLOC() \
-	(kmalloc_ok && CHOOSE_MODE((getpid() != tracing_pid), 1))
-
-extern void *__real_malloc(int);
-
-void *__wrap_malloc(int size)
-{
-	void *ret;
-
-	if(!CAN_KMALLOC())
-		return(__real_malloc(size));
-	else if(size <= PAGE_SIZE) /* finding contiguos pages can be hard*/
-		ret = um_kmalloc(size);
-	else ret = um_vmalloc(size);
-
-	/* glibc people insist that if malloc fails, errno should be
-	 * set by malloc as well. So we do.
-	 */
-	if(ret == NULL)
-		errno = ENOMEM;
-
-	return(ret);
-}
-
-void *__wrap_calloc(int n, int size)
-{
-	void *ptr = __wrap_malloc(n * size);
-
-	if(ptr == NULL) return(NULL);
-	memset(ptr, 0, n * size);
-	return(ptr);
-}
-
-extern void __real_free(void *);
-
-extern unsigned long high_physmem;
-
-void __wrap_free(void *ptr)
-{
-	unsigned long addr = (unsigned long) ptr;
-
-	/* We need to know how the allocation happened, so it can be correctly
-	 * freed.  This is done by seeing what region of memory the pointer is
-	 * in -
-	 * 	physical memory - kmalloc/kfree
-	 *	kernel virtual memory - vmalloc/vfree
-	 * 	anywhere else - malloc/free
-	 * If kmalloc is not yet possible, then the kernel memory regions
-	 * may not be set up yet, and the variables not initialized.  So,
-	 * free is called.
-	 */
-	if(CAN_KMALLOC()){
-		if((addr >= uml_physmem) && (addr <= high_physmem))
-			kfree(ptr);
-		else if((addr >= start_vm) && (addr <= end_vm))
-			vfree(ptr);
-		else
-			__real_free(ptr);
-	}
-	else __real_free(ptr);
-}
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */
Index: 2.6.8.1-mm3/arch/um/sys-i386/Makefile
===================================================================
--- 2.6.8.1-mm3.orig/arch/um/sys-i386/Makefile	2004-08-20 13:01:54.000000000 -0400
+++ 2.6.8.1-mm3/arch/um/sys-i386/Makefile	2004-08-20 13:18:47.000000000 -0400
@@ -1,5 +1,5 @@
-obj-y = bugs.o checksum.o fault.o ksyms.o ldt.o ptrace.o ptrace_user.o \
-	semaphore.o sigcontext.o syscalls.o sysrq.o time.o
+obj-y = bitops.o bugs.o checksum.o fault.o ksyms.o ldt.o ptrace.o \
+	ptrace_user.o semaphore.o sigcontext.o syscalls.o sysrq.o time.o
 
 obj-$(CONFIG_HIGHMEM) += highmem.o
 obj-$(CONFIG_MODULES) += module.o
@@ -7,11 +7,12 @@
 USER_OBJS := bugs.o ptrace_user.o sigcontext.o fault.o
 USER_OBJS := $(foreach file,$(USER_OBJS),$(obj)/$(file))
 
-SYMLINKS = semaphore.c highmem.c module.c
+SYMLINKS = bitops.c semaphore.c highmem.c module.c
 SYMLINKS := $(foreach f,$(SYMLINKS),$(src)/$f)
 
 clean-files := $(SYMLINKS)
 
+bitops.c-dir = lib
 semaphore.c-dir = kernel
 highmem.c-dir = mm
 module.c-dir = kernel
Index: 2.6.8.1-mm3/arch/um/uml.lds.S
===================================================================
--- 2.6.8.1-mm3.orig/arch/um/uml.lds.S	2004-08-20 13:01:54.000000000 -0400
+++ 2.6.8.1-mm3/arch/um/uml.lds.S	2003-09-15 09:40:47.000000000 -0400
@@ -1,96 +0,0 @@
-#include <asm-generic/vmlinux.lds.h>
-	
-OUTPUT_FORMAT(ELF_FORMAT)
-OUTPUT_ARCH(ELF_ARCH)
-ENTRY(_start)
-jiffies = jiffies_64;
-
-SECTIONS
-{
-  . = START + SIZEOF_HEADERS;
-
-  __binary_start = .;
-#ifdef MODE_TT
-  .thread_private : {
-    __start_thread_private = .;
-    errno = .;
-    . += 4;
-    arch/um/kernel/tt/unmap_fin.o (.data)
-    __end_thread_private = .;
-  }
-  . = ALIGN(4096);
-  .remap : { arch/um/kernel/tt/unmap_fin.o (.text) }
-#endif
-
-  . = ALIGN(4096);		/* Init code and data */
-  _stext = .;
-  __init_begin = .;
-  .init.text : {
-	_sinittext = .;
-	*(.init.text)
-	_einittext = .;
-  }
-  . = ALIGN(4096);
-  .text      :
-  {
-    *(.text)
-    SCHED_TEXT
-    /* .gnu.warning sections are handled specially by elf32.em.  */
-    *(.gnu.warning)
-    *(.gnu.linkonce.t*)
-  }
-
-  #include "asm/common.lds.S"
-
-  init.data : { *(init.data) }
-  .data    :
-  {
-    . = ALIGN(KERNEL_STACK_SIZE);		/* init_task */
-    *(.data.init_task)
-    *(.data)
-    *(.gnu.linkonce.d*)
-    CONSTRUCTORS
-  }
-  .data1   : { *(.data1) }
-  .ctors         :
-  {
-    *(.ctors)
-  }
-  .dtors         :
-  {
-    *(.dtors)
-  }
-
-  .got           : { *(.got.plt) *(.got) }
-  .dynamic       : { *(.dynamic) }
-  /* We want the small data sections together, so single-instruction offsets
-     can access them all, and initialized data all before uninitialized, so
-     we can shorten the on-disk segment size.  */
-  .sdata     : { *(.sdata) }
-  _edata  =  .;
-  PROVIDE (edata = .);
-  . = ALIGN(0x1000);
-  .sbss      : 
-  {
-   __bss_start = .;
-   PROVIDE(_bss_start = .);
-   *(.sbss) 
-   *(.scommon) 
-  }
-  .bss       :
-  {
-   *(.dynbss)
-   *(.bss)
-   *(COMMON)
-  }
-  _end = . ;
-  PROVIDE (end = .);
-  /* Stabs debugging sections.  */
-  .stab 0 : { *(.stab) }
-  .stabstr 0 : { *(.stabstr) }
-  .stab.excl 0 : { *(.stab.excl) }
-  .stab.exclstr 0 : { *(.stab.exclstr) }
-  .stab.index 0 : { *(.stab.index) }
-  .stab.indexstr 0 : { *(.stab.indexstr) }
-  .comment 0 : { *(.comment) }
-}
Index: 2.6.8.1-mm3/fs/hppfs/hppfs_kern.c
===================================================================
--- 2.6.8.1-mm3.orig/fs/hppfs/hppfs_kern.c	2004-08-20 13:01:57.000000000 -0400
+++ 2.6.8.1-mm3/fs/hppfs/hppfs_kern.c	2004-08-20 13:31:11.000000000 -0400
@@ -24,7 +24,7 @@
 };
 
 struct hppfs_private {
-	struct file proc_file;
+	struct file *proc_file;
 	int host_fd;
 	loff_t len;
 	struct hppfs_data *contents;
@@ -307,7 +307,7 @@
 		if(count > 0)
 			*ppos += count;
 	}
-	else count = read_proc(&hppfs->proc_file, buf, count, ppos, 1);
+	else count = read_proc(hppfs->proc_file, buf, count, ppos, 1);
 
 	return(count);
 }
@@ -316,7 +316,7 @@
 			   loff_t *ppos)
 {
 	struct hppfs_private *data = file->private_data;
-	struct file *proc_file = &data->proc_file;
+	struct file *proc_file = data->proc_file;
 	ssize_t (*write)(struct file *, const char *, size_t, loff_t *);
 	int err;
 
@@ -471,9 +471,10 @@
 	proc_dentry = HPPFS_I(inode)->proc_dentry;
 
 	/* XXX This isn't closed anywhere */
-	err = open_private_file(&data->proc_file, proc_dentry,
-				file_mode(file->f_mode));
-	if(err)
+	data->proc_file = dentry_open(dget(proc_dentry), NULL, 
+				      file_mode(file->f_mode));
+	err = PTR_ERR(data->proc_file);
+	if(IS_ERR(data->proc_file))
 		goto out_free1;
 
 	type = os_file_type(host_file);
@@ -524,9 +525,10 @@
 		goto out;
 
 	proc_dentry = HPPFS_I(inode)->proc_dentry;
-	err = open_private_file(&data->proc_file, proc_dentry,
-				file_mode(file->f_mode));
-	if(err)
+	data->proc_file = dentry_open(dget(proc_dentry), NULL, 
+				      file_mode(file->f_mode));
+	err = PTR_ERR(data->proc_file);
+	if(IS_ERR(data->proc_file))
 		goto out_free;
 
 	file->private_data = data;
@@ -657,40 +659,42 @@
 
 static int hppfs_readlink(struct dentry *dentry, char *buffer, int buflen)
 {
-	struct file proc_file;
+	struct file *proc_file;
 	struct dentry *proc_dentry;
 	int (*readlink)(struct dentry *, char *, int);
 	int err, n;
 
 	proc_dentry = HPPFS_I(dentry->d_inode)->proc_dentry;
-	err = open_private_file(&proc_file, proc_dentry, O_RDONLY);
-	if(err)
+	proc_file = dentry_open(dget(proc_dentry), NULL, O_RDONLY);
+	err = PTR_ERR(proc_dentry);
+	if(IS_ERR(proc_dentry))
 		return(err);
 
 	readlink = proc_dentry->d_inode->i_op->readlink;
 	n = (*readlink)(proc_dentry, buffer, buflen);
 
-	close_private_file(&proc_file);
+	fput(proc_file);
 
 	return(n);
 }
 
 static int hppfs_follow_link(struct dentry *dentry, struct nameidata *nd)
 {
-	struct file proc_file;
+	struct file *proc_file;
 	struct dentry *proc_dentry;
 	int (*follow_link)(struct dentry *, struct nameidata *);
 	int err, n;
 
 	proc_dentry = HPPFS_I(dentry->d_inode)->proc_dentry;
-	err = open_private_file(&proc_file, proc_dentry, O_RDONLY);
-	if(err)
+	proc_file = dentry_open(dget(proc_dentry), NULL, O_RDONLY);
+	err = PTR_ERR(proc_dentry);
+	if(IS_ERR(proc_dentry))
 		return(err);
 
 	follow_link = proc_dentry->d_inode->i_op->follow_link;
 	n = (*follow_link)(proc_dentry, nd);
 
-	close_private_file(&proc_file);
+	fput(proc_file);
 
 	return(n);
 }

