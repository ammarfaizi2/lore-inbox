Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932213AbWDKAgL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932213AbWDKAgL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 20:36:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932218AbWDKAgL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 20:36:11 -0400
Received: from saraswathi.solana.com ([198.99.130.12]:8420 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S932213AbWDKAgJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 20:36:09 -0400
Message-Id: <200604102337.k3ANb8M7006858@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       Rob Landley <rob@landley.net>
Subject: [PATCH 3/3] UML - 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 10 Apr 2006 19:37:08 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Landley <rob@landley.net>

UML really wants shared memory semantics form its physical memory map file,
and the place for that is /dev/shm.  So move the default, and fix the error
messages to recognize that this value can be overridden.

Signed-off-by: Rob Landley <rob@landley.net>
Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.16-mm/arch/um/os-Linux/mem.c
===================================================================
--- linux-2.6.16-mm.orig/arch/um/os-Linux/mem.c	2006-04-08 17:21:35.000000000 -0400
+++ linux-2.6.16-mm/arch/um/os-Linux/mem.c	2006-04-10 20:15:26.000000000 -0400
@@ -8,6 +8,7 @@
 #include <fcntl.h>
 #include <sys/types.h>
 #include <sys/mman.h>
+#include <sys/statfs.h>
 #include "kern_util.h"
 #include "user.h"
 #include "user_util.h"
@@ -19,6 +20,7 @@
 
 #include <sys/param.h>
 
+static char *default_tmpdir = "/tmp";
 static char *tempdir = NULL;
 
 static void __init find_tempdir(void)
@@ -34,7 +36,7 @@ static void __init find_tempdir(void)
 			break;
 	}
 	if((dir == NULL) || (*dir == '\0'))
-		dir = "/tmp";
+		dir = default_tmpdir;
 
 	tempdir = malloc(strlen(dir) + 2);
 	if(tempdir == NULL){
@@ -46,6 +48,96 @@ static void __init find_tempdir(void)
 	strcat(tempdir, "/");
 }
 
+/* This will return 1, with the first character in buf being the
+ * character following the next instance of c in the file.  This will
+ * read the file as needed.  If there's an error, -errno is returned;
+ * if the end of the file is reached, 0 is returned.
+ */
+static int next(int fd, char *buf, int size, char c)
+{
+	int n;
+	char *ptr;
+
+	while((ptr = strchr(buf, c)) == NULL){
+		n = read(fd, buf, size - 1);
+		if(n == 0)
+			return 0;
+		else if(n < 0)
+			return -errno;
+
+		buf[n] = '\0';
+	}
+
+	ptr++;
+	memmove(buf, ptr, strlen(ptr) + 1);
+	return 1;
+}
+
+static int checked_tmpdir = 0;
+
+/* Look for a tmpfs mounted at /dev/shm.  I couldn't find a cleaner
+ * way to do this than to parse /proc/mounts.  statfs will return the
+ * same filesystem magic number and fs id for both /dev and /dev/shm
+ * when they are both tmpfs, so you can't tell if they are different
+ * filesystems.  Also, there seems to be no other way of finding the
+ * mount point of a filesystem from within it.
+ *
+ * If a /dev/shm tmpfs entry is found, then we switch to using it.
+ * Otherwise, we stay with the default /tmp.
+ */
+static void which_tmpdir(void)
+{
+	int fd, found;
+	char buf[128] = { '\0' };
+
+	if(checked_tmpdir)
+		return;
+
+	checked_tmpdir = 1;
+
+	printf("Checking for tmpfs mount on /dev/shm...");
+
+	fd = open("/proc/mounts", O_RDONLY);
+	if(fd < 0){
+		printf("failed to open /proc/mounts, errno = %d\n", errno);
+		return;
+	}
+
+	while(1){
+		found = next(fd, buf, sizeof(buf) / sizeof(buf[0]), ' ');
+		if(found != 1)
+			break;
+
+		if(!strncmp(buf, "/dev/shm", strlen("/dev/shm")))
+			goto found;
+
+		found = next(fd, buf, sizeof(buf) / sizeof(buf[0]), '\n');
+		if(found != 1)
+			break;
+	}
+
+err:
+	if(found == 0)
+		printf("nothing mounted on /dev/shm\n");
+	else if(found < 0)
+		printf("read returned errno %d\n", -found);
+
+	return;
+
+found:
+	found = next(fd, buf, sizeof(buf) / sizeof(buf[0]), ' ');
+	if(found != 1)
+		goto err;
+
+	if(strncmp(buf, "tmpfs", strlen("tmpfs"))){
+		printf("not tmpfs\n");
+		return;
+	}
+
+	printf("OK\n");
+	default_tmpdir = "/dev/shm";
+}
+
 /*
  * This proc still used in tt-mode
  * (file: kernel/tt/ptproxy/proxy.c, proc: start_debugger).
@@ -56,6 +148,7 @@ int make_tempfile(const char *template, 
 	char *tempname;
 	int fd;
 
+	which_tmpdir();
 	tempname = malloc(MAXPATHLEN);
 
 	find_tempdir();
@@ -137,3 +230,26 @@ int create_mem_file(unsigned long long l
 	}
 	return(fd);
 }
+
+
+void check_tmpexec(void)
+{
+	void *addr;
+	int err, fd = create_tmp_file(UM_KERN_PAGE_SIZE);
+
+	addr = mmap(NULL, UM_KERN_PAGE_SIZE,
+		    PROT_READ | PROT_WRITE | PROT_EXEC, MAP_PRIVATE, fd, 0);
+	printf("Checking PROT_EXEC mmap in %s...",tempdir);
+	fflush(stdout);
+	if(addr == MAP_FAILED){
+		err = errno;
+		perror("failed");
+		if(err == EPERM)
+			printf("%s must be not mounted noexec\n",tempdir);
+		exit(1);
+	}
+	printf("OK\n");
+	munmap(addr, UM_KERN_PAGE_SIZE);
+
+	close(fd);
+}
Index: linux-2.6.16-mm/arch/um/os-Linux/start_up.c
===================================================================
--- linux-2.6.16-mm.orig/arch/um/os-Linux/start_up.c	2006-04-08 17:21:35.000000000 -0400
+++ linux-2.6.16-mm/arch/um/os-Linux/start_up.c	2006-04-10 14:53:26.000000000 -0400
@@ -296,29 +296,7 @@ static void __init check_ptrace(void)
 	check_sysemu();
 }
 
-extern int create_tmp_file(unsigned long long len);
-
-static void check_tmpexec(void)
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
-	close(fd);
-}
+extern void check_tmpexec(void);
 
 void os_early_checks(void)
 {

