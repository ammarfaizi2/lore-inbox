Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932439AbVHWVtu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932439AbVHWVtu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 17:49:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932465AbVHWVtM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 17:49:12 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:9654 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S932439AbVHWVoD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 17:44:03 -0400
To: torvalds@osdl.org
Subject: [PATCH] (28/43) alpha xchg fix
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1E7gbr-0007DA-1I@parcelfarce.linux.theplanet.co.uk>
From: Al Viro <viro@www.linux.org.uk>
Date: Tue, 23 Aug 2005 22:47:07 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

alpha xchg has to be a macro - alpha disables always_inline and if that
puppy does not get inlined, we immediately blow up on undefined reference.
Happens even on gcc3; with gcc4 that happens a _lot_.

Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
----
diff -urN RC13-rc6-git13-pcmcia-irq/include/asm-alpha/system.h RC13-rc6-git13-alpha-xchg/include/asm-alpha/system.h
--- RC13-rc6-git13-pcmcia-irq/include/asm-alpha/system.h	2005-06-17 15:48:29.000000000 -0400
+++ RC13-rc6-git13-alpha-xchg/include/asm-alpha/system.h	2005-08-21 13:17:10.000000000 -0400
@@ -443,22 +443,19 @@
    if something tries to do an invalid xchg().  */
 extern void __xchg_called_with_bad_pointer(void);
 
-static inline unsigned long
-__xchg(volatile void *ptr, unsigned long x, int size)
-{
-	switch (size) {
-		case 1:
-			return __xchg_u8(ptr, x);
-		case 2:
-			return __xchg_u16(ptr, x);
-		case 4:
-			return __xchg_u32(ptr, x);
-		case 8:
-			return __xchg_u64(ptr, x);
-	}
-	__xchg_called_with_bad_pointer();
-	return x;
-}
+#define __xchg(ptr, x, size) \
+({ \
+	unsigned long __xchg__res; \
+	volatile void *__xchg__ptr = (ptr); \
+	switch (size) { \
+		case 1: __xchg__res = __xchg_u8(__xchg__ptr, x); break; \
+		case 2: __xchg__res = __xchg_u16(__xchg__ptr, x); break; \
+		case 4: __xchg__res = __xchg_u32(__xchg__ptr, x); break; \
+		case 8: __xchg__res = __xchg_u64(__xchg__ptr, x); break; \
+		default: __xchg_called_with_bad_pointer(); __xchg__res = x; \
+	} \
+	__xchg__res; \
+})
 
 #define xchg(ptr,x)							     \
   ({									     \
