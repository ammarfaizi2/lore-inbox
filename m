Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268184AbUHQMMN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268184AbUHQMMN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 08:12:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268202AbUHQMLb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 08:11:31 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:42391 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S268188AbUHQMHe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 08:07:34 -0400
Date: Tue, 17 Aug 2004 17:37:17 +0530
From: Hariprasad Nellitheertha <hari@in.ibm.com>
To: linux-kernel@vger.kernel.org, fastboot@osdl.org
Cc: akpm@osdl.org, Suparna Bhattacharya <suparna@in.ibm.com>,
       mbligh@aracnet.com, litke@us.ibm.com, ebiederm@xmission.com
Subject: Re: [PATCH][2/6]Memory preserving reboot using kexec
Message-ID: <20040817120717.GC3916@in.ibm.com>
Reply-To: hari@in.ibm.com
References: <20040817120239.GA3916@in.ibm.com> <20040817120531.GB3916@in.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="1UWUbFP1cBYEclgG"
Content-Disposition: inline
In-Reply-To: <20040817120531.GB3916@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--1UWUbFP1cBYEclgG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Regards, Hari
-- 
Hariprasad Nellitheertha
Linux Technology Center
India Software Labs
IBM India, Bangalore

--1UWUbFP1cBYEclgG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="kd-reb-268.patch"



This patch contains the code that does the memory preserving reboot. It 
copies over the first CRASH_BACKUP_SIZE amount of memory into a backup
region before handing over to kexec.

Signed off by Hariprasad Nellitheertha <hari@in.ibm.com>
Signed off by Adam Litke <litke@us.ibm.com>


---

 linux-2.6.8.1-hari/arch/i386/Kconfig                |   22 +++++++++++
 linux-2.6.8.1-hari/arch/i386/kernel/machine_kexec.c |   31 +++++++++++++++
 linux-2.6.8.1-hari/arch/i386/kernel/setup.c         |   11 +++++
 linux-2.6.8.1-hari/include/asm-i386/crash_dump.h    |   39 ++++++++++++++++++++
 linux-2.6.8.1-hari/include/linux/bootmem.h          |    1 
 linux-2.6.8.1-hari/include/linux/crash_dump.h       |   27 +++++++++++++
 linux-2.6.8.1-hari/kernel/panic.c                   |    6 +++
 linux-2.6.8.1-hari/mm/bootmem.c                     |    5 ++
 8 files changed, 142 insertions(+)

diff -puN arch/i386/Kconfig~kd-reb-268 arch/i386/Kconfig
--- linux-2.6.8.1/arch/i386/Kconfig~kd-reb-268	2004-08-17 17:04:35.000000000 +0530
+++ linux-2.6.8.1-hari/arch/i386/Kconfig	2004-08-17 17:05:03.000000000 +0530
@@ -865,6 +865,28 @@ config REGPARM
 	generate incorrect output with certain kernel constructs when
 	-mregparm=3 is used.
 
+config CRASH_DUMP
+	bool "kernel crash dumps (EXPERIMENTAL)"
+	depends on KEXEC
+	help
+	  Generate crash dump using kexec.
+
+config BACKUP_BASE
+	int "location of the crash dumps backup region"
+	depends on CRASH_DUMP
+	default 128
+	help
+	Offset of backup region in terms of MB. Change this if you want
+	to modify the location of the crash dumps backup region.
+
+config BACKUP_SIZE
+	int "Size of the crash dumps backup region"
+	depends on CRASH_DUMP
+	range 16 64
+	default 16
+	help
+	The size of the backup region, in MB. This is also the size of the
+	memory that will be used to boot the second kernel after a crash.
 endmenu
 
 
diff -puN arch/i386/kernel/machine_kexec.c~kd-reb-268 arch/i386/kernel/machine_kexec.c
--- linux-2.6.8.1/arch/i386/kernel/machine_kexec.c~kd-reb-268	2004-08-17 17:04:35.000000000 +0530
+++ linux-2.6.8.1-hari/arch/i386/kernel/machine_kexec.c	2004-08-17 17:05:03.000000000 +0530
@@ -9,6 +9,7 @@
 #include <linux/mm.h>
 #include <linux/kexec.h>
 #include <linux/delay.h>
+#include <linux/crash_dump.h>
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
@@ -16,6 +17,7 @@
 #include <asm/io.h>
 #include <asm/apic.h>
 #include <asm/cpufeature.h>
+#include <asm/hw_irq.h>
 
 
 static void set_idt(void *newidt, __u16 limit)
@@ -76,6 +78,28 @@ const extern unsigned int relocate_new_k
 extern void use_mm(struct mm_struct *mm);
 
 /*
+ * We are going to do a memory preserving reboot. So, we copy over the
+ * first xxMB of memory into a backup location.
+ */
+void __relocate_base_mem(unsigned long backup_addr, unsigned long backup_size)
+{
+	unsigned long pfn, pfn_max;
+	void *src_addr, *dest_addr;
+	struct page *page;
+
+	pfn_max = backup_size >> PAGE_SHIFT;
+	for (pfn = 0; pfn < pfn_max; pfn++) {
+		src_addr = phys_to_virt(pfn << PAGE_SHIFT);
+		dest_addr = backup_addr + src_addr;
+		if (!pfn_valid(pfn))
+			continue;
+		page = pfn_to_page(pfn);
+		if (PageReserved(page))
+			copy_page(dest_addr, src_addr);
+	}
+}
+
+/*
  * Do not allocate memory (or fail in any way) in machine_kexec().
  * We are past the point of no return, committed to rebooting now.
  */
@@ -94,6 +118,13 @@ void machine_kexec(struct kimage *image)
 	reboot_code_buffer = page_to_pfn(image->reboot_code_pages) << PAGE_SHIFT;
 	indirection_page = image->head & PAGE_MASK;
 
+	/*
+	 * If we are here to do a crash dump, save the memory from
+	 * 0-16MB before we copy over the kexec kernel image.  Otherwise
+	 * our dump will show the wrong kernel entirely.
+	 */
+	relocate_base_mem();
+
 	/* copy it out */
 	memcpy((void *)reboot_code_buffer, relocate_new_kernel, relocate_new_kernel_size);
 
diff -puN arch/i386/kernel/setup.c~kd-reb-268 arch/i386/kernel/setup.c
--- linux-2.6.8.1/arch/i386/kernel/setup.c~kd-reb-268	2004-08-17 17:04:35.000000000 +0530
+++ linux-2.6.8.1-hari/arch/i386/kernel/setup.c	2004-08-17 17:05:03.000000000 +0530
@@ -39,6 +39,7 @@
 #include <linux/efi.h>
 #include <linux/init.h>
 #include <linux/edd.h>
+#include <linux/crash_dump.h>
 #include <video/edid.h>
 #include <asm/e820.h>
 #include <asm/mpspec.h>
@@ -56,6 +57,7 @@
 unsigned long init_pg_tables_end __initdata = ~0UL;
 
 int disable_pse __initdata = 0;
+unsigned int dump_enabled;
 
 /*
  * Machine setup..
@@ -347,6 +349,9 @@ static void __init limit_regions(unsigne
 			}
 		}
 	}
+	/* If we are doing a crash dump, we still need to know the real mem size*/
+	set_saved_max_pfn();
+
 	for (i = 0; i < e820.nr_map; i++) {
 		if (e820.map[i].type == E820_RAM) {
 			current_addr = e820.map[i].addr + e820.map[i].size;
@@ -809,6 +814,9 @@ static void __init parse_cmdline_early (
 		if (c == ' ' && !memcmp(from, "highmem=", 8))
 			highmem_pages = memparse(from+8, &from) >> PAGE_SHIFT;
 	
+		if (!memcmp(from, "dump", 4))
+			dump_enabled = 1;
+
 		c = *(from++);
 		if (!c)
 			break;
@@ -1082,6 +1090,9 @@ static unsigned long __init setup_memory
 		}
 	}
 #endif
+
+	crash_reserve_bootmem();
+
 	return max_low_pfn;
 }
 #else
diff -puN /dev/null include/asm-i386/crash_dump.h
--- /dev/null	2003-01-30 15:54:37.000000000 +0530
+++ linux-2.6.8.1-hari/include/asm-i386/crash_dump.h	2004-08-17 17:05:03.000000000 +0530
@@ -0,0 +1,39 @@
+/* asm-i386/crash_dump.h */
+#include <linux/bootmem.h>
+
+extern unsigned int dump_enabled;
+
+unsigned long __init find_max_low_pfn(void);
+void __init find_max_pfn(void);
+void __relocate_base_mem(unsigned long, unsigned long);
+
+extern unsigned int crashed;
+
+#ifdef CONFIG_CRASH_DUMP
+#define CRASH_BACKUP_BASE ((unsigned long)CONFIG_BACKUP_BASE * 0x100000)
+#define CRASH_BACKUP_SIZE ((unsigned long)CONFIG_BACKUP_SIZE * 0x100000)
+
+static inline void relocate_base_mem(void)
+{
+	if (crashed)
+		__relocate_base_mem(CRASH_BACKUP_BASE, CRASH_BACKUP_SIZE);
+}
+
+static inline void set_saved_max_pfn(void)
+{
+	find_max_pfn();
+	saved_max_pfn = find_max_low_pfn();
+}
+
+static inline void crash_reserve_bootmem(void)
+{
+	if (!dump_enabled)
+		reserve_bootmem(CRASH_BACKUP_BASE, CRASH_BACKUP_SIZE);
+}
+#else
+#define CRASH_BACKUP_BASE 0x08000000
+#define CRASH_BACKUP_SIZE 0x01000000
+static inline void relocate_base_mem(void) {}
+static inline void set_saved_max_pfn(void) {}
+static inline void crash_reserve_bootmem(void) {}
+#endif
diff -puN include/linux/bootmem.h~kd-reb-268 include/linux/bootmem.h
--- linux-2.6.8.1/include/linux/bootmem.h~kd-reb-268	2004-08-17 17:04:36.000000000 +0530
+++ linux-2.6.8.1-hari/include/linux/bootmem.h	2004-08-17 17:05:03.000000000 +0530
@@ -21,6 +21,7 @@ extern unsigned long min_low_pfn;
  * highest page
  */
 extern unsigned long max_pfn;
+extern unsigned long saved_max_pfn;
 
 /*
  * node_bootmem_map is a map pointer - the bits represent all physical 
diff -puN /dev/null include/linux/crash_dump.h
--- /dev/null	2003-01-30 15:54:37.000000000 +0530
+++ linux-2.6.8.1-hari/include/linux/crash_dump.h	2004-08-17 17:05:03.000000000 +0530
@@ -0,0 +1,27 @@
+#include <linux/kexec.h>
+#include <linux/smp_lock.h>
+#include <linux/device.h>
+#include <asm/crash_dump.h>
+
+#ifdef CONFIG_CRASH_DUMP
+static inline void crash_machine_kexec(void)
+{
+	struct kimage *image;
+
+	if (crashed)
+		return;
+
+        image = xchg(&kexec_image, 0);
+        if (image) {
+		crashed = 1;
+		device_shutdown();
+		printk(KERN_EMERG "kexec: opening parachute\n");
+		machine_kexec(image);
+		while (1);
+        } else {
+		printk(KERN_EMERG "kexec: No kernel image loaded!\n");
+        }
+}
+#else
+static inline void crash_machine_kexec(void) {}
+#endif
diff -puN kernel/panic.c~kd-reb-268 kernel/panic.c
--- linux-2.6.8.1/kernel/panic.c~kd-reb-268	2004-08-17 17:04:36.000000000 +0530
+++ linux-2.6.8.1-hari/kernel/panic.c	2004-08-17 17:05:03.000000000 +0530
@@ -19,10 +19,13 @@
 #include <linux/syscalls.h>
 #include <linux/interrupt.h>
 #include <linux/nmi.h>
+#include <linux/kexec.h>
+#include <linux/crash_dump.h>
 
 int panic_timeout;
 int panic_on_oops;
 int tainted;
+unsigned int crashed;
 
 EXPORT_SYMBOL(panic_timeout);
 
@@ -68,6 +71,9 @@ NORET_TYPE void panic(const char * fmt, 
 		sys_sync();
 	bust_spinlocks(0);
 
+	/* If we have crashed, perform a kexec reboot, for dump write-out */
+	crash_machine_kexec();
+
 #ifdef CONFIG_SMP
 	smp_send_stop();
 #endif
diff -puN mm/bootmem.c~kd-reb-268 mm/bootmem.c
--- linux-2.6.8.1/mm/bootmem.c~kd-reb-268	2004-08-17 17:04:36.000000000 +0530
+++ linux-2.6.8.1-hari/mm/bootmem.c	2004-08-17 17:05:03.000000000 +0530
@@ -27,6 +27,11 @@
 unsigned long max_low_pfn;
 unsigned long min_low_pfn;
 unsigned long max_pfn;
+/*
+ * If we have booted due to a crash, max_pfn will be a very low value. We need
+ * to know the amount of memory that the previous kernel used.
+ */
+unsigned long saved_max_pfn;
 
 EXPORT_SYMBOL(max_pfn);		/* This is exported so
 				 * dma_get_required_mask(), which uses

_

--1UWUbFP1cBYEclgG--
