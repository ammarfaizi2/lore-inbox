Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267595AbUG3EXf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267595AbUG3EXf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 00:23:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267584AbUG3EXf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 00:23:35 -0400
Received: from gate.crashing.org ([63.228.1.57]:10989 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S267595AbUG3EXG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 00:23:06 -0400
Subject: [PATCH] ppc64: fix memcpy_to/from_io
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1091161338.2083.30.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 30 Jul 2004 14:22:19 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

The ppc64 implementation of memcpy_to/from_io was bogus (used memcpy
which uses cache hints and thus is broken on non cacheable IO space).

This re-implements them with some simple/gross C code doing 32 bits
accesses when aligned and bytes accesses when not.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

===== include/asm-ppc64/eeh.h 1.12 vs ? (writable without lock!)  =====
--- 1.12/include/asm-ppc64/eeh.h	2004-07-02 15:23:45 +10:00
+++ ?/include/asm-ppc64/eeh.h	2004-07-30 14:19:48 +10:00
@@ -180,26 +180,95 @@
 	out_be64(vaddr, val);
 }
 
+#define EEH_CHECK_ALIGN(v,a) \
+	((((unsigned long)(v)) & ((a) - 1)) == 0)
+
 static inline void eeh_memset_io(void *addr, int c, unsigned long n) {
 	void *vaddr = (void *)IO_TOKEN_TO_ADDR(addr);
-	memset(vaddr, c, n);
+	u32 lc = c;
+	lc |= lc << 8;
+	lc |= lc << 16;
+
+	while(n && !EEH_CHECK_ALIGN(vaddr, 4)) {
+		*((volatile u8 *)vaddr) = c;
+		vaddr = (void *)((unsigned long)vaddr + 1);
+		n--;
+	}
+	while(n >= 4) {
+		*((volatile u32 *)vaddr) = lc;
+		vaddr = (void *)((unsigned long)vaddr + 4);
+		n -= 4;
+	}
+	while(n) {
+		*((volatile u8 *)vaddr) = c;
+		vaddr = (void *)((unsigned long)vaddr + 1);
+		n--;
+	}
+	__asm__ __volatile__ ("sync" : : : "memory");
 }
 static inline void eeh_memcpy_fromio(void *dest, void *src, unsigned long n) {
 	void *vsrc = (void *)IO_TOKEN_TO_ADDR(src);
-	memcpy(dest, vsrc, n);
+	void *vsrcsave = vsrc, *destsave = dest, *srcsave = src;
+	unsigned long nsave = n;
+
+	while(n && (!EEH_CHECK_ALIGN(vsrc, 4) || !EEH_CHECK_ALIGN(dest, 4))) {
+		*((u8 *)dest) = *((volatile u8 *)vsrc);
+		__asm__ __volatile__ ("eieio" : : : "memory");
+		vsrc = (void *)((unsigned long)vsrc + 1);
+		dest = (void *)((unsigned long)dest + 1);			
+		n--;
+	}
+	while(n > 4) {
+		*((u32 *)dest) = *((volatile u32 *)vsrc);
+		__asm__ __volatile__ ("eieio" : : : "memory");
+		vsrc = (void *)((unsigned long)vsrc + 4);
+		dest = (void *)((unsigned long)dest + 4);			
+		n -= 4;
+	}
+	while(n) {
+		*((u8 *)dest) = *((volatile u8 *)vsrc);
+		__asm__ __volatile__ ("eieio" : : : "memory");
+		vsrc = (void *)((unsigned long)vsrc + 1);
+		dest = (void *)((unsigned long)dest + 1);			
+		n--;
+	}
+	__asm__ __volatile__ ("sync" : : : "memory");
+
 	/* Look for ffff's here at dest[n].  Assume that at least 4 bytes
 	 * were copied. Check all four bytes.
 	 */
-	if ((n >= 4) &&
-		(EEH_POSSIBLE_ERROR(src, vsrc, (*((u32 *) dest+n-4)), u32))) {
-		eeh_check_failure(src, (*((u32 *) dest+n-4)));
+	if ((nsave >= 4) &&
+		(EEH_POSSIBLE_ERROR(srcsave, vsrcsave, (*((u32 *) destsave+nsave-4)),
+				    u32))) {
+		eeh_check_failure(srcsave, (*((u32 *) destsave+nsave-4)));
 	}
 }
 
 static inline void eeh_memcpy_toio(void *dest, void *src, unsigned long n) {
 	void *vdest = (void *)IO_TOKEN_TO_ADDR(dest);
-	memcpy(vdest, src, n);
+
+	while(n && (!EEH_CHECK_ALIGN(vdest, 4) || !EEH_CHECK_ALIGN(src, 4))) {
+		*((volatile u8 *)vdest) = *((u8 *)src);
+		src = (void *)((unsigned long)src + 1);
+		vdest = (void *)((unsigned long)vdest + 1);			
+		n--;
+	}
+	while(n > 4) {
+		*((volatile u32 *)vdest) = *((volatile u32 *)src);
+		src = (void *)((unsigned long)src + 4);
+		vdest = (void *)((unsigned long)vdest + 4);			
+		n-=4;
+	}
+	while(n) {
+		*((volatile u8 *)vdest) = *((u8 *)src);
+		src = (void *)((unsigned long)src + 1);
+		vdest = (void *)((unsigned long)vdest + 1);			
+		n--;
+	}
+	__asm__ __volatile__ ("sync" : : : "memory");
 }
+
+#undef EEH_CHECK_ALIGN
 
 #define MAX_ISA_PORT 0x10000
 extern unsigned long io_page_mask;


