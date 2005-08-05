Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261256AbVHEXtv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261256AbVHEXtv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 19:49:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263133AbVHEXs0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 19:48:26 -0400
Received: from smtp.osdl.org ([65.172.181.4]:20907 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263143AbVHEXq7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 19:46:59 -0400
Date: Fri, 5 Aug 2005 16:46:55 -0700
From: Chris Wright <chrisw@osdl.org>
To: Zachary Amsden <zach@vmware.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       virtualization@lists.osdl.org, xen-devel@lists.xensource.com
Subject: Re: [PATCH, experimental] i386 Allow the fixmap to be relocated at boot time
Message-ID: <20050805234655.GY7762@shell0.pdx.osdl.net>
References: <42F3F61F.30305@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42F3F61F.30305@vmware.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Zachary Amsden (zach@vmware.com) wrote:
> This most curious patch allows the fixmap on i386 to be unfixed.  The 
> result is that we can create a dynamically sizable hole at the top of 
> kernel linear address space.  I know at least some virtualization 
> developers are interested in being able to achieve this to achieve 
> run-time sizing of a hole in which a hypervisor can live, or at least to 
> test out the performance characteristics of different sized holes.

I've done it simpler with keeping it fixed but defined by the subarch.
Patch is stupid simple (and untested).  Do you think there's a huge gain
for dynamically sizing?

--- linux-2.6.12/include/asm-i386/fixmap.h	2005-06-17 12:48:29.000000000 -0700
+++ linux-2.6.12-subarch/include/asm-i386/fixmap.h	2005-08-01 15:27:05.000000000 -0700
@@ -15,82 +15,9 @@
 
 #include <linux/config.h>
 
-/* used by vmalloc.c, vsyscall.lds.S.
- *
- * Leave one empty page between vmalloc'ed areas and
- * the start of the fixmap.
- */
-#define __FIXADDR_TOP	0xfffff000
+#include <mach_fixmap.h>
 
 #ifndef __ASSEMBLY__
-#include <linux/kernel.h>
-#include <asm/acpi.h>
-#include <asm/apicdef.h>
-#include <asm/page.h>
-#ifdef CONFIG_HIGHMEM
-#include <linux/threads.h>
-#include <asm/kmap_types.h>
-#endif
-
-/*
- * Here we define all the compile-time 'special' virtual
- * addresses. The point is to have a constant address at
- * compile time, but to set the physical address only
- * in the boot process. We allocate these special addresses
- * from the end of virtual memory (0xfffff000) backwards.
- * Also this lets us do fail-safe vmalloc(), we
- * can guarantee that these special addresses and
- * vmalloc()-ed addresses never overlap.
- *
- * these 'compile-time allocated' memory buffers are
- * fixed-size 4k pages. (or larger if used with an increment
- * highger than 1) use fixmap_set(idx,phys) to associate
- * physical memory with fixmap indices.
- *
- * TLB entries of such buffers will not be flushed across
- * task switches.
- */
-enum fixed_addresses {
-	FIX_HOLE,
-	FIX_VSYSCALL,
-#ifdef CONFIG_X86_LOCAL_APIC
-	FIX_APIC_BASE,	/* local (CPU) APIC) -- required for SMP or not */
-#endif
-#ifdef CONFIG_X86_IO_APIC
-	FIX_IO_APIC_BASE_0,
-	FIX_IO_APIC_BASE_END = FIX_IO_APIC_BASE_0 + MAX_IO_APICS-1,
-#endif
-#ifdef CONFIG_X86_VISWS_APIC
-	FIX_CO_CPU,	/* Cobalt timer */
-	FIX_CO_APIC,	/* Cobalt APIC Redirection Table */ 
-	FIX_LI_PCIA,	/* Lithium PCI Bridge A */
-	FIX_LI_PCIB,	/* Lithium PCI Bridge B */
-#endif
-#ifdef CONFIG_X86_F00F_BUG
-	FIX_F00F_IDT,	/* Virtual mapping for IDT */
-#endif
-#ifdef CONFIG_X86_CYCLONE_TIMER
-	FIX_CYCLONE_TIMER, /*cyclone timer register*/
-#endif 
-#ifdef CONFIG_HIGHMEM
-	FIX_KMAP_BEGIN,	/* reserved pte's for temporary kernel mappings */
-	FIX_KMAP_END = FIX_KMAP_BEGIN+(KM_TYPE_NR*NR_CPUS)-1,
-#endif
-#ifdef CONFIG_ACPI_BOOT
-	FIX_ACPI_BEGIN,
-	FIX_ACPI_END = FIX_ACPI_BEGIN + FIX_ACPI_PAGES - 1,
-#endif
-#ifdef CONFIG_PCI_MMCONFIG
-	FIX_PCIE_MCFG,
-#endif
-	__end_of_permanent_fixed_addresses,
-	/* temporary boot-time mappings, used before ioremap() is functional */
-#define NR_FIX_BTMAPS	16
-	FIX_BTMAP_END = __end_of_permanent_fixed_addresses,
-	FIX_BTMAP_BEGIN = FIX_BTMAP_END + NR_FIX_BTMAPS - 1,
-	FIX_WP_TEST,
-	__end_of_fixed_addresses
-};
 
 extern void __set_fixmap (enum fixed_addresses idx,
 					unsigned long phys, pgprot_t flags);
--- linux-2.6.12/include/asm-i386/mach-default/mach_fixmap.h	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.12-subarch/include/asm-i386/mach-default/mach_fixmap.h	2005-08-01 15:27:44.000000000 -0700
@@ -0,0 +1,93 @@
+/*
+ * mach_fixmap.h: mach dependent fixmap split out from fixmap.h
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 1998 Ingo Molnar
+ *
+ * Support of BIGMEM added by Gerhard Wichert, Siemens AG, July 1999
+ */
+
+#ifndef _ASM_MACH_FIXMAP_H
+#define _ASM_MACH_FIXMAP_H
+
+/* used by vmalloc.c, vsyscall.lds.S.
+ *
+ * Leave one empty page between vmalloc'ed areas and
+ * the start of the fixmap.
+ */
+#define __FIXADDR_TOP	0xfffff000
+
+#ifndef __ASSEMBLY__
+#include <linux/kernel.h>
+#include <asm/acpi.h>
+#include <asm/apicdef.h>
+#include <asm/page.h>
+#ifdef CONFIG_HIGHMEM
+#include <linux/threads.h>
+#include <asm/kmap_types.h>
+#endif
+/*
+ * Here we define all the compile-time 'special' virtual
+ * addresses. The point is to have a constant address at
+ * compile time, but to set the physical address only
+ * in the boot process. We allocate these special addresses
+ * from the end of virtual memory (0xfffff000) backwards.
+ * Also this lets us do fail-safe vmalloc(), we
+ * can guarantee that these special addresses and
+ * vmalloc()-ed addresses never overlap.
+ *
+ * these 'compile-time allocated' memory buffers are
+ * fixed-size 4k pages. (or larger if used with an increment
+ * highger than 1) use fixmap_set(idx,phys) to associate
+ * physical memory with fixmap indices.
+ *
+ * TLB entries of such buffers will not be flushed across
+ * task switches.
+ */
+enum fixed_addresses {
+	FIX_HOLE,
+	FIX_VSYSCALL,
+#ifdef CONFIG_X86_LOCAL_APIC
+	FIX_APIC_BASE,	/* local (CPU) APIC) -- required for SMP or not */
+#endif
+#ifdef CONFIG_X86_IO_APIC
+	FIX_IO_APIC_BASE_0,
+	FIX_IO_APIC_BASE_END = FIX_IO_APIC_BASE_0 + MAX_IO_APICS-1,
+#endif
+#ifdef CONFIG_X86_VISWS_APIC
+	FIX_CO_CPU,	/* Cobalt timer */
+	FIX_CO_APIC,	/* Cobalt APIC Redirection Table */ 
+	FIX_LI_PCIA,	/* Lithium PCI Bridge A */
+	FIX_LI_PCIB,	/* Lithium PCI Bridge B */
+#endif
+#ifdef CONFIG_X86_F00F_BUG
+	FIX_F00F_IDT,	/* Virtual mapping for IDT */
+#endif
+#ifdef CONFIG_X86_CYCLONE_TIMER
+	FIX_CYCLONE_TIMER, /*cyclone timer register*/
+#endif 
+#ifdef CONFIG_HIGHMEM
+	FIX_KMAP_BEGIN,	/* reserved pte's for temporary kernel mappings */
+	FIX_KMAP_END = FIX_KMAP_BEGIN+(KM_TYPE_NR*NR_CPUS)-1,
+#endif
+#ifdef CONFIG_ACPI_BOOT
+	FIX_ACPI_BEGIN,
+	FIX_ACPI_END = FIX_ACPI_BEGIN + FIX_ACPI_PAGES - 1,
+#endif
+#ifdef CONFIG_PCI_MMCONFIG
+	FIX_PCIE_MCFG,
+#endif
+	__end_of_permanent_fixed_addresses,
+	/* temporary boot-time mappings, used before ioremap() is functional */
+#define NR_FIX_BTMAPS	16
+	FIX_BTMAP_END = __end_of_permanent_fixed_addresses,
+	FIX_BTMAP_BEGIN = FIX_BTMAP_END + NR_FIX_BTMAPS - 1,
+	FIX_WP_TEST,
+	__end_of_fixed_addresses
+};
+
+#endif /* !__ASSEMBLY__ */
+#endif
