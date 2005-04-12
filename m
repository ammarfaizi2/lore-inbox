Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262507AbVDLTUv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262507AbVDLTUv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 15:20:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262587AbVDLTUE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 15:20:04 -0400
Received: from fire.osdl.org ([65.172.181.4]:35529 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262198AbVDLKc2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:32:28 -0400
Message-Id: <200504121032.j3CAWIOM005553@shell0.pdx.osdl.net>
Subject: [patch 104/198] h8300 header update
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, ysato@users.sourceforge.jp
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:32:12 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Yoshinori Sato <ysato@users.sourceforge.jp>

- page.h: fix build error
- unistd.h: _syscall macro cleanup.

Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/include/asm-h8300/page.h   |    4 
 25-akpm/include/asm-h8300/unistd.h |  304 ++++++++++++++++++-------------------
 2 files changed, 150 insertions(+), 158 deletions(-)

diff -puN include/asm-h8300/page.h~h8300-header-update include/asm-h8300/page.h
--- 25/include/asm-h8300/page.h~h8300-header-update	2005-04-12 03:21:27.924891672 -0700
+++ 25-akpm/include/asm-h8300/page.h	2005-04-12 03:21:27.928891064 -0700
@@ -79,7 +79,7 @@ extern unsigned long memory_end;
 
 #ifndef __ASSEMBLY__
 
-#define __pa(vaddr)		virt_to_phys((void *)vaddr)
+#define __pa(vaddr)		virt_to_phys(vaddr)
 #define __va(paddr)		phys_to_virt((unsigned long)paddr)
 
 #define virt_to_pfn(kaddr)	(__pa(kaddr) >> PAGE_SHIFT)
@@ -89,7 +89,7 @@ extern unsigned long memory_end;
 #define virt_to_page(addr)	(mem_map + (((unsigned long)(addr)-PAGE_OFFSET) >> PAGE_SHIFT))
 #define virt_to_page(addr)	(mem_map + (((unsigned long)(addr)-PAGE_OFFSET) >> PAGE_SHIFT))
 #define page_to_virt(page)	((((page) - mem_map) << PAGE_SHIFT) + PAGE_OFFSET)
-#define VALID_PAGE(page)	((page - mem_map) < max_mapnr)
+#define pfn_valid(page)	        (page < max_mapnr)
 
 #define pfn_to_page(pfn)	virt_to_page(pfn_to_virt(pfn))
 #define page_to_pfn(page)	virt_to_pfn(page_to_virt(page))
diff -puN include/asm-h8300/unistd.h~h8300-header-update include/asm-h8300/unistd.h
--- 25/include/asm-h8300/unistd.h~h8300-header-update	2005-04-12 03:21:27.925891520 -0700
+++ 25-akpm/include/asm-h8300/unistd.h	2005-04-12 03:21:27.930890760 -0700
@@ -310,163 +310,155 @@ do { \
 	return (type) (res); \
 } while (0)
 
-#define _syscall0(type, name)							\
-type name(void)									\
-{										\
-  register long __res __asm__("er0");						\
-  __asm__ __volatile__ ("mov.l	%1,er0\n\t"					\
-  			"trapa	#0\n\t"						\
-			: "=r" (__res)						\
-			: "ir" (__NR_##name)					\
-			: "cc");						\
-  if ((unsigned long)(__res) >= (unsigned long)(-125)) {			\
-    errno = -__res;								\
-    __res = -1;									\
-  }										\
-  return (type)__res;								\
-}
-
-#define _syscall1(type, name, atype, a)						\
-type name(atype a)								\
-{										\
-  register long __res __asm__("er0");						\
-  __asm__ __volatile__ ("mov.l	%2, er1\n\t"					\
-  			"mov.l	%1, er0\n\t"					\
-  			"trapa	#0\n\t"						\
-			: "=r" (__res)						\
-			: "ir" (__NR_##name),					\
-			  "g" ((long)a)						\
-			: "cc", "er1");					\
-  if ((unsigned long)(__res) >= (unsigned long)(-125)) {			\
-    errno = -__res;								\
-    __res = -1;									\
-  }										\
-  return (type)__res;								\
-}
-
-#define _syscall2(type, name, atype, a, btype, b)				\
-type name(atype a, btype b)							\
-{										\
-  register long __res __asm__("er0");						\
-  __asm__ __volatile__ ("mov.l	%3, er2\n\t"					\
-  			"mov.l	%2, er1\n\t"					\
-			"mov.l	%1, er0\n\t"					\
-  			"trapa	#0\n\t"						\
-			: "=r" (__res)						\
-			: "ir" (__NR_##name),					\
-			  "g" ((long)a),					\
-			  "g" ((long)b)						\
-			: "cc", "er1", "er2"); 				\
-  if ((unsigned long)(__res) >= (unsigned long)(-125)) {			\
-    errno = -__res;								\
-    __res = -1;									\
-  }										\
-  return (type)__res;								\
-}
-
-#define _syscall3(type, name, atype, a, btype, b, ctype, c)			\
-type name(atype a, btype b, ctype c)						\
-{										\
-  register long __res __asm__("er0");						\
-  __asm__ __volatile__ ("mov.l	%4, er3\n\t"					\
-			"mov.l	%3, er2\n\t"					\
-  			"mov.l	%2, er1\n\t"					\
-			"mov.l	%1, er0\n\t"					\
-  			"trapa	#0\n\t"						\
-			: "=r" (__res)						\
-			: "ir" (__NR_##name),					\
-			  "g" ((long)a),					\
-			  "g" ((long)b),					\
-			  "g" ((long)c)						\
-			: "cc", "er1", "er2", "er3");  			\
-  if ((unsigned long)(__res) >= (unsigned long)(-125)) {			\
-    errno = -__res;								\
-    __res = -1;									\
-  }										\
-  return (type)__res;								\
-}
-
-#define _syscall4(type, name, atype, a, btype, b, ctype, c, dtype, d)		\
-type name(atype a, btype b, ctype c, dtype d)					\
-{										\
-  register long __res __asm__("er0");						\
-  __asm__ __volatile__ ("mov.l	%5, er4\n\t"					\
-			"mov.l	%4, er3\n\t"					\
-			"mov.l	%3, er2\n\t"					\
-  			"mov.l	%2, er1\n\t"					\
-			"mov.l	%1, er0\n\t"					\
-  			"trapa	#0\n\t"						\
-			: "=r" (__res)						\
-			: "ir" (__NR_##name),					\
-			  "g" ((long)a),					\
-			  "g" ((long)b),					\
-			  "g" ((long)c),					\
-			  "g" ((long)d)						\
-			: "cc", "er1", "er2", "er3", "er4");			\
-  if ((unsigned long)(__res) >= (unsigned long)(-125)) {			\
-    errno = -__res;								\
-    __res = -1;									\
-  }										\
-  return (type)__res;								\
-}
-
-#define _syscall5(type, name, atype, a, btype, b, ctype, c, dtype, d, etype, e)	\
-type name(atype a, btype b, ctype c, dtype d, etype e)				\
-{										\
-  register long __res __asm__("er0");						\
-  __asm__ __volatile__ ("mov.l	%6, er5\n\t"					\
-			"mov.l	%5, er4\n\t"					\
-			"mov.l	%4, er3\n\t"					\
-			"mov.l	%3, er2\n\t"					\
-  			"mov.l	%2, er1\n\t"					\
-			"mov.l	%1, er0\n\t"					\
-  			"trapa	#0\n\t"						\
-			: "=r" (__res)						\
-			: "ir" (__NR_##name),					\
-			  "g" ((long)a),					\
-			  "g" ((long)b),					\
-			  "g" ((long)c),					\
-			  "g" ((long)d),					\
-			  "m" ((long)e)						\
-			: "cc", "er1", "er2", "er3", "er4", "er5");		\
-  if ((unsigned long)(__res) >= (unsigned long)(-125)) {		       	\
-    errno = -__res;								\
-    __res = -1;									\
-  }										\
-  return (type)__res;								\
-}
-		
-#define _syscall6(type, name, atype, a, btype, b, ctype, c, dtype, d,           \
-                              etype, e, ftype, f)	                        \
-type name(atype a, btype b, ctype c, dtype d, etype e, ftype f)			\
-{										\
-  register long __res __asm__("er0");						\
-  __asm__ __volatile__ ("mov.l	er6,@-sp\n\t"					\
-                        "mov.l	%7, er6\n\t"					\
-                        "mov.l	%6, er5\n\t"					\
-			"mov.l	%5, er4\n\t"					\
-			"mov.l	%4, er3\n\t"					\
-			"mov.l	%3, er2\n\t"					\
-  			"mov.l	%2, er1\n\t"					\
-			"mov.l	%1, er0\n\t"					\
-  			"trapa	#0\n\t"						\
-  			"mov.l	@sp+,er6"					\
-			: "=r" (__res)						\
-			: "ir" (__NR_##name),					\
-			  "g" ((long)a),					\
-			  "g" ((long)b),					\
-			  "g" ((long)c),					\
-			  "g" ((long)d),					\
-			  "m" ((long)e),					\
-			  "m" ((long)e)						\
-			: "cc", "er1", "er2", "er3", "er4", "er5");		\
-  if ((unsigned long)(__res) >= (unsigned long)(-125)) {		       	\
-    errno = -__res;								\
-    __res = -1;									\
-  }										\
-  return (type)__res;								\
+#define _syscall0(type, name)				\
+type name(void)						\
+{							\
+  register long __res __asm__("er0");			\
+  __asm__ __volatile__ ("mov.l %1,er0\n\t"		\
+                        "trapa	#0\n\t"			\
+			: "=r" (__res)			\
+			: "g" (__NR_##name)		\
+			: "cc", "memory");		\
+  __syscall_return(type, __res);			\
+}
+
+#define _syscall1(type, name, atype, a)			\
+type name(atype a)					\
+{							\
+  register long __res __asm__("er0");			\
+  register long _a __asm__("er1");			\
+  _a = (long)a;						\
+  __asm__ __volatile__ ("mov.l %1,er0\n\t"		\
+                        "trapa	#0\n\t"			\
+			: "=r" (__res)			\
+			: "g" (__NR_##name),		\
+			  "g" (_a)			\
+			: "cc", "memory");	 	\
+  __syscall_return(type, __res);			\
+}
+
+#define _syscall2(type, name, atype, a, btype, b)	\
+type name(atype a, btype b)				\
+{							\
+  register long __res __asm__("er0");			\
+  register long _a __asm__("er1");			\
+  register long _b __asm__("er2");			\
+  _a = (long)a;						\
+  _b = (long)b;						\
+  __asm__ __volatile__ ("mov.l %1,er0\n\t"		\
+                        "trapa	#0\n\t"			\
+			: "=r" (__res)			\
+			: "g" (__NR_##name),		\
+			  "g" (_a),			\
+			  "g" (_b)			\
+			: "cc", "memory");	 	\
+  __syscall_return(type, __res);			\
+}
+
+#define _syscall3(type, name, atype, a, btype, b, ctype, c)	\
+type name(atype a, btype b, ctype c)			\
+{							\
+  register long __res __asm__("er0");			\
+  register long _a __asm__("er1");			\
+  register long _b __asm__("er2");			\
+  register long _c __asm__("er3");			\
+  _a = (long)a;						\
+  _b = (long)b;						\
+  _c = (long)c;						\
+  __asm__ __volatile__ ("mov.l %1,er0\n\t"		\
+                        "trapa	#0\n\t"			\
+			: "=r" (__res)			\
+			: "g" (__NR_##name),		\
+			  "g" (_a),			\
+			  "g" (_b),			\
+			  "g" (_c)			\
+			: "cc", "memory");		\
+  __syscall_return(type, __res);			\
+}
+
+#define _syscall4(type, name, atype, a, btype, b,	\
+                  ctype, c, dtype, d)			\
+type name(atype a, btype b, ctype c, dtype d)		\
+{							\
+  register long __res __asm__("er0");			\
+  register long _a __asm__("er1");			\
+  register long _b __asm__("er2");			\
+  register long _c __asm__("er3");			\
+  register long _d __asm__("er4");			\
+  _a = (long)a;						\
+  _b = (long)b;						\
+  _c = (long)c;						\
+  _d = (long)d;						\
+  __asm__ __volatile__ ("mov.l	%1,er0\n\t"		\
+                        "trapa	#0\n\t"			\
+			: "=r" (__res)			\
+			: "g" (__NR_##name),		\
+			  "g" (_a),			\
+			  "g" (_b),			\
+			  "g" (_c),			\
+			  "g" (_d)			\
+			: "cc", "memory");		\
+  __syscall_return(type, __res);			\
+}
+
+#define _syscall5(type, name, atype, a, btype, b,	\
+                  ctype, c, dtype, d, etype, e)		\
+type name(atype a, btype b, ctype c, dtype d, etype e)	\
+{							\
+  register long __res __asm__("er0");			\
+  register long _a __asm__("er1");			\
+  register long _b __asm__("er2");			\
+  register long _c __asm__("er3");			\
+  register long _d __asm__("er4");			\
+  register long _e __asm__("er5");			\
+  _a = (long)a;                                       	\
+  _b = (long)b;                                       	\
+  _c = (long)c;                                       	\
+  _d = (long)d;                                       	\
+  _e = (long)e;                                       	\
+  __asm__ __volatile__ ("mov.l	%1,er0\n\t"		\
+                        "trapa	#0\n\t"			\
+			: "=r" (__res)			\
+			: "g" (__NR_##name),		\
+			  "g" (_a),			\
+			  "g" (_b),			\
+			  "g" (_c),			\
+			  "g" (_d),			\
+			  "g" (_e)			\
+			: "cc", "memory");		\
+  __syscall_return(type, __res);			\
+}
+
+#define _syscall6(type, name, atype, a, btype, b,	\
+                  ctype, c, dtype, d, etype, e, ftype, f)	\
+type name(atype a, btype b, ctype c, dtype d, etype e, ftype f)	\
+{							\
+  register long __res __asm__("er0");			\
+  register long _a __asm__("er1");			\
+  register long _b __asm__("er2");			\
+  register long _c __asm__("er3");			\
+  register long _d __asm__("er4");			\
+  register long _e __asm__("er5");			\
+  register long _f __asm__("er6");			\
+  _a = (long)a;                                       	\
+  _b = (long)b;                                       	\
+  _c = (long)c;                                       	\
+  _d = (long)d;                                       	\
+  _e = (long)e;                                       	\
+  _f = (long)f;                                       	\
+  __asm__ __volatile__ ("mov.l	%1,er0\n\t"		\
+                        "trapa	#0\n\t"			\
+			: "=r" (__res)			\
+			: "g" (__NR_##name),		\
+			  "g" (_a),			\
+			  "g" (_b),			\
+			  "g" (_c),			\
+			  "g" (_d),			\
+			  "g" (_e)			\
+			  "g" (_f)			\
+			: "cc", "memory");		\
+  __syscall_return(type, __res);			\
 }
-		
 
 #ifdef __KERNEL__
 #define __ARCH_WANT_IPC_PARSE_VERSION
_
