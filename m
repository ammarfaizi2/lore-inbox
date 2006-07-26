Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030346AbWGZRjS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030346AbWGZRjS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 13:39:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030350AbWGZRjS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 13:39:18 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:42965 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1030346AbWGZRjR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 13:39:17 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andi Kleen <ak@suse.de>
Subject: Re: swsusp status report
Date: Wed, 26 Jul 2006 19:38:39 +0200
User-Agent: KMail/1.9.3
Cc: Linux PM <linux-pm@osdl.org>, Pavel Machek <pavel@ucw.cz>,
       linux-kernel@vger.kernel.org
References: <200607251325.14747.rjw@sisk.pl> <p73fygo5ri9.fsf@verdi.suse.de>
In-Reply-To: <p73fygo5ri9.fsf@verdi.suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607261938.39213.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 26 July 2006 17:13, Andi Kleen wrote:
> "Rafael J. Wysocki" <rjw@sisk.pl> writes:
> > 
> > The code that restores the memory state from the suspend image in step
> > (11) also uses the kernel identity mapping to address memory, so it cannot
> > access highmem pages on i386, but it practically has no other limitations as
> > far as the image size is concerned.  In other words, it would be possible to
> > restore suspend images as big as 80% or even 90% of RAM, or the normal zone
> > on i386, if the 'snapshotting' code were able to create them.
> 
> Why can't you just kmap or ioremap them as needed and pass the pfns/struct
> page * for IO?

In principle we can, but that's a long way to go from where we are today.

Currently, we need to make a copy of each highmem page, because we have no
good method of checking which of them are going to change after we have
created the snapshot image and before we save them.  Moreover, the copies are
made in the normal zone, because swsusp uses kernel virtual addresses to
enumerate the suspend image pages.  If the copies of the highmem pages were
made in the highmem zone, we'd have to use pfns to enumerate them and that
would require some substantial code changes.

> > The code that performs steps (5) and (11) of the suspend-resume cycle is
> > quite robust and there is only one known problem with it, which seems to
> > be x86_64-specific.  Namely, on x86_64 machines with more than 2 GB of RAM
> > there are memory gaps and/or reserved memory areas between the 2nd and 3rd
> > Gbyte of physical memory and swsusp tries to save these areas as though
> > they were RAM which leads to oopses.  This issue is now being worked on.
> 
> I guess we could just borrow a new struct page flags bit again and set it
> during memory setup. That would fix your problem I guess. Should be fairly
> easy to do. Let me know if you need it.

Actaully we already have the PG_nosave bit for this purpose and a patch that
fixes this is in the -mm tree now.  [I'm sorry you were not on the Cc list,
but one of the Andrew's machines was affected and he just picked up the
patch.]  I'm appeding it for reference (hope it's OK ;-) ).

Greetings,
Rafael


---
 arch/x86_64/kernel/e820.c  |   48 +++++++++++++++++++++++++++++++++++++++++++++
 arch/x86_64/kernel/setup.c |    1 
 include/asm-x86_64/e820.h  |    1 
 3 files changed, 50 insertions(+)

Index: linux-2.6.18-rc1-mm2/arch/x86_64/kernel/e820.c
===================================================================
--- linux-2.6.18-rc1-mm2.orig/arch/x86_64/kernel/e820.c
+++ linux-2.6.18-rc1-mm2/arch/x86_64/kernel/e820.c
@@ -16,6 +16,7 @@
 #include <linux/string.h>
 #include <linux/kexec.h>
 #include <linux/module.h>
+#include <linux/mm.h>
 
 #include <asm/pgtable.h>
 #include <asm/page.h>
@@ -293,6 +294,53 @@ void __init e820_reserve_resources(void)
 	}
 }
 
+/* Mark pages corresponding to given address range as nosave */
+static void __init
+e820_mark_nosave_range(unsigned long start, unsigned long end)
+{
+	unsigned long pfn, max_pfn;
+
+	if (start >= end)
+		return;
+
+	printk("Nosave address range: %016lx - %016lx\n", start, end);
+	max_pfn = end >> PAGE_SHIFT;
+	for (pfn = start >> PAGE_SHIFT; pfn < max_pfn; pfn++)
+		if (pfn_valid(pfn))
+			SetPageNosave(pfn_to_page(pfn));
+}
+
+/*
+ * Find the ranges of physical addresses that do not correspond to
+ * e820 RAM areas and mark the corresponding pages as nosave for software
+ * suspend and suspend to RAM.
+ *
+ * This function requires the e820 map to be sorted and without any
+ * overlapping entries and assumes the first e820 area to be RAM.
+ */
+void __init e820_mark_nosave_regions(void)
+{
+	int i;
+	unsigned long paddr;
+
+	paddr = round_down(e820.map[0].addr + e820.map[0].size, PAGE_SIZE);
+	for (i = 1; i < e820.nr_map; i++) {
+		struct e820entry *ei = &e820.map[i];
+
+		if (paddr < ei->addr)
+			e820_mark_nosave_range(paddr,
+					round_up(ei->addr, PAGE_SIZE));
+
+		paddr = round_down(ei->addr + ei->size, PAGE_SIZE);
+		if (ei->type != E820_RAM)
+			e820_mark_nosave_range(round_up(ei->addr, PAGE_SIZE),
+					paddr);
+
+		if (paddr >= (end_pfn << PAGE_SHIFT))
+			break;
+	}
+}
+
 /* 
  * Add a memory region to the kernel e820 map.
  */ 
Index: linux-2.6.18-rc1-mm2/arch/x86_64/kernel/setup.c
===================================================================
--- linux-2.6.18-rc1-mm2.orig/arch/x86_64/kernel/setup.c
+++ linux-2.6.18-rc1-mm2/arch/x86_64/kernel/setup.c
@@ -684,6 +684,7 @@ void __init setup_arch(char **cmdline_p)
 	 */
 	probe_roms();
 	e820_reserve_resources(); 
+	e820_mark_nosave_regions();
 
 	request_resource(&iomem_resource, &video_ram_resource);
 
Index: linux-2.6.18-rc1-mm2/include/asm-x86_64/e820.h
===================================================================
--- linux-2.6.18-rc1-mm2.orig/include/asm-x86_64/e820.h
+++ linux-2.6.18-rc1-mm2/include/asm-x86_64/e820.h
@@ -46,6 +46,7 @@ extern void setup_memory_region(void);
 extern void contig_e820_setup(void); 
 extern unsigned long e820_end_of_ram(void);
 extern void e820_reserve_resources(void);
+extern void e820_mark_nosave_regions(void);
 extern void e820_print_map(char *who);
 extern int e820_any_mapped(unsigned long start, unsigned long end, unsigned type);
 extern int e820_all_mapped(unsigned long start, unsigned long end, unsigned type);
