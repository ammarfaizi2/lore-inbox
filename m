Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262862AbUEBAws@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262862AbUEBAws (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 May 2004 20:52:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262866AbUEBAws
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 May 2004 20:52:48 -0400
Received: from fw.osdl.org ([65.172.181.6]:25818 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262862AbUEBAwW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 May 2004 20:52:22 -0400
Date: Sat, 1 May 2004 17:51:34 -0700
From: Andrew Morton <akpm@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: bunk@fs.tum.de, eyal@eyal.emu.id.au, linux-dvb-maintainer@linuxtv.org,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-rc3: modular DVB tda1004x broken
Message-Id: <20040501175134.243b389c.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0405011653560.18014@ppc970.osdl.org>
References: <Pine.LNX.4.58.0404271858290.10799@ppc970.osdl.org>
	<408F9BD8.8000203@eyal.emu.id.au>
	<20040501201342.GL2541@fs.tum.de>
	<Pine.LNX.4.58.0405011536300.18014@ppc970.osdl.org>
	<20040501161035.67205a1f.akpm@osdl.org>
	<Pine.LNX.4.58.0405011653560.18014@ppc970.osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:
>
> So maybe a
> 
>  	#undef __syscall_return
>  	#define __syscall_return(type, res)	return (type)(res);
> 
>  inside the __KERNEL_SYSCALLS__ area?

It wasn't quite that simple - lots of architectures have been inventive.

For 2.6.6 we should just stick that errno decl back in there..


 25-akpm/include/asm-alpha/unistd.h     |    4 ++
 25-akpm/include/asm-arm/unistd.h       |    4 ++
 25-akpm/include/asm-arm26/unistd.h     |    4 ++
 25-akpm/include/asm-h8300/unistd.h     |    4 ++
 25-akpm/include/asm-i386/unistd.h      |    4 ++
 25-akpm/include/asm-m68k/unistd.h      |    4 ++
 25-akpm/include/asm-m68knommu/unistd.h |   45 ++++++---------------------
 25-akpm/include/asm-mips/unistd.h      |   55 +++++++++++----------------------
 25-akpm/include/asm-parisc/unistd.h    |   17 +++++++---
 25-akpm/include/asm-ppc/unistd.h       |   17 +++++++---
 25-akpm/include/asm-ppc64/unistd.h     |   17 +++++++---
 25-akpm/include/asm-s390/unistd.h      |    4 ++
 25-akpm/include/asm-sh/unistd.h        |    4 ++
 25-akpm/include/asm-sparc/unistd.h     |   40 +++++++++---------------
 25-akpm/include/asm-sparc64/unistd.h   |   40 +++++++++---------------
 25-akpm/include/asm-v850/unistd.h      |    5 ++-
 25-akpm/include/asm-x86_64/unistd.h    |    4 ++
 include/asm-cris/unistd.h              |    0 
 include/asm-ia64/unistd.h              |    0 
 include/asm-um/unistd.h                |    0 
 20 files changed, 138 insertions(+), 134 deletions(-)

diff -puN include/asm-i386/unistd.h~kernel-syscalls-retval-fix include/asm-i386/unistd.h
--- 25/include/asm-i386/unistd.h~kernel-syscalls-retval-fix	2004-05-01 17:04:04.998291624 -0700
+++ 25-akpm/include/asm-i386/unistd.h	2004-05-01 17:38:51.646072944 -0700
@@ -293,6 +293,9 @@
 
 /* user-visible error numbers are in the range -1 - -124: see <asm-i386/errno.h> */
 
+#ifdef __KERNEL__
+#define __syscall_return(type, res) return ((type)(res))
+#else
 #define __syscall_return(type, res) \
 do { \
 	if ((unsigned long)(res) >= (unsigned long)(-125)) { \
@@ -301,6 +304,7 @@ do { \
 	} \
 	return (type) (res); \
 } while (0)
+#endif
 
 /* XXX - _foo needs to be __foo, while __NR_bar could be _NR_bar. */
 #define _syscall0(type,name) \
diff -puN include/asm-alpha/unistd.h~kernel-syscalls-retval-fix include/asm-alpha/unistd.h
--- 25/include/asm-alpha/unistd.h~kernel-syscalls-retval-fix	2004-05-01 17:06:00.857678320 -0700
+++ 25-akpm/include/asm-alpha/unistd.h	2004-05-01 17:09:31.219698432 -0700
@@ -367,8 +367,12 @@
 
 #if defined(__GNUC__)
 
+#ifdef __KERNEL__
+#define _syscall_return(type)	return ((type) _sc_ret)
+#else
 #define _syscall_return(type)						\
 	return (_sc_err ? errno = _sc_ret, _sc_ret = -1L : 0), (type) _sc_ret
+#endif
 
 #define _syscall_clobbers						\
 	"$1", "$2", "$3", "$4", "$5", "$6", "$7", "$8",			\
diff -puN include/asm-arm26/unistd.h~kernel-syscalls-retval-fix include/asm-arm26/unistd.h
--- 25/include/asm-arm26/unistd.h~kernel-syscalls-retval-fix	2004-05-01 17:06:00.888673608 -0700
+++ 25-akpm/include/asm-arm26/unistd.h	2004-05-01 17:10:05.165537880 -0700
@@ -277,6 +277,9 @@
 #define __syscall(name) "swi\t" __sys1(__NR_##name) "\n\t"
 #endif
 
+#ifdef __KERNEL__
+#define __syscall_return(type, res) return ((type)(res))
+#else
 #define __syscall_return(type, res)					\
 do {									\
 	if ((unsigned long)(res) >= (unsigned long)(-125)) {		\
@@ -285,6 +288,7 @@ do {									\
 	}								\
 	return (type) (res);						\
 } while (0)
+#endif
 
 #define _syscall0(type,name)						\
 type name(void) {							\
diff -puN include/asm-arm/unistd.h~kernel-syscalls-retval-fix include/asm-arm/unistd.h
--- 25/include/asm-arm/unistd.h~kernel-syscalls-retval-fix	2004-05-01 17:06:00.917669200 -0700
+++ 25-akpm/include/asm-arm/unistd.h	2004-05-01 17:10:16.747777112 -0700
@@ -324,6 +324,9 @@
 #endif
 #endif
 
+#ifdef __KERNEL__
+#define __syscall_return(type, res) return ((type)(res))
+#else
 #define __syscall_return(type, res)					\
 do {									\
 	if ((unsigned long)(res) >= (unsigned long)(-125)) {		\
@@ -332,6 +335,7 @@ do {									\
 	}								\
 	return (type) (res);						\
 } while (0)
+#endif
 
 #define _syscall0(type,name)						\
 type name(void) {							\
diff -puN include/asm-cris/unistd.h~kernel-syscalls-retval-fix include/asm-cris/unistd.h
diff -puN include/asm-h8300/unistd.h~kernel-syscalls-retval-fix include/asm-h8300/unistd.h
--- 25/include/asm-h8300/unistd.h~kernel-syscalls-retval-fix	2004-05-01 17:06:00.971660992 -0700
+++ 25-akpm/include/asm-h8300/unistd.h	2004-05-01 17:10:55.685857624 -0700
@@ -276,6 +276,9 @@
 /* user-visible error numbers are in the range -1 - -122: see
    <asm-m68k/errno.h> */
 
+#ifdef __KERNEL__
+#define __syscall_return(type, res) return ((type)(res))
+#else
 #define __syscall_return(type, res) \
 do { \
 	if ((unsigned long)(res) >= (unsigned long)(-125)) { \
@@ -287,6 +290,7 @@ do { \
 	} \
 	return (type) (res); \
 } while (0)
+#endif
 
 #define _syscall0(type, name)							\
 type name(void)									\
diff -puN include/asm-ia64/unistd.h~kernel-syscalls-retval-fix include/asm-ia64/unistd.h
diff -puN include/asm-m68knommu/unistd.h~kernel-syscalls-retval-fix include/asm-m68knommu/unistd.h
--- 25/include/asm-m68knommu/unistd.h~kernel-syscalls-retval-fix	2004-05-01 17:06:01.069646096 -0700
+++ 25-akpm/include/asm-m68knommu/unistd.h	2004-05-01 17:14:51.502008120 -0700
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
@@ -248,11 +249,7 @@ type name(void)									\
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
@@ -267,11 +264,7 @@ type name(atype a)								\
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
@@ -288,11 +281,7 @@ type name(atype a, btype b)							\
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
@@ -311,11 +300,7 @@ type name(atype a, btype b, ctype c)				
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
@@ -337,11 +322,7 @@ type name(atype a, btype b, ctype c, dty
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
@@ -365,11 +346,7 @@ type name(atype a, btype b, ctype c, dty
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
 
 
diff -puN include/asm-m68k/unistd.h~kernel-syscalls-retval-fix include/asm-m68k/unistd.h
--- 25/include/asm-m68k/unistd.h~kernel-syscalls-retval-fix	2004-05-01 17:06:01.097641840 -0700
+++ 25-akpm/include/asm-m68k/unistd.h	2004-05-01 17:15:10.603104312 -0700
@@ -244,6 +244,9 @@
 /* user-visible error numbers are in the range -1 - -124: see
    <asm-m68k/errno.h> */
 
+#ifdef __KERNEL__
+#define __syscall_return(type, res) return ((type)(res))
+#else
 #define __syscall_return(type, res) \
 do { \
 	if ((unsigned long)(res) >= (unsigned long)(-125)) { \
@@ -255,6 +258,7 @@ do { \
 	} \
 	return (type) (res); \
 } while (0)
+#endif
 
 #define _syscall0(type,name) \
 type name(void) \
diff -puN include/asm-mips/unistd.h~kernel-syscalls-retval-fix include/asm-mips/unistd.h
--- 25/include/asm-mips/unistd.h~kernel-syscalls-retval-fix	2004-05-01 17:06:01.132636520 -0700
+++ 25-akpm/include/asm-mips/unistd.h	2004-05-01 17:18:02.541965632 -0700
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
@@ -837,10 +847,7 @@ type name(void) \
 	: "i" (__NR_##name) \
 	: "$2", "$8", "$9", "$10", "$11", "$12", "$13", "$14", "$15", "$24"); \
 	\
-	if (__a3 == 0) \
-		return (type) __v0; \
-	errno = __v0; \
-	return -1; \
+	__syscall_return(type, __v0) \
 }
 
 /*
@@ -864,10 +871,7 @@ type name(atype a) \
 	: "r" (__a0), "i" (__NR_##name) \
 	: "$2", "$8", "$9", "$10", "$11", "$12", "$13", "$14", "$15", "$24"); \
 	\
-	if (__a3 == 0) \
-		return (type) __v0; \
-	errno = __v0; \
-	return -1; \
+	__syscall_return(type, __v0) \
 }
 
 #define _syscall2(type,name,atype,a,btype,b) \
@@ -888,10 +892,7 @@ type name(atype a, btype b) \
 	: "r" (__a0), "r" (__a1), "i" (__NR_##name) \
 	: "$2", "$8", "$9", "$10", "$11", "$12", "$13", "$14", "$15", "$24"); \
 	\
-	if (__a3 == 0) \
-		return (type) __v0; \
-	errno = __v0; \
-	return -1; \
+	__syscall_return(type, __v0) \
 }
 
 #define _syscall3(type,name,atype,a,btype,b,ctype,c) \
@@ -913,10 +914,7 @@ type name(atype a, btype b, ctype c) \
 	: "r" (__a0), "r" (__a1), "r" (__a2), "i" (__NR_##name) \
 	: "$2", "$8", "$9", "$10", "$11", "$12", "$13", "$14", "$15", "$24"); \
 	\
-	if (__a3 == 0) \
-		return (type) __v0; \
-	errno = __v0; \
-	return -1; \
+	__syscall_return(type, __v0) \
 }
 
 #define _syscall4(type,name,atype,a,btype,b,ctype,c,dtype,d) \
@@ -938,10 +936,7 @@ type name(atype a, btype b, ctype c, dty
 	: "r" (__a0), "r" (__a1), "r" (__a2), "i" (__NR_##name) \
 	: "$2", "$8", "$9", "$10", "$11", "$12", "$13", "$14", "$15", "$24"); \
 	\
-	if (__a3 == 0) \
-		return (type) __v0; \
-	errno = __v0; \
-	return -1; \
+	__syscall_return(type, __v0) \
 }
 
 #if (_MIPS_SIM == _MIPS_SIM_ABI32)
@@ -974,10 +969,7 @@ type name(atype a, btype b, ctype c, dty
 	  "m" ((unsigned long)e) \
 	: "$2", "$8", "$9", "$10", "$11", "$12", "$13", "$14", "$15", "$24"); \
 	\
-	if (__a3 == 0) \
-		return (type) __v0; \
-	errno = __v0; \
-	return -1; \
+	__syscall_return(type, __v0) \
 }
 
 #define _syscall6(type,name,atype,a,btype,b,ctype,c,dtype,d,etype,e,ftype,f) \
@@ -1006,10 +998,7 @@ type name(atype a, btype b, ctype c, dty
 	  "m" ((unsigned long)e), "m" ((unsigned long)f) \
 	: "$2", "$8", "$9", "$10", "$11", "$12", "$13", "$14", "$15", "$24"); \
 	\
-	if (__a3 == 0) \
-		return (type) __v0; \
-	errno = __v0; \
-	return -1; \
+	__syscall_return(type, __v0) \
 }
 
 #endif /* (_MIPS_SIM == _MIPS_SIM_ABI32) */
@@ -1036,10 +1025,7 @@ type name (atype a,btype b,ctype c,dtype
 	: "r" (__a0), "r" (__a1), "r" (__a2), "i" (__NR_##name) \
 	: "$2","$9", "$10", "$11", "$12", "$13", "$14", "$15", "$24"); \
 	\
-	if (__a3 == 0) \
-		return (type) __v0; \
-	errno = __v0; \
-	return -1; \
+	__syscall_return(type, __v0) \
 }
 
 #define _syscall6(type,name,atype,a,btype,b,ctype,c,dtype,d,etype,e,ftype,f) \
@@ -1064,10 +1050,7 @@ type name (atype a,btype b,ctype c,dtype
 	  "i" (__NR_##name) \
 	: "$2","$9", "$10", "$11", "$12", "$13", "$14", "$15", "$24"); \
 	\
-	if (__a3 == 0) \
-		return (type) __v0; \
-	errno = __v0; \
-	return -1; \
+	__syscall_return(type, __v0) \
 }
 
 #endif /* (_MIPS_SIM == _MIPS_SIM_NABI32) || (_MIPS_SIM == _MIPS_SIM_ABI64) */
diff -puN include/asm-parisc/unistd.h~kernel-syscalls-retval-fix include/asm-parisc/unistd.h
--- 25/include/asm-parisc/unistd.h~kernel-syscalls-retval-fix	2004-05-01 17:06:01.161632112 -0700
+++ 25-akpm/include/asm-parisc/unistd.h	2004-05-01 17:20:18.759257456 -0700
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
diff -puN include/asm-ppc64/unistd.h~kernel-syscalls-retval-fix include/asm-ppc64/unistd.h
--- 25/include/asm-ppc64/unistd.h~kernel-syscalls-retval-fix	2004-05-01 17:06:01.187628160 -0700
+++ 25-akpm/include/asm-ppc64/unistd.h	2004-05-01 17:21:43.897314504 -0700
@@ -286,6 +286,17 @@
 
 #ifndef __ASSEMBLY__
 
+#ifdef __KERNEL__
+#define __syscall_return	/* */
+#else
+#define __syscall_return						\
+	if (__sc_err & 0x10000000)					\
+	{								\
+		errno = __sc_ret;					\
+		__sc_ret = -1;						\
+	}								\
+#endif
+
 /* On powerpc a system call basically clobbers the same registers like a
  * function call, with the exception of LR (which is needed for the
  * "sc; bnslr" sequence) and CR (where only CR0.SO is clobbered to signal
@@ -317,11 +328,7 @@
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
diff -puN include/asm-ppc/unistd.h~kernel-syscalls-retval-fix include/asm-ppc/unistd.h
--- 25/include/asm-ppc/unistd.h~kernel-syscalls-retval-fix	2004-05-01 17:06:01.222622840 -0700
+++ 25-akpm/include/asm-ppc/unistd.h	2004-05-01 17:22:19.506901024 -0700
@@ -277,6 +277,17 @@
 
 #define __NR(n)	#n
 
+#ifdef __KERNEL__
+#define __syscall_return	/* */
+#else
+#define __syscall_return						\
+	if (__sc_err & 0x10000000)					\
+	{								\
+		errno = __sc_ret;					\
+		__sc_ret = -1;						\
+	}								\
+#endif
+
 /* On powerpc a system call basically clobbers the same registers like a
  * function call, with the exception of LR (which is needed for the
  * "sc; bnslr" sequence) and CR (where only CR0.SO is clobbered to signal
@@ -307,11 +318,7 @@
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
diff -puN include/asm-s390/unistd.h~kernel-syscalls-retval-fix include/asm-s390/unistd.h
--- 25/include/asm-s390/unistd.h~kernel-syscalls-retval-fix	2004-05-01 17:06:01.253618128 -0700
+++ 25-akpm/include/asm-s390/unistd.h	2004-05-01 17:22:38.607997216 -0700
@@ -360,6 +360,9 @@
 
 /* user-visible error numbers are in the range -1 - -122: see <asm-s390/errno.h> */
 
+#ifdef __KERNEL__
+#define __syscall_return(type, res) return ((type)(res))
+#else
 #define __syscall_return(type, res)			     \
 do {							     \
 	if ((unsigned long)(res) >= (unsigned long)(-125)) { \
@@ -368,6 +371,7 @@ do {							     \
 	}						     \
 	return (type) (res);				     \
 } while (0)
+#endif
 
 #define _svc_clobber "1", "cc", "memory"
 
diff -puN include/asm-sh/unistd.h~kernel-syscalls-retval-fix include/asm-sh/unistd.h
--- 25/include/asm-sh/unistd.h~kernel-syscalls-retval-fix	2004-05-01 17:06:01.282613720 -0700
+++ 25-akpm/include/asm-sh/unistd.h	2004-05-01 17:22:57.037195552 -0700
@@ -286,6 +286,9 @@
 
 /* user-visible error numbers are in the range -1 - -124: see <asm-sh/errno.h> */
 
+#ifdef __KERNEL__
+#define __syscall_return(type, res) return ((type)(res))
+#else
 #define __syscall_return(type, res) \
 do { \
 	if ((unsigned long)(res) >= (unsigned long)(-124)) { \
@@ -297,6 +300,7 @@ do { \
 	} \
 	return (type) (res); \
 } while (0)
+#endif
 
 /* XXX - _foo needs to be __foo, while __NR_bar could be _NR_bar. */
 #define _syscall0(type,name) \
diff -puN include/asm-sparc64/unistd.h~kernel-syscalls-retval-fix include/asm-sparc64/unistd.h
--- 25/include/asm-sparc64/unistd.h~kernel-syscalls-retval-fix	2004-05-01 17:06:01.324607336 -0700
+++ 25-akpm/include/asm-sparc64/unistd.h	2004-05-01 17:25:32.979488720 -0700
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
@@ -314,10 +324,7 @@ __asm__ __volatile__ ("t 0x6d\n\t" \
 		      : "=r" (__res)\
 		      : "r" (__g1) \
 		      : "o0", "cc"); \
-if (__res >= 0) \
-    return (type) __res; \
-errno = -__res; \
-return -1; \
+	__syscall_return(type, __res) \
 }
 
 #define _syscall1(type,name,type1,arg1) \
@@ -332,10 +339,7 @@ __asm__ __volatile__ ("t 0x6d\n\t" \
 		      : "=r" (__res), "=&r" (__o0) \
 		      : "1" (__o0), "r" (__g1) \
 		      : "cc"); \
-if (__res >= 0) \
-	return (type) __res; \
-errno = -__res; \
-return -1; \
+	__syscall_return(type, __res) \
 }
 
 #define _syscall2(type,name,type1,arg1,type2,arg2) \
@@ -351,10 +355,7 @@ __asm__ __volatile__ ("t 0x6d\n\t" \
 		      : "=r" (__res), "=&r" (__o0) \
 		      : "1" (__o0), "r" (__o1), "r" (__g1) \
 		      : "cc"); \
-if (__res >= 0) \
-	return (type) __res; \
-errno = -__res; \
-return -1; \
+	__syscall_return(type, __res) \
 }
 
 #define _syscall3(type,name,type1,arg1,type2,arg2,type3,arg3) \
@@ -371,10 +372,7 @@ __asm__ __volatile__ ("t 0x6d\n\t" \
 		      : "=r" (__res), "=&r" (__o0) \
 		      : "1" (__o0), "r" (__o1), "r" (__o2), "r" (__g1) \
 		      : "cc"); \
-if (__res>=0) \
-	return (type) __res; \
-errno = -__res; \
-return -1; \
+	__syscall_return(type, __res) \
 }
 
 #define _syscall4(type,name,type1,arg1,type2,arg2,type3,arg3,type4,arg4) \
@@ -392,10 +390,7 @@ __asm__ __volatile__ ("t 0x6d\n\t" \
 		      : "=r" (__res), "=&r" (__o0) \
 		      : "1" (__o0), "r" (__o1), "r" (__o2), "r" (__o3), "r" (__g1) \
 		      : "cc"); \
-if (__res>=0) \
-	return (type) __res; \
-errno = -__res; \
-return -1; \
+	__syscall_return(type, __res) \
 } 
 
 #define _syscall5(type,name,type1,arg1,type2,arg2,type3,arg3,type4,arg4, \
@@ -415,10 +410,7 @@ __asm__ __volatile__ ("t 0x6d\n\t" \
 		      : "=r" (__res), "=&r" (__o0) \
 		      : "1" (__o0), "r" (__o1), "r" (__o2), "r" (__o3), "r" (__o4), "r" (__g1) \
 		      : "cc"); \
-if (__res>=0) \
-	return (type) __res; \
-errno = -__res; \
-return -1; \
+	__syscall_return(type, __res) \
 }
 #ifdef __KERNEL_SYSCALLS__
 
diff -puN include/asm-sparc/unistd.h~kernel-syscalls-retval-fix include/asm-sparc/unistd.h
--- 25/include/asm-sparc/unistd.h~kernel-syscalls-retval-fix	2004-05-01 17:06:01.360601864 -0700
+++ 25-akpm/include/asm-sparc/unistd.h	2004-05-01 17:26:55.061010432 -0700
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
@@ -315,10 +325,7 @@ __asm__ __volatile__ ("t 0x10\n\t" \
 		      : "=r" (__res)\
 		      : "r" (__g1) \
 		      : "o0", "cc"); \
-if (__res < -255 || __res >= 0) \
-    return (type) __res; \
-errno = -__res; \
-return -1; \
+	__syscall_return(type, __res) \
 }
 
 #define _syscall1(type,name,type1,arg1) \
@@ -335,10 +342,7 @@ __asm__ __volatile__ ("t 0x10\n\t" \
 		      : "=r" (__res), "=&r" (__o0) \
 		      : "1" (__o0), "r" (__g1) \
 		      : "cc"); \
-if (__res < -255 || __res >= 0) \
-	return (type) __res; \
-errno = -__res; \
-return -1; \
+	__syscall_return(type, __res) \
 }
 
 #define _syscall2(type,name,type1,arg1,type2,arg2) \
@@ -356,10 +360,7 @@ __asm__ __volatile__ ("t 0x10\n\t" \
 		      : "=r" (__res), "=&r" (__o0) \
 		      : "1" (__o0), "r" (__o1), "r" (__g1) \
 		      : "cc"); \
-if (__res < -255 || __res >= 0) \
-	return (type) __res; \
-errno = -__res; \
-return -1; \
+	__syscall_return(type, __res) \
 }
 
 #define _syscall3(type,name,type1,arg1,type2,arg2,type3,arg3) \
@@ -378,10 +379,7 @@ __asm__ __volatile__ ("t 0x10\n\t" \
 		      : "=r" (__res), "=&r" (__o0) \
 		      : "1" (__o0), "r" (__o1), "r" (__o2), "r" (__g1) \
 		      : "cc"); \
-if (__res < -255 || __res>=0) \
-	return (type) __res; \
-errno = -__res; \
-return -1; \
+	__syscall_return(type, __res) \
 }
 
 #define _syscall4(type,name,type1,arg1,type2,arg2,type3,arg3,type4,arg4) \
@@ -401,10 +399,7 @@ __asm__ __volatile__ ("t 0x10\n\t" \
 		      : "=r" (__res), "=&r" (__o0) \
 		      : "1" (__o0), "r" (__o1), "r" (__o2), "r" (__o3), "r" (__g1) \
 		      : "cc"); \
-if (__res < -255 || __res>=0) \
-	return (type) __res; \
-errno = -__res; \
-return -1; \
+	__syscall_return(type, __res) \
 } 
 
 #define _syscall5(type,name,type1,arg1,type2,arg2,type3,arg3,type4,arg4, \
@@ -426,10 +421,7 @@ __asm__ __volatile__ ("t 0x10\n\t" \
 		      : "=r" (__res), "=&r" (__o0) \
 		      : "1" (__o0), "r" (__o1), "r" (__o2), "r" (__o3), "r" (__o4), "r" (__g1) \
 		      : "cc"); \
-if (__res < -255 || __res>=0) \
-	return (type) __res; \
-errno = -__res; \
-return -1; \
+	__syscall_return(type, __res) \
 }
 #ifdef __KERNEL_SYSCALLS__
 
diff -puN include/asm-um/unistd.h~kernel-syscalls-retval-fix include/asm-um/unistd.h
diff -puN include/asm-v850/unistd.h~kernel-syscalls-retval-fix include/asm-v850/unistd.h
--- 25/include/asm-v850/unistd.h~kernel-syscalls-retval-fix	2004-05-01 17:06:01.415593504 -0700
+++ 25-akpm/include/asm-v850/unistd.h	2004-05-01 17:27:26.784187776 -0700
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
diff -puN include/asm-x86_64/unistd.h~kernel-syscalls-retval-fix include/asm-x86_64/unistd.h
--- 25/include/asm-x86_64/unistd.h~kernel-syscalls-retval-fix	2004-05-01 17:06:01.449588336 -0700
+++ 25-akpm/include/asm-x86_64/unistd.h	2004-05-01 17:27:40.526098688 -0700
@@ -560,6 +560,9 @@ __SYSCALL(__NR_mq_getsetattr, sys_mq_get
 
 #define __syscall_clobber "r11","rcx","memory" 
 
+#ifdef __KERNEL__
+#define __syscall_return(type, res) return ((type)(res))
+#else
 #define __syscall_return(type, res) \
 do { \
 	if ((unsigned long)(res) >= (unsigned long)(-127)) { \
@@ -568,6 +571,7 @@ do { \
 	} \
 	return (type) (res); \
 } while (0)
+#endif
 
 #ifndef __KERNEL_SYSCALLS__
 

_

