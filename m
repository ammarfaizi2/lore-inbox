Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263970AbUDVLtn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263970AbUDVLtn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 07:49:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263975AbUDVLtn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 07:49:43 -0400
Received: from amsfep16-int.chello.nl ([213.46.243.26]:65375 "EHLO
	amsfep16-int.chello.nl") by vger.kernel.org with ESMTP
	id S263970AbUDVLs6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 07:48:58 -0400
Date: Thu, 22 Apr 2004 13:48:54 +0200
Message-Id: <200404221148.i3MBmsLU015389@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 445] m68k bitops
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k bitops updates (from Roman Zippel):
  - Optimize find_{first,next}_zero_bit()
  - Add missing implementations of find_{first,next}_bit()

--- linux-2.6.6-rc2/include/asm-m68k/bitops.h	2004-04-05 10:41:52.000000000 +0200
+++ linux-m68k-2.6.6-rc2/include/asm-m68k/bitops.h	2004-04-21 12:56:55.000000000 +0200
@@ -175,51 +175,96 @@ static inline int test_bit(int nr, const
 static inline int find_first_zero_bit(const unsigned long *vaddr,
 				      unsigned size)
 {
-	const unsigned long *p = vaddr, *addr = vaddr;
-	unsigned long allones = ~0UL;
-	int res;
+	const unsigned long *p = vaddr;
+	int res = 32;
 	unsigned long num;

 	if (!size)
 		return 0;

-	size = (size >> 5) + ((size & 31) > 0);
-	while (*p++ == allones)
-	{
-		if (--size == 0)
-			return (p - addr) << 5;
+	size = (size + 31) >> 5;
+	while (!(num = ~*p++)) {
+		if (!--size)
+			goto out;
 	}

-	num = ~*--p;
 	__asm__ __volatile__ ("bfffo %1{#0,#0},%0"
 			      : "=d" (res) : "d" (num & -num));
-	return ((p - addr) << 5) + (res ^ 31);
+	res ^= 31;
+out:
+	return ((long)p - (long)vaddr - 4) * 8 + res;
 }

 static inline int find_next_zero_bit(const unsigned long *vaddr, int size,
 				     int offset)
 {
-	const unsigned long *addr = vaddr;
-	const unsigned long *p = addr + (offset >> 5);
-	int set = 0, bit = offset & 31UL, res;
+	const unsigned long *p = vaddr + (offset >> 5);
+	int bit = offset & 31UL, res;

 	if (offset >= size)
 		return size;

 	if (bit) {
-		unsigned long num = ~*p & (~0UL << bit);
+		unsigned long num = ~*p++ & (~0UL << bit);
+		offset -= bit;

 		/* Look for zero in first longword */
 		__asm__ __volatile__ ("bfffo %1{#0,#0},%0"
 				      : "=d" (res) : "d" (num & -num));
 		if (res < 32)
-			return (offset & ~31UL) + (res ^ 31);
-                set = 32 - bit;
-		p++;
+			return offset + (res ^ 31);
+		offset += 32;
 	}
 	/* No zero yet, search remaining full bytes for a zero */
-	res = find_first_zero_bit (p, size - 32 * (p - addr));
-	return (offset + set + res);
+	res = find_first_zero_bit(p, size - ((long)p - (long)vaddr) * 8);
+	return offset + res;
+}
+
+static inline int find_first_bit(const unsigned long *vaddr, unsigned size)
+{
+	const unsigned long *p = vaddr;
+	int res = 32;
+	unsigned long num;
+
+	if (!size)
+		return 0;
+
+	size = (size + 31) >> 5;
+	while (!(num = *p++)) {
+		if (!--size)
+			goto out;
+	}
+
+	__asm__ __volatile__ ("bfffo %1{#0,#0},%0"
+			      : "=d" (res) : "d" (num & -num));
+	res ^= 31;
+out:
+	return ((long)p - (long)vaddr - 4) * 8 + res;
+}
+
+static inline int find_next_bit(const unsigned long *vaddr, int size,
+				int offset)
+{
+	const unsigned long *p = vaddr + (offset >> 5);
+	int bit = offset & 31UL, res;
+
+	if (offset >= size)
+		return size;
+
+	if (bit) {
+		unsigned long num = *p++ & (~0UL << bit);
+		offset -= bit;
+
+		/* Look for one in first longword */
+		__asm__ __volatile__ ("bfffo %1{#0,#0},%0"
+				      : "=d" (res) : "d" (num & -num));
+		if (res < 32)
+			return offset + (res ^ 31);
+		offset += 32;
+	}
+	/* No one yet, search remaining full bytes for a one */
+	res = find_first_bit(p, size - ((long)p - (long)vaddr) * 8);
+	return offset + res;
 }

 /*

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
