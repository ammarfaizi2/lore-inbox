Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265315AbUANJLk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 04:11:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265439AbUANJLk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 04:11:40 -0500
Received: from pD9E5637F.dip.t-dialin.net ([217.229.99.127]:20864 "EHLO
	averell.firstfloor.org") by vger.kernel.org with ESMTP
	id S265315AbUANJJH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 04:09:07 -0500
Date: Wed, 14 Jan 2004 10:08:54 +0100
From: Andi Kleen <ak@muc.de>
To: akpm@osdl.org
Cc: jh@suse.cz, linux-kernel@vger.kernel.org
Subject: [PATCH] Fixing gcc 3.4 warnings in x86-64
Message-ID: <20040114090854.GA1987@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Fix x86-64 warnings exposed by an gcc 3.4 snapshot.

-Andi

diff -u linux-34/arch/x86_64/mm/fault.c-o linux-34/arch/x86_64/mm/fault.c
--- linux-34/arch/x86_64/mm/fault.c-o	2004-01-09 09:27:11.000000000 +0100
+++ linux-34/arch/x86_64/mm/fault.c	2004-01-13 13:12:57.000000000 +0100
@@ -141,6 +141,10 @@
 void dump_pagetable(unsigned long address)
 {
 	pml4_t *pml4;
+	pgd_t *pgd;
+	pmd_t *pmd;
+	pte_t *pte;
+
 	asm("movq %%cr3,%0" : "=r" (pml4));
 
 	pml4 = __va((unsigned long)pml4 & PHYSICAL_PAGE_MASK); 
@@ -149,17 +153,17 @@
 	if (bad_address(pml4)) goto bad;
 	if (!pml4_present(*pml4)) goto ret; 
 
-	pgd_t *pgd = __pgd_offset_k((pgd_t *)pml4_page(*pml4), address); 
+	pgd = __pgd_offset_k((pgd_t *)pml4_page(*pml4), address); 
 	if (bad_address(pgd)) goto bad;
 	printk("PGD %lx ", pgd_val(*pgd)); 
 	if (!pgd_present(*pgd))	goto ret;
 
-	pmd_t *pmd = pmd_offset(pgd, address); 
+	pmd = pmd_offset(pgd, address); 
 	if (bad_address(pmd)) goto bad;
 	printk("PMD %lx ", pmd_val(*pmd));
 	if (!pmd_present(*pmd))	goto ret;	 
 
-	pte_t *pte = pte_offset_kernel(pmd, address);
+	pte = pte_offset_kernel(pmd, address);
 	if (bad_address(pte)) goto bad;
 	printk("PTE %lx", pte_val(*pte)); 
 ret:
diff -u linux-34/arch/x86_64/mm/k8topology.c-o linux-34/arch/x86_64/mm/k8topology.c
--- linux-34/arch/x86_64/mm/k8topology.c-o	2003-11-24 04:46:35.000000000 +0100
+++ linux-34/arch/x86_64/mm/k8topology.c	2004-01-13 13:13:09.000000000 +0100
@@ -48,6 +48,7 @@
 	int nodeid, i, nb; 
 	int found = 0;
 	int nmax; 
+	int rr;
 
 	nb = find_northbridge(); 
 	if (nb < 0) 
@@ -153,7 +154,7 @@
 	   mapping. To avoid this fill in the mapping for all possible
 	   CPUs, as the number of CPUs is not known yet. 
 	   We round robin the existing nodes. */
-	int rr = 0;
+	rr = 0;
 	for (i = 0; i < MAXNODE; i++) {
 		if (nodes_present & (1UL<<i))
 			continue;
diff -u linux-34/arch/x86_64/lib/usercopy.c-o linux-34/arch/x86_64/lib/usercopy.c
--- linux-34/arch/x86_64/lib/usercopy.c-o	2003-09-11 04:12:28.000000000 +0200
+++ linux-34/arch/x86_64/lib/usercopy.c	2004-01-13 13:19:51.000000000 +0100
@@ -88,7 +88,7 @@
 		"	.quad 1b,2b\n"
 		".previous"
 		: [size8] "=c"(size), [dst] "=&D" (__d0)
-		: [size1] "r"(size & 7), "[size8]" (size / 8), "[dst] "(addr),
+		: [size1] "r"(size & 7), "[size8]" (size / 8), "[dst]"(addr),
 		  [zero] "r" (0UL), [eight] "r" (8UL));
 	return size;
 }
diff -u linux-34/arch/x86_64/lib/csum-partial.c-o linux-34/arch/x86_64/lib/csum-partial.c
--- linux-34/arch/x86_64/lib/csum-partial.c-o	2003-10-09 00:28:48.000000000 +0200
+++ linux-34/arch/x86_64/lib/csum-partial.c	2004-01-13 13:18:44.000000000 +0100
@@ -56,6 +56,8 @@
 		}
 		count >>= 1;		/* nr of 32-bit words.. */
 		if (count) {
+			unsigned long zero;
+			unsigned count64;
 			if (4 & (unsigned long) buff) {
 				result += *(unsigned int *) buff;
 				count--;
@@ -65,8 +67,8 @@
 			count >>= 1;	/* nr of 64-bit words.. */
 
 			/* main loop using 64byte blocks */
-				unsigned long zero = 0; 
-			unsigned count64 = count >> 3; 
+			zero = 0; 
+			count64 = count >> 3; 
 			while (count64) { 
 				asm("addq 0*8(%[src]),%[res]\n\t"
 				    "adcq 1*8(%[src]),%[res]\n\t"
diff -u linux-34/arch/x86_64/ia32/sys_ia32.c-o linux-34/arch/x86_64/ia32/sys_ia32.c
--- linux-34/arch/x86_64/ia32/sys_ia32.c-o	2004-01-09 09:27:11.000000000 +0100
+++ linux-34/arch/x86_64/ia32/sys_ia32.c	2004-01-13 13:22:50.000000000 +0100
@@ -274,13 +274,16 @@
 		return -EINVAL;
 
 	if (act) {
+		compat_uptr_t handler, restorer;
+
 		if (verify_area(VERIFY_READ, act, sizeof(*act)) ||
-		    __get_user((long)new_ka.sa.sa_handler, &act->sa_handler) ||
+		    __get_user(handler, &act->sa_handler) ||
 		    __get_user(new_ka.sa.sa_flags, &act->sa_flags) ||
-		    __get_user((long)new_ka.sa.sa_restorer, &act->sa_restorer)||
+		    __get_user(restorer, &act->sa_restorer)||
 		    __copy_from_user(&set32, &act->sa_mask, sizeof(compat_sigset_t)))
 			return -EFAULT;
-
+		new_ka.sa.sa_handler = compat_ptr(handler);
+		new_ka.sa.sa_restorer = compat_ptr(restorer);
 		/* FIXME: here we rely on _COMPAT_NSIG_WORS to be >= than _NSIG_WORDS << 1 */
 		switch (_NSIG_WORDS) {
 		case 4: new_ka.sa.sa_mask.sig[3] = set32.sig[6]
@@ -331,13 +334,18 @@
 
         if (act) {
 		compat_old_sigset_t mask;
+		compat_uptr_t handler, restorer;
 
 		if (verify_area(VERIFY_READ, act, sizeof(*act)) ||
-		    __get_user((long)new_ka.sa.sa_handler, &act->sa_handler) ||
+		    __get_user(handler, &act->sa_handler) ||
 		    __get_user(new_ka.sa.sa_flags, &act->sa_flags) ||
-		    __get_user((long)new_ka.sa.sa_restorer, &act->sa_restorer) ||
+		    __get_user(restorer, &act->sa_restorer) ||
 		    __get_user(mask, &act->sa_mask))
 			return -EFAULT;
+
+		new_ka.sa.sa_handler = compat_ptr(handler);
+		new_ka.sa.sa_restorer = compat_ptr(restorer);
+
 		siginitset(&new_ka.sa.sa_mask, mask);
         }
 
@@ -525,7 +533,7 @@
 	put_user(reclen, &dirent->d_reclen);
 	copy_to_user(dirent->d_name, name, namlen);
 	put_user(0, dirent->d_name + namlen);
-	((char *) dirent) += reclen;
+	dirent = ((void *)dirent) + reclen;
 	buf->current_dir = dirent;
 	buf->count -= reclen;
 	return 0;
diff -u linux-34/arch/x86_64/kernel/aperture.c-o linux-34/arch/x86_64/kernel/aperture.c
--- linux-34/arch/x86_64/kernel/aperture.c-o	2003-08-23 13:03:11.000000000 +0200
+++ linux-34/arch/x86_64/kernel/aperture.c	2004-01-13 13:20:08.000000000 +0100
@@ -87,13 +87,15 @@
 /* Find a PCI capability */ 
 static __u32 __init find_cap(int num, int slot, int func, int cap) 
 { 
+	u8 pos;
+	int bytes;
 	if (!(read_pci_config_16(num,slot,func,PCI_STATUS) & PCI_STATUS_CAP_LIST))
 		return 0;
-	u8 pos = read_pci_config_byte(num,slot,func,PCI_CAPABILITY_LIST);
-	int bytes;
+	pos = read_pci_config_byte(num,slot,func,PCI_CAPABILITY_LIST);
 	for (bytes = 0; bytes < 48 && pos >= 0x40; bytes++) { 
+		u8 id;
 		pos &= ~3; 
-		u8 id = read_pci_config_byte(num,slot,func,pos+PCI_CAP_LIST_ID); 
+		id = read_pci_config_byte(num,slot,func,pos+PCI_CAP_LIST_ID); 
 		if (id == 0xff)
 			break;
 		if (id == cap) 
@@ -106,26 +108,31 @@
 /* Read a standard AGPv3 bridge header */
 static __u32 __init read_agp(int num, int slot, int func, int cap, u32 *order)
 { 
-	printk("AGP bridge at %02x:%02x:%02x\n", num, slot, func); 
-	u32 apsizereg = read_pci_config_16(num,slot,func, cap + 0x14);
+	u32 apsize;
+	u32 apsizereg;
+	int nbits;
+	u32 aper_low, aper_hi;
+	u64 aper;
 
+	printk("AGP bridge at %02x:%02x:%02x\n", num, slot, func); 
+	apsizereg = read_pci_config_16(num,slot,func, cap + 0x14);
 	if (apsizereg == 0xffffffff) {
 		printk("APSIZE in AGP bridge unreadable\n");
 		return 0;
 	}
 
-	u32 apsize = apsizereg & 0xfff;
+	apsize = apsizereg & 0xfff;
 	/* Some BIOS use weird encodings not in the AGPv3 table. */
 	if (apsize & 0xff) 
 		apsize |= 0xf00; 
-	int nbits = hweight16(apsize);
+	nbits = hweight16(apsize);
 	*order = 7 - nbits;
 	if ((int)*order < 0) /* < 32MB */
 		*order = 0;
 	
-	u32 aper_low = read_pci_config(num,slot,func, 0x10); 
-	u32 aper_hi = read_pci_config(num,slot,func,0x14); 
-	u64 aper = (aper_low & ~((1<<22)-1)) | ((u64)aper_hi << 32); 
+	aper_low = read_pci_config(num,slot,func, 0x10); 
+	aper_hi = read_pci_config(num,slot,func,0x14); 
+	aper = (aper_low & ~((1<<22)-1)) | ((u64)aper_hi << 32); 
 
 	printk("Aperture from AGP @ %Lx size %u MB (APSIZE %x)\n", 
 	       aper, 32 << *order, apsizereg);
@@ -155,6 +162,7 @@
 		for (slot = 0; slot < 32; slot++) { 
 			for (func = 0; func < 8; func++) { 
 				u32 class, cap;
+				u8 type;
 				class = read_pci_config(num,slot,func,
 							PCI_CLASS_REVISION);
 				if (class == 0xffffffff)
@@ -172,7 +180,7 @@
 				} 
 				
 				/* No multi-function device? */
-				u8 type = read_pci_config_byte(num,slot,func,
+				type = read_pci_config_byte(num,slot,func,
 							       PCI_HEADER_TYPE);
 				if (!(type & 0x80))
 					break;
diff -u linux-34/arch/x86_64/kernel/pci-gart.c-o linux-34/arch/x86_64/kernel/pci-gart.c
--- linux-34/arch/x86_64/kernel/pci-gart.c-o	2004-01-09 09:27:11.000000000 +0100
+++ linux-34/arch/x86_64/kernel/pci-gart.c	2004-01-13 13:10:29.000000000 +0100
@@ -117,11 +117,11 @@
 
 static void free_iommu(unsigned long offset, int size)
 { 
+	unsigned long flags;
 	if (size == 1) { 
 		clear_bit(offset, iommu_gart_bitmap); 
 		return;
 	}
-	unsigned long flags;
 	spin_lock_irqsave(&iommu_bitmap_lock, flags);
 	__clear_bit_string(iommu_gart_bitmap, offset, size);
 	spin_unlock_irqrestore(&iommu_bitmap_lock, flags);
@@ -329,6 +329,7 @@
 { 
 	unsigned long npages = to_pages(phys_mem, size);
 	unsigned long iommu_page = alloc_iommu(npages);
+	int i;
 	if (iommu_page == -1) {
 		if (!nonforced_iommu(dev, phys_mem, size))
 			return phys_mem; 
@@ -338,7 +339,6 @@
 		return bad_dma_address;
 	}
 
-	int i;
 	for (i = 0; i < npages; i++) {
 		iommu_gatt_base[iommu_page + i] = GPTE_ENCODE(phys_mem);
 		SET_LEAK(iommu_page + i);
@@ -396,11 +396,11 @@
 		      struct scatterlist *sout, unsigned long pages)
 {
 	unsigned long iommu_start = alloc_iommu(pages);
-	if (iommu_start == -1)
-		return -1;
-
 	unsigned long iommu_page = iommu_start; 
 	int i;
+
+	if (iommu_start == -1)
+		return -1;
 	
 	for (i = start; i < stopat; i++) {
 		struct scatterlist *s = &sg[i];
@@ -518,12 +518,12 @@
 {
 	unsigned long iommu_page; 
 	int npages;
+	int i;
 	if (dma_addr < iommu_bus_base + EMERGENCY_PAGES*PAGE_SIZE || 
 	    dma_addr > iommu_bus_base + iommu_size)
 		return;
 	iommu_page = (dma_addr - iommu_bus_base)>>PAGE_SHIFT;	
 	npages = to_pages(dma_addr, size);
-	int i;
 	for (i = 0; i < npages; i++) { 
 		iommu_gatt_base[iommu_page + i] = 0; 
 		CLEAR_LEAK(iommu_page + i);
diff -u linux-34/arch/x86_64/kernel/nmi.c-o linux-34/arch/x86_64/kernel/nmi.c
--- linux-34/arch/x86_64/kernel/nmi.c-o	2003-09-28 10:53:16.000000000 +0200
+++ linux-34/arch/x86_64/kernel/nmi.c	2004-01-13 13:09:50.000000000 +0100
@@ -311,11 +311,11 @@
 
 void nmi_watchdog_tick (struct pt_regs * regs, unsigned reason)
 {
+	int sum, cpu = safe_smp_processor_id();
+
 	if (nmi_watchdog_disabled)
 		return;
 
-	int sum, cpu = safe_smp_processor_id();
-
 	sum = read_pda(apic_timer_irqs);
 	if (last_irq_sums[cpu] == sum) {
 		/*
diff -u linux-34/arch/x86_64/kernel/x8664_ksyms.c-o linux-34/arch/x86_64/kernel/x8664_ksyms.c
--- linux-34/arch/x86_64/kernel/x8664_ksyms.c-o	2003-11-24 04:46:35.000000000 +0100
+++ linux-34/arch/x86_64/kernel/x8664_ksyms.c	2004-01-13 13:09:27.000000000 +0100
@@ -155,7 +155,7 @@
 
 extern void * memset(void *,int,__kernel_size_t);
 extern size_t strlen(const char *);
-extern void bcopy(const char * src, char * dest, int count);
+extern void bcopy(const void * src, void * dest, size_t count);
 extern void * memmove(void * dest,const void *src,size_t count);
 extern char * strcpy(char * dest,const char *src);
 extern int strcmp(const char * cs,const char * ct);
diff -u linux-34/include/asm-x86_64/apic.h-o linux-34/include/asm-x86_64/apic.h
--- linux-34/include/asm-x86_64/apic.h-o	2003-08-09 16:48:14.000000000 +0200
+++ linux-34/include/asm-x86_64/apic.h	2004-01-13 12:57:39.000000000 +0100
@@ -79,7 +79,7 @@
 extern void enable_lapic_nmi_watchdog(void);
 extern void disable_timer_nmi_watchdog(void);
 extern void enable_timer_nmi_watchdog(void);
-extern inline void nmi_watchdog_tick (struct pt_regs * regs, unsigned reason);
+extern void nmi_watchdog_tick (struct pt_regs * regs, unsigned reason);
 extern int APIC_init_uniprocessor (void);
 extern void disable_APIC_timer(void);
 extern void enable_APIC_timer(void);
diff -u linux-34/include/asm-x86_64/unistd.h-o linux-34/include/asm-x86_64/unistd.h
--- linux-34/include/asm-x86_64/unistd.h-o	2004-01-09 09:27:19.000000000 +0100
+++ linux-34/include/asm-x86_64/unistd.h	2004-01-13 13:15:06.000000000 +0100
@@ -694,7 +694,7 @@
 }
 
 extern long sys_exit(int) __attribute__((noreturn));
-extern inline long exit(int error_code)
+extern inline void exit(int error_code)
 {
 	sys_exit(error_code);
 }
diff -u linux-34/include/asm-x86_64/hw_irq.h-o linux-34/include/asm-x86_64/hw_irq.h
--- linux-34/include/asm-x86_64/hw_irq.h-o	2004-01-09 09:27:19.000000000 +0100
+++ linux-34/include/asm-x86_64/hw_irq.h	2004-01-13 13:00:36.000000000 +0100
@@ -77,7 +77,7 @@
 
 #ifndef __ASSEMBLY__
 extern u8 irq_vector[NR_IRQ_VECTORS];
-#define IO_APIC_VECTOR(irq)	((int)irq_vector[irq])
+#define IO_APIC_VECTOR(irq)	(irq_vector[irq])
 
 /*
  * Various low-level irq details needed by irq.c, process.c,

