Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264787AbUEERfW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264787AbUEERfW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 13:35:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264788AbUEERfW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 13:35:22 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:21652 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S264787AbUEEReg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 13:34:36 -0400
Date: Wed, 5 May 2004 10:33:58 -0700
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-rc3-mm2 [sparc, sparc64, mips syscall broken]
Message-Id: <20040505103358.5717d7ee.pj@sgi.com>
In-Reply-To: <20040505013135.7689e38d.akpm@osdl.org>
References: <20040505013135.7689e38d.akpm@osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

She doesn't build for sparc64 either (using crosstool).  And I'd
wager a pretty penny this applies to sparc and mips as well.

The patch kernel-syscalls-retval-fix.patch is missing a bunch of
semicolons.  Several lines that look like:

	__syscall_return(type, __res) \

should instead be:

	__syscall_return(type, __res); \

Here's the 2.6.6-rc3-mm2 kernel-syscalls-retval-fix.patch updated with
this change, for all three sparc, sparc64, and mips.  I am only able to
test build sparc64, and unable to test boot any of this.  With this
change, sparc64 built.

============================ snip ============================



Index: 2.6.6-rc3-mm2/include/asm-alpha/unistd.h
===================================================================
--- 2.6.6-rc3-mm2.orig/include/asm-alpha/unistd.h	2004-05-05 09:35:45.000000000 -0700
+++ 2.6.6-rc3-mm2/include/asm-alpha/unistd.h	2004-05-05 09:36:24.000000000 -0700
@@ -378,8 +378,12 @@
 
 #if defined(__GNUC__)
 
+#ifdef __KERNEL__
+#define _syscall_return(type)	return ((type) _sc_ret)
+#else
 #define _syscall_return(type)						\
 	return (_sc_err ? errno = _sc_ret, _sc_ret = -1L : 0), (type) _sc_ret
+#endif
 
 #define _syscall_clobbers						\
 	"$1", "$2", "$3", "$4", "$5", "$6", "$7", "$8",			\
Index: 2.6.6-rc3-mm2/include/asm-arm26/unistd.h
===================================================================
--- 2.6.6-rc3-mm2.orig/include/asm-arm26/unistd.h	2004-05-05 09:33:36.000000000 -0700
+++ 2.6.6-rc3-mm2/include/asm-arm26/unistd.h	2004-05-05 09:36:24.000000000 -0700
@@ -277,6 +277,9 @@
 #define __syscall(name) "swi\t" __sys1(__NR_##name) "\n\t"
 #endif
 
+#ifdef __KERNEL__
+#define __syscall_return(type, res) return ((type)(res))
+#else
 #define __syscall_return(type, res)					\
 do {									\
 	if ((unsigned long)(res) >= (unsigned long)(-125)) {		\
@@ -285,6 +288,7 @@
 	}								\
 	return (type) (res);						\
 } while (0)
+#endif
 
 #define _syscall0(type,name)						\
 type name(void) {							\
Index: 2.6.6-rc3-mm2/include/asm-arm/unistd.h
===================================================================
--- 2.6.6-rc3-mm2.orig/include/asm-arm/unistd.h	2004-05-05 09:33:34.000000000 -0700
+++ 2.6.6-rc3-mm2/include/asm-arm/unistd.h	2004-05-05 09:36:24.000000000 -0700
@@ -324,6 +324,9 @@
 #endif
 #endif
 
+#ifdef __KERNEL__
+#define __syscall_return(type, res) return ((type)(res))
+#else
 #define __syscall_return(type, res)					\
 do {									\
 	if ((unsigned long)(res) >= (unsigned long)(-125)) {		\
@@ -332,6 +335,7 @@
 	}								\
 	return (type) (res);						\
 } while (0)
+#endif
 
 #define _syscall0(type,name)						\
 type name(void) {							\
Index: 2.6.6-rc3-mm2/include/asm-h8300/unistd.h
===================================================================
--- 2.6.6-rc3-mm2.orig/include/asm-h8300/unistd.h	2004-05-05 09:33:42.000000000 -0700
+++ 2.6.6-rc3-mm2/include/asm-h8300/unistd.h	2004-05-05 09:36:24.000000000 -0700
@@ -276,6 +276,9 @@
 /* user-visible error numbers are in the range -1 - -122: see
    <asm-m68k/errno.h> */
 
+#ifdef __KERNEL__
+#define __syscall_return(type, res) return ((type)(res))
+#else
 #define __syscall_return(type, res) \
 do { \
 	if ((unsigned long)(res) >= (unsigned long)(-125)) { \
@@ -287,6 +290,7 @@
 	} \
 	return (type) (res); \
 } while (0)
+#endif
 
 #define _syscall0(type, name)							\
 type name(void)									\
Index: 2.6.6-rc3-mm2/include/asm-i386/unistd.h
===================================================================
--- 2.6.6-rc3-mm2.orig/include/asm-i386/unistd.h	2004-05-05 09:33:43.000000000 -0700
+++ 2.6.6-rc3-mm2/include/asm-i386/unistd.h	2004-05-05 09:36:24.000000000 -0700
@@ -293,6 +293,9 @@
 
 /* user-visible error numbers are in the range -1 - -124: see <asm-i386/errno.h> */
 
+#ifdef __KERNEL__
+#define __syscall_return(type, res) return ((type)(res))
+#else
 #define __syscall_return(type, res) \
 do { \
 	if ((unsigned long)(res) >= (unsigned long)(-125)) { \
@@ -301,6 +304,7 @@
 	} \
 	return (type) (res); \
 } while (0)
+#endif
 
 /* XXX - _foo needs to be __foo, while __NR_bar could be _NR_bar. */
 #define _syscall0(type,name) \
Index: 2.6.6-rc3-mm2/include/asm-m68knommu/unistd.h
===================================================================
--- 2.6.6-rc3-mm2.orig/include/asm-m68knommu/unistd.h	2004-05-05 09:33:46.000000000 -0700
+++ 2.6.6-rc3-mm2/include/asm-m68knommu/unistd.h	2004-05-05 09:36:24.000000000 -0700
@@ -226,17 +226,18 @@
 /* user-visible error numbers are in the range -1 - -122: see
    <asm-m68k/errno.h> */
 
+#ifdef __KERNEL__
+#define __syscall_return(type, res) return ((type)(res))
+#else
 #define __syscall_return(type, res) \
 do { \
 	if ((unsigned long)(res) >= (unsigned long)(-125)) { \
-	/* avoid using res which is declared to be in register d0; \
-	   errno might expand to a function call and clobber it.  */ \
-		int __err = -(res); \
-		errno = __err; \
+		errno = -(res); \
 		res = -1; \
 	} \
 	return (type) (res); \
 } while (0)
+#endif
 
 #define _syscall0(type, name)							\
 type name(void)									\
@@ -248,11 +249,7 @@
 			: "=g" (__res)						\
 			: "i" (__NR_##name)					\
 			: "cc", "%d0");						\
-  if ((unsigned long)(__res) >= (unsigned long)(-125)) {				\
-    errno = -__res;								\
-    __res = -1;									\
-  }										\
-  return (type)__res;								\
+  __syscall_return(type, __res);						\
 }
 
 #define _syscall1(type, name, atype, a)						\
@@ -267,11 +264,7 @@
 			: "i" (__NR_##name),					\
 			  "g" ((long)a)						\
 			: "cc", "%d0", "%d1");					\
-  if ((unsigned long)(__res) >= (unsigned long)(-125)) {				\
-    errno = -__res;								\
-    __res = -1;									\
-  }										\
-  return (type)__res;								\
+  __syscall_return(type, __res);						\
 }
 
 #define _syscall2(type, name, atype, a, btype, b)				\
@@ -288,11 +281,7 @@
 			  "a" ((long)a),					\
 			  "g" ((long)b)						\
 			: "cc", "%d0", "%d1", "%d2");				\
-  if ((unsigned long)(__res) >= (unsigned long)(-125)) {				\
-    errno = -__res;								\
-    __res = -1;									\
-  }										\
-  return (type)__res;								\
+  __syscall_return(type, __res);						\
 }
 
 #define _syscall3(type, name, atype, a, btype, b, ctype, c)			\
@@ -311,11 +300,7 @@
 			  "a" ((long)b),					\
 			  "g" ((long)c)						\
 			: "cc", "%d0", "%d1", "%d2", "%d3");			\
-  if ((unsigned long)(__res) >= (unsigned long)(-125)) {				\
-    errno = -__res;								\
-    __res = -1;									\
-  }										\
-  return (type)__res;								\
+  __syscall_return(type, __res);						\
 }
 
 #define _syscall4(type, name, atype, a, btype, b, ctype, c, dtype, d)		\
@@ -337,11 +322,7 @@
 			  "g" ((long)d)						\
 			: "cc", "%d0", "%d1", "%d2", "%d3",			\
 			  "%d4");						\
-  if ((unsigned long)(__res) >= (unsigned long)(-125)) {				\
-    errno = -__res;								\
-    __res = -1;									\
-  }										\
-  return (type)__res;								\
+  __syscall_return(type, __res);						\
 }
 
 #define _syscall5(type, name, atype, a, btype, b, ctype, c, dtype, d, etype, e)	\
@@ -365,11 +346,7 @@
 			  "g" ((long)e)						\
 			: "cc", "%d0", "%d1", "%d2", "%d3",			\
 			  "%d4", "%d5");					\
-  if ((unsigned long)(__res) >= (unsigned long)(-125)) {				\
-    errno = -__res;								\
-    __res = -1;									\
-  }										\
-  return (type)__res;								\
+  __syscall_return(type, __res);						\
 }
 
 
Index: 2.6.6-rc3-mm2/include/asm-m68k/unistd.h
===================================================================
--- 2.6.6-rc3-mm2.orig/include/asm-m68k/unistd.h	2004-05-05 09:33:46.000000000 -0700
+++ 2.6.6-rc3-mm2/include/asm-m68k/unistd.h	2004-05-05 09:36:24.000000000 -0700
@@ -244,6 +244,9 @@
 /* user-visible error numbers are in the range -1 - -124: see
    <asm-m68k/errno.h> */
 
+#ifdef __KERNEL__
+#define __syscall_return(type, res) return ((type)(res))
+#else
 #define __syscall_return(type, res) \
 do { \
 	if ((unsigned long)(res) >= (unsigned long)(-125)) { \
@@ -255,6 +258,7 @@
 	} \
 	return (type) (res); \
 } while (0)
+#endif
 
 #define _syscall0(type,name) \
 type name(void) \
Index: 2.6.6-rc3-mm2/include/asm-mips/unistd.h
===================================================================
--- 2.6.6-rc3-mm2.orig/include/asm-mips/unistd.h	2004-05-05 09:35:58.000000000 -0700
+++ 2.6.6-rc3-mm2/include/asm-mips/unistd.h	2004-05-05 09:36:24.000000000 -0700
@@ -820,6 +820,16 @@
 
 #ifndef __ASSEMBLY__
 
+#ifdef __KERNEL__
+#define __syscall_return(type, res) return ((type)(res))
+#else
+do { \
+	if (__a3 == 0) \
+		return (type)(res); \
+	errno = res; \
+	return -1; \
+} while (0)
+
 /* XXX - _foo needs to be __foo, while __NR_bar could be _NR_bar. */
 #define _syscall0(type,name) \
 type name(void) \
@@ -837,10 +847,7 @@
 	: "i" (__NR_##name) \
 	: "$2", "$8", "$9", "$10", "$11", "$12", "$13", "$14", "$15", "$24"); \
 	\
-	if (__a3 == 0) \
-		return (type) __v0; \
-	errno = __v0; \
-	return -1; \
+	__syscall_return(type, __v0); \
 }
 
 /*
@@ -864,10 +871,7 @@
 	: "r" (__a0), "i" (__NR_##name) \
 	: "$2", "$8", "$9", "$10", "$11", "$12", "$13", "$14", "$15", "$24"); \
 	\
-	if (__a3 == 0) \
-		return (type) __v0; \
-	errno = __v0; \
-	return -1; \
+	__syscall_return(type, __v0); \
 }
 
 #define _syscall2(type,name,atype,a,btype,b) \
@@ -888,10 +892,7 @@
 	: "r" (__a0), "r" (__a1), "i" (__NR_##name) \
 	: "$2", "$8", "$9", "$10", "$11", "$12", "$13", "$14", "$15", "$24"); \
 	\
-	if (__a3 == 0) \
-		return (type) __v0; \
-	errno = __v0; \
-	return -1; \
+	__syscall_return(type, __v0); \
 }
 
 #define _syscall3(type,name,atype,a,btype,b,ctype,c) \
@@ -913,10 +914,7 @@
 	: "r" (__a0), "r" (__a1), "r" (__a2), "i" (__NR_##name) \
 	: "$2", "$8", "$9", "$10", "$11", "$12", "$13", "$14", "$15", "$24"); \
 	\
-	if (__a3 == 0) \
-		return (type) __v0; \
-	errno = __v0; \
-	return -1; \
+	__syscall_return(type, __v0); \
 }
 
 #define _syscall4(type,name,atype,a,btype,b,ctype,c,dtype,d) \
@@ -938,10 +936,7 @@
 	: "r" (__a0), "r" (__a1), "r" (__a2), "i" (__NR_##name) \
 	: "$2", "$8", "$9", "$10", "$11", "$12", "$13", "$14", "$15", "$24"); \
 	\
-	if (__a3 == 0) \
-		return (type) __v0; \
-	errno = __v0; \
-	return -1; \
+	__syscall_return(type, __v0); \
 }
 
 #if (_MIPS_SIM == _MIPS_SIM_ABI32)
@@ -974,10 +969,7 @@
 	  "m" ((unsigned long)e) \
 	: "$2", "$8", "$9", "$10", "$11", "$12", "$13", "$14", "$15", "$24"); \
 	\
-	if (__a3 == 0) \
-		return (type) __v0; \
-	errno = __v0; \
-	return -1; \
+	__syscall_return(type, __v0); \
 }
 
 #define _syscall6(type,name,atype,a,btype,b,ctype,c,dtype,d,etype,e,ftype,f) \
@@ -1006,10 +998,7 @@
 	  "m" ((unsigned long)e), "m" ((unsigned long)f) \
 	: "$2", "$8", "$9", "$10", "$11", "$12", "$13", "$14", "$15", "$24"); \
 	\
-	if (__a3 == 0) \
-		return (type) __v0; \
-	errno = __v0; \
-	return -1; \
+	__syscall_return(type, __v0); \
 }
 
 #endif /* (_MIPS_SIM == _MIPS_SIM_ABI32) */
@@ -1036,10 +1025,7 @@
 	: "r" (__a0), "r" (__a1), "r" (__a2), "i" (__NR_##name) \
 	: "$2","$9", "$10", "$11", "$12", "$13", "$14", "$15", "$24"); \
 	\
-	if (__a3 == 0) \
-		return (type) __v0; \
-	errno = __v0; \
-	return -1; \
+	__syscall_return(type, __v0); \
 }
 
 #define _syscall6(type,name,atype,a,btype,b,ctype,c,dtype,d,etype,e,ftype,f) \
@@ -1064,10 +1050,7 @@
 	  "i" (__NR_##name) \
 	: "$2","$9", "$10", "$11", "$12", "$13", "$14", "$15", "$24"); \
 	\
-	if (__a3 == 0) \
-		return (type) __v0; \
-	errno = __v0; \
-	return -1; \
+	__syscall_return(type, __v0); \
 }
 
 #endif /* (_MIPS_SIM == _MIPS_SIM_NABI32) || (_MIPS_SIM == _MIPS_SIM_ABI64) */
Index: 2.6.6-rc3-mm2/include/asm-parisc/unistd.h
===================================================================
--- 2.6.6-rc3-mm2.orig/include/asm-parisc/unistd.h	2004-05-05 09:33:49.000000000 -0700
+++ 2.6.6-rc3-mm2/include/asm-parisc/unistd.h	2004-05-05 09:36:24.000000000 -0700
@@ -739,6 +739,17 @@
 
 #define SYS_ify(syscall_name)   __NR_##syscall_name
 
+#ifdef __KERNEL__
+#define __syscall_return __sys_res
+#else
+#define __syscall_return					\
+        if (__sys_res >= (unsigned long)-4095) {		\
+		errno = -__sys_res;				\
+                __sys_res = (unsigned long)-1;			\
+        }							\
+        __sys_res;						\
+#endif
+
 /* The system call number MUST ALWAYS be loaded in the delay slot of
    the ble instruction, or restarting system calls WILL NOT WORK.  See
    arch/parisc/kernel/signal.c - dhd, 2000-07-26 */
@@ -755,11 +766,7 @@
 			  );                                    \
                 __sys_res = __res;                              \
         }                                                       \
-        if (__sys_res >= (unsigned long)-4095) {                \
-		errno = -__sys_res;				\
-                __sys_res = (unsigned long)-1;                 \
-        }                                                       \
-        __sys_res;                                              \
+	__syscall_return					\
 })
 
 #define K_LOAD_ARGS_0()
Index: 2.6.6-rc3-mm2/include/asm-ppc64/unistd.h
===================================================================
--- 2.6.6-rc3-mm2.orig/include/asm-ppc64/unistd.h	2004-05-05 09:33:51.000000000 -0700
+++ 2.6.6-rc3-mm2/include/asm-ppc64/unistd.h	2004-05-05 09:36:24.000000000 -0700
@@ -286,6 +286,19 @@
 
 #ifndef __ASSEMBLY__
 
+#ifdef __KERNEL__
+#define __syscall_return						\
+	if (__sc_err & 0x10000000)					\
+		__sc_ret = - __sc_ret;
+#else
+#define __syscall_return						\
+	if (__sc_err & 0x10000000)					\
+	{								\
+		errno = __sc_ret;					\
+		__sc_ret = -1;						\
+	}
+#endif
+
 /* On powerpc a system call basically clobbers the same registers like a
  * function call, with the exception of LR (which is needed for the
  * "sc; bnslr" sequence) and CR (where only CR0.SO is clobbered to signal
@@ -317,11 +330,7 @@
 		__sc_ret = __sc_3;					\
 		__sc_err = __sc_0;					\
 	}								\
-	if (__sc_err & 0x10000000)					\
-	{								\
-		errno = __sc_ret;					\
-		__sc_ret = -1;						\
-	}								\
+	__syscall_return						\
 	return (type) __sc_ret
 
 #define __sc_loadargs_0(name, dummy...)					\
Index: 2.6.6-rc3-mm2/include/asm-ppc/unistd.h
===================================================================
--- 2.6.6-rc3-mm2.orig/include/asm-ppc/unistd.h	2004-05-05 09:33:49.000000000 -0700
+++ 2.6.6-rc3-mm2/include/asm-ppc/unistd.h	2004-05-05 09:36:24.000000000 -0700
@@ -277,6 +277,19 @@
 
 #define __NR(n)	#n
 
+#ifdef __KERNEL__
+#define __syscall_return						\
+	if (__sc_err & 0x10000000)					\
+		__sc_ret = - __sc_ret;
+#else
+#define __syscall_return						\
+	if (__sc_err & 0x10000000)					\
+	{								\
+		errno = __sc_ret;					\
+		__sc_ret = -1;						\
+	}
+#endif
+
 /* On powerpc a system call basically clobbers the same registers like a
  * function call, with the exception of LR (which is needed for the
  * "sc; bnslr" sequence) and CR (where only CR0.SO is clobbered to signal
@@ -307,11 +320,7 @@
 		__sc_ret = __sc_3;					\
 		__sc_err = __sc_0;					\
 	}								\
-	if (__sc_err & 0x10000000)					\
-	{								\
-		errno = __sc_ret;					\
-		__sc_ret = -1;						\
-	}								\
+	__syscall_return						\
 	return (type) __sc_ret
 
 #define __sc_loadargs_0(name, dummy...)					\
Index: 2.6.6-rc3-mm2/include/asm-s390/unistd.h
===================================================================
--- 2.6.6-rc3-mm2.orig/include/asm-s390/unistd.h	2004-05-05 09:35:45.000000000 -0700
+++ 2.6.6-rc3-mm2/include/asm-s390/unistd.h	2004-05-05 09:36:24.000000000 -0700
@@ -360,6 +360,9 @@
 
 /* user-visible error numbers are in the range -1 - -122: see <asm-s390/errno.h> */
 
+#ifdef __KERNEL__
+#define __syscall_return(type, res) return ((type)(res))
+#else
 #define __syscall_return(type, res)			     \
 do {							     \
 	if ((unsigned long)(res) >= (unsigned long)(-125)) { \
@@ -368,6 +371,7 @@
 	}						     \
 	return (type) (res);				     \
 } while (0)
+#endif
 
 #define _svc_clobber "1", "cc", "memory"
 
Index: 2.6.6-rc3-mm2/include/asm-sh/unistd.h
===================================================================
--- 2.6.6-rc3-mm2.orig/include/asm-sh/unistd.h	2004-05-05 09:33:51.000000000 -0700
+++ 2.6.6-rc3-mm2/include/asm-sh/unistd.h	2004-05-05 09:36:24.000000000 -0700
@@ -286,6 +286,9 @@
 
 /* user-visible error numbers are in the range -1 - -124: see <asm-sh/errno.h> */
 
+#ifdef __KERNEL__
+#define __syscall_return(type, res) return ((type)(res))
+#else
 #define __syscall_return(type, res) \
 do { \
 	if ((unsigned long)(res) >= (unsigned long)(-124)) { \
@@ -297,6 +300,7 @@
 	} \
 	return (type) (res); \
 } while (0)
+#endif
 
 /* XXX - _foo needs to be __foo, while __NR_bar could be _NR_bar. */
 #define _syscall0(type,name) \
Index: 2.6.6-rc3-mm2/include/asm-sparc64/unistd.h
===================================================================
--- 2.6.6-rc3-mm2.orig/include/asm-sparc64/unistd.h	2004-05-05 09:33:53.000000000 -0700
+++ 2.6.6-rc3-mm2/include/asm-sparc64/unistd.h	2004-05-05 10:02:44.000000000 -0700
@@ -303,6 +303,16 @@
  *          find a free slot in the 0-282 range.
  */
 
+#ifdef __KERNEL__
+#define __syscall_return(type, res) return ((type)(res))
+#else
+#define __syscall_return(type, res)		\
+	if (res >= 0)				\
+		return (type)res;		\
+	errno = -res;				\
+	return -1;
+#endif
+
 #define _syscall0(type,name) \
 type name(void) \
 { \
@@ -314,10 +324,7 @@
 		      : "=r" (__res)\
 		      : "r" (__g1) \
 		      : "o0", "cc"); \
-if (__res >= 0) \
-    return (type) __res; \
-errno = -__res; \
-return -1; \
+	__syscall_return(type, __res); \
 }
 
 #define _syscall1(type,name,type1,arg1) \
@@ -332,10 +339,7 @@
 		      : "=r" (__res), "=&r" (__o0) \
 		      : "1" (__o0), "r" (__g1) \
 		      : "cc"); \
-if (__res >= 0) \
-	return (type) __res; \
-errno = -__res; \
-return -1; \
+	__syscall_return(type, __res); \
 }
 
 #define _syscall2(type,name,type1,arg1,type2,arg2) \
@@ -351,10 +355,7 @@
 		      : "=r" (__res), "=&r" (__o0) \
 		      : "1" (__o0), "r" (__o1), "r" (__g1) \
 		      : "cc"); \
-if (__res >= 0) \
-	return (type) __res; \
-errno = -__res; \
-return -1; \
+	__syscall_return(type, __res); \
 }
 
 #define _syscall3(type,name,type1,arg1,type2,arg2,type3,arg3) \
@@ -371,10 +372,7 @@
 		      : "=r" (__res), "=&r" (__o0) \
 		      : "1" (__o0), "r" (__o1), "r" (__o2), "r" (__g1) \
 		      : "cc"); \
-if (__res>=0) \
-	return (type) __res; \
-errno = -__res; \
-return -1; \
+	__syscall_return(type, __res); \
 }
 
 #define _syscall4(type,name,type1,arg1,type2,arg2,type3,arg3,type4,arg4) \
@@ -392,10 +390,7 @@
 		      : "=r" (__res), "=&r" (__o0) \
 		      : "1" (__o0), "r" (__o1), "r" (__o2), "r" (__o3), "r" (__g1) \
 		      : "cc"); \
-if (__res>=0) \
-	return (type) __res; \
-errno = -__res; \
-return -1; \
+	__syscall_return(type, __res); \
 } 
 
 #define _syscall5(type,name,type1,arg1,type2,arg2,type3,arg3,type4,arg4, \
@@ -415,10 +410,7 @@
 		      : "=r" (__res), "=&r" (__o0) \
 		      : "1" (__o0), "r" (__o1), "r" (__o2), "r" (__o3), "r" (__o4), "r" (__g1) \
 		      : "cc"); \
-if (__res>=0) \
-	return (type) __res; \
-errno = -__res; \
-return -1; \
+	__syscall_return(type, __res); \
 }
 #ifdef __KERNEL_SYSCALLS__
 
Index: 2.6.6-rc3-mm2/include/asm-sparc/unistd.h
===================================================================
--- 2.6.6-rc3-mm2.orig/include/asm-sparc/unistd.h	2004-05-05 09:33:52.000000000 -0700
+++ 2.6.6-rc3-mm2/include/asm-sparc/unistd.h	2004-05-05 10:02:24.000000000 -0700
@@ -302,6 +302,16 @@
  *          find a free slot in the 0-282 range.
  */
 
+#ifdef __KERNEL__
+#define __syscall_return(type, res) return ((type)(res))
+#else
+#define __syscall_return(type, res)		\
+	if (res < -255 || res >= 0)		\
+		return (type)res;		\
+	errno = -res;				\
+	return -1;
+#endif
+
 #define _syscall0(type,name) \
 type name(void) \
 { \
@@ -315,10 +325,7 @@
 		      : "=r" (__res)\
 		      : "r" (__g1) \
 		      : "o0", "cc"); \
-if (__res < -255 || __res >= 0) \
-    return (type) __res; \
-errno = -__res; \
-return -1; \
+	__syscall_return(type, __res); \
 }
 
 #define _syscall1(type,name,type1,arg1) \
@@ -335,10 +342,7 @@
 		      : "=r" (__res), "=&r" (__o0) \
 		      : "1" (__o0), "r" (__g1) \
 		      : "cc"); \
-if (__res < -255 || __res >= 0) \
-	return (type) __res; \
-errno = -__res; \
-return -1; \
+	__syscall_return(type, __res); \
 }
 
 #define _syscall2(type,name,type1,arg1,type2,arg2) \
@@ -356,10 +360,7 @@
 		      : "=r" (__res), "=&r" (__o0) \
 		      : "1" (__o0), "r" (__o1), "r" (__g1) \
 		      : "cc"); \
-if (__res < -255 || __res >= 0) \
-	return (type) __res; \
-errno = -__res; \
-return -1; \
+	__syscall_return(type, __res); \
 }
 
 #define _syscall3(type,name,type1,arg1,type2,arg2,type3,arg3) \
@@ -378,10 +379,7 @@
 		      : "=r" (__res), "=&r" (__o0) \
 		      : "1" (__o0), "r" (__o1), "r" (__o2), "r" (__g1) \
 		      : "cc"); \
-if (__res < -255 || __res>=0) \
-	return (type) __res; \
-errno = -__res; \
-return -1; \
+	__syscall_return(type, __res); \
 }
 
 #define _syscall4(type,name,type1,arg1,type2,arg2,type3,arg3,type4,arg4) \
@@ -401,10 +399,7 @@
 		      : "=r" (__res), "=&r" (__o0) \
 		      : "1" (__o0), "r" (__o1), "r" (__o2), "r" (__o3), "r" (__g1) \
 		      : "cc"); \
-if (__res < -255 || __res>=0) \
-	return (type) __res; \
-errno = -__res; \
-return -1; \
+	__syscall_return(type, __res); \
 } 
 
 #define _syscall5(type,name,type1,arg1,type2,arg2,type3,arg3,type4,arg4, \
@@ -426,10 +421,7 @@
 		      : "=r" (__res), "=&r" (__o0) \
 		      : "1" (__o0), "r" (__o1), "r" (__o2), "r" (__o3), "r" (__o4), "r" (__g1) \
 		      : "cc"); \
-if (__res < -255 || __res>=0) \
-	return (type) __res; \
-errno = -__res; \
-return -1; \
+	__syscall_return(type, __res); \
 }
 #ifdef __KERNEL_SYSCALLS__
 
Index: 2.6.6-rc3-mm2/include/asm-v850/unistd.h
===================================================================
--- 2.6.6-rc3-mm2.orig/include/asm-v850/unistd.h	2004-05-05 09:33:54.000000000 -0700
+++ 2.6.6-rc3-mm2/include/asm-v850/unistd.h	2004-05-05 09:36:24.000000000 -0700
@@ -245,6 +245,9 @@
 #define __builtin_expect(x, expected_value) (x)
 #endif
 
+#ifdef __KERNEL__
+#define __syscall_return(type, res) return ((type)(res))
+#else
 #define __syscall_return(type, res)					      \
   do {									      \
 	  /* user-visible error numbers are in the range -1 - -124:	      \
@@ -255,7 +258,7 @@
 	  }								      \
 	  return (type) (res);						      \
   } while (0)
-
+#endif
 
 #define _syscall0(type, name)						      \
 type name (void)							      \
Index: 2.6.6-rc3-mm2/include/asm-x86_64/unistd.h
===================================================================
--- 2.6.6-rc3-mm2.orig/include/asm-x86_64/unistd.h	2004-05-05 09:35:55.000000000 -0700
+++ 2.6.6-rc3-mm2/include/asm-x86_64/unistd.h	2004-05-05 09:36:24.000000000 -0700
@@ -560,6 +560,9 @@
 
 #define __syscall_clobber "r11","rcx","memory" 
 
+#ifdef __KERNEL__
+#define __syscall_return(type, res) return ((type)(res))
+#else
 #define __syscall_return(type, res) \
 do { \
 	if ((unsigned long)(res) >= (unsigned long)(-127)) { \
@@ -568,6 +571,7 @@
 	} \
 	return (type) (res); \
 } while (0)
+#endif
 
 #ifndef __KERNEL_SYSCALLS__
 
============================ snip ============================


-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
