Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286310AbSABTJA>; Wed, 2 Jan 2002 14:09:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287905AbSABTIp>; Wed, 2 Jan 2002 14:08:45 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:40934 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S287903AbSABTIU>;
	Wed, 2 Jan 2002 14:08:20 -0500
Date: Wed, 2 Jan 2002 20:08:18 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200201021908.UAA18846@harpo.it.uu.se>
To: torvalds@transmeta.com
Subject: [PATCH] DMI/APIC updates 2 of 4: boot-time-ioremap
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

This is part 2 of 4 of a patch set for 2.5.2-pre6 to move the
x86 DMI scan to an earlier point in the boot sequence. This is
motivated by the UP APIC code, which must be disabled on some
machines with broken BIOSen, but there are also other cases that
would benefit from it. Tested. Please apply.

This second patch (patch-boot-time-ioremap) implements bt_ioremap(),
a clone of ioremap() which works early in the boot process. It
requires the boot-time-fixmaps patch I posted previously.

/Mikael

diff -ruN linux-2.5.2-pre6/arch/i386/mm/ioremap.c linux-2.5.2-pre6.boot-time-ioremap/arch/i386/mm/ioremap.c
--- linux-2.5.2-pre6/arch/i386/mm/ioremap.c	Tue Mar 20 17:13:33 2001
+++ linux-2.5.2-pre6.boot-time-ioremap/arch/i386/mm/ioremap.c	Wed Jan  2 00:56:14 2002
@@ -161,3 +161,68 @@
 	if (addr > high_memory)
 		return vfree((void *) (PAGE_MASK & (unsigned long) addr));
 }
+
+void __init *bt_ioremap(unsigned long phys_addr, unsigned long size)
+{
+	unsigned long offset, last_addr;
+	unsigned int nrpages;
+	enum fixed_addresses idx;
+
+	/* Don't allow wraparound or zero size */
+	last_addr = phys_addr + size - 1;
+	if (!size || last_addr < phys_addr)
+		return NULL;
+
+	/*
+	 * Don't remap the low PCI/ISA area, it's always mapped..
+	 */
+	if (phys_addr >= 0xA0000 && last_addr < 0x100000)
+		return phys_to_virt(phys_addr);
+
+	/*
+	 * Mappings have to be page-aligned
+	 */
+	offset = phys_addr & ~PAGE_MASK;
+	phys_addr &= PAGE_MASK;
+	size = PAGE_ALIGN(last_addr) - phys_addr;
+
+	/*
+	 * Mappings have to fit in the FIX_BTMAP area.
+	 */
+	nrpages = size >> PAGE_SHIFT;
+	if (nrpages > NR_FIX_BTMAPS)
+		return NULL;
+
+	/*
+	 * Ok, go for it..
+	 */
+	idx = FIX_BTMAP_BEGIN;
+	while (nrpages > 0) {
+		set_fixmap(idx, phys_addr);
+		phys_addr += PAGE_SIZE;
+		--idx;
+		--nrpages;
+	}
+	return (void*) (offset + fix_to_virt(FIX_BTMAP_BEGIN));
+}
+
+void __init bt_iounmap(void *addr, unsigned long size)
+{
+	unsigned long virt_addr;
+	unsigned long offset;
+	unsigned int nrpages;
+	enum fixed_addresses idx;
+
+	virt_addr = (unsigned long)addr;
+	if (virt_addr < fix_to_virt(FIX_BTMAP_BEGIN))
+		return;
+	offset = virt_addr & ~PAGE_MASK;
+	nrpages = PAGE_ALIGN(offset + size - 1) >> PAGE_SHIFT;
+
+	idx = FIX_BTMAP_BEGIN;
+	while (nrpages > 0) {
+		__set_fixmap(idx, 0, __pgprot(0));
+		--idx;
+		--nrpages;
+	}
+}
diff -ruN linux-2.5.2-pre6/include/asm-i386/io.h linux-2.5.2-pre6.boot-time-ioremap/include/asm-i386/io.h
--- linux-2.5.2-pre6/include/asm-i386/io.h	Tue Dec 18 00:40:12 2001
+++ linux-2.5.2-pre6.boot-time-ioremap/include/asm-i386/io.h	Wed Jan  2 00:56:14 2002
@@ -95,6 +95,14 @@
 extern void iounmap(void *addr);
 
 /*
+ * bt_ioremap() and bt_iounmap() are for temporary early boot-time
+ * mappings, before the real ioremap() is functional.
+ * A boot-time mapping is currently limited to at most 16 pages.
+ */
+extern void *bt_ioremap(unsigned long offset, unsigned long size);
+extern void bt_iounmap(void *addr, unsigned long size);
+
+/*
  * IO bus memory addresses are also 1:1 with the physical address
  */
 #define virt_to_bus virt_to_phys
