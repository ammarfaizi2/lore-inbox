Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261893AbTDUUll (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 16:41:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261921AbTDUUll
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 16:41:41 -0400
Received: from zero.aec.at ([193.170.194.10]:53000 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S261893AbTDUUlg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 16:41:36 -0400
Date: Mon, 21 Apr 2003 22:53:33 +0200
From: Andi Kleen <ak@muc.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Runtime memory barrier patching
Message-ID: <20030421205333.GA13883@averell>
References: <20030421192734.GA1542@averell> <Pine.LNX.4.44.0304211254190.17221-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0304211254190.17221-100000@home.transmeta.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 21, 2003 at 09:59:00PM +0200, Linus Torvalds wrote:
> 
> On Mon, 21 Apr 2003, Andi Kleen wrote:
> > 
> > This patch implements automatic code patching of memory barriers based
> > on the CPU capabilities. Normally lock ; addl $0,(%esp) barriers
> > are used, but these are a bit slow on the Pentium 4. 
> 
> Could you fix this part:

Ok fixed. I used the recommendations from the Hammer optimization
manual, will hopefully work for Intel too.

Original mail for BitKeeper:

This patch implements automatic code patching of memory barriers based
on the CPU capabilities. Normally lock ; addl $0,(%esp) barriers
are used, but these are a bit slow on the Pentium 4. 

Linus proposed this a few weeks ago after the support for SSE1/SSE2
barriers was introduced. I now got around to implement it.

The main advantage is that it allows distributors to ship less binary
kernels but still get fast kernels. In particular it avoids the
need of a special Pentium 4 kernel.

The patching code is quite generic and could be used to patch
other instructions (like prefetches or specific other critical
instructions) too.
Thanks to Rusty's in kernel loader it also works seamlessly for modules.

The patching is done before other CPUs start to avoid potential
erratas with self modifying code on SMP systems. It makes no 
attempt to automatically handle assymetric systems (an secondary
CPU having less capabilities than the boot CPU). In this
case just boot with "noreplacement"


diff -u linux-2.5.68-gencpu/arch/i386/kernel/setup.c-o linux-2.5.68-gencpu/arch/i386/kernel/setup.c
--- linux-2.5.68-gencpu/arch/i386/kernel/setup.c-o	2003-04-21 22:18:39.000000000 +0200
+++ linux-2.5.68-gencpu/arch/i386/kernel/setup.c	2003-04-21 22:34:40.000000000 +0200
@@ -797,6 +797,57 @@
 		pci_mem_start = low_mem_size;
 }
 
+/* Replace instructions with better alternatives for this CPU type.
+
+   This runs before SMP is initialized to avoid SMP problems with
+   self modifying code. This implies that assymetric systems where
+   APs have less capabilities than the boot processor are not handled. 
+    
+   In this case boot with "noreplacement". */ 
+void __init apply_alternatives(void *start, void *end) 
+{ 
+	struct alt_instr *a; 
+	int diff, i, k;
+
+	for (a = start; a < end; 
+	     a = (void *)ALIGN((unsigned long)(a + 1) + a->instrlen, 4)) { 
+		if (!boot_cpu_has(a->cpuid))
+			continue;
+		BUG_ON(a->replacementlen > a->instrlen); 
+		memcpy(a->instr, a->replacement, a->replacementlen); 
+		diff = a->instrlen - a->replacementlen; 
+		for (i = a->replacementlen; diff > 0; diff -= k, i += k) {
+			static const char *nops[] = {
+				0,
+				"\x90",
+				"\x66\x90",
+				"\x66\x66\x90",
+				"\x66\x66\x66\x90",
+			};
+			k = min_t(int, diff, ARRAY_SIZE(nops)); 
+			memcpy(a->instr + i, nops[k], k); 
+		} 
+	}
+} 
+
+static int no_replacement __initdata = 0; 
+ 
+void __init alternative_instructions(void)
+{
+	extern struct alt_instr __alt_instructions[], __alt_instructions_end[];
+	if (no_replacement) 
+		return;
+	apply_alternatives(__alt_instructions, __alt_instructions_end);
+}
+
+static int __init noreplacement_setup(char *s)
+{ 
+     no_replacement = 1; 
+     return 0; 
+} 
+
+__setup("noreplacement", noreplacement_setup); 
+
 void __init setup_arch(char **cmdline_p)
 {
 	unsigned long max_low_pfn;
diff -u linux-2.5.68-gencpu/arch/i386/kernel/module.c-o linux-2.5.68-gencpu/arch/i386/kernel/module.c
--- linux-2.5.68-gencpu/arch/i386/kernel/module.c-o	2003-04-20 21:24:16.000000000 +0200
@@ -104,9 +104,22 @@
 	return -ENOEXEC;
 }
 
+extern void apply_alternatives(void *start, void *end); 
+
 int module_finalize(const Elf_Ehdr *hdr,
 		    const Elf_Shdr *sechdrs,
 		    struct module *me)
 {
+	Elf_Shdr *s;
+	char *secstrings = (void *)hdr + sechdrs[hdr->e_shstrndx].sh_offset;
+
+	/* look for .altinstructions to patch */ 
+	for (s = sechdrs; s < sechdrs + hdr->e_shnum; s++) { 
+		void *seg; 		
+		if (strcmp(".altinstructions", secstrings + s->sh_name))
+			continue;
+		seg = (void *)s->sh_addr; 
+		apply_alternatives(seg, seg + s->sh_size); 
+	} 	
 	return 0;
 }
diff -u linux-2.5.68-gencpu/arch/i386/vmlinux.lds.S-o linux-2.5.68-gencpu/arch/i386/vmlinux.lds.S
--- linux-2.5.68-gencpu/arch/i386/vmlinux.lds.S-o	2003-04-20 21:24:16.000000000 +0200
+++ linux-2.5.68-gencpu/arch/i386/vmlinux.lds.S	2003-04-20 21:24:22.000000000 +0200
@@ -81,6 +81,10 @@
   __con_initcall_start = .;
   .con_initcall.init : { *(.con_initcall.init) }
   __con_initcall_end = .;
+  . = ALIGN(4);
+  __alt_instructions = .;
+  .altinstructions : { *(.altinstructions) } 
+  __alt_instructions_end = .; 
   . = ALIGN(4096);
   __initramfs_start = .;
   .init.ramfs : { *(.init.ramfs) }
diff -u linux-2.5.68-gencpu/include/asm-i386/system.h-o linux-2.5.68-gencpu/include/asm-i386/system.h
--- linux-2.5.68-gencpu/include/asm-i386/system.h-o	2003-04-20 21:24:16.000000000 +0200
+++ linux-2.5.68-gencpu/include/asm-i386/system.h	2003-04-20 21:24:22.000000000 +0200
@@ -4,6 +4,7 @@
 #include <linux/config.h>
 #include <linux/kernel.h>
 #include <asm/segment.h>
+#include <asm/cpufeature.h>
 #include <linux/bitops.h> /* for LOCK_PREFIX */
 
 #ifdef __KERNEL__
@@ -276,6 +277,37 @@
 /* Compiling for a 386 proper.	Is it worth implementing via cli/sti?  */
 #endif
 
+struct alt_instr { 
+	u8 *instr; 		/* original instruction */
+	u8  cpuid;		/* cpuid bit set for replacement */
+	u8  instrlen;		/* length of original instruction */
+	u8  replacementlen; 	/* length of new instruction, <= instrlen */ 
+	u8  replacement[0];   	/* new instruction */
+}; 
+
+/* 
+ * Alternative instructions for different CPU types or capabilities.
+ * 
+ * This allows to use optimized instructions even on generic binary
+ * kernels.
+ * 
+ * length of oldinstr must be longer or equal the length of newinstr
+ * It can be padded with nops as needed.
+ * 
+ * For non barrier like inlines please define new variants
+ * without volatile and memory clobber.
+ */
+#define alternative(oldinstr, newinstr, feature) 	\
+	asm volatile ("661:\n\t" oldinstr "\n662:\n" 		     \
+		      ".section .altinstructions,\"a\"\n"     	     \
+		      "  .align 4\n"				       \
+		      "  .long 661b\n"            /* label */          \
+		      "  .byte %c0\n"             /* feature bit */    \
+		      "  .byte 662b-661b\n"       /* sourcelen */      \
+		      "  .byte 664f-663f\n"       /* replacementlen */ \
+		      "663:\n\t" newinstr "\n664:\n"   /* replacement */    \
+		      ".previous" :: "i" (feature) : "memory")  
+
 /*
  * Force strict CPU ordering.
  * And yes, this is required on UP too when we're talking
@@ -294,13 +326,15 @@
  * nop for these.
  */
  
-#ifdef CONFIG_X86_SSE2
-#define mb()	asm volatile("mfence" ::: "memory")
-#define rmb()	asm volatile("lfence" ::: "memory")
-#else
-#define mb() 	__asm__ __volatile__ ("lock; addl $0,0(%%esp)": : :"memory")
-#define rmb()	mb()
-#endif
+
+/* 
+ * Actually only lfence would be needed for mb() because all stores done 
+ * by the kernel should be already ordered. But keep a full barrier for now. 
+ */
+
+#define mb() alternative("lock; addl $0,0(%%esp)", "mfence", X86_FEATURE_XMM2)
+#define rmb() alternative("lock; addl $0,0(%%esp)", "lfence", X86_FEATURE_XMM2)
+
 /**
  * read_barrier_depends - Flush all pending reads that subsequents reads
  * depend on.
@@ -356,7 +390,9 @@
 #define read_barrier_depends()	do { } while(0)
 
 #ifdef CONFIG_X86_OOSTORE
-#define wmb() 	__asm__ __volatile__ ("lock; addl $0,0(%%esp)": : :"memory")
+/* Actually there are no OOO store capable CPUs for now that do SSE, 
+   but make it already an possibility. */
+#define wmb() alternative("lock; addl $0,0(%%esp)", "sfence", X86_FEATURE_XMM)
 #else
 #define wmb()	__asm__ __volatile__ ("": : :"memory")
 #endif
diff -u linux-2.5.68-gencpu/include/asm-i386/bugs.h-o linux-2.5.68-gencpu/include/asm-i386/bugs.h
--- linux-2.5.68-gencpu/include/asm-i386/bugs.h-o	2003-04-20 21:24:16.000000000 +0200
+++ linux-2.5.68-gencpu/include/asm-i386/bugs.h	2003-04-20 21:24:22.000000000 +0200
@@ -200,6 +200,8 @@
 #endif
 }
 
+extern void alternative_instructions(void);
+
 static void __init check_bugs(void)
 {
 	identify_cpu(&boot_cpu_data);
@@ -212,4 +214,5 @@
 	check_hlt();
 	check_popad();
 	system_utsname.machine[1] = '0' + (boot_cpu_data.x86 > 6 ? 6 : boot_cpu_data.x86);
+	alternative_instructions(); 
 }

