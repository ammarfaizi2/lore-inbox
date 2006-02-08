Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161063AbWBHHON@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161063AbWBHHON (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 02:14:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161045AbWBHHKq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 02:10:46 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:49879 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1161041AbWBHHKQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 02:10:16 -0500
To: linux-kernel@vger.kernel.org
Subject: [PATCH 02/17] mips: namespace pollution - mem_... -> __mem_... in io.h
Cc: ralf@linux-mips.org
Message-Id: <E1F6jSx-0002TE-Ur@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Wed, 08 Feb 2006 07:10:15 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Date: 1134015174 -0500

A pile of internal functions use only inside mips io.h has names starting
with mem_... and clashing with names in drivers; renamed to __mem_....

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 include/asm-mips/io.h |   32 ++++++++++++++++----------------
 1 files changed, 16 insertions(+), 16 deletions(-)

290f10ae4230ef06b71e57673101b7e70c1b29a6
diff --git a/include/asm-mips/io.h b/include/asm-mips/io.h
index a9fa125..6c0aae5 100644
--- a/include/asm-mips/io.h
+++ b/include/asm-mips/io.h
@@ -56,38 +56,38 @@
  * variations of functions: non-prefixed ones that preserve the value
  * and prefixed ones that preserve byte addresses.  The latters are
  * typically used for moving raw data between a peripheral and memory (cf.
- * string I/O functions), hence the "mem_" prefix.
+ * string I/O functions), hence the "__mem_" prefix.
  */
 #if defined(CONFIG_SWAP_IO_SPACE)
 
 # define ioswabb(x)		(x)
-# define mem_ioswabb(x)		(x)
+# define __mem_ioswabb(x)	(x)
 # ifdef CONFIG_SGI_IP22
 /*
  * IP22 seems braindead enough to swap 16bits values in hardware, but
  * not 32bits.  Go figure... Can't tell without documentation.
  */
 #  define ioswabw(x)		(x)
-#  define mem_ioswabw(x)	le16_to_cpu(x)
+#  define __mem_ioswabw(x)	le16_to_cpu(x)
 # else
 #  define ioswabw(x)		le16_to_cpu(x)
-#  define mem_ioswabw(x)	(x)
+#  define __mem_ioswabw(x)	(x)
 # endif
 # define ioswabl(x)		le32_to_cpu(x)
-# define mem_ioswabl(x)		(x)
+# define __mem_ioswabl(x)	(x)
 # define ioswabq(x)		le64_to_cpu(x)
-# define mem_ioswabq(x)		(x)
+# define __mem_ioswabq(x)	(x)
 
 #else
 
 # define ioswabb(x)		(x)
-# define mem_ioswabb(x)		(x)
+# define __mem_ioswabb(x)	(x)
 # define ioswabw(x)		(x)
-# define mem_ioswabw(x)		cpu_to_le16(x)
+# define __mem_ioswabw(x)	cpu_to_le16(x)
 # define ioswabl(x)		(x)
-# define mem_ioswabl(x)		cpu_to_le32(x)
+# define __mem_ioswabl(x)	cpu_to_le32(x)
 # define ioswabq(x)		(x)
-# define mem_ioswabq(x)		cpu_to_le32(x)
+# define __mem_ioswabq(x)	cpu_to_le32(x)
 
 #endif
 
@@ -417,7 +417,7 @@ __BUILD_MEMORY_SINGLE(bus, bwlq, type, 1
 									\
 __BUILD_MEMORY_PFX(__raw_, bwlq, type)					\
 __BUILD_MEMORY_PFX(, bwlq, type)					\
-__BUILD_MEMORY_PFX(mem_, bwlq, type)					\
+__BUILD_MEMORY_PFX(__mem_, bwlq, type)					\
 
 BUILDIO_MEM(b, u8)
 BUILDIO_MEM(w, u16)
@@ -430,7 +430,7 @@ BUILDIO_MEM(q, u64)
 
 #define BUILDIO_IOPORT(bwlq, type)					\
 	__BUILD_IOPORT_PFX(, bwlq, type)				\
-	__BUILD_IOPORT_PFX(mem_, bwlq, type)
+	__BUILD_IOPORT_PFX(__mem_, bwlq, type)
 
 BUILDIO_IOPORT(b, u8)
 BUILDIO_IOPORT(w, u16)
@@ -464,7 +464,7 @@ static inline void writes##bwlq(volatile
 	const volatile type *__addr = addr;				\
 									\
 	while (count--) {						\
-		mem_write##bwlq(*__addr, mem);				\
+		__mem_write##bwlq(*__addr, mem);			\
 		__addr++;						\
 	}								\
 }									\
@@ -475,7 +475,7 @@ static inline void reads##bwlq(volatile 
 	volatile type *__addr = addr;					\
 									\
 	while (count--) {						\
-		*__addr = mem_read##bwlq(mem);				\
+		*__addr = __mem_read##bwlq(mem);			\
 		__addr++;						\
 	}								\
 }
@@ -488,7 +488,7 @@ static inline void outs##bwlq(unsigned l
 	const volatile type *__addr = addr;				\
 									\
 	while (count--) {						\
-		mem_out##bwlq(*__addr, port);				\
+		__mem_out##bwlq(*__addr, port);				\
 		__addr++;						\
 	}								\
 }									\
@@ -499,7 +499,7 @@ static inline void ins##bwlq(unsigned lo
 	volatile type *__addr = addr;					\
 									\
 	while (count--) {						\
-		*__addr = mem_in##bwlq(port);				\
+		*__addr = __mem_in##bwlq(port);				\
 		__addr++;						\
 	}								\
 }
-- 
0.99.9.GIT

