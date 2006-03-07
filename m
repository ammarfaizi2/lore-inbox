Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751449AbWCGSJS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751449AbWCGSJS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 13:09:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751434AbWCGSJS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 13:09:18 -0500
Received: from ftp.linux-mips.org ([194.74.144.162]:49826 "EHLO
	ftp.linux-mips.org") by vger.kernel.org with ESMTP id S1751449AbWCGSJR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 13:09:17 -0500
Date: Tue, 7 Mar 2006 18:09:07 +0000
From: Ralf Baechle <ralf@linux-mips.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 64bit unaligned access on 32bit kernel
Message-ID: <20060307180907.GA13577@linux-mips.org>
References: <20050830104056.GA4710@linux-mips.org> <20060306.203218.69025300.nemoto@toshiba-tops.co.jp> <20060306170552.0aab29c5.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060306170552.0aab29c5.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2006 at 05:05:52PM -0800, Andrew Morton wrote:

> I worry about what impact that change might have on code generation. 
> Hopefully none, if gcc is good enough.
> 
> But I cannot think of a better fix.

Below's fix results in exactly the same code size on all compilers and
configurations I've tested it.

I also have another more elegant fix which as a side effect makes
get_unaligned work for arbitrary data types but it that one results in a
slight code bloat:

gcc 4.1.0 ip22 64-bit
   text    data     bss     dec     hex filename
2717213  337920  167968 3223101  312e3d vmlinux
2717277  337920  167968 3223165  312e7d vmlinux         unaligned-4.patch

  Ralf


Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

diff --git a/include/asm-generic/unaligned.h b/include/asm-generic/unaligned.h
index 4dc8ddb..9a63564 100644
--- a/include/asm-generic/unaligned.h
+++ b/include/asm-generic/unaligned.h
@@ -26,35 +26,13 @@
  * the linker will alert us to the problem via an unresolved reference
  * error.
  */
-extern void bad_unaligned_access_length(void) __attribute__((noreturn));
+extern int bad_unaligned_access_length(void) __attribute__((noreturn));
 
 struct __una_u64 { __u64 x __attribute__((packed)); };
 struct __una_u32 { __u32 x __attribute__((packed)); };
 struct __una_u16 { __u16 x __attribute__((packed)); };
 
 /*
- * Elemental unaligned loads 
- */
-
-static inline __u64 __uldq(const __u64 *addr)
-{
-	const struct __una_u64 *ptr = (const struct __una_u64 *) addr;
-	return ptr->x;
-}
-
-static inline __u32 __uldl(const __u32 *addr)
-{
-	const struct __una_u32 *ptr = (const struct __una_u32 *) addr;
-	return ptr->x;
-}
-
-static inline __u16 __uldw(const __u16 *addr)
-{
-	const struct __una_u16 *ptr = (const struct __una_u16 *) addr;
-	return ptr->x;
-}
-
-/*
  * Elemental unaligned stores 
  */
 
@@ -76,26 +54,16 @@ static inline void __ustw(__u16 val, __u
 	ptr->x = val;
 }
 
-#define __get_unaligned(ptr, size) ({		\
-	const void *__gu_p = ptr;		\
-	__typeof__(*(ptr)) val;			\
-	switch (size) {				\
-	case 1:					\
-		val = *(const __u8 *)__gu_p;	\
-		break;				\
-	case 2:					\
-		val = __uldw(__gu_p);		\
-		break;				\
-	case 4:					\
-		val = __uldl(__gu_p);		\
-		break;				\
-	case 8:					\
-		val = __uldq(__gu_p);		\
-		break;				\
-	default:				\
-		bad_unaligned_access_length();	\
-	};					\
-	val;					\
+#define __get_unaligned(ptr, size)						\
+({										\
+	const void *__gu_p = ptr;						\
+	int __sz = size;							\
+										\
+	((__sz == 1) ? (__typeof__(*(ptr)))*(const __u8 *)__gu_p		\
+	: ((__sz == 2) ? (__typeof__(*(ptr)))((struct __una_u16 *)__gu_p)->x	\
+	: ((__sz == 4) ? (__typeof__(*(ptr)))((struct __una_u32 *)__gu_p)->x	\
+	: ((__sz == 8) ? (__typeof__(*(ptr)))((struct __una_u64 *)__gu_p)->x	\
+	: bad_unaligned_access_length()))));					\
 })
 
 #define __put_unaligned(val, ptr, size)		\
