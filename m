Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266609AbTBCOoR>; Mon, 3 Feb 2003 09:44:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266708AbTBCOoQ>; Mon, 3 Feb 2003 09:44:16 -0500
Received: from d06lmsgate-4.uk.ibm.com ([195.212.29.4]:64903 "EHLO
	d06lmsgate-4.uk.ibm.COM") by vger.kernel.org with ESMTP
	id <S266609AbTBCOmo>; Mon, 3 Feb 2003 09:42:44 -0500
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] s390 fixes (6/12).
Date: Mon, 3 Feb 2003 15:49:13 +0100
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200302031549.13658.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

updates for compiling with gcc-3.3pre

- add -finline-limit=10000 to make it build
- drop .eh_frame elf section from vmlinux
- fix common warnings inn asm headers
- make dasd compile
- Don't warn about signed/unsigned comparisions
diff -urN linux-2.5.59/arch/s390/Makefile linux-2.5.59-s390/arch/s390/Makefile
--- linux-2.5.59/arch/s390/Makefile	Fri Jan 17 03:21:42 2003
+++ linux-2.5.59-s390/arch/s390/Makefile	Mon Feb  3 15:07:19 2003
@@ -18,7 +18,7 @@
 LDFLAGS_vmlinux := -e start
 LDFLAGS_BLOB	:= --format binary --oformat elf32-s390
 
-CFLAGS += -pipe -fno-strength-reduce
+CFLAGS += -pipe -fno-strength-reduce -finline-limit=10000 -Wno-sign-compare
 
 HEAD := arch/$(ARCH)/kernel/head.o arch/$(ARCH)/kernel/init_task.o
 
diff -urN linux-2.5.59/arch/s390/vmlinux.lds.S 
linux-2.5.59-s390/arch/s390/vmlinux.lds.S
--- linux-2.5.59/arch/s390/vmlinux.lds.S	Fri Jan 17 03:22:01 2003
+++ linux-2.5.59-s390/arch/s390/vmlinux.lds.S	Mon Feb  3 15:07:19 2003
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
diff -urN linux-2.5.59/arch/s390x/Makefile 
linux-2.5.59-s390/arch/s390x/Makefile
--- linux-2.5.59/arch/s390x/Makefile	Fri Jan 17 03:22:13 2003
+++ linux-2.5.59-s390/arch/s390x/Makefile	Mon Feb  3 15:07:19 2003
@@ -19,7 +19,7 @@
 MODFLAGS += -fpic -D__PIC__
 LDFLAGS_BLOB	:= --format binary --oformat elf64-s390
 
-CFLAGS += -pipe -fno-strength-reduce
+CFLAGS += -pipe -fno-strength-reduce -finline-limit=10000 -Wno-sign-compare
 
 HEAD := arch/$(ARCH)/kernel/head.o arch/$(ARCH)/kernel/init_task.o
 
diff -urN linux-2.5.59/arch/s390x/vmlinux.lds.S 
linux-2.5.59-s390/arch/s390x/vmlinux.lds.S
--- linux-2.5.59/arch/s390x/vmlinux.lds.S	Fri Jan 17 03:21:50 2003
+++ linux-2.5.59-s390/arch/s390x/vmlinux.lds.S	Mon Feb  3 15:07:19 2003
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
diff -urN linux-2.5.59/drivers/s390/block/dasd_eckd.h 
linux-2.5.59-s390/drivers/s390/block/dasd_eckd.h
--- linux-2.5.59/drivers/s390/block/dasd_eckd.h	Fri Jan 17 03:22:03 2003
+++ linux-2.5.59-s390/drivers/s390/block/dasd_eckd.h	Mon Feb  3 15:07:19 2003
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
diff -urN linux-2.5.59/include/asm-s390/bitops.h 
linux-2.5.59-s390/include/asm-s390/bitops.h
--- linux-2.5.59/include/asm-s390/bitops.h	Fri Jan 17 03:21:36 2003
+++ linux-2.5.59-s390/include/asm-s390/bitops.h	Mon Feb  3 15:07:19 2003
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
 
diff -urN linux-2.5.59/include/asm-s390/idals.h 
linux-2.5.59-s390/include/asm-s390/idals.h
--- linux-2.5.59/include/asm-s390/idals.h	Fri Jan 17 03:21:38 2003
+++ linux-2.5.59-s390/include/asm-s390/idals.h	Mon Feb  3 15:07:19 2003
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
 
diff -urN linux-2.5.59/include/asm-s390x/bitops.h 
linux-2.5.59-s390/include/asm-s390x/bitops.h
--- linux-2.5.59/include/asm-s390x/bitops.h	Fri Jan 17 03:22:44 2003
+++ linux-2.5.59-s390/include/asm-s390x/bitops.h	Mon Feb  3 15:07:19 2003
@@ -473,7 +473,7 @@
  * This routine doesn't need to be atomic.
  */
 
-static inline int __test_bit(unsigned long nr, volatile unsigned long *ptr)
+static inline int __test_bit(unsigned long nr, const volatile unsigned long 
*ptr)
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
 
diff -urN linux-2.5.59/include/asm-s390x/idals.h 
linux-2.5.59-s390/include/asm-s390x/idals.h
--- linux-2.5.59/include/asm-s390x/idals.h	Fri Jan 17 03:22:22 2003
+++ linux-2.5.59-s390/include/asm-s390x/idals.h	Mon Feb  3 15:07:19 2003
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
 

