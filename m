Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263251AbTD0CH4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Apr 2003 22:07:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263253AbTD0CHz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Apr 2003 22:07:55 -0400
Received: from zero.aec.at ([193.170.194.10]:56589 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S263251AbTD0CHu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Apr 2003 22:07:50 -0400
Date: Sun, 27 Apr 2003 04:19:58 +0200
From: Andi Kleen <ak@muc.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Alternative patching for prefetches & cleanup
Message-ID: <20030427021958.GA27897@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch extends and cleans up the early generic CPU alternative patching.

It adds automatic patching for (SSE) prefetches and 3dnow! write
prefetches. This is one step towards making the Athlon kernel work
on Intel CPUs again. It's not fully finished yet because the memcpy
still uses 3dnow!.

I had to split the alternative section into two for this. The reason
is that for big kernels gas or ld would sometimes add a few padding
bytes after the replacement instruction in .altinstructions, and that
would confuse the patcher who relied on knowing the exact length
of the instruction. Now the instructions are in another section 
with a pointer from the main patch record.

It also adds nop types for various CPUs straight from their optimization 
manuals. Now you can always get the fastest nops for K7,K8 and Intel.
I moved them into the include files to make it easy to use them
for padding alternative()s. Some cleanups in the patch function to use this.

Removal of the now obsolete X86_PREFETCH and X86_SSE2 options.

diff -u linux-gencpu/arch/i386/kernel/setup.c-o linux-gencpu/arch/i386/kernel/setup.c
--- linux-gencpu/arch/i386/kernel/setup.c-o	2003-04-25 01:17:20.000000000 +0200
+++ linux-gencpu/arch/i386/kernel/setup.c	2003-04-27 04:12:32.000000000 +0200
@@ -795,41 +795,42 @@
 		pci_mem_start = low_mem_size;
 }
 
+asm("nops: " 
+    ASM_NOP1 ASM_NOP2 ASM_NOP3 ASM_NOP4 ASM_NOP5 ASM_NOP6
+    ASM_NOP7 ASM_NOP8); 
+
+static inline unsigned char *findnop(int num) 
+{
+	extern unsigned char nops[];
+	int i, k = 0;
+	for (i = 1; i < num; i++) 
+		k += i; 
+	return nops + k;
+} 
+
 /* Replace instructions with better alternatives for this CPU type.
 
    This runs before SMP is initialized to avoid SMP problems with
    self modifying code. This implies that assymetric systems where
    APs have less capabilities than the boot processor are not handled. 
-    
    In this case boot with "noreplacement". */ 
 void apply_alternatives(void *start, void *end) 
 { 
 	struct alt_instr *a; 
 	int diff, i, k;
 
-	for (a = start; a < (struct alt_instr *)end; 
-	     a = (void *)ALIGN((unsigned long)(a + 1) + a->instrlen, 4)) { 
+	for (a = start; (void *)a < end; a++) { 
 		if (!boot_cpu_has(a->cpuid))
 			continue;
 		BUG_ON(a->replacementlen > a->instrlen); 
 		memcpy(a->instr, a->replacement, a->replacementlen); 
 		diff = a->instrlen - a->replacementlen; 
+		/* Pad the rest with nops */
 		for (i = a->replacementlen; diff > 0; diff -= k, i += k) {
-			static const char *nops[] = {
-				0,
-				"\x90",
-#if CONFIG_MK7 || CONFIG_MK8
-				"\x66\x90",
-				"\x66\x66\x90",
-				"\x66\x66\x66\x90",
-#else
-				"\x89\xf6",
-				"\x8d\x76\x00",
-				"\x8d\x74\x26\x00",
-#endif
-			};
-			k = min_t(int, diff, ARRAY_SIZE(nops)); 
-			memcpy(a->instr + i, nops[k], k); 
+			k = diff;
+			if (k > ASM_NOP_MAX)
+				k = ASM_NOP_MAX;
+			memcpy(a->instr + i, findnop(k), k); 
 		} 
 	}
 } 
diff -u linux-gencpu/arch/i386/Kconfig-o linux-gencpu/arch/i386/Kconfig
--- linux-gencpu/arch/i386/Kconfig-o	2003-04-27 02:40:32.000000000 +0200
+++ linux-gencpu/arch/i386/Kconfig	2003-04-27 03:50:08.000000000 +0200
@@ -363,16 +370,6 @@
 	depends on MWINCHIP3D || MWINCHIP2 || MWINCHIPC6
 	default y
 
-config X86_PREFETCH
-	bool
-	depends on MPENTIUMIII || MPENTIUM4 || MVIAC3_2
-	default y
-
-config X86_SSE2
-	bool
-	depends on MK8 || MPENTIUM4
-	default y
-
 config HUGETLB_PAGE
 	bool "Huge TLB Page Support"
 	help
diff -u linux-gencpu/arch/i386/vmlinux.lds.S-o linux-gencpu/arch/i386/vmlinux.lds.S
--- linux-gencpu/arch/i386/vmlinux.lds.S-o	2003-04-25 01:17:20.000000000 +0200
+++ linux-gencpu/arch/i386/vmlinux.lds.S	2003-04-27 03:50:08.000000000 +0200
@@ -85,6 +85,7 @@
   __alt_instructions = .;
   .altinstructions : { *(.altinstructions) } 
   __alt_instructions_end = .; 
+ .altinstr_replacement : { *(.altinstr_replacement) }
   . = ALIGN(4096);
   __initramfs_start = .;
   .init.ramfs : { *(.init.ramfs) }
diff -u linux-gencpu/include/asm-i386/processor.h-o linux-gencpu/include/asm-i386/processor.h
--- linux-gencpu/include/asm-i386/processor.h-o	2003-04-20 13:26:38.000000000 +0200
+++ linux-gencpu/include/asm-i386/processor.h	2003-04-27 03:50:08.000000000 +0200
@@ -15,6 +15,7 @@
 #include <asm/sigcontext.h>
 #include <asm/cpufeature.h>
 #include <asm/msr.h>
+#include <asm/system.h>
 #include <linux/cache.h>
 #include <linux/config.h>
 #include <linux/threads.h>
@@ -495,32 +496,61 @@
 
 #define cpu_relax()	rep_nop()
 
-/* Prefetch instructions for Pentium III and AMD Athlon */
-#ifdef 	CONFIG_X86_PREFETCH
+#define ASM_NOP1	".byte 0x90\n"
+#ifdef CONFIG_MK8
+#define ASM_NOP2	".byte 0x66,0x90\n" 
+#define ASM_NOP3	".byte 0x66,0x66,0x90\n" 
+#define ASM_NOP4	".byte 0x66,0x66,0x66,0x90\n" 
+#define ASM_NOP5	ASM_NOP3 ASM_NOP2 
+#define ASM_NOP6	ASM_NOP3 ASM_NOP3
+#define ASM_NOP7	ASM_NOP4 ASM_NOP3
+#define ASM_NOP8	ASM_NOP4 ASM_NOP4
+#elif CONFIG_MK7
+/* uses eax dependencies (arbitary choice) */
+#define ASM_NOP2	".byte 0x8b,0xc0\n" 
+#define ASM_NOP3	".byte 0x8d,0x04,0x20\n"
+#define ASM_NOP4	".byte 0x8d,0x44,0x20,0x00\n"
+#define ASM_NOP5	ASM_NOP4 ASM_NOP1
+#define ASM_NOP6	".byte 0x8d,0x80,0,0,0,0\n"
+#define ASM_NOP7        ".byte 0x8D,0x04,0x05,0,0,0,0\n"
+#define ASM_NOP8        ASM_NOP7 ASM_NOP1
+#else
+/* generic versions from gas */
+#define ASM_NOP2    	".byte 0x89,0xf6\n"
+#define ASM_NOP3        ".byte 0x8d,0x76,0x00\n"
+#define ASM_NOP4        ".byte 0x8d,0x74,0x26,0x00\n"
+#define ASM_NOP5        ASM_NOP1 ASM_NOP4
+#define ASM_NOP6	".byte 0x8d,0xb6,0x00,0x00,0x00,0x00\n"
+#define ASM_NOP7	".byte 0x8d,0xb4,0x26,0x00,0x00,0x00,0x00\n"
+#define ASM_NOP8	ASM_NOP1 ASM_NOP7
+#endif
+#define ASM_NOP_MAX 8
 
+/* Prefetch instructions for Pentium III and AMD Athlon */
+/* It's not worth to care about 3dnow! prefetches for the K6
+   because they are microcoded there and very slow. */
 #define ARCH_HAS_PREFETCH
 extern inline void prefetch(const void *x)
 {
-	__asm__ __volatile__ ("prefetchnta (%0)" : : "r"(x));
+	alternative_input(ASM_NOP3,
+			  "prefetchnta (%1)",
+			  X86_FEATURE_XMM,
+			  "r" (x));
 }
 
-#elif defined CONFIG_X86_USE_3DNOW
-
 #define ARCH_HAS_PREFETCH
 #define ARCH_HAS_PREFETCHW
 #define ARCH_HAS_SPINLOCK_PREFETCH
 
-extern inline void prefetch(const void *x)
-{
-	 __asm__ __volatile__ ("prefetch (%0)" : : "r"(x));
-}
-
+/* 3dnow! prefetch to get an exclusive cache line. Useful for 
+   spinlocks to avoid one state transition in the cache coherency protocol. */
 extern inline void prefetchw(const void *x)
 {
-	 __asm__ __volatile__ ("prefetchw (%0)" : : "r"(x));
+	alternative_input(ASM_NOP3,
+			  "prefetchw (%1)",
+			  X86_FEATURE_3DNOW,
+			  "r" (x));
 }
 #define spin_lock_prefetch(x)	prefetchw(x)
 
-#endif
-
 #endif /* __ASM_I386_PROCESSOR_H */
diff -u linux-gencpu/include/asm-i386/system.h-o linux-gencpu/include/asm-i386/system.h
--- linux-gencpu/include/asm-i386/system.h-o	2003-04-25 01:17:37.000000000 +0200
+++ linux-gencpu/include/asm-i386/system.h	2003-04-27 03:50:08.000000000 +0200
@@ -279,10 +279,11 @@
 
 struct alt_instr { 
 	u8 *instr; 		/* original instruction */
+	u8 *replacement;
 	u8  cpuid;		/* cpuid bit set for replacement */
 	u8  instrlen;		/* length of original instruction */
 	u8  replacementlen; 	/* length of new instruction, <= instrlen */ 
-	u8  replacement[0];   	/* new instruction */
+	u8  pad;
 }; 
 
 /* 
@@ -302,13 +303,40 @@
 		      ".section .altinstructions,\"a\"\n"     	     \
 		      "  .align 4\n"				       \
 		      "  .long 661b\n"            /* label */          \
+		      "  .long 663f\n"		  /* new instruction */ 	\
 		      "  .byte %c0\n"             /* feature bit */    \
 		      "  .byte 662b-661b\n"       /* sourcelen */      \
 		      "  .byte 664f-663f\n"       /* replacementlen */ \
+		      ".previous\n"						\
+		      ".section .altinstr_replacement,\"ax\"\n"			\
 		      "663:\n\t" newinstr "\n664:\n"   /* replacement */    \
 		      ".previous" :: "i" (feature) : "memory")  
 
 /*
+ * Alternative inline assembly with input.
+ * 
+ * Pecularities:
+ * No memory clobber here. 
+ * Argument numbers start with 1.
+ * Best is to use constraints that are fixed size (like (%1) ... "r")
+ * If you use variable sized constraints like "m" or "g" in the 
+ * replacement maake sure to pad to the worst case length.
+ */
+#define alternative_input(oldinstr, newinstr, feature, input)			\
+	asm volatile ("661:\n\t" oldinstr "\n662:\n"				\
+		      ".section .altinstructions,\"a\"\n"			\
+		      "  .align 4\n"						\
+		      "  .long 661b\n"            /* label */			\
+		      "  .long 663f\n"		  /* new instruction */ 	\
+		      "  .byte %c0\n"             /* feature bit */		\
+		      "  .byte 662b-661b\n"       /* sourcelen */		\
+		      "  .byte 664f-663f\n"       /* replacementlen */ 		\
+		      ".previous\n"						\
+		      ".section .altinstr_replacement,\"ax\"\n"			\
+		      "663:\n\t" newinstr "\n664:\n"   /* replacement */ 	\
+		      ".previous" :: "i" (feature), input)  
+
+/*
  * Force strict CPU ordering.
  * And yes, this is required on UP too when we're talking
  * to devices.
