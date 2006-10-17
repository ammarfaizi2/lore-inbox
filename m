Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750719AbWJQV3l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750719AbWJQV3l (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 17:29:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750786AbWJQV3l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 17:29:41 -0400
Received: from smtp008.mail.ukl.yahoo.com ([217.12.11.62]:46229 "HELO
	smtp008.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1750719AbWJQV1L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 17:27:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:Subject:Date:To:Cc:Bcc:Message-Id:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:User-Agent;
  b=RzJ22KA+0QCxPFzRz52XWnLCltu+fPpUHecBpjrjPBg4u478Prt3dUkvcSdvENVQE2DM6+kTiCXcuF7Gpl385RuE8TqEAl4uHo2XiWiz5efdZC681Vt5Izg5zXaQOPTc6Zt97l2pSSOHfsOaZXmgo/6LIh7oZO2CXcZQCOXwIKc=  ;
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 04/10] uml: make execvp safe for our usage
Date: Tue, 17 Oct 2006 23:27:11 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Message-Id: <20061017212711.26445.79770.stgit@americanbeauty.home.lan>
In-Reply-To: <20061017211943.26445.75719.stgit@americanbeauty.home.lan>
References: <20061017211943.26445.75719.stgit@americanbeauty.home.lan>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Reimplement execvp for our purposes - after we call fork() it is fundamentally
unsafe to use the kernel allocator - current is not valid there. So we simply
pass to our modified execvp() a preallocated buffer. This fixes a real bug and
works very well in testing (I've seen indirectly warning messages from the
forked thread - they went on the pipe connected to its stdout and where read as
a number by UML, when calling read_output(). I verified the obtained number
corresponded to "BUG:").

The added use of __cant_sleep() is not a new bug since __cant_sleep() is already
used in the same function - passing an atomicity parameter would be better but
it would require huge change, stating that this function must not be called in
atomic context and can sleep is a better idea (will make sure of this gradually).

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/include/os.h      |    2 +
 arch/um/os-Linux/Makefile |   10 ++-
 arch/um/os-Linux/execvp.c |  149 +++++++++++++++++++++++++++++++++++++++++++++
 arch/um/os-Linux/helper.c |   13 +++-
 4 files changed, 165 insertions(+), 9 deletions(-)

diff --git a/arch/um/include/os.h b/arch/um/include/os.h
index 6516f6d..13a86bd 100644
--- a/arch/um/include/os.h
+++ b/arch/um/include/os.h
@@ -233,6 +233,8 @@ extern unsigned long __do_user_copy(void
 				    void (*op)(void *to, const void *from,
 					       int n), int *faulted_out);
 
+/* execvp.c */
+extern int execvp_noalloc(char *buf, const char *file, char *const argv[]);
 /* helper.c */
 extern int run_helper(void (*pre_exec)(void *), void *pre_data, char **argv,
 		      unsigned long *stack_out);
diff --git a/arch/um/os-Linux/Makefile b/arch/um/os-Linux/Makefile
index b418392..2f8c794 100644
--- a/arch/um/os-Linux/Makefile
+++ b/arch/um/os-Linux/Makefile
@@ -3,8 +3,8 @@ # Copyright (C) 2000 Jeff Dike (jdike@ka
 # Licensed under the GPL
 #
 
-obj-y = aio.o elf_aux.o file.o helper.o irq.o main.o mem.o process.o sigio.o \
-	signal.o start_up.o time.o trap.o tty.o uaccess.o umid.o tls.o \
+obj-y = aio.o elf_aux.o execvp.o file.o helper.o irq.o main.o mem.o process.o \
+	sigio.o signal.o start_up.o time.o trap.o tty.o uaccess.o umid.o tls.o \
 	user_syms.o util.o drivers/ sys-$(SUBARCH)/
 
 obj-$(CONFIG_MODE_SKAS) += skas/
@@ -15,9 +15,9 @@ user-objs-$(CONFIG_MODE_TT) += tt.o
 obj-$(CONFIG_TTY_LOG) += tty_log.o
 user-objs-$(CONFIG_TTY_LOG) += tty_log.o
 
-USER_OBJS := $(user-objs-y) aio.o elf_aux.o file.o helper.o irq.o main.o mem.o \
-	process.o sigio.o signal.o start_up.o time.o trap.o tty.o tls.o \
-	uaccess.o umid.o util.o
+USER_OBJS := $(user-objs-y) aio.o elf_aux.o execvp.o file.o helper.o irq.o \
+	main.o mem.o process.o sigio.o signal.o start_up.o time.o trap.o tty.o \
+	tls.o uaccess.o umid.o util.o
 
 CFLAGS_user_syms.o += -DSUBARCH_$(SUBARCH)
 
diff --git a/arch/um/os-Linux/execvp.c b/arch/um/os-Linux/execvp.c
new file mode 100644
index 0000000..66e583a
--- /dev/null
+++ b/arch/um/os-Linux/execvp.c
@@ -0,0 +1,149 @@
+/* Copyright (C) 2006 by Paolo Giarrusso - modified from glibc' execvp.c.
+   Original copyright notice follows:
+
+   Copyright (C) 1991,92,1995-99,2002,2004 Free Software Foundation, Inc.
+   This file is part of the GNU C Library.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library; if not, write to the Free
+   Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
+   02111-1307 USA.  */
+#include <unistd.h>
+
+#include <stdbool.h>
+#include <stdlib.h>
+#include <string.h>
+#include <errno.h>
+#include <limits.h>
+
+#ifndef TEST
+#include "um_malloc.h"
+#else
+#include <stdio.h>
+#define um_kmalloc malloc
+#endif
+#include "os.h"
+
+/* Execute FILE, searching in the `PATH' environment variable if it contains
+   no slashes, with arguments ARGV and environment from `environ'.  */
+int execvp_noalloc(char *buf, const char *file, char *const argv[])
+{
+	if (*file == '\0') {
+		return -ENOENT;
+	}
+
+	if (strchr (file, '/') != NULL) {
+		/* Don't search when it contains a slash.  */
+		execv(file, argv);
+	} else {
+		int got_eacces;
+		size_t len, pathlen;
+		char *name, *p;
+		char *path = getenv("PATH");
+		if (path == NULL)
+			path = ":/bin:/usr/bin";
+
+		len = strlen(file) + 1;
+		pathlen = strlen(path);
+		/* Copy the file name at the top.  */
+		name = memcpy(buf + pathlen + 1, file, len);
+		/* And add the slash.  */
+		*--name = '/';
+
+		got_eacces = 0;
+		p = path;
+		do {
+			char *startp;
+
+			path = p;
+			//Let's avoid this GNU extension.
+			//p = strchrnul (path, ':');
+			p = strchr(path, ':');
+			if (!p)
+				p = strchr(path, '\0');
+
+			if (p == path)
+				/* Two adjacent colons, or a colon at the beginning or the end
+				   of `PATH' means to search the current directory.  */
+				startp = name + 1;
+			else
+				startp = memcpy(name - (p - path), path, p - path);
+
+			/* Try to execute this name.  If it works, execv will not return.  */
+			execv(startp, argv);
+
+			/*
+			if (errno == ENOEXEC) {
+			}
+			*/
+
+			switch (errno) {
+				case EACCES:
+					/* Record the we got a `Permission denied' error.  If we end
+					   up finding no executable we can use, we want to diagnose
+					   that we did find one but were denied access.  */
+					got_eacces = 1;
+				case ENOENT:
+				case ESTALE:
+				case ENOTDIR:
+					/* Those errors indicate the file is missing or not executable
+					   by us, in which case we want to just try the next path
+					   directory.  */
+				case ENODEV:
+				case ETIMEDOUT:
+					/* Some strange filesystems like AFS return even
+					   stranger error numbers.  They cannot reasonably mean
+					   anything else so ignore those, too.  */
+				case ENOEXEC:
+					/* We won't go searching for the shell
+					 * if it is not executable - the Linux
+					 * kernel already handles this enough,
+					 * for us. */
+					break;
+
+				default:
+					/* Some other error means we found an executable file, but
+					   something went wrong executing it; return the error to our
+					   caller.  */
+					return -errno;
+			}
+		} while (*p++ != '\0');
+
+		/* We tried every element and none of them worked.  */
+		if (got_eacces)
+			/* At least one failure was due to permissions, so report that
+			   error.  */
+			return -EACCES;
+	}
+
+	/* Return the error from the last attempt (probably ENOENT).  */
+	return -errno;
+}
+#ifdef TEST
+int main(int argc, char**argv)
+{
+	char buf[PATH_MAX];
+	int ret;
+	argc--;
+	if (!argc) {
+		fprintf(stderr, "Not enough arguments\n");
+		return 1;
+	}
+	argv++;
+	if (ret = execvp_noalloc(buf, argv[0], argv)) {
+		errno = -ret;
+		perror("execvp_noalloc");
+	}
+	return 0;
+}
+#endif
diff --git a/arch/um/os-Linux/helper.c b/arch/um/os-Linux/helper.c
index cd15b9d..f72c512 100644
--- a/arch/um/os-Linux/helper.c
+++ b/arch/um/os-Linux/helper.c
@@ -8,18 +8,21 @@ #include <stdlib.h>
 #include <unistd.h>
 #include <errno.h>
 #include <sched.h>
+#include <limits.h>
 #include <sys/signal.h>
 #include <sys/wait.h>
 #include "user.h"
 #include "kern_util.h"
 #include "user_util.h"
 #include "os.h"
+#include "um_malloc.h"
 
 struct helper_data {
 	void (*pre_exec)(void*);
 	void *pre_data;
 	char **argv;
 	int fd;
+	char *buf;
 };
 
 /* Debugging aid, changed only from gdb */
@@ -41,9 +44,8 @@ static int helper_child(void *arg)
 	}
 	if(data->pre_exec != NULL)
 		(*data->pre_exec)(data->pre_data);
-	execvp(argv[0], argv);
-	errval = -errno;
-	printk("helper_child - execve of '%s' failed - errno = %d\n", argv[0], errno);
+	errval = execvp_noalloc(data->buf, argv[0], argv);
+	printk("helper_child - execvp of '%s' failed - errno = %d\n", argv[0], -errval);
 	os_write_file(data->fd, &errval, sizeof(errval));
 	kill(os_getpid(), SIGKILL);
 	return(0);
@@ -82,11 +84,12 @@ int run_helper(void (*pre_exec)(void *),
 	data.pre_data = pre_data;
 	data.argv = argv;
 	data.fd = fds[1];
+	data.buf = __cant_sleep() ? um_kmalloc_atomic(PATH_MAX) : um_kmalloc(PATH_MAX);
 	pid = clone(helper_child, (void *) sp, CLONE_VM | SIGCHLD, &data);
 	if(pid < 0){
 		ret = -errno;
 		printk("run_helper : clone failed, errno = %d\n", errno);
-		goto out_close;
+		goto out_free2;
 	}
 
 	close(fds[1]);
@@ -107,6 +110,8 @@ int run_helper(void (*pre_exec)(void *),
 		CATCH_EINTR(waitpid(pid, NULL, 0));
 	}
 
+out_free2:
+	kfree(data.buf);
 out_close:
 	if (fds[1] != -1)
 		close(fds[1]);
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 
