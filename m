Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315413AbSE2Oh5>; Wed, 29 May 2002 10:37:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315416AbSE2Oh4>; Wed, 29 May 2002 10:37:56 -0400
Received: from jalon.able.es ([212.97.163.2]:55467 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S315413AbSE2Ohw>;
	Wed, 29 May 2002 10:37:52 -0400
Date: Wed, 29 May 2002 16:35:44 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] intel-x86 model config cleanup
Message-ID: <20020529143544.GA2224@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Mailer: Balsa 1.3.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all..

One other try.

This is an attempt to clean up the CPU model flags. Changes:

- change names for CONFIG_Mxxxx, trying to make them more intuitive
- split PII from PPro
- introduce X86_F00F config flag and fixmap fix.
- kill CONFIG_M586 as independent flag, and make it just an
  extra flag for 586 (I couldnt get a better name for
  MGEN586, suggestions wellcome...)
- kill CONFIG_M686 as independent flag, and make it just an
  extra flag for anything >= PPro.
- change option order definition to avoid duplicates, like:

if [ "$CONFIG_MPENTIUM" = "y" ]; then
   define_bool CONFIG_M586 y         <==============
   define_bool CONFIG_X86_TSC y
fi
if [ "$CONFIG_MPENTIUMMMX" = "y" ]; then
   define_bool CONFIG_M586 y         <==============
   define_bool CONFIG_X86_TSC y
   define_bool CONFIG_X86_GOOD_APIC y
fi
if [ "$CONFIG_M586" = "y" ]; then <======== common things here
   define_int  CONFIG_X86_L1_CACHE_SHIFT 5
   define_bool CONFIG_X86_USE_STRING_486 y
   define_bool CONFIG_X86_ALIGNMENT_16 y
   define_bool CONFIG_X86_PPRO_FENCE y
   define_bool CONFIG_X86_F00F_BUG y
fi 

Patch follows:

diff -ruN linux-2.4.19-pre9-jam1/Documentation/Configure.help linux-2.4.19-pre9-jam1-arch/Documentation/Configure.help
--- linux-2.4.19-pre9-jam1/Documentation/Configure.help	Wed May 29 11:50:43 2002
+++ linux-2.4.19-pre9-jam1-arch/Documentation/Configure.help	Wed May 29 11:52:18 2002
@@ -3943,16 +3943,17 @@
   a PPro, but not necessarily on a i486.
 
   Here are the settings recommended for greatest speed:
-   - "386" for the AMD/Cyrix/Intel 386DX/DXL/SL/SLC/SX, Cyrix/TI
+   - "Generic-386" for the AMD/Cyrix/Intel 386DX/DXL/SL/SLC/SX, Cyrix/TI
      486DLC/DLC2, UMC 486SX-S and NexGen Nx586.  Only "386" kernels
      will run on a 386 class machine.
-   - "486" for the AMD/Cyrix/IBM/Intel 486DX/DX2/DX4 or
+   - "Generic-486" for the AMD/Cyrix/IBM/Intel 486DX/DX2/DX4 or
      SL/SLC/SLC2/SLC3/SX/SX2 and UMC U5D or U5S.
-   - "586" for generic Pentium CPUs, possibly lacking the TSC
+   - "Generic-586" for generic Pentium CPUs, possibly lacking the TSC
      (time stamp counter) register.
-   - "Pentium-Classic" for the Intel Pentium.
+   - "Pentium" for the Intel Pentium.
    - "Pentium-MMX" for the Intel Pentium MMX.
-   - "Pentium-Pro" for the Intel Pentium Pro/Celeron/Pentium II.
+   - "Pentium-Pro" for the Intel Pentium Pro.
+   - "Pentium-II" for the Intel Pentium II / Celeron.
    - "Pentium-III" for the Intel Pentium III
      and Celerons based on the Coppermine core.
    - "Pentium-4" for the Intel Pentium 4.
diff -ruN linux-2.4.19-pre9-jam1/arch/i386/Makefile linux-2.4.19-pre9-jam1-arch/arch/i386/Makefile
--- linux-2.4.19-pre9-jam1/arch/i386/Makefile	Wed May 29 11:50:43 2002
+++ linux-2.4.19-pre9-jam1-arch/arch/i386/Makefile	Wed May 29 11:55:39 2002
@@ -34,23 +34,27 @@
 CFLAGS += -march=i486
 endif
 
-ifdef CONFIG_M586
+ifdef CONFIG_MGEN586
 CFLAGS += -march=i586
 endif
 
-ifdef CONFIG_M586TSC
+ifdef CONFIG_MPENTIUM
 CFLAGS += -march=i586
 endif
 
-ifdef CONFIG_M586MMX
+ifdef CONFIG_MPENTIUMMMX
 CFLAGS += -march=i586
 endif
 
-ifdef CONFIG_M686
+ifdef CONFIG_MPENTIUMPRO
 CFLAGS += -march=i686
 endif
 
-ifdef CONFIG_MPENTIUMIII
+ifdef CONFIG_MPENTIUM2
+CFLAGS += -march=i686
+endif
+
+ifdef CONFIG_MPENTIUM3
 CFLAGS += -march=i686
 endif
 
diff -ruN linux-2.4.19-pre9-jam1/arch/i386/config.in linux-2.4.19-pre9-jam1-arch/arch/i386/config.in
--- linux-2.4.19-pre9-jam1/arch/i386/config.in	Wed May 29 11:50:43 2002
+++ linux-2.4.19-pre9-jam1-arch/arch/i386/config.in	Wed May 29 11:54:25 2002
@@ -27,22 +27,23 @@
 mainmenu_option next_comment
 comment 'Processor type and features'
 choice 'Processor family' \
-	"386					CONFIG_M386 \
-	 486					CONFIG_M486 \
-	 586/K5/5x86/6x86/6x86MX		CONFIG_M586 \
-	 Pentium-Classic			CONFIG_M586TSC \
-	 Pentium-MMX				CONFIG_M586MMX \
-	 Pentium-Pro/Celeron/Pentium-II		CONFIG_M686 \
-	 Pentium-III/Celeron(Coppermine)	CONFIG_MPENTIUMIII \
-	 Pentium-4				CONFIG_MPENTIUM4 \
-	 K6/K6-II/K6-III			CONFIG_MK6 \
-	 Athlon/Duron/K7			CONFIG_MK7 \
-	 Elan					CONFIG_MELAN \
-	 Crusoe					CONFIG_MCRUSOE \
-	 Winchip-C6				CONFIG_MWINCHIPC6 \
-	 Winchip-2				CONFIG_MWINCHIP2 \
-	 Winchip-2A/Winchip-3			CONFIG_MWINCHIP3D \
-	 CyrixIII/VIA-C3/VIA-C5			CONFIG_MCYRIXIII" Pentium-Pro
+	"Generic-386						CONFIG_M386 \
+	 Generic-486						CONFIG_M486 \
+	 Generic-586						CONFIG_MGEN586 \
+	 Pentium						CONFIG_MPENTIUM \
+	 Pentium-MMX						CONFIG_MPENTIUMMMX \
+	 Pentium-Pro						CONFIG_MPENTIUMPRO \
+	 Pentium-II/Celeron					CONFIG_MPENTIUM2 \
+	 Pentium-III/Celeron(Coppermine)	CONFIG_MPENTIUM3 \
+	 Pentium-4							CONFIG_MPENTIUM4 \
+	 K6/K6-II/K6-III					CONFIG_MK6 \
+	 Athlon/Duron/K7					CONFIG_MK7 \
+	 Elan								CONFIG_MELAN \
+	 Crusoe								CONFIG_MCRUSOE \
+	 Winchip-C6							CONFIG_MWINCHIPC6 \
+	 Winchip-2							CONFIG_MWINCHIP2 \
+	 Winchip-2A/Winchip-3				CONFIG_MWINCHIP3D \
+	 CyrixIII/VIA-C3/VIA-C5				CONFIG_MCYRIXIII" Pentium-III
 #
 # Define implied options from the CPU selection here
 #
@@ -54,6 +55,7 @@
    define_bool CONFIG_RWSEM_GENERIC_SPINLOCK y
    define_bool CONFIG_RWSEM_XCHGADD_ALGORITHM n
    define_bool CONFIG_X86_PPRO_FENCE y
+   define_bool CONFIG_X86_F00F_BUG y
 else
    define_bool CONFIG_X86_WP_WORKS_OK y
    define_bool CONFIG_X86_INVLPG y
@@ -64,55 +66,59 @@
    define_bool CONFIG_RWSEM_GENERIC_SPINLOCK n
    define_bool CONFIG_RWSEM_XCHGADD_ALGORITHM y
 fi
+
 if [ "$CONFIG_M486" = "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 4
    define_bool CONFIG_X86_USE_STRING_486 y
    define_bool CONFIG_X86_ALIGNMENT_16 y
    define_bool CONFIG_X86_PPRO_FENCE y
+   define_bool CONFIG_X86_F00F_BUG y
 fi
-if [ "$CONFIG_M586" = "y" ]; then
-   define_int  CONFIG_X86_L1_CACHE_SHIFT 5
-   define_bool CONFIG_X86_USE_STRING_486 y
-   define_bool CONFIG_X86_ALIGNMENT_16 y
-   define_bool CONFIG_X86_PPRO_FENCE y
+
+if [ "$CONFIG_MGEN586" = "y" ]; then
+   define_bool CONFIG_M586 y
 fi
-if [ "$CONFIG_M586TSC" = "y" ]; then
-   define_int  CONFIG_X86_L1_CACHE_SHIFT 5
-   define_bool CONFIG_X86_USE_STRING_486 y
-   define_bool CONFIG_X86_ALIGNMENT_16 y
+if [ "$CONFIG_MPENTIUM" = "y" ]; then
+   define_bool CONFIG_M586 y
    define_bool CONFIG_X86_TSC y
-   define_bool CONFIG_X86_PPRO_FENCE y
 fi
-if [ "$CONFIG_M586MMX" = "y" ]; then
+if [ "$CONFIG_MPENTIUMMMX" = "y" ]; then
+   define_bool CONFIG_M586 y
+   define_bool CONFIG_X86_TSC y
+   define_bool CONFIG_X86_GOOD_APIC y
+fi
+if [ "$CONFIG_M586" = "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 5
    define_bool CONFIG_X86_USE_STRING_486 y
    define_bool CONFIG_X86_ALIGNMENT_16 y
-   define_bool CONFIG_X86_TSC y
-   define_bool CONFIG_X86_GOOD_APIC y
    define_bool CONFIG_X86_PPRO_FENCE y
+   define_bool CONFIG_X86_F00F_BUG y
 fi
-if [ "$CONFIG_M686" = "y" ]; then
+
+if [ "$CONFIG_MPENTIUMPRO" = "y" ]; then
+   define_bool CONFIG_M686 y
    define_int  CONFIG_X86_L1_CACHE_SHIFT 5
-   define_bool CONFIG_X86_TSC y
-   define_bool CONFIG_X86_GOOD_APIC y
-   define_bool CONFIG_X86_PGE y
-   define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
    define_bool CONFIG_X86_PPRO_FENCE y
 fi
-if [ "$CONFIG_MPENTIUMIII" = "y" ]; then
+if [ "$CONFIG_MPENTIUM2" = "y" ]; then
+   define_bool CONFIG_M686 y
+   define_int  CONFIG_X86_L1_CACHE_SHIFT 5
+fi
+if [ "$CONFIG_MPENTIUM3" = "y" ]; then
+   define_bool CONFIG_M686 y
    define_int  CONFIG_X86_L1_CACHE_SHIFT 5
-   define_bool CONFIG_X86_TSC y
-   define_bool CONFIG_X86_GOOD_APIC y
-   define_bool CONFIG_X86_PGE y
-   define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
 fi
 if [ "$CONFIG_MPENTIUM4" = "y" ]; then
+   define_bool CONFIG_M686 y
    define_int  CONFIG_X86_L1_CACHE_SHIFT 7
+fi
+if [ "$CONFIG_M686" = "y" ]; then
    define_bool CONFIG_X86_TSC y
    define_bool CONFIG_X86_GOOD_APIC y
    define_bool CONFIG_X86_PGE y
    define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
 fi
+
 if [ "$CONFIG_MK6" = "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 5
    define_bool CONFIG_X86_ALIGNMENT_16 y
diff -ruN linux-2.4.19-pre9-jam1/arch/i386/defconfig linux-2.4.19-pre9-jam1-arch/arch/i386/defconfig
--- linux-2.4.19-pre9-jam1/arch/i386/defconfig	Wed May 29 11:50:43 2002
+++ linux-2.4.19-pre9-jam1-arch/arch/i386/defconfig	Wed May 29 11:54:59 2002
@@ -23,11 +23,12 @@
 #
 # CONFIG_M386 is not set
 # CONFIG_M486 is not set
-# CONFIG_M586 is not set
-# CONFIG_M586TSC is not set
-# CONFIG_M586MMX is not set
-# CONFIG_M686 is not set
-CONFIG_MPENTIUMIII=y
+# CONFIG_MGEN586 is not set
+# CONFIG_MPENTIUM is not set
+# CONFIG_MPENTIUMMMX is not set
+# CONFIG_MPENTIUMPRO is not set
+# CONFIG_MPENTIUM2 is not set
+CONFIG_MPENTIUM3=y
 # CONFIG_MPENTIUM4 is not set
 # CONFIG_MK6 is not set
 # CONFIG_MK7 is not set
diff -ruN linux-2.4.19-pre9-jam1/arch/i386/kernel/setup.c linux-2.4.19-pre9-jam1-arch/arch/i386/kernel/setup.c
--- linux-2.4.19-pre9-jam1/arch/i386/kernel/setup.c	Wed May 29 11:50:43 2002
+++ linux-2.4.19-pre9-jam1-arch/arch/i386/kernel/setup.c	Wed May 29 11:52:18 2002
@@ -2114,13 +2114,10 @@
 
 static void __init init_intel(struct cpuinfo_x86 *c)
 {
-#ifndef CONFIG_M686
-	static int f00f_workaround_enabled = 0;
-#endif
 	char *p = NULL;
 	unsigned int l1i = 0, l1d = 0, l2 = 0, l3 = 0; /* Cache sizes */
 
-#ifndef CONFIG_M686
+#ifdef CONFIG_X86_F00F_BUG
 	/*
 	 * All current models of Pentium and Pentium with MMX technology CPUs
 	 * have the F0 0F bug, which lets nonpriviledged users lock up the system.
@@ -2128,6 +2125,8 @@
 	 */
 	c->f00f_bug = 0;
 	if ( c->x86 == 5 ) {
+		static int f00f_workaround_enabled = 0;
+
 		c->f00f_bug = 1;
 		if ( !f00f_workaround_enabled ) {
 			trap_init_f00f_bug();
diff -ruN linux-2.4.19-pre9-jam1/arch/i386/kernel/traps.c linux-2.4.19-pre9-jam1-arch/arch/i386/kernel/traps.c
--- linux-2.4.19-pre9-jam1/arch/i386/kernel/traps.c	Wed May 29 11:50:43 2002
+++ linux-2.4.19-pre9-jam1-arch/arch/i386/kernel/traps.c	Wed May 29 11:52:18 2002
@@ -757,35 +757,17 @@
 
 #endif /* CONFIG_MATH_EMULATION */
 
-#ifndef CONFIG_M686
+#ifdef CONFIG_X86_F00F_BUG
 void __init trap_init_f00f_bug(void)
 {
-	unsigned long page;
-	pgd_t * pgd;
-	pmd_t * pmd;
-	pte_t * pte;
-
-	/*
-	 * Allocate a new page in virtual address space, 
-	 * move the IDT into it and write protect this page.
-	 */
-	page = (unsigned long) vmalloc(PAGE_SIZE);
-	pgd = pgd_offset(&init_mm, page);
-	pmd = pmd_offset(pgd, page);
-	pte = pte_offset(pmd, page);
-	__free_page(pte_page(*pte));
-	*pte = mk_pte_phys(__pa(&idt_table), PAGE_KERNEL_RO);
-	/*
-	 * Not that any PGE-capable kernel should have the f00f bug ...
-	 */
-	__flush_tlb_all();
+	__set_fixmap(FIX_F00F_IDT, __pa(&idt_table), PAGE_KERNEL_RO);
 
 	/*
 	 * "idt" is magic - it overlaps the idt_descr
 	 * variable so that updating idt will automatically
 	 * update the idt descriptor..
 	 */
-	idt = (struct desc_struct *)page;
+	idt = (struct desc_struct *) fix_to_virt(FIX_F00F_IDT);
 	__asm__ __volatile__("lidt %0": "=m" (idt_descr));
 }
 #endif
diff -ruN linux-2.4.19-pre9-jam1/arch/i386/mm/fault.c linux-2.4.19-pre9-jam1-arch/arch/i386/mm/fault.c
--- linux-2.4.19-pre9-jam1/arch/i386/mm/fault.c	Wed May 29 11:50:43 2002
+++ linux-2.4.19-pre9-jam1-arch/arch/i386/mm/fault.c	Wed May 29 11:52:18 2002
@@ -281,6 +281,7 @@
 		return;
 	}
 
+#ifdef CONFIG_X86_F00F_BUG
 	/*
 	 * Pentium F0 0F C7 C8 bug workaround.
 	 */
@@ -294,6 +295,7 @@
 			return;
 		}
 	}
+#endif
 
 no_context:
 	/* Are we prepared to handle this kernel fault?  */
diff -ruN linux-2.4.19-pre9-jam1/include/asm-i386/fixmap.h linux-2.4.19-pre9-jam1-arch/include/asm-i386/fixmap.h
--- linux-2.4.19-pre9-jam1/include/asm-i386/fixmap.h	Wed May 29 11:50:43 2002
+++ linux-2.4.19-pre9-jam1-arch/include/asm-i386/fixmap.h	Wed May 29 11:52:18 2002
@@ -61,6 +61,9 @@
 	FIX_LI_PCIA,	/* Lithium PCI Bridge A */
 	FIX_LI_PCIB,	/* Lithium PCI Bridge B */
 #endif
+#ifdef CONFIG_X86_F00F_BUG
+	FIX_F00F_IDT,	/* Virtual mapping for IDT */
+#endif
 #ifdef CONFIG_HIGHMEM
 	FIX_KMAP_BEGIN,	/* reserved pte's for temporary kernel mappings */
 	FIX_KMAP_END = FIX_KMAP_BEGIN+(KM_TYPE_NR*NR_CPUS)-1,


-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.3 (Cooker) for i586
Linux werewolf 2.4.19-pre9-jam1 #1 SMP mié may 29 02:20:48 CEST 2002 i686
