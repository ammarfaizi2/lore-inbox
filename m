Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313314AbSDUNjj>; Sun, 21 Apr 2002 09:39:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313319AbSDUNji>; Sun, 21 Apr 2002 09:39:38 -0400
Received: from rwcrmhc54.attbi.com ([216.148.227.87]:46246 "EHLO
	rwcrmhc54.attbi.com") by vger.kernel.org with ESMTP
	id <S313314AbSDUNjh>; Sun, 21 Apr 2002 09:39:37 -0400
Message-ID: <3CC2C08B.4060608@didntduck.org>
Date: Sun, 21 Apr 2002 09:37:15 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Frank Davis <fdavis@si.rr.com>
CC: linux-kernel@vger.kernel.org, davej@suse.de, Martin.Bligh@us.ibm.com
Subject: [PATCH] Re: 2.5.8-dj1 : arch/i386/kernel/smpboot.c error
In-Reply-To: <Pine.LNX.4.33.0204152216590.18109-100000@localhost.localdomain>
Content-Type: multipart/mixed;
 boundary="------------070504080702050409050106"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070504080702050409050106
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Frank Davis wrote:
> Hello all,
>   While a 'make bzImage', I received the following compile error:
> Regards,
> Frank
> 
> smpboot.c:1008: parse error before `0'
> smpboot.c: In function `smp_boot_cpus':
> smpboot.c:1023: invalid lvalue in assignment
> make[1]: *** [smpboot.o] Error 1
> make[1]: Leaving directory `/usr/src/linux/arch/i386/kernel'
> make: *** [_dir_arch/i386/kernel] Error 2
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

I reworked the patch to avoid the #define of xquad_portio.  It is still 
much more readable than the original code.  Patch attached against 
2.5.8-dj1.

-- 

						Brian Gerst

--------------070504080702050409050106
Content-Type: text/plain;
 name="io-4"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="io-4"

diff -urN linux-2.5.8-dj1/include/asm-i386/io.h linux/include/asm-i386/io.h
--- linux-2.5.8-dj1/include/asm-i386/io.h	Sun Apr 21 09:14:24 2002
+++ linux/include/asm-i386/io.h	Sun Apr 21 09:27:20 2002
@@ -331,16 +331,8 @@
 
 #ifdef CONFIG_MULTIQUAD
 extern void *xquad_portio;    /* Where the IO area was mapped */
-#else
-#define xquad_portio (0)
-#endif
-
 #define XQUAD_PORT_ADDR(port, quad) (xquad_portio + (XQUAD_PORTIO_QUAD*quad) + port)
-
 #define __BUILDIO(bwl,bw,type) \
-static inline void out##bwl##_local(unsigned type value, int port) { \
-	__asm__ __volatile__("out" #bwl " %" #bw "0, %w1" : : "a"(value), "Nd"(port)); \
-} \
 static inline void out##bwl##_quad(unsigned type value, int port, int quad) { \
 	if (xquad_portio) \
 		write##bwl(value, XQUAD_PORT_ADDR(port, quad)); \
@@ -350,18 +342,6 @@
 static inline void out##bwl(unsigned type value, int port) { \
 	out##bwl##_quad(value, port, 0); \
 } \
-static inline void out##bwl##_p(unsigned type value, int port) { \
-	out##bwl(value, port); \
-	slow_down_io(); \
-} \
-static inline void outs##bwl(int port, const void *addr, unsigned long count) { \
-	__asm__ __volatile__("rep; outs" #bwl : "+S"(addr), "+c"(count) : "d"(port)); \
-} \
-static inline unsigned type in##bwl##_local(int port) { \
-	unsigned type value; \
-	__asm__ __volatile__("in" #bwl " %w1, %" #bw "0" : "=a"(value) : "Nd"(port)); \
-	return value; \
-} \
 static inline unsigned type in##bwl##_quad(int port, int quad) { \
 	if (xquad_portio) \
 		return read##bwl(XQUAD_PORT_ADDR(port, quad)); \
@@ -370,18 +350,46 @@
 } \
 static inline unsigned type in##bwl(int port) { \
 	return in##bwl##_quad(port, 0); \
+}
+#else
+#define __BUILDIO(bwl,bw,type) \
+static inline void out##bwl(unsigned type value, int port) { \
+	out##bwl##_local(value, port); \
+} \
+static inline unsigned type in##bwl(int port) { \
+	return in##bwl##_local(port); \
+}
+#endif
+
+
+#define BUILDIO(bwl,bw,type) \
+static inline void out##bwl##_local(unsigned type value, int port) { \
+	__asm__ __volatile__("out" #bwl " %" #bw "0, %w1" : : "a"(value), "Nd"(port)); \
+} \
+static inline unsigned type in##bwl##_local(int port) { \
+	unsigned type value; \
+	__asm__ __volatile__("in" #bwl " %w1, %" #bw "0" : "=a"(value) : "Nd"(port)); \
+	return value; \
+} \
+__BUILDIO(bwl,bw,type) \
+static inline void out##bwl##_p(unsigned type value, int port) { \
+	out##bwl(value, port); \
+	slow_down_io(); \
 } \
 static inline unsigned type in##bwl##_p(int port) { \
 	unsigned type value = in##bwl(port); \
 	slow_down_io(); \
 	return value; \
 } \
+static inline void outs##bwl(int port, const void *addr, unsigned long count) { \
+	__asm__ __volatile__("rep; outs" #bwl : "+S"(addr), "+c"(count) : "d"(port)); \
+} \
 static inline void ins##bwl(int port, void *addr, unsigned long count) { \
 	__asm__ __volatile__("rep; ins" #bwl : "+D"(addr), "+c"(count) : "d"(port)); \
 }
 
-__BUILDIO(b,b,char)
-__BUILDIO(w,w,short)
-__BUILDIO(l,,long)
+BUILDIO(b,b,char)
+BUILDIO(w,w,short)
+BUILDIO(l,,long)
 
 #endif

--------------070504080702050409050106--

