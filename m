Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751789AbWADVAc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751789AbWADVAc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 16:00:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751286AbWADVAJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 16:00:09 -0500
Received: from saraswathi.solana.com ([198.99.130.12]:50334 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1750813AbWADU74 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 15:59:56 -0500
Message-Id: <200601042151.k04Lpl6d009220@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 1/9] UML - Separate libc-dependent umid code
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 04 Jan 2006 16:51:46 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I reworked Gennady's umid OS abstraction patch because the code shouldn't
be moved entirely to os.  As it turns out, I moved most of it anyway.  This
patch is the minimal one needed to move the code and have it work.
It turns out that the concept of the umid is OS-independent, but
almost everything else about the implementation is OS-dependent.

This is code movement without cleanup - a follow-on patch tidies
everything up without shuffling code around.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.15/arch/um/include/kern.h
===================================================================
--- linux-2.6.15.orig/arch/um/include/kern.h	2005-12-19 23:29:40.000000000 -0500
+++ linux-2.6.15/arch/um/include/kern.h	2005-12-19 23:36:18.000000000 -0500
@@ -17,7 +17,7 @@ extern int errno;
 
 extern int clone(int (*proc)(void *), void *sp, int flags, void *data);
 extern int sleep(int);
-extern int printf(char *fmt, ...);
+extern int printf(const char *fmt, ...);
 extern char *strerror(int errnum);
 extern char *ptsname(int __fd);
 extern int munmap(void *, int);
@@ -35,15 +35,6 @@ extern int read(unsigned int, char *, in
 extern int pipe(int *);
 extern int sched_yield(void);
 extern int ptrace(int op, int pid, long addr, long data);
+
 #endif
 
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
Index: linux-2.6.15/arch/um/include/os.h
===================================================================
--- linux-2.6.15.orig/arch/um/include/os.h	2005-12-19 23:29:40.000000000 -0500
+++ linux-2.6.15/arch/um/include/os.h	2005-12-19 23:36:24.000000000 -0500
@@ -213,15 +213,10 @@ extern int run_helper_thread(int (*proc)
 			     int stack_order);
 extern int helper_wait(int pid);
 
-#endif
+/* umid.c */
+
+extern int umid_file_name(char *name, char *buf, int len);
+extern int set_umid(char *name, int (*printer)(const char *fmt, ...));
+extern char *get_umid(int only_if_set);
 
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
+#endif
Index: linux-2.6.15/arch/um/kernel/Makefile
===================================================================
--- linux-2.6.15.orig/arch/um/kernel/Makefile	2005-12-19 23:29:40.000000000 -0500
+++ linux-2.6.15/arch/um/kernel/Makefile	2005-12-19 23:36:18.000000000 -0500
@@ -10,8 +10,8 @@ obj-y = config.o exec_kern.o exitcode.o 
 	init_task.o irq.o irq_user.o ksyms.o mem.o physmem.o \
 	process_kern.o ptrace.o reboot.o resource.o sigio_user.o sigio_kern.o \
 	signal_kern.o signal_user.o smp.o syscall_kern.o sysrq.o time.o \
-	time_kern.o tlb.o trap_kern.o trap_user.o uaccess.o um_arch.o \
-	umid.o user_util.o
+	time_kern.o tlb.o trap_kern.o trap_user.o uaccess.o um_arch.o umid.o \
+	user_util.o
 
 obj-$(CONFIG_BLK_DEV_INITRD) += initrd.o
 obj-$(CONFIG_GPROF)	+= gprof_syms.o
@@ -24,7 +24,7 @@ obj-$(CONFIG_MODE_SKAS) += skas/
 
 user-objs-$(CONFIG_TTY_LOG) += tty_log.o
 
-USER_OBJS := $(user-objs-y) config.o time.o tty_log.o umid.o user_util.o
+USER_OBJS := $(user-objs-y) config.o time.o tty_log.o user_util.o
 
 include arch/um/scripts/Makefile.rules
 
Index: linux-2.6.15/arch/um/kernel/process_kern.c
===================================================================
--- linux-2.6.15.orig/arch/um/kernel/process_kern.c	2005-12-19 23:29:40.000000000 -0500
+++ linux-2.6.15/arch/um/kernel/process_kern.c	2005-12-19 23:36:18.000000000 -0500
@@ -324,10 +324,6 @@ int user_context(unsigned long sp)
 	return(stack != (unsigned long) current_thread);
 }
 
-extern void remove_umid_dir(void);
-
-__uml_exitcall(remove_umid_dir);
-
 extern exitcall_t __uml_exitcall_begin, __uml_exitcall_end;
 
 void do_uml_exitcalls(void)
Index: linux-2.6.15/arch/um/kernel/umid.c
===================================================================
--- linux-2.6.15.orig/arch/um/kernel/umid.c	2005-12-19 23:29:40.000000000 -0500
+++ linux-2.6.15/arch/um/kernel/umid.c	2005-12-19 23:36:24.000000000 -0500
@@ -3,61 +3,34 @@
  * Licensed under the GPL
  */
 
-#include <stdio.h>
-#include <unistd.h>
-#include <errno.h>
-#include <string.h>
-#include <stdlib.h>
-#include <dirent.h>
-#include <signal.h>
-#include <sys/stat.h>
-#include <sys/param.h>
-#include "user.h"
-#include "umid.h"
+#include "linux/stddef.h"
+#include "linux/kernel.h"
+#include "asm/errno.h"
 #include "init.h"
 #include "os.h"
-#include "user_util.h"
-#include "choose-mode.h"
+#include "kern.h"
 
-#define UMID_LEN 64
-#define UML_DIR "~/.uml/"
-
-/* Changed by set_umid and make_umid, which are run early in boot */
-static char umid[UMID_LEN] = { 0 };
-
-/* Changed by set_uml_dir and make_uml_dir, which are run early in boot */
-static char *uml_dir = UML_DIR;
-
-/* Changed by set_umid */
-static int umid_is_random = 1;
+/* Changed by set_umid_arg and umid_file_name */
+int umid_is_random = 0;
 static int umid_inited = 0;
-/* Have we created the files? Should we remove them? */
-static int umid_owned = 0;
 
-static int make_umid(int (*printer)(const char *fmt, ...));
-
-static int __init set_umid(char *name, int is_random,
-			   int (*printer)(const char *fmt, ...))
+static int __init set_umid_arg(char *name, int *add)
 {
-	if(umid_inited){
-		(*printer)("Unique machine name can't be set twice\n");
-		return(-1);
-	}
+	int err;
 
-	if(strlen(name) > UMID_LEN - 1)
-		(*printer)("Unique machine name is being truncated to %d "
-			   "characters\n", UMID_LEN);
-	strlcpy(umid, name, sizeof(umid));
+	if(umid_inited)
+		return 0;
 
-	umid_is_random = is_random;
-	umid_inited = 1;
-	return 0;
-}
-
-static int __init set_umid_arg(char *name, int *add)
-{
 	*add = 0;
-	return(set_umid(name, 0, printf));
+	err = set_umid(name, printf);
+	if(err == -EEXIST){
+		printf("umid '%s' already in use\n", name);
+		umid_is_random = 1;
+	}
+	else if(!err)
+		umid_inited = 1;
+
+	return 0;
 }
 
 __uml_setup("umid=", set_umid_arg,
@@ -66,265 +39,3 @@ __uml_setup("umid=", set_umid_arg,
 "    is used for naming the pid file and management console socket.\n\n"
 );
 
-int __init umid_file_name(char *name, char *buf, int len)
-{
-	int n;
-
-	if(!umid_inited && make_umid(printk)) return(-1);
-
-	n = strlen(uml_dir) + strlen(umid) + strlen(name) + 1;
-	if(n > len){
-		printk("umid_file_name : buffer too short\n");
-		return(-1);
-	}
-
-	sprintf(buf, "%s%s/%s", uml_dir, umid, name);
-	return(0);
-}
-
-extern int tracing_pid;
-
-static void __init create_pid_file(void)
-{
-	char file[strlen(uml_dir) + UMID_LEN + sizeof("/pid\0")];
-	char pid[sizeof("nnnnn\0")];
-	int fd, n;
-
-	if(umid_file_name("pid", file, sizeof(file)))
-		return;
-
-	fd = os_open_file(file, of_create(of_excl(of_rdwr(OPENFLAGS()))), 
-			  0644);
-	if(fd < 0){
-		printf("Open of machine pid file \"%s\" failed: %s\n",
-		       file, strerror(-fd));
-		return;
-	}
-
-	sprintf(pid, "%d\n", os_getpid());
-	n = os_write_file(fd, pid, strlen(pid));
-	if(n != strlen(pid))
-		printf("Write of pid file failed - err = %d\n", -n);
-	os_close_file(fd);
-}
-
-static int actually_do_remove(char *dir)
-{
-	DIR *directory;
-	struct dirent *ent;
-	int len;
-	char file[256];
-
-	directory = opendir(dir);
-	if(directory == NULL){
-		printk("actually_do_remove : couldn't open directory '%s', "
-		       "errno = %d\n", dir, errno);
-		return(1);
-	}
-	while((ent = readdir(directory)) != NULL){
-		if(!strcmp(ent->d_name, ".") || !strcmp(ent->d_name, ".."))
-			continue;
-		len = strlen(dir) + sizeof("/") + strlen(ent->d_name) + 1;
-		if(len > sizeof(file)){
-			printk("Not deleting '%s' from '%s' - name too long\n",
-			       ent->d_name, dir);
-			continue;
-		}
-		sprintf(file, "%s/%s", dir, ent->d_name);
-		if(unlink(file) < 0){
-			printk("actually_do_remove : couldn't remove '%s' "
-			       "from '%s', errno = %d\n", ent->d_name, dir, 
-			       errno);
-			return(1);
-		}
-	}
-	if(rmdir(dir) < 0){
-		printk("actually_do_remove : couldn't rmdir '%s', "
-		       "errno = %d\n", dir, errno);
-		return(1);
-	}
-	return(0);
-}
-
-void remove_umid_dir(void)
-{
-	char dir[strlen(uml_dir) + UMID_LEN + 1];
-	if (!umid_owned)
-		return;
-
-	sprintf(dir, "%s%s", uml_dir, umid);
-	actually_do_remove(dir);
-}
-
-char *get_umid(int only_if_set)
-{
-	if(only_if_set && umid_is_random)
-		return NULL;
-	return umid;
-}
-
-static int not_dead_yet(char *dir)
-{
-	char file[strlen(uml_dir) + UMID_LEN + sizeof("/pid\0")];
-	char pid[sizeof("nnnnn\0")], *end;
-	int dead, fd, p, n;
-
-	sprintf(file, "%s/pid", dir);
-	dead = 0;
-	fd = os_open_file(file, of_read(OPENFLAGS()), 0);
-	if(fd < 0){
-		if(fd != -ENOENT){
-			printk("not_dead_yet : couldn't open pid file '%s', "
-			       "err = %d\n", file, -fd);
-			return(1);
-		}
-		dead = 1;
-	}
-	if(fd > 0){
-		n = os_read_file(fd, pid, sizeof(pid));
-		if(n < 0){
-			printk("not_dead_yet : couldn't read pid file '%s', "
-			       "err = %d\n", file, -n);
-			return(1);
-		}
-		p = strtoul(pid, &end, 0);
-		if(end == pid){
-			printk("not_dead_yet : couldn't parse pid file '%s', "
-			       "errno = %d\n", file, errno);
-			dead = 1;
-		}
-		if(((kill(p, 0) < 0) && (errno == ESRCH)) ||
-		   (p == CHOOSE_MODE(tracing_pid, os_getpid())))
-			dead = 1;
-	}
-	if(!dead)
-		return(1);
-	return(actually_do_remove(dir));
-}
-
-static int __init set_uml_dir(char *name, int *add)
-{
-	if((strlen(name) > 0) && (name[strlen(name) - 1] != '/')){
-		uml_dir = malloc(strlen(name) + 2);
-		if(uml_dir == NULL){
-			printf("Failed to malloc uml_dir - error = %d\n",
-			       errno);
-			uml_dir = name;
-			/* Return 0 here because do_initcalls doesn't look at
-			 * the return value.
-			 */
-			return(0);
-		}
-		sprintf(uml_dir, "%s/", name);
-	}
-	else uml_dir = name;
-	return(0);
-}
-
-static int __init make_uml_dir(void)
-{
-	char dir[MAXPATHLEN + 1] = { '\0' };
-	int len;
-
-	if(*uml_dir == '~'){
-		char *home = getenv("HOME");
-
-		if(home == NULL){
-			printf("make_uml_dir : no value in environment for "
-			       "$HOME\n");
-			exit(1);
-		}
-		strlcpy(dir, home, sizeof(dir));
-		uml_dir++;
-	}
-	strlcat(dir, uml_dir, sizeof(dir));
-	len = strlen(dir);
-	if (len > 0 && dir[len - 1] != '/')
-		strlcat(dir, "/", sizeof(dir));
-
-	uml_dir = malloc(strlen(dir) + 1);
-	if (uml_dir == NULL) {
-		printf("make_uml_dir : malloc failed, errno = %d\n", errno);
-		exit(1);
-	}
-	strcpy(uml_dir, dir);
-	
-	if((mkdir(uml_dir, 0777) < 0) && (errno != EEXIST)){
-	        printf("Failed to mkdir %s: %s\n", uml_dir, strerror(errno));
-		return(-1);
-	}
-	return 0;
-}
-
-static int __init make_umid(int (*printer)(const char *fmt, ...))
-{
-	int fd, err;
-	char tmp[strlen(uml_dir) + UMID_LEN + 1];
-
-	strlcpy(tmp, uml_dir, sizeof(tmp));
-
-	if(!umid_inited){
-		strcat(tmp, "XXXXXX");
-		fd = mkstemp(tmp);
-		if(fd < 0){
-			(*printer)("make_umid - mkstemp(%s) failed: %s\n",
-				   tmp,strerror(errno));
-			return(1);
-		}
-
-		os_close_file(fd);
-		/* There's a nice tiny little race between this unlink and
-		 * the mkdir below.  It'd be nice if there were a mkstemp
-		 * for directories.
-		 */
-		unlink(tmp);
-		set_umid(&tmp[strlen(uml_dir)], 1, printer);
-	}
-	
-	sprintf(tmp, "%s%s", uml_dir, umid);
-
-	err = mkdir(tmp, 0777);
-	if(err < 0){
-		if(errno == EEXIST){
-			if(not_dead_yet(tmp)){
-				(*printer)("umid '%s' is in use\n", umid);
-				umid_owned = 0;
-				return(-1);
-			}
-			err = mkdir(tmp, 0777);
-		}
-	}
-	if(err < 0){
-		(*printer)("Failed to create %s - errno = %d\n", umid, errno);
-		return(-1);
-	}
-
-	umid_owned = 1;
-	return 0;
-}
-
-__uml_setup("uml_dir=", set_uml_dir,
-"uml_dir=<directory>\n"
-"    The location to place the pid and umid files.\n\n"
-);
-
-static int __init make_umid_setup(void)
-{
-	/* one function with the ordering we need ... */
-	make_uml_dir();
-	make_umid(printf);
-	create_pid_file();
-	return 0;
-}
-__uml_postsetup(make_umid_setup);
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
Index: linux-2.6.15/arch/um/os-Linux/Makefile
===================================================================
--- linux-2.6.15.orig/arch/um/os-Linux/Makefile	2005-12-19 23:29:40.000000000 -0500
+++ linux-2.6.15/arch/um/os-Linux/Makefile	2005-12-19 23:36:18.000000000 -0500
@@ -4,11 +4,11 @@
 #
 
 obj-y = aio.o elf_aux.o file.o helper.o main.o mem.o process.o signal.o \
-	start_up.o time.o tt.o tty.o uaccess.o user_syms.o drivers/ \
+	start_up.o time.o tt.o tty.o uaccess.o umid.o user_syms.o drivers/ \
 	sys-$(SUBARCH)/
 
 USER_OBJS := aio.o elf_aux.o file.o helper.o main.o mem.o process.o signal.o \
-	start_up.o time.o tt.o tty.o uaccess.o
+	start_up.o time.o tt.o tty.o uaccess.o umid.o
 
 elf_aux.o: $(ARCH_DIR)/kernel-offsets.h
 CFLAGS_elf_aux.o += -I$(objtree)/arch/um
Index: linux-2.6.15/arch/um/os-Linux/umid.c
===================================================================
--- linux-2.6.15.orig/arch/um/os-Linux/umid.c	2005-12-19 05:57:40.904482500 -0500
+++ linux-2.6.15/arch/um/os-Linux/umid.c	2005-12-19 23:36:24.000000000 -0500
@@ -0,0 +1,292 @@
+#include <stdio.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <string.h>
+#include <errno.h>
+#include <signal.h>
+#include <dirent.h>
+#include <sys/stat.h>
+#include <sys/param.h>
+#include "init.h"
+#include "os.h"
+#include "user.h"
+#include "mode.h"
+
+#define UML_DIR "~/.uml/"
+
+#define UMID_LEN 64
+
+/* Changed by set_umid, which is run early in boot */
+char umid[UMID_LEN] = { 0 };
+
+/* Changed by set_uml_dir and make_uml_dir, which are run early in boot */
+static char *uml_dir = UML_DIR;
+
+static int __init make_uml_dir(void)
+{
+	char dir[512] = { '\0' };
+	int len;
+
+	if(*uml_dir == '~'){
+		char *home = getenv("HOME");
+
+		if(home == NULL){
+			printf("make_uml_dir : no value in environment for "
+			       "$HOME\n");
+			exit(1);
+		}
+		strlcpy(dir, home, sizeof(dir));
+		uml_dir++;
+	}
+	strlcat(dir, uml_dir, sizeof(dir));
+	len = strlen(dir);
+	if (len > 0 && dir[len - 1] != '/')
+		strlcat(dir, "/", sizeof(dir));
+
+	uml_dir = malloc(strlen(dir) + 1);
+	if (uml_dir == NULL) {
+		printf("make_uml_dir : malloc failed, errno = %d\n", errno);
+		exit(1);
+	}
+	strcpy(uml_dir, dir);
+	
+	if((mkdir(uml_dir, 0777) < 0) && (errno != EEXIST)){
+	        printf("Failed to mkdir '%s': %s\n", uml_dir, strerror(errno));
+		return(-1);
+	}
+	return 0;
+}
+
+static int actually_do_remove(char *dir)
+{
+	DIR *directory;
+	struct dirent *ent;
+	int len;
+	char file[256];
+
+	directory = opendir(dir);
+	if(directory == NULL){
+		printk("actually_do_remove : couldn't open directory '%s', "
+		       "errno = %d\n", dir, errno);
+		return(1);
+	}
+	while((ent = readdir(directory)) != NULL){
+		if(!strcmp(ent->d_name, ".") || !strcmp(ent->d_name, ".."))
+			continue;
+		len = strlen(dir) + sizeof("/") + strlen(ent->d_name) + 1;
+		if(len > sizeof(file)){
+			printk("Not deleting '%s' from '%s' - name too long\n",
+			       ent->d_name, dir);
+			continue;
+		}
+		sprintf(file, "%s/%s", dir, ent->d_name);
+		if(unlink(file) < 0){
+			printk("actually_do_remove : couldn't remove '%s' "
+			       "from '%s', errno = %d\n", ent->d_name, dir, 
+			       errno);
+			return(1);
+		}
+	}
+	if(rmdir(dir) < 0){
+		printk("actually_do_remove : couldn't rmdir '%s', "
+		       "errno = %d\n", dir, errno);
+		return(1);
+	}
+	return(0);
+}
+
+extern int tracing_pid;
+
+static int not_dead_yet(char *dir)
+{
+	char file[strlen(uml_dir) + UMID_LEN + sizeof("/pid\0")];
+	char pid[sizeof("nnnnn\0")], *end;
+	int dead, fd, p, n;
+
+	sprintf(file, "%s/pid", dir);
+	dead = 0;
+	fd = os_open_file(file, of_read(OPENFLAGS()), 0);
+	if(fd < 0){
+		if(fd != -ENOENT){
+			printk("not_dead_yet : couldn't open pid file '%s', "
+			       "err = %d\n", file, -fd);
+			return(1);
+		}
+		dead = 1;
+	}
+	if(fd > 0){
+		n = os_read_file(fd, pid, sizeof(pid));
+		if(n < 0){
+			printk("not_dead_yet : couldn't read pid file '%s', "
+			       "err = %d\n", file, -n);
+			return(1);
+		}
+		p = strtoul(pid, &end, 0);
+		if(end == pid){
+			printk("not_dead_yet : couldn't parse pid file '%s', "
+			       "errno = %d\n", file, errno);
+			dead = 1;
+		}
+		if(((kill(p, 0) < 0) && (errno == ESRCH)) ||
+		   (p == CHOOSE_MODE(tracing_pid, os_getpid())))
+			dead = 1;
+	}
+	if(!dead)
+		return(1);
+	return(actually_do_remove(dir));
+}
+
+static void __init create_pid_file(void)
+{
+	char file[strlen(uml_dir) + UMID_LEN + sizeof("/pid\0")];
+	char pid[sizeof("nnnnn\0")];
+	int fd, n;
+
+	if(umid_file_name("pid", file, sizeof(file)))
+		return;
+
+	fd = os_open_file(file, of_create(of_excl(of_rdwr(OPENFLAGS()))), 
+			  0644);
+	if(fd < 0){
+		printf("Open of machine pid file \"%s\" failed: %s\n",
+		       file, strerror(-fd));
+		return;
+	}
+
+	sprintf(pid, "%d\n", os_getpid());
+	n = os_write_file(fd, pid, strlen(pid));
+	if(n != strlen(pid))
+		printf("Write of pid file failed - err = %d\n", -n);
+	os_close_file(fd);
+}
+
+int __init set_umid(char *name, int (*printer)(const char *fmt, ...))
+{
+	if(strlen(name) > UMID_LEN - 1)
+		(*printer)("Unique machine name is being truncated to %d "
+			   "characters\n", UMID_LEN);
+	strlcpy(umid, name, sizeof(umid));
+
+	return 0;
+}
+
+static int umid_setup = 0;
+
+int __init make_umid(int (*printer)(const char *fmt, ...))
+{
+	int fd, err;
+	char tmp[256];
+
+	make_uml_dir();
+
+	if(*umid == '\0'){
+		strlcpy(tmp, uml_dir, sizeof(tmp));
+		strcat(tmp, "XXXXXX");
+		fd = mkstemp(tmp);
+		if(fd < 0){
+			(*printer)("make_umid - mkstemp(%s) failed: %s\n",
+				   tmp,strerror(errno));
+			return(1);
+		}
+
+		os_close_file(fd);
+		/* There's a nice tiny little race between this unlink and
+		 * the mkdir below.  It'd be nice if there were a mkstemp
+		 * for directories.
+		 */
+		unlink(tmp);
+		set_umid(&tmp[strlen(uml_dir)], printer);
+	}
+	
+	sprintf(tmp, "%s%s", uml_dir, umid);
+	err = mkdir(tmp, 0777);
+	if(err < 0){
+		if(errno == EEXIST){
+			if(not_dead_yet(tmp))
+				return -EEXIST;
+			err = mkdir(tmp, 0777);
+		}
+	}
+	if(err < 0){
+		(*printer)("Failed to create %s - errno = %d\n", umid, errno);
+		return(-1);
+	}
+
+	umid_setup = 1;
+
+	create_pid_file();
+
+	return 0;
+}
+
+static int __init make_umid_init(void)
+{
+	make_umid(printk);
+
+	return(0);
+}
+
+__initcall(make_umid_init);
+
+int __init umid_file_name(char *name, char *buf, int len)
+{
+	int n, err;
+
+	if(!umid_setup){
+		err = make_umid(printk);
+		if(err)
+			return err;
+	}
+
+	n = strlen(uml_dir) + strlen(umid) + strlen("/") + strlen(name) + 1;
+	if(n > len){
+		printk("umid_file_name : buffer too short\n");
+		return(-1);
+	}
+
+	sprintf(buf, "%s%s/%s", uml_dir, umid, name);
+	return(0);
+}
+
+extern int umid_is_random;
+
+char *get_umid(int only_if_set)
+{
+	if(only_if_set && umid_is_random)
+		return NULL;
+	return umid;
+}
+
+static int __init set_uml_dir(char *name, int *add)
+{
+	if((strlen(name) > 0) && (name[strlen(name) - 1] != '/')){
+		uml_dir = malloc(strlen(name) + 2);
+		if(uml_dir == NULL){
+			printf("Failed to malloc uml_dir - error = %d\n",
+			       errno);
+			uml_dir = name;
+			/* Return 0 here because do_initcalls doesn't look at
+			 * the return value.
+			 */
+			return(0);
+		}
+		sprintf(uml_dir, "%s/", name);
+	}
+	else uml_dir = name;
+	return(0);
+}
+
+__uml_setup("uml_dir=", set_uml_dir,
+"uml_dir=<directory>\n"
+"    The location to place the pid and umid files.\n\n"
+);
+
+static void remove_umid_dir(void)
+{
+	char dir[strlen(uml_dir) + UMID_LEN + 1];
+
+	sprintf(dir, "%s%s", uml_dir, umid);
+	actually_do_remove(dir);
+}
+
+__uml_exitcall(remove_umid_dir);

