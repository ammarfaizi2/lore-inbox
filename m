Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267457AbTBXSSI>; Mon, 24 Feb 2003 13:18:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267344AbTBXSPp>; Mon, 24 Feb 2003 13:15:45 -0500
Received: from d06lmsgate-6.uk.ibm.com ([194.196.100.252]:33193 "EHLO
	d06lmsgate-6.uk.ibm.com") by vger.kernel.org with ESMTP
	id <S267289AbTBXSKM> convert rfc822-to-8bit; Mon, 24 Feb 2003 13:10:12 -0500
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] s390 (7/13): gcc 3.3 adaptions.
Date: Mon, 24 Feb 2003 19:10:51 +0100
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200302241910.51523.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

updates for compiling with gcc-3.3pre

- add -finline-limit=10000 to make it build
- drop .eh_frame elf section from vmlinux
- fix common warnings inn asm headers
- make dasd compile
- Don't warn about signed/unsigned comparisions
- fix inline syscall macros

diff -urN linux-2.5.62/arch/s390/Makefile linux-2.5.62-s390/arch/s390/Makefile
--- linux-2.5.62/arch/s390/Makefile	Mon Feb 17 23:56:00 2003
+++ linux-2.5.62-s390/arch/s390/Makefile	Mon Feb 24 18:24:21 2003
@@ -18,7 +18,7 @@
 LDFLAGS_vmlinux := -e start
 LDFLAGS_BLOB	:= --format binary --oformat elf32-s390
 
-CFLAGS += -pipe -fno-strength-reduce
+CFLAGS += -pipe -fno-strength-reduce -finline-limit=10000 -Wno-sign-compare
 
 head-y := arch/$(ARCH)/kernel/head.o arch/$(ARCH)/kernel/init_task.o
 
diff -urN linux-2.5.62/arch/s390/vmlinux.lds.S linux-2.5.62-s390/arch/s390/vmlinux.lds.S
--- linux-2.5.62/arch/s390/vmlinux.lds.S	Mon Feb 17 23:56:11 2003
+++ linux-2.5.62-s390/arch/s390/vmlinux.lds.S	Mon Feb 24 18:24:21 2003
@@ -64,6 +64,9 @@
   __setup_start = .;
   .init.setup : { *(.init.setup) }
   __setup_end = .;
+  __start___param = .;
+  __param : { *(__param) }
+  __stop___param = .;
   __initcall_start = .;
   .initcall.init : {
 	*(.initcall1.init) 
@@ -98,6 +101,7 @@
 	*(.exit.text)
 	*(.exit.data)
 	*(.exitcall.exit)
+	*(.eh_frame)
 	}
 
   /* Stabs debugging sections.  */
diff -urN linux-2.5.62/arch/s390x/Makefile linux-2.5.62-s390/arch/s390x/Makefile
--- linux-2.5.62/arch/s390x/Makefile	Mon Feb 17 23:56:15 2003
+++ linux-2.5.62-s390/arch/s390x/Makefile	Mon Feb 24 18:24:21 2003
@@ -19,7 +19,7 @@
 MODFLAGS += -fpic -D__PIC__
 LDFLAGS_BLOB	:= --format binary --oformat elf64-s390
 
-CFLAGS += -pipe -fno-strength-reduce
+CFLAGS += -pipe -fno-strength-reduce -finline-limit=10000 -Wno-sign-compare
 
 head-y := arch/$(ARCH)/kernel/head.o arch/$(ARCH)/kernel/init_task.o
 
diff -urN linux-2.5.62/arch/s390x/vmlinux.lds.S linux-2.5.62-s390/arch/s390x/vmlinux.lds.S
--- linux-2.5.62/arch/s390x/vmlinux.lds.S	Mon Feb 17 23:56:10 2003
+++ linux-2.5.62-s390/arch/s390x/vmlinux.lds.S	Mon Feb 24 18:24:21 2003
@@ -64,6 +64,9 @@
   __setup_start = .;
   .init.setup : { *(.init.setup) }
   __setup_end = .;
+  __start___param = .;
+  __param : { *(__param) }
+  __stop___param = .;
   __initcall_start = .;
   .initcall.init : {
 	*(.initcall1.init) 
@@ -98,6 +101,7 @@
 	*(.exit.text)
 	*(.exit.data)
 	*(.exitcall.exit)
+	*(.eh_frame)
 	}
 
   /* Stabs debugging sections.  */
diff -urN linux-2.5.62/drivers/s390/block/dasd_eckd.h linux-2.5.62-s390/drivers/s390/block/dasd_eckd.h
--- linux-2.5.62/drivers/s390/block/dasd_eckd.h	Mon Feb 17 23:56:13 2003
+++ linux-2.5.62-s390/drivers/s390/block/dasd_eckd.h	Mon Feb 24 18:24:21 2003
@@ -5,7 +5,7 @@
  * Bugreports.to..: <Linux390@de.ibm.com>
  * (C) IBM Corporation, IBM Deutschland Entwicklung GmbH, 1999,2000
  *
- * $Revision: 1.5 $
+ * $Revision: 1.6 $
  *
  * History of changes 
  * 
@@ -109,7 +109,7 @@
 		unsigned char cfw:1;	/* Cache fast write */
 		unsigned char dfw:1;	/* DASD fast write */
 	} __attribute__ ((packed)) attributes;
-	__u16 short blk_size;	/* Blocksize */
+	__u16 blk_size;		/* Blocksize */
 	__u16 fast_write_id;
 	__u8 ga_additional;	/* Global Attributes Additional */
 	__u8 ga_extended;	/* Global Attributes Extended	*/
diff -urN linux-2.5.62/include/asm-s390/bitops.h linux-2.5.62-s390/include/asm-s390/bitops.h
--- linux-2.5.62/include/asm-s390/bitops.h	Mon Feb 17 23:55:50 2003
+++ linux-2.5.62-s390/include/asm-s390/bitops.h	Mon Feb 24 18:24:21 2003
@@ -469,7 +469,7 @@
  * This routine doesn't need to be atomic.
  */
 
-static inline int __test_bit(int nr, volatile unsigned long *ptr)
+static inline int __test_bit(int nr, const volatile unsigned long *ptr)
 {
 	unsigned long addr;
 	unsigned char ch;
@@ -480,7 +480,7 @@
 }
 
 static inline int 
-__constant_test_bit(int nr, volatile unsigned long * addr) {
+__constant_test_bit(int nr, const volatile unsigned long * addr) {
     return (((volatile char *) addr)[(nr>>3)^3] & (1<<(nr&7))) != 0;
 }
 
diff -urN linux-2.5.62/include/asm-s390/idals.h linux-2.5.62-s390/include/asm-s390/idals.h
--- linux-2.5.62/include/asm-s390/idals.h	Mon Feb 17 23:55:52 2003
+++ linux-2.5.62-s390/include/asm-s390/idals.h	Mon Feb 24 18:24:21 2003
@@ -191,10 +191,10 @@
 __idal_buffer_is_needed(struct idal_buffer *ib)
 {
 #ifdef CONFIG_ARCH_S390X
-	return ib->size > (4096 << ib->page_order) ||
+	return ib->size > (4096ul << ib->page_order) ||
 		idal_is_needed(ib->data[0], ib->size);
 #else
-	return ib->size > (4096 << ib->page_order);
+	return ib->size > (4096ul << ib->page_order);
 #endif
 }
 
diff -urN linux-2.5.62/include/asm-s390/unistd.h linux-2.5.62-s390/include/asm-s390/unistd.h
--- linux-2.5.62/include/asm-s390/unistd.h	Mon Feb 24 18:18:38 2003
+++ linux-2.5.62-s390/include/asm-s390/unistd.h	Mon Feb 24 18:24:21 2003
@@ -266,27 +266,29 @@
 
 #define _syscall0(type,name)                                 \
 type name(void) {                                            \
-        register long __res asm("2");                        \
+        register long __svcres asm("2");                     \
+        long __res;                                          \
         __asm__ __volatile__ (                               \
                 "    svc %b1\n"                              \
-                "    lr  %0,2"                               \
-                : "=d" (__res)                               \
+                : "=d" (__svcres)                            \
                 : "i" (__NR_##name)                          \
                 : _svc_clobber );                            \
+	__res = __svcres;                                    \
         __syscall_return(type,__res);                        \
 }
 
 #define _syscall1(type,name,type1,arg1)                      \
 type name(type1 arg1) {                                      \
         register type1 __arg1 asm("2") = arg1;               \
-        register long __res asm("2");                        \
+        register long __svcres asm("2");                     \
+        long __res;                                          \
         __asm__ __volatile__ (                               \
                 "    svc %b1\n"                              \
-                "    lr  %0,2"                               \
-                : "=d" (__res)                               \
+                : "=d" (__svcres)                            \
                 : "i" (__NR_##name),                         \
                   "0" (__arg1)                               \
                 : _svc_clobber );                            \
+	__res = __svcres;                                    \
         __syscall_return(type,__res);                        \
 }
 
@@ -294,15 +296,16 @@
 type name(type1 arg1, type2 arg2) {                          \
         register type1 __arg1 asm("2") = arg1;               \
         register type2 __arg2 asm("3") = arg2;               \
-        register long __res asm("2");                        \
+        register long __svcres asm("2");                     \
+        long __res;                                          \
         __asm__ __volatile__ (                               \
                 "    svc %b1\n"                              \
-                "    lr  %0,2"                               \
-                : "=d" (__res)                               \
+                : "=d" (__svcres)                            \
                 : "i" (__NR_##name),                         \
                   "0" (__arg1),                              \
                   "d" (__arg2)                               \
                 : _svc_clobber );                            \
+	__res = __svcres;                                    \
         __syscall_return(type,__res);                        \
 }
 
@@ -311,16 +314,17 @@
         register type1 __arg1 asm("2") = arg1;               \
         register type2 __arg2 asm("3") = arg2;               \
         register type3 __arg3 asm("4") = arg3;               \
-        register long __res asm("2");                        \
+        register long __svcres asm("2");                     \
+        long __res;                                          \
         __asm__ __volatile__ (                               \
                 "    svc %b1\n"                              \
-                "    lr  %0,2"                               \
-                : "=d" (__res)                               \
+                : "=d" (__svcres)                            \
                 : "i" (__NR_##name),                         \
                   "0" (__arg1),                              \
                   "d" (__arg2),                              \
                   "d" (__arg3)                               \
                 : _svc_clobber );                            \
+	__res = __svcres;                                    \
         __syscall_return(type,__res);                        \
 }
 
@@ -331,17 +335,18 @@
         register type2 __arg2 asm("3") = arg2;               \
         register type3 __arg3 asm("4") = arg3;               \
         register type4 __arg4 asm("5") = arg4;               \
-        register long __res asm("2");                        \
+        register long __svcres asm("2");                     \
+        long __res;                                          \
         __asm__ __volatile__ (                               \
                 "    svc %b1\n"                              \
-                "    lr  %0,2"                               \
-                : "=d" (__res)                               \
+                : "=d" (__svcres)                            \
                 : "i" (__NR_##name),                         \
                   "0" (__arg1),                              \
                   "d" (__arg2),                              \
                   "d" (__arg3),                              \
                   "d" (__arg4)                               \
                 : _svc_clobber );                            \
+	__res = __svcres;                                    \
         __syscall_return(type,__res);                        \
 }
 
@@ -354,11 +359,11 @@
         register type3 __arg3 asm("4") = arg3;               \
         register type4 __arg4 asm("5") = arg4;               \
         register type5 __arg5 asm("6") = arg5;               \
-        register long __res asm("2");                        \
+        register long __svcres asm("2");                     \
+        long __res;                                          \
         __asm__ __volatile__ (                               \
                 "    svc %b1\n"                              \
-                "    lr  %0,2"                               \
-                : "=d" (__res)                               \
+                : "=d" (__svcres)                            \
                 : "i" (__NR_##name),                         \
                   "0" (__arg1),                              \
                   "d" (__arg2),                              \
@@ -366,6 +371,7 @@
                   "d" (__arg4),                              \
                   "d" (__arg5)                               \
                 : _svc_clobber );                            \
+	__res = __svcres;                                    \
         __syscall_return(type,__res);                        \
 }
 
diff -urN linux-2.5.62/include/asm-s390x/bitops.h linux-2.5.62-s390/include/asm-s390x/bitops.h
--- linux-2.5.62/include/asm-s390x/bitops.h	Mon Feb 17 23:56:59 2003
+++ linux-2.5.62-s390/include/asm-s390x/bitops.h	Mon Feb 24 18:24:21 2003
@@ -473,7 +473,7 @@
  * This routine doesn't need to be atomic.
  */
 
-static inline int __test_bit(unsigned long nr, volatile unsigned long *ptr)
+static inline int __test_bit(unsigned long nr, const volatile unsigned long *ptr)
 {
 	unsigned long addr;
 	unsigned char ch;
@@ -484,7 +484,7 @@
 }
 
 static inline int 
-__constant_test_bit(unsigned long nr, volatile unsigned long *addr) {
+__constant_test_bit(unsigned long nr, const volatile unsigned long *addr) {
     return (((volatile char *) addr)[(nr>>3)^7] & (1<<(nr&7))) != 0;
 }
 
diff -urN linux-2.5.62/include/asm-s390x/idals.h linux-2.5.62-s390/include/asm-s390x/idals.h
--- linux-2.5.62/include/asm-s390x/idals.h	Mon Feb 17 23:56:22 2003
+++ linux-2.5.62-s390/include/asm-s390x/idals.h	Mon Feb 24 18:24:21 2003
@@ -191,10 +191,10 @@
 __idal_buffer_is_needed(struct idal_buffer *ib)
 {
 #ifdef CONFIG_ARCH_S390X
-	return ib->size > (4096 << ib->page_order) ||
+	return ib->size > (4096ul << ib->page_order) ||
 		idal_is_needed(ib->data[0], ib->size);
 #else
-	return ib->size > (4096 << ib->page_order);
+	return ib->size > (4096ul << ib->page_order);
 #endif
 }
 
diff -urN linux-2.5.62/include/asm-s390x/unistd.h linux-2.5.62-s390/include/asm-s390x/unistd.h
--- linux-2.5.62/include/asm-s390x/unistd.h	Mon Feb 24 18:18:38 2003
+++ linux-2.5.62-s390/include/asm-s390x/unistd.h	Mon Feb 24 18:24:21 2003
@@ -233,27 +233,29 @@
 
 #define _syscall0(type,name)                                 \
 type name(void) {                                            \
-        register long __res asm("2");                        \
+        register long __svcres asm("2");                     \
+        long __res;                                          \
         __asm__ __volatile__ (                               \
                 "    svc %b1\n"                              \
-                "    lgr  %0,2"                              \
-                : "=d" (__res)                               \
+                : "=d" (__svcres)                            \
                 : "i" (__NR_##name)                          \
                 : _svc_clobber );                            \
+	__res = __svcres;                                    \
         __syscall_return(type,__res);                        \
 }
 
 #define _syscall1(type,name,type1,arg1)                      \
 type name(type1 arg1) {                                      \
         register type1 __arg1 asm("2") = arg1;               \
-        register long __res asm("2");                        \
+        register long __svcres asm("2");                     \
+        long __res;                                          \
         __asm__ __volatile__ (                               \
                 "    svc %b1\n"                              \
-                "    lgr  %0,2"                              \
-                : "=d" (__res)                               \
+                : "=d" (__svcres)                            \
                 : "i" (__NR_##name),                         \
                   "0" (__arg1)                               \
                 : _svc_clobber );                            \
+	__res = __svcres;                                    \
         __syscall_return(type,__res);                        \
 }
 
@@ -261,15 +263,16 @@
 type name(type1 arg1, type2 arg2) {                          \
         register type1 __arg1 asm("2") = arg1;               \
         register type2 __arg2 asm("3") = arg2;               \
-        register long __res asm("2");                        \
+        register long __svcres asm("2");                     \
+        long __res;                                          \
         __asm__ __volatile__ (                               \
                 "    svc %b1\n"                              \
-                "    lgr  %0,2"                              \
-                : "=d" (__res)                               \
+                : "=d" (__svcres)                            \
                 : "i" (__NR_##name),                         \
                   "0" (__arg1),                              \
                   "d" (__arg2)                               \
                 : _svc_clobber );                            \
+	__res = __svcres;                                    \
         __syscall_return(type,__res);                        \
 }
 
@@ -278,16 +281,17 @@
         register type1 __arg1 asm("2") = arg1;               \
         register type2 __arg2 asm("3") = arg2;               \
         register type3 __arg3 asm("4") = arg3;               \
-        register long __res asm("2");                        \
+        register long __svcres asm("2");                     \
+        long __res;                                          \
         __asm__ __volatile__ (                               \
                 "    svc %b1\n"                              \
-                "    lgr  %0,2"                              \
-                : "=d" (__res)                               \
+                : "=d" (__svcres)                            \
                 : "i" (__NR_##name),                         \
                   "0" (__arg1),                              \
                   "d" (__arg2),                              \
                   "d" (__arg3)                               \
                 : _svc_clobber );                            \
+	__res = __svcres;                                    \
         __syscall_return(type,__res);                        \
 }
 
@@ -298,17 +302,18 @@
         register type2 __arg2 asm("3") = arg2;               \
         register type3 __arg3 asm("4") = arg3;               \
         register type4 __arg4 asm("5") = arg4;               \
-        register long __res asm("2");                        \
+        register long __svcres asm("2");                     \
+        long __res;                                          \
         __asm__ __volatile__ (                               \
                 "    svc %b1\n"                              \
-                "    lgr  %0,2"                              \
-                : "=d" (__res)                               \
+                : "=d" (__svcres)                            \
                 : "i" (__NR_##name),                         \
                   "0" (__arg1),                              \
                   "d" (__arg2),                              \
                   "d" (__arg3),                              \
                   "d" (__arg4)                               \
                 : _svc_clobber );                            \
+	__res = __svcres;                                    \
         __syscall_return(type,__res);                        \
 }
 
@@ -321,11 +326,11 @@
         register type3 __arg3 asm("4") = arg3;               \
         register type4 __arg4 asm("5") = arg4;               \
         register type5 __arg5 asm("6") = arg5;               \
-        register long __res asm("2");                        \
+        register long __svcres asm("2");                     \
+        long __res;                                          \
         __asm__ __volatile__ (                               \
                 "    svc %b1\n"                              \
-                "    lgr  %0,2"                              \
-                : "=d" (__res)                               \
+                : "=d" (__svcres)                            \
                 : "i" (__NR_##name),                         \
                   "0" (__arg1),                              \
                   "d" (__arg2),                              \
@@ -333,6 +338,7 @@
                   "d" (__arg4),                              \
                   "d" (__arg5)                               \
                 : _svc_clobber );                            \
+	__res = __svcres;                                    \
         __syscall_return(type,__res);                        \
 }
 

