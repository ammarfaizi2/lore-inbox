Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266650AbUJCKpb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266650AbUJCKpb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Oct 2004 06:45:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267633AbUJCKpb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Oct 2004 06:45:31 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:20236 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S266650AbUJCKpB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Oct 2004 06:45:01 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: jmorris@redhat.com, davem@davemloft.net
Subject: [PATCH] add rotate left/right ops to bitops.h
Date: Sun, 3 Oct 2004 13:44:54 +0300
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_mg9XBC6onl63hxg"
Message-Id: <200410031344.54182.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_mg9XBC6onl63hxg
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

This patch is needed for next sha512 optimization patch.

It adds these to linux/bitops.h:

extern inline u32 rol32(u32 x, int num)
extern inline u32 ror32(u32 x, int num)
extern inline u64 rol64(u64 x, int num)
extern inline u64 ror64(u64 x, int num)

Generic C version is provided.
Arches may override it by optimized ones.
64bit i386 asm version is provided.
--
vda

--Boundary-00=_mg9XBC6onl63hxg
Content-Type: text/x-diff;
  charset="koi8-r";
  name="269r3rot.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="269r3rot.diff"

diff -urpN linux-2.6.9-rc3.src/include/asm-i386/bitops.h linux-2.6.9-rc3rot.src/include/asm-i386/bitops.h
--- linux-2.6.9-rc3.src/include/asm-i386/bitops.h	Fri Oct  1 21:30:16 2004
+++ linux-2.6.9-rc3rot.src/include/asm-i386/bitops.h	Sun Oct  3 12:48:46 2004
@@ -431,9 +431,130 @@ static inline int ffs(int x)
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
+		: "0" (vv),				\
+		  "r" (vv),				\
+		  "Ic" (c&63)				\
+		);					\
+	} else if((c&63)>32) {				\
+		asm (					\
+		"	shrdl	%3,%%edx,%%eax	\n"	\
+		"	shrdl	%3,%2,%%edx	\n"	\
+		: "=&A" (vv)				\
+		: "0" (vv),				\
+		  "r" (vv),				\
+		  "Ic" (64-(c&63))			\
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
+#define constant_ror64(v,c) \
+	({						\
+	u64 vv = (v);					\
+	if(!(c&63)) {					\
+	} else if((c&63)==1) {				\
+		asm (					\
+		"	shrdl	$1,%%edx,%%eax	\n"	\
+		"	rcrl	$1,%%edx	\n"	\
+		: "=&A" (vv)				\
+		: "0" (vv)				\
+		);					\
+	} else if((c&63)==63) {				\
+		asm (					\
+		"	shldl	$1,%%edx,%%eax	\n"	\
+		"	rcll	$1,%%edx	\n"	\
+		: "=&A" (vv)				\
+		: "0" (vv)				\
+		);					\
+	} else if((c&63)<32) {				\
+		asm (					\
+		"	shrdl	%3,%%edx,%%eax	\n"	\
+		"	shrdl	%3,%2,%%edx	\n"	\
+		: "=&A" (vv)				\
+		: "0" (vv),				\
+		  "r" (vv),				\
+		  "Ic" (c&63)				\
+		);					\
+	} else if((c&63)>32) {				\
+		asm (					\
+		"	shldl	%3,%%edx,%%eax	\n"	\
+		"	shldl	%3,%2,%%edx	\n"	\
+		: "=&A" (vv)				\
+		: "0" (vv),				\
+		  "r" (vv),				\
+		  "Ic" (64-(c&63))			\
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
+extern inline u64 rol64(u64 x,int num) {
+	if(__builtin_constant_p(num))
+		return constant_rol64(x,num);
+	/* Hmmm... shall we do cnt&=63 here? */
+	return ((x<<num) | (x>>(64-num)));
+}
+extern inline u64 ror64(u64 x,int num) {
+	if(__builtin_constant_p(num))
+		return constant_ror64(x,num);
+	return ((x>>num) | (x<<(64-num)));
+}
+
+#define ARCH_HAS_ROL64
+#define ARCH_HAS_ROR64
 
-#ifdef __KERNEL__
 
 #define ext2_set_bit(nr,addr) \
 	__test_and_set_bit((nr),(unsigned long*)addr)
diff -urpN linux-2.6.9-rc3.src/include/linux/bitops.h linux-2.6.9-rc3rot.src/include/linux/bitops.h
--- linux-2.6.9-rc3.src/include/linux/bitops.h	Sat Aug 14 13:56:23 2004
+++ linux-2.6.9-rc3rot.src/include/linux/bitops.h	Sun Oct  3 12:43:51 2004
@@ -4,6 +4,38 @@
 #include <asm/bitops.h>
 
 /*
+ * bit rotations
+ */
+
+#ifndef ARCH_HAS_ROL32
+extern inline u32 rol32(u32 x, int num)
+{
+	return (x << num) | (x >> (32 - num));
+}
+#endif
+
+#ifndef ARCH_HAS_ROR32
+extern inline u32 ror32(u32 x, int num)
+{
+	return (x >> num) | (x << (32 - num));
+}
+#endif
+
+#ifndef ARCH_HAS_ROL64
+extern inline u64 rol64(u64 x, int num)
+{
+	return (x << num) | (x >> (64 - num));
+}
+#endif
+
+#ifndef ARCH_HAS_ROR64
+extern inline u64 ror64(u64 x, int num)
+{
+	return (x >> num) | (x << (64 - num));
+}
+#endif
+
+/*
  * ffs: find first bit set. This is defined the same way as
  * the libc and compiler builtin ffs routines, therefore
  * differs in spirit from the above ffz (man ffs).

--Boundary-00=_mg9XBC6onl63hxg--

