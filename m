Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265250AbTBCTyL>; Mon, 3 Feb 2003 14:54:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265081AbTBCTxT>; Mon, 3 Feb 2003 14:53:19 -0500
Received: from d12lmsgate-4.de.ibm.com ([194.196.100.237]:60634 "EHLO
	d12lmsgate-4.de.ibm.com") by vger.kernel.org with ESMTP
	id <S265895AbTBCTwh> convert rfc822-to-8bit; Mon, 3 Feb 2003 14:52:37 -0500
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH, =?iso-8859-1?q?B=F6blingen?=
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] s390 fixes (12/12).
Date: Mon, 3 Feb 2003 20:48:24 +0100
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200302032048.24470.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

trivial s390 fixes
diff -urN linux-2.5.59/arch/s390/kernel/setup.c linux-2.5.59-s390/arch/s390/kernel/setup.c
--- linux-2.5.59/arch/s390/kernel/setup.c	Fri Jan 17 03:21:38 2003
+++ linux-2.5.59-s390/arch/s390/kernel/setup.c	Mon Feb  3 20:50:22 2003
@@ -551,7 +551,7 @@
 
 static void *c_start(struct seq_file *m, loff_t *pos)
 {
-	return *pos <= NR_CPUS ? (void *)((unsigned long) *pos + 1) : NULL;
+	return *pos < NR_CPUS ? (void *)((unsigned long) *pos + 1) : NULL;
 }
 static void *c_next(struct seq_file *m, void *v, loff_t *pos)
 {
diff -urN linux-2.5.59/arch/s390x/kernel/setup.c linux-2.5.59-s390/arch/s390x/kernel/setup.c
--- linux-2.5.59/arch/s390x/kernel/setup.c	Fri Jan 17 03:22:02 2003
+++ linux-2.5.59-s390/arch/s390x/kernel/setup.c	Mon Feb  3 20:50:22 2003
@@ -545,7 +545,7 @@
 
 static void *c_start(struct seq_file *m, loff_t *pos)
 {
-	return *pos <= NR_CPUS ? (void *)((unsigned long) *pos + 1) : NULL;
+	return *pos < NR_CPUS ? (void *)((unsigned long) *pos + 1) : NULL;
 }
 static void *c_next(struct seq_file *m, void *v, loff_t *pos)
 {
diff -urN linux-2.5.59/fs/partitions/ibm.c linux-2.5.59-s390/fs/partitions/ibm.c
--- linux-2.5.59/fs/partitions/ibm.c	Fri Jan 17 03:22:56 2003
+++ linux-2.5.59-s390/fs/partitions/ibm.c	Mon Feb  3 20:50:22 2003
@@ -91,6 +91,11 @@
 	EBCASC(type, 4);
 	EBCASC(name, 6);
 
+/* FIXME: this no longer works.
+	if(name[0] != '\0')
+		register_disk_label(hd, name);
+*/
+
 	/*
 	 * Three different types: CMS1, VOL1 and LNX1/unlabeled
 	 */
diff -urN linux-2.5.59/include/asm-s390/spinlock.h linux-2.5.59-s390/include/asm-s390/spinlock.h
--- linux-2.5.59/include/asm-s390/spinlock.h	Fri Jan 17 03:23:01 2003
+++ linux-2.5.59-s390/include/asm-s390/spinlock.h	Mon Feb  3 20:50:22 2003
@@ -122,4 +122,17 @@
                      : "+m" ((rw)->lock) : "a" (&(rw)->lock) \
 		     : "2", "3", "cc" )
 
+extern inline int _raw_write_trylock(rwlock_t *rw)
+{
+	unsigned int result, reg;
+	
+	__asm__ __volatile__("   lhi  %0,1\n"
+			     "   sll  %0,31\n"
+			     "   basr %1,0\n"
+			     "0: cs   %0,%1,0(%3)\n"
+			     : "=&d" (result), "=&d" (reg), "+m" (rw->lock)
+			     : "a" (&rw->lock) : "cc" );
+	return !result;
+}
+
 #endif /* __ASM_SPINLOCK_H */
diff -urN linux-2.5.59/include/asm-s390x/spinlock.h linux-2.5.59-s390/include/asm-s390x/spinlock.h
--- linux-2.5.59/include/asm-s390x/spinlock.h	Fri Jan 17 03:21:41 2003
+++ linux-2.5.59-s390/include/asm-s390x/spinlock.h	Mon Feb  3 20:50:22 2003
@@ -139,5 +139,17 @@
 		     : "a" (&(rw)->lock), "i" (__DIAG44_OPERAND) \
 		     : "2", "3", "cc" )
 
+extern inline int _raw_write_trylock(rwlock_t *rw)
+{
+	unsigned int result, reg;
+	
+	__asm__ __volatile__("   llihh %0,0x8000\n"
+			     "   basr  %1,0\n"
+			     "0: csg %0,%1,0(%3)\n"
+			     : "=&d" (result), "=&d" (reg), "+m" (rw->lock)
+			     : "a" (&rw->lock) : "cc" );
+	return !result;
+}
+
 #endif /* __ASM_SPINLOCK_H */
 

