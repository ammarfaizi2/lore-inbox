Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965225AbVLRQwh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965225AbVLRQwh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 11:52:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965222AbVLRQw3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 11:52:29 -0500
Received: from host229-46.pool8259.interbusiness.it ([82.59.46.229]:60632 "EHLO
	zion.home.lan") by vger.kernel.org with ESMTP id S965220AbVLRQwI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 11:52:08 -0500
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 4/4] uml skas0: stop gcc's insanity
Date: Sun, 18 Dec 2005 17:50:39 +0100
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Message-Id: <20051218165039.441.89463.stgit@zion.home.lan>
In-Reply-To: <20051218164916.441.69564.stgit@zion.home.lan>
References: <20051218164916.441.69564.stgit@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Jeff Dike <jdike@addtoit.com>, Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

UML skas0 stub has been miscompiling for many people (incidentally not the
authors), depending on the used GCC versions.

I think (and testing on some GCC versions shows) this patch avoids the
fundamental issue which is behind this, namely gcc using the stack when we have
just replaced it, behind gcc's back. The remapping and storage of the return
value is hidden in a blob of asm, hopefully giving gcc no room for creativity.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/include/sysdep-i386/stub.h   |   29 ++++++++++++++++-------------
 arch/um/include/sysdep-x86_64/stub.h |   30 +++++++++++++++++-------------
 arch/um/kernel/skas/clone.c          |   23 +++++++++++++----------
 3 files changed, 46 insertions(+), 36 deletions(-)

diff --git a/arch/um/include/sysdep-i386/stub.h b/arch/um/include/sysdep-i386/stub.h
index 6ba8cbb..b492b12 100644
--- a/arch/um/include/sysdep-i386/stub.h
+++ b/arch/um/include/sysdep-i386/stub.h
@@ -6,8 +6,12 @@
 #ifndef __SYSDEP_STUB_H
 #define __SYSDEP_STUB_H
 
+#include <sys/mman.h>
 #include <asm/ptrace.h>
 #include <asm/unistd.h>
+#include "stub-data.h"
+#include "kern_constants.h"
+#include "uml-config.h"
 
 extern void stub_segv_handler(int sig);
 extern void stub_clone_handler(void);
@@ -76,23 +80,22 @@ static inline long stub_syscall5(long sy
 	return ret;
 }
 
-static inline long stub_syscall6(long syscall, long arg1, long arg2, long arg3,
-				 long arg4, long arg5, long arg6)
+static inline void trap_myself(void)
 {
-	long ret;
-
-	__asm__ volatile ("push %%ebp ; movl %%eax,%%ebp ; movl %1,%%eax ; "
-			"int $0x80 ; pop %%ebp"
-			: "=a" (ret)
-			: "g" (syscall), "b" (arg1), "c" (arg2), "d" (arg3),
-			  "S" (arg4), "D" (arg5), "0" (arg6));
-
-	return ret;
+	__asm("int3");
 }
 
-static inline void trap_myself(void)
+static inline void remap_stack(int fd, unsigned long offset)
 {
-	__asm("int3");
+	__asm__ volatile ("movl %%eax,%%ebp ; movl %0,%%eax ; int $0x80 ;"
+			  "movl %7, %%ebx ; movl %%eax, (%%ebx)"
+			  : : "g" (STUB_MMAP_NR), "b" (UML_CONFIG_STUB_DATA), 
+			    "c" (UM_KERN_PAGE_SIZE), 
+			    "d" (PROT_READ | PROT_WRITE),
+			    "S" (MAP_FIXED | MAP_SHARED), "D" (fd), 
+			    "a" (offset), 
+			    "i" (&((struct stub_data *) UML_CONFIG_STUB_DATA)->err) 
+			  : "memory");
 }
 
 #endif
diff --git a/arch/um/include/sysdep-x86_64/stub.h b/arch/um/include/sysdep-x86_64/stub.h
index c41689c..92e989f 100644
--- a/arch/um/include/sysdep-x86_64/stub.h
+++ b/arch/um/include/sysdep-x86_64/stub.h
@@ -6,8 +6,12 @@
 #ifndef __SYSDEP_STUB_H
 #define __SYSDEP_STUB_H
 
+#include <sys/mman.h>
 #include <asm/unistd.h>
 #include <sysdep/ptrace_user.h>
+#include "stub-data.h"
+#include "kern_constants.h"
+#include "uml-config.h"
 
 extern void stub_segv_handler(int sig);
 extern void stub_clone_handler(void);
@@ -81,23 +85,23 @@ static inline long stub_syscall5(long sy
 	return ret;
 }
 
-static inline long stub_syscall6(long syscall, long arg1, long arg2, long arg3,
-				 long arg4, long arg5, long arg6)
+static inline void trap_myself(void)
 {
-	long ret;
-
-	__asm__ volatile ("movq %5,%%r10 ; movq %6,%%r8 ; "
-		"movq %7, %%r9; " __syscall : "=a" (ret)
-		: "0" (syscall), "D" (arg1), "S" (arg2), "d" (arg3),
-		  "g" (arg4), "g" (arg5), "g" (arg6)
-		: __syscall_clobber, "r10", "r8", "r9" );
-
-	return ret;
+	__asm("int3");
 }
 
-static inline void trap_myself(void)
+static inline void remap_stack(long fd, unsigned long offset)
 {
-	__asm("int3");
+	__asm__ volatile ("movq %4,%%r10 ; movq %5,%%r8 ; "
+			  "movq %6, %%r9; " __syscall "; movq %7, %%rbx ; "
+			  "movq %%rax, (%%rbx)": 
+			  : "a" (STUB_MMAP_NR), "D" (UML_CONFIG_STUB_DATA), 
+			    "S" (UM_KERN_PAGE_SIZE), 
+			    "d" (PROT_READ | PROT_WRITE), 
+                            "g" (MAP_FIXED | MAP_SHARED), "g" (fd), 
+			    "g" (offset),
+			    "i" (&((struct stub_data *) UML_CONFIG_STUB_DATA)->err)
+			  : __syscall_clobber, "r10", "r8", "r9" );
 }
 
 #endif
diff --git a/arch/um/kernel/skas/clone.c b/arch/um/kernel/skas/clone.c
index cb37ce9..47b812b 100644
--- a/arch/um/kernel/skas/clone.c
+++ b/arch/um/kernel/skas/clone.c
@@ -18,11 +18,10 @@
  * on some systems.
  */
 
-#define STUB_DATA(field) (((struct stub_data *) UML_CONFIG_STUB_DATA)->field)
-
 void __attribute__ ((__section__ (".__syscall_stub")))
 stub_clone_handler(void)
 {
+	struct stub_data *data = (struct stub_data *) UML_CONFIG_STUB_DATA;
 	long err;
 
 	err = stub_syscall2(__NR_clone, CLONE_PARENT | CLONE_FILES | SIGCHLD,
@@ -35,17 +34,21 @@ stub_clone_handler(void)
 	if(err)
 		goto out;
 
-	err = stub_syscall3(__NR_setitimer, ITIMER_VIRTUAL,
-			    (long) &STUB_DATA(timer), 0);
+	err = stub_syscall3(__NR_setitimer, ITIMER_VIRTUAL, 
+			    (long) &data->timer, 0);
 	if(err)
 		goto out;
 
-	err = stub_syscall6(STUB_MMAP_NR, UML_CONFIG_STUB_DATA,
-			    UM_KERN_PAGE_SIZE, PROT_READ | PROT_WRITE,
-			    MAP_FIXED | MAP_SHARED, STUB_DATA(fd),
-			    STUB_DATA(offset));
+	remap_stack(data->fd, data->offset);
+	goto done;
+
  out:
-	/* save current result. Parent: pid; child: retcode of mmap */
-	STUB_DATA(err) = err;
+	/* save current result. 
+	 * Parent: pid; 
+	 * child: retcode of mmap already saved and it jumps around this 
+	 * assignment
+	 */
+	data->err = err;
+ done:
 	trap_myself();
 }

