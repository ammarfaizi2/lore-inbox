Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750772AbWADVBO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750772AbWADVBO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 16:01:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751292AbWADVAE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 16:00:04 -0500
Received: from saraswathi.solana.com ([198.99.130.12]:50078 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1750772AbWADU74 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 15:59:56 -0500
Message-Id: <200601042151.k04LpsKV009226@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 2/9] UML - umid cleanup
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 04 Jan 2006 16:51:54 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch cleans up the umid code:
	The only_if_set argument to get_umid is gone.
	get_umid returns an empty string rather than NULL if there is
no umid.
	umid_is_random is gone since its users went away.
	Some printfs were turned into printks because the code runs
late enough that printk is working.
	Error paths were cleaned up.
	Some functions now return an error and let the caller print
the error message rather than printing it themselves.  This
eliminates the practice of passing a pointer to printf or printk in,
depending on where in the boot process we are.
	Major tidying of not_dead_yet - mostly error path cleanup,
plus a comment explaining why it doesn't react to errors the way you
might expect.
	Calls to os_* interfaces that were moved under os are changed
back to their native libc forms.
	snprintf, strlcpy, and their bounds-checking friends are used
more often, replacing by-hand bounds checking in some places.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.15/arch/um/drivers/line.c
===================================================================
--- linux-2.6.15.orig/arch/um/drivers/line.c	2006-01-04 13:57:19.000000000 -0500
+++ linux-2.6.15/arch/um/drivers/line.c	2006-01-04 13:57:45.000000000 -0500
@@ -831,8 +831,8 @@ char *add_xterm_umid(char *base)
 	char *umid, *title;
 	int len;
 
-	umid = get_umid(1);
-	if(umid == NULL)
+	umid = get_umid();
+	if(*umid == '\0')
 		return base;
 
 	len = strlen(base) + strlen(" ()") + strlen(umid) + 1;
Index: linux-2.6.15/arch/um/include/os.h
===================================================================
--- linux-2.6.15.orig/arch/um/include/os.h	2006-01-04 13:57:34.000000000 -0500
+++ linux-2.6.15/arch/um/include/os.h	2006-01-04 13:57:45.000000000 -0500
@@ -216,7 +216,7 @@ extern int helper_wait(int pid);
 /* umid.c */
 
 extern int umid_file_name(char *name, char *buf, int len);
-extern int set_umid(char *name, int (*printer)(const char *fmt, ...));
-extern char *get_umid(int only_if_set);
+extern int set_umid(char *name);
+extern char *get_umid(void);
 
 #endif
Index: linux-2.6.15/arch/um/include/user_util.h
===================================================================
--- linux-2.6.15.orig/arch/um/include/user_util.h	2005-10-28 12:58:12.000000000 -0400
+++ linux-2.6.15/arch/um/include/user_util.h	2006-01-04 13:57:45.000000000 -0500
@@ -64,7 +64,6 @@ extern void setup_machinename(char *mach
 extern void setup_hostinfo(void);
 extern void do_exec(int old_pid, int new_pid);
 extern void tracer_panic(char *msg, ...);
-extern char *get_umid(int only_if_set);
 extern void do_longjmp(void *p, int val);
 extern int detach(int pid, int sig);
 extern int attach(int pid);
Index: linux-2.6.15/arch/um/kernel/um_arch.c
===================================================================
--- linux-2.6.15.orig/arch/um/kernel/um_arch.c	2006-01-03 17:39:46.000000000 -0500
+++ linux-2.6.15/arch/um/kernel/um_arch.c	2006-01-04 13:57:45.000000000 -0500
@@ -146,8 +146,8 @@ void set_cmdline(char *cmd)
 
 	if(CHOOSE_MODE(honeypot, 0)) return;
 
-	umid = get_umid(1);
-	if(umid != NULL){
+	umid = get_umid();
+	if(*umid != '\0'){
 		snprintf(argv1_begin, 
 			 (argv1_end - argv1_begin) * sizeof(*ptr), 
 			 "(%s) ", umid);
Index: linux-2.6.15/arch/um/kernel/umid.c
===================================================================
--- linux-2.6.15.orig/arch/um/kernel/umid.c	2006-01-04 13:57:34.000000000 -0500
+++ linux-2.6.15/arch/um/kernel/umid.c	2006-01-04 13:57:45.000000000 -0500
@@ -3,15 +3,13 @@
  * Licensed under the GPL
  */
 
-#include "linux/stddef.h"
-#include "linux/kernel.h"
 #include "asm/errno.h"
 #include "init.h"
 #include "os.h"
 #include "kern.h"
+#include "linux/kernel.h"
 
-/* Changed by set_umid_arg and umid_file_name */
-int umid_is_random = 0;
+/* Changed by set_umid_arg */
 static int umid_inited = 0;
 
 static int __init set_umid_arg(char *name, int *add)
@@ -22,11 +20,9 @@ static int __init set_umid_arg(char *nam
 		return 0;
 
 	*add = 0;
-	err = set_umid(name, printf);
-	if(err == -EEXIST){
+	err = set_umid(name);
+	if(err == -EEXIST)
 		printf("umid '%s' already in use\n", name);
-		umid_is_random = 1;
-	}
 	else if(!err)
 		umid_inited = 1;
 
Index: linux-2.6.15/arch/um/os-Linux/umid.c
===================================================================
--- linux-2.6.15.orig/arch/um/os-Linux/umid.c	2006-01-04 13:57:34.000000000 -0500
+++ linux-2.6.15/arch/um/os-Linux/umid.c	2006-01-04 13:57:45.000000000 -0500
@@ -5,6 +5,7 @@
 #include <errno.h>
 #include <signal.h>
 #include <dirent.h>
+#include <sys/fcntl.h>
 #include <sys/stat.h>
 #include <sys/param.h>
 #include "init.h"
@@ -25,15 +26,16 @@ static char *uml_dir = UML_DIR;
 static int __init make_uml_dir(void)
 {
 	char dir[512] = { '\0' };
-	int len;
+	int len, err;
 
 	if(*uml_dir == '~'){
 		char *home = getenv("HOME");
 
+		err = -ENOENT;
 		if(home == NULL){
-			printf("make_uml_dir : no value in environment for "
+			printk("make_uml_dir : no value in environment for "
 			       "$HOME\n");
-			exit(1);
+			goto err;
 		}
 		strlcpy(dir, home, sizeof(dir));
 		uml_dir++;
@@ -43,18 +45,26 @@ static int __init make_uml_dir(void)
 	if (len > 0 && dir[len - 1] != '/')
 		strlcat(dir, "/", sizeof(dir));
 
+	err = -ENOMEM;
 	uml_dir = malloc(strlen(dir) + 1);
 	if (uml_dir == NULL) {
 		printf("make_uml_dir : malloc failed, errno = %d\n", errno);
-		exit(1);
+		goto err;
 	}
 	strcpy(uml_dir, dir);
-	
+
 	if((mkdir(uml_dir, 0777) < 0) && (errno != EEXIST)){
 	        printf("Failed to mkdir '%s': %s\n", uml_dir, strerror(errno));
-		return(-1);
+		err = -errno;
+		goto err_free;
 	}
 	return 0;
+
+err_free:
+	free(uml_dir);
+err:
+	uml_dir = NULL;
+	return err;
 }
 
 static int actually_do_remove(char *dir)
@@ -65,75 +75,88 @@ static int actually_do_remove(char *dir)
 	char file[256];
 
 	directory = opendir(dir);
-	if(directory == NULL){
-		printk("actually_do_remove : couldn't open directory '%s', "
-		       "errno = %d\n", dir, errno);
-		return(1);
-	}
+	if(directory == NULL)
+		return -errno;
+
 	while((ent = readdir(directory)) != NULL){
 		if(!strcmp(ent->d_name, ".") || !strcmp(ent->d_name, ".."))
 			continue;
 		len = strlen(dir) + sizeof("/") + strlen(ent->d_name) + 1;
-		if(len > sizeof(file)){
-			printk("Not deleting '%s' from '%s' - name too long\n",
-			       ent->d_name, dir);
-			continue;
-		}
+		if(len > sizeof(file))
+			return -E2BIG;
+
 		sprintf(file, "%s/%s", dir, ent->d_name);
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
+		if(unlink(file) < 0)
+			return -errno;
 	}
-	return(0);
+	if(rmdir(dir) < 0)
+		return -errno;
+
+	return 0;
 }
 
-extern int tracing_pid;
+/* This says that there isn't already a user of the specified directory even if
+ * there are errors during the checking.  This is because if these errors
+ * happen, the directory is unusable by the pre-existing UML, so we might as
+ * well take it over.  This could happen either by
+ * 	the existing UML somehow corrupting its umid directory
+ * 	something other than UML sticking stuff in the directory
+ *	this boot racing with a shutdown of the other UML
+ * In any of these cases, the directory isn't useful for anything else.
+ */
 
 static int not_dead_yet(char *dir)
 {
 	char file[strlen(uml_dir) + UMID_LEN + sizeof("/pid\0")];
 	char pid[sizeof("nnnnn\0")], *end;
-	int dead, fd, p, n;
+	int dead, fd, p, n, err;
+
+	n = snprintf(file, sizeof(file), "%s/pid", dir);
+	if(n >= sizeof(file)){
+		printk("not_dead_yet - pid filename too long\n");
+		err = -E2BIG;
+		goto out;
+	}
 
-	sprintf(file, "%s/pid", dir);
 	dead = 0;
-	fd = os_open_file(file, of_read(OPENFLAGS()), 0);
+	fd = open(file, O_RDONLY);
 	if(fd < 0){
 		if(fd != -ENOENT){
 			printk("not_dead_yet : couldn't open pid file '%s', "
 			       "err = %d\n", file, -fd);
-			return(1);
 		}
-		dead = 1;
+		goto out;
 	}
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
+
+	err = 0;
+	n = read(fd, pid, sizeof(pid));
+	if(n <= 0){
+		printk("not_dead_yet : couldn't read pid file '%s', "
+		       "err = %d\n", file, -n);
+		goto out_close;
+	}
+
+	p = strtoul(pid, &end, 0);
+	if(end == pid){
+		printk("not_dead_yet : couldn't parse pid file '%s', "
+		       "errno = %d\n", file, errno);
+		goto out_close;
+	}
+
+	if((kill(p, 0) == 0) || (errno != ESRCH))
+		return 1;
+
+	err = actually_do_remove(dir);
+	if(err)
+		printk("not_dead_yet - actually_do_remove failed with "
+		       "err = %d\n", err);
+
+	return err;
+
+ out_close:
+	close(fd);
+ out:
+	return 0;
 }
 
 static void __init create_pid_file(void)
@@ -145,26 +168,26 @@ static void __init create_pid_file(void)
 	if(umid_file_name("pid", file, sizeof(file)))
 		return;
 
-	fd = os_open_file(file, of_create(of_excl(of_rdwr(OPENFLAGS()))), 
-			  0644);
+	fd = open(file, O_RDWR | O_CREAT | O_EXCL, 0644);
 	if(fd < 0){
-		printf("Open of machine pid file \"%s\" failed: %s\n",
+		printk("Open of machine pid file \"%s\" failed: %s\n",
 		       file, strerror(-fd));
 		return;
 	}
 
-	sprintf(pid, "%d\n", os_getpid());
-	n = os_write_file(fd, pid, strlen(pid));
+	snprintf(pid, sizeof(pid), "%d\n", getpid());
+	n = write(fd, pid, strlen(pid));
 	if(n != strlen(pid))
-		printf("Write of pid file failed - err = %d\n", -n);
-	os_close_file(fd);
+		printk("Write of pid file failed - err = %d\n", -n);
+
+	close(fd);
 }
 
-int __init set_umid(char *name, int (*printer)(const char *fmt, ...))
+int __init set_umid(char *name)
 {
 	if(strlen(name) > UMID_LEN - 1)
-		(*printer)("Unique machine name is being truncated to %d "
-			   "characters\n", UMID_LEN);
+		return -E2BIG;
+
 	strlcpy(umid, name, sizeof(umid));
 
 	return 0;
@@ -172,44 +195,56 @@ int __init set_umid(char *name, int (*pr
 
 static int umid_setup = 0;
 
-int __init make_umid(int (*printer)(const char *fmt, ...))
+int __init make_umid(void)
 {
 	int fd, err;
 	char tmp[256];
 
+	if(umid_setup)
+		return 0;
+
 	make_uml_dir();
 
 	if(*umid == '\0'){
 		strlcpy(tmp, uml_dir, sizeof(tmp));
-		strcat(tmp, "XXXXXX");
+		strlcat(tmp, "XXXXXX", sizeof(tmp));
 		fd = mkstemp(tmp);
 		if(fd < 0){
-			(*printer)("make_umid - mkstemp(%s) failed: %s\n",
-				   tmp,strerror(errno));
-			return(1);
+			printk("make_umid - mkstemp(%s) failed: %s\n",
+			       tmp, strerror(errno));
+			err = -errno;
+			goto err;
 		}
 
-		os_close_file(fd);
+		close(fd);
+
+		set_umid(&tmp[strlen(uml_dir)]);
+
 		/* There's a nice tiny little race between this unlink and
 		 * the mkdir below.  It'd be nice if there were a mkstemp
 		 * for directories.
 		 */
-		unlink(tmp);
-		set_umid(&tmp[strlen(uml_dir)], printer);
+		if(unlink(tmp)){
+			err = -errno;
+			goto err;
+		}
 	}
-	
-	sprintf(tmp, "%s%s", uml_dir, umid);
+
+	snprintf(tmp, sizeof(tmp), "%s%s", uml_dir, umid);
 	err = mkdir(tmp, 0777);
 	if(err < 0){
-		if(errno == EEXIST){
-			if(not_dead_yet(tmp))
-				return -EEXIST;
-			err = mkdir(tmp, 0777);
-		}
+		err = -errno;
+		if(errno != EEXIST)
+			goto err;
+
+		if(not_dead_yet(tmp) < 0)
+			goto err;
+
+		err = mkdir(tmp, 0777);
 	}
 	if(err < 0){
-		(*printer)("Failed to create %s - errno = %d\n", umid, errno);
-		return(-1);
+		printk("Failed to create '%s' - err = %d\n", umid, err);
+		goto err_rmdir;
 	}
 
 	umid_setup = 1;
@@ -217,13 +252,18 @@ int __init make_umid(int (*printer)(cons
 	create_pid_file();
 
 	return 0;
+
+ err_rmdir:
+	rmdir(tmp);
+ err:
+	return err;
 }
 
 static int __init make_umid_init(void)
 {
-	make_umid(printk);
+	make_umid();
 
-	return(0);
+	return 0;
 }
 
 __initcall(make_umid_init);
@@ -232,48 +272,48 @@ int __init umid_file_name(char *name, ch
 {
 	int n, err;
 
-	if(!umid_setup){
-		err = make_umid(printk);
-		if(err)
-			return err;
-	}
+	err = make_umid();
+	if(err)
+		return err;
 
-	n = strlen(uml_dir) + strlen(umid) + strlen("/") + strlen(name) + 1;
-	if(n > len){
+	n = snprintf(buf, len, "%s%s/%s", uml_dir, umid, name);
+	if(n >= len){
 		printk("umid_file_name : buffer too short\n");
-		return(-1);
+		return -E2BIG;
 	}
 
-	sprintf(buf, "%s%s/%s", uml_dir, umid, name);
-	return(0);
+	return 0;
 }
 
-extern int umid_is_random;
-
-char *get_umid(int only_if_set)
+char *get_umid(void)
 {
-	if(only_if_set && umid_is_random)
-		return NULL;
 	return umid;
 }
 
 static int __init set_uml_dir(char *name, int *add)
 {
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
+	if(*name == '\0'){
+		printf("uml_dir can't be an empty string\n");
+		return 0;
+	}
+
+	if(name[strlen(name) - 1] == '/'){
+		uml_dir = name;
+		return 0;
 	}
-	else uml_dir = name;
-	return(0);
+
+	uml_dir = malloc(strlen(name) + 2);
+	if(uml_dir == NULL){
+		printf("Failed to malloc uml_dir - error = %d\n", errno);
+
+		/* Return 0 here because do_initcalls doesn't look at
+		 * the return value.
+		 */
+		return 0;
+	}
+	sprintf(uml_dir, "%s/", name);
+
+	return 0;
 }
 
 __uml_setup("uml_dir=", set_uml_dir,
@@ -283,10 +323,13 @@ __uml_setup("uml_dir=", set_uml_dir,
 
 static void remove_umid_dir(void)
 {
-	char dir[strlen(uml_dir) + UMID_LEN + 1];
+	char dir[strlen(uml_dir) + UMID_LEN + 1], err;
 
 	sprintf(dir, "%s%s", uml_dir, umid);
-	actually_do_remove(dir);
+	err = actually_do_remove(dir);
+	if(err)
+		printf("remove_umid_dir - actually_do_remove failed with "
+		       "err = %d\n", err);
 }
 
 __uml_exitcall(remove_umid_dir);

