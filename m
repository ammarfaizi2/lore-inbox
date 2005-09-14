Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965081AbVINW1h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965081AbVINW1h (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 18:27:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965069AbVINW1R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 18:27:17 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:61957 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S965071AbVINW1I
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 18:27:08 -0400
Message-Id: <200509142156.j8ELu7dK012159@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       Gennady Sharapov <Gennady.V.Sharapov@intel.com>
Subject: [PATCH 7/10] UML - move libc code out of mem_user.c and tempfile.c
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 14 Sep 2005 17:56:07 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The serial UML OS-abstraction layer patch (um/kernel dir).

This moves all system calls from mem_user.c and tempfile.c files under 
os-Linux dir.

Signed-off-by: Gennady Sharapov <Gennady.V.Sharapov@intel.com>
Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.13-mm2/arch/um/include/mem_user.h
===================================================================
--- linux-2.6.13-mm2.orig/arch/um/include/mem_user.h	2005-09-08 14:55:12.000000000 -0400
+++ linux-2.6.13-mm2/arch/um/include/mem_user.h	2005-09-08 14:55:47.000000000 -0400
@@ -51,7 +51,6 @@
 
 extern void check_devanon(void);
 extern int init_mem_user(void);
-extern int create_mem_file(unsigned long len);
 extern void setup_memory(void *entry);
 extern unsigned long find_iomem(char *driver, unsigned long *len_out);
 extern int init_maps(unsigned long physmem, unsigned long iomem,
@@ -64,20 +63,6 @@
 extern void unmap_physmem(void);
 extern void map_memory(unsigned long virt, unsigned long phys,
 		       unsigned long len, int r, int w, int x);
-extern int protect_memory(unsigned long addr, unsigned long len, 
-			  int r, int w, int x, int must_succeed);
 extern unsigned long get_kmem_end(void);
-extern void check_tmpexec(void);
 
 #endif
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
Index: linux-2.6.13-mm2/arch/um/include/os.h
===================================================================
--- linux-2.6.13-mm2.orig/arch/um/include/os.h	2005-09-08 14:55:13.000000000 -0400
+++ linux-2.6.13-mm2/arch/um/include/os.h	2005-09-08 14:55:47.000000000 -0400
@@ -157,6 +157,9 @@
 extern void os_early_checks(void);
 extern int can_do_skas(void);
 
+/* mem.c */
+extern int create_mem_file(unsigned long len);
+  
 /* process.c */
 extern unsigned long os_process_pc(int pid);
 extern int os_process_parent(int pid);
@@ -181,6 +184,8 @@
 /* tt.c
  * for tt mode only (will be deleted in future...)
  */
+extern int protect_memory(unsigned long addr, unsigned long len, 
+			  int r, int w, int x, int must_succeed);
 extern void forward_pending_sigio(int target);
 extern int start_fork_tramp(void *arg, unsigned long temp_stack,
 			    int clone_flags, int (*tramp)(void *));
Index: linux-2.6.13-mm2/arch/um/kernel/Makefile
===================================================================
--- linux-2.6.13-mm2.orig/arch/um/kernel/Makefile	2005-09-08 14:55:13.000000000 -0400
+++ linux-2.6.13-mm2/arch/um/kernel/Makefile	2005-09-08 14:55:47.000000000 -0400
@@ -10,7 +10,7 @@
 	helper.o init_task.o irq.o irq_user.o ksyms.o main.o mem.o mem_user.o \
 	physmem.o process_kern.o ptrace.o reboot.o resource.o sigio_user.o \
 	sigio_kern.o signal_kern.o signal_user.o smp.o syscall_kern.o sysrq.o \
-	tempfile.o time.o time_kern.o tlb.o trap_kern.o trap_user.o \
+	time.o time_kern.o tlb.o trap_kern.o trap_user.o \
 	uaccess_user.o um_arch.o umid.o user_util.o
 
 obj-$(CONFIG_BLK_DEV_INITRD) += initrd.o
@@ -24,8 +24,8 @@
 
 user-objs-$(CONFIG_TTY_LOG) += tty_log.o
 
-USER_OBJS := $(user-objs-y) config.o helper.o main.o tempfile.o time.o \
-	tty_log.o umid.o user_util.o
+USER_OBJS := $(user-objs-y) config.o helper.o main.o time.o tty_log.o umid.o \
+	user_util.o
 
 include arch/um/scripts/Makefile.rules
 
Index: linux-2.6.13-mm2/arch/um/kernel/init_task.c
===================================================================
--- linux-2.6.13-mm2.orig/arch/um/kernel/init_task.c	2005-09-08 14:55:12.000000000 -0400
+++ linux-2.6.13-mm2/arch/um/kernel/init_task.c	2005-09-08 14:55:47.000000000 -0400
@@ -13,6 +13,7 @@
 #include "asm/pgtable.h"
 #include "user_util.h"
 #include "mem_user.h"
+#include "os.h"
 
 static struct fs_struct init_fs = INIT_FS;
 struct mm_struct init_mm = INIT_MM(init_mm);
@@ -45,8 +46,8 @@
 
 void unprotect_stack(unsigned long stack)
 {
-	protect_memory(stack, (1 << CONFIG_KERNEL_STACK_ORDER) * PAGE_SIZE, 
-		       1, 1, 0, 1);
+	os_protect_memory((void *) stack, (1 << CONFIG_KERNEL_STACK_ORDER) * PAGE_SIZE, 
+		       1, 1, 0);
 }
 
 /*
Index: linux-2.6.13-mm2/arch/um/kernel/mem_user.c
===================================================================
--- linux-2.6.13-mm2.orig/arch/um/kernel/mem_user.c	2005-09-08 14:55:12.000000000 -0400
+++ linux-2.6.13-mm2/arch/um/kernel/mem_user.c	2005-09-08 14:55:47.000000000 -0400
@@ -48,219 +48,16 @@
 #include "tempfile.h"
 #include "kern_constants.h"
 
-#define TEMPNAME_TEMPLATE "vm_file-XXXXXX"
-
-static int create_tmp_file(unsigned long len)
-{
-	int fd, err;
-	char zero;
-
-	fd = make_tempfile(TEMPNAME_TEMPLATE, NULL, 1);
-	if(fd < 0) {
-		os_print_error(fd, "make_tempfile");
-		exit(1);
-	}
-
-	err = os_mode_fd(fd, 0777);
-	if(err < 0){
-		os_print_error(err, "os_mode_fd");
-		exit(1);
-	}
-	err = os_seek_file(fd, len);
-	if(err < 0){
-		os_print_error(err, "os_seek_file");
-		exit(1);
-	}
-	zero = 0;
-	err = os_write_file(fd, &zero, 1);
-	if(err != 1){
-		os_print_error(err, "os_write_file");
-		exit(1);
-	}
-
-	return(fd);
-}
-
-void check_tmpexec(void)
-{
-	void *addr;
-	int err, fd = create_tmp_file(UM_KERN_PAGE_SIZE);
-
-	addr = mmap(NULL, UM_KERN_PAGE_SIZE,
-		    PROT_READ | PROT_WRITE | PROT_EXEC, MAP_PRIVATE, fd, 0);
-	printf("Checking PROT_EXEC mmap in /tmp...");
-	fflush(stdout);
-	if(addr == MAP_FAILED){
-		err = errno;
-		perror("failed");
-		if(err == EPERM)
-			printf("/tmp must be not mounted noexec\n");
-		exit(1);
-	}
-	printf("OK\n");
-	munmap(addr, UM_KERN_PAGE_SIZE);
-
-	os_close_file(fd);
-}
-
-static int have_devanon = 0;
-
-void check_devanon(void)
-{
-	int fd;
-
-	printk("Checking for /dev/anon on the host...");
-	fd = open("/dev/anon", O_RDWR);
-	if(fd < 0){
-		printk("Not available (open failed with errno %d)\n", errno);
-		return;
-	}
-
-	printk("OK\n");
-	have_devanon = 1;
-}
-
-static int create_anon_file(unsigned long len)
-{
-	void *addr;
-	int fd;
-
-	fd = open("/dev/anon", O_RDWR);
-	if(fd < 0) {
-		os_print_error(fd, "opening /dev/anon");
-		exit(1);
-	}
-
-	addr = mmap(NULL, len, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
-	if(addr == MAP_FAILED){
-		perror("mapping physmem file");
-		exit(1);
-	}
-	munmap(addr, len);
-
-	return(fd);
-}
-
-int create_mem_file(unsigned long len)
-{
-	int err, fd;
-
-	if(have_devanon)
-		fd = create_anon_file(len);
-	else fd = create_tmp_file(len);
-
-	err = os_set_exec_close(fd, 1);
-	if(err < 0)
-		os_print_error(err, "exec_close");
-	return(fd);
-}
-
 struct iomem_region *iomem_regions = NULL;
 int iomem_size = 0;
 
-static int __init parse_iomem(char *str, int *add)
-{
-	struct iomem_region *new;
-	struct uml_stat buf;
-	char *file, *driver;
-	int fd, err, size;
-
-	driver = str;
-	file = strchr(str,',');
-	if(file == NULL){
-		printf("parse_iomem : failed to parse iomem\n");
-		goto out;
-	}
-	*file = '\0';
-	file++;
-	fd = os_open_file(file, of_rdwr(OPENFLAGS()), 0);
-	if(fd < 0){
-		os_print_error(fd, "parse_iomem - Couldn't open io file");
-		goto out;
-	}
-
-	err = os_stat_fd(fd, &buf);
-	if(err < 0){
-		os_print_error(err, "parse_iomem - cannot stat_fd file");
-		goto out_close;
-	}
-
-	new = malloc(sizeof(*new));
-	if(new == NULL){
-		perror("Couldn't allocate iomem_region struct");
-		goto out_close;
-	}
-
-	size = (buf.ust_size + UM_KERN_PAGE_SIZE) & ~(UM_KERN_PAGE_SIZE - 1);
-
-	*new = ((struct iomem_region) { .next		= iomem_regions,
-					.driver		= driver,
-					.fd		= fd,
-					.size		= size,
-					.phys		= 0,
-					.virt		= 0 });
-	iomem_regions = new;
-	iomem_size += new->size + UM_KERN_PAGE_SIZE;
-
-	return(0);
- out_close:
-	os_close_file(fd);
- out:
-	return(1);
-}
+extern int parse_iomem(char *str, int *add) __init;
 
 __uml_setup("iomem=", parse_iomem,
 "iomem=<name>,<file>\n"
 "    Configure <file> as an IO memory region named <name>.\n\n"
 );
 
-int protect_memory(unsigned long addr, unsigned long len, int r, int w, int x,
-		   int must_succeed)
-{
-	int err;
-
-	err = os_protect_memory((void *) addr, len, r, w, x);
-	if(err < 0){
-                if(must_succeed)
-			panic("protect failed, err = %d", -err);
-		else return(err);
-	}
-	return(0);
-}
-
-#if 0
-/* Debugging facility for dumping stuff out to the host, avoiding the timing
- * problems that come with printf and breakpoints.
- * Enable in case of emergency.
- */
-
-int logging = 1;
-int logging_fd = -1;
-
-int logging_line = 0;
-char logging_buf[512];
-
-void log(char *fmt, ...)
-{
-        va_list ap;
-        struct timeval tv;
-        struct openflags flags;
-
-        if(logging == 0) return;
-        if(logging_fd < 0){
-                flags = of_create(of_trunc(of_rdwr(OPENFLAGS())));
-                logging_fd = os_open_file("log", flags, 0644);
-        }
-        gettimeofday(&tv, NULL);
-        sprintf(logging_buf, "%d\t %u.%u  ", logging_line++, tv.tv_sec,
-                tv.tv_usec);
-        va_start(ap, fmt);
-        vsprintf(&logging_buf[strlen(logging_buf)], fmt, ap);
-        va_end(ap);
-        write(logging_fd, logging_buf, strlen(logging_buf));
-}
-#endif
-
 /*
  * Overrides for Emacs so that we follow Linus's tabbing style.
  * Emacs will notice this stuff at the end of the file and automatically
Index: linux-2.6.13-mm2/arch/um/kernel/tempfile.c
===================================================================
--- linux-2.6.13-mm2.orig/arch/um/kernel/tempfile.c	2005-09-08 14:55:12.000000000 -0400
+++ linux-2.6.13-mm2/arch/um/kernel/tempfile.c	2005-09-08 05:17:51.187952264 -0400
@@ -1,82 +0,0 @@
-/*
- * Copyright (C) 2002 Jeff Dike (jdike@karaya.com)
- * Licensed under the GPL
- */
-
-#include <stdio.h>
-#include <stdlib.h>
-#include <unistd.h>
-#include <string.h>
-#include <errno.h>
-#include <sys/param.h>
-#include "init.h"
-
-/* Modified from create_mem_file and start_debugger */
-static char *tempdir = NULL;
-
-static void __init find_tempdir(void)
-{
-	char *dirs[] = { "TMP", "TEMP", "TMPDIR", NULL };
-	int i;
-	char *dir = NULL;
-
-	if(tempdir != NULL) return;	/* We've already been called */
-	for(i = 0; dirs[i]; i++){
-		dir = getenv(dirs[i]);
-		if((dir != NULL) && (*dir != '\0'))
-			break;
-	}
-	if((dir == NULL) || (*dir == '\0')) 
-		dir = "/tmp";
-
-	tempdir = malloc(strlen(dir) + 2);
-	if(tempdir == NULL){
-		fprintf(stderr, "Failed to malloc tempdir, "
-			"errno = %d\n", errno);
-		return;
-	}
-	strcpy(tempdir, dir);
-	strcat(tempdir, "/");
-}
-
-int make_tempfile(const char *template, char **out_tempname, int do_unlink)
-{
-	char tempname[MAXPATHLEN];
-	int fd;
-
-	find_tempdir();
-	if (*template != '/')
-		strcpy(tempname, tempdir);
-	else
-		*tempname = 0;
-	strcat(tempname, template);
-	fd = mkstemp(tempname);
-	if(fd < 0){
-		fprintf(stderr, "open - cannot create %s: %s\n", tempname, 
-			strerror(errno));
-		return -1;
-	}
-	if(do_unlink && (unlink(tempname) < 0)){
-		perror("unlink");
-		return -1;
-	}
-	if(out_tempname){
-		*out_tempname = strdup(tempname);
-		if(*out_tempname == NULL){
-			perror("strdup");
-			return -1;
-		}
-	}
-	return(fd);
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
Index: linux-2.6.13-mm2/arch/um/kernel/tlb.c
===================================================================
--- linux-2.6.13-mm2.orig/arch/um/kernel/tlb.c	2005-09-08 14:55:12.000000000 -0400
+++ linux-2.6.13-mm2/arch/um/kernel/tlb.c	2005-09-08 14:55:47.000000000 -0400
@@ -307,7 +307,7 @@
                 }
                 else if(pte_newprot(*pte)){
                         updated = 1;
-                        protect_memory(addr, PAGE_SIZE, 1, 1, 1, 1);
+                        os_protect_memory((void *) addr, PAGE_SIZE, 1, 1, 1);
                 }
                 addr += PAGE_SIZE;
         }
Index: linux-2.6.13-mm2/arch/um/kernel/tt/mem_user.c
===================================================================
--- linux-2.6.13-mm2.orig/arch/um/kernel/tt/mem_user.c	2005-09-08 14:55:12.000000000 -0400
+++ linux-2.6.13-mm2/arch/um/kernel/tt/mem_user.c	2005-09-08 14:55:47.000000000 -0400
@@ -12,6 +12,7 @@
 #include "tt.h"
 #include "mem_user.h"
 #include "user_util.h"
+#include "os.h"
 
 void remap_data(void *segment_start, void *segment_end, int w)
 {
Index: linux-2.6.13-mm2/arch/um/kernel/um_arch.c
===================================================================
--- linux-2.6.13-mm2.orig/arch/um/kernel/um_arch.c	2005-09-08 14:55:12.000000000 -0400
+++ linux-2.6.13-mm2/arch/um/kernel/um_arch.c	2005-09-08 14:55:47.000000000 -0400
@@ -361,11 +361,6 @@
 	uml_start = CHOOSE_MODE_PROC(set_task_sizes_tt, set_task_sizes_skas, 0,
 				     &host_task_size, &task_size);
 
-	/* Need to check this early because mmapping happens before the
-	 * kernel is running.
-	 */
-	check_tmpexec();
-
 	brk_start = (unsigned long) sbrk(0);
 	CHOOSE_MODE_PROC(before_mem_tt, before_mem_skas, brk_start);
 	/* Increase physical memory size for exec-shield users
Index: linux-2.6.13-mm2/arch/um/os-Linux/Makefile
===================================================================
--- linux-2.6.13-mm2.orig/arch/um/os-Linux/Makefile	2005-09-08 14:55:12.000000000 -0400
+++ linux-2.6.13-mm2/arch/um/os-Linux/Makefile	2005-09-08 14:55:47.000000000 -0400
@@ -3,11 +3,11 @@
 # Licensed under the GPL
 #
 
-obj-y = aio.o elf_aux.o file.o process.o signal.o start_up.o time.o tt.o \
-	tty.o user_syms.o drivers/ sys-$(SUBARCH)/
+obj-y = aio.o elf_aux.o file.o mem.o process.o signal.o start_up.o time.o \
+	tt.o tty.o user_syms.o drivers/ sys-$(SUBARCH)/
 
-USER_OBJS := aio.o elf_aux.o file.o process.o signal.o start_up.o time.o tt.o \
-	tty.o
+USER_OBJS := aio.o elf_aux.o file.o mem.o process.o signal.o start_up.o \
+	time.o tt.o tty.o
 
 elf_aux.o: $(ARCH_DIR)/kernel-offsets.h
 CFLAGS_elf_aux.o += -I$(objtree)/arch/um
Index: linux-2.6.13-mm2/arch/um/os-Linux/mem.c
===================================================================
--- linux-2.6.13-mm2.orig/arch/um/os-Linux/mem.c	2005-09-08 05:17:51.187952264 -0400
+++ linux-2.6.13-mm2/arch/um/os-Linux/mem.c	2005-09-08 14:55:47.000000000 -0400
@@ -0,0 +1,161 @@
+#include <stdio.h>
+#include <stdlib.h>
+#include <stddef.h>
+#include <stdarg.h>
+#include <unistd.h>
+#include <errno.h>
+#include <string.h>
+#include <fcntl.h>
+#include <sys/types.h>
+#include <sys/mman.h>
+#include "kern_util.h"
+#include "user.h"
+#include "user_util.h"
+#include "mem_user.h"
+#include "init.h"
+#include "os.h"
+#include "tempfile.h"
+#include "kern_constants.h"
+
+#include <sys/param.h>
+
+static char *tempdir = NULL;
+
+static void __init find_tempdir(void)
+{
+	char *dirs[] = { "TMP", "TEMP", "TMPDIR", NULL };
+	int i;
+	char *dir = NULL;
+
+	if(tempdir != NULL) return;	/* We've already been called */
+	for(i = 0; dirs[i]; i++){
+		dir = getenv(dirs[i]);
+		if((dir != NULL) && (*dir != '\0'))
+			break;
+	}
+	if((dir == NULL) || (*dir == '\0')) 
+		dir = "/tmp";
+
+	tempdir = malloc(strlen(dir) + 2);
+	if(tempdir == NULL){
+		fprintf(stderr, "Failed to malloc tempdir, "
+			"errno = %d\n", errno);
+		return;
+	}
+	strcpy(tempdir, dir);
+	strcat(tempdir, "/");
+}
+
+/*
+ * This proc still used in tt-mode
+ * (file: kernel/tt/ptproxy/proxy.c, proc: start_debugger).
+ * So it isn't 'static' yet.
+ */
+int make_tempfile(const char *template, char **out_tempname, int do_unlink)
+{
+	char tempname[MAXPATHLEN];
+	int fd;
+
+	find_tempdir();
+	if (*template != '/')
+		strcpy(tempname, tempdir);
+	else
+		*tempname = 0;
+	strcat(tempname, template);
+	fd = mkstemp(tempname);
+	if(fd < 0){
+		fprintf(stderr, "open - cannot create %s: %s\n", tempname, 
+			strerror(errno));
+		return -1;
+	}
+	if(do_unlink && (unlink(tempname) < 0)){
+		perror("unlink");
+		return -1;
+	}
+	if(out_tempname){
+		*out_tempname = strdup(tempname);
+		if(*out_tempname == NULL){
+			perror("strdup");
+			return -1;
+		}
+	}
+	return(fd);
+}
+
+#define TEMPNAME_TEMPLATE "vm_file-XXXXXX"
+
+/*
+ * This proc is used in start_up.c
+ * So it isn't 'static'.
+ */
+int create_tmp_file(unsigned long len)
+{
+	int fd, err;
+	char zero;
+
+	fd = make_tempfile(TEMPNAME_TEMPLATE, NULL, 1);
+	if(fd < 0) {
+		exit(1);
+	}
+
+	err = fchmod(fd, 0777);
+	if(err < 0){
+		perror("os_mode_fd");
+		exit(1);
+	}
+
+        if (lseek64(fd, len, SEEK_SET) < 0) {
+ 		perror("os_seek_file");
+		exit(1);
+	}
+
+	zero = 0;
+
+	err = os_write_file(fd, &zero, 1);
+	if(err != 1){
+		errno = -err;
+		perror("os_write_file");
+		exit(1);
+	}
+
+	return(fd);
+}
+
+static int create_anon_file(unsigned long len)
+{
+	void *addr;
+	int fd;
+
+	fd = open("/dev/anon", O_RDWR);
+	if(fd < 0) {
+		perror("opening /dev/anon");
+		exit(1);
+	}
+
+	addr = mmap(NULL, len, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
+	if(addr == MAP_FAILED){
+		perror("mapping physmem file");
+		exit(1);
+	}
+	munmap(addr, len);
+
+	return(fd);
+}
+
+extern int have_devanon;
+
+int create_mem_file(unsigned long len)
+{
+	int err, fd;
+
+	if(have_devanon)
+		fd = create_anon_file(len);
+	else fd = create_tmp_file(len);
+
+	err = os_set_exec_close(fd, 1);
+	if(err < 0){
+		errno = -err;
+		perror("exec_close");
+	}
+	return(fd);
+}
Index: linux-2.6.13-mm2/arch/um/os-Linux/start_up.c
===================================================================
--- linux-2.6.13-mm2.orig/arch/um/os-Linux/start_up.c	2005-09-08 14:55:12.000000000 -0400
+++ linux-2.6.13-mm2/arch/um/os-Linux/start_up.c	2005-09-08 14:55:47.000000000 -0400
@@ -4,18 +4,22 @@
  */
 
 #include <stdio.h>
+#include <stddef.h>
+#include <stdarg.h>
+#include <stdlib.h>
+#include <string.h>
 #include <unistd.h>
 #include <signal.h>
 #include <sched.h>
+#include <fcntl.h>
 #include <errno.h>
-#include <stdarg.h>
-#include <stdlib.h>
 #include <setjmp.h>
 #include <sys/time.h>
 #include <sys/wait.h>
 #include <sys/mman.h>
 #include <asm/unistd.h>
 #include <asm/page.h>
+#include <sys/types.h>
 #include "user_util.h"
 #include "kern_util.h"
 #include "user.h"
@@ -25,6 +29,7 @@
 #include "sysdep/sigcontext.h"
 #include "irq_user.h"
 #include "ptrace_user.h"
+#include "mem_user.h"
 #include "time_user.h"
 #include "init.h"
 #include "os.h"
@@ -32,6 +37,8 @@
 #include "choose-mode.h"
 #include "mode.h"
 #include "tempfile.h"
+#include "kern_constants.h"
+
 #ifdef UML_CONFIG_MODE_SKAS
 #include "skas.h"
 #include "skas_ptrace.h"
@@ -276,9 +283,38 @@
 	check_sysemu();
 }
 
+extern int create_tmp_file(unsigned long len);
+
+static void check_tmpexec(void)
+{
+	void *addr;
+	int err, fd = create_tmp_file(UM_KERN_PAGE_SIZE);
+
+	addr = mmap(NULL, UM_KERN_PAGE_SIZE,
+		    PROT_READ | PROT_WRITE | PROT_EXEC, MAP_PRIVATE, fd, 0);
+	printf("Checking PROT_EXEC mmap in /tmp...");
+	fflush(stdout);
+	if(addr == MAP_FAILED){
+		err = errno;
+		perror("failed");
+		if(err == EPERM)
+			printf("/tmp must be not mounted noexec\n");
+		exit(1);
+	}
+	printf("OK\n");
+	munmap(addr, UM_KERN_PAGE_SIZE);
+
+	close(fd);
+}
+
 void os_early_checks(void)
 {
 	check_ptrace();
+
+	/* Need to check this early because mmapping happens before the
+	 * kernel is running.
+	 */
+	check_tmpexec();
 }
 
 static int __init noprocmm_cmd_param(char *str, int* add)
@@ -357,3 +393,72 @@
 	return(0);
 }
 #endif
+
+int have_devanon = 0;
+
+void check_devanon(void)
+{
+	int fd;
+
+	printk("Checking for /dev/anon on the host...");
+	fd = open("/dev/anon", O_RDWR);
+	if(fd < 0){
+		printk("Not available (open failed with errno %d)\n", errno);
+		return;
+	}
+
+	printk("OK\n");
+	have_devanon = 1;
+}
+
+int __init parse_iomem(char *str, int *add)
+{
+	struct iomem_region *new;
+	struct uml_stat buf;
+	char *file, *driver;
+	int fd, err, size;
+
+	driver = str;
+	file = strchr(str,',');
+	if(file == NULL){
+		printf("parse_iomem : failed to parse iomem\n");
+		goto out;
+	}
+	*file = '\0';
+	file++;
+	fd = os_open_file(file, of_rdwr(OPENFLAGS()), 0);
+	if(fd < 0){
+		os_print_error(fd, "parse_iomem - Couldn't open io file");
+		goto out;
+	}
+
+	err = os_stat_fd(fd, &buf);
+	if(err < 0){
+		os_print_error(err, "parse_iomem - cannot stat_fd file");
+		goto out_close;
+	}
+
+	new = malloc(sizeof(*new));
+	if(new == NULL){
+		perror("Couldn't allocate iomem_region struct");
+		goto out_close;
+	}
+
+	size = (buf.ust_size + UM_KERN_PAGE_SIZE) & ~(UM_KERN_PAGE_SIZE - 1);
+
+	*new = ((struct iomem_region) { .next		= iomem_regions,
+					.driver		= driver,
+					.fd		= fd,
+					.size		= size,
+					.phys		= 0,
+					.virt		= 0 });
+	iomem_regions = new;
+	iomem_size += new->size + UM_KERN_PAGE_SIZE;
+
+	return(0);
+ out_close:
+	os_close_file(fd);
+ out:
+	return(1);
+}
+
Index: linux-2.6.13-mm2/arch/um/os-Linux/tt.c
===================================================================
--- linux-2.6.13-mm2.orig/arch/um/os-Linux/tt.c	2005-09-08 14:55:12.000000000 -0400
+++ linux-2.6.13-mm2/arch/um/os-Linux/tt.c	2005-09-08 14:55:47.000000000 -0400
@@ -36,6 +36,20 @@
 #include "mode.h"
 #include "tempfile.h"
 
+int protect_memory(unsigned long addr, unsigned long len, int r, int w, int x,
+		   int must_succeed)
+{
+	int err;
+
+	err = os_protect_memory((void *) addr, len, r, w, x);
+	if(err < 0){
+                if(must_succeed)
+			panic("protect failed, err = %d", -err);
+		else return(err);
+	}
+	return(0);
+}
+
 /*
  *-------------------------
  * only for tt mode (will be deleted in future...)

