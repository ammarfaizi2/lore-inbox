Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267356AbUITUvq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267356AbUITUvq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 16:51:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267354AbUITUvq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 16:51:46 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:12232 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S267350AbUITUva (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 16:51:30 -0400
Date: Mon, 20 Sep 2004 13:49:20 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
cc: akpm@osdl.org, "David S. Miller" <davem@davemloft.net>,
       benh@kernel.crashing.org, wli@holomorphy.com, davem@redhat.com,
       raybry@sgi.com, ak@muc.de, manfred@colorfullife.com,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       vrajesh@umich.edu, hugh@veritas.com
Subject: Re: page fault scalability patch V8: [4/7] universally available
 cmpxchg on i386
In-Reply-To: <200409202043.00580.vda@port.imtp.ilyichevsk.odessa.ua>
Message-ID: <Pine.LNX.4.58.0409201348070.4628@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0408150630560.324@schroedinger.engr.sgi.com>
 <200409191430.37444.vda@port.imtp.ilyichevsk.odessa.ua>
 <Pine.LNX.4.58.0409200844460.3633@schroedinger.engr.sgi.com>
 <200409202043.00580.vda@port.imtp.ilyichevsk.odessa.ua>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Sep 2004, Denis Vlasenko wrote:

> I think it shouldn't be this way.
>
> OTOH for !CONFIG_386 case it makes perfect sense to have it inlined.

Would the following revised patch be acceptable?

Index: linux-2.6.9-rc2/include/asm-i386/system.h
===================================================================
--- linux-2.6.9-rc2.orig/include/asm-i386/system.h	2004-09-12 22:31:26.000000000 -0700
+++ linux-2.6.9-rc2/include/asm-i386/system.h	2004-09-20 13:44:49.000000000 -0700
@@ -240,7 +240,24 @@
  */

 #ifdef CONFIG_X86_CMPXCHG
+
 #define __HAVE_ARCH_CMPXCHG 1
+#define cmpxchg(ptr,o,n)\
+	((__typeof__(*(ptr)))__cmpxchg((ptr),(unsigned long)(o),\
+					(unsigned long)(n),sizeof(*(ptr))))
+
+#else
+
+/*
+ * Building a kernel capable running on 80386. It may be necessary to
+ * simulate the cmpxchg on the 80386 CPU.
+ */
+
+extern unsigned long cmpxchg_386(void *,unsigned long,unsigned long);
+
+#define cmpxchg(ptr,o,n)\
+	((__typeof__(*(ptr)))cmpxchg_386((ptr),(unsigned long)(o),\
+					(unsigned long)(n),sizeof(*(ptr))))
 #endif

 static inline unsigned long __cmpxchg(volatile void *ptr, unsigned long old,
@@ -270,10 +287,32 @@
 	return old;
 }

-#define cmpxchg(ptr,o,n)\
-	((__typeof__(*(ptr)))__cmpxchg((ptr),(unsigned long)(o),\
-					(unsigned long)(n),sizeof(*(ptr))))
-
+static inline unsigned long long __cmpxchg8b(volatile unsigned long long *ptr,
+	       unsigned long long old, unsigned long long newv)
+{
+	unsigned long long prev;
+	 __asm__ __volatile__(
+	LOCK_PREFIX "cmpxchg8b %4\n"
+	: "=A" (prev)
+	: "0" (old), "c" ((unsigned long)(newv >> 32)),
+       		"b" ((unsigned long)(newv & 0xffffffffLL)), "m" (ptr)
+	: "memory");
+	return prev ;
+}
+
+#ifdef CONFIG_X86_CMPXCHG8B
+#define cmpxchg8b __cmpxchg8b
+#else
+/*
+ * Building a kernel capable of running on 80486 and 80386. Both
+ * do not support cmpxchg8b. Call a function that emulates the
+ * instruction if necessary.
+ */
+extern unsigned long long cmpxchg_486(unsigned long long *,
+				unsigned long long, unsigned long long);
+#define cmpxchg8b cmpxchg8b_486
+#endif
+
 #ifdef __KERNEL__
 struct alt_instr {
 	__u8 *instr; 		/* original instruction */
Index: linux-2.6.9-rc2/arch/i386/Kconfig
===================================================================
--- linux-2.6.9-rc2.orig/arch/i386/Kconfig	2004-09-20 08:57:47.000000000 -0700
+++ linux-2.6.9-rc2/arch/i386/Kconfig	2004-09-20 10:11:45.000000000 -0700
@@ -345,6 +345,11 @@
 	depends on !M386
 	default y

+config X86_CMPXCHG8B
+	bool
+	depends on !M386 && !M486
+	default y
+
 config X86_XADD
 	bool
 	depends on !M386
Index: linux-2.6.9-rc2/arch/i386/kernel/cpu/intel.c
===================================================================
--- linux-2.6.9-rc2.orig/arch/i386/kernel/cpu/intel.c	2004-09-12 22:31:59.000000000 -0700
+++ linux-2.6.9-rc2/arch/i386/kernel/cpu/intel.c	2004-09-20 13:44:08.000000000 -0700
@@ -415,5 +415,68 @@
 	return 0;
 }

+#ifndef CONFIG_X86_CMPXCHG
+/*
+ * Atomic compare and exchange.  Compare OLD with MEM, if identical,
+ * store NEW in MEM.  Return the initial value in MEM.  Success is
+ * indicated by comparing RETURN with OLD.
+ */
+
+unsigned long cmpxchg_386(volatile void *ptr, unsigned long old,
+				      unsigned long new, int size)
+{
+	unsigned long prev;
+	/*
+	 * Check if the kernel was compiled for an old cpu but the
+	 * currently running cpu can do cmpxchg after all
+	 */
+	unsigned long flags;
+
+	/* All CPUs except 386 support CMPXCHG */
+	if (cpu_data->x86 > 3) return __cmpxchg(ptr, old, new, size);
+
+	/* Poor man's cmpxchg for 386. Unsuitable for SMP */
+	local_irq_save(flags);
+	switch (size) {
+	case 1:
+		prev = * (u8 *)ptr;
+		if (prev == old) *(u8 *)ptr = new;
+		break;
+	case 2:
+		prev = * (u16 *)ptr;
+		if (prev == old) *(u16 *)ptr = new;
+	case 4:
+		prev = *(u32 *)ptr;
+		if (prev == old) *(u32 *)ptr = new;
+		break;
+	}
+	local_irq_restore(flags);
+	return prev;
+}
+#endif
+
+#ifndef CONFIG_X86_CMPXCHG8B
+unsigned long long cmpxchg8b_486(unsigned long long *ptr,
+	       unsigned long long old, unsigned long long newv)
+{
+	unsigned long long prev;
+	unsigned long flags;
+
+	/*
+	 * Check if the kernel was compiled for an old cpu but
+	 * we are running really on a cpu capable of cmpxchg8b
+	 */
+
+	if (cpu_has(cpu_data, X86_FEATURE_CX8)) return __cmpxchg8b(ptr, old newv);
+
+	/* Poor mans cmpxchg8b for 386 and 486. Not suitable for SMP */
+	local_irq_save(flags);
+	prev = *ptr;
+	if (prev == old) *ptr = newv;
+	local_irq_restore(flags);
+	return prev;
+}
+#endif
+
 // arch_initcall(intel_cpu_init);

