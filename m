Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265890AbUFTRcl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265890AbUFTRcl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 13:32:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265907AbUFTRcd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 13:32:33 -0400
Received: from nl-ams-slo-l4-01-pip-5.chellonetwork.com ([213.46.243.21]:11358
	"EHLO amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id S265890AbUFTR1D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 13:27:03 -0400
Date: Sun, 20 Jun 2004 19:27:04 +0200
Message-Id: <200406201727.i5KHR4lY001559@anakin.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 458] M68k atomic
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k: Add missing atomic operations (from Roman Zippel and me) and replace
`__inline__' by `inline' while we're at it.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

--- linux-2.6.7/include/asm-m68k/atomic.h	2004-05-23 11:32:03.000000000 +0200
+++ linux-m68k-2.6.7/include/asm-m68k/atomic.h	2004-06-20 11:09:03.000000000 +0200
@@ -1,6 +1,8 @@
 #ifndef __ARCH_M68K_ATOMIC__
 #define __ARCH_M68K_ATOMIC__
 
+#include <asm/system.h>	/* local_irq_XXX() */
+
 /*
  * Atomic operations that C can't guarantee us.  Useful for
  * resource counting etc..
@@ -16,39 +18,121 @@ typedef struct { int counter; } atomic_t
 #define atomic_read(v)		((v)->counter)
 #define atomic_set(v, i)	(((v)->counter) = i)
 
-static __inline__ void atomic_add(int i, atomic_t *v)
+static inline void atomic_add(int i, atomic_t *v)
 {
 	__asm__ __volatile__("addl %1,%0" : "+m" (*v) : "id" (i));
 }
 
-static __inline__ void atomic_sub(int i, atomic_t *v)
+static inline void atomic_sub(int i, atomic_t *v)
 {
 	__asm__ __volatile__("subl %1,%0" : "+m" (*v) : "id" (i));
 }
 
-static __inline__ void atomic_inc(atomic_t *v)
+static inline void atomic_inc(atomic_t *v)
 {
 	__asm__ __volatile__("addql #1,%0" : "+m" (*v));
 }
 
-static __inline__ void atomic_dec(atomic_t *v)
+static inline void atomic_dec(atomic_t *v)
 {
 	__asm__ __volatile__("subql #1,%0" : "+m" (*v));
 }
 
-static __inline__ int atomic_dec_and_test(atomic_t *v)
+static inline int atomic_dec_and_test(atomic_t *v)
 {
 	char c;
 	__asm__ __volatile__("subql #1,%1; seq %0" : "=d" (c), "+m" (*v));
 	return c != 0;
 }
 
-static __inline__ void atomic_clear_mask(unsigned long mask, unsigned long *v)
+static inline int atomic_inc_and_test(atomic_t *v)
+{
+	char c;
+	__asm__ __volatile__("addql #1,%1; seq %0" : "=d" (c), "+m" (*v));
+	return c != 0;
+}
+
+#ifdef CONFIG_RMW_INSNS
+static inline int atomic_add_return(int i, atomic_t *v)
+{
+	int t, tmp;
+
+	__asm__ __volatile__(
+			"1:	movel %2,%1\n"
+			"	addl %3,%1\n"
+			"	casl %2,%1,%0\n"
+			"	jne 1b"
+			: "+m" (*v), "=&d" (t), "=&d" (tmp)
+			: "g" (i), "2" (atomic_read(v)));
+	return t;
+}
+
+static inline int atomic_sub_return(int i, atomic_t *v)
+{
+	int t, tmp;
+
+	__asm__ __volatile__(
+			"1:	movel %2,%1\n"
+			"	subl %3,%1\n"
+			"	casl %2,%1,%0\n"
+			"	jne 1b"
+			: "+m" (*v), "=&d" (t), "=&d" (tmp)
+			: "g" (i), "2" (atomic_read(v)));
+	return t;
+}
+#else /* !CONFIG_RMW_INSNS */
+static inline int atomic_add_return(int i, atomic_t * v)
+{
+	unsigned long flags;
+	int t;
+
+	local_irq_save(flags);
+	t = atomic_read(v);
+	t += i;
+	atomic_set(v, t);
+	local_irq_restore(flags);
+
+	return t;
+}
+
+static inline int atomic_sub_return(int i, atomic_t * v)
+{
+	unsigned long flags;
+	int t;
+
+	local_irq_save(flags);
+	t = atomic_read(v);
+	t -= i;
+	atomic_set(v, t);
+	local_irq_restore(flags);
+
+	return t;
+}
+#endif /* !CONFIG_RMW_INSNS */
+
+#define atomic_dec_return(v)	atomic_sub_return(1, (v))
+#define atomic_inc_return(v)	atomic_add_return(1, (v))
+
+static inline int atomic_sub_and_test(int i, atomic_t *v)
+{
+	char c;
+	__asm__ __volatile__("subl %2,%1; seq %0" : "=d" (c), "+m" (*v): "g" (i));
+	return c != 0;
+}
+
+static inline int atomic_add_negative(int i, atomic_t *v)
+{
+	char c;
+	__asm__ __volatile__("addl %2,%1; smi %0" : "=d" (c), "+m" (*v): "g" (i));
+	return c != 0;
+}
+
+static inline void atomic_clear_mask(unsigned long mask, unsigned long *v)
 {
 	__asm__ __volatile__("andl %1,%0" : "+m" (*v) : "id" (~(mask)));
 }
 
-static __inline__ void atomic_set_mask(unsigned long mask, unsigned long *v)
+static inline void atomic_set_mask(unsigned long mask, unsigned long *v)
 {
 	__asm__ __volatile__("orl %1,%0" : "+m" (*v) : "id" (mask));
 }

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
