Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263980AbUDVMGi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263980AbUDVMGi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 08:06:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263984AbUDVMGh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 08:06:37 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:39176 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S263980AbUDVMEr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 08:04:47 -0400
Date: Thu, 22 Apr 2004 22:04:17 +1000
To: Pavel Machek <pavel@suse.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: SOFTWARE_SUSPEND as a module
Message-ID: <20040422120417.GA2835@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi:

This is a quick hack to modularise SOFTWARE_SUSPEND.  I've successfully
suspended to/resumed from LVM using this.

Please ignore my changes in kernel/sys.c and drivers/acpi/sleep/proc.c.
They should be replaced by the way that pmdisk hooks into the kernel.

Cheers,
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=p

Index: arch/i386/power/Makefile
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.5/arch/i386/power/Makefile,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 Makefile
--- a/arch/i386/power/Makefile	28 Sep 2003 04:44:10 -0000	1.1.1.1
+++ b/arch/i386/power/Makefile	22 Apr 2004 11:32:00 -0000
@@ -1,3 +1,8 @@
+swsusp-arch-y			+= swsusp_syms.o swsusp.o
+
 obj-$(CONFIG_PM)		+= cpu.o
 obj-$(CONFIG_PM_DISK)		+= pmdisk.o
-obj-$(CONFIG_SOFTWARE_SUSPEND)	+= swsusp.o
+
+ifneq ($(CONFIG_SOFTWARE_SUSPEND),)
+obj-y				+= swsusp-arch.o
+endif
Index: arch/i386/power/swsusp_syms.c
===================================================================
RCS file: arch/i386/power/swsusp_syms.c
diff -N arch/i386/power/swsusp_syms.c
--- /dev/null	1 Jan 1970 00:00:00 -0000
+++ b/arch/i386/power/swsusp_syms.c	22 Apr 2004 11:31:23 -0000
@@ -0,0 +1,12 @@
+/*
+ * Architecture-specific support for software suspend.
+ *
+ * Copyright (c) 2004 Herbert Xu <herbert@debian.org>
+ *
+ * This file is licensed under the GPLv2.
+ */
+
+#include <linux/module.h>
+#include <linux/suspend.h>
+
+EXPORT_SYMBOL(do_magic);
Index: arch/x86_64/kernel/Makefile
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.5/arch/x86_64/kernel/Makefile,v
retrieving revision 1.1.1.15
diff -u -r1.1.1.15 Makefile
--- a/arch/x86_64/kernel/Makefile	5 Apr 2004 09:49:25 -0000	1.1.1.15
+++ b/arch/x86_64/kernel/Makefile	22 Apr 2004 11:37:52 -0000
@@ -19,7 +19,9 @@
 obj-$(CONFIG_X86_LOCAL_APIC)	+= apic.o  nmi.o
 obj-$(CONFIG_X86_IO_APIC)	+= io_apic.o mpparse.o
 obj-$(CONFIG_PM)		+= suspend.o
-obj-$(CONFIG_SOFTWARE_SUSPEND)	+= suspend_asm.o
+ifneq ($(CONFIG_SOFTWARE_SUSPEND),)
+obj-y				+= swsusp-arch.o
+endif
 obj-$(CONFIG_CPU_FREQ)		+= cpufreq/
 obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
 obj-$(CONFIG_GART_IOMMU)	+= pci-gart.o aperture.o
@@ -35,3 +37,4 @@
 topology-y                     += ../../i386/mach-default/topology.o
 swiotlb-$(CONFIG_SWIOTLB)      += ../../ia64/lib/swiotlb.o
 microcode-$(subst m,y,$(CONFIG_MICROCODE))  += ../../i386/kernel/microcode.o
+swsusp-arch-y			+= swsusp_syms.o suspend_asm.o
Index: arch/x86_64/kernel/swsusp_syms.c
===================================================================
RCS file: arch/x86_64/kernel/swsusp_syms.c
diff -N arch/x86_64/kernel/swsusp_syms.c
--- /dev/null	1 Jan 1970 00:00:00 -0000
+++ b/arch/x86_64/kernel/swsusp_syms.c	22 Apr 2004 11:37:24 -0000
@@ -0,0 +1,12 @@
+/*
+ * Architecture-specific support for software suspend.
+ *
+ * Copyright (c) 2004 Herbert Xu <herbert@debian.org>
+ *
+ * This file is licensed under the GPLv2.
+ */
+
+#include <linux/module.h>
+#include <linux/suspend.h>
+
+EXPORT_SYMBOL(do_magic);
Index: drivers/acpi/sleep/proc.c
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.5/drivers/acpi/sleep/proc.c,v
retrieving revision 1.1.1.7
diff -u -r1.1.1.7 proc.c
--- a/drivers/acpi/sleep/proc.c	5 Apr 2004 09:49:25 -0000	1.1.1.7
+++ b/drivers/acpi/sleep/proc.c	20 Apr 2004 08:29:00 -0000
@@ -2,6 +2,7 @@
 #include <linux/seq_file.h>
 #include <linux/suspend.h>
 #include <linux/bcd.h>
+#include <linux/module.h>
 #include <asm/uaccess.h>
 
 #include <acpi/acpi_bus.h>
@@ -67,12 +68,17 @@
 		goto Done;
 	}
 	state = simple_strtoul(str, NULL, 0);
-#ifdef CONFIG_SOFTWARE_SUSPEND
 	if (state == 4) {
-		software_suspend();
-		goto Done;
+		down(&software_suspend_sem);
+		if (software_suspend_module &&
+		    try_module_get(software_suspend_module)) {
+			up(&software_suspend_sem);
+			software_suspend_hook();
+			module_put(software_suspend_module);
+			goto Done;
+		}
+		up(&software_suspend_sem);
 	}
-#endif
 	error = acpi_suspend(state);
  Done:
 	return error ? error : count;
Index: fs/buffer.c
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.5/fs/buffer.c,v
retrieving revision 1.7
diff -u -r1.7 buffer.c
--- a/fs/buffer.c	5 Apr 2004 10:54:47 -0000	1.7
+++ b/fs/buffer.c	20 Apr 2004 12:58:51 -0000
@@ -282,6 +282,8 @@
 	return 0;
 }
 
+EXPORT_SYMBOL(sys_sync);
+
 void emergency_sync(void)
 {
 	pdflush_operation(do_sync, 0);
Index: include/linux/suspend.h
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.5/include/linux/suspend.h,v
retrieving revision 1.1.1.10
diff -u -r1.1.1.10 suspend.h
--- a/include/linux/suspend.h	11 Mar 2004 02:55:24 -0000	1.1.1.10
+++ b/include/linux/suspend.h	20 Apr 2004 08:15:43 -0000
@@ -4,6 +4,7 @@
 #ifdef CONFIG_X86
 #include <asm/suspend.h>
 #endif
+#include <asm/semaphore.h>
 #include <linux/swap.h>
 #include <linux/notifier.h>
 #include <linux/config.h>
@@ -42,23 +43,10 @@
 /* mm/page_alloc.c */
 extern void drain_local_pages(void);
 
-/* kernel/power/swsusp.c */
-extern int software_suspend(void);
-
 extern unsigned int nr_copy_pages __nosavedata;
 extern suspend_pagedir_t *pagedir_nosave __nosavedata;
 
-#else	/* CONFIG_SOFTWARE_SUSPEND */
-static inline int software_suspend(void)
-{
-	printk("Warning: fake suspend called\n");
-	return -EPERM;
-}
-#define software_resume()		do { } while(0)
-#endif	/* CONFIG_SOFTWARE_SUSPEND */
-
 
-#ifdef CONFIG_PM
 extern void refrigerator(unsigned long);
 extern int freeze_processes(void);
 extern void thaw_processes(void);
@@ -87,4 +75,9 @@
 asmlinkage void do_magic_suspend_1(void);
 asmlinkage void do_magic_suspend_2(void);
 
+struct module;
+extern struct module *software_suspend_module;
+extern int (*software_suspend_hook)(void);
+extern struct semaphore software_suspend_sem;
+
 #endif /* _LINUX_SWSUSP_H */
Index: kernel/sys.c
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.5/kernel/sys.c,v
retrieving revision 1.7
diff -u -r1.7 sys.c
--- a/kernel/sys.c	12 Mar 2004 11:03:09 -0000	1.7
+++ b/kernel/sys.c	22 Apr 2004 11:42:11 -0000
@@ -27,6 +27,7 @@
 #include <asm/uaccess.h>
 #include <asm/io.h>
 #include <asm/unistd.h>
+#include <asm/semaphore.h>
 
 #ifndef SET_UNALIGN_CTL
 # define SET_UNALIGN_CTL(a,b)	(-EINVAL)
@@ -408,6 +409,14 @@
 }
 
 
+struct module *software_suspend_module;
+int (*software_suspend_hook)(void);
+DECLARE_MUTEX(software_suspend_sem);
+
+EXPORT_SYMBOL(software_suspend_module);
+EXPORT_SYMBOL(software_suspend_hook);
+EXPORT_SYMBOL(software_suspend_sem);
+
 /*
  * Reboot system call: for obvious reasons only root may call it,
  * and even root needs to set up some magic numbers in the registers
@@ -484,14 +493,20 @@
 		machine_restart(buffer);
 		break;
 
-#ifdef CONFIG_SOFTWARE_SUSPEND
 	case LINUX_REBOOT_CMD_SW_SUSPEND:
-		{
-			int ret = software_suspend();
+		down(&software_suspend_sem);
+		if (software_suspend_module &&
+		    try_module_get(software_suspend_module)) {
+			int ret;
+
+			up(&software_suspend_sem);
+			ret = software_suspend_hook();
+			module_put(software_suspend_module);
 			unlock_kernel();
 			return ret;
 		}
-#endif
+		up(&software_suspend_sem);
+		/* fall through */
 
 	default:
 		unlock_kernel();
Index: kernel/power/Kconfig
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.5/kernel/power/Kconfig,v
retrieving revision 1.1.1.2
diff -u -r1.1.1.2 Kconfig
--- a/kernel/power/Kconfig	9 Jan 2004 06:59:56 -0000	1.1.1.2
+++ b/kernel/power/Kconfig	20 Apr 2004 06:43:44 -0000
@@ -19,7 +19,7 @@
 	  sending the processor to sleep and saving power.
 
 config SOFTWARE_SUSPEND
-	bool "Software Suspend (EXPERIMENTAL)"
+	tristate "Software Suspend (EXPERIMENTAL)"
 	depends on EXPERIMENTAL && PM && SWAP
 	---help---
 	  Enable the possibilty of suspendig machine. It doesn't need APM.
Index: kernel/power/Makefile
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.5/kernel/power/Makefile,v
retrieving revision 1.1.1.3
diff -u -r1.1.1.3 Makefile
--- a/kernel/power/Makefile	28 Sep 2003 04:44:22 -0000	1.1.1.3
+++ b/kernel/power/Makefile	22 Apr 2004 11:30:51 -0000
@@ -3,3 +3,7 @@
 obj-$(CONFIG_PM_DISK)		+= disk.o pmdisk.o
 
 obj-$(CONFIG_MAGIC_SYSRQ)	+= poweroff.o
+
+ifneq ($(CONFIG_SOFTWARE_SUSPEND),)
+obj-y				+= swsusp-core.o
+endif
Index: kernel/power/console.c
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.5/kernel/power/console.c,v
retrieving revision 1.1.1.4
diff -u -r1.1.1.4 console.c
--- a/kernel/power/console.c	19 Feb 2004 08:56:02 -0000	1.1.1.4
+++ b/kernel/power/console.c	20 Apr 2004 12:57:23 -0000
@@ -7,6 +7,7 @@
 #include <linux/vt_kern.h>
 #include <linux/kbd_kern.h>
 #include <linux/console.h>
+#include <linux/module.h>
 #include "power.h"
 
 static int new_loglevel = 10;
@@ -43,6 +44,8 @@
 	return 0;
 }
 
+EXPORT_SYMBOL(pm_prepare_console);
+
 void pm_restore_console(void)
 {
 	console_loglevel = orig_loglevel;
@@ -53,3 +56,5 @@
 #endif
 	return;
 }
+
+EXPORT_SYMBOL(pm_restore_console);
Index: kernel/power/process.c
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.5/kernel/power/process.c,v
retrieving revision 1.1.1.2
diff -u -r1.1.1.2 process.c
--- a/kernel/power/process.c	22 Aug 2003 23:50:57 -0000	1.1.1.2
+++ b/kernel/power/process.c	20 Apr 2004 12:56:35 -0000
@@ -60,6 +60,8 @@
 	current->state = save;
 }
 
+EXPORT_SYMBOL(refrigerator);
+
 /* 0 = success, else # of processes that we failed to stop */
 int freeze_processes(void)
 {
@@ -102,6 +104,8 @@
 	return 0;
 }
 
+EXPORT_SYMBOL(freeze_processes);
+
 void thaw_processes(void)
 {
 	struct task_struct *g, *p;
@@ -125,4 +129,4 @@
 	MDELAY(500);
 }
 
-EXPORT_SYMBOL(refrigerator);
+EXPORT_SYMBOL(thaw_processes);
Index: kernel/power/swsusp-core.c
===================================================================
RCS file: kernel/power/swsusp-core.c
diff -N kernel/power/swsusp-core.c
--- /dev/null	1 Jan 1970 00:00:00 -0000
+++ b/kernel/power/swsusp-core.c	22 Apr 2004 11:29:39 -0000
@@ -0,0 +1,610 @@
+/*
+ * linux/kernel/power/swsusp-core.c
+ *
+ * This file provides symbols required by swusup-arch.
+ *
+ * Copyright (C) 1998-2001 Gabor Kuti <seasons@fornax.hu>
+ * Copyright (C) 1998,2001-2003 Pavel Machek <pavel@suse.cz>
+ * Copyright (C) 2004 Herbert Xu <herbert@debian.org>
+ *
+ * This file is licensed under the GPLv2.
+ */
+
+#include <linux/module.h>
+#include <linux/mm.h>
+#include <linux/suspend.h>
+#include <linux/smp_lock.h>
+#include <linux/file.h>
+#include <linux/utsname.h>
+#include <linux/version.h>
+#include <linux/delay.h>
+#include <linux/reboot.h>
+#include <linux/bitops.h>
+#include <linux/vt_kern.h>
+#include <linux/kbd_kern.h>
+#include <linux/keyboard.h>
+#include <linux/spinlock.h>
+#include <linux/genhd.h>
+#include <linux/kernel.h>
+#include <linux/major.h>
+#include <linux/swap.h>
+#include <linux/pm.h>
+#include <linux/device.h>
+#include <linux/buffer_head.h>
+#include <linux/swapops.h>
+#include <linux/bootmem.h>
+#include <linux/console.h>
+#include <linux/init.h>
+#include <linux/cpumask.h>
+#include <linux/fs.h>
+
+#include <asm/uaccess.h>
+#include <asm/mmu_context.h>
+#include <asm/pgtable.h>
+#include <asm/io.h>
+
+#include "power.h"
+#include "swsusp.h"
+
+#define __ADDRESS(x)  ((unsigned long) phys_to_virt(x))
+#define ADDRESS(x) __ADDRESS((x) << PAGE_SHIFT)
+#define ADDRESS2(x) __ADDRESS(__pa(x))		/* Needed for x86-64 where some pages are in memory twice */
+
+/* References to section boundaries */
+extern char __nosave_begin, __nosave_end;
+
+extern int is_head_of_free_region(struct page *);
+
+/* Locks */
+spinlock_t suspend_pagedir_lock __nosavedata = SPIN_LOCK_UNLOCKED;
+
+/* Variables to be preserved over suspend */
+static int pagedir_order_check;
+static int nr_copy_pages_check;
+
+dev_t swsusp_resume_device;
+EXPORT_SYMBOL(swsusp_resume_device);
+
+/* Local variables that should not be affected by save */
+unsigned int nr_copy_pages __nosavedata = 0;
+EXPORT_SYMBOL(nr_copy_pages);
+
+/* Suspend pagedir is allocated before final copy, therefore it
+   must be freed after resume 
+
+   Warning: this is evil. There are actually two pagedirs at time of
+   resume. One is "pagedir_save", which is empty frame allocated at
+   time of suspend, that must be freed. Second is "pagedir_nosave", 
+   allocated at time of resume, that travels through memory not to
+   collide with anything.
+ */
+suspend_pagedir_t *pagedir_nosave __nosavedata = NULL;
+EXPORT_SYMBOL(pagedir_nosave);
+suspend_pagedir_t *pagedir_save;
+EXPORT_SYMBOL(pagedir_save);
+int pagedir_order __nosavedata = 0;
+EXPORT_SYMBOL(pagedir_order);
+
+/*
+ * XXX: We try to keep some more pages free so that I/O operations succeed
+ * without paging. Might this be more?
+ */
+#define PAGES_FOR_IO	512
+
+const char swsusp_name_suspend[] = "Suspend Machine: ";
+EXPORT_SYMBOL(swsusp_name_suspend);
+const char swsusp_name_resume[] = "Resume Machine: ";
+EXPORT_SYMBOL(swsusp_name_resume);
+
+/*
+ * Saving part...
+ */
+
+static __inline__ int fill_suspend_header(struct suspend_header *sh)
+{
+	memset((char *)sh, 0, sizeof(*sh));
+
+	sh->version_code = LINUX_VERSION_CODE;
+	sh->num_physpages = num_physpages;
+	strncpy(sh->machine, system_utsname.machine, 8);
+	strncpy(sh->version, system_utsname.version, 20);
+	/* FIXME: Is this bogus? --RR */
+	sh->num_cpus = num_online_cpus();
+	sh->page_size = PAGE_SIZE;
+	sh->suspend_pagedir = pagedir_nosave;
+	BUG_ON (pagedir_save != pagedir_nosave);
+	sh->num_pbes = nr_copy_pages;
+	/* TODO: needed? mounted fs' last mounted date comparison
+	 * [so they haven't been mounted since last suspend.
+	 * Maybe it isn't.] [we'd need to do this for _all_ fs-es]
+	 */
+	return 0;
+}
+
+/* We memorize in swapfile_used what swap devices are used for suspension */
+#define SWAPFILE_UNUSED    0
+#define SWAPFILE_SUSPEND   1	/* This is the suspending device */
+#define SWAPFILE_IGNORED   2	/* Those are other swap devices ignored for suspension */
+
+static unsigned short swapfile_used[MAX_SWAPFILES];
+static unsigned short root_swap;
+#define MARK_SWAP_SUSPEND 0
+#define MARK_SWAP_RESUME 2
+
+static void mark_swapfiles(swp_entry_t prev, int mode)
+{
+	swp_entry_t entry;
+	union diskpage *cur;
+	struct page *page;
+
+	if (root_swap == 0xFFFF)  /* ignored */
+		return;
+
+	page = alloc_page(GFP_ATOMIC);
+	if (!page)
+		panic("Out of memory in mark_swapfiles");
+	cur = page_address(page);
+	/* XXX: this is dirty hack to get first page of swap file */
+	entry = swp_entry(root_swap, 0);
+	rw_swap_page_sync(READ, entry, page);
+
+	if (mode == MARK_SWAP_RESUME) {
+	  	if (!memcmp("S1",cur->swh.magic.magic,2))
+		  	memcpy(cur->swh.magic.magic,"SWAP-SPACE",10);
+		else if (!memcmp("S2",cur->swh.magic.magic,2))
+			memcpy(cur->swh.magic.magic,"SWAPSPACE2",10);
+		else printk("%sUnable to find suspended-data signature (%.10s - misspelled?\n", 
+		      	swsusp_name_resume, cur->swh.magic.magic);
+	} else {
+	  	if ((!memcmp("SWAP-SPACE",cur->swh.magic.magic,10)))
+		  	memcpy(cur->swh.magic.magic,"S1SUSP....",10);
+		else if ((!memcmp("SWAPSPACE2",cur->swh.magic.magic,10)))
+			memcpy(cur->swh.magic.magic,"S2SUSP....",10);
+		else panic("\nSwapspace is not swapspace (%.10s)\n", cur->swh.magic.magic);
+		cur->link.next = prev; /* prev is the first/last swap page of the resume area */
+		/* link.next lies *no more* in last 4/8 bytes of magic */
+	}
+	rw_swap_page_sync(WRITE, entry, page);
+	__free_page(page);
+}
+
+static void read_swapfiles(void) /* This is called before saving image */
+{
+	int i;
+	
+	root_swap = 0xFFFF;
+	
+	swap_list_lock();
+	for(i=0; i<MAX_SWAPFILES; i++) {
+		if (swap_info[i].flags == 0) {
+			swapfile_used[i]=SWAPFILE_UNUSED;
+		} else {
+			if (!swsusp_resume_device) {
+	    			printk(KERN_WARNING "resume= option should be used to set suspend device" );
+				if(root_swap == 0xFFFF) {
+					swapfile_used[i] = SWAPFILE_SUSPEND;
+					root_swap = i;
+				} else
+					swapfile_used[i] = SWAPFILE_IGNORED;				  
+			} else {
+	  			/* we ignore all swap devices that are not the swsusp_resume_device */
+				if (1) {
+// FIXME				if(swsusp_resume_device == swap_info[i].swap_device) {
+					swapfile_used[i] = SWAPFILE_SUSPEND;
+					root_swap = i;
+				} else {
+#if 0
+					printk( "Resume: device %s (%x != %x) ignored\n", swap_info[i].swap_file->d_name.name, swap_info[i].swap_device, swsusp_resume_device );				  
+#endif
+				  	swapfile_used[i] = SWAPFILE_IGNORED;
+				}
+			}
+		}
+	}
+	swap_list_unlock();
+}
+
+static void lock_swapdevices(void) /* This is called after saving image so modification
+				      will be lost after resume... and that's what we want. */
+{
+	int i;
+
+	swap_list_lock();
+	for(i = 0; i< MAX_SWAPFILES; i++)
+		if(swapfile_used[i] == SWAPFILE_IGNORED) {
+			swap_info[i].flags ^= 0xFF; /* we make the device unusable. A new call to
+						       lock_swapdevices can unlock the devices. */
+		}
+	swap_list_unlock();
+}
+
+/**
+ *    write_suspend_image - Write entire image to disk.
+ *
+ *    After writing suspend signature to the disk, suspend may no
+ *    longer fail: we have ready-to-run image in swap, and rollback
+ *    would happen on next reboot -- corrupting data.
+ *
+ *    Note: The buffer we allocate to use to write the suspend header is
+ *    not freed; its not needed since the system is going down anyway
+ *    (plus it causes an oops and I'm lazy^H^H^H^Htoo busy).
+ */
+static int write_suspend_image(void)
+{
+	int i;
+	swp_entry_t entry, prev = { 0 };
+	int nr_pgdir_pages = SUSPEND_PD_PAGES(nr_copy_pages);
+	union diskpage *cur,  *buffer = (union diskpage *)get_zeroed_page(GFP_ATOMIC);
+	unsigned long address;
+	struct page *page;
+
+	if (!buffer)
+		return -ENOMEM;
+
+	printk( "Writing data to swap (%d pages): ", nr_copy_pages );
+	for (i=0; i<nr_copy_pages; i++) {
+		if (!(i%100))
+			printk( "." );
+		if (!(entry = get_swap_page()).val)
+			panic("\nNot enough swapspace when writing data" );
+		
+		if (swapfile_used[swp_type(entry)] != SWAPFILE_SUSPEND)
+			panic("\nPage %d: not enough swapspace on suspend device", i );
+	    
+		address = (pagedir_nosave+i)->address;
+		page = virt_to_page(address);
+		rw_swap_page_sync(WRITE, entry, page);
+		(pagedir_nosave+i)->swap_address = entry;
+	}
+	printk( "|\n" );
+	printk( "Writing pagedir (%d pages): ", nr_pgdir_pages);
+	for (i=0; i<nr_pgdir_pages; i++) {
+		cur = (union diskpage *)((char *) pagedir_nosave)+i;
+		BUG_ON ((char *) cur != (((char *) pagedir_nosave) + i*PAGE_SIZE));
+		printk( "." );
+		if (!(entry = get_swap_page()).val) {
+			printk(KERN_CRIT "Not enough swapspace when writing pgdir\n" );
+			panic("Don't know how to recover");
+			free_page((unsigned long) buffer);
+			return -ENOSPC;
+		}
+
+		if(swapfile_used[swp_type(entry)] != SWAPFILE_SUSPEND)
+			panic("\nNot enough swapspace for pagedir on suspend device" );
+
+		BUG_ON (sizeof(swp_entry_t) != sizeof(long));
+		BUG_ON (PAGE_SIZE % sizeof(struct pbe));
+
+		cur->link.next = prev;				
+		page = virt_to_page((unsigned long)cur);
+		rw_swap_page_sync(WRITE, entry, page);
+		prev = entry;
+	}
+	printk("H");
+	BUG_ON (sizeof(struct suspend_header) > PAGE_SIZE-sizeof(swp_entry_t));
+	BUG_ON (sizeof(union diskpage) != PAGE_SIZE);
+	BUG_ON (sizeof(struct link) != PAGE_SIZE);
+	if (!(entry = get_swap_page()).val)
+		panic( "\nNot enough swapspace when writing header" );
+	if (swapfile_used[swp_type(entry)] != SWAPFILE_SUSPEND)
+		panic("\nNot enough swapspace for header on suspend device" );
+
+	cur = (void *) buffer;
+	if (fill_suspend_header(&cur->sh))
+		panic("\nOut of memory while writing header");
+		
+	cur->link.next = prev;
+
+	page = virt_to_page((unsigned long)cur);
+	rw_swap_page_sync(WRITE, entry, page);
+	prev = entry;
+
+	printk( "S" );
+	mark_swapfiles(prev, MARK_SWAP_SUSPEND);
+	printk( "|\n" );
+
+	MDELAY(1000);
+	return 0;
+}
+
+/* if pagedir_p != NULL it also copies the counted pages */
+static int count_and_copy_data_pages(struct pbe *pagedir_p)
+{
+	int chunk_size;
+	int nr_copy_pages = 0;
+	int pfn;
+	struct page *page;
+	
+#ifdef CONFIG_DISCONTIGMEM
+	panic("Discontingmem not supported");
+#else
+	BUG_ON (max_pfn != num_physpages);
+#endif
+	for (pfn = 0; pfn < max_pfn; pfn++) {
+		page = pfn_to_page(pfn);
+		if (PageHighMem(page))
+			panic("Swsusp not supported on highmem boxes. Send 1GB of RAM to <pavel@ucw.cz> and try again ;-).");
+
+		if (!PageReserved(page)) {
+			if (PageNosave(page))
+				continue;
+
+			if ((chunk_size=is_head_of_free_region(page))!=0) {
+				pfn += chunk_size - 1;
+				continue;
+			}
+		} else if (PageReserved(page)) {
+			BUG_ON (PageNosave(page));
+
+			/*
+			 * Just copy whole code segment. Hopefully it is not that big.
+			 */
+			if ((ADDRESS(pfn) >= (unsigned long) ADDRESS2(&__nosave_begin)) && 
+			    (ADDRESS(pfn) <  (unsigned long) ADDRESS2(&__nosave_end))) {
+				PRINTK("[nosave %lx]", ADDRESS(pfn));
+				continue;
+			}
+			/* Hmm, perhaps copying all reserved pages is not too healthy as they may contain 
+			   critical bios data? */
+		} else	BUG();
+
+		nr_copy_pages++;
+		if (pagedir_p) {
+			pagedir_p->orig_address = ADDRESS(pfn);
+			copy_page((void *) pagedir_p->address, (void *) pagedir_p->orig_address);
+			pagedir_p++;
+		}
+	}
+	return nr_copy_pages;
+}
+
+static void free_suspend_pagedir(unsigned long this_pagedir)
+{
+	struct page *page;
+	int pfn;
+	unsigned long this_pagedir_end = this_pagedir +
+		(PAGE_SIZE << pagedir_order);
+
+	for(pfn = 0; pfn < num_physpages; pfn++) {
+		page = pfn_to_page(pfn);
+		if (!TestClearPageNosave(page))
+			continue;
+
+		if (ADDRESS(pfn) >= this_pagedir && ADDRESS(pfn) < this_pagedir_end)
+			continue; /* old pagedir gets freed in one */
+		
+		free_page(ADDRESS(pfn));
+	}
+	free_pages(this_pagedir, pagedir_order);
+}
+
+static suspend_pagedir_t *create_suspend_pagedir(int nr_copy_pages)
+{
+	int i;
+	suspend_pagedir_t *pagedir;
+	struct pbe *p;
+	struct page *page;
+
+	pagedir_order = get_bitmask_order(SUSPEND_PD_PAGES(nr_copy_pages));
+
+	p = pagedir = (suspend_pagedir_t *)__get_free_pages(GFP_ATOMIC | __GFP_COLD, pagedir_order);
+	if(!pagedir)
+		return NULL;
+
+	page = virt_to_page(pagedir);
+	for(i=0; i < 1<<pagedir_order; i++)
+		SetPageNosave(page++);
+		
+	while(nr_copy_pages--) {
+		p->address = get_zeroed_page(GFP_ATOMIC | __GFP_COLD);
+		if(!p->address) {
+			free_suspend_pagedir((unsigned long) pagedir);
+			return NULL;
+		}
+		SetPageNosave(virt_to_page(p->address));
+		p->orig_address = 0;
+		p++;
+	}
+	return pagedir;
+}
+
+static int suspend_prepare_image(void)
+{
+	struct sysinfo i;
+	unsigned int nr_needed_pages = 0;
+
+	drain_local_pages();
+
+	pagedir_nosave = NULL;
+	printk( "/critical section: Counting pages to copy" );
+	nr_copy_pages = count_and_copy_data_pages(NULL);
+	nr_needed_pages = nr_copy_pages + PAGES_FOR_IO;
+	
+	printk(" (pages needed: %d+%d=%d free: %d)\n",nr_copy_pages,PAGES_FOR_IO,nr_needed_pages,nr_free_pages());
+	if(nr_free_pages() < nr_needed_pages) {
+		printk(KERN_CRIT "%sCouldn't get enough free pages, on %d pages short\n",
+		       swsusp_name_suspend, nr_needed_pages-nr_free_pages());
+		root_swap = 0xFFFF;
+		return 1;
+	}
+	si_swapinfo(&i);	/* FIXME: si_swapinfo(&i) returns all swap devices information.
+				   We should only consider swsusp_resume_device. */
+	if (i.freeswap < nr_needed_pages)  {
+		printk(KERN_CRIT "%sThere's not enough swap space available, on %ld pages short\n",
+		       swsusp_name_suspend, nr_needed_pages-i.freeswap);
+		return 1;
+	}
+
+	PRINTK( "Alloc pagedir\n" ); 
+	pagedir_save = pagedir_nosave = create_suspend_pagedir(nr_copy_pages);
+	if(!pagedir_nosave) {
+		/* Shouldn't happen */
+		printk(KERN_CRIT "%sCouldn't allocate enough pages\n",swsusp_name_suspend);
+		panic("Really should not happen");
+		return 1;
+	}
+	nr_copy_pages_check = nr_copy_pages;
+	pagedir_order_check = pagedir_order;
+
+	drain_local_pages();	/* During allocating of suspend pagedir, new cold pages may appear. Kill them */
+	if (nr_copy_pages != count_and_copy_data_pages(pagedir_nosave))	/* copy */
+		BUG();
+
+	/*
+	 * End of critical section. From now on, we can write to memory,
+	 * but we should not touch disk. This specially means we must _not_
+	 * touch swap space! Except we must write out our image of course.
+	 */
+
+	printk( "critical section/: done (%d pages copied)\n", nr_copy_pages );
+	return 0;
+}
+
+static void suspend_save_image(void)
+{
+	device_resume();
+
+	lock_swapdevices();
+	write_suspend_image();
+	lock_swapdevices();	/* This will unlock ignored swap devices since writing is finished */
+
+	/* It is important _NOT_ to umount filesystems at this point. We want
+	 * them synced (in case something goes wrong) but we DO not want to mark
+	 * filesystem clean: it is not. (And it does not matter, if we resume
+	 * correctly, we'll mark system clean, anyway.)
+	 */
+}
+
+static void suspend_power_down(void)
+{
+	extern int C_A_D;
+	C_A_D = 0;
+	printk(KERN_EMERG "%s%s Trying to power down.\n", swsusp_name_suspend, TEST_SWSUSP ? "Disable TEST_SWSUSP. NOT ": "");
+#ifdef CONFIG_VT
+	PRINTK(KERN_EMERG "shift_state: %04x\n", shift_state);
+	mdelay(1000);
+	if (TEST_SWSUSP ^ (!!(shift_state & (1 << KG_CTRL))))
+		machine_restart(NULL);
+	else
+#endif
+	{
+		device_shutdown();
+		machine_power_off();
+	}
+
+	printk(KERN_EMERG "%sProbably not capable for powerdown. System halted.\n", swsusp_name_suspend);
+	machine_halt();
+	while (1);
+	/* NOTREACHED */
+}
+
+/*
+ * Magic happens here
+ */
+
+asmlinkage void do_magic_resume_1(void)
+{
+	barrier();
+	mb();
+	spin_lock_irq(&suspend_pagedir_lock);	/* Done to disable interrupts */ 
+
+	device_power_down(4);
+	PRINTK( "Waiting for DMAs to settle down...\n");
+	mdelay(1000);	/* We do not want some readahead with DMA to corrupt our memory, right?
+			   Do it with disabled interrupts for best effect. That way, if some
+			   driver scheduled DMA, we have good chance for DMA to finish ;-). */
+}
+
+EXPORT_SYMBOL(do_magic_resume_1);
+
+asmlinkage void do_magic_resume_2(void)
+{
+	BUG_ON (nr_copy_pages_check != nr_copy_pages);
+	BUG_ON (pagedir_order_check != pagedir_order);
+
+	__flush_tlb_global();		/* Even mappings of "global" things (vmalloc) need to be fixed */
+
+	PRINTK( "Freeing prev allocated pagedir\n" );
+	free_suspend_pagedir((unsigned long) pagedir_save);
+	device_power_up();
+	spin_unlock_irq(&suspend_pagedir_lock);
+	device_resume();
+
+	acquire_console_sem();
+	update_screen(fg_console);	/* Hmm, is this the problem? */
+	release_console_sem();
+
+	PRINTK( "Fixing swap signatures... " );
+	mark_swapfiles(((swp_entry_t) {0}), MARK_SWAP_RESUME);
+	PRINTK( "ok\n" );
+
+#ifdef SUSPEND_CONSOLE
+	acquire_console_sem();
+	update_screen(fg_console);	/* Hmm, is this the problem? */
+	release_console_sem();
+#endif
+}
+
+EXPORT_SYMBOL(do_magic_resume_2);
+
+/* do_magic() is implemented in arch/?/kernel/suspend_asm.S, and basically does:
+
+	if (!resume) {
+		do_magic_suspend_1();
+		save_processor_state();
+		SAVE_REGISTERS
+		do_magic_suspend_2();
+		return;
+	}
+	GO_TO_SWAPPER_PAGE_TABLES
+	do_magic_resume_1();
+	COPY_PAGES_BACK
+	RESTORE_REGISTERS
+	restore_processor_state();
+	do_magic_resume_2();
+
+ */
+
+asmlinkage void do_magic_suspend_1(void)
+{
+	mb();
+	barrier();
+	BUG_ON(in_atomic());
+	spin_lock_irq(&suspend_pagedir_lock);
+}
+
+EXPORT_SYMBOL(do_magic_suspend_1);
+
+asmlinkage void do_magic_suspend_2(void)
+{
+	int is_problem;
+	read_swapfiles();
+	device_power_down(4);
+	is_problem = suspend_prepare_image();
+	device_power_up();
+	spin_unlock_irq(&suspend_pagedir_lock);
+	if (!is_problem) {
+		kernel_fpu_end();	/* save_processor_state() does kernel_fpu_begin, and we need to revert it in order to pass in_atomic() checks */
+		BUG_ON(in_atomic());
+		suspend_save_image();
+		suspend_power_down();	/* FIXME: if suspend_power_down is commented out, console is lost after few suspends ?! */
+	}
+
+	printk(KERN_EMERG "%sSuspend failed, trying to recover...\n", swsusp_name_suspend);
+	MDELAY(1000); /* So user can wait and report us messages if armageddon comes :-) */
+
+	barrier();
+	mb();
+	spin_lock_irq(&suspend_pagedir_lock);	/* Done to disable interrupts */ 
+	mdelay(1000);
+
+	free_pages((unsigned long) pagedir_nosave, pagedir_order);
+	spin_unlock_irq(&suspend_pagedir_lock);
+
+	device_resume();
+	PRINTK( "Fixing swap signatures... " );
+	mark_swapfiles(((swp_entry_t) {0}), MARK_SWAP_RESUME);
+	PRINTK( "ok\n" );
+}
+
+EXPORT_SYMBOL(do_magic_suspend_2);
Index: kernel/power/swsusp.c
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.5/kernel/power/swsusp.c,v
retrieving revision 1.3
diff -u -r1.3 swsusp.c
--- a/kernel/power/swsusp.c	12 Mar 2004 11:03:09 -0000	1.3
+++ b/kernel/power/swsusp.c	22 Apr 2004 11:46:58 -0000
@@ -39,430 +39,38 @@
 #include <linux/module.h>
 #include <linux/mm.h>
 #include <linux/suspend.h>
-#include <linux/smp_lock.h>
-#include <linux/file.h>
 #include <linux/utsname.h>
 #include <linux/version.h>
-#include <linux/delay.h>
-#include <linux/reboot.h>
-#include <linux/bitops.h>
-#include <linux/vt_kern.h>
-#include <linux/kbd_kern.h>
-#include <linux/keyboard.h>
-#include <linux/spinlock.h>
-#include <linux/genhd.h>
 #include <linux/kernel.h>
 #include <linux/major.h>
 #include <linux/swap.h>
 #include <linux/pm.h>
-#include <linux/device.h>
-#include <linux/buffer_head.h>
-#include <linux/swapops.h>
-#include <linux/bootmem.h>
 #include <linux/syscalls.h>
 #include <linux/console.h>
-
-#include <asm/uaccess.h>
-#include <asm/mmu_context.h>
-#include <asm/pgtable.h>
-#include <asm/io.h>
+#include <linux/init.h>
+#include <linux/moduleparam.h>
+#include <linux/kdev_t.h>
+#include <linux/blkdev.h>
+#include <linux/buffer_head.h>
+#include <linux/swapops.h>
+#include <linux/cpumask.h>
+#include <linux/slab.h>
+#include <linux/fs.h>
+#include <linux/string.h>
+#include <linux/pagemap.h>
 
 #include "power.h"
+#include "swsusp.h"
 
 unsigned char software_suspend_enabled = 0;
 
-#define NORESUME		1
-#define RESUME_SPECIFIED	2
-
-
-#define __ADDRESS(x)  ((unsigned long) phys_to_virt(x))
-#define ADDRESS(x) __ADDRESS((x) << PAGE_SHIFT)
-#define ADDRESS2(x) __ADDRESS(__pa(x))		/* Needed for x86-64 where some pages are in memory twice */
-
-/* References to section boundaries */
-extern char __nosave_begin, __nosave_end;
-
-extern int is_head_of_free_region(struct page *);
-
-/* Locks */
-spinlock_t suspend_pagedir_lock __nosavedata = SPIN_LOCK_UNLOCKED;
-
-/* Variables to be preserved over suspend */
-static int pagedir_order_check;
-static int nr_copy_pages_check;
-
-static int resume_status;
-static char resume_file[256] = "";			/* For resume= kernel option */
-static dev_t resume_device;
-/* Local variables that should not be affected by save */
-unsigned int nr_copy_pages __nosavedata = 0;
-
-/* Suspend pagedir is allocated before final copy, therefore it
-   must be freed after resume 
-
-   Warning: this is evil. There are actually two pagedirs at time of
-   resume. One is "pagedir_save", which is empty frame allocated at
-   time of suspend, that must be freed. Second is "pagedir_nosave", 
-   allocated at time of resume, that travels through memory not to
-   collide with anything.
- */
-suspend_pagedir_t *pagedir_nosave __nosavedata = NULL;
-static suspend_pagedir_t *pagedir_save;
-static int pagedir_order __nosavedata = 0;
-
-struct link {
-	char dummy[PAGE_SIZE - sizeof(swp_entry_t)];
-	swp_entry_t next;
-};
-
-union diskpage {
-	union swap_header swh;
-	struct link link;
-	struct suspend_header sh;
-};
-
-/*
- * XXX: We try to keep some more pages free so that I/O operations succeed
- * without paging. Might this be more?
- */
-#define PAGES_FOR_IO	512
-
-static const char name_suspend[] = "Suspend Machine: ";
-static const char name_resume[] = "Resume Machine: ";
-
-/*
- * Debug
- */
-#define	DEBUG_DEFAULT
-#undef	DEBUG_PROCESS
-#undef	DEBUG_SLOW
-#define TEST_SWSUSP 0		/* Set to 1 to reboot instead of halt machine after suspension */
-
-#ifdef DEBUG_DEFAULT
-# define PRINTK(f, a...)       printk(f, ## a)
-#else
-# define PRINTK(f, a...)
-#endif
-
-#ifdef DEBUG_SLOW
-#define MDELAY(a) mdelay(a)
-#else
-#define MDELAY(a)
-#endif
+static int noresume __initdata;
+static char resume_file[256] __initdata;	/* For resume= kernel option */
 
 /*
  * Saving part...
  */
 
-static __inline__ int fill_suspend_header(struct suspend_header *sh)
-{
-	memset((char *)sh, 0, sizeof(*sh));
-
-	sh->version_code = LINUX_VERSION_CODE;
-	sh->num_physpages = num_physpages;
-	strncpy(sh->machine, system_utsname.machine, 8);
-	strncpy(sh->version, system_utsname.version, 20);
-	/* FIXME: Is this bogus? --RR */
-	sh->num_cpus = num_online_cpus();
-	sh->page_size = PAGE_SIZE;
-	sh->suspend_pagedir = pagedir_nosave;
-	BUG_ON (pagedir_save != pagedir_nosave);
-	sh->num_pbes = nr_copy_pages;
-	/* TODO: needed? mounted fs' last mounted date comparison
-	 * [so they haven't been mounted since last suspend.
-	 * Maybe it isn't.] [we'd need to do this for _all_ fs-es]
-	 */
-	return 0;
-}
-
-/* We memorize in swapfile_used what swap devices are used for suspension */
-#define SWAPFILE_UNUSED    0
-#define SWAPFILE_SUSPEND   1	/* This is the suspending device */
-#define SWAPFILE_IGNORED   2	/* Those are other swap devices ignored for suspension */
-
-static unsigned short swapfile_used[MAX_SWAPFILES];
-static unsigned short root_swap;
-#define MARK_SWAP_SUSPEND 0
-#define MARK_SWAP_RESUME 2
-
-static void mark_swapfiles(swp_entry_t prev, int mode)
-{
-	swp_entry_t entry;
-	union diskpage *cur;
-	struct page *page;
-
-	if (root_swap == 0xFFFF)  /* ignored */
-		return;
-
-	page = alloc_page(GFP_ATOMIC);
-	if (!page)
-		panic("Out of memory in mark_swapfiles");
-	cur = page_address(page);
-	/* XXX: this is dirty hack to get first page of swap file */
-	entry = swp_entry(root_swap, 0);
-	rw_swap_page_sync(READ, entry, page);
-
-	if (mode == MARK_SWAP_RESUME) {
-	  	if (!memcmp("S1",cur->swh.magic.magic,2))
-		  	memcpy(cur->swh.magic.magic,"SWAP-SPACE",10);
-		else if (!memcmp("S2",cur->swh.magic.magic,2))
-			memcpy(cur->swh.magic.magic,"SWAPSPACE2",10);
-		else printk("%sUnable to find suspended-data signature (%.10s - misspelled?\n", 
-		      	name_resume, cur->swh.magic.magic);
-	} else {
-	  	if ((!memcmp("SWAP-SPACE",cur->swh.magic.magic,10)))
-		  	memcpy(cur->swh.magic.magic,"S1SUSP....",10);
-		else if ((!memcmp("SWAPSPACE2",cur->swh.magic.magic,10)))
-			memcpy(cur->swh.magic.magic,"S2SUSP....",10);
-		else panic("\nSwapspace is not swapspace (%.10s)\n", cur->swh.magic.magic);
-		cur->link.next = prev; /* prev is the first/last swap page of the resume area */
-		/* link.next lies *no more* in last 4/8 bytes of magic */
-	}
-	rw_swap_page_sync(WRITE, entry, page);
-	__free_page(page);
-}
-
-static void read_swapfiles(void) /* This is called before saving image */
-{
-	int i, len;
-	
-	len=strlen(resume_file);
-	root_swap = 0xFFFF;
-	
-	swap_list_lock();
-	for(i=0; i<MAX_SWAPFILES; i++) {
-		if (swap_info[i].flags == 0) {
-			swapfile_used[i]=SWAPFILE_UNUSED;
-		} else {
-			if(!len) {
-	    			printk(KERN_WARNING "resume= option should be used to set suspend device" );
-				if(root_swap == 0xFFFF) {
-					swapfile_used[i] = SWAPFILE_SUSPEND;
-					root_swap = i;
-				} else
-					swapfile_used[i] = SWAPFILE_IGNORED;				  
-			} else {
-	  			/* we ignore all swap devices that are not the resume_file */
-				if (1) {
-// FIXME				if(resume_device == swap_info[i].swap_device) {
-					swapfile_used[i] = SWAPFILE_SUSPEND;
-					root_swap = i;
-				} else {
-#if 0
-					printk( "Resume: device %s (%x != %x) ignored\n", swap_info[i].swap_file->d_name.name, swap_info[i].swap_device, resume_device );				  
-#endif
-				  	swapfile_used[i] = SWAPFILE_IGNORED;
-				}
-			}
-		}
-	}
-	swap_list_unlock();
-}
-
-static void lock_swapdevices(void) /* This is called after saving image so modification
-				      will be lost after resume... and that's what we want. */
-{
-	int i;
-
-	swap_list_lock();
-	for(i = 0; i< MAX_SWAPFILES; i++)
-		if(swapfile_used[i] == SWAPFILE_IGNORED) {
-			swap_info[i].flags ^= 0xFF; /* we make the device unusable. A new call to
-						       lock_swapdevices can unlock the devices. */
-		}
-	swap_list_unlock();
-}
-
-/**
- *    write_suspend_image - Write entire image to disk.
- *
- *    After writing suspend signature to the disk, suspend may no
- *    longer fail: we have ready-to-run image in swap, and rollback
- *    would happen on next reboot -- corrupting data.
- *
- *    Note: The buffer we allocate to use to write the suspend header is
- *    not freed; its not needed since the system is going down anyway
- *    (plus it causes an oops and I'm lazy^H^H^H^Htoo busy).
- */
-static int write_suspend_image(void)
-{
-	int i;
-	swp_entry_t entry, prev = { 0 };
-	int nr_pgdir_pages = SUSPEND_PD_PAGES(nr_copy_pages);
-	union diskpage *cur,  *buffer = (union diskpage *)get_zeroed_page(GFP_ATOMIC);
-	unsigned long address;
-	struct page *page;
-
-	if (!buffer)
-		return -ENOMEM;
-
-	printk( "Writing data to swap (%d pages): ", nr_copy_pages );
-	for (i=0; i<nr_copy_pages; i++) {
-		if (!(i%100))
-			printk( "." );
-		if (!(entry = get_swap_page()).val)
-			panic("\nNot enough swapspace when writing data" );
-		
-		if (swapfile_used[swp_type(entry)] != SWAPFILE_SUSPEND)
-			panic("\nPage %d: not enough swapspace on suspend device", i );
-	    
-		address = (pagedir_nosave+i)->address;
-		page = virt_to_page(address);
-		rw_swap_page_sync(WRITE, entry, page);
-		(pagedir_nosave+i)->swap_address = entry;
-	}
-	printk( "|\n" );
-	printk( "Writing pagedir (%d pages): ", nr_pgdir_pages);
-	for (i=0; i<nr_pgdir_pages; i++) {
-		cur = (union diskpage *)((char *) pagedir_nosave)+i;
-		BUG_ON ((char *) cur != (((char *) pagedir_nosave) + i*PAGE_SIZE));
-		printk( "." );
-		if (!(entry = get_swap_page()).val) {
-			printk(KERN_CRIT "Not enough swapspace when writing pgdir\n" );
-			panic("Don't know how to recover");
-			free_page((unsigned long) buffer);
-			return -ENOSPC;
-		}
-
-		if(swapfile_used[swp_type(entry)] != SWAPFILE_SUSPEND)
-			panic("\nNot enough swapspace for pagedir on suspend device" );
-
-		BUG_ON (sizeof(swp_entry_t) != sizeof(long));
-		BUG_ON (PAGE_SIZE % sizeof(struct pbe));
-
-		cur->link.next = prev;				
-		page = virt_to_page((unsigned long)cur);
-		rw_swap_page_sync(WRITE, entry, page);
-		prev = entry;
-	}
-	printk("H");
-	BUG_ON (sizeof(struct suspend_header) > PAGE_SIZE-sizeof(swp_entry_t));
-	BUG_ON (sizeof(union diskpage) != PAGE_SIZE);
-	BUG_ON (sizeof(struct link) != PAGE_SIZE);
-	if (!(entry = get_swap_page()).val)
-		panic( "\nNot enough swapspace when writing header" );
-	if (swapfile_used[swp_type(entry)] != SWAPFILE_SUSPEND)
-		panic("\nNot enough swapspace for header on suspend device" );
-
-	cur = (void *) buffer;
-	if (fill_suspend_header(&cur->sh))
-		panic("\nOut of memory while writing header");
-		
-	cur->link.next = prev;
-
-	page = virt_to_page((unsigned long)cur);
-	rw_swap_page_sync(WRITE, entry, page);
-	prev = entry;
-
-	printk( "S" );
-	mark_swapfiles(prev, MARK_SWAP_SUSPEND);
-	printk( "|\n" );
-
-	MDELAY(1000);
-	return 0;
-}
-
-/* if pagedir_p != NULL it also copies the counted pages */
-static int count_and_copy_data_pages(struct pbe *pagedir_p)
-{
-	int chunk_size;
-	int nr_copy_pages = 0;
-	int pfn;
-	struct page *page;
-	
-#ifdef CONFIG_DISCONTIGMEM
-	panic("Discontingmem not supported");
-#else
-	BUG_ON (max_pfn != num_physpages);
-#endif
-	for (pfn = 0; pfn < max_pfn; pfn++) {
-		page = pfn_to_page(pfn);
-		if (PageHighMem(page))
-			panic("Swsusp not supported on highmem boxes. Send 1GB of RAM to <pavel@ucw.cz> and try again ;-).");
-
-		if (!PageReserved(page)) {
-			if (PageNosave(page))
-				continue;
-
-			if ((chunk_size=is_head_of_free_region(page))!=0) {
-				pfn += chunk_size - 1;
-				continue;
-			}
-		} else if (PageReserved(page)) {
-			BUG_ON (PageNosave(page));
-
-			/*
-			 * Just copy whole code segment. Hopefully it is not that big.
-			 */
-			if ((ADDRESS(pfn) >= (unsigned long) ADDRESS2(&__nosave_begin)) && 
-			    (ADDRESS(pfn) <  (unsigned long) ADDRESS2(&__nosave_end))) {
-				PRINTK("[nosave %lx]", ADDRESS(pfn));
-				continue;
-			}
-			/* Hmm, perhaps copying all reserved pages is not too healthy as they may contain 
-			   critical bios data? */
-		} else	BUG();
-
-		nr_copy_pages++;
-		if (pagedir_p) {
-			pagedir_p->orig_address = ADDRESS(pfn);
-			copy_page((void *) pagedir_p->address, (void *) pagedir_p->orig_address);
-			pagedir_p++;
-		}
-	}
-	return nr_copy_pages;
-}
-
-static void free_suspend_pagedir(unsigned long this_pagedir)
-{
-	struct page *page;
-	int pfn;
-	unsigned long this_pagedir_end = this_pagedir +
-		(PAGE_SIZE << pagedir_order);
-
-	for(pfn = 0; pfn < num_physpages; pfn++) {
-		page = pfn_to_page(pfn);
-		if (!TestClearPageNosave(page))
-			continue;
-
-		if (ADDRESS(pfn) >= this_pagedir && ADDRESS(pfn) < this_pagedir_end)
-			continue; /* old pagedir gets freed in one */
-		
-		free_page(ADDRESS(pfn));
-	}
-	free_pages(this_pagedir, pagedir_order);
-}
-
-static suspend_pagedir_t *create_suspend_pagedir(int nr_copy_pages)
-{
-	int i;
-	suspend_pagedir_t *pagedir;
-	struct pbe *p;
-	struct page *page;
-
-	pagedir_order = get_bitmask_order(SUSPEND_PD_PAGES(nr_copy_pages));
-
-	p = pagedir = (suspend_pagedir_t *)__get_free_pages(GFP_ATOMIC | __GFP_COLD, pagedir_order);
-	if(!pagedir)
-		return NULL;
-
-	page = virt_to_page(pagedir);
-	for(i=0; i < 1<<pagedir_order; i++)
-		SetPageNosave(page++);
-		
-	while(nr_copy_pages--) {
-		p->address = get_zeroed_page(GFP_ATOMIC | __GFP_COLD);
-		if(!p->address) {
-			free_suspend_pagedir((unsigned long) pagedir);
-			return NULL;
-		}
-		SetPageNosave(virt_to_page(p->address));
-		p->orig_address = 0;
-		p++;
-	}
-	return pagedir;
-}
-
 static int prepare_suspend_processes(void)
 {
 	sys_sync();	/* Syncing needs pdflushd, so do it before stopping processes */
@@ -487,204 +95,11 @@
 	printk("|\n");
 }
 
-static int suspend_prepare_image(void)
-{
-	struct sysinfo i;
-	unsigned int nr_needed_pages = 0;
-
-	drain_local_pages();
-
-	pagedir_nosave = NULL;
-	printk( "/critical section: Counting pages to copy" );
-	nr_copy_pages = count_and_copy_data_pages(NULL);
-	nr_needed_pages = nr_copy_pages + PAGES_FOR_IO;
-	
-	printk(" (pages needed: %d+%d=%d free: %d)\n",nr_copy_pages,PAGES_FOR_IO,nr_needed_pages,nr_free_pages());
-	if(nr_free_pages() < nr_needed_pages) {
-		printk(KERN_CRIT "%sCouldn't get enough free pages, on %d pages short\n",
-		       name_suspend, nr_needed_pages-nr_free_pages());
-		root_swap = 0xFFFF;
-		return 1;
-	}
-	si_swapinfo(&i);	/* FIXME: si_swapinfo(&i) returns all swap devices information.
-				   We should only consider resume_device. */
-	if (i.freeswap < nr_needed_pages)  {
-		printk(KERN_CRIT "%sThere's not enough swap space available, on %ld pages short\n",
-		       name_suspend, nr_needed_pages-i.freeswap);
-		return 1;
-	}
-
-	PRINTK( "Alloc pagedir\n" ); 
-	pagedir_save = pagedir_nosave = create_suspend_pagedir(nr_copy_pages);
-	if(!pagedir_nosave) {
-		/* Shouldn't happen */
-		printk(KERN_CRIT "%sCouldn't allocate enough pages\n",name_suspend);
-		panic("Really should not happen");
-		return 1;
-	}
-	nr_copy_pages_check = nr_copy_pages;
-	pagedir_order_check = pagedir_order;
-
-	drain_local_pages();	/* During allocating of suspend pagedir, new cold pages may appear. Kill them */
-	if (nr_copy_pages != count_and_copy_data_pages(pagedir_nosave))	/* copy */
-		BUG();
-
-	/*
-	 * End of critical section. From now on, we can write to memory,
-	 * but we should not touch disk. This specially means we must _not_
-	 * touch swap space! Except we must write out our image of course.
-	 */
-
-	printk( "critical section/: done (%d pages copied)\n", nr_copy_pages );
-	return 0;
-}
-
-static void suspend_save_image(void)
-{
-	device_resume();
-
-	lock_swapdevices();
-	write_suspend_image();
-	lock_swapdevices();	/* This will unlock ignored swap devices since writing is finished */
-
-	/* It is important _NOT_ to umount filesystems at this point. We want
-	 * them synced (in case something goes wrong) but we DO not want to mark
-	 * filesystem clean: it is not. (And it does not matter, if we resume
-	 * correctly, we'll mark system clean, anyway.)
-	 */
-}
-
-static void suspend_power_down(void)
-{
-	extern int C_A_D;
-	C_A_D = 0;
-	printk(KERN_EMERG "%s%s Trying to power down.\n", name_suspend, TEST_SWSUSP ? "Disable TEST_SWSUSP. NOT ": "");
-#ifdef CONFIG_VT
-	PRINTK(KERN_EMERG "shift_state: %04x\n", shift_state);
-	mdelay(1000);
-	if (TEST_SWSUSP ^ (!!(shift_state & (1 << KG_CTRL))))
-		machine_restart(NULL);
-	else
-#endif
-	{
-		device_shutdown();
-		machine_power_off();
-	}
-
-	printk(KERN_EMERG "%sProbably not capable for powerdown. System halted.\n", name_suspend);
-	machine_halt();
-	while (1);
-	/* NOTREACHED */
-}
-
-/*
- * Magic happens here
- */
-
-asmlinkage void do_magic_resume_1(void)
-{
-	barrier();
-	mb();
-	spin_lock_irq(&suspend_pagedir_lock);	/* Done to disable interrupts */ 
-
-	device_power_down(4);
-	PRINTK( "Waiting for DMAs to settle down...\n");
-	mdelay(1000);	/* We do not want some readahead with DMA to corrupt our memory, right?
-			   Do it with disabled interrupts for best effect. That way, if some
-			   driver scheduled DMA, we have good chance for DMA to finish ;-). */
-}
-
-asmlinkage void do_magic_resume_2(void)
-{
-	BUG_ON (nr_copy_pages_check != nr_copy_pages);
-	BUG_ON (pagedir_order_check != pagedir_order);
-
-	__flush_tlb_global();		/* Even mappings of "global" things (vmalloc) need to be fixed */
-
-	PRINTK( "Freeing prev allocated pagedir\n" );
-	free_suspend_pagedir((unsigned long) pagedir_save);
-	device_power_up();
-	spin_unlock_irq(&suspend_pagedir_lock);
-	device_resume();
-
-	acquire_console_sem();
-	update_screen(fg_console);	/* Hmm, is this the problem? */
-	release_console_sem();
-
-	PRINTK( "Fixing swap signatures... " );
-	mark_swapfiles(((swp_entry_t) {0}), MARK_SWAP_RESUME);
-	PRINTK( "ok\n" );
-
-#ifdef SUSPEND_CONSOLE
-	acquire_console_sem();
-	update_screen(fg_console);	/* Hmm, is this the problem? */
-	release_console_sem();
-#endif
-}
-
-/* do_magic() is implemented in arch/?/kernel/suspend_asm.S, and basically does:
-
-	if (!resume) {
-		do_magic_suspend_1();
-		save_processor_state();
-		SAVE_REGISTERS
-		do_magic_suspend_2();
-		return;
-	}
-	GO_TO_SWAPPER_PAGE_TABLES
-	do_magic_resume_1();
-	COPY_PAGES_BACK
-	RESTORE_REGISTERS
-	restore_processor_state();
-	do_magic_resume_2();
-
- */
-
-asmlinkage void do_magic_suspend_1(void)
-{
-	mb();
-	barrier();
-	BUG_ON(in_atomic());
-	spin_lock_irq(&suspend_pagedir_lock);
-}
-
-asmlinkage void do_magic_suspend_2(void)
-{
-	int is_problem;
-	read_swapfiles();
-	device_power_down(4);
-	is_problem = suspend_prepare_image();
-	device_power_up();
-	spin_unlock_irq(&suspend_pagedir_lock);
-	if (!is_problem) {
-		kernel_fpu_end();	/* save_processor_state() does kernel_fpu_begin, and we need to revert it in order to pass in_atomic() checks */
-		BUG_ON(in_atomic());
-		suspend_save_image();
-		suspend_power_down();	/* FIXME: if suspend_power_down is commented out, console is lost after few suspends ?! */
-	}
-
-	printk(KERN_EMERG "%sSuspend failed, trying to recover...\n", name_suspend);
-	MDELAY(1000); /* So user can wait and report us messages if armageddon comes :-) */
-
-	barrier();
-	mb();
-	spin_lock_irq(&suspend_pagedir_lock);	/* Done to disable interrupts */ 
-	mdelay(1000);
-
-	free_pages((unsigned long) pagedir_nosave, pagedir_order);
-	spin_unlock_irq(&suspend_pagedir_lock);
-
-	device_resume();
-	PRINTK( "Fixing swap signatures... " );
-	mark_swapfiles(((swp_entry_t) {0}), MARK_SWAP_RESUME);
-	PRINTK( "ok\n" );
-}
-
 /*
  * This is main interface to the outside world. It needs to be
  * called from process context.
  */
-int software_suspend(void)
+static int software_suspend(void)
 {
 	int res;
 	if (!software_suspend_enabled)
@@ -694,11 +109,11 @@
 	might_sleep();
 
 	if (arch_prepare_suspend()) {
-		printk("%sArchitecture failed to prepare\n", name_suspend);
+		printk("%sArchitecture failed to prepare\n", swsusp_name_suspend);
 		return -EPERM;
 	}		
 	if (pm_prepare_console())
-		printk( "%sCan't allocate a console... proceeding\n", name_suspend);
+		printk( "%sCan't allocate a console... proceeding\n", swsusp_name_suspend);
 	if (!prepare_suspend_processes()) {
 
 		/* At this point, all user processes and "dangerous"
@@ -841,7 +256,7 @@
 
 static int sanity_check_failed(char *reason)
 {
-	printk(KERN_ERR "%s%s\n", name_resume, reason);
+	printk(KERN_ERR "%s%s\n", swsusp_name_resume, reason);
 	return -EPERM;
 }
 
@@ -889,17 +304,15 @@
 	BUG_ON(!buffer_uptodate(bh));
 	generic_make_request(WRITE, bh);
 	if (!buffer_uptodate(bh))
-		printk(KERN_CRIT "%sWarning %s: Fixing swap signatures unsuccessful...\n", name_resume, resume_file);
+		printk(KERN_CRIT "%sWarning %s: Fixing swap signatures unsuccessful...\n", swsusp_name_resume, resume_file);
 	wait_on_buffer(bh);
 	brelse(bh);
 	return 0;
 #endif
-	printk(KERN_CRIT "%sWarning %s: Fixing swap signatures unimplemented...\n", name_resume, resume_file);
+	printk(KERN_CRIT "%sWarning %s: Fixing swap signatures unimplemented...\n", swsusp_name_resume, resume_file);
 	return 0;
 }
 
-extern dev_t __init name_to_dev_t(const char *line);
-
 static int __init __read_suspend_image(struct block_device *bdev, union diskpage *cur, int noresume)
 {
 	swp_entry_t next;
@@ -914,7 +327,7 @@
 
 	if ((!memcmp("SWAP-SPACE",cur->swh.magic.magic,10)) ||
 	    (!memcmp("SWAPSPACE2",cur->swh.magic.magic,10))) {
-		printk(KERN_ERR "%sThis is normal swap space\n", name_resume );
+		printk(KERN_ERR "%sThis is normal swap space\n", swsusp_name_resume );
 		return -EINVAL;
 	}
 
@@ -928,18 +341,18 @@
 		if (noresume)
 			return -EINVAL;
 		panic("%sUnable to find suspended-data signature (%.10s - misspelled?\n", 
-			name_resume, cur->swh.magic.magic);
+			swsusp_name_resume, cur->swh.magic.magic);
 	}
 	if (noresume) {
 		/* We don't do a sanity check here: we want to restore the swap
 		   whatever version of kernel made the suspend image;
 		   We need to write swap, but swap is *not* enabled so
 		   we must write the device directly */
-		printk("%s: Fixing swap signatures %s...\n", name_resume, resume_file);
+		printk("%s: Fixing swap signatures %s...\n", swsusp_name_resume, resume_file);
 		bdev_write_page(bdev, 0, cur);
 	}
 
-	printk( "%sSignature found, resuming\n", name_resume );
+	printk( "%sSignature found, resuming\n", swsusp_name_resume );
 	MDELAY(1000);
 
 	if (bdev_read_page(bdev, next.val, cur)) return -EIO;
@@ -956,7 +369,7 @@
 	if (!pagedir_nosave)
 		return -ENOMEM;
 
-	PRINTK( "%sReading pagedir, ", name_resume );
+	PRINTK( "%sReading pagedir, ", swsusp_name_resume );
 
 	/* We get pages in reverse order of saving! */
 	for (i=nr_pgdir_pages-1; i>=0; i--) {
@@ -986,21 +399,37 @@
 	return 0;
 }
 
-static int read_suspend_image(const char * specialfile, int noresume)
+static int __init read_suspend_image(const char * specialfile, int noresume)
 {
 	union diskpage *cur;
 	unsigned long scratch_page = 0;
 	int error;
 	char b[BDEVNAME_SIZE];
+#ifdef MODULE
+	char *p;
+
+	swsusp_resume_device =
+		new_decode_dev(simple_strtoul(specialfile, &p, 16));
+	if (*p)
+		swsusp_resume_device = 0;
+#else
+	extern dev_t __init name_to_dev_t(const char *line);
 
-	resume_device = name_to_dev_t(specialfile);
+	swsusp_resume_device = name_to_dev_t(specialfile);
+#endif
+	if (!swsusp_resume_device) {
+		printk(KERN_ERR "%s%s: Invalid device\n", swsusp_name_resume,
+		       specialfile);
+		error = -EINVAL;
+		goto out;
+	}
 	scratch_page = get_zeroed_page(GFP_ATOMIC);
 	cur = (void *) scratch_page;
 	if (cur) {
 		struct block_device *bdev;
 		printk("Resuming from device %s\n",
-				__bdevname(resume_device, b));
-		bdev = open_by_devnum(resume_device, FMODE_READ);
+				__bdevname(swsusp_resume_device, b));
+		bdev = open_by_devnum(swsusp_resume_device, FMODE_READ);
 		if (IS_ERR(bdev)) {
 			error = PTR_ERR(bdev);
 		} else {
@@ -1019,17 +448,18 @@
 		case -EINVAL:
 			break;
 		case -EIO:
-			printk( "%sI/O error\n", name_resume);
+			printk( "%sI/O error\n", swsusp_name_resume);
 			break;
 		case -ENOENT:
-			printk( "%s%s: No such file or directory\n", name_resume, specialfile);
+			printk( "%s%s: No such file or directory\n", swsusp_name_resume, specialfile);
 			break;
 		case -ENOMEM:
-			printk( "%sNot enough memory\n", name_resume);
+			printk( "%sNot enough memory\n", swsusp_name_resume);
 			break;
 		default:
-			printk( "%sError %d resuming\n", name_resume, error );
+			printk( "%sError %d resuming\n", swsusp_name_resume, error );
 	}
+out:
 	MDELAY(1000);
 	return error;
 }
@@ -1053,11 +483,17 @@
 	}
 	/* We enable the possibility of machine suspend */
 	software_suspend_enabled = 1;
-	if (!resume_status)
+
+	down(&software_suspend_sem);
+	software_suspend_module = THIS_MODULE;
+	software_suspend_hook = software_suspend;
+	up(&software_suspend_sem);
+
+	if (!noresume && !resume_file[0])
 		return 0;
 
-	printk( "%s", name_resume );
-	if (resume_status == NORESUME) {
+	printk( "%s", swsusp_name_resume );
+	if (noresume) {
 		if(resume_file[0])
 			read_suspend_image(resume_file, 1);
 		printk( "disabled\n" );
@@ -1068,11 +504,6 @@
 	if (pm_prepare_console())
 		printk("swsusp: Can't allocate a console... proceeding\n");
 
-	if (!resume_file[0] && resume_status == RESUME_SPECIFIED) {
-		printk( "suspension device unspecified\n" );
-		return -EINVAL;
-	}
-
 	printk( "resuming from %s\n", resume_file);
 	if (read_suspend_image(resume_file, 0))
 		goto read_failure;
@@ -1085,27 +516,19 @@
 	return 0;
 }
 
-late_initcall(software_resume);
-
-static int __init resume_setup(char *str)
+static void __exit software_resume_exit(void)
 {
-	if (resume_status == NORESUME)
-		return 1;
-
-	strncpy( resume_file, str, 255 );
-	resume_status = RESUME_SPECIFIED;
-
-	return 1;
+	down(&software_suspend_sem);
+	software_suspend_module = 0;
+	up(&software_suspend_sem);
 }
 
-static int __init noresume_setup(char *str)
-{
-	resume_status = NORESUME;
-	return 1;
-}
+late_initcall(software_resume);
+module_exit(software_resume_exit);
+
+module_param(noresume, bool, 0);
+module_param_string(resume, resume_file, sizeof(resume_file), 0);
 
-__setup("noresume", noresume_setup);
-__setup("resume=", resume_setup);
+MODULE_LICENSE("GPL");
 
-EXPORT_SYMBOL(software_suspend);
 EXPORT_SYMBOL(software_suspend_enabled);
Index: kernel/power/swsusp.h
===================================================================
RCS file: kernel/power/swsusp.h
diff -N kernel/power/swsusp.h
--- /dev/null	1 Jan 1970 00:00:00 -0000
+++ b/kernel/power/swsusp.h	20 Apr 2004 12:01:31 -0000
@@ -0,0 +1,50 @@
+/*
+ * linux/kernel/power/swsusp.h
+ *
+ * Copyright (c) 2004 Herbert Xu <herbert@debian.org>
+ *
+ * This file is licensed under the GPLv2.
+ */
+
+#include <linux/delay.h>
+#include <linux/kernel.h>
+#include <linux/suspend.h>
+#include <linux/types.h>
+
+struct link {
+	char dummy[PAGE_SIZE - sizeof(swp_entry_t)];
+	swp_entry_t next;
+};
+
+union diskpage {
+	union swap_header swh;
+	struct link link;
+	struct suspend_header sh;
+};
+
+extern dev_t swsusp_resume_device;
+extern const char swsusp_name_suspend[];
+extern const char swsusp_name_resume[];
+
+extern suspend_pagedir_t *pagedir_save;
+extern int pagedir_order;
+
+/*
+ * Debug
+ */
+#define	DEBUG_DEFAULT
+#undef	DEBUG_PROCESS
+#undef	DEBUG_SLOW
+#define TEST_SWSUSP 0		/* Set to 1 to reboot instead of halt machine after suspension */
+
+#ifdef DEBUG_DEFAULT
+# define PRINTK(f, a...)       printk(f, ## a)
+#else
+# define PRINTK(f, a...)
+#endif
+
+#ifdef DEBUG_SLOW
+#define MDELAY(a) mdelay(a)
+#else
+#define MDELAY(a)
+#endif
Index: mm/vmscan.c
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.5/mm/vmscan.c,v
retrieving revision 1.1.1.16
diff -u -r1.1.1.16 vmscan.c
--- a/mm/vmscan.c	5 Apr 2004 09:49:44 -0000	1.1.1.16
+++ b/mm/vmscan.c	20 Apr 2004 12:58:08 -0000
@@ -1102,6 +1102,8 @@
 	current->reclaim_state = NULL;
 	return ret;
 }
+
+EXPORT_SYMBOL(shrink_all_memory);
 #endif
 
 #ifdef CONFIG_HOTPLUG_CPU

--RnlQjJ0d97Da+TV1--
