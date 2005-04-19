Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261344AbVDSGTh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261344AbVDSGTh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 02:19:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261348AbVDSGTe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 02:19:34 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:36613 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261344AbVDSGTL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 02:19:11 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] introduce generic 64bit rotations and i386 asm optimized version
Date: Tue, 19 Apr 2005 09:18:10 +0300
User-Agent: KMail/1.5.4
Cc: Matt Mackall <mpm@selenic.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_iKKZCbHAG+RJptd"
Message-Id: <200504190918.10279.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_iKKZCbHAG+RJptd
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

This is done because on 32bit arch gcc generates suboptimal code
from C implementation:

old:
      40:       83 ea 80                sub    $0xffffff80,%edx
      43:       89 95 50 ff ff ff       mov    %edx,0xffffff50(%ebp)
      49:       8b bd 50 ff ff ff       mov    0xffffff50(%ebp),%edi
      4f:       8b 4f f0                mov    0xfffffff0(%edi),%ecx
      52:       8b 5f f4                mov    0xfffffff4(%edi),%ebx
      55:       89 ce                   mov    %ecx,%esi
      57:       0f ac de 13             shrd   $0x13,%ebx,%esi
      5b:       31 c0                   xor    %eax,%eax
      5d:       89 df                   mov    %ebx,%edi
      5f:       89 ca                   mov    %ecx,%edx
      61:       c1 e2 0d                shl    $0xd,%edx
      64:       09 c6                   or     %eax,%esi
      66:       c1 ef 13                shr    $0x13,%edi
      69:       89 d8                   mov    %ebx,%eax
      6b:       09 d7                   or     %edx,%edi
      6d:       c1 e8 1d                shr    $0x1d,%eax
      70:       31 d2                   xor    %edx,%edx
      72:       89 85 40 ff ff ff       mov    %eax,0xffffff40(%ebp)
      78:       89 95 44 ff ff ff       mov    %edx,0xffffff44(%ebp)
new:
      40:       83 ea 80                sub    $0xffffff80,%edx
      43:       89 95 48 ff ff ff       mov    %edx,0xffffff48(%ebp)
      49:       8b 9d 48 ff ff ff       mov    0xffffff48(%ebp),%ebx
      4f:       8b 4b f0                mov    0xfffffff0(%ebx),%ecx
      52:       8b 5b f4                mov    0xfffffff4(%ebx),%ebx
      55:       89 c8                   mov    %ecx,%eax
      57:       89 da                   mov    %ebx,%edx
      59:       0f ac d0 13             shrd   $0x13,%edx,%eax
      5d:       0f ac ca 13             shrd   $0x13,%ecx,%edx
      61:       89 45 a0                mov    %eax,0xffffffa0(%ebp)
      64:       89 55 a4                mov    %edx,0xffffffa4(%ebp)
--
vda

--Boundary-00=_iKKZCbHAG+RJptd
Content-Type: text/x-diff;
  charset="koi8-r";
  name="0.ror64.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="0.ror64.patch"

diff -urpN 2.6.12-rc2.1.be/include/asm-i386/bitops.h 2.6.12-rc2.2.ror/include/asm-i386/bitops.h
--- 2.6.12-rc2.1.be/include/asm-i386/bitops.h	Tue Oct 19 00:54:36 2004
+++ 2.6.12-rc2.2.ror/include/asm-i386/bitops.h	Tue Apr 19 08:20:07 2005
@@ -7,6 +7,7 @@
 
 #include <linux/config.h>
 #include <linux/compiler.h>
+#include <linux/types.h>
 
 /*
  * These have to be done with inline assembly: that way the bit-setting
@@ -431,9 +432,81 @@ static inline int ffs(int x)
 #define hweight16(x) generic_hweight16(x)
 #define hweight8(x) generic_hweight8(x)
 
-#endif /* __KERNEL__ */
+/*
+ * 64bit rotations
+ * (gcc3 seems to be clever enough to do 32bit ones just fine)
+ *
+ * Why "i" and "I" constraints do not work? gcc says:
+ * "warning: asm operand 2 probably doesn't match constraints"
+ * "error: impossible constraint in 'asm'"
+ * Will use "Ic" for now. If gcc will fail to do const propagation
+ * and will try to stuff constant into ecx, shld %3,... will expand
+ * to shld %ecx,... and assembler will moan.
+ * Do not 'fix' by changing to shld %b3,...
+ *
+ * Have to stick to edx,eax pair only because
+ * gcc has limited support for 64bit asm parameters
+ */
+#define constant_rol64(v,c) \
+	({						\
+	u64 vv = (v);					\
+	if(!(c&63)) {					\
+	} else if((c&63)==1) {				\
+		asm (					\
+		"	shldl	$1,%%edx,%%eax	\n"	\
+		"	rcll	$1,%%edx	\n"	\
+		: "=&A" (vv)				\
+		: "0" (vv)				\
+		);					\
+	} else if((c&63)==63) {				\
+		asm (					\
+		"	shrdl	$1,%%edx,%%eax	\n"	\
+		"	rcrl	$1,%%edx	\n"	\
+		: "=&A" (vv)				\
+		: "0" (vv)				\
+		);					\
+	} else if((c&63)<32) {				\
+		asm (					\
+		"	shldl	%3,%%edx,%%eax	\n"	\
+		"	shldl	%3,%2,%%edx	\n"	\
+		: "=&A" (vv)				\
+		: "0" (vv), "r" (vv), "Ic" (c&63)	\
+		);					\
+	} else if((c&63)>32) {				\
+		asm (					\
+		"	shrdl	%3,%%edx,%%eax	\n"	\
+		"	shrdl	%3,%2,%%edx	\n"	\
+		: "=&A" (vv)				\
+		: "0" (vv), "r" (vv), "Ic" (64-(c&63))	\
+		);					\
+	} else /* (c&63)==32 */ {			\
+		asm (					\
+		"	xchgl	%%edx,%%eax	\n"	\
+		: "=&A" (vv)				\
+		: "0" (vv)				\
+		);					\
+	}						\
+	vv;						\
+	})
+/*
+ * Unfortunately 64bit rotations with non-constant count
+ * have issues with cnt>=32. Using C code instead
+ */
+static inline u64 rol64(u64 x,int num) {
+	if(__builtin_constant_p(num))
+		return constant_rol64(x,num);
+	/* Hmmm... shall we do cnt&=63 here? */
+	return ((x<<num) | (x>>(64-num)));
+}
+static inline u64 ror64(u64 x,int num) {
+	if(__builtin_constant_p(num))
+		return constant_rol64(x,(64-num));
+	return ((x>>num) | (x<<(64-num)));
+}
+
+#define ARCH_HAS_ROL64
+#define ARCH_HAS_ROR64
 
-#ifdef __KERNEL__
 
 #define ext2_set_bit(nr,addr) \
 	__test_and_set_bit((nr),(unsigned long*)addr)
diff -urpN 2.6.12-rc2.1.be/include/linux/bitops.h 2.6.12-rc2.2.ror/include/linux/bitops.h
--- 2.6.12-rc2.1.be/include/linux/bitops.h	Mon Apr 18 22:55:10 2005
+++ 2.6.12-rc2.2.ror/include/linux/bitops.h	Tue Apr 19 00:25:28 2005
@@ -41,7 +41,7 @@ static inline int generic_ffs(int x)
  * fls: find last bit set.
  */
 
-static __inline__ int generic_fls(int x)
+static inline int generic_fls(int x)
 {
 	int r = 32;
 
@@ -76,7 +76,7 @@ static __inline__ int generic_fls(int x)
  */
 #include <asm/bitops.h>
 
-static __inline__ int get_bitmask_order(unsigned int count)
+static inline int get_bitmask_order(unsigned int count)
 {
 	int order;
 	
@@ -155,5 +155,31 @@ static inline __u32 ror32(__u32 word, un
 {
 	return (word >> shift) | (word << (32 - shift));
 }
+
+/*
+ * rol64 - rotate a 64-bit value left
+ *
+ * @word: value to rotate
+ * @shift: bits to roll
+ */
+#ifndef ARCH_HAS_ROL64
+static inline __u64 rol64(__u64 word, unsigned int shift)
+{
+	return (word << shift) | (word >> (64 - shift));
+}
+#endif
+
+/*
+ * ror64 - rotate a 64-bit value right
+ *
+ * @word: value to rotate
+ * @shift: bits to roll
+ */
+#ifndef ARCH_HAS_ROR64
+static inline __u64 ror64(__u64 word, unsigned int shift)
+{
+	return (word >> shift) | (word << (64 - shift));
+}
+#endif
 
 #endif

--Boundary-00=_iKKZCbHAG+RJptd--

