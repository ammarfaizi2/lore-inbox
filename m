Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751906AbWFWSmN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751906AbWFWSmN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 14:42:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751912AbWFWSlz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 14:41:55 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:16591 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751913AbWFWSlu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 14:41:50 -0400
Message-Id: <20060623183909.041973000@linux-m68k.org>
References: <20060623183056.479024000@linux-m68k.org>
User-Agent: quilt/0.44-1
Date: Fri, 23 Jun 2006 20:30:57 +0200
From: zippel@linux-m68k.org
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 01/21] fix uaccess.h for gcc-3.x
Content-Disposition: inline; filename=0001-M68K-fix-uaccess.h-for-gcc-3.x.txt
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gcc-3.x has a few problems detecting a constant parameter.

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

---

 include/asm-m68k/uaccess.h |  234 ++++++++++++++++++++++++--------------------
 1 files changed, 127 insertions(+), 107 deletions(-)

fc73eb3c1c20f01114bd452fc8140ead1575e447
diff --git a/include/asm-m68k/uaccess.h b/include/asm-m68k/uaccess.h
index b761ef2..ef7963f 100644
--- a/include/asm-m68k/uaccess.h
+++ b/include/asm-m68k/uaccess.h
@@ -181,144 +181,164 @@ #define get_user(x, ptr) __get_user(x, p
 unsigned long __generic_copy_from_user(void *to, const void __user *from, unsigned long n);
 unsigned long __generic_copy_to_user(void __user *to, const void *from, unsigned long n);
 
+#define __constant_copy_from_user_asm(res, to, from, tmp, n, s1, s2, s3)\
+	asm volatile ("\n"						\
+		"1:	moves."#s1"	(%2)+,%3\n"			\
+		"	move."#s1"	%3,(%1)+\n"			\
+		"2:	moves."#s2"	(%2)+,%3\n"			\
+		"	move."#s2"	%3,(%1)+\n"			\
+		"	.ifnc	\""#s3"\",\"\"\n"			\
+		"3:	moves."#s3"	(%2)+,%3\n"			\
+		"	move."#s3"	%3,(%1)+\n"			\
+		"	.endif\n"					\
+		"4:\n"							\
+		"	.section __ex_table,\"a\"\n"			\
+		"	.align	4\n"					\
+		"	.long	1b,10f\n"				\
+		"	.long	2b,20f\n"				\
+		"	.ifnc	\""#s3"\",\"\"\n"			\
+		"	.long	3b,30f\n"				\
+		"	.endif\n"					\
+		"	.previous\n"					\
+		"\n"							\
+		"	.section .fixup,\"ax\"\n"			\
+		"	.even\n"					\
+		"10:	clr."#s1"	(%1)+\n"			\
+		"20:	clr."#s2"	(%1)+\n"			\
+		"	.ifnc	\""#s3"\",\"\"\n"			\
+		"30:	clr."#s3"	(%1)+\n"			\
+		"	.endif\n"					\
+		"	moveq.l	#"#n",%0\n"				\
+		"	jra	4b\n"					\
+		"	.previous\n"					\
+		: "+d" (res), "+&a" (to), "+a" (from), "=&d" (tmp)	\
+		: : "memory")
+
 static __always_inline unsigned long
 __constant_copy_from_user(void *to, const void __user *from, unsigned long n)
 {
 	unsigned long res = 0, tmp;
 
-	/* limit the inlined version to 3 moves */
-	if (n == 11 || n > 12)
-		return __generic_copy_from_user(to, from, n);
-
 	switch (n) {
 	case 1:
 		__get_user_asm(res, *(u8 *)to, (u8 *)from, u8, b, d, 1);
-		return res;
+		break;
 	case 2:
 		__get_user_asm(res, *(u16 *)to, (u16 *)from, u16, w, d, 2);
-		return res;
+		break;
+	case 3:
+		__constant_copy_from_user_asm(res, to, from, tmp, 3, w, b,);
+		break;
 	case 4:
 		__get_user_asm(res, *(u32 *)to, (u32 *)from, u32, l, r, 4);
-		return res;
+		break;
+	case 5:
+		__constant_copy_from_user_asm(res, to, from, tmp, 5, l, b,);
+		break;
+	case 6:
+		__constant_copy_from_user_asm(res, to, from, tmp, 6, l, w,);
+		break;
+	case 7:
+		__constant_copy_from_user_asm(res, to, from, tmp, 7, l, w, b);
+		break;
+	case 8:
+		__constant_copy_from_user_asm(res, to, from, tmp, 8, l, l,);
+		break;
+	case 9:
+		__constant_copy_from_user_asm(res, to, from, tmp, 9, l, l, b);
+		break;
+	case 10:
+		__constant_copy_from_user_asm(res, to, from, tmp, 10, l, l, w);
+		break;
+	case 12:
+		__constant_copy_from_user_asm(res, to, from, tmp, 12, l, l, l);
+		break;
+	default:
+		/* we limit the inlined version to 3 moves */
+		return __generic_copy_from_user(to, from, n);
 	}
 
-	asm volatile ("\n"
-		"	.ifndef	.Lfrom_user\n"
-		"	.set	.Lfrom_user,1\n"
-		"	.macro	copy_from_user to,from,tmp\n"
-		"	.if	.Lcnt >= 4\n"
-		"1:	moves.l	(\\from)+,\\tmp\n"
-		"	move.l	\\tmp,(\\to)+\n"
-		"	.set	.Lcnt,.Lcnt-4\n"
-		"	.elseif	.Lcnt & 2\n"
-		"1:	moves.w	(\\from)+,\\tmp\n"
-		"	move.w	\\tmp,(\\to)+\n"
-		"	.set	.Lcnt,.Lcnt-2\n"
-		"	.elseif	.Lcnt & 1\n"
-		"1:	moves.b	(\\from)+,\\tmp\n"
-		"	move.b	\\tmp,(\\to)+\n"
-		"	.set	.Lcnt,.Lcnt-1\n"
-		"	.else\n"
-		"	.exitm\n"
-		"	.endif\n"
-		"\n"
-		"	.section __ex_table,\"a\"\n"
-		"	.align	4\n"
-		"	.long	1b,3f\n"
-		"	.previous\n"
-		"	.endm\n"
-		"	.endif\n"
-		"\n"
-		"	.set	.Lcnt,%c4\n"
-		"	copy_from_user %1,%2,%3\n"
-		"	copy_from_user %1,%2,%3\n"
-		"	copy_from_user %1,%2,%3\n"
-		"2:\n"
-		"	.section .fixup,\"ax\"\n"
-		"	.even\n"
-		"3:	moveq.l	%4,%0\n"
-		"	move.l	%5,%1\n"
-		"	.rept	%c4 / 4\n"
-		"	clr.l	(%1)+\n"
-		"	.endr\n"
-		"	.if	%c4 & 2\n"
-		"	clr.w	(%1)+\n"
-		"	.endif\n"
-		"	.if	%c4 & 1\n"
-		"	clr.b	(%1)+\n"
-		"	.endif\n"
-		"	jra	2b\n"
-		"	.previous\n"
-		: "+r" (res), "+a" (to), "+a" (from), "=&d" (tmp)
-		: "i" (n), "g" (to)
-		: "memory");
-
 	return res;
 }
 
+#define __constant_copy_to_user_asm(res, to, from, tmp, n, s1, s2, s3)	\
+	asm volatile ("\n"						\
+		"	move."#s1"	(%2)+,%3\n"			\
+		"11:	moves."#s1"	%3,(%1)+\n"			\
+		"12:	move."#s2"	(%2)+,%3\n"			\
+		"21:	moves."#s2"	%3,(%1)+\n"			\
+		"22:\n"							\
+		"	.ifnc	\""#s3"\",\"\"\n"			\
+		"	move."#s3"	(%2)+,%3\n"			\
+		"31:	moves."#s3"	%3,(%1)+\n"			\
+		"32:\n"							\
+		"	.endif\n"					\
+		"4:\n"							\
+		"\n"							\
+		"	.section __ex_table,\"a\"\n"			\
+		"	.align	4\n"					\
+		"	.long	11b,5f\n"				\
+		"	.long	12b,5f\n"				\
+		"	.long	21b,5f\n"				\
+		"	.long	22b,5f\n"				\
+		"	.ifnc	\""#s3"\",\"\"\n"			\
+		"	.long	31b,5f\n"				\
+		"	.long	32b,5f\n"				\
+		"	.endif\n"					\
+		"	.previous\n"					\
+		"\n"							\
+		"	.section .fixup,\"ax\"\n"			\
+		"	.even\n"					\
+		"5:	moveq.l	#"#n",%0\n"				\
+		"	jra	4b\n"					\
+		"	.previous\n"					\
+		: "+d" (res), "+a" (to), "+a" (from), "=&d" (tmp)	\
+		: : "memory")
+
 static __always_inline unsigned long
 __constant_copy_to_user(void __user *to, const void *from, unsigned long n)
 {
 	unsigned long res = 0, tmp;
 
-	/* limit the inlined version to 3 moves */
-	if (n == 11 || n > 12)
-		return __generic_copy_to_user(to, from, n);
-
 	switch (n) {
 	case 1:
 		__put_user_asm(res, *(u8 *)from, (u8 *)to, b, d, 1);
-		return res;
+		break;
 	case 2:
 		__put_user_asm(res, *(u16 *)from, (u16 *)to, w, d, 2);
-		return res;
+		break;
+	case 3:
+		__constant_copy_to_user_asm(res, to, from, tmp, 3, w, b,);
+		break;
 	case 4:
 		__put_user_asm(res, *(u32 *)from, (u32 *)to, l, r, 4);
-		return res;
+		break;
+	case 5:
+		__constant_copy_to_user_asm(res, to, from, tmp, 5, l, b,);
+		break;
+	case 6:
+		__constant_copy_to_user_asm(res, to, from, tmp, 6, l, w,);
+		break;
+	case 7:
+		__constant_copy_to_user_asm(res, to, from, tmp, 7, l, w, b);
+		break;
+	case 8:
+		__constant_copy_to_user_asm(res, to, from, tmp, 8, l, l,);
+		break;
+	case 9:
+		__constant_copy_to_user_asm(res, to, from, tmp, 9, l, l, b);
+		break;
+	case 10:
+		__constant_copy_to_user_asm(res, to, from, tmp, 10, l, l, w);
+		break;
+	case 12:
+		__constant_copy_to_user_asm(res, to, from, tmp, 12, l, l, l);
+		break;
+	default:
+		/* limit the inlined version to 3 moves */
+		return __generic_copy_to_user(to, from, n);
 	}
 
-	asm volatile ("\n"
-		"	.ifndef	.Lto_user\n"
-		"	.set	.Lto_user,1\n"
-		"	.macro	copy_to_user to,from,tmp\n"
-		"	.if	.Lcnt >= 4\n"
-		"	move.l	(\\from)+,\\tmp\n"
-		"11:	moves.l	\\tmp,(\\to)+\n"
-		"12:	.set	.Lcnt,.Lcnt-4\n"
-		"	.elseif	.Lcnt & 2\n"
-		"	move.w	(\\from)+,\\tmp\n"
-		"11:	moves.w	\\tmp,(\\to)+\n"
-		"12:	.set	.Lcnt,.Lcnt-2\n"
-		"	.elseif	.Lcnt & 1\n"
-		"	move.b	(\\from)+,\\tmp\n"
-		"11:	moves.b	\\tmp,(\\to)+\n"
-		"12:	.set	.Lcnt,.Lcnt-1\n"
-		"	.else\n"
-		"	.exitm\n"
-		"	.endif\n"
-		"\n"
-		"	.section __ex_table,\"a\"\n"
-		"	.align	4\n"
-		"	.long	11b,3f\n"
-		"	.long	12b,3f\n"
-		"	.previous\n"
-		"	.endm\n"
-		"	.endif\n"
-		"\n"
-		"	.set	.Lcnt,%c4\n"
-		"	copy_to_user %1,%2,%3\n"
-		"	copy_to_user %1,%2,%3\n"
-		"	copy_to_user %1,%2,%3\n"
-		"2:\n"
-		"	.section .fixup,\"ax\"\n"
-		"	.even\n"
-		"3:	moveq.l	%4,%0\n"
-		"	jra	2b\n"
-		"	.previous\n"
-		: "+r" (res), "+a" (to), "+a" (from), "=&d" (tmp)
-		: "i" (n)
-		: "memory");
-
 	return res;
 }
 
-- 
1.3.3

--

