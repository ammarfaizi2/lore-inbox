Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266661AbUF3NFR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266661AbUF3NFR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 09:05:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266663AbUF3NFQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 09:05:16 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:32464 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S266661AbUF3NEt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 09:04:49 -0400
Date: Wed, 30 Jun 2004 15:04:42 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: s390(64) per_cpu in modules (ipv6)
Message-ID: <20040630130442.GA2440@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > It seems to work fine, but I'm wondering if a better fix can
> > be found.
> 
> How does __attribute__((used)) fare?

__attribute_used__ isn't really what we want. If a statically
defined per cpu variable isn't used in the C file then gcc
should be allowed to remove it. It's not used after all.
What we need is a way to tell the compiler that an inline
assembly uses a variable without passing any kind of address
of the variable to it. The solution is the "X" constraint.
While I was at it I cleaned things up a bit, I don't like
the #undefs in percpu.h. Patch is attached, I will include
it in my next update for Andrew.

blue skies,
  Martin.

diff -urN linux-2.6/include/asm-s390/percpu.h linux-2.6-s390/include/asm-s390/percpu.h
--- linux-2.6/include/asm-s390/percpu.h	Wed Jun 16 07:20:04 2004
+++ linux-2.6-s390/include/asm-s390/percpu.h	Wed Jun 30 14:37:45 2004
@@ -1,30 +1,70 @@
 #ifndef __ARCH_S390_PERCPU__
 #define __ARCH_S390_PERCPU__
 
-#include <asm-generic/percpu.h>
+#include <linux/compiler.h>
 #include <asm/lowcore.h>
 
+#define __GENERIC_PER_CPU
+
 /*
- * For builtin kernel code s390 uses the generic implementation for
- * per cpu data, with the exception that the offset of the cpu local
- * data area is cached in the cpu's lowcore memory
+ * s390 uses its own implementation for per cpu data, the offset of
+ * the cpu local data area is cached in the cpu's lowcore memory.
  * For 64 bit module code s390 forces the use of a GOT slot for the
  * address of the per cpu variable. This is needed because the module
  * may be more than 4G above the per cpu area.
  */
 #if defined(__s390x__) && defined(MODULE)
-#define __get_got_cpu_var(var,offset) \
+
+#define __reloc_hide(var,offset) \
   (*({ unsigned long *__ptr; \
-       asm ( "larl %0,per_cpu__"#var"@GOTENT" : "=a" (__ptr) ); \
-       ((typeof(&per_cpu__##var))((*__ptr) + offset)); \
-    }))
-#undef __get_cpu_var
-#define __get_cpu_var(var) __get_got_cpu_var(var,S390_lowcore.percpu_offset)
-#undef per_cpu
-#define per_cpu(var,cpu) __get_got_cpu_var(var,__per_cpu_offset[cpu])
+       asm ( "larl %0,per_cpu__"#var"@GOTENT" \
+             : "=a" (__ptr) : "X" (per_cpu__##var) ); \
+       (typeof(&per_cpu__##var))((*__ptr) + (offset)); }))
+
 #else
-#undef __get_cpu_var
-#define __get_cpu_var(var) (*RELOC_HIDE(&per_cpu__##var, S390_lowcore.percpu_offset))
+
+#define __reloc_hide(var, offset) \
+  (*({ unsigned long __ptr; \
+       asm ( "" : "=a" (__ptr) : "0" (&per_cpu__##var) ); \
+       (typeof(&per_cpu__##var)) (__ptr + (offset)); }))
+
 #endif
 
+#ifdef CONFIG_SMP
+
+extern unsigned long __per_cpu_offset[NR_CPUS];
+
+/* Separate out the type, so (int[3], foo) works. */
+#define DEFINE_PER_CPU(type, name) \
+    __attribute__((__section__(".data.percpu"))) \
+    __typeof__(type) per_cpu__##name
+
+#define __get_cpu_var(var) __reloc_hide(var,S390_lowcore.percpu_offset)
+#define per_cpu(var,cpu) __reloc_hide(var,__per_cpu_offset[cpu])
+
+/* A macro to avoid #include hell... */
+#define percpu_modcopy(pcpudst, src, size)			\
+do {								\
+	unsigned int __i;					\
+	for (__i = 0; __i < NR_CPUS; __i++)			\
+		if (cpu_possible(__i))				\
+			memcpy((pcpudst)+__per_cpu_offset[__i],	\
+			       (src), (size));			\
+} while (0)
+
+#else /* ! SMP */
+
+#define DEFINE_PER_CPU(type, name) \
+    __typeof__(type) per_cpu__##name
+
+#define __get_cpu_var(var) __reloc_hide(var,0)
+#define per_cpu(var,cpu) __reloc_hide(var,0)
+
+#endif /* SMP */
+
+#define DECLARE_PER_CPU(type, name) extern __typeof__(type) per_cpu__##name
+
+#define EXPORT_PER_CPU_SYMBOL(var) EXPORT_SYMBOL(per_cpu__##var)
+#define EXPORT_PER_CPU_SYMBOL_GPL(var) EXPORT_SYMBOL_GPL(per_cpu__##var)
+
 #endif /* __ARCH_S390_PERCPU__ */
