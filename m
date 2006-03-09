Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751631AbWCIXdU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751631AbWCIXdU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 18:33:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932116AbWCIXdU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 18:33:20 -0500
Received: from smtp-out.google.com ([216.239.45.12]:7670 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1751631AbWCIXdT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 18:33:19 -0500
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:
	x-accept-language:mime-version:to:cc:subject:content-type;
	b=IR9IXfX94e0qIvE3qt+ORV2JhiLuWTsjC41+pf3kdi+ifyzp+fgrdv4J9r9bLNro/
	tolfq7Gwmyr+KEYN4SMpA==
Message-ID: <4410BB32.1020905@google.com>
Date: Thu, 09 Mar 2006 15:33:06 -0800
From: Markus Gutschke <markus@google.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050923 Debian/1.7.12-0ubuntu05.04
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Daniel Kegel <dkegel@google.com>
Subject: [PATCH 1/1] x86: Make _syscallX() macros compile in PIC mode on i386
Content-Type: multipart/mixed;
 boundary="------------040207090002060208070706"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040207090002060208070706
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

From: Markus Gutschke <markus@google.com>

Gcc reserves %ebx when compiling position-independent-code on i386. This 
means, the _syscallX() macros in include/asm-i386/unistd.h will not 
compile. This patch is against 2.6.15.6 and adds a new set of macros 
which will be used in PIC mode. These macros take special care to 
preserve %ebx.

The bug can be tracked at http://bugzilla.kernel.org/show_bug.cgi?id=6204

Signed-off-by: Markus Gutschke <markus@google.com>

---

--------------040207090002060208070706
Content-Type: text/x-patch;
 name="i386-unistd.h.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="i386-unistd.h.diff"

--- linux/include/asm-i386/unistd.h.orig	2006-03-05 11:07:54.000000000 -0800
+++ linux/include/asm-i386/unistd.h	2006-03-09 14:25:45.000000000 -0800
@@ -326,6 +326,7 @@
 __syscall_return(type,__res); \
 }
 
+#ifndef __PIC__
 #define _syscall1(type,name,type1,arg1) \
 type name(type1 arg1) \
 { \
@@ -393,6 +394,82 @@
 __syscall_return(type,__res); \
 }
 
+#else /* __PIC__ */
+
+#define _syscall1(type,name,type1,arg1) \
+type name(type1 arg1) \
+{ \
+long __res; \
+__asm__ volatile ("push %%ebx ; movl %2,%%ebx ; int $0x80 ; pop %%ebx" \
+	: "=a" (__res) \
+	: "0" (__NR_##name),"ri" ((long)(arg1)) : "memory"); \
+__syscall_return(type,__res); \
+}
+
+#define _syscall2(type,name,type1,arg1,type2,arg2) \
+type name(type1 arg1,type2 arg2) \
+{ \
+long __res; \
+__asm__ volatile ("push %%ebx ; movl %2,%%ebx ; int $0x80 ; pop %%ebx" \
+	: "=a" (__res) \
+	: "0" (__NR_##name),"ri" ((long)(arg1)),"c" ((long)(arg2)) \
+	: "memory"); \
+__syscall_return(type,__res); \
+}
+
+#define _syscall3(type,name,type1,arg1,type2,arg2,type3,arg3) \
+type name(type1 arg1,type2 arg2,type3 arg3) \
+{ \
+long __res; \
+__asm__ volatile ("push %%ebx ; movl %2,%%ebx ; int $0x80 ; pop %%ebx" \
+	: "=a" (__res) \
+	: "0" (__NR_##name),"ri" ((long)(arg1)),"c" ((long)(arg2)), \
+		  "d" ((long)(arg3)) : "memory"); \
+__syscall_return(type,__res); \
+}
+
+#define _syscall4(type,name,type1,arg1,type2,arg2,type3,arg3,type4,arg4) \
+type name (type1 arg1, type2 arg2, type3 arg3, type4 arg4) \
+{ \
+long __res; \
+__asm__ volatile ("push %%ebx ; movl %2,%%ebx ; int $0x80 ; pop %%ebx" \
+	: "=a" (__res) \
+	: "0" (__NR_##name),"ri" ((long)(arg1)),"c" ((long)(arg2)), \
+	  "d" ((long)(arg3)),"S" ((long)(arg4)) : "memory"); \
+__syscall_return(type,__res); \
+} 
+
+#define _syscall5(type,name,type1,arg1,type2,arg2,type3,arg3,type4,arg4, \
+	  type5,arg5) \
+type name (type1 arg1,type2 arg2,type3 arg3,type4 arg4,type5 arg5) \
+{ \
+long __res; \
+__asm__ volatile ("push %%ebx ; movl %2,%%ebx ; movl %1,%%eax ; " \
+                  "int $0x80 ; pop %%ebx" \
+	: "=a" (__res) \
+	: "i" (__NR_##name),"ri" ((long)(arg1)),"c" ((long)(arg2)), \
+	  "d" ((long)(arg3)),"S" ((long)(arg4)),"D" ((long)(arg5)) \
+	: "memory"); \
+__syscall_return(type,__res); \
+}
+
+#define _syscall6(type,name,type1,arg1,type2,arg2,type3,arg3,type4,arg4, \
+	  type5,arg5,type6,arg6) \
+type name (type1 arg1,type2 arg2,type3 arg3,type4 arg4,type5 arg5,type6 arg6) \
+{ \
+long __res; \
+  struct { long __a1; long __a6; } __s = { (long)arg1, (long)arg6 }; \
+__asm__ volatile ("push %%ebp ; push %%ebx ; movl 4(%2),%%ebp ; " \
+                  "movl 0(%2),%%ebx ; movl %1,%%eax ; int $0x80 ; " \
+                  "pop %%ebx ;  pop %%ebp" \
+	: "=a" (__res) \
+	: "i" (__NR_##name),"0" ((long)(&__s)),"c" ((long)(arg2)), \
+	  "d" ((long)(arg3)),"S" ((long)(arg4)),"D" ((long)(arg5)) \
+	: "memory"); \
+__syscall_return(type,__res); \
+}
+#endif /* __PIC__ */
+
 #ifdef __KERNEL__
 #define __ARCH_WANT_IPC_PARSE_VERSION
 #define __ARCH_WANT_OLD_READDIR

--------------040207090002060208070706--
