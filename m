Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751429AbVH3AVU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751429AbVH3AVU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 20:21:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751430AbVH3AVU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 20:21:20 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:54935 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751429AbVH3AVT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 20:21:19 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>
Subject: [PATCH] i386, x86_64 Initial PAT implementation
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Mon, 29 Aug 2005 18:20:43 -0600
Message-ID: <m1psrwmg10.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


PAT (or setting caching policy in the page table entries) has been a
long desired feature in the kernel and as large memory sizes become
more prevalent it becomes increasingly hard to specify all of the
regions that need write-back caching with just 8 MTRRs much less add
in the write-combining regions. 

This implementation does not attempt to change the world but it is instead
an incremental improvement on what we already have.  We already have
page attributes of write-back (neither PCD nor PWT), uncached (PCD and PWT), 
and uncached but allow write-combining (PCD but not PWT) in the x86 page
tables.  This implementation simply promotes (PCD but not PWT) to
request write-combining instead of simply allowing it.  If PAT is
not implemented on the cpu on the cpu someone requesting
write-combining will get an uncached area that will allow the
mtrrs to specify write-combining.

The way we used the existing page attributes was not completely
consistent, and it is cumbersome to use if you don't understand
the architecture minutia.  So I have added an implementation
pgprot_writecombine and the flags _PAGE_MA_WB, _PAGE_MA_WC,
_PAGE_MA_UC so it is clearer what the users are doing.

There should probably be an ioremap_writecombine added as well
but for now you can use __ioremap(..., _PAGE_MA_WC);

In previous conversations concerns have been raised about aliasing
issues caused by the same physical addresses being cached in different
ways.  Currently this code only allows for an additional flavor
of uncached access to physical memory addresses which should be hard
to abuse, and should raise no additional aliasing problems.  No
attempt has been made to fix theoretical aliasing problems.

I have tested this code and it works for me but it probably needs
to sit in the -mm tree for a little while, to get broader exposure. 

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>


---

 arch/i386/kernel/cpu/common.c   |   31 ++++++++++++++++++++++++++++++
 arch/i386/kernel/reboot.c       |    1 +
 arch/i386/kernel/smp.c          |    1 +
 arch/i386/mach-visws/reboot.c   |    1 +
 arch/i386/mm/ioremap.c          |    2 +-
 arch/i386/pci/i386.c            |   15 +++++++--------
 arch/x86_64/kernel/reboot.c     |    1 +
 arch/x86_64/kernel/setup.c      |   34 ++++++++++++++++++++++++++++++++-
 arch/x86_64/mm/ioremap.c        |    2 +-
 drivers/char/drm/drm_vm.c       |    5 +----
 drivers/video/fbmem.c           |    3 +--
 drivers/video/gbefb.c           |   11 ++++++-----
 drivers/video/sgivwfb.c         |    3 +--
 include/asm-i386/cpufeature.h   |    1 +
 include/asm-i386/msr.h          |    2 ++
 include/asm-i386/pgtable.h      |   40 +++++++++++++++++++++++++++++++++------
 include/asm-i386/processor.h    |    1 +
 include/asm-x86_64/cpufeature.h |    1 +
 include/asm-x86_64/msr.h        |    2 ++
 include/asm-x86_64/pgtable.h    |   33 ++++++++++++++++++++++++++++----
 include/asm-x86_64/processor.h  |    1 +
 21 files changed, 157 insertions(+), 34 deletions(-)

054beb808d7d8bbb39fb675faa2d0f4f54c0196d
diff --git a/arch/i386/kernel/cpu/common.c b/arch/i386/kernel/cpu/common.c
--- a/arch/i386/kernel/cpu/common.c
+++ b/arch/i386/kernel/cpu/common.c
@@ -320,6 +320,27 @@ static int __init x86_serial_nr_setup(ch
 __setup("serialnumber", x86_serial_nr_setup);
 
 
+static void __devinit pat_init(void)
+{
+	/* Set PCD to Write-Combining instead of Write-Combining allow */
+	if (cpu_has_pat) {
+		unsigned long lo,hi;
+		lo = 0x00010406;
+		hi = 0x00070406;
+		wrmsr(MSR_PAT,lo,hi);
+	}
+}
+
+static void pat_shutdown(void)
+{
+	/* Restore CPU default pat state */
+	if (cpu_has_pat) {
+		unsigned long lo,hi;
+		lo = 0x00070406;
+		hi = 0x00070406;
+		wrmsr(MSR_PAT,lo,hi);
+	}
+}
 
 /*
  * This does the hard work of actually picking apart the CPU stuff...
@@ -440,6 +461,8 @@ void __devinit identify_cpu(struct cpuin
 		mtrr_bp_init();
 	else
 		mtrr_ap_init();
+
+	pat_init();
 }
 
 #ifdef CONFIG_X86_HT
@@ -668,3 +691,11 @@ void __devinit cpu_uninit(void)
 	per_cpu(cpu_tlbstate, cpu).active_mm = &init_mm;
 }
 #endif
+
+void cpu_shutdown(void)
+{
+	/* PARANOIA: Turn off optional cpu features so
+	 * we do not confuse the reboot process.
+	 */
+	pat_shutdown();
+}
diff --git a/arch/i386/kernel/reboot.c b/arch/i386/kernel/reboot.c
--- a/arch/i386/kernel/reboot.c
+++ b/arch/i386/kernel/reboot.c
@@ -309,6 +309,7 @@ void machine_shutdown(void)
 #ifdef CONFIG_X86_IO_APIC
 	disable_IO_APIC();
 #endif
+	cpu_shutdown();
 }
 
 void machine_emergency_restart(void)
diff --git a/arch/i386/kernel/smp.c b/arch/i386/kernel/smp.c
--- a/arch/i386/kernel/smp.c
+++ b/arch/i386/kernel/smp.c
@@ -575,6 +575,7 @@ static void stop_this_cpu (void * dummy)
 	cpu_clear(smp_processor_id(), cpu_online_map);
 	local_irq_disable();
 	disable_local_APIC();
+	cpu_shutdown();
 	if (cpu_data[smp_processor_id()].hlt_works_ok)
 		for(;;) __asm__("hlt");
 	for (;;);
diff --git a/arch/i386/mach-visws/reboot.c b/arch/i386/mach-visws/reboot.c
--- a/arch/i386/mach-visws/reboot.c
+++ b/arch/i386/mach-visws/reboot.c
@@ -14,6 +14,7 @@ void machine_shutdown(void)
 #ifdef CONFIG_SMP
 	smp_send_stop();
 #endif
+	cpu_shutdown();
 }
 
 void machine_emergency_restart(void)
diff --git a/arch/i386/mm/ioremap.c b/arch/i386/mm/ioremap.c
--- a/arch/i386/mm/ioremap.c
+++ b/arch/i386/mm/ioremap.c
@@ -193,7 +193,7 @@ EXPORT_SYMBOL(__ioremap);
 void __iomem *ioremap_nocache (unsigned long phys_addr, unsigned long size)
 {
 	unsigned long last_addr;
-	void __iomem *p = __ioremap(phys_addr, size, _PAGE_PCD);
+	void __iomem *p = __ioremap(phys_addr, size, _PAGE_MA_UC);
 	if (!p) 
 		return p; 
 
diff --git a/arch/i386/pci/i386.c b/arch/i386/pci/i386.c
--- a/arch/i386/pci/i386.c
+++ b/arch/i386/pci/i386.c
@@ -279,8 +279,6 @@ void pcibios_set_master(struct pci_dev *
 int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
 			enum pci_mmap_state mmap_state, int write_combine)
 {
-	unsigned long prot;
-
 	/* I/O space cannot be accessed via normal processor loads and
 	 * stores on this platform.
 	 */
@@ -292,13 +290,14 @@ int pci_mmap_page_range(struct pci_dev *
 	 */
 	vma->vm_flags |= (VM_SHM | VM_LOCKED | VM_IO);
 
-	prot = pgprot_val(vma->vm_page_prot);
-	if (boot_cpu_data.x86 > 3)
-		prot |= _PAGE_PCD | _PAGE_PWT;
-	vma->vm_page_prot = __pgprot(prot);
+	if (!write_combine) {
+		vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
+	} else {
+		vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
+	}
 
-	/* Write-combine setting is ignored, it is changed via the mtrr
-	 * interfaces on this platform.
+	/* Write-combine setting may also be controlled via
+	 * the mtrr interfaces on this platform.
 	 */
 	if (remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
 			     vma->vm_end - vma->vm_start,
diff --git a/arch/x86_64/kernel/reboot.c b/arch/x86_64/kernel/reboot.c
--- a/arch/x86_64/kernel/reboot.c
+++ b/arch/x86_64/kernel/reboot.c
@@ -106,6 +106,7 @@ void machine_shutdown(void)
 
 	disable_IO_APIC();
 
+	cpu_shutdown();
 	local_irq_enable();
 }
 
diff --git a/arch/x86_64/kernel/setup.c b/arch/x86_64/kernel/setup.c
--- a/arch/x86_64/kernel/setup.c
+++ b/arch/x86_64/kernel/setup.c
@@ -1001,6 +1001,28 @@ void __cpuinit early_identify_cpu(struct
 #endif
 }
 
+static void __cpuinit pat_init(void)
+{
+	/* Set PCD to Write-Combining instead of Write-Combining allow */
+	if (cpu_has_pat) {
+		unsigned long lo,hi;
+		lo = 0x00010406;
+		hi = 0x00070406;
+		wrmsr(MSR_PAT,lo,hi);
+	}
+}
+
+static void pat_shutdown(void)
+{
+	/* Restore CPU default pat state */
+	if (cpu_has_pat) {
+		unsigned long lo,hi;
+		lo = 0x00070406;
+		hi = 0x00070406;
+		wrmsr(MSR_PAT,lo,hi);
+	}
+}
+
 /*
  * This does the hard work of actually picking apart the CPU stuff...
  */
@@ -1078,11 +1100,21 @@ void __cpuinit identify_cpu(struct cpuin
 		mtrr_bp_init();
 	else
 		mtrr_ap_init();
+
+	pat_init();
+
 #ifdef CONFIG_NUMA
 	numa_add_cpu(smp_processor_id());
 #endif
 }
- 
+
+void cpu_shutdown(void)
+{
+	/* PARANOIA: Turn off optional cpu features so
+	 * we do not confuse the reboot process.
+	 */
+	pat_shutdown();
+}
 
 void __cpuinit print_cpu_info(struct cpuinfo_x86 *c)
 {
diff --git a/arch/x86_64/mm/ioremap.c b/arch/x86_64/mm/ioremap.c
--- a/arch/x86_64/mm/ioremap.c
+++ b/arch/x86_64/mm/ioremap.c
@@ -246,7 +246,7 @@ void __iomem * __ioremap(unsigned long p
 
 void __iomem *ioremap_nocache (unsigned long phys_addr, unsigned long size)
 {
-	return __ioremap(phys_addr, size, _PAGE_PCD);
+	return __ioremap(phys_addr, size, _PAGE_MA_UC);
 }
 
 void iounmap(volatile void __iomem *addr)
diff --git a/drivers/char/drm/drm_vm.c b/drivers/char/drm/drm_vm.c
--- a/drivers/char/drm/drm_vm.c
+++ b/drivers/char/drm/drm_vm.c
@@ -607,10 +607,7 @@ int drm_mmap(struct file *filp, struct v
 	case _DRM_REGISTERS:
 		if (VM_OFFSET(vma) >= __pa(high_memory)) {
 #if defined(__i386__) || defined(__x86_64__)
-			if (boot_cpu_data.x86 > 3 && map->type != _DRM_AGP) {
-				pgprot_val(vma->vm_page_prot) |= _PAGE_PCD;
-				pgprot_val(vma->vm_page_prot) &= ~_PAGE_PWT;
-			}
+			vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
 #elif defined(__powerpc__)
 			pgprot_val(vma->vm_page_prot) |= _PAGE_NO_CACHE | _PAGE_GUARDED;
 #endif
diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
--- a/drivers/video/fbmem.c
+++ b/drivers/video/fbmem.c
@@ -915,8 +915,7 @@ fb_mmap(struct file *file, struct vm_are
 #elif defined(__alpha__)
 	/* Caching is off in the I/O space quadrant by design.  */
 #elif defined(__i386__) || defined(__x86_64__)
-	if (boot_cpu_data.x86 > 3)
-		pgprot_val(vma->vm_page_prot) |= _PAGE_PCD;
+	vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
 #elif defined(__mips__)
 	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
 #elif defined(__hppa__)
diff --git a/drivers/video/gbefb.c b/drivers/video/gbefb.c
--- a/drivers/video/gbefb.c
+++ b/drivers/video/gbefb.c
@@ -52,13 +52,15 @@ struct gbefb_par {
 /* macro for fastest write-though access to the framebuffer */
 #ifdef CONFIG_MIPS
 #ifdef CONFIG_CPU_R10000
-#define pgprot_fb(_prot) (((_prot) & (~_CACHE_MASK)) | _CACHE_UNCACHED_ACCELERATED)
+#define pgprot_fb(_prot) \
+	__prprot((pgprot_val(_prot) & (~_CACHE_MASK)) | _CACHE_UNCACHED_ACCELERATED)
 #else
-#define pgprot_fb(_prot) (((_prot) & (~_CACHE_MASK)) | _CACHE_CACHABLE_NO_WA)
+#define pgprot_fb(_prot) \
+	__pgprot((pgprot_val(_prot) & (~_CACHE_MASK)) | _CACHE_CACHABLE_NO_WA)
 #endif
 #endif
 #ifdef CONFIG_X86
-#define pgprot_fb(_prot) ((_prot) | _PAGE_PCD)
+#define pgprot_fb(_prot) pgprot_writecombine(_prot)
 #endif
 
 /*
@@ -996,8 +998,7 @@ static int gbefb_mmap(struct fb_info *in
 
 	/* remap using the fastest write-through mode on architecture */
 	/* try not polluting the cache when possible */
-	pgprot_val(vma->vm_page_prot) =
-		pgprot_fb(pgprot_val(vma->vm_page_prot));
+	vma->vm_page_prot = pgprot_fb(vma->vm_page_prot);
 
 	vma->vm_flags |= VM_IO | VM_RESERVED;
 	vma->vm_file = file;
diff --git a/drivers/video/sgivwfb.c b/drivers/video/sgivwfb.c
--- a/drivers/video/sgivwfb.c
+++ b/drivers/video/sgivwfb.c
@@ -716,8 +716,7 @@ static int sgivwfb_mmap(struct fb_info *
 	if (offset + size > sgivwfb_mem_size)
 		return -EINVAL;
 	offset += sgivwfb_mem_phys;
-	pgprot_val(vma->vm_page_prot) =
-	    pgprot_val(vma->vm_page_prot) | _PAGE_PCD;
+	vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
 	vma->vm_flags |= VM_IO;
 	if (remap_pfn_range(vma, vma->vm_start, offset >> PAGE_SHIFT,
 						size, vma->vm_page_prot))
diff --git a/include/asm-i386/cpufeature.h b/include/asm-i386/cpufeature.h
--- a/include/asm-i386/cpufeature.h
+++ b/include/asm-i386/cpufeature.h
@@ -118,6 +118,7 @@
 #define cpu_has_xstore_enabled	boot_cpu_has(X86_FEATURE_XSTORE_EN)
 #define cpu_has_xcrypt		boot_cpu_has(X86_FEATURE_XCRYPT)
 #define cpu_has_xcrypt_enabled	boot_cpu_has(X86_FEATURE_XCRYPT_EN)
+#define cpu_has_pat		boot_cpu_has(X86_FEATURE_PAT)
 
 #endif /* __ASM_I386_CPUFEATURE_H */
 
diff --git a/include/asm-i386/msr.h b/include/asm-i386/msr.h
--- a/include/asm-i386/msr.h
+++ b/include/asm-i386/msr.h
@@ -121,6 +121,8 @@ static inline void wrmsrl (unsigned long
 #define MSR_IA32_LASTINTFROMIP		0x1dd
 #define MSR_IA32_LASTINTTOIP		0x1de
 
+#define MSR_PAT				0x277
+
 #define MSR_IA32_MC0_CTL		0x400
 #define MSR_IA32_MC0_STATUS		0x401
 #define MSR_IA32_MC0_ADDR		0x402
diff --git a/include/asm-i386/pgtable.h b/include/asm-i386/pgtable.h
--- a/include/asm-i386/pgtable.h
+++ b/include/asm-i386/pgtable.h
@@ -119,6 +119,16 @@ void paging_init(void);
 #define _PAGE_UNUSED2	0x400
 #define _PAGE_UNUSED3	0x800
 
+/* Cache memory access attributes.
+ * WB: Write back caching is allowed.
+ * WC: Uncached but combining writes is allowed.
+ * UC: Uncached and combining writes is not allwed.
+ */
+#define _PAGE_MA_MASK	(_PAGE_PCD | _PAGE_PWT)
+#define _PAGE_MA_WB	(0)
+#define _PAGE_MA_WC	(_PAGE_PCD)
+#define _PAGE_MA_UC	(_PAGE_PCD | _PAGE_PWT)
+
 #define _PAGE_FILE	0x040	/* set:pagecache unset:swap */
 #define _PAGE_PROTNONE	0x080	/* If not present */
 #ifdef CONFIG_X86_PAE
@@ -156,7 +166,7 @@ void paging_init(void);
 
 extern unsigned long long __PAGE_KERNEL, __PAGE_KERNEL_EXEC;
 #define __PAGE_KERNEL_RO		(__PAGE_KERNEL & ~_PAGE_RW)
-#define __PAGE_KERNEL_NOCACHE		(__PAGE_KERNEL | _PAGE_PCD)
+#define __PAGE_KERNEL_NOCACHE		(__PAGE_KERNEL | _PAGE_MA_UC)
 #define __PAGE_KERNEL_LARGE		(__PAGE_KERNEL | _PAGE_PSE)
 #define __PAGE_KERNEL_LARGE_EXEC	(__PAGE_KERNEL_EXEC | _PAGE_PSE)
 
@@ -264,11 +274,29 @@ static inline void ptep_set_wrprotect(st
 }
 
 /*
- * Macro to mark a page protection value as "uncacheable".  On processors which do not support
- * it, this is a no-op.
- */
-#define pgprot_noncached(prot)	((boot_cpu_data.x86 > 3)					  \
-				 ? (__pgprot(pgprot_val(prot) | _PAGE_PCD | _PAGE_PWT)) : (prot))
+ * Macro to mark a page protection value as "uncacheable". 
+ * Accesses through a uncached translation bypasses the cache
+ * and do not allow for consecutive writes to be combined.
+ * On processors which do not support it, this is a no-op.
+ */
+#define pgprot_noncached(prot)		\
+	((boot_cpu_data.x86 > 3) ?	\
+		(__pgprot((pgprot_val(prot) & ~_PAGE_MA_MASK) | _PAGE_MA_UC)): \
+		(prot))
+
+/*
+ * Macro to make mark a page protection value as "write-combining".
+ * Accesses through a write-combining translation bypasses the
+ * caches, but does allow for consecutive writes to be combined into
+ * single (but larger) write transactions. 
+ * On processors that do not support PAT this setting allows
+ * mtrrs to set write combining.
+ * On processors which do not support it, this is a no-op.
+ */
+#define pgprot_writecombine(prot)	\
+	((boot_cpu_data.x86 > 3) ?	\
+		(__pgprot((pgprot_val(prot) & ~_PAGE_MA_MASK) | _PAGE_MA_WC)): \
+		(prot))
 
 /*
  * Conversion functions: convert a page and protection to a page entry,
diff --git a/include/asm-i386/processor.h b/include/asm-i386/processor.h
--- a/include/asm-i386/processor.h
+++ b/include/asm-i386/processor.h
@@ -102,6 +102,7 @@ extern	int cpu_core_id[NR_CPUS];
 extern char ignore_fpu_irq;
 
 extern void identify_cpu(struct cpuinfo_x86 *);
+extern void cpu_shutdown(void);
 extern void print_cpu_info(struct cpuinfo_x86 *);
 extern unsigned int init_intel_cacheinfo(struct cpuinfo_x86 *c);
 
diff --git a/include/asm-x86_64/cpufeature.h b/include/asm-x86_64/cpufeature.h
--- a/include/asm-x86_64/cpufeature.h
+++ b/include/asm-x86_64/cpufeature.h
@@ -107,5 +107,6 @@
 #define cpu_has_cyrix_arr      0
 #define cpu_has_centaur_mcr    0
 #define cpu_has_clflush	       boot_cpu_has(X86_FEATURE_CLFLSH)
+#define cpu_has_pat            1
 
 #endif /* __ASM_X8664_CPUFEATURE_H */
diff --git a/include/asm-x86_64/msr.h b/include/asm-x86_64/msr.h
--- a/include/asm-x86_64/msr.h
+++ b/include/asm-x86_64/msr.h
@@ -197,6 +197,8 @@ extern inline unsigned int cpuid_edx(uns
 #define MSR_MTRRfix4K_F8000	0x26f
 #define MSR_MTRRdefType		0x2ff
 
+#define MSR_PAT			0x277
+
 #define MSR_IA32_MC0_CTL       0x400
 #define MSR_IA32_MC0_STATUS        0x401
 #define MSR_IA32_MC0_ADDR      0x402
diff --git a/include/asm-x86_64/pgtable.h b/include/asm-x86_64/pgtable.h
--- a/include/asm-x86_64/pgtable.h
+++ b/include/asm-x86_64/pgtable.h
@@ -146,6 +146,16 @@ extern inline void pgd_clear (pgd_t * pg
 #define _PAGE_FILE	0x040	/* set:pagecache, unset:swap */
 #define _PAGE_GLOBAL	0x100	/* Global TLB entry */
 
+/* Cache memory access attributes.
+ * WB: Write back caching is allowed.
+ * WC: Uncached but combining writes is allowed.
+ * UC: Uncached and combining writes is not allwed.
+ */
+#define _PAGE_MA_MASK	(_PAGE_PCD | _PAGE_PWT)
+#define _PAGE_MA_WB	(0)
+#define _PAGE_MA_WC	(_PAGE_PCD)
+#define _PAGE_MA_UC	(_PAGE_PCD | _PAGE_PWT)
+
 #define _PAGE_PROTNONE	0x080	/* If not present */
 #define _PAGE_NX        (1UL<<_PAGE_BIT_NX)
 
@@ -167,13 +177,13 @@ extern inline void pgd_clear (pgd_t * pg
 #define __PAGE_KERNEL_EXEC \
 	(_PAGE_PRESENT | _PAGE_RW | _PAGE_DIRTY | _PAGE_ACCESSED)
 #define __PAGE_KERNEL_NOCACHE \
-	(_PAGE_PRESENT | _PAGE_RW | _PAGE_DIRTY | _PAGE_PCD | _PAGE_ACCESSED | _PAGE_NX)
+	(_PAGE_PRESENT | _PAGE_RW | _PAGE_DIRTY | _PAGE_MA_UC | _PAGE_ACCESSED | _PAGE_NX)
 #define __PAGE_KERNEL_RO \
 	(_PAGE_PRESENT | _PAGE_DIRTY | _PAGE_ACCESSED | _PAGE_NX)
 #define __PAGE_KERNEL_VSYSCALL \
 	(_PAGE_PRESENT | _PAGE_USER | _PAGE_ACCESSED)
 #define __PAGE_KERNEL_VSYSCALL_NOCACHE \
-	(_PAGE_PRESENT | _PAGE_USER | _PAGE_ACCESSED | _PAGE_PCD)
+	(_PAGE_PRESENT | _PAGE_USER | _PAGE_ACCESSED | _PAGE_MA_UC)
 #define __PAGE_KERNEL_LARGE \
 	(__PAGE_KERNEL | _PAGE_PSE)
 #define __PAGE_KERNEL_LARGE_EXEC \
@@ -185,6 +195,7 @@ extern inline void pgd_clear (pgd_t * pg
 #define PAGE_KERNEL_EXEC MAKE_GLOBAL(__PAGE_KERNEL_EXEC)
 #define PAGE_KERNEL_RO MAKE_GLOBAL(__PAGE_KERNEL_RO)
 #define PAGE_KERNEL_NOCACHE MAKE_GLOBAL(__PAGE_KERNEL_NOCACHE)
+#define PAGE_KERNEL_WC MAKE_GLOBAL(__PAGE_KERNEL_WC)
 #define PAGE_KERNEL_VSYSCALL32 __pgprot(__PAGE_KERNEL_VSYSCALL)
 #define PAGE_KERNEL_VSYSCALL MAKE_GLOBAL(__PAGE_KERNEL_VSYSCALL)
 #define PAGE_KERNEL_LARGE MAKE_GLOBAL(__PAGE_KERNEL_LARGE)
@@ -291,8 +302,22 @@ static inline void ptep_set_wrprotect(st
 
 /*
  * Macro to mark a page protection value as "uncacheable".
+ * Accesses through a uncached translation bypasses the cache
+ * and do not allow for consecutive writes to be combined.
+ */
+#define pgprot_noncached(prot) \
+	(__pgprot((pgprot_val(prot) & ~_PAGE_MA_MASK) | _PAGE_MA_UC))
+
+/*
+ * Macro to make mark a page protection value as "write-combining".
+ * Accesses through a write-combining translation works bypasses the
+ * caches, but does allow for consecutive writes to be combined into
+ * single (but larger) write transactions. 
+ * On processors that do not support PAT this setting allows
+ * mtrrs to set write combining.
  */
-#define pgprot_noncached(prot)	(__pgprot(pgprot_val(prot) | _PAGE_PCD | _PAGE_PWT))
+#define pgprot_writecombine(prot) \
+	(__pgprot((pgprot_val(prot) & ~_PAGE_MA_MASK) | _PAGE_MA_WC))
 
 static inline int pmd_large(pmd_t pte) { 
 	return (pmd_val(pte) & __LARGE_PTE) == __LARGE_PTE; 
@@ -422,7 +447,7 @@ extern int kern_addr_valid(unsigned long
 #define pgtable_cache_init()   do { } while (0)
 #define check_pgt_cache()      do { } while (0)
 
-#define PAGE_AGP    PAGE_KERNEL_NOCACHE
+#define PAGE_AGP    PAGE_KERNEL_WC
 #define HAVE_PAGE_AGP 1
 
 /* fs/proc/kcore.c */
diff --git a/include/asm-x86_64/processor.h b/include/asm-x86_64/processor.h
--- a/include/asm-x86_64/processor.h
+++ b/include/asm-x86_64/processor.h
@@ -89,6 +89,7 @@ extern struct cpuinfo_x86 cpu_data[];
 extern char ignore_irq13;
 
 extern void identify_cpu(struct cpuinfo_x86 *);
+extern void cpu_shutdown(void);
 extern void print_cpu_info(struct cpuinfo_x86 *);
 extern unsigned int init_intel_cacheinfo(struct cpuinfo_x86 *c);
 
