Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264404AbSIQRUQ>; Tue, 17 Sep 2002 13:20:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264406AbSIQRUQ>; Tue, 17 Sep 2002 13:20:16 -0400
Received: from d12lmsgate.de.ibm.com ([195.212.91.199]:60361 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id <S264404AbSIQRUN>; Tue, 17 Sep 2002 13:20:13 -0400
Content-Type: text/plain; charset=US-ASCII
From: Arnd Bergmann <arnd@bergmann-dalldorf.de>
To: Benjamin LaHaise <bcrl@redhat.com>, linux-aio@kvack.org
Subject: Re: libaio 0.3.92 test release
Date: Tue, 17 Sep 2002 19:25:32 +0200
User-Agent: KMail/1.4.3
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
References: <20020916221219.A22465@redhat.com>
In-Reply-To: <20020916221219.A22465@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200209171925.32381.arnd@bergmann-dalldorf.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 17 September 2002 04:12, Benjamin LaHaise wrote:

> linux-aio@kvack.org, it would be appreciated.  My hit list still
> includes getting ARM, PPC, S/390, SPARC and m68k support merged into
> libaio, so if anyone cares to provide patches, I'd appreciate it.  Cheers,

Hi,

I've been meaning to send this earlier, but somehow forgot about it.
Unfortunately, I have not been able to make all the test cases work,
but that might be because it used a patched 2.4-aa kernel, not the
latest 2.5.

	Arnd <><

diff -ur --new-file libaio-0.3.92-orig/libaio.spec libaio-0.3.92/libaio.spec
--- libaio-0.3.92-orig/libaio.spec	Sat Sep 14 01:57:13 2002
+++ libaio-0.3.92/libaio.spec	Tue Sep 17 10:58:29 2002
@@ -7,7 +7,7 @@
 Source: %{name}-%{version}.tar.gz
 BuildRoot: %{_tmppath}/%{name}-root
 # Fix ExclusiveArch as we implement this functionality on more architectures
-ExclusiveArch: i386 x86_64 ia64
+ExclusiveArch: i386 x86_64 ia64 s390 s390x
 
 %description
 The Linux-native asynchronous I/O facility ("async I/O", or "aio") has a
diff -ur --new-file libaio-0.3.92-orig/src/libaio.h libaio-0.3.92/src/libaio.h
--- libaio-0.3.92-orig/src/libaio.h	Tue Sep 17 00:45:18 2002
+++ libaio-0.3.92/src/libaio.h	Tue Sep 17 11:40:49 2002
@@ -51,6 +51,14 @@
 #define PADDED(x, y)	x, y
 #define PADDEDptr(x, y)	x
 #define PADDEDul(x, y)	unsigned long x
+#elif defined(__s390x__) /* big endian, 64 bits */
+#define PADDED(x, y)	unsigned y; x
+#define PADDEDptr(x,y)	x
+#define PADDEDul(x, y)	unsigned long x
+#elif defined(__s390__) /* big endian, 32 bits */
+#define PADDED(x, y)	unsigned y; x
+#define PADDEDptr(x, y) unsigned y; x
+#define PADDEDul(x, y)	unsigned y; unsigned long x
 #else
 #error	endian?
 #endif
diff -ur --new-file libaio-0.3.92-orig/src/syscall-s390.h libaio-0.3.92/src/syscall-s390.h
--- libaio-0.3.92-orig/src/syscall-s390.h	Thu Jan  1 01:00:00 1970
+++ libaio-0.3.92/src/syscall-s390.h	Tue Sep 17 11:43:47 2002
@@ -0,0 +1,119 @@
+#define __NR_io_setup		243
+#define __NR_io_destroy		244
+#define __NR_io_getevents	245
+#define __NR_io_submit		246
+#define __NR_io_cancel		247
+
+#define _svc_clobber "2", "cc", "memory"
+
+#ifdef __s390x__
+#define __LR "lgr " /* 64 bit load register */
+#else
+#define __LR "lr	" /* 32 bit load register */
+#endif
+
+#define io_syscall0(type,name)					\
+type name(void) {						\
+	long __res;						\
+	__asm__ __volatile__ (					\
+		"    svc %b1\n"					\
+		"    "__LR" %0,2"				\
+		: "=d" (__res)					\
+		: "i" (__NR_##name)				\
+		: _svc_clobber );				\
+	return (type) __res;					\
+}
+
+#define io_syscall1(type,name,type1,arg1)			\
+type name(type1 arg1) {						\
+	register type1 __arg1 asm("2") = arg1;			\
+	long __res;						\
+	__asm__ __volatile__ (					\
+		"    svc %b1\n"					\
+		"    "__LR" %0,2"				\
+		: "=d" (__res)					\
+		: "i" (__NR_##name),				\
+		  "d" (__arg1)					\
+		: _svc_clobber );				\
+	return (type) __res;					\
+}
+
+#define io_syscall2(type,name,type1,arg1,type2,arg2)		\
+type name(type1 arg1, type2 arg2) {				\
+	register type1 __arg1 asm("2") = arg1;			\
+	register type2 __arg2 asm("3") = arg2;			\
+	long __res;						\
+	__asm__ __volatile__ (					\
+		"    svc %b1\n"					\
+		"    "__LR" %0,2"				\
+		: "=d" (__res)					\
+		: "i" (__NR_##name),				\
+		  "d" (__arg1),					\
+		  "d" (__arg2)					\
+		: _svc_clobber );				\
+	return (type) __res;					\
+}
+
+#define io_syscall3(type,name,type1,arg1,type2,arg2,		\
+		    type3,arg3)					\
+type name(type1 arg1, type2 arg2, type3 arg3) {			\
+	register type1 __arg1 asm("2") = arg1;			\
+	register type2 __arg2 asm("3") = arg2;			\
+	register type3 __arg3 asm("4") = arg3;			\
+	long __res;						\
+	__asm__ __volatile__ (					\
+		"    svc %b1\n"					\
+		"    "__LR" %0,2"				\
+		: "=d" (__res)					\
+		: "i" (__NR_##name),				\
+		  "d" (__arg1),					\
+		  "d" (__arg2),					\
+		  "d" (__arg3)					\
+		: _svc_clobber );				\
+	return (type) __res;					\
+}
+
+#define io_syscall4(type,name,type1,arg1,type2,arg2,		\
+		    type3,arg3,type4,arg4)			\
+type name(type1 arg1, type2 arg2, type3 arg3, type4 arg4) {	\
+	register type1 __arg1 asm("2") = arg1;			\
+	register type2 __arg2 asm("3") = arg2;			\
+	register type3 __arg3 asm("4") = arg3;			\
+	register type4 __arg4 asm("5") = arg4;			\
+	long __res;						\
+	__asm__ __volatile__ (					\
+		"    svc %b1\n"					\
+		"    "__LR" %0,2"				\
+		: "=d" (__res)					\
+		: "i" (__NR_##name),				\
+		  "d" (__arg1),					\
+		  "d" (__arg2),					\
+		  "d" (__arg3),					\
+		  "d" (__arg4)					\
+		: _svc_clobber );				\
+	return (type) __res;					\
+}
+
+#define io_syscall5(type,name,type1,arg1,type2,arg2,		\
+		    type3,arg3,type4,arg4,type5,arg5)		\
+type name(type1 arg1, type2 arg2, type3 arg3, type4 arg4,	\
+	  type5 arg5) {						\
+	register type1 __arg1 asm("2") = arg1;			\
+	register type2 __arg2 asm("3") = arg2;			\
+	register type3 __arg3 asm("4") = arg3;			\
+	register type4 __arg4 asm("5") = arg4;			\
+	register type5 __arg5 asm("6") = arg5;			\
+	long __res;						\
+	__asm__ __volatile__ (					\
+		"    svc %b1\n"					\
+		"    "__LR" %0,2"				\
+		: "=d" (__res)					\
+		: "i" (__NR_##name),				\
+		  "d" (__arg1),					\
+		  "d" (__arg2),					\
+		  "d" (__arg3),					\
+		  "d" (__arg4),					\
+		  "d" (__arg5)					\
+		: _svc_clobber );				\
+	return (type) __res;					\
+}
diff -ur --new-file libaio-0.3.92-orig/src/syscall.h libaio-0.3.92/src/syscall.h
--- libaio-0.3.92-orig/src/syscall.h	Sat Sep 14 01:07:20 2002
+++ libaio-0.3.92/src/syscall.h	Tue Sep 17 10:46:54 2002
@@ -10,6 +10,8 @@
 #include "syscall-x86_64.h"
 #elif defined(__ia64__)
 #include "syscall-ia64.h"
+#elif defined(__s390__)
+#include "syscall-s390.h"
 #else
 #error "add syscall-arch.h"
 #endif

