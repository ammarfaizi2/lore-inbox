Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263512AbTDMM75 (for <rfc822;willy@w.ods.org>); Sun, 13 Apr 2003 08:59:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263496AbTDMM7c (for <rfc822;linux-kernel-outgoing>);
	Sun, 13 Apr 2003 08:59:32 -0400
Received: from amsfep16-int.chello.nl ([213.46.243.26]:1355 "EHLO
	amsfep16-int.chello.nl") by vger.kernel.org with ESMTP
	id S263499AbTDMM4M (for <rfc822;linux-kernel@vger.kernel.org>); Sun, 13 Apr 2003 08:56:12 -0400
Date: Sun, 13 Apr 2003 15:05:14 +0200
Message-Id: <200304131305.h3DD5EqZ001287@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] M68k raw I/O updates
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k raw I/O updates:
  - Convert raw I/O access macros to inline functions:
      o raw_{in,out}s[bw]()
      o raw_{in,out}sw_swapw()
  - Add raw_{in,out}sl() (needed for IDE)
  - Update isa_[im]t_[bw]() for stricter type checking of inline functions

--- linux-2.4.21-pre7/include/asm-m68k/io.h	Sun Apr  6 10:29:44 2003
+++ linux-m68k-2.4.21-pre7/include/asm-m68k/io.h	Sun Mar 30 22:22:41 2003
@@ -120,66 +120,66 @@
  * be compiled in so the case statement will be optimised away
  */
 
-static inline unsigned long isa_itb(long addr)
+static inline unsigned char *isa_itb(long addr)
 {
   switch(ISA_TYPE)
     {
 #ifdef CONFIG_Q40
-    case Q40_ISA: return Q40_ISA_IO_B(addr);
+    case Q40_ISA: return (unsigned char *)Q40_ISA_IO_B(addr);
 #endif
 #ifdef CONFIG_GG2
-    case GG2_ISA: return GG2_ISA_IO_B(addr);
+    case GG2_ISA: return (unsigned char *)GG2_ISA_IO_B(addr);
 #endif
 #ifdef CONFIG_AMIGA_PCMCIA
-    case AG_ISA: return AG_ISA_IO_B(addr);
+    case AG_ISA: return (unsigned char *)AG_ISA_IO_B(addr);
 #endif
     default: return 0; /* avoid warnings, just in case */
     }
 }
-static inline unsigned long isa_itw(long addr)
+static inline unsigned short *isa_itw(long addr)
 {
   switch(ISA_TYPE)
     {
 #ifdef CONFIG_Q40
-    case Q40_ISA: return Q40_ISA_IO_W(addr);
+    case Q40_ISA: return (unsigned short *)Q40_ISA_IO_W(addr);
 #endif
 #ifdef CONFIG_GG2
-    case GG2_ISA: return GG2_ISA_IO_W(addr);
+    case GG2_ISA: return (unsigned short *)GG2_ISA_IO_W(addr);
 #endif
 #ifdef CONFIG_AMIGA_PCMCIA
-    case AG_ISA: return AG_ISA_IO_W(addr);
+    case AG_ISA: return (unsigned short *)AG_ISA_IO_W(addr);
 #endif
     default: return 0; /* avoid warnings, just in case */
     }
 }
-static inline unsigned long isa_mtb(long addr)
+static inline unsigned char *isa_mtb(long addr)
 {
   switch(ISA_TYPE)
     {
 #ifdef CONFIG_Q40
-    case Q40_ISA: return Q40_ISA_MEM_B(addr);
+    case Q40_ISA: return (unsigned char *)Q40_ISA_MEM_B(addr);
 #endif
 #ifdef CONFIG_GG2
-    case GG2_ISA: return GG2_ISA_MEM_B(addr);
+    case GG2_ISA: return (unsigned char *)GG2_ISA_MEM_B(addr);
 #endif
 #ifdef CONFIG_AMIGA_PCMCIA
-    case AG_ISA: return addr;
+    case AG_ISA: return (unsigned char *)addr;
 #endif
     default: return 0; /* avoid warnings, just in case */
     }
 }
-static inline unsigned long isa_mtw(long addr)
+static inline unsigned short *isa_mtw(long addr)
 {
   switch(ISA_TYPE)
     {
 #ifdef CONFIG_Q40
-    case Q40_ISA: return Q40_ISA_MEM_W(addr);
+    case Q40_ISA: return (unsigned short *)Q40_ISA_MEM_W(addr);
 #endif
 #ifdef CONFIG_GG2
-    case GG2_ISA: return GG2_ISA_MEM_W(addr);
+    case GG2_ISA: return (unsigned short *)GG2_ISA_MEM_W(addr);
 #endif
 #ifdef CONFIG_AMIGA_PCMCIA
-    case AG_ISA: return addr;
+    case AG_ISA: return (unsigned short *)addr;
 #endif
     default: return 0; /* avoid warnings, just in case */
     }
@@ -255,7 +255,7 @@
 #define readl(addr)      in_le32(addr)
 #define writel(val,addr) out_le32((addr),(val))
 
-/* those can be defined for both ISA and PCI - it wont work though */
+/* those can be defined for both ISA and PCI - it won't work though */
 #define readb(addr)       in_8(addr)
 #define readw(addr)       in_le16(addr)
 #define writeb(val,addr)  out_8((addr),(val))
--- linux-2.4.21-pre7/include/asm-m68k/raw_io.h	Sun Apr  6 10:29:45 2003
+++ linux-m68k-2.4.21-pre7/include/asm-m68k/raw_io.h	Sun Mar 30 22:22:41 2003
@@ -52,208 +52,290 @@
 #define raw_outw(val,port) out_be16((port),(val))
 #define raw_outl(val,port) out_be32((port),(val))
 
-#define raw_insb(port, buf, len) ({	   \
-	volatile unsigned char *_port = (volatile unsigned char *) (port);   \
-        unsigned char *_buf =(unsigned char *)(buf);	   \
-        unsigned int  _i,_len=(unsigned int)(len);	   \
-        for(_i=0; _i< _len; _i++)  \
-           *_buf++=in_8(_port);      \
-  })
-
-#define raw_outsb(port, buf, len) ({	   \
-	volatile unsigned char *_port = (volatile unsigned char *) (port);   \
-        unsigned char *_buf =(unsigned char *)(buf);	   \
-        unsigned int  _i,_len=(unsigned int)(len);	   \
-        for( _i=0; _i< _len; _i++)  \
-           out_8(_port,*_buf++);      \
-  })
- 
-
-#define raw_insw(port, buf, nr) ({				\
-	volatile unsigned char *_port = (volatile unsigned char *) (port);	\
-	unsigned char *_buf = (unsigned char *)(buf);			\
-	unsigned int _nr = (unsigned int)(nr);					\
-	unsigned long _tmp;				\
-							\
-	if (_nr & 15) {					\
-		_tmp = (_nr & 15) - 1;			\
-		asm volatile (				\
-			"1: movew %2@,%0@+; dbra %1,1b"	\
-			: "=a" (_buf), "=d" (_tmp)	\
-			: "a" (_port), "0" (_buf),	\
-			  "1" (_tmp));			\
-	}						\
-	if (_nr >> 4) {					\
-		_tmp = (_nr >> 4) - 1;			\
-		asm volatile (				\
-			"1: "				\
-			"movew %2@,%0@+; "		\
-			"movew %2@,%0@+; "		\
-			"movew %2@,%0@+; "		\
-			"movew %2@,%0@+; "		\
-			"movew %2@,%0@+; "		\
-			"movew %2@,%0@+; "		\
-			"movew %2@,%0@+; "		\
-			"movew %2@,%0@+; "		\
-			"movew %2@,%0@+; "		\
-			"movew %2@,%0@+; "		\
-			"movew %2@,%0@+; "		\
-			"movew %2@,%0@+; "		\
-			"movew %2@,%0@+; "		\
-			"movew %2@,%0@+; "		\
-			"movew %2@,%0@+; "		\
-			"movew %2@,%0@+; "		\
-			"dbra %1,1b"			\
-			: "=a" (_buf), "=d" (_tmp)	\
-			: "a" (_port), "0" (_buf),	\
-			  "1" (_tmp));			\
-	}						\
-})
-
-#define raw_outsw(port, buf, nr) ({				\
-	volatile unsigned char *_port = (volatile unsigned char *) (port);	\
-	unsigned char *_buf = (unsigned char *)(buf);			\
-	unsigned int _nr = (unsigned int)(nr);					\
-	unsigned long _tmp;				\
-							\
-	if (_nr & 15) {					\
-		_tmp = (_nr & 15) - 1;			\
-		asm volatile (				\
-			"1: movew %0@+,%2@; dbra %1,1b"	\
-			: "=a" (_buf), "=d" (_tmp)	\
-			: "a" (_port), "0" (_buf),	\
-			  "1" (_tmp));			\
-	}						\
-	if (_nr >> 4) {					\
-		_tmp = (_nr >> 4) - 1;			\
-		asm volatile (				\
-			"1: "				\
-			"movew %0@+,%2@; "		\
-			"movew %0@+,%2@; "		\
-			"movew %0@+,%2@; "		\
-			"movew %0@+,%2@; "		\
-			"movew %0@+,%2@; "		\
-			"movew %0@+,%2@; "		\
-			"movew %0@+,%2@; "		\
-			"movew %0@+,%2@; "		\
-			"movew %0@+,%2@; "		\
-			"movew %0@+,%2@; "		\
-			"movew %0@+,%2@; "		\
-			"movew %0@+,%2@; "		\
-			"movew %0@+,%2@; "		\
-			"movew %0@+,%2@; "		\
-			"movew %0@+,%2@; "		\
-			"movew %0@+,%2@; "		\
-			"dbra %1,1b"	   		\
-			: "=a" (_buf), "=d" (_tmp)	\
-			: "a" (_port), "0" (_buf),	\
-			  "1" (_tmp));			\
-	}						\
-})
-
-
-#define raw_insw_swapw(port, buf, nr) \
-({  if ((nr) % 8) \
-	__asm__ __volatile__ \
-	       ("movel %0,%/a0; \
-		 movel %1,%/a1; \
-		 movel %2,%/d6; \
-		 subql #1,%/d6; \
-	       1:movew %/a0@,%/d0; \
-		 rolw  #8,%/d0; \
-		 movew %/d0,%/a1@+; \
-		 dbra %/d6,1b"  \
-		:               \
-		: "g" (port), "g" (buf), "g" (nr) \
-		: "d0", "a0", "a1", "d6"); \
-    else \
-	__asm__ __volatile__ \
-	       ("movel %0,%/a0; \
-		 movel %1,%/a1; \
-		 movel %2,%/d6; \
-		 lsrl  #3,%/d6; \
-		 subql #1,%/d6; \
-	       1:movew %/a0@,%/d0; \
-		 rolw  #8,%/d0; \
-		 movew %/d0,%/a1@+; \
-		 movew %/a0@,%/d0; \
-		 rolw  #8,%/d0; \
-		 movew %/d0,%/a1@+; \
-		 movew %/a0@,%/d0; \
-		 rolw  #8,%/d0; \
-		 movew %/d0,%/a1@+; \
-		 movew %/a0@,%/d0; \
-		 rolw  #8,%/d0; \
-		 movew %/d0,%/a1@+; \
-		 movew %/a0@,%/d0; \
-		 rolw  #8,%/d0; \
-		 movew %/d0,%/a1@+; \
-		 movew %/a0@,%/d0; \
-		 rolw  #8,%/d0; \
-		 movew %/d0,%/a1@+; \
-		 movew %/a0@,%/d0; \
-		 rolw  #8,%/d0; \
-		 movew %/d0,%/a1@+; \
-		 movew %/a0@,%/d0; \
-		 rolw  #8,%/d0; \
-		 movew %/d0,%/a1@+; \
-		 dbra %/d6,1b"  \
-                :               \
-		: "g" (port), "g" (buf), "g" (nr) \
-		: "d0", "a0", "a1", "d6"); \
-})
-
-
-#define raw_outsw_swapw(port, buf, nr) \
-({  if ((nr) % 8) \
-	__asm__ __volatile__ \
-	       ("movel %0,%/a0; \
-		 movel %1,%/a1; \
-		 movel %2,%/d6; \
-		 subql #1,%/d6; \
-	       1:movew %/a1@+,%/d0; \
-		 rolw  #8,%/d0; \
-		 movew %/d0,%/a0@; \
-		 dbra %/d6,1b"  \
-                :               \
-		: "g" (port), "g" (buf), "g" (nr) \
-		: "d0", "a0", "a1", "d6"); \
-    else \
-	__asm__ __volatile__ \
-	       ("movel %0,%/a0; \
-		 movel %1,%/a1; \
-		 movel %2,%/d6; \
-		 lsrl  #3,%/d6; \
-		 subql #1,%/d6; \
-	       1:movew %/a1@+,%/d0; \
-		 rolw  #8,%/d0; \
-		 movew %/d0,%/a0@; \
-		 movew %/a1@+,%/d0; \
-		 rolw  #8,%/d0; \
-		 movew %/d0,%/a0@; \
-		 movew %/a1@+,%/d0; \
-		 rolw  #8,%/d0; \
-		 movew %/d0,%/a0@; \
-		 movew %/a1@+,%/d0; \
-		 rolw  #8,%/d0; \
-		 movew %/d0,%/a0@; \
-		 movew %/a1@+,%/d0; \
-		 rolw  #8,%/d0; \
-		 movew %/d0,%/a0@; \
-		 movew %/a1@+,%/d0; \
-		 rolw  #8,%/d0; \
-		 movew %/d0,%/a0@; \
-		 movew %/a1@+,%/d0; \
-		 rolw  #8,%/d0; \
-		 movew %/d0,%/a0@; \
-		 movew %/a1@+,%/d0; \
-		 rolw  #8,%/d0; \
-		 movew %/d0,%/a0@; \
-		 dbra %/d6,1b"  \
-                :               \
-		: "g" (port), "g" (buf), "g" (nr) \
-		: "d0", "a0", "a1", "d6"); \
-})
+static inline void raw_insb(volatile unsigned char *port, unsigned char *buf,
+			    unsigned int len)
+{
+	unsigned int i;
+
+        for (i = 0; i < len; i++)
+		*buf++ = in_8(port);
+}
+
+static inline void raw_outsb(volatile unsigned char *port,
+			     const unsigned char *buf, unsigned int len)
+{
+	unsigned int i;
+
+        for (i = 0; i < len; i++)
+		out_8(port, *buf++);
+}
+
+static inline void raw_insw(volatile unsigned short *port, unsigned short *buf,
+			    unsigned int nr)
+{
+	unsigned int tmp;
+
+	if (nr & 15) {
+		tmp = (nr & 15) - 1;
+		asm volatile (
+			"1: movew %2@,%0@+; dbra %1,1b"
+			: "=a" (buf), "=d" (tmp)
+			: "a" (port), "0" (buf),
+			  "1" (tmp));
+	}
+	if (nr >> 4) {
+		tmp = (nr >> 4) - 1;
+		asm volatile (
+			"1: "
+			"movew %2@,%0@+; "
+			"movew %2@,%0@+; "
+			"movew %2@,%0@+; "
+			"movew %2@,%0@+; "
+			"movew %2@,%0@+; "
+			"movew %2@,%0@+; "
+			"movew %2@,%0@+; "
+			"movew %2@,%0@+; "
+			"movew %2@,%0@+; "
+			"movew %2@,%0@+; "
+			"movew %2@,%0@+; "
+			"movew %2@,%0@+; "
+			"movew %2@,%0@+; "
+			"movew %2@,%0@+; "
+			"movew %2@,%0@+; "
+			"movew %2@,%0@+; "
+			"dbra %1,1b"
+			: "=a" (buf), "=d" (tmp)
+			: "a" (port), "0" (buf),
+			  "1" (tmp));
+	}
+}
+
+static inline void raw_outsw(volatile unsigned short *port,
+			     const unsigned short *buf, unsigned int nr)
+{
+	unsigned int tmp;
+
+	if (nr & 15) {
+		tmp = (nr & 15) - 1;
+		asm volatile (
+			"1: movew %0@+,%2@; dbra %1,1b"
+			: "=a" (buf), "=d" (tmp)
+			: "a" (port), "0" (buf),
+			  "1" (tmp));
+	}
+	if (nr >> 4) {
+		tmp = (nr >> 4) - 1;
+		asm volatile (
+			"1: "
+			"movew %0@+,%2@; "
+			"movew %0@+,%2@; "
+			"movew %0@+,%2@; "
+			"movew %0@+,%2@; "
+			"movew %0@+,%2@; "
+			"movew %0@+,%2@; "
+			"movew %0@+,%2@; "
+			"movew %0@+,%2@; "
+			"movew %0@+,%2@; "
+			"movew %0@+,%2@; "
+			"movew %0@+,%2@; "
+			"movew %0@+,%2@; "
+			"movew %0@+,%2@; "
+			"movew %0@+,%2@; "
+			"movew %0@+,%2@; "
+			"movew %0@+,%2@; "
+			"dbra %1,1b"
+			: "=a" (buf), "=d" (tmp)
+			: "a" (port), "0" (buf),
+			  "1" (tmp));
+	}
+}
+
+static inline void raw_insl(volatile unsigned int *port, unsigned int *buf,
+			    unsigned int nr)
+{
+	unsigned int tmp;
+
+	if (nr & 15) {
+		tmp = (nr & 15) - 1;
+		asm volatile (
+			"1: movel %2@,%0@+; dbra %1,1b"
+			: "=a" (buf), "=d" (tmp)
+			: "a" (port), "0" (buf),
+			  "1" (tmp));
+	}
+	if (nr >> 4) {
+		tmp = (nr >> 4) - 1;
+		asm volatile (
+			"1: "
+			"movel %2@,%0@+; "
+			"movel %2@,%0@+; "
+			"movel %2@,%0@+; "
+			"movel %2@,%0@+; "
+			"movel %2@,%0@+; "
+			"movel %2@,%0@+; "
+			"movel %2@,%0@+; "
+			"movel %2@,%0@+; "
+			"movel %2@,%0@+; "
+			"movel %2@,%0@+; "
+			"movel %2@,%0@+; "
+			"movel %2@,%0@+; "
+			"movel %2@,%0@+; "
+			"movel %2@,%0@+; "
+			"movel %2@,%0@+; "
+			"movel %2@,%0@+; "
+			"dbra %1,1b"
+			: "=a" (buf), "=d" (tmp)
+			: "a" (port), "0" (buf),
+			  "1" (tmp));
+	}
+}
+
+static inline void raw_outsl(volatile unsigned int *port,
+			     const unsigned int *buf, unsigned int nr)
+{
+	unsigned int tmp;
+
+	if (nr & 15) {
+		tmp = (nr & 15) - 1;
+		asm volatile (
+			"1: movel %0@+,%2@; dbra %1,1b"
+			: "=a" (buf), "=d" (tmp)
+			: "a" (port), "0" (buf),
+			  "1" (tmp));
+	}
+	if (nr >> 4) {
+		tmp = (nr >> 4) - 1;
+		asm volatile (
+			"1: "
+			"movel %0@+,%2@; "
+			"movel %0@+,%2@; "
+			"movel %0@+,%2@; "
+			"movel %0@+,%2@; "
+			"movel %0@+,%2@; "
+			"movel %0@+,%2@; "
+			"movel %0@+,%2@; "
+			"movel %0@+,%2@; "
+			"movel %0@+,%2@; "
+			"movel %0@+,%2@; "
+			"movel %0@+,%2@; "
+			"movel %0@+,%2@; "
+			"movel %0@+,%2@; "
+			"movel %0@+,%2@; "
+			"movel %0@+,%2@; "
+			"movel %0@+,%2@; "
+			"dbra %1,1b"
+			: "=a" (buf), "=d" (tmp)
+			: "a" (port), "0" (buf),
+			  "1" (tmp));
+	}
+}
+
+
+static inline void raw_insw_swapw(volatile unsigned short *port,
+				  unsigned short *buf, unsigned int nr)
+{
+    if ((nr) % 8)
+	__asm__ __volatile__
+	       ("\tmovel %0,%/a0\n\t"
+		"movel %1,%/a1\n\t"
+		"movel %2,%/d6\n\t"
+		"subql #1,%/d6\n"
+		"1:\tmovew %/a0@,%/d0\n\t"
+		"rolw  #8,%/d0\n\t"
+		"movew %/d0,%/a1@+\n\t"
+		"dbra %/d6,1b"
+		:
+		: "g" (port), "g" (buf), "g" (nr)
+		: "d0", "a0", "a1", "d6");
+    else
+	__asm__ __volatile__
+	       ("movel %0,%/a0\n\t"
+		"movel %1,%/a1\n\t"
+		"movel %2,%/d6\n\t"
+		"lsrl  #3,%/d6\n\t"
+		"subql #1,%/d6\n"
+		"1:\tmovew %/a0@,%/d0\n\t"
+		"rolw  #8,%/d0\n\t"
+		"movew %/d0,%/a1@+\n\t"
+		"movew %/a0@,%/d0\n\t"
+		"rolw  #8,%/d0\n\t"
+		"movew %/d0,%/a1@+\n\t"
+		"movew %/a0@,%/d0\n\t"
+		"rolw  #8,%/d0\n\t"
+		"movew %/d0,%/a1@+\n\t"
+		"movew %/a0@,%/d0\n\t"
+		"rolw  #8,%/d0\n\t"
+		"movew %/d0,%/a1@+\n\t"
+		"movew %/a0@,%/d0\n\t"
+		"rolw  #8,%/d0\n\t"
+		"movew %/d0,%/a1@+\n\t"
+		"movew %/a0@,%/d0\n\t"
+		"rolw  #8,%/d0\n\t"
+		"movew %/d0,%/a1@+\n\t"
+		"movew %/a0@,%/d0\n\t"
+		"rolw  #8,%/d0\n\t"
+		"movew %/d0,%/a1@+\n\t"
+		"movew %/a0@,%/d0\n\t"
+		"rolw  #8,%/d0\n\t"
+		"movew %/d0,%/a1@+\n\t"
+		"dbra %/d6,1b"
+                :
+		: "g" (port), "g" (buf), "g" (nr)
+		: "d0", "a0", "a1", "d6");
+}
+
+static inline void raw_outsw_swapw(volatile unsigned short *port,
+				   const unsigned short *buf, unsigned int nr)
+{
+    if ((nr) % 8)
+	__asm__ __volatile__
+	       ("movel %0,%/a0\n\t"
+		"movel %1,%/a1\n\t"
+		"movel %2,%/d6\n\t"
+		"subql #1,%/d6\n"
+		"1:\tmovew %/a1@+,%/d0\n\t"
+		"rolw  #8,%/d0\n\t"
+		"movew %/d0,%/a0@\n\t"
+		"dbra %/d6,1b"
+                :
+		: "g" (port), "g" (buf), "g" (nr)
+		: "d0", "a0", "a1", "d6");
+    else
+	__asm__ __volatile__
+	       ("movel %0,%/a0\n\t"
+		"movel %1,%/a1\n\t"
+		"movel %2,%/d6\n\t"
+		"lsrl  #3,%/d6\n\t"
+		"subql #1,%/d6\n"
+		"1:\tmovew %/a1@+,%/d0\n\t"
+		"rolw  #8,%/d0\n\t"
+		"movew %/d0,%/a0@\n\t"
+		"movew %/a1@+,%/d0\n\t"
+		"rolw  #8,%/d0\n\t"
+		"movew %/d0,%/a0@\n\t"
+		"movew %/a1@+,%/d0\n\t"
+		"rolw  #8,%/d0\n\t"
+		"movew %/d0,%/a0@\n\t"
+		"movew %/a1@+,%/d0\n\t"
+		"rolw  #8,%/d0\n\t"
+		"movew %/d0,%/a0@\n\t"
+		"movew %/a1@+,%/d0\n\t"
+		"rolw  #8,%/d0\n\t"
+		"movew %/d0,%/a0@\n\t"
+		"movew %/a1@+,%/d0\n\t"
+		"rolw  #8,%/d0\n\t"
+		"movew %/d0,%/a0@\n\t"
+		"movew %/a1@+,%/d0\n\t"
+		"rolw  #8,%/d0\n\t"
+		"movew %/d0,%/a0@\n\t"
+		"movew %/a1@+,%/d0\n\t"
+		"rolw  #8,%/d0\n\t"
+		"movew %/d0,%/a0@\n\t"
+		"dbra %/d6,1b"
+                :
+		: "g" (port), "g" (buf), "g" (nr)
+		: "d0", "a0", "a1", "d6");
+}
 
 
 #endif /* __KERNEL__ */

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
