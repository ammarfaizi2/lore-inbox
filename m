Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313925AbSDJXOq>; Wed, 10 Apr 2002 19:14:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313926AbSDJXOp>; Wed, 10 Apr 2002 19:14:45 -0400
Received: from rwcrmhc53.attbi.com ([204.127.198.39]:42686 "EHLO
	rwcrmhc53.attbi.com") by vger.kernel.org with ESMTP
	id <S313925AbSDJXOo>; Wed, 10 Apr 2002 19:14:44 -0400
Message-ID: <3CB4C6EE.5060606@didntduck.org>
Date: Wed, 10 Apr 2002 19:12:46 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>, Martin.Bligh@us.ibm.com
Subject: [PATCH] io.h cleanup (x86)
Content-Type: multipart/mixed;
 boundary="------------070303020709020802070809"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070303020709020802070809
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This patch unravels the mess of macros that create the inX/outX functions.

-- 

						Brian Gerst

--------------070303020709020802070809
Content-Type: text/plain;
 name="io-3"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="io-3"

diff -urN linux-2.5.8-pre2/include/asm-i386/io.h linux/include/asm-i386/io.h
--- linux-2.5.8-pre2/include/asm-i386/io.h	Sun Apr  7 12:12:45 2002
+++ linux/include/asm-i386/io.h	Mon Apr  8 11:19:44 2002
@@ -315,122 +315,73 @@
 #endif /* __KERNEL__ */
 
 #ifdef SLOW_IO_BY_JUMPING
-#define __SLOW_DOWN_IO "\njmp 1f\n1:\tjmp 1f\n1:"
+#define __SLOW_DOWN_IO "jmp 1f; 1: jmp 1f; 1:"
 #else
-#define __SLOW_DOWN_IO "\noutb %%al,$0x80"
+#define __SLOW_DOWN_IO "outb %%al,$0x80;"
 #endif
 
+static inline void slow_down_io(void) {
+	__asm__ __volatile__(
+		__SLOW_DOWN_IO
 #ifdef REALLY_SLOW_IO
-#define __FULL_SLOW_DOWN_IO __SLOW_DOWN_IO __SLOW_DOWN_IO __SLOW_DOWN_IO __SLOW_DOWN_IO
-#else
-#define __FULL_SLOW_DOWN_IO __SLOW_DOWN_IO
+		__SLOW_DOWN_IO __SLOW_DOWN_IO __SLOW_DOWN_IO
 #endif
+		: : );
+}
 
 #ifdef CONFIG_MULTIQUAD
 extern void *xquad_portio;    /* Where the IO area was mapped */
-#endif /* CONFIG_MULTIQUAD */
-
-/*
- * Talk about misusing macros..
- */
-#define __OUT1(s,x) \
-static inline void out##s(unsigned x value, unsigned short port) {
+#else
+#define xquad_portio (0)
+#endif
 
-#define __OUT2(s,s1,s2) \
-__asm__ __volatile__ ("out" #s " %" s1 "0,%" s2 "1"
+#define XQUAD_PORT_ADDR(port, quad) (xquad_portio + (XQUAD_PORTIO_QUAD*quad) + port)
 
-#ifdef CONFIG_MULTIQUAD
-#define __OUTQ(s,ss,x)    /* Do the equivalent of the portio op on quads */ \
-static inline void out##ss(unsigned x value, unsigned short port) { \
-	if (xquad_portio) \
-		write##s(value, (unsigned long) xquad_portio + port); \
-	else               /* We're still in early boot, running on quad 0 */ \
-		out##ss##_local(value, port); \
+#define __BUILDIO(bwl,bw,type) \
+static inline void out##bwl##_local(unsigned type value, int port) { \
+	__asm__ __volatile__("out" #bwl " %" #bw "0, %w1" : : "a"(value), "Nd"(port)); \
 } \
-static inline void out##ss##_quad(unsigned x value, unsigned short port, int quad) { \
-	if (xquad_portio) \
-		write##s(value, (unsigned long) xquad_portio + (XQUAD_PORTIO_QUAD*quad)\
-			+ port); \
-}
-
-#define __INQ(s,ss)       /* Do the equivalent of the portio op on quads */ \
-static inline RETURN_TYPE in##ss(unsigned short port) { \
+static inline void out##bwl##_quad(unsigned type value, int port, int quad) { \
 	if (xquad_portio) \
-		return read##s((unsigned long) xquad_portio + port); \
-	else               /* We're still in early boot, running on quad 0 */ \
-		return in##ss##_local(port); \
+		write##bwl(value, XQUAD_PORT_ADDR(port, quad)); \
+	else \
+		out##bwl##_local(value, port); \
 } \
-static inline RETURN_TYPE in##ss##_quad(unsigned short port, int quad) { \
+static inline void out##bwl(unsigned type value, int port) { \
+	out##bwl##_quad(value, port, 0); \
+} \
+static inline void out##bwl##_p(unsigned type value, int port) { \
+	out##bwl(value, port); \
+	slow_down_io(); \
+} \
+static inline void outs##bwl(int port, const void *addr, unsigned long count) { \
+	__asm__ __volatile__("rep; outs" #bwl : "+S"(addr), "+c"(count) : "d"(port)); \
+} \
+static inline unsigned type in##bwl##_local(int port) { \
+	unsigned type value; \
+	__asm__ __volatile__("in" #bwl " %w1, %" #bw "0" : "=a"(value) : "Nd"(port)); \
+	return value; \
+} \
+static inline unsigned type in##bwl##_quad(int port, int quad) { \
 	if (xquad_portio) \
-		return read##s((unsigned long) xquad_portio + (XQUAD_PORTIO_QUAD*quad)\
-			+ port); \
-	else\
-		return 0;\
+		return read##bwl(XQUAD_PORT_ADDR(port, quad)); \
+	else \
+		return in##bwl##_local(port); \
+} \
+static inline unsigned type in##bwl(int port) { \
+	return in##bwl##_quad(port, 0); \
+} \
+static inline unsigned type in##bwl##_p(int port) { \
+	unsigned type value = in##bwl(port); \
+	slow_down_io(); \
+	return value; \
+} \
+static inline void ins##bwl(int port, void *addr, unsigned long count) { \
+	__asm__ __volatile__("rep; ins" #bwl : "+D"(addr), "+c"(count) : "d"(port)); \
 }
-#endif /* CONFIG_MULTIQUAD */
 
-#ifndef CONFIG_MULTIQUAD
-#define __OUT(s,s1,x) \
-__OUT1(s,x) __OUT2(s,s1,"w") : : "a" (value), "Nd" (port)); } \
-__OUT1(s##_p,x) __OUT2(s,s1,"w") __FULL_SLOW_DOWN_IO : : "a" (value), "Nd" (port));} 
-#else
-/* Make the default portio routines operate on quad 0 */
-#define __OUT(s,s1,x) \
-__OUT1(s##_local,x) __OUT2(s,s1,"w") : : "a" (value), "Nd" (port)); } \
-__OUT1(s##_p_local,x) __OUT2(s,s1,"w") __FULL_SLOW_DOWN_IO : : "a" (value), "Nd" (port));} \
-__OUTQ(s,s,x) \
-__OUTQ(s,s##_p,x) 
-#endif /* CONFIG_MULTIQUAD */
-
-#define __IN1(s) \
-static inline RETURN_TYPE in##s(unsigned short port) { RETURN_TYPE _v;
-
-#define __IN2(s,s1,s2) \
-__asm__ __volatile__ ("in" #s " %" s2 "1,%" s1 "0"
-
-#ifndef CONFIG_MULTIQUAD
-#define __IN(s,s1,i...) \
-__IN1(s) __IN2(s,s1,"w") : "=a" (_v) : "Nd" (port) ,##i ); return _v; } \
-__IN1(s##_p) __IN2(s,s1,"w") __FULL_SLOW_DOWN_IO : "=a" (_v) : "Nd" (port) ,##i ); return _v; } 
-#else
-/* Make the default portio routines operate on quad 0 */
-#define __IN(s,s1,i...) \
-__IN1(s##_local) __IN2(s,s1,"w") : "=a" (_v) : "Nd" (port) ,##i ); return _v; } \
-__IN1(s##_p_local) __IN2(s,s1,"w") __FULL_SLOW_DOWN_IO : "=a" (_v) : "Nd" (port) ,##i ); return _v; } \
-__INQ(s,s) \
-__INQ(s,s##_p) 
-#endif /* CONFIG_MULTIQUAD */
-
-#define __INS(s) \
-static inline void ins##s(unsigned short port, void * addr, unsigned long count) \
-{ __asm__ __volatile__ ("rep ; ins" #s \
-: "=D" (addr), "=c" (count) : "d" (port),"0" (addr),"1" (count)); }
-
-#define __OUTS(s) \
-static inline void outs##s(unsigned short port, const void * addr, unsigned long count) \
-{ __asm__ __volatile__ ("rep ; outs" #s \
-: "=S" (addr), "=c" (count) : "d" (port),"0" (addr),"1" (count)); }
-
-#define RETURN_TYPE unsigned char
-__IN(b,"")
-#undef RETURN_TYPE
-#define RETURN_TYPE unsigned short
-__IN(w,"")
-#undef RETURN_TYPE
-#define RETURN_TYPE unsigned int
-__IN(l,"")
-#undef RETURN_TYPE
-
-__OUT(b,"b",char)
-__OUT(w,"w",short)
-__OUT(l,,int)
-
-__INS(b)
-__INS(w)
-__INS(l)
-
-__OUTS(b)
-__OUTS(w)
-__OUTS(l)
+__BUILDIO(b,b,char)
+__BUILDIO(w,w,short)
+__BUILDIO(l,,long)
 
 #endif

--------------070303020709020802070809--

