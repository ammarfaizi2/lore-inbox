Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263818AbUIOM7e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263818AbUIOM7e (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 08:59:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266115AbUIOM6y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 08:58:54 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:12726 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263818AbUIOMxq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 08:53:46 -0400
Date: Wed, 15 Sep 2004 18:23:22 +0530
From: Hariprasad Nellitheertha <hari@in.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org, fastboot@osdl.org
Cc: Suparna Bhattacharya <suparna@in.ibm.com>, mbligh@aracnet.com,
       ebiederm@xmission.com, litke@us.ibm.com
Subject: Re: [PATCH][2/6]Memory preserving reboot using kexec
Message-ID: <20040915125322.GC15450@in.ibm.com>
Reply-To: hari@in.ibm.com
References: <20040915125041.GA15450@in.ibm.com> <20040915125145.GB15450@in.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="R3G7APHDIzY6R/pk"
Content-Disposition: inline
In-Reply-To: <20040915125145.GB15450@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--R3G7APHDIzY6R/pk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Regards, Hari
-- 
Hariprasad Nellitheertha
Linux Technology Center
India Software Labs
IBM India, Bangalore

--R3G7APHDIzY6R/pk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="kd-reb-269rc1-mm5.patch"



This patch contains the code that does the memory preserving reboot. It 
copies over the first 640k into a backup region before handing over to 
kexec. The second kernel will boot using only the backup region.

Signed off by Hariprasad Nellitheertha <hari@in.ibm.com>
Signed off by Adam Litke <litke@us.ibm.com>


---

 linux-2.6.9-rc1-hari/arch/i386/Kconfig                |   20 ++++++++
 linux-2.6.9-rc1-hari/arch/i386/kernel/machine_kexec.c |   31 ++++++++++++
 linux-2.6.9-rc1-hari/arch/i386/kernel/setup.c         |   13 +++++
 linux-2.6.9-rc1-hari/fs/proc/proc_misc.c              |   25 ++++++++++
 linux-2.6.9-rc1-hari/include/asm-i386/crash_dump.h    |   44 ++++++++++++++++++
 linux-2.6.9-rc1-hari/include/linux/bootmem.h          |    1 
 linux-2.6.9-rc1-hari/include/linux/crash_dump.h       |   28 +++++++++++
 linux-2.6.9-rc1-hari/kernel/panic.c                   |    7 ++
 linux-2.6.9-rc1-hari/mm/bootmem.c                     |    5 ++
 9 files changed, 174 insertions(+)

diff -puN arch/i386/Kconfig~kd-reb-269rc1-mm5 arch/i386/Kconfig
--- linux-2.6.9-rc1/arch/i386/Kconfig~kd-reb-269rc1-mm5	2004-09-15 17:36:30.000000000 +0530
+++ linux-2.6.9-rc1-hari/arch/i386/Kconfig	2004-09-15 17:36:30.000000000 +0530
@@ -894,6 +894,26 @@ config KEXEC
 	  support.  As of this writing the exact hardware interface is
 	  strongly in flux, so no good recommendation can be made.
 
+config CRASH_DUMP
+	bool "kernel crash dumps (EXPERIMENTAL)"
+	depends on KEXEC
+	help
+	  Generate crash dump using kexec.
+
+config BACKUP_BASE
+	int "location of the crash dumps backup region"
+	depends on CRASH_DUMP
+	default 16
+	help
+	This is the location where the second kernel will boot from.
+
+config BACKUP_SIZE
+	int "Size of the crash dumps backup region"
+	depends on CRASH_DUMP
+	range 16 64
+	default 32
+	help
+	The size of the second kernel's memory.
 endmenu
 
 
diff -puN arch/i386/kernel/setup.c~kd-reb-269rc1-mm5 arch/i386/kernel/setup.c
--- linux-2.6.9-rc1/arch/i386/kernel/setup.c~kd-reb-269rc1-mm5	2004-09-15 17:36:30.000000000 +0530
+++ linux-2.6.9-rc1-hari/arch/i386/kernel/setup.c	2004-09-15 17:36:30.000000000 +0530
@@ -39,6 +39,7 @@
 #include <linux/efi.h>
 #include <linux/init.h>
 #include <linux/edd.h>
+#include <linux/crash_dump.h>
 #include <video/edid.h>
 #include <asm/e820.h>
 #include <asm/mpspec.h>
@@ -57,6 +58,7 @@
 unsigned long init_pg_tables_end __initdata = ~0UL;
 
 int disable_pse __initdata = 0;
+unsigned int dump_enabled;
 
 /*
  * Machine setup..
@@ -708,6 +710,11 @@ static void __init parse_cmdline_early (
 			if (to != command_line)
 				to--;
 			if (!memcmp(from+7, "exactmap", 8)) {
+				/* If we are doing a crash dump, we
+				 * still need to know the real mem
+				 * size.
+				 */
+				set_saved_max_pfn();
 				from += 8+7;
 				e820.nr_map = 0;
 				userdef = 1;
@@ -815,6 +822,9 @@ static void __init parse_cmdline_early (
 		if (c == ' ' && !memcmp(from, "highmem=", 8))
 			highmem_pages = memparse(from+8, &from) >> PAGE_SHIFT;
 	
+		if (!memcmp(from, "dump", 4))
+			dump_enabled = 1;
+
 		c = *(from++);
 		if (!c)
 			break;
@@ -1102,6 +1112,9 @@ static unsigned long __init setup_memory
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
+++ linux-2.6.9-rc1-hari/include/asm-i386/crash_dump.h	2004-09-15 17:36:30.000000000 +0530
@@ -0,0 +1,44 @@
+/* asm-i386/crash_dump.h */
+#include <linux/bootmem.h>
+
+extern unsigned int dump_enabled;
+
+void __crash_relocate_mem(unsigned long, unsigned long);
+unsigned long __init find_max_low_pfn(void);
+void __init find_max_pfn(void);
+
+extern unsigned int crashed;
+
+#ifdef CONFIG_CRASH_DUMP
+#define CRASH_BACKUP_BASE ((unsigned long)CONFIG_BACKUP_BASE * 0x100000)
+#define CRASH_BACKUP_SIZE ((unsigned long)CONFIG_BACKUP_SIZE * 0x100000)
+#define CRASH_RELOCATE_SIZE 0xa0000
+
+static inline void crash_relocate_mem(void)
+{
+	if (crashed)
+		__crash_relocate_mem(CRASH_BACKUP_BASE + CRASH_BACKUP_SIZE,
+					CRASH_RELOCATE_SIZE);
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
+	if (!dump_enabled) {
+		reserve_bootmem(0, CRASH_RELOCATE_SIZE);
+		reserve_bootmem(CRASH_BACKUP_BASE,
+			CRASH_BACKUP_SIZE + CRASH_RELOCATE_SIZE);
+	}
+}
+#else
+#define CRASH_BACKUP_BASE 0x6000000
+#define CRASH_BACKUP_SIZE 0x1000000
+#define crash_relocate_mem() do { } while(0)
+#define set_saved_max_pfn() do { } while(0)
+#define crash_reserve_bootmem() do { } while(0)
+#endif
diff -puN include/linux/bootmem.h~kd-reb-269rc1-mm5 include/linux/bootmem.h
--- linux-2.6.9-rc1/include/linux/bootmem.h~kd-reb-269rc1-mm5	2004-09-15 17:36:30.000000000 +0530
+++ linux-2.6.9-rc1-hari/include/linux/bootmem.h	2004-09-15 17:36:30.000000000 +0530
@@ -21,6 +21,7 @@ extern unsigned long min_low_pfn;
  * highest page
  */
 extern unsigned long max_pfn;
+extern unsigned long saved_max_pfn;
 
 /*
  * node_bootmem_map is a map pointer - the bits represent all physical 
diff -puN /dev/null include/linux/crash_dump.h
--- /dev/null	2003-01-30 15:54:37.000000000 +0530
+++ linux-2.6.9-rc1-hari/include/linux/crash_dump.h	2004-09-15 17:36:30.000000000 +0530
@@ -0,0 +1,28 @@
+#include <linux/kexec.h>
+#include <linux/smp_lock.h>
+#include <linux/device.h>
+#include <asm/crash_dump.h>
+
+#ifdef CONFIG_CRASH_DUMP
+extern int crash_dump_on;
+static inline void crash_machine_kexec(void)
+{
+	struct kimage *image;
+
+	if ((!crash_dump_on) || (crashed))
+		return;
+
+	image = xchg(&kexec_image, 0);
+	if (image) {
+		crashed = 1;
+		device_shutdown();
+		printk(KERN_EMERG "kexec: opening parachute\n");
+		machine_kexec(image);
+		while (1);
+	} else {
+		printk(KERN_EMERG "kexec: No kernel image loaded!\n");
+	}
+}
+#else
+#define crash_machine_kexec()	do { } while(0)
+#endif
diff -puN kernel/panic.c~kd-reb-269rc1-mm5 kernel/panic.c
--- linux-2.6.9-rc1/kernel/panic.c~kd-reb-269rc1-mm5	2004-09-15 17:36:30.000000000 +0530
+++ linux-2.6.9-rc1-hari/kernel/panic.c	2004-09-15 17:36:30.000000000 +0530
@@ -19,10 +19,14 @@
 #include <linux/syscalls.h>
 #include <linux/interrupt.h>
 #include <linux/nmi.h>
+#include <linux/kexec.h>
+#include <linux/crash_dump.h>
 
 int panic_timeout;
 int panic_on_oops;
 int tainted;
+unsigned int crashed;
+int crash_dump_on;
 
 EXPORT_SYMBOL(panic_timeout);
 
@@ -62,6 +66,9 @@ NORET_TYPE void panic(const char * fmt, 
 	printk(KERN_EMERG "Kernel panic - not syncing: %s\n",buf);
 	bust_spinlocks(0);
 
+	/* If we have crashed, perform a kexec reboot, for dump write-out */
+	crash_machine_kexec();
+
 #ifdef CONFIG_SMP
 	smp_send_stop();
 #endif
diff -puN mm/bootmem.c~kd-reb-269rc1-mm5 mm/bootmem.c
--- linux-2.6.9-rc1/mm/bootmem.c~kd-reb-269rc1-mm5	2004-09-15 17:36:30.000000000 +0530
+++ linux-2.6.9-rc1-hari/mm/bootmem.c	2004-09-15 17:36:30.000000000 +0530
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
diff -puN fs/proc/proc_misc.c~kd-reb-269rc1-mm5 fs/proc/proc_misc.c
--- linux-2.6.9-rc1/fs/proc/proc_misc.c~kd-reb-269rc1-mm5	2004-09-15 17:36:30.000000000 +0530
+++ linux-2.6.9-rc1-hari/fs/proc/proc_misc.c	2004-09-15 17:36:30.000000000 +0530
@@ -44,6 +44,7 @@
 #include <linux/jiffies.h>
 #include <linux/sysrq.h>
 #include <linux/vmalloc.h>
+#include <linux/crash_dump.h>
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
 #include <asm/io.h>
@@ -563,6 +564,25 @@ static struct file_operations proc_sysrq
 };
 #endif
 
+#ifdef CONFIG_CRASH_DUMP
+/*
+ * Enable kexec reboot upon panic; for dumping
+ */
+static ssize_t write_crash_dump_on(struct file *file, const char __user *buf,
+					size_t count, loff_t *ppos)
+{
+	if (count) {
+		if (get_user(crash_dump_on, buf))
+			return -EFAULT;
+	}
+	return count;
+}
+
+static struct file_operations proc_crash_dump_on_operations = {
+	.write		= write_crash_dump_on,
+};
+#endif
+
 struct proc_dir_entry *proc_root_kcore;
 
 static void create_seq_entry(char *name, mode_t mode, struct file_operations *f)
@@ -663,6 +683,11 @@ void __init proc_misc_init(void)
 	if (entry)
 		entry->proc_fops = &proc_sysrq_trigger_operations;
 #endif
+#ifdef CONFIG_CRASH_DUMP
+	entry = create_proc_entry("kexec-dump", S_IWUSR, NULL);
+	if (entry)
+		entry->proc_fops = &proc_crash_dump_on_operations;
+#endif
 #ifdef CONFIG_LOCKMETER
 	entry = create_proc_entry("lockmeter", S_IWUSR | S_IRUGO, NULL);
 	if (entry) {
diff -puN arch/i386/kernel/machine_kexec.c~kd-reb-269rc1-mm5 arch/i386/kernel/machine_kexec.c
--- linux-2.6.9-rc1/arch/i386/kernel/machine_kexec.c~kd-reb-269rc1-mm5	2004-09-15 17:36:30.000000000 +0530
+++ linux-2.6.9-rc1-hari/arch/i386/kernel/machine_kexec.c	2004-09-15 17:36:30.000000000 +0530
@@ -161,6 +161,30 @@ void machine_kexec_cleanup(struct kimage
 }
 
 /*
+ * We are going to do a memory preserving reboot. So, we copy over the
+ * first 640k of memory into a backup location. Though the second kernel
+ * boots from a different location, it still requires the first 640k.
+ * Hence this backup.
+ */
+void __crash_relocate_mem(unsigned long backup_addr, unsigned long backup_size)
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
@@ -180,6 +204,13 @@ void machine_kexec(struct kimage *image)
 	/* Set up an identity mapping for the reboot_code_buffer */
 	identity_map_page(reboot_code_buffer);
 
+	/*
+	 * If we are here to do a crash dump, save the memory from
+	 * 0-640k before we copy over the kexec kernel image.  Otherwise
+	 * our dump will show the wrong kernel entirely.
+	 */
+	crash_relocate_mem();
+
 	/* copy it out */
 	memcpy((void *)reboot_code_buffer, relocate_new_kernel, relocate_new_kernel_size);
 

_

--R3G7APHDIzY6R/pk--
