Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752685AbWKBWZv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752685AbWKBWZv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 17:25:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752701AbWKBWZv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 17:25:51 -0500
Received: from usea-naimss2.unisys.com ([192.61.61.104]:10761 "EHLO
	usea-naimss2.unisys.com") by vger.kernel.org with ESMTP
	id S1752685AbWKBWZu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 17:25:50 -0500
Subject: [RFC] [PATCH 2.6.19-rc4] kdump panics early in boot when reserving
	MP Tables located in high memory
From: Amul Shah <amul.shah@unisys.com>
To: LKML <linux-kernel@vger.kernel.org>, fastboot <fastboot@lists.osdl.org>,
       Andi Kleen <ak@suse.de>
Content-Type: text/plain
Date: Thu, 02 Nov 2006 17:24:32 -0500
Message-Id: <1162506272.19677.33.camel@ustr-linux-shaha1.unisys.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 Nov 2006 22:25:30.0389 (UTC) FILETIME=[CDF6C450:01C6FECD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The kdump crash kernel panics when it tries to reserve the MP Config
tables on an ES7000.

The MP Config table is located above 1MB of physical memory in a
reserved memory area.  It is located outside the first 1MB area because
the tables are too large, 240k.

The crash kernel is given a user defined memory map with E820 reserved
and ACPI areas passed in by kexec tools and a usable area from 16MB
physical to 80MB physical.  This user defined map causes the top of
memory to be set as 80MB.

The ACPI tables and MP Tables reside higher in memory.  When reserving
memory with reserve_bootmem_generic, the function has a BUG panic if the
memory location to reserve is above the top of memory.  The MP table is
above the top of memory in a user defined memory map.

This patch will ignore reserving the MP tables if the MP table resides
in an area already reserved in the E820.

I have two alternate patches that accomplish the same effect if this
patch is not acceptable.
1. avoid reserving the MP tables if a user defined memory map or if a
user defined memory limit ("mem=") is used.
2. avoid reserving the MP tables if a kernel parameter is passed in to
ignore MP table reservation.


diff -Naur linux-2.6.19-rc4/arch/x86_64/kernel/e820.c linux-2.6.19-rc4-az/arch/x86_64/kernel/e820.c
--- linux-2.6.19-rc4/arch/x86_64/kernel/e820.c	2006-10-31 17:38:41.000000000 -0500
+++ linux-2.6.19-rc4-az/arch/x86_64/kernel/e820.c	2006-11-02 17:56:01.000000000 -0500
@@ -351,6 +351,53 @@
 	}
 }
 
+int __init e820_reserved(unsigned long target_phys)
+{
+	int i;
+	unsigned long section_begin_phys, section_end_phys;
+
+	for (i = 0; i < e820.nr_map; i++) {
+		// if it is usable memory, ignore it
+		if (e820.map[i].type == E820_RAM )
+			continue;
+
+		section_begin_phys = e820.map[i].addr;
+		section_end_phys = e820.map[i].addr + e820.map[i].size;
+
+		// if its NOT within the memory range, ignore it
+		if (!(section_begin_phys < target_phys &&
+		      target_phys < section_end_phys))
+			continue;
+
+		printk(KERN_DEBUG "MP Tables at %lx in %016lx - %016lx",
+		       target_phys, section_begin_phys, section_end_phys);
+		
+		switch (e820.map[i].type) {
+		case E820_RESERVED:
+			printk(KERN_DEBUG "(reserved)\n");
+			break;
+		case E820_ACPI:
+			printk(KERN_DEBUG "(ACPI data)\n");
+			printk(KERN_DEBUG "WARNING: MP Tables located in");
+			printk(KERN_DEBUG "ACPI Data Area\n");
+			break;
+		case E820_NVS:
+			printk(KERN_DEBUG "(ACPI NVS)\n");
+			printk(KERN_DEBUG "WARNING: MP Tables located in");
+			printk(KERN_DEBUG "ACPI NVS Area\n");
+			break;
+		default:	
+			printk(KERN_DEBUG "(type %u)\n", e820.map[i].type);
+			printk(KERN_ERR "WARNING: MP Tables located in");
+			printk(KERN_ERR "Unkown Memory Area!\n");
+			printk(KERN_ERR "Reservations are disallowed.\n");
+			return 0;
+		}
+		return 1;
+	}
+	return 0;
+}
+
 /*
  * Sanitize the BIOS e820 map.
  *
diff -Naur linux-2.6.19-rc4/arch/x86_64/kernel/mpparse.c linux-2.6.19-rc4-az/arch/x86_64/kernel/mpparse.c
--- linux-2.6.19-rc4/arch/x86_64/kernel/mpparse.c	2006-10-31 17:38:41.000000000 -0500
+++ linux-2.6.19-rc4-az/arch/x86_64/kernel/mpparse.c	2006-11-02 17:25:10.000000000 -0500
@@ -23,6 +23,7 @@
 #include <linux/acpi.h>
 #include <linux/module.h>
 
+#include <asm/e820.h>
 #include <asm/smp.h>
 #include <asm/mtrr.h>
 #include <asm/mpspec.h>
@@ -543,7 +544,7 @@
 
 			smp_found_config = 1;
 			reserve_bootmem_generic(virt_to_phys(mpf), PAGE_SIZE);
-			if (mpf->mpf_physptr)
+			if (mpf->mpf_physptr && e820_reserved(mpf->mpf_physptr))
 				reserve_bootmem_generic(mpf->mpf_physptr, PAGE_SIZE);
 			mpf_found = mpf;
 			return 1;
diff -Naur linux-2.6.19-rc4/include/asm-x86_64/e820.h linux-2.6.19-rc4-az/include/asm-x86_64/e820.h
--- linux-2.6.19-rc4/include/asm-x86_64/e820.h	2006-10-31 17:39:24.000000000 -0500
+++ linux-2.6.19-rc4-az/include/asm-x86_64/e820.h	2006-11-02 17:25:10.000000000 -0500
@@ -44,6 +44,7 @@
 extern void e820_reserve_resources(void);
 extern void e820_mark_nosave_regions(void);
 extern void e820_print_map(char *who);
+extern int e820_reserved(unsigned long target_phys);
 extern int e820_any_mapped(unsigned long start, unsigned long end, unsigned type);
 extern int e820_all_mapped(unsigned long start, unsigned long end, unsigned type);
 


