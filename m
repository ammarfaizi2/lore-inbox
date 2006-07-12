Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750924AbWGLQ0V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750924AbWGLQ0V (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 12:26:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750988AbWGLQ0V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 12:26:21 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:7358 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750883AbWGLQ0U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 12:26:20 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: "Ulrich Drepper" <drepper@gmail.com>
Cc: Arjan van de Ven <arjan@infradead.org>,
       "Randy.Dunlap" <rdunlap@xenotime.net>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, libc-alpha@sourceware.org
Subject: [PATCH] Use uname not sysctl to get the kernel revision
References: <m1psgdkrt8.fsf@ebiederm.dsl.xmission.com>
	<20060710155051.326e49da.rdunlap@xenotime.net>
	<m1veq4kcij.fsf@ebiederm.dsl.xmission.com>
	<1152601640.3128.7.camel@laptopd505.fenrus.org>
Date: Wed, 12 Jul 2006 10:25:00 -0600
In-Reply-To: <1152601640.3128.7.camel@laptopd505.fenrus.org> (Arjan van de
	Ven's message of "Tue, 11 Jul 2006 09:07:20 +0200")
Message-ID: <m1irm2bxk3.fsf_-_@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Currently it is felt but at least a subset of the kernel maintainers
that the binary sysctl interface is not maintainable, and the /proc
/sys interface should be used instead.  In investigating this it turns
out that the pthread code in glibc for detecting a SMP kernel appears
to be the primary user.

The information that we are asking for is available from the uname
system call so I don't understand why the code is using sysctl.

To understand the cost of the various approaches I put together
a little test program.  Using time for timing and running 100000
repetitions of the various system calls I get about
sysctl: 0.3s to 0.2s
uname:  0.1s to 0.07s
proc:   7.5 to  4.1s

proc is significantly slower which puzzles me.
But uname is noticeably faster than sysctl and uname is more portable
across linux flavors.  So updating the glibc pthread code to use
uname looks like the right way to implement is_smp_system. 

I do think detecting a SMP kernel to enable busy waiting on contended
mutexes is a very peculiar thing to be doing.  

My test performance test program:
> #include <string.h>
> #include <stdio.h>
> #include <sys/utsname.h>
> #include <errno.h>
> #include <stdarg.h>
> #include <stdlib.h>
> #include <sys/sysctl.h>
> #include <fcntl.h>
> #include <unistd.h>
> 
> static void uname_test(void)
> {
> 	struct utsname uts;
> 	uname(&uts);
> }
> 
> static void proc_test(void)
> {
> 	int fd;
> 	char buf[512];
> 	fd = open("/proc/sys/kernel/version", O_RDONLY);
> 	read(fd, buf, sizeof(buf));
> 	close(fd);
> }
> 
> static void sysctl_test(void)
> {
> 	static int sysctl_args[] = { CTL_KERN, KERN_VERSION };
> 	char buf[512];
> 	size_t reslen = sizeof(buf);
> 
> 	sysctl(sysctl_args, sizeof(sysctl_args)/sizeof(sysctl_args[0]),
> 		buf, &reslen, NULL, 0);
> }
> 
> int main(int argc, char *argv[])
> {
> 	void (*test)(void) = NULL;
> 	int reps = -1;
> 	int i;
> 
> 	for (i = 1; i < argc; i++) {
> 		if (strcmp(argv[i], "--sysctl") == 0)
> 			test = sysctl_test;
> 		else if (strcmp(argv[i], "--uname") == 0)
> 			test = uname_test;
> 		else if (strcmp(argv[i], "--proc") == 0)
> 			test = proc_test;
> 		else 
> 			reps = atol(argv[i]);
> 	}
> 	if ((reps == -1) || (test == NULL)) {
> 		fprintf(stderr, "usage: [--sysctl | --uname | --proc] <reps>\n");
> 		return 1;
> 	}
> 
> 	for (i = 0; i < reps; i++) {
> 		test();
> 	}
> 	return 0;
> }


My patch to use uname instead of proc or sysctl to get the 

--- glibc-2.4/nptl/sysdeps/unix/sysv/linux/smp.h-sysctl	2006-07-12 08:48:44.000000000 -0600
+++ glibc-2.4/nptl/sysdeps/unix/sysv/linux/smp.h	2006-07-12 09:57:07.000000000 -0600
@@ -17,11 +17,8 @@
    write to the Free Software Foundation, Inc., 59 Temple Place - Suite 330,
    Boston, MA 02111-1307, USA.  */
 
-#include <errno.h>
-#include <fcntl.h>
 #include <string.h>
-#include <sys/sysctl.h>
-#include <not-cancel.h>
+#include <sys/utsname>
 
 /* Test whether the machine has more than one processor.  This is not the
    best test but good enough.  More complicated tests would require `malloc'
@@ -29,24 +26,8 @@
 static inline int
 is_smp_system (void)
 {
-  static const int sysctl_args[] = { CTL_KERN, KERN_VERSION };
-  char buf[512];
-  size_t reslen = sizeof (buf);
-
-  /* Try reading the number using `sysctl' first.  */
-  if (__sysctl ((int *) sysctl_args,
-		sizeof (sysctl_args) / sizeof (sysctl_args[0]),
-		buf, &reslen, NULL, 0) < 0)
-    {
-      /* This was not successful.  Now try reading the /proc filesystem.  */
-      int fd = open_not_cancel_2 ("/proc/sys/kernel/version", O_RDONLY);
-      if (__builtin_expect (fd, 0) == -1
-	  || (reslen = read_not_cancel (fd, buf, sizeof (buf))) <= 0)
-	/* This also didn't work.  We give up and say it's a UP machine.  */
-	buf[0] = '\0';
-
-      close_not_cancel_no_status (fd);
-    }
-
-  return strstr (buf, "SMP") != NULL;
+  struct utsname uts;
+  if (uname(&uts) < 0)
+	  uts.version[0] = '\0';
+  return strstr (uts.version, "SMP") != NULL;
 }
