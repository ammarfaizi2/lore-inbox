Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268526AbVBFAwf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268526AbVBFAwf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 19:52:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268225AbVBFAuF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 19:50:05 -0500
Received: from smtpout.mac.com ([17.250.248.83]:44241 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S267970AbVBFAn5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 19:43:57 -0500
In-Reply-To: <420523E0.9090603@zytor.com>
References: <20050130130308.GK3185@stusta.de> <m1pszn3t2w.fsf@muc.de> <41FCFED4.1070301@tiscali.de> <ctrtbe$570$1@terminus.zytor.com> <20050205135026.GC3129@stusta.de> <42051460.9060208@zytor.com> <20050205193813.GG3129@stusta.de> <420523E0.9090603@zytor.com>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <22CCE3FF-77D8-11D9-BD1C-000393ACC76E@mac.com>
Content-Transfer-Encoding: 7bit
Cc: Andrew Morton <akpm@osdl.org>, Adrian Bunk <bunk@stusta.de>,
       linux-kernel@vger.kernel.org
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: [RFC][PATCH-2.6] Clean up and merge compiler-*.h
Date: Sat, 5 Feb 2005 19:43:36 -0500
To: "H. Peter Anvin" <hpa@zytor.com>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I set up a sample patch to clean up and merge the compiler.h files, on 
the
basis that it's generally easier to manage all implementations of a 
single
compiler feature in the same file right next to each other, instead of
spread across 3 files.  This also cleans it up and puts the __KERNEL__
stuff in a single small section at the bottom, so as not to pollute the
user-space namespace.  This is also a precursor to several other patches
I'm working on to clean up and split out user-space available ABI from
the kernel headers in include/linux to include/linux-abi.

A sample new GCC feature test:
/*
  * __attribute__((__someattr__))			[GCC 3.3 or later]
  *   This will force the specified function to be inlined, or throw an
  *   error if inlining is impossible.  This is designed to be used
  *   where inlining is critical.  In the kernel, we want basically
  *   everything marked "inline" to be forced to inline, because 
otherwise
  *   the code is just plain wrong.
  */
#if (__GNUC__ > 3) || (__GNUC__ == 3 && __GNUC_MINOR__ >= 3)
# define __attribute_someattr__ __attribute__((__someattr__))
#else
# define __attribute_someattr__ /* unimplemented */
#endif

Signed-off-by: Kyle Moffett <mrmacman_g4@mac.com>

Index: linux-2.5/include/linux/compiler-gcc+.h
diff -u linux-2.5/include/linux/compiler-gcc+.h:1.5 
linux-2.5/include/linux/compiler-gcc+.h:removed
--- linux-2.5/include/linux/compiler-gcc+.h:1.5	Mon Aug 23 15:45:33 2004
+++ linux-2.5/include/linux/compiler-gcc+.h	Sat Feb  5 19:07:42 2005
@@ -1,16 +0,0 @@
-/* Never include this file directly.  Include <linux/compiler.h> 
instead.  */
-
-/*
- * These definitions are for Ueber-GCC: always newer than the latest
- * version and hence sporting everything plus a kitchen-sink.
- */
-#include <linux/compiler-gcc.h>
-
-#define inline			inline		__attribute__((always_inline))
-#define __inline__		__inline__	__attribute__((always_inline))
-#define __inline		__inline	__attribute__((always_inline))
-#define __deprecated		__attribute__((deprecated))
-#define __attribute_used__	__attribute__((__used__))
-#define __attribute_pure__	__attribute__((pure))
-#define __attribute_const__	__attribute__((__const__))
-#define __must_check 		__attribute__((warn_unused_result))
Index: linux-2.5/include/linux/compiler-gcc.h
diff -u linux-2.5/include/linux/compiler-gcc.h:1.2 
linux-2.5/include/linux/compiler-gcc.h:removed
--- linux-2.5/include/linux/compiler-gcc.h:1.2	Sun Sep 21 18:36:53 2003
+++ linux-2.5/include/linux/compiler-gcc.h	Sat Feb  5 19:08:02 2005
@@ -1,17 +0,0 @@
-/* Never include this file directly.  Include <linux/compiler.h> 
instead.  */
-
-/*
- * Common definitions for all gcc versions go here.
- */
-
-
-/* Optimization barrier */
-/* The "volatile" is due to gcc bugs */
-#define barrier() __asm__ __volatile__("": : :"memory")
-
-/* This macro obfuscates arithmetic on a variable address so that gcc
-   shouldn't recognize the original var, and make assumptions about it 
*/
-#define RELOC_HIDE(ptr, off)					\
-  ({ unsigned long __ptr;					\
-    __asm__ ("" : "=g"(__ptr) : "0"(ptr));		\
-    (typeof(ptr)) (__ptr + (off)); })
Index: linux-2.5/include/linux/compiler-gcc2.h
diff -u linux-2.5/include/linux/compiler-gcc2.h:1.3 
linux-2.5/include/linux/compiler-gcc2.h:removed
--- linux-2.5/include/linux/compiler-gcc2.h:1.3	Mon Jan 19 13:43:54 2004
+++ linux-2.5/include/linux/compiler-gcc2.h	Sat Feb  5 19:08:12 2005
@@ -1,24 +0,0 @@
-/* Never include this file directly.  Include <linux/compiler.h> 
instead.  */
-
-/* These definitions are for GCC v2.x.  */
-
-/* Somewhere in the middle of the GCC 2.96 development cycle, we 
implemented
-   a mechanism by which the user can annotate likely branch directions 
and
-   expect the blocks to be reordered appropriately.  Define 
__builtin_expect
-   to nothing for earlier compilers.  */
-#include <linux/compiler-gcc.h>
-
-#if __GNUC_MINOR__ < 96
-# define __builtin_expect(x, expected_value) (x)
-#endif
-
-#define __attribute_used__	__attribute__((__unused__))
-
-/*
- * The attribute `pure' is not implemented in GCC versions earlier
- * than 2.96.
- */
-#if __GNUC_MINOR__ >= 96
-# define __attribute_pure__	__attribute__((pure))
-# define __attribute_const__	__attribute__((__const__))
-#endif
Index: linux-2.5/include/linux/compiler-gcc3.h
diff -u linux-2.5/include/linux/compiler-gcc3.h:1.10 
linux-2.5/include/linux/compiler-gcc3.h:removed
--- linux-2.5/include/linux/compiler-gcc3.h:1.10	Wed Sep  8 11:00:28 
2004
+++ linux-2.5/include/linux/compiler-gcc3.h	Sat Feb  5 19:08:25 2005
@@ -1,34 +0,0 @@
-/* Never include this file directly.  Include <linux/compiler.h> 
instead.  */
-
-/* These definitions are for GCC v3.x.  */
-#include <linux/compiler-gcc.h>
-
-#if __GNUC_MINOR__ >= 1
-# define inline		inline		__attribute__((always_inline))
-# define __inline__	__inline__	__attribute__((always_inline))
-# define __inline	__inline	__attribute__((always_inline))
-#endif
-
-#if __GNUC_MINOR__ > 0
-# define __deprecated	__attribute__((deprecated))
-#endif
-
-#if __GNUC_MINOR__ >= 3
-# define __attribute_used__	__attribute__((__used__))
-#else
-# define __attribute_used__	__attribute__((__unused__))
-#endif
-
-#define __attribute_pure__	__attribute__((pure))
-#define __attribute_const__	__attribute__((__const__))
-
-#if __GNUC_MINOR__ >= 1
-#define  noinline __attribute__((noinline))
-#endif
-#if __GNUC_MINOR__ >= 4
-#define __must_check __attribute__((warn_unused_result))
-#endif
-
-#if __GNUC_MINOR__ >= 5
-#define __compiler_offsetof(a,b) __builtin_offsetof(a,b)
-#endif
Index: linux-2.5/include/linux/compiler-intel.h
diff -u linux-2.5/include/linux/compiler-intel.h:1.2 
linux-2.5/include/linux/compiler-intel.h:removed
--- linux-2.5/include/linux/compiler-intel.h:1.2	Sun Sep 21 18:36:53 
2003
+++ linux-2.5/include/linux/compiler-intel.h	Sat Feb  5 19:08:37 2005
@@ -1,24 +0,0 @@
-/* Never include this file directly.  Include <linux/compiler.h> 
instead.  */
-
-#ifdef __ECC
-
-/* Some compiler specific definitions are overwritten here
- * for Intel ECC compiler
- */
-
-#include <asm/intrinsics.h>
-
-/* Intel ECC compiler doesn't support gcc specific asm stmts.
- * It uses intrinsics to do the equivalent things.
- */
-#undef barrier
-#undef RELOC_HIDE
-
-#define barrier() __memory_barrier()
-
-#define RELOC_HIDE(ptr, off)					\
-  ({ unsigned long __ptr;					\
-     __ptr = (unsigned long) (ptr);				\
-    (typeof(ptr)) (__ptr + (off)); })
-
-#endif
Index: linux-2.5/include/linux/compiler.h
diff -u linux-2.5/include/linux/compiler.h:1.38 
linux-2.5/include/linux/compiler.h:1.39
--- linux-2.5/include/linux/compiler.h:1.38	Sat Oct 30 23:02:00 2004
+++ linux-2.5/include/linux/compiler.h	Sat Feb  5 19:06:05 2005
@@ -1,148 +1,246 @@
  #ifndef __LINUX_COMPILER_H
-#define __LINUX_COMPILER_H
-
+#define __LINUX_COMPILER_H 1
  #ifndef __ASSEMBLY__

+/* sparse "compile" */
  #ifdef __CHECKER__
-# define __user		__attribute__((noderef, address_space(1)))
-# define __kernel	/* default address space */
  # define __safe		__attribute__((safe))
  # define __force	__attribute__((force))
-# define __iomem	__attribute__((noderef, address_space(2)))
  # define __acquires(x)	__attribute__((context(0,1)))
  # define __releases(x)	__attribute__((context(1,0)))
  # define __acquire(x)	__context__(1)
  # define __release(x)	__context__(-1)
-# define __cond_lock(x)	((x) ? ({ __context__(1); 1; }) : 0)
-extern void __chk_user_ptr(void __user *);
-extern void __chk_io_ptr(void __iomem *);
+# define __cond_lock(x)	((x) ? ({ __context__(1); 1; }) : 0 )
+# ifdef __KERNEL__
+#  define __kernel	/* default address space */
+#  define __user	__attribute__((noderef, address_space(1)))
+#  define __iomem	__attribute__((noderef, address_space(2)))
+# else
+#  undef __kernel
+#  define __user	/* default address space */
+#  undef __iomem
+# endif
+
+/* normal compile */
  #else
-# define __user
-# define __kernel
+# define __builtin_warning(x, y...) (1)
  # define __safe
  # define __force
-# define __iomem
-# define __chk_user_ptr(x) (void)0
-# define __chk_io_ptr(x) (void)0
-# define __builtin_warning(x, y...) (1)
  # define __acquires(x)
  # define __releases(x)
  # define __acquire(x) (void)0
  # define __release(x) (void)0
-# define __cond_lock(x) (x)
+# define __cond_lock(x) ((x)?1:0)
+# ifdef __KERNEL__
+#  define __kernel
+#  define __user
+#  define __iomem
+# else
+#  undef __kernel
+#  define __user
+#  undef __iomem
+# endif
+#endif
+
+/* Basic address space checking */
+#ifdef __kernel
+static inline void __chk_kern_ptr (void __kernel *) {}
+#endif
+#ifdef __user
+static inline void __chk_user_ptr (void __user   *) {}
+#endif
+#ifdef __iomem
+static inline void __chk_io_ptr   (void __iomem  *) {}
  #endif

-#ifdef __KERNEL__

-#if __GNUC__ > 3
-# include <linux/compiler-gcc+.h>	/* catch-all for GCC 4, 5, etc. */
-#elif __GNUC__ == 3
-# include <linux/compiler-gcc3.h>
-#elif __GNUC__ == 2
-# include <linux/compiler-gcc2.h>
+
+/***************************
+ * Generic Compiler Checks *
+ ***************************/
+
+#if defined(__INTEL_COMPILER) && defined(__ECC)
+  /* Intel uses compiler intrinsics instead of inline asm */
+# include <asm/intrinsics.h>
+# define __ptr_obfusc(dst,src)	(void)( (dst) = (unsigned long)(src) )
+#elif __GNUC__ >= 2
+# define __memory_barrier()	__asm__ __volatile__("": : :"memory")
+# define __ptr_obfusc(dst,src)	__asm__("" : "=g"(__ptr) : "0"(ptr))
  #else
-# error Sorry, your compiler is too old/not recognized.
+# error "Unknown compiler!  Your compiler is either too old or not"
+# error "supported.  If you are willing to provide patches to make"
+# error "linux compile on your system and maintain them, then please"
+# error "post them to the LKML <linux-kernel@vger.kernel.org>"
  #endif

-/* Intel compiler defines __GNUC__. So we will overwrite 
implementations
- * coming from above header files here
+
+							
+/***************************
+ * Compiler Feature Checks *
+ ***************************/
+
+/*
+ * __builtin_expect(value,expected)		[GCC 2.96 or later]
+ *   This tells the compiler to optimize branching to favor one case 
over
+ *   another.  This may reorder the branches or insert branch 
prediction
+ *   instructions.
   */
-#ifdef __INTEL_COMPILER
-# include <linux/compiler-intel.h>
+#if (__GNUC__ > 2) || (__GNUC__ == 2 && __GNUC_MINOR__ >= 96)
+# define __expect(value,expected) __builtin_expect(value,expected)
+#else
+# define __expect(value,expected) (value)
  #endif

  /*
- * Generic compiler-dependent macros required for kernel
- * build go below this comment. Actual compiler/compiler version
- * specific implementations come from the above header files
+ * __attribute__((__unused__))			[All supported compilers]
+ *   This indicates that the corresponding variable or function is 
known
+ *   to be unused, therefore no warning should be emitted and the 
variable
+ *   or function may be omitted while optimizing.
   */
+#define __attribute_unused__ __attribute__((__unused__))

-#define likely(x)	__builtin_expect(!!(x), 1)
-#define unlikely(x)	__builtin_expect(!!(x), 0)
-
-/* Optimization barrier */
-#ifndef barrier
-# define barrier() __memory_barrier()
+/*
+ * __attribute__((__used__))			[GCC 3.3 or later]
+ *   This indicates that the corresponding variable or function is 
known
+ *   to be used, despite appearances (possibly by inline assembly), and
+ *   therefore it _must_ be emitted.  This also quiets related warnings
+ *   about that variable or function.
+ *
+ *   NOTE: GCC prior to 3.3 did not omit data, so the only need for 
this
+ *   there is to quiet the warning, in which case it behaves exactly 
the
+ *   same as __attribute__((__unused__)).
+ */
+#if (__GNUC__ > 3) || (__GNUC__ == 3 && __GNUC_MINOR__ >= 3)
+# define __attribute_used__ __attribute__((__used__))
+#else
+# define __attribute_used__ __attribute_unused__
  #endif

-#ifndef RELOC_HIDE
-# define RELOC_HIDE(ptr, off)					\
-  ({ unsigned long __ptr;					\
-     __ptr = (unsigned long) (ptr);				\
-    (typeof(ptr)) (__ptr + (off)); })
+/*
+ * __attribute__((__pure__))			[GCC 2.96 or later]
+ *   From the GCC manual:
+ *     Many functions have no effects except the return value and their
+ *     return value depends only on the parameters and/or global
+ *     variables.  Such a function can be subject to common 
subexpression
+ *     elimination and loop optimization just as an arithmetic operator
+ *     would be.
+ */
+#if (__GNUC__ > 2) || (__GNUC__ == 2 && __GNUC_MINOR__ >= 96)
+# define __attribute_pure__ __attribute__((__pure__))
+#else
+# define __attribute_pure__ /* unimplemented */
  #endif

-#endif /* __ASSEMBLY__ */
-
-#endif /* __KERNEL__ */
-
  /*
- * Allow us to mark functions as 'deprecated' and have gcc emit a nice
- * warning for each use, in hopes of speeding the functions removal.
- * Usage is:
- * 		int __deprecated foo(void)
+ * __attribute__((__const__))			[GCC 2.96 or later]
+ *   From the GCC manual:
+ *     Many functions do not examine any values except their arguments,
+ *     and have no effects except the return value.  Basically this is
+ *     just slightly more strict class than the `pure' attribute above,
+ *     since function is not allowed to read global memory.
+ *
+ *     Note that a function that has pointer arguments and examines the
+ *     data pointed to must _not_ be declared `const'.  Likewise, a
+ *     function that calls a non-`const' function usually must not be
+ *     `const'.  It does not make sense for a `const' function to 
return
+ *     `void'.
   */
-#ifndef __deprecated
-# define __deprecated		/* unimplemented */
+#if (__GNUC__ > 2) || (__GNUC__ == 2 && __GNUC_MINOR__ >= 96)
+# define __attribute_pure__ __attribute__((__pure__))
+#else
+# define __attribute_pure__ /* unimplemented */
  #endif

-#ifndef __must_check
-#define __must_check
+/*
+ * __attribute__((__always_inline__))		[GCC 3.1 or later]
+ *   This will force the specified function to be inlined, or throw an
+ *   error if inlining is impossible.  This is designed to be used
+ *   where inlining is critical.  In the kernel, we want basically
+ *   everything marked "inline" to be forced to inline, because 
otherwise
+ *   the code is just plain wrong.
+ */
+#if (__GNUC__ > 3) || (__GNUC__ == 3 && __GNUC_MINOR__ >= 1)
+# define __attribute_always_inline__ __attribute__((__always_inline__))
+#else
+# define __attribute_always_inline__ inline
  #endif

  /*
- * Allow us to avoid 'defined but not used' warnings on functions and 
data,
- * as well as force them to be emitted to the assembly file.
- *
- * As of gcc 3.3, static functions that are not marked with 
attribute((used))
- * may be elided from the assembly file.  As of gcc 3.3, static data 
not so
- * marked will not be elided, but this may change in a future gcc 
version.
- *
- * In prior versions of gcc, such functions and data would be emitted, 
but
- * would be warned about except with attribute((unused)).
+ * __attribute__((__noinline__))		[GCC 3.1 or later]
+ *   This will force the specified function remain uninlined.  This is
+ *   designed to be used where inlining would cause errors, such as in
+ *   certain places in the kernel.
   */
-#ifndef __attribute_used__
-# define __attribute_used__	/* unimplemented */
+#if (__GNUC__ > 3) || (__GNUC__ == 3 && __GNUC_MINOR__ >= 1)
+# define __attribute_noinline__ __attribute__((__noinline__))
+#else
+# define __attribute_noinline__ /* unimplemented */
  #endif

  /*
- * From the GCC manual:
- *
- * Many functions have no effects except the return value and their
- * return value depends only on the parameters and/or global
- * variables.  Such a function can be subject to common subexpression
- * elimination and loop optimization just as an arithmetic operator
- * would be.
- * [...]
+ * __attribute__((__deprecated__))		[GCC 3.1 or later]
+ *   This will cause the compiler to emit warnings whenever the 
function
+ *   or variable is used in non-deprecated code.  This should be used
+ *   whenever code is to be removed soon and we want to convert away 
all
+ *   old users of it.
   */
-#ifndef __attribute_pure__
-# define __attribute_pure__	/* unimplemented */
+#if (__GNUC__ > 3) || (__GNUC__ == 3 && __GNUC_MINOR__ >= 1)
+# define __attribute_deprecated__ __attribute__((__deprecated__))
+#else
+# define __attribute_deprecated__ /* unimplemented */
  #endif

  /*
- * From the GCC manual:
- *
- * Many functions do not examine any values except their arguments,
- * and have no effects except the return value.  Basically this is
- * just slightly more strict class than the `pure' attribute above,
- * since function is not allowed to read global memory.
- *
- * Note that a function that has pointer arguments and examines the
- * data pointed to must _not_ be declared `const'.  Likewise, a
- * function that calls a non-`const' function usually must not be
- * `const'.  It does not make sense for a `const' function to return
- * `void'.
+ * __attribute__((__warn_unused_result__))	[GCC 3.4 or later]
+ *   This will cause the compiler to emit warnings whenever the 
function
+ *   is used without its return value being checked or used.  This is
+ *   used to warn about unchecked error conditions in the kernel.
   */
-#ifndef __attribute_const__
-# define __attribute_const__	/* unimplemented */
+#if (__GNUC__ > 3) || (__GNUC__ == 3 && __GNUC_MINOR__ >= 4)
+# define __attribute_warn_unused_result__ 
__attribute__((__warn_unused_result__))
+#else
+# define __attribute_warn_unused_result__ /* unimplemented */
  #endif

-#ifndef noinline
-#define noinline
+/*
+ * __builtin_offsetof				[GCC 3.5 or later]
+ *   This returns the offset of a particular member in a given type
+ */
+#if (__GNUC__ > 3) || (__GNUC__ == 3 && __GNUC_MINOR__ >= 5)
+# define __offsetof(type,member) __builtin_offsetof(type,member)
+#else
+# define __offsetof(type,member) ((unsigned long) &((type *)0)->member)
  #endif

-#ifndef __always_inline
-#define __always_inline inline
-#endif
+/* Stuff only used by the linux kernel, including short names */
+#ifdef __KERNEL__
+
+/* Memory barrier */
+# define barrier() __memory_barrier()
+
+/* This macro obfuscates arithmetic on a variable address so the 
compiler
+   shouldn't recognize the original var and make assumptions about it 
*/
+# define RELOC_HIDE(ptr,off) ({		\
+	unsigned long __ptr;		\
+	__pointer_obfusc(__ptr,ptr);	\
+	(typeof(ptr)) (__ptr + (off));	\
+})
+
+/* These help optimize branch-prediction for the fast-paths */
+# define likely(x)	__builtin_expect(!!(x), 1)
+# define unlikely(x)	__builtin_expect(!!(x), 0)
+
+#define noinline	__attribute_noinline__
+#define __always_inline	__attribute_always_inline__
+#define __deprecated	__attribute_deprecated__
+#define __must_check	__attribute_warn_unused_result__
+#define inline		inline		__attribute_always_inline__
+#define __inline	__inline	__attribute_always_inline__
+#define __inline__	__inline__	__attribute_always_inline__
+#define offsetof(a,b)	__offsetof(a,b)
+
+#endif /* __KERNEL__ */
+
+#endif /* not __ASSEMBLY__ */
+#endif /* not __LINUX_COMPILER_H */

-#endif /* __LINUX_COMPILER_H */
Index: linux-2.5/include/linux/stddef.h
diff -u linux-2.5/include/linux/stddef.h:1.3 
linux-2.5/include/linux/stddef.h:1.4
--- linux-2.5/include/linux/stddef.h:1.3	Wed Sep  8 11:00:28 2004
+++ linux-2.5/include/linux/stddef.h	Sat Feb  5 19:06:05 2005
@@ -10,11 +10,4 @@
  #define NULL ((void *)0)
  #endif

-#undef offsetof
-#ifdef __compiler_offsetof
-#define offsetof(TYPE,MEMBER) __compiler_offsetof(TYPE,MEMBER)
-#else
-#define offsetof(TYPE, MEMBER) ((size_t) &((TYPE *)0)->MEMBER)
-#endif
-
  #endif

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a18 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  
!y?(-)
------END GEEK CODE BLOCK------


