Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261451AbUIVHgy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261451AbUIVHgy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 03:36:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261426AbUIVHgy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 03:36:54 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:6291 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261474AbUIVHgg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 03:36:36 -0400
To: Paul Mackerras <paulus@samba.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Petr Vandrovec <vandrove@vc.cvut.cz>
X-Message-Flag: Warning: May contain useful information
References: <1095758630.3332.133.camel@gaston>
	<1095761113.30931.13.camel@localhost.localdomain>
	<1095766919.3577.138.camel@gaston> <523c1bpghm.fsf@topspin.com>
	<Pine.LNX.4.58.0409211237510.25656@ppc970.osdl.org>
	<52mzzjnuq7.fsf@topspin.com>
	<Pine.LNX.4.58.0409211510150.25656@ppc970.osdl.org>
	<16720.57400.930844.91232@cargo.ozlabs.ibm.com>
From: Roland Dreier <roland@topspin.com>
Date: Wed, 22 Sep 2004 00:36:34 -0700
In-Reply-To: <16720.57400.930844.91232@cargo.ozlabs.ibm.com> (Paul
 Mackerras's message of "Tue, 21 Sep 2004 21:15:20 -0500")
Message-ID: <52hdpqoiv1.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: roland@topspin.com
Subject: Re: [PATCH] ppc64: Fix __raw_* IO accessors
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 22 Sep 2004 07:36:34.0845 (UTC) FILETIME=[E3035CD0:01C4A076]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Paul> I believe this was done so that we could quickly work out
    Paul> the pci bus/device/function inside read/write[bwl].  We
    Paul> needed that for coping with the "Enhanced Error Handling"
    Paul> (EEH) stuff on pSeries machines.  I think we used to stuff
    Paul> the pci bus/dev/fn in the high bits and then change the top
    Paul> 4 bits to make quite clear that it wasn't a valid pointer.
    Paul> These days we don't put the pci bus/dev/fn in the high bits
    Paul> and we could certainly get rid of the IO_TOKEN_TO_ADDR
    Paul> games.

Here's a patch that gets rid of IO_TOKEN_TO_ADDR.  It's lightly tested
on my p630 (boots fine and my InfiniBand driver works well).

Thanks,
  Roland


Get rid of IO_TOKEN_TO_ADDR() and IO_ADDR_TO_TOKEN() for pSeries EEH;
the conversion to tokens is not needed now that we have __iomem
annotations to prevent drivers from dereferencing IO addresses.

Signed-off-by: Roland Dreier <roland@topspin.com>

Index: linux-bk/arch/ppc64/kernel/eeh.c
===================================================================
--- linux-bk.orig/arch/ppc64/kernel/eeh.c	2004-09-21 14:55:33.000000000 -0700
+++ linux-bk/arch/ppc64/kernel/eeh.c	2004-09-22 00:14:25.000000000 -0700
@@ -335,26 +335,19 @@
 
 /**
  * eeh_token_to_phys - convert EEH address token to phys address
- * @token i/o token, should be address in the form 0xA....
- *
- * Converts EEH address tokens into physical addresses.  Note that
- * ths routine does *not* convert I/O BAR addresses (which start
- * with 0xE...) to phys addresses!
+ * @token i/o token, should be address in the form 0xE....
  */
 static inline unsigned long eeh_token_to_phys(unsigned long token)
 {
 	pte_t *ptep;
-	unsigned long pa, vaddr;
+	unsigned long pa;
 
-	if (REGION_ID(token) == EEH_REGION_ID)
-		vaddr = IO_TOKEN_TO_ADDR(token);
-	else
+	ptep = find_linux_pte(ioremap_mm.pgd, token);
+	if (!ptep)
 		return token;
-
-	ptep = find_linux_pte(ioremap_mm.pgd, vaddr);
 	pa = pte_pfn(*ptep) << PAGE_SHIFT;
 
-	return pa | (vaddr & (PAGE_SIZE-1));
+	return pa | (token & (PAGE_SIZE-1));
 }
 
 /**
@@ -473,7 +466,7 @@
 	struct device_node *dn;
 
 	/* Finding the phys addr + pci device; this is pretty quick. */
-	addr = eeh_token_to_phys((unsigned long)token);
+	addr = eeh_token_to_phys((unsigned long __force) token);
 	dev = pci_get_device_by_addr(addr);
 	if (!dev)
 		return val;
@@ -750,15 +743,15 @@
  */
 void ioread8_rep(void __iomem *addr, void *dst, unsigned long count)
 {
-	_insb((void *) IO_TOKEN_TO_ADDR(addr), dst, count);
+	_insb((u8 __force *) addr, dst, count);
 }
 void ioread16_rep(void __iomem *addr, void *dst, unsigned long count)
 {
-	_insw_ns((void *) IO_TOKEN_TO_ADDR(addr), dst, count);
+	_insw_ns((u16 __force *) addr, dst, count);
 }
 void ioread32_rep(void __iomem *addr, void *dst, unsigned long count)
 {
-	_insl_ns((void *) IO_TOKEN_TO_ADDR(addr), dst, count);
+	_insl_ns((u32 __force *) addr, dst, count);
 }
 EXPORT_SYMBOL(ioread8_rep);
 EXPORT_SYMBOL(ioread16_rep);
@@ -766,15 +759,15 @@
 
 void iowrite8_rep(void __iomem *addr, const void *src, unsigned long count)
 {
-	_outsb((void *) IO_TOKEN_TO_ADDR(addr), src, count);
+	_outsb((u8 __force *) addr, src, count);
 }
 void iowrite16_rep(void __iomem *addr, const void *src, unsigned long count)
 {
-	_outsw_ns((void *) IO_TOKEN_TO_ADDR(addr), src, count);
+	_outsw_ns((u16 __force *) addr, src, count);
 }
 void iowrite32_rep(void __iomem *addr, const void *src, unsigned long count)
 {
-	_outsl_ns((void *) IO_TOKEN_TO_ADDR(addr), src, count);
+	_outsl_ns((u32 __force *) addr, src, count);
 }
 EXPORT_SYMBOL(iowrite8_rep);
 EXPORT_SYMBOL(iowrite16_rep);
@@ -784,7 +777,7 @@
 {
 	if (!_IO_IS_VALID(port))
 		return NULL;
-	return (void __iomem *) IO_ADDR_TO_TOKEN(port+pci_io_base);
+	return (void __iomem *) (port+pci_io_base);
 }
 
 void ioport_unmap(void __iomem *addr)
@@ -806,15 +799,8 @@
 		len = max;
 	if (flags & IORESOURCE_IO)
 		return ioport_map(start, len);
-	if (flags & IORESOURCE_MEM) {
-		void __iomem *vaddr = (void __iomem *) start;
-		if (dev  && eeh_subsystem_enabled) {
-			struct device_node *dn = pci_device_to_OF_node(dev);
-			if (dn && !(dn->eeh_mode & EEH_MODE_NOCHECK))
-				return (void __iomem *) IO_ADDR_TO_TOKEN(vaddr);
-		}
-		return vaddr;
-	}
+	if (flags & IORESOURCE_MEM)
+		return (void __iomem *) start;
 	/* What? */
 	return NULL;
 }
@@ -826,39 +812,6 @@
 EXPORT_SYMBOL(pci_iomap);
 EXPORT_SYMBOL(pci_iounmap);
 
-/*
- * If EEH is implemented, find the PCI device using given phys addr
- * and check to see if eeh failure checking is disabled.
- * Remap the addr (trivially) to the EEH region if EEH checking enabled.
- * For addresses not known to PCI the vaddr is simply returned unchanged.
- */
-void __iomem *eeh_ioremap(unsigned long addr, void __iomem *vaddr)
-{
-	struct pci_dev *dev;
-	struct device_node *dn;
-
-	if (!eeh_subsystem_enabled)
-		return vaddr;
-
-	dev = pci_get_device_by_addr(addr);
-	if (!dev)
-		return vaddr;
-
-	dn = pci_device_to_OF_node(dev);
-	if (!dn) {
-		pci_dev_put(dev);
-		return vaddr;
-	}
-
-	if (dn->eeh_mode & EEH_MODE_NOCHECK) {
-		pci_dev_put(dev);
-		return vaddr;
-	}
-
-	pci_dev_put(dev);
-	return (void __iomem *)IO_ADDR_TO_TOKEN(vaddr);
-}
-
 static int proc_eeh_show(struct seq_file *m, void *v)
 {
 	unsigned int cpu;
Index: linux-bk/arch/ppc64/mm/init.c
===================================================================
--- linux-bk.orig/arch/ppc64/mm/init.c	2004-09-21 14:55:02.000000000 -0700
+++ linux-bk/arch/ppc64/mm/init.c	2004-09-21 19:42:58.000000000 -0700
@@ -203,10 +203,7 @@
 void __iomem *
 ioremap(unsigned long addr, unsigned long size)
 {
-	void __iomem *ret = __ioremap(addr, size, _PAGE_NO_CACHE);
-	if(mem_init_done)
-		return eeh_ioremap(addr, ret);	/* may remap the addr */
-	return ret;
+	return __ioremap(addr, size, _PAGE_NO_CACHE);
 }
 
 void __iomem *
@@ -363,9 +360,7 @@
 		return;
 	}
 	
-	/* addr could be in EEH or IO region, map it to IO region regardless.
-	 */
-	addr = (void *) (IO_TOKEN_TO_ADDR(token) & PAGE_MASK);
+	addr = (void *) ((unsigned long __force) token & PAGE_MASK);
 	
 	if ((size = im_free(addr)) == 0) {
 		return;
@@ -415,9 +410,7 @@
 	unsigned long addr;
 	int rc;
 	
-	/* addr could be in EEH or IO region, map it to IO region regardless.
-	 */
-	addr = (IO_TOKEN_TO_ADDR(start) & PAGE_MASK);
+	addr = (unsigned long __force) start & PAGE_MASK;
 
 	/* Verify that the region either exists or is a subset of an existing
 	 * region.  In the latter case, split the parent region to create 
Index: linux-bk/include/asm-ppc64/eeh.h
===================================================================
--- linux-bk.orig/include/asm-ppc64/eeh.h	2004-09-21 14:57:25.000000000 -0700
+++ linux-bk/include/asm-ppc64/eeh.h	2004-09-21 19:39:19.000000000 -0700
@@ -26,18 +26,6 @@
 struct pci_dev;
 struct device_node;
 
-/* I/O addresses are converted to EEH "tokens" such that a driver will cause
- * a bad page fault if the address is used directly (i.e. these addresses are
- * never actually mapped.  Translation between IO <-> EEH region is 1 to 1.
- */
-#define IO_TOKEN_TO_ADDR(token) \
-	(((unsigned long __force)(token) & ~(0xfUL << REGION_SHIFT)) | \
-	(IO_REGION_ID << REGION_SHIFT))
-
-#define IO_ADDR_TO_TOKEN(addr) \
-	(((unsigned long)(addr) & ~(0xfUL << REGION_SHIFT)) | \
-	(EEH_REGION_ID << REGION_SHIFT))
-
 /* Values for eeh_mode bits in device_node */
 #define EEH_MODE_SUPPORTED	(1<<0)
 #define EEH_MODE_NOCHECK	(1<<1)
@@ -109,83 +97,83 @@
  * MMIO read/write operations with EEH support.
  */
 static inline u8 eeh_readb(const volatile void __iomem *addr) {
-	volatile u8 *vaddr = (volatile u8 *)IO_TOKEN_TO_ADDR(addr);
+	volatile u8 *vaddr = (volatile u8 __force *) addr;
 	u8 val = in_8(vaddr);
 	if (EEH_POSSIBLE_ERROR(addr, vaddr, val, u8))
 		return eeh_check_failure(addr, val);
 	return val;
 }
 static inline void eeh_writeb(u8 val, volatile void __iomem *addr) {
-	volatile u8 *vaddr = (volatile u8 *)IO_TOKEN_TO_ADDR(addr);
+	volatile u8 *vaddr = (volatile u8 __force *) addr;
 	out_8(vaddr, val);
 }
 
 static inline u16 eeh_readw(const volatile void __iomem *addr) {
-	volatile u16 *vaddr = (volatile u16 *)IO_TOKEN_TO_ADDR(addr);
+	volatile u16 *vaddr = (volatile u16 __force *) addr;
 	u16 val = in_le16(vaddr);
 	if (EEH_POSSIBLE_ERROR(addr, vaddr, val, u16))
 		return eeh_check_failure(addr, val);
 	return val;
 }
 static inline void eeh_writew(u16 val, volatile void __iomem *addr) {
-	volatile u16 *vaddr = (volatile u16 *)IO_TOKEN_TO_ADDR(addr);
+	volatile u16 *vaddr = (volatile u16 __force *) addr;
 	out_le16(vaddr, val);
 }
 static inline u16 eeh_raw_readw(const volatile void __iomem *addr) {
-	volatile u16 *vaddr = (volatile u16 *)IO_TOKEN_TO_ADDR(addr);
+	volatile u16 *vaddr = (volatile u16 __force *) addr;
 	u16 val = in_be16(vaddr);
 	if (EEH_POSSIBLE_ERROR(addr, vaddr, val, u16))
 		return eeh_check_failure(addr, val);
 	return val;
 }
 static inline void eeh_raw_writew(u16 val, volatile void __iomem *addr) {
-	volatile u16 *vaddr = (volatile u16 *)IO_TOKEN_TO_ADDR(addr);
+	volatile u16 *vaddr = (volatile u16 __force *) addr;
 	out_be16(vaddr, val);
 }
 
 static inline u32 eeh_readl(const volatile void __iomem *addr) {
-	volatile u32 *vaddr = (volatile u32 *)IO_TOKEN_TO_ADDR(addr);
+	volatile u32 *vaddr = (volatile u32 __force *) addr;
 	u32 val = in_le32(vaddr);
 	if (EEH_POSSIBLE_ERROR(addr, vaddr, val, u32))
 		return eeh_check_failure(addr, val);
 	return val;
 }
 static inline void eeh_writel(u32 val, volatile void __iomem *addr) {
-	volatile u32 *vaddr = (volatile u32 *)IO_TOKEN_TO_ADDR(addr);
+	volatile u32 *vaddr = (volatile u32 __force *) addr;
 	out_le32(vaddr, val);
 }
 static inline u32 eeh_raw_readl(const volatile void __iomem *addr) {
-	volatile u32 *vaddr = (volatile u32 *)IO_TOKEN_TO_ADDR(addr);
+	volatile u32 *vaddr = (volatile u32 __force *) addr;
 	u32 val = in_be32(vaddr);
 	if (EEH_POSSIBLE_ERROR(addr, vaddr, val, u32))
 		return eeh_check_failure(addr, val);
 	return val;
 }
 static inline void eeh_raw_writel(u32 val, volatile void __iomem *addr) {
-	volatile u32 *vaddr = (volatile u32 *)IO_TOKEN_TO_ADDR(addr);
+	volatile u32 *vaddr = (volatile u32 __force *) addr;
 	out_be32(vaddr, val);
 }
 
 static inline u64 eeh_readq(const volatile void __iomem *addr) {
-	volatile u64 *vaddr = (volatile u64 *)IO_TOKEN_TO_ADDR(addr);
+	volatile u64 *vaddr = (volatile u64 __force *) addr;
 	u64 val = in_le64(vaddr);
 	if (EEH_POSSIBLE_ERROR(addr, vaddr, val, u64))
 		return eeh_check_failure(addr, val);
 	return val;
 }
 static inline void eeh_writeq(u64 val, volatile void __iomem *addr) {
-	volatile u64 *vaddr = (volatile u64 *)IO_TOKEN_TO_ADDR(addr);
+	volatile u64 *vaddr = (volatile u64 __force *) addr;
 	out_le64(vaddr, val);
 }
 static inline u64 eeh_raw_readq(const volatile void __iomem *addr) {
-	volatile u64 *vaddr = (volatile u64 *)IO_TOKEN_TO_ADDR(addr);
+	volatile u64 *vaddr = (volatile u64 __force *) addr;
 	u64 val = in_be64(vaddr);
 	if (EEH_POSSIBLE_ERROR(addr, vaddr, val, u64))
 		return eeh_check_failure(addr, val);
 	return val;
 }
 static inline void eeh_raw_writeq(u64 val, volatile void __iomem *addr) {
-	volatile u64 *vaddr = (volatile u64 *)IO_TOKEN_TO_ADDR(addr);
+	volatile u64 *vaddr = (volatile u64 __force *) addr;
 	out_be64(vaddr, val);
 }
 
@@ -193,7 +181,7 @@
 	((((unsigned long)(v)) & ((a) - 1)) == 0)
 
 static inline void eeh_memset_io(volatile void __iomem *addr, int c, unsigned long n) {
-	void *vaddr = (void *)IO_TOKEN_TO_ADDR(addr);
+	void *vaddr = (void __force *) addr;
 	u32 lc = c;
 	lc |= lc << 8;
 	lc |= lc << 16;
@@ -216,7 +204,7 @@
 	__asm__ __volatile__ ("sync" : : : "memory");
 }
 static inline void eeh_memcpy_fromio(void *dest, const volatile void __iomem *src, unsigned long n) {
-	void *vsrc = (void *)IO_TOKEN_TO_ADDR(src);
+	void *vsrc = (void __force *) src;
 	void *vsrcsave = vsrc, *destsave = dest;
 	const volatile void __iomem *srcsave = src;
 	unsigned long nsave = n;
@@ -255,7 +243,7 @@
 }
 
 static inline void eeh_memcpy_toio(volatile void __iomem *dest, const void *src, unsigned long n) {
-	void *vdest = (void *)IO_TOKEN_TO_ADDR(dest);
+	void *vdest = (void __force *) dest;
 
 	while(n && (!EEH_CHECK_ALIGN(vdest, 4) || !EEH_CHECK_ALIGN(src, 4))) {
 		*((volatile u8 *)vdest) = *((u8 *)src);
