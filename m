Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261881AbVCUUho@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261881AbVCUUho (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 15:37:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261875AbVCUUeh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 15:34:37 -0500
Received: from amsfep12-int.chello.nl ([213.46.243.17]:21305 "EHLO
	amsfep12-int.chello.nl") by vger.kernel.org with ESMTP
	id S261866AbVCUUcq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 15:32:46 -0500
Date: Mon, 21 Mar 2005 21:25:50 +0100
Message-Id: <200503212025.j2LKPo13011327@anakin.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 545] M68k: IP checksum updates
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k: IP checksum updates:
  - ip_fast_csum() needs a "memory" constraint with new gcc versions
  - Do not always use d0 in ip_fast_csum(), leave register allocation to gcc
  - Fixed constraints of csum_fold()
  - Fixed constraints of csum_tcpudp_nofold()
  - Moved comment for csum_tcpudp_magic() to the right place

Signed-off-by: Kars de Jong <jongk@linux-m68k.org>
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

--- linux-2.6.12-rc1/include/asm-m68k/checksum.h	2 Mar 2005 23:47:59 -0000	1.7
+++ linux-m68k-2.6.12-rc1/include/asm-m68k/checksum.h	9 Mar 2005 21:02:17 -0000	1.8
@@ -43,20 +43,21 @@
 ip_fast_csum(unsigned char *iph, unsigned int ihl)
 {
 	unsigned int sum = 0;
+	unsigned long tmp;
 
 	__asm__ ("subqw #1,%2\n"
 		 "1:\t"
-		 "movel %1@+,%/d0\n\t"
-		 "addxl %/d0,%0\n\t"
+		 "movel %1@+,%3\n\t"
+		 "addxl %3,%0\n\t"
 		 "dbra  %2,1b\n\t"
-		 "movel %0,%/d0\n\t"
-		 "swap  %/d0\n\t"
-		 "addxw %/d0,%0\n\t"
-		 "clrw  %/d0\n\t"
-		 "addxw %/d0,%0\n\t"
-		 : "=d" (sum), "=a" (iph), "=d" (ihl)
+		 "movel %0,%3\n\t"
+		 "swap  %3\n\t"
+		 "addxw %3,%0\n\t"
+		 "clrw  %3\n\t"
+		 "addxw %3,%0\n\t"
+		 : "=d" (sum), "=&a" (iph), "=&d" (ihl), "=&d" (tmp)
 		 : "0" (sum), "1" (iph), "2" (ihl)
-		 : "d0");
+		 : "memory");
 	return ~sum;
 }
 
@@ -72,31 +73,31 @@
 		"clrw %1\n\t"
 		"addxw %1, %0"
 		: "=&d" (sum), "=&d" (tmp)
-		: "0" (sum), "1" (sum));
+		: "0" (sum), "1" (tmp));
 	return ~sum;
 }
 
 
-/*
- * computes the checksum of the TCP/UDP pseudo-header
- * returns a 16-bit checksum, already complemented
- */
-
 static inline unsigned int
 csum_tcpudp_nofold(unsigned long saddr, unsigned long daddr, unsigned short len,
 		  unsigned short proto, unsigned int sum)
 {
-	__asm__ ("addl  %1,%0\n\t"
+	__asm__ ("addl  %2,%0\n\t"
+		 "addxl %3,%0\n\t"
 		 "addxl %4,%0\n\t"
-		 "addxl %5,%0\n\t"
 		 "clrl %1\n\t"
 		 "addxl %1,%0"
-		 : "=&d" (sum), "=&d" (saddr)
-		 : "0" (daddr), "1" (saddr), "d" (len + proto),
-		   "d"(sum));
+		 : "=&d" (sum), "=d" (saddr)
+		 : "g" (daddr), "1" (saddr), "d" (len + proto),
+		   "0" (sum));
 	return sum;
 }
 
+
+/*
+ * computes the checksum of the TCP/UDP pseudo-header
+ * returns a 16-bit checksum, already complemented
+ */
 static inline unsigned short int
 csum_tcpudp_magic(unsigned long saddr, unsigned long daddr, unsigned short len,
 		  unsigned short proto, unsigned int sum)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
