Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932464AbVKLSCq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932464AbVKLSCq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 13:02:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932459AbVKLSCY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 13:02:24 -0500
Received: from host20-103.pool873.interbusiness.it ([87.3.103.20]:48608 "EHLO
	zion.home.lan") by vger.kernel.org with ESMTP id S932455AbVKLSCM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 13:02:12 -0500
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 8/9] Uml: fix access_ok
Date: Sat, 12 Nov 2005 19:07:59 +0100
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Message-Id: <20051112180754.20133.28856.stgit@zion.home.lan>
In-Reply-To: <20051112180711.20133.68166.stgit@zion.home.lan>
References: <20051112180711.20133.68166.stgit@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

The access_ok_tt() macro is bogus, in that a read access is unconditionally
considered valid.

I couldn't find in SCM logs the introduction of this check, but I went back to
 2.4.20-1um and the definition was the same.

Possibly this was done to avoid problems with missing set_fs() calls, but there
can't be any I think because they would fail with SKAS mode. TT-specific code is
still to check.

Also, this patch joins common code together, and makes the "address range
wrapping" check happen for all cases, rather than for only some.

This may, possibly, be reoptimized at some time, but the current code doesn't
seem clever, just confused.

* Important: I've also had to change references to access_ok_{tt,skas} back to
  access_ok - the kernel wasn't that happy otherwise.
Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/include/um_uaccess.h               |   19 ++++++++++++++++++-
 arch/um/kernel/skas/include/uaccess-skas.h |   10 ++--------
 arch/um/kernel/skas/uaccess.c              |    8 ++++----
 arch/um/kernel/tt/include/uaccess-tt.h     |    8 +-------
 arch/um/kernel/tt/uaccess.c                |    8 ++++----
 5 files changed, 29 insertions(+), 24 deletions(-)

diff --git a/arch/um/include/um_uaccess.h b/arch/um/include/um_uaccess.h
index 84c0868..f8760a3 100644
--- a/arch/um/include/um_uaccess.h
+++ b/arch/um/include/um_uaccess.h
@@ -17,8 +17,25 @@
 #include "uaccess-skas.h"
 #endif
 
+#define __under_task_size(addr, size) \
+	(((unsigned long) (addr) < TASK_SIZE) && \
+         (((unsigned long) (addr) + (size)) < TASK_SIZE))
+
+#define __access_ok_vsyscall(type, addr, size) \
+	 ((type == VERIFY_READ) && \
+	  ((unsigned long) (addr) >= FIXADDR_USER_START) && \
+	  ((unsigned long) (addr) + (size) <= FIXADDR_USER_END) && \
+	  ((unsigned long) (addr) + (size) >= (unsigned long)(addr)))
+
+#define __addr_range_nowrap(addr, size) \
+	((unsigned long) (addr) <= ((unsigned long) (addr) + (size)))
+
 #define access_ok(type, addr, size) \
-	CHOOSE_MODE_PROC(access_ok_tt, access_ok_skas, type, addr, size)
+	(__addr_range_nowrap(addr, size) && \
+	 (__under_task_size(addr, size) || \
+	  __access_ok_vsyscall(type, addr, size) || \
+	  segment_eq(get_fs(), KERNEL_DS) || \
+	  CHOOSE_MODE_PROC(access_ok_tt, access_ok_skas, type, addr, size)))
 
 static inline int copy_from_user(void *to, const void __user *from, int n)
 {
diff --git a/arch/um/kernel/skas/include/uaccess-skas.h b/arch/um/kernel/skas/include/uaccess-skas.h
index 7da0c2d..f611f83 100644
--- a/arch/um/kernel/skas/include/uaccess-skas.h
+++ b/arch/um/kernel/skas/include/uaccess-skas.h
@@ -9,14 +9,8 @@
 #include "asm/errno.h"
 #include "asm/fixmap.h"
 
-#define access_ok_skas(type, addr, size) \
-	((segment_eq(get_fs(), KERNEL_DS)) || \
-	 (((unsigned long) (addr) < TASK_SIZE) && \
-	  ((unsigned long) (addr) + (size) <= TASK_SIZE)) || \
-	 ((type == VERIFY_READ ) && \
-	  ((unsigned long) (addr) >= FIXADDR_USER_START) && \
-	  ((unsigned long) (addr) + (size) <= FIXADDR_USER_END) && \
-	  ((unsigned long) (addr) + (size) >= (unsigned long)(addr))))
+/* No SKAS-specific checking. */
+#define access_ok_skas(type, addr, size) 0
 
 extern int copy_from_user_skas(void *to, const void __user *from, int n);
 extern int copy_to_user_skas(void __user *to, const void *from, int n);
diff --git a/arch/um/kernel/skas/uaccess.c b/arch/um/kernel/skas/uaccess.c
index 7519528..a5a4752 100644
--- a/arch/um/kernel/skas/uaccess.c
+++ b/arch/um/kernel/skas/uaccess.c
@@ -143,7 +143,7 @@ int copy_from_user_skas(void *to, const 
 		return(0);
 	}
 
-	return(access_ok_skas(VERIFY_READ, from, n) ?
+	return(access_ok(VERIFY_READ, from, n) ?
 	       buffer_op((unsigned long) from, n, 0, copy_chunk_from_user, &to):
 	       n);
 }
@@ -164,7 +164,7 @@ int copy_to_user_skas(void __user *to, c
 		return(0);
 	}
 
-	return(access_ok_skas(VERIFY_WRITE, to, n) ?
+	return(access_ok(VERIFY_WRITE, to, n) ?
 	       buffer_op((unsigned long) to, n, 1, copy_chunk_to_user, &from) :
 	       n);
 }
@@ -193,7 +193,7 @@ int strncpy_from_user_skas(char *dst, co
 		return(strnlen(dst, count));
 	}
 
-	if(!access_ok_skas(VERIFY_READ, src, 1))
+	if(!access_ok(VERIFY_READ, src, 1))
 		return(-EFAULT);
 
 	n = buffer_op((unsigned long) src, count, 0, strncpy_chunk_from_user,
@@ -221,7 +221,7 @@ int clear_user_skas(void __user *mem, in
 		return(0);
 	}
 
-	return(access_ok_skas(VERIFY_WRITE, mem, len) ?
+	return(access_ok(VERIFY_WRITE, mem, len) ?
 	       buffer_op((unsigned long) mem, len, 1, clear_chunk, NULL) : len);
 }
 
diff --git a/arch/um/kernel/tt/include/uaccess-tt.h b/arch/um/kernel/tt/include/uaccess-tt.h
index dc2ebfa..b9bfe9c 100644
--- a/arch/um/kernel/tt/include/uaccess-tt.h
+++ b/arch/um/kernel/tt/include/uaccess-tt.h
@@ -19,19 +19,13 @@
 extern unsigned long end_vm;
 extern unsigned long uml_physmem;
 
-#define under_task_size(addr, size) \
-	(((unsigned long) (addr) < TASK_SIZE) && \
-         (((unsigned long) (addr) + (size)) < TASK_SIZE))
-
 #define is_stack(addr, size) \
 	(((unsigned long) (addr) < STACK_TOP) && \
 	 ((unsigned long) (addr) >= STACK_TOP - ABOVE_KMEM) && \
 	 (((unsigned long) (addr) + (size)) <= STACK_TOP))
 
 #define access_ok_tt(type, addr, size) \
-	((type == VERIFY_READ) || (segment_eq(get_fs(), KERNEL_DS)) || \
-         (((unsigned long) (addr) <= ((unsigned long) (addr) + (size))) && \
-          (under_task_size(addr, size) || is_stack(addr, size))))
+	(is_stack(addr, size))
 
 extern unsigned long get_fault_addr(void);
 
diff --git a/arch/um/kernel/tt/uaccess.c b/arch/um/kernel/tt/uaccess.c
index a72aa63..1cb6072 100644
--- a/arch/um/kernel/tt/uaccess.c
+++ b/arch/um/kernel/tt/uaccess.c
@@ -8,7 +8,7 @@
 
 int copy_from_user_tt(void *to, const void __user *from, int n)
 {
-	if(!access_ok_tt(VERIFY_READ, from, n))
+	if(!access_ok(VERIFY_READ, from, n))
 		return(n);
 
 	return(__do_copy_from_user(to, from, n, &current->thread.fault_addr,
@@ -17,7 +17,7 @@ int copy_from_user_tt(void *to, const vo
 
 int copy_to_user_tt(void __user *to, const void *from, int n)
 {
-	if(!access_ok_tt(VERIFY_WRITE, to, n))
+	if(!access_ok(VERIFY_WRITE, to, n))
 		return(n);
 
 	return(__do_copy_to_user(to, from, n, &current->thread.fault_addr,
@@ -28,7 +28,7 @@ int strncpy_from_user_tt(char *dst, cons
 {
 	int n;
 
-	if(!access_ok_tt(VERIFY_READ, src, 1))
+	if(!access_ok(VERIFY_READ, src, 1))
 		return(-EFAULT);
 
 	n = __do_strncpy_from_user(dst, src, count,
@@ -47,7 +47,7 @@ int __clear_user_tt(void __user *mem, in
 
 int clear_user_tt(void __user *mem, int len)
 {
-	if(!access_ok_tt(VERIFY_WRITE, mem, len))
+	if(!access_ok(VERIFY_WRITE, mem, len))
 		return(len);
 
 	return(__do_clear_user(mem, len, &current->thread.fault_addr,

