Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261219AbUBTM5i (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 07:57:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261220AbUBTMzs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 07:55:48 -0500
Received: from amsfep14-int.chello.nl ([213.46.243.22]:52510 "EHLO
	amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id S261219AbUBTMxN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 07:53:13 -0500
Date: Fri, 20 Feb 2004 13:48:22 +0100
Message-Id: <200402201248.i1KCmM1a004305@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 411] M68k cmpxchg
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k: Add missing implementation of cmpxchg() (from Andreas Schwab, Roman
Zippel and me)

--- linux-2.6.3/include/asm-m68k/system.h	2004-01-21 22:03:56.000000000 +0100
+++ linux-m68k-2.6.3/include/asm-m68k/system.h	2004-02-06 11:43:52.000000000 +0100
@@ -158,6 +158,42 @@
 }
 #endif
 
+/*
+ * Atomic compare and exchange.  Compare OLD with MEM, if identical,
+ * store NEW in MEM.  Return the initial value in MEM.  Success is
+ * indicated by comparing RETURN with OLD.
+ */
+#ifdef CONFIG_RMW_INSNS
+#define __HAVE_ARCH_CMPXCHG	1
+
+static inline unsigned long __cmpxchg(volatile void *p, unsigned long old,
+				      unsigned long new, int size)
+{
+	switch (size) {
+	case 1:
+		__asm__ __volatile__ ("casb %0,%2,%1"
+				      : "=d" (old), "=m" (*(char *)p)
+				      : "d" (new), "0" (old), "m" (*(char *)p));
+		break;
+	case 2:
+		__asm__ __volatile__ ("casw %0,%2,%1"
+				      : "=d" (old), "=m" (*(short *)p)
+				      : "d" (new), "0" (old), "m" (*(short *)p));
+		break;
+	case 4:
+		__asm__ __volatile__ ("casl %0,%2,%1"
+				      : "=d" (old), "=m" (*(int *)p)
+				      : "d" (new), "0" (old), "m" (*(int *)p));
+		break;
+	}
+	return old;
+}
+
+#define cmpxchg(ptr,o,n)\
+	((__typeof__(*(ptr)))__cmpxchg((ptr),(unsigned long)(o),\
+					(unsigned long)(n),sizeof(*(ptr))))
+#endif
+
 #endif /* __KERNEL__ */
 
 #endif /* _M68K_SYSTEM_H */

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
