Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264272AbUEIFnt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264272AbUEIFnt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 May 2004 01:43:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264276AbUEIFnt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 May 2004 01:43:49 -0400
Received: from ozlabs.org ([203.10.76.45]:47558 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S264272AbUEIFnm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 May 2004 01:43:42 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16541.47807.90358.558608@cargo.ozlabs.ibm.com>
Date: Sun, 9 May 2004 14:59:43 +1000
From: Paul Mackerras <paulus@samba.org>
To: torvalds@osdl.org, akpm@osdl.org, olh@suse.de
Cc: anton@samba.org, benh@kernel.crashing.org, linux-kernel@vger.kernel.org
Subject: [PATCH][PPC64] extra barrier in I/O operations
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At the moment, on PPC64, the instruction we use for wmb() doesn't
order cacheable stores vs. non-cacheable stores.  (It does order
cacheable vs. cacheable and non-cacheable vs. non-cacheable.)  This
causes problems in the sort of driver code that writes stuff into
memory, does a wmb(), then a writel to the device to start a DMA
operation to read the stuff it has just written to memory.

This patch solves the problem by adding a sync instruction before the
store in the write* and out* macros.  The sync is a full barrier that
orders all loads and stores, cacheable or not.  The patch also moves
the eieio instruction that we had after the store to before the load
in the read* and in* macros.  With the sync before the store, we don't
need an eieio as well in a sequence of stores, but we still need an
eieio between a store and a load.

I think it is better to do this than to turn wmb() into a full memory
barrier (a sync instruction) because the full barrier is slow and
isn't needed with the sync in the write*/out* macros.  This way,
write*/out* are fully ordered with respect to preceding loads and
stores, which is what driver writers expect, and we avoid penalizing
users of wmb() who are only doing cacheable stores.

Please apply.

Paul.

diff -urN linux-2.5/include/asm-ppc64/io.h g5-ppc64/include/asm-ppc64/io.h
--- linux-2.5/include/asm-ppc64/io.h	2004-03-20 08:59:11.000000000 +1100
+++ g5-ppc64/include/asm-ppc64/io.h	2004-05-09 13:31:12.607957768 +1000
@@ -240,22 +240,23 @@
 {
 	int ret;
 
-	__asm__ __volatile__("lbz%U1%X1 %0,%1; twi 0,%0,0; isync" :
-			     "=r" (ret) : "m" (*addr));
+	__asm__ __volatile__("eieio; lbz%U1%X1 %0,%1; twi 0,%0,0; isync"
+			     : "=r" (ret) : "m" (*addr));
 	return ret;
 }
 
 static inline void out_8(volatile unsigned char *addr, int val)
 {
-	__asm__ __volatile__("stb%U0%X0 %1,%0; eieio" : "=m" (*addr) : "r" (val));
+	__asm__ __volatile__("sync; stb%U0%X0 %1,%0"
+			     : "=m" (*addr) : "r" (val));
 }
 
 static inline int in_le16(volatile unsigned short *addr)
 {
 	int ret;
 
-	__asm__ __volatile__("lhbrx %0,0,%1; twi 0,%0,0; isync" :
-			     "=r" (ret) : "r" (addr), "m" (*addr));
+	__asm__ __volatile__("eieio; lhbrx %0,0,%1; twi 0,%0,0; isync"
+			     : "=r" (ret) : "r" (addr), "m" (*addr));
 	return ret;
 }
 
@@ -263,28 +264,29 @@
 {
 	int ret;
 
-	__asm__ __volatile__("lhz%U1%X1 %0,%1; twi 0,%0,0; isync" :
-			     "=r" (ret) : "m" (*addr));
+	__asm__ __volatile__("eieio; lhz%U1%X1 %0,%1; twi 0,%0,0; isync"
+			     : "=r" (ret) : "m" (*addr));
 	return ret;
 }
 
 static inline void out_le16(volatile unsigned short *addr, int val)
 {
-	__asm__ __volatile__("sthbrx %1,0,%2; eieio" : "=m" (*addr) :
-			      "r" (val), "r" (addr));
+	__asm__ __volatile__("sync; sthbrx %1,0,%2"
+			     : "=m" (*addr) : "r" (val), "r" (addr));
 }
 
 static inline void out_be16(volatile unsigned short *addr, int val)
 {
-	__asm__ __volatile__("sth%U0%X0 %1,%0; eieio" : "=m" (*addr) : "r" (val));
+	__asm__ __volatile__("sync; sth%U0%X0 %1,%0"
+			     : "=m" (*addr) : "r" (val));
 }
 
 static inline unsigned in_le32(volatile unsigned *addr)
 {
 	unsigned ret;
 
-	__asm__ __volatile__("lwbrx %0,0,%1; twi 0,%0,0; isync" :
-			     "=r" (ret) : "r" (addr), "m" (*addr));
+	__asm__ __volatile__("eieio; lwbrx %0,0,%1; twi 0,%0,0; isync"
+			     : "=r" (ret) : "r" (addr), "m" (*addr));
 	return ret;
 }
 
@@ -292,20 +294,21 @@
 {
 	unsigned ret;
 
-	__asm__ __volatile__("lwz%U1%X1 %0,%1; twi 0,%0,0; isync" :
-			     "=r" (ret) : "m" (*addr));
+	__asm__ __volatile__("eieio; lwz%U1%X1 %0,%1; twi 0,%0,0; isync"
+			     : "=r" (ret) : "m" (*addr));
 	return ret;
 }
 
 static inline void out_le32(volatile unsigned *addr, int val)
 {
-	__asm__ __volatile__("stwbrx %1,0,%2; eieio" : "=m" (*addr) :
-			     "r" (val), "r" (addr));
+	__asm__ __volatile__("sync; stwbrx %1,0,%2" : "=m" (*addr)
+			     : "r" (val), "r" (addr));
 }
 
 static inline void out_be32(volatile unsigned *addr, int val)
 {
-	__asm__ __volatile__("stw%U0%X0 %1,%0; eieio" : "=m" (*addr) : "r" (val));
+	__asm__ __volatile__("sync; stw%U0%X0 %1,%0; eieio"
+			     : "=m" (*addr) : "r" (val));
 }
 
 static inline unsigned long in_le64(volatile unsigned long *addr)
@@ -313,7 +316,7 @@
 	unsigned long tmp, ret;
 
 	__asm__ __volatile__(
-			     "ld %1,0(%2)\n"
+			     "eieio; ld %1,0(%2)\n"
 			     "twi 0,%1,0\n"
 			     "isync\n"
 			     "rldimi %0,%1,5*8,1*8\n"
@@ -331,8 +334,8 @@
 {
 	unsigned long ret;
 
-	__asm__ __volatile__("ld %0,0(%1); twi 0,%0,0; isync" :
-			     "=r" (ret) : "m" (*addr));
+	__asm__ __volatile__("eieio; ld %0,0(%1); twi 0,%0,0; isync"
+			     : "=r" (ret) : "m" (*addr));
 	return ret;
 }
 
@@ -348,14 +351,13 @@
 			     "rldicl %1,%1,32,0\n"
 			     "rlwimi %0,%1,8,8,31\n"
 			     "rlwimi %0,%1,24,16,23\n"
-			     "std %0,0(%2)\n"
-			     "eieio\n"
+			     "sync; std %0,0(%2)\n"
 			     : "=r" (tmp) : "r" (val), "b" (addr) , "m" (*addr));
 }
 
 static inline void out_be64(volatile unsigned long *addr, int val)
 {
-	__asm__ __volatile__("std %1,0(%0); eieio" : "=m" (*addr) : "r" (val));
+	__asm__ __volatile__("sync; std %1,0(%0)" : "=m" (*addr) : "r" (val));
 }
 
 #ifndef CONFIG_PPC_ISERIES 




