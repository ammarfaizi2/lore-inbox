Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261712AbVBTR4F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261712AbVBTR4F (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Feb 2005 12:56:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261724AbVBTR4E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Feb 2005 12:56:04 -0500
Received: from fire.osdl.org ([65.172.181.4]:18380 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261712AbVBTRzy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Feb 2005 12:55:54 -0500
Date: Sun, 20 Feb 2005 09:56:01 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: Steven Rostedt <rostedt@goodmis.org>, LKML <linux-kernel@vger.kernel.org>,
       Greg KH <gregkh@suse.de>
Subject: Re: IBM Thinkpad G41 PCMCIA problems [Was: Yenta TI: ... no PCI
 interrupts. Fish. Please report.]
In-Reply-To: <Pine.LNX.4.58.0502200905060.2378@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.58.0502200954350.2378@ppc970.osdl.org>
References: <1108858971.8413.147.camel@localhost.localdomain>
 <Pine.LNX.4.58.0502191648110.14176@ppc970.osdl.org>
 <1108863372.8413.158.camel@localhost.localdomain> <20050220082226.A7093@flint.arm.linux.org.uk>
 <Pine.LNX.4.58.0502200905060.2378@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 20 Feb 2005, Linus Torvalds wrote:
> 
> But the PCI allocations are not at all limited by MAXMEM - they want to be 
> in the low 4GB, but that's the only real limit. So using "max_low_pfn" to 
> determine where to start PCI allocations is pretty bogus.
> 
> I'll try to write something that actually looks at the e820 memory map 
> properly.

Russell, what do your eagle-eyes think of a patch like this?

Steven, does this fix it without the need for any kernel command line (or
any other patches, for that matter - ie revert all the transparency-
changing ones)?

		Linus

----
# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2005/02/20 09:43:19-08:00 torvalds@ppc970.osdl.org 
#   Use e820 memory map to determine PCI allocation area.
#   
#   Don't use the VM numbers (max_low_pfn and friends), since they depend
#   on the partial kernel linear mapping and only partially on the actual
#   physical memory layout.
# 
# arch/i386/kernel/setup.c
#   2005/02/20 09:43:12-08:00 torvalds@ppc970.osdl.org +19 -6
#   Use e820 memory map to determine PCI allocation area.
#   
#   Don't use the VM numbers (max_low_pfn and friends), since they depend
#   on the partial kernel linear mapping and only partially on the actual
#   physical memory layout.
# 
diff -Nru a/arch/i386/kernel/setup.c b/arch/i386/kernel/setup.c
--- a/arch/i386/kernel/setup.c	2005-02-20 09:54:35 -08:00
+++ b/arch/i386/kernel/setup.c	2005-02-20 09:54:35 -08:00
@@ -1166,9 +1166,10 @@
 /*
  * Request address space for all standard resources
  */
-static void __init register_memory(unsigned long max_low_pfn)
+static void __init register_memory(void)
 {
-	unsigned long low_mem_size;
+	long long gapsize;
+	unsigned long long last;
 	int	      i;
 
 	if (efi_enabled)
@@ -1184,9 +1185,21 @@
 		request_resource(&ioport_resource, &standard_io_resources[i]);
 
 	/* Tell the PCI layer not to allocate too close to the RAM area.. */
-	low_mem_size = ((max_low_pfn << PAGE_SHIFT) + 0xfffff) & ~0xfffff;
-	if (low_mem_size > pci_mem_start)
-		pci_mem_start = low_mem_size;
+	last = 0x100000000ull;
+	gapsize = 0x400000;
+	i = e820.nr_map;
+	while (--i >= 0) {
+		unsigned long long start = e820.map[i].addr;
+		unsigned long long end = start + e820.map[i].size;
+		long long gap = last - end;
+
+		if (gap > gapsize) {
+			gapsize = gap;
+			pci_mem_start = ((unsigned long) end + 0xfffff) & ~0xfffff;
+		}
+		last = start;
+	}
+	printk("Allocating PCI resources starting at %08lx\n", pci_mem_start);
 }
 
 /* Use inline assembly to define this because the nops are defined 
@@ -1432,7 +1445,7 @@
 		get_smp_config();
 #endif
 
-	register_memory(max_low_pfn);
+	register_memory();
 
 #ifdef CONFIG_VT
 #if defined(CONFIG_VGA_CONSOLE)
