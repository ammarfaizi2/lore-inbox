Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264711AbSKRT0z>; Mon, 18 Nov 2002 14:26:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264797AbSKRT0m>; Mon, 18 Nov 2002 14:26:42 -0500
Received: from d12lmsgate-4.de.ibm.com ([194.196.100.237]:19927 "EHLO
	d12lmsgate-4.de.ibm.com") by vger.kernel.org with ESMTP
	id <S264711AbSKRTYw> convert rfc822-to-8bit; Mon, 18 Nov 2002 14:24:52 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] 2.5.48 s390 (8/16): gcc 3.2 fixes.
Date: Mon, 18 Nov 2002 20:20:20 +0100
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200211182020.20940.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make the kernel compile with gcc 3.2.

diff -urN linux-2.5.48/include/asm-s390/smp.h linux-2.5.48-s390/include/asm-s390/smp.h
--- linux-2.5.48/include/asm-s390/smp.h	Mon Nov 18 05:29:45 2002
+++ linux-2.5.48-s390/include/asm-s390/smp.h	Mon Nov 18 20:11:38 2002
@@ -29,7 +29,7 @@
 } sigp_info;
 
 extern volatile unsigned long cpu_online_map;
-extern unsigned long cpu_possible_map;
+extern volatile unsigned long cpu_possible_map;
 
 #define NO_PROC_ID		0xFF		/* No processor magic marker */
 
diff -urN linux-2.5.48/include/asm-s390/unistd.h linux-2.5.48-s390/include/asm-s390/unistd.h
--- linux-2.5.48/include/asm-s390/unistd.h	Mon Nov 18 20:11:15 2002
+++ linux-2.5.48-s390/include/asm-s390/unistd.h	Mon Nov 18 20:11:38 2002
@@ -258,11 +258,11 @@
         return (type) (res);                                 \
 } while (0)
 
-#define _svc_clobber "2", "cc", "memory"
+#define _svc_clobber "cc", "memory"
 
 #define _syscall0(type,name)                                 \
 type name(void) {                                            \
-        long __res;                                          \
+        register long __res asm("2");                        \
         __asm__ __volatile__ (                               \
                 "    svc %b1\n"                              \
                 "    lr  %0,2"                               \
@@ -275,13 +275,13 @@
 #define _syscall1(type,name,type1,arg1)                      \
 type name(type1 arg1) {                                      \
         register type1 __arg1 asm("2") = arg1;               \
-        long __res;                                          \
+        register long __res asm("2");                        \
         __asm__ __volatile__ (                               \
                 "    svc %b1\n"                              \
                 "    lr  %0,2"                               \
                 : "=d" (__res)                               \
                 : "i" (__NR_##name),                         \
-                  "d" (__arg1)                               \
+                  "0" (__arg1)                               \
                 : _svc_clobber );                            \
         __syscall_return(type,__res);                        \
 }
@@ -290,13 +290,13 @@
 type name(type1 arg1, type2 arg2) {                          \
         register type1 __arg1 asm("2") = arg1;               \
         register type2 __arg2 asm("3") = arg2;               \
-        long __res;                                          \
+        register long __res asm("2");                        \
         __asm__ __volatile__ (                               \
                 "    svc %b1\n"                              \
                 "    lr  %0,2"                               \
                 : "=d" (__res)                               \
                 : "i" (__NR_##name),                         \
-                  "d" (__arg1),                              \
+                  "0" (__arg1),                              \
                   "d" (__arg2)                               \
                 : _svc_clobber );                            \
         __syscall_return(type,__res);                        \
@@ -307,13 +307,13 @@
         register type1 __arg1 asm("2") = arg1;               \
         register type2 __arg2 asm("3") = arg2;               \
         register type3 __arg3 asm("4") = arg3;               \
-        long __res;                                          \
+        register long __res asm("2");                        \
         __asm__ __volatile__ (                               \
                 "    svc %b1\n"                              \
                 "    lr  %0,2"                               \
                 : "=d" (__res)                               \
                 : "i" (__NR_##name),                         \
-                  "d" (__arg1),                              \
+                  "0" (__arg1),                              \
                   "d" (__arg2),                              \
                   "d" (__arg3)                               \
                 : _svc_clobber );                            \
@@ -327,13 +327,13 @@
         register type2 __arg2 asm("3") = arg2;               \
         register type3 __arg3 asm("4") = arg3;               \
         register type4 __arg4 asm("5") = arg4;               \
-        long __res;                                          \
+        register long __res asm("2");                        \
         __asm__ __volatile__ (                               \
                 "    svc %b1\n"                              \
                 "    lr  %0,2"                               \
                 : "=d" (__res)                               \
                 : "i" (__NR_##name),                         \
-                  "d" (__arg1),                              \
+                  "0" (__arg1),                              \
                   "d" (__arg2),                              \
                   "d" (__arg3),                              \
                   "d" (__arg4)                               \
@@ -350,13 +350,13 @@
         register type3 __arg3 asm("4") = arg3;               \
         register type4 __arg4 asm("5") = arg4;               \
         register type5 __arg5 asm("6") = arg5;               \
-        long __res;                                          \
+        register long __res asm("2");                        \
         __asm__ __volatile__ (                               \
                 "    svc %b1\n"                              \
                 "    lr  %0,2"                               \
                 : "=d" (__res)                               \
                 : "i" (__NR_##name),                         \
-                  "d" (__arg1),                              \
+                  "0" (__arg1),                              \
                   "d" (__arg2),                              \
                   "d" (__arg3),                              \
                   "d" (__arg4),                              \
diff -urN linux-2.5.48/include/asm-s390x/unistd.h linux-2.5.48-s390/include/asm-s390x/unistd.h
--- linux-2.5.48/include/asm-s390x/unistd.h	Mon Nov 18 20:11:15 2002
+++ linux-2.5.48-s390/include/asm-s390x/unistd.h	Mon Nov 18 20:11:38 2002
@@ -225,11 +225,11 @@
         return (type) (res);                                 \
 } while (0)
 
-#define _svc_clobber "2", "cc", "memory"
+#define _svc_clobber "cc", "memory"
 
 #define _syscall0(type,name)                                 \
 type name(void) {                                            \
-        long __res;                                          \
+        register long __res asm("2");                        \
         __asm__ __volatile__ (                               \
                 "    svc %b1\n"                              \
                 "    lgr  %0,2"                              \
@@ -242,13 +242,13 @@
 #define _syscall1(type,name,type1,arg1)                      \
 type name(type1 arg1) {                                      \
         register type1 __arg1 asm("2") = arg1;               \
-        long __res;                                          \
+        register long __res asm("2");                        \
         __asm__ __volatile__ (                               \
                 "    svc %b1\n"                              \
                 "    lgr  %0,2"                              \
                 : "=d" (__res)                               \
                 : "i" (__NR_##name),                         \
-                  "d" (__arg1)                               \
+                  "0" (__arg1)                               \
                 : _svc_clobber );                            \
         __syscall_return(type,__res);                        \
 }
@@ -257,13 +257,13 @@
 type name(type1 arg1, type2 arg2) {                          \
         register type1 __arg1 asm("2") = arg1;               \
         register type2 __arg2 asm("3") = arg2;               \
-        long __res;                                          \
+        register long __res asm("2");                        \
         __asm__ __volatile__ (                               \
                 "    svc %b1\n"                              \
                 "    lgr  %0,2"                              \
                 : "=d" (__res)                               \
                 : "i" (__NR_##name),                         \
-                  "d" (__arg1),                              \
+                  "0" (__arg1),                              \
                   "d" (__arg2)                               \
                 : _svc_clobber );                            \
         __syscall_return(type,__res);                        \
@@ -274,13 +274,13 @@
         register type1 __arg1 asm("2") = arg1;               \
         register type2 __arg2 asm("3") = arg2;               \
         register type3 __arg3 asm("4") = arg3;               \
-        long __res;                                          \
+        register long __res asm("2");                        \
         __asm__ __volatile__ (                               \
                 "    svc %b1\n"                              \
                 "    lgr  %0,2"                              \
                 : "=d" (__res)                               \
                 : "i" (__NR_##name),                         \
-                  "d" (__arg1),                              \
+                  "0" (__arg1),                              \
                   "d" (__arg2),                              \
                   "d" (__arg3)                               \
                 : _svc_clobber );                            \
@@ -294,13 +294,13 @@
         register type2 __arg2 asm("3") = arg2;               \
         register type3 __arg3 asm("4") = arg3;               \
         register type4 __arg4 asm("5") = arg4;               \
-        long __res;                                          \
+        register long __res asm("2");                        \
         __asm__ __volatile__ (                               \
                 "    svc %b1\n"                              \
                 "    lgr  %0,2"                              \
                 : "=d" (__res)                               \
                 : "i" (__NR_##name),                         \
-                  "d" (__arg1),                              \
+                  "0" (__arg1),                              \
                   "d" (__arg2),                              \
                   "d" (__arg3),                              \
                   "d" (__arg4)                               \
@@ -317,13 +317,13 @@
         register type3 __arg3 asm("4") = arg3;               \
         register type4 __arg4 asm("5") = arg4;               \
         register type5 __arg5 asm("6") = arg5;               \
-        long __res;                                          \
+        register long __res asm("2");                        \
         __asm__ __volatile__ (                               \
                 "    svc %b1\n"                              \
                 "    lgr  %0,2"                              \
                 : "=d" (__res)                               \
                 : "i" (__NR_##name),                         \
-                  "d" (__arg1),                              \
+                  "0" (__arg1),                              \
                   "d" (__arg2),                              \
                   "d" (__arg3),                              \
                   "d" (__arg4),                              \

