Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751529AbWGPIzd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751529AbWGPIzd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jul 2006 04:55:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750710AbWGPIzd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jul 2006 04:55:33 -0400
Received: from 83-64-96-243.bad-voeslau.xdsl-line.inode.at ([83.64.96.243]:33416
	"EHLO mognix.dark-green.com") by vger.kernel.org with ESMTP
	id S964856AbWGPIzc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jul 2006 04:55:32 -0400
Message-ID: <44B9FF02.3020600@ed-soft.at>
Date: Sun, 16 Jul 2006 10:55:30 +0200
From: Edgar Hucek <hostmaster@ed-soft.at>
User-Agent: Thunderbird 1.5.0.4 (X11/20060615)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: "Eric W. Biederman" <ebiederm@xmission.com>,
       "H. Peter Anvin" <hpa@zytor.com>, LKML <linux-kernel@vger.kernel.org>,
       akpm@osdl.org
Subject: [PATCH 1/1] Add efi e820 memory mapping on x86 [try #1]
References: <44A04F5F.8030405@ed-soft.at> <Pine.LNX.4.64.0606261430430.3927@g5.osdl.org> <44A0CCEA.7030309@ed-soft.at> <Pine.LNX.4.64.0606262318341.3927@g5.osdl.org> <44A304C1.2050304@zytor.com> <m1ac7r9a9n.fsf@ebiederm.dsl.xmission.com> <44A8058D.3030905@zytor.com> <m11wt3983j.fsf@ebiederm.dsl.xmission.com> <44AB8878.7010203@ed-soft.at> <m1lkr83v73.fsf@ebiederm.dsl.xmission.com> <44B6BF2F.6030401@ed-soft.at> <Pine.LNX.4.64.0607131507220.5623@g5.osdl.org> <44B73791.9080601@ed-soft.at> <Pine.LNX.4.64.0607140901200.5623@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0607140901200.5623@g5.osdl.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This Patch add an efi e820 memory mapping.

Signed-off-by: Edgar Hucek <hostmaster@ed-soft.at>


diff -uNr linux-2.6.18-rc2/arch/i386/kernel/setup.c
linux-2.6.18-rc2.mactel/arch/i386/kernel/setup.c
--- linux-2.6.18-rc2/arch/i386/kernel/setup.c    2006-07-16
10:38:10.000000000 +0200
+++ linux-2.6.18-rc2.mactel/arch/i386/kernel/setup.c    2006-07-16
10:16:12.000000000 +0200
@@ -414,19 +414,17 @@
 {
     int x;
 
-    if (!efi_enabled) {
-               x = e820.nr_map;
+    x = e820.nr_map;
 
-        if (x == E820MAX) {
-            printk(KERN_ERR "Ooops! Too many entries in the memory
map!\n");
-            return;
-        }
-
-        e820.map[x].addr = start;
-        e820.map[x].size = size;
-        e820.map[x].type = type;
-        e820.nr_map++;
+    if (x == E820MAX) {
+        printk(KERN_ERR "Ooops! Too many entries in the memory map!\n");
+        return;
     }
+
+    e820.map[x].addr = start;
+    e820.map[x].size = size;
+    e820.map[x].type = type;
+    e820.nr_map++;
 } /* add_memory_region */
 
 #define E820_DEBUG    1
@@ -1431,6 +1429,59 @@
 #endif
 
 /*
+ * Make a e820 memory map
+ */
+void __init efi_init_e820_map(void)
+{
+    efi_memory_desc_t *md;
+    unsigned long long start = 0;
+    unsigned long long end = 0;
+    unsigned long long size = 0;
+    void *p;
+
+    e820.nr_map = 0;
+
+    for (p = memmap.map; p < memmap.map_end;
+        p += memmap.desc_size) {
+        md = p;
+        switch (md->type) {
+        case EFI_ACPI_RECLAIM_MEMORY:
+            add_memory_region(md->phys_addr, md->num_pages <<
EFI_PAGE_SHIFT, E820_ACPI);
+            break;
+        case EFI_RUNTIME_SERVICES_CODE:
+        case EFI_RUNTIME_SERVICES_DATA:
+        case EFI_RESERVED_TYPE:
+        case EFI_MEMORY_MAPPED_IO:
+        case EFI_MEMORY_MAPPED_IO_PORT_SPACE:
+        case EFI_UNUSABLE_MEMORY:
+            add_memory_region(md->phys_addr, md->num_pages <<
EFI_PAGE_SHIFT, E820_RESERVED);
+            break;
+        case EFI_LOADER_CODE:
+        case EFI_LOADER_DATA:
+        case EFI_BOOT_SERVICES_CODE:
+        case EFI_BOOT_SERVICES_DATA:
+        case EFI_CONVENTIONAL_MEMORY:
+            start = md->phys_addr;
+            size = md->num_pages << EFI_PAGE_SHIFT;
+            end = start + size;
+            if (start < 0x100000ULL && end > 0xA0000ULL) {
+                if (start < 0xA0000ULL)
+                    add_memory_region(start, 0xA0000ULL-start, E820_RAM);
+                if (end <= 0x100000ULL)
+                    continue;
+                start = 0x100000ULL;
+                size = end - start;
+            }
+            add_memory_region(start, size, E820_RAM);
+            break;
+        case EFI_ACPI_MEMORY_NVS:
+            add_memory_region(md->phys_addr, md->num_pages <<
EFI_PAGE_SHIFT, E820_NVS);
+            break;
+        }
+    }
+}
+
+/*
  * Determine if we were loaded by an EFI loader.  If so, then we have
also been
  * passed the efi memmap, systab, etc., so we should use these data
structures
  * for initialization.  Note, the efi init code path is determined by the
@@ -1478,9 +1529,11 @@
     rd_doload = ((RAMDISK_FLAGS & RAMDISK_LOAD_FLAG) != 0);
 #endif
     ARCH_SETUP
-    if (efi_enabled)
+    if (efi_enabled) {
         efi_init();
-    else {
+        efi_init_e820_map();
+        print_memory_map("BIOS-EFI");
+    } else {
         printk(KERN_INFO "BIOS-provided physical RAM map:\n");
         print_memory_map(machine_specific_memory_setup());
     }

