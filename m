Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314549AbSDSEq0>; Fri, 19 Apr 2002 00:46:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314550AbSDSEqY>; Fri, 19 Apr 2002 00:46:24 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:22421 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S314549AbSDSEqT>;
	Fri, 19 Apr 2002 00:46:19 -0400
Date: Fri, 19 Apr 2002 00:46:17 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] (2/6) alpha fixes
In-Reply-To: <Pine.GSO.4.21.0204190037400.20383-100000@weyl.math.psu.edu>
Message-ID: <Pine.GSO.4.21.0204190045560.20383-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


diff -urN C8-nfsctl/arch/alpha/kernel/semaphore.c C8-alpha-defines/arch/alpha/kernel/semaphore.c
--- C8-nfsctl/arch/alpha/kernel/semaphore.c	Tue Nov 20 18:49:31 2001
+++ C8-alpha-defines/arch/alpha/kernel/semaphore.c	Thu Apr 18 23:23:15 2002
@@ -5,8 +5,8 @@
  * (C) Copyright 1999, 2000 Richard Henderson
  */
 
+#include <linux/errno.h>
 #include <linux/sched.h>
-
 
 /*
  * Semaphores are implemented using a two-way counter:
diff -urN C8-nfsctl/include/asm-alpha/mman.h C8-alpha-defines/include/asm-alpha/mman.h
--- C8-nfsctl/include/asm-alpha/mman.h	Thu Mar 16 17:07:09 2000
+++ C8-alpha-defines/include/asm-alpha/mman.h	Thu Apr 18 23:23:15 2002
@@ -4,6 +4,7 @@
 #define PROT_READ	0x1		/* page can be read */
 #define PROT_WRITE	0x2		/* page can be written */
 #define PROT_EXEC	0x4		/* page can be executed */
+#define PROT_SEM	0x8		/* page may be used for atomic ops */
 #define PROT_NONE	0x0		/* page can not be accessed */
 
 #define MAP_SHARED	0x01		/* Share changes */
diff -urN C8-nfsctl/include/asm-alpha/siginfo.h C8-alpha-defines/include/asm-alpha/siginfo.h
--- C8-nfsctl/include/asm-alpha/siginfo.h	Sun Feb 10 23:06:16 2002
+++ C8-alpha-defines/include/asm-alpha/siginfo.h	Thu Apr 18 23:23:15 2002
@@ -108,6 +108,7 @@
 #define SI_ASYNCIO	-4		/* sent by AIO completion */
 #define SI_SIGIO	-5		/* sent by queued SIGIO */
 #define SI_TKILL	-6		/* sent by tkill system call */
+#define SI_DETHREAD	-7		/* sent by execve() killing subsidiary threads */
 
 #define SI_FROMUSER(siptr)	((siptr)->si_code <= 0)
 #define SI_FROMKERNEL(siptr)	((siptr)->si_code > 0)
diff -urN C8-nfsctl/include/asm-alpha/thread_info.h C8-alpha-defines/include/asm-alpha/thread_info.h
--- C8-nfsctl/include/asm-alpha/thread_info.h	Tue Feb 19 22:33:05 2002
+++ C8-alpha-defines/include/asm-alpha/thread_info.h	Thu Apr 18 23:23:15 2002
@@ -20,6 +20,7 @@
 	struct exec_domain	*exec_domain;	/* execution domain */
 	mm_segment_t		addr_limit;	/* thread address space */
 	int			cpu;		/* current CPU */
+	int			preempt_count; /* 0 => preemptable, <0 => BUG */
 
 	int bpt_nsaved;
 	unsigned long bpt_addr[2];		/* breakpoint handling  */
@@ -52,6 +53,8 @@
 #define put_thread_info(ti) put_task_struct((ti)->task)
 
 #endif /* __ASSEMBLY__ */
+
+#define PREEMPT_ACTIVE		0x4000000
 
 /*
  * Thread information flags:
diff -urN C8-nfsctl/include/asm-alpha/unistd.h C8-alpha-defines/include/asm-alpha/unistd.h
--- C8-nfsctl/include/asm-alpha/unistd.h	Sun Apr 14 17:53:11 2002
+++ C8-alpha-defines/include/asm-alpha/unistd.h	Thu Apr 18 23:23:15 2002
@@ -528,6 +528,7 @@
 
 static inline long close(int fd)
 {
+	extern long sys_close(unsigned int);
 	return sys_close(fd);
 }
 
@@ -603,6 +604,6 @@
  * What we want is __attribute__((weak,alias("sys_ni_syscall"))),
  * but it doesn't work on all toolchains, so we just do it by hand
  */
-#define cond_syscall(x) asm(".weak\t" #x "\n\t.set\t" #x ",sys_ni_syscall");
+#define cond_syscall(x) asmlinkage long x(void) __attribute__((weak,alias("sys_ni_syscall")));
 
 #endif /* _ALPHA_UNISTD_H */
diff -urN C8-nfsctl/init/main.c C8-alpha-defines/init/main.c
--- C8-nfsctl/init/main.c	Sun Apr 14 17:53:13 2002
+++ C8-alpha-defines/init/main.c	Thu Apr 18 23:23:15 2002
@@ -271,6 +271,9 @@
 #else
 #define smp_init()	do { } while (0)
 #endif
+static inline void setup_per_cpu_areas(void)
+{
+}
 
 #else
 
diff -urN C8-nfsctl/lib/radix-tree.c C8-alpha-defines/lib/radix-tree.c
--- C8-nfsctl/lib/radix-tree.c	Sun Apr 14 17:53:13 2002
+++ C8-alpha-defines/lib/radix-tree.c	Thu Apr 18 23:23:15 2002
@@ -24,6 +24,7 @@
 #include <linux/module.h>
 #include <linux/radix-tree.h>
 #include <linux/slab.h>
+#include <linux/string.h>
 
 /*
  * Radix tree node definition.


