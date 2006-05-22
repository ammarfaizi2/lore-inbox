Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751178AbWEVUnB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751178AbWEVUnB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 16:43:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751177AbWEVUnB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 16:43:01 -0400
Received: from THUNK.ORG ([69.25.196.29]:9394 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1751178AbWEVUnA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 16:43:00 -0400
Date: Mon, 22 May 2006 14:33:52 -0400
From: Theodore Tso <tytso@mit.edu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add user taint flag
Message-ID: <20060522183352.GA4453@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <E1FhwyO-0001YQ-O1@candygram.thunk.org> <20060522033644.26d47a00.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060522033644.26d47a00.akpm@osdl.org>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2006 at 03:36:44AM -0700, Andrew Morton wrote:
> "Theodore Ts'o" <tytso@mit.edu> wrote:
> > Allow taint flags to be set from userspace by writing to
> > /proc/sys/kernel/tainted, and add a new taint flag, TAINT_USER, to be
> > used when userspace is potentially doing something naughty that might
> > compromise the kernel.
> 
> What sort of userspace actions are you thinking of here?

You don't really want to know.  No, really.  :-)

> And how is other userspace to detect what the naughty userspace is doing?

When the kernel returns a panic or an Oops, then we'll know something
bad had happened....

> Someone's done something and you're not telling us what it was ;)

OK, OK.  See the attached patch.  Note especially the
NOT-Signed-off-by....  I am not expecting nor requesting this to get
anywhere near mainline.

The problem is that the Real-Time Specification for Java (RTSJ)
**requires** that the JVM provide class functions which provide direct
access to physical memory; all physical memory.  In fact, the RTSJ
compliance test explicitly checks for this; it requires that you give
the compliance test the address of a few hundred megs of physical
memory for the test.  The absolutely hilarious bit about all of this
is that the same customer who wants RTSJ compliance because of federal
procurement regulations is also interested in using SELinux.  We've
told them that actually using this feature of RTSJ is incompatible
with their security needs, and that on production systems they should
delete the rmem module from their configured systems.  However, it
must be present in order to demonstrate RTSJ compliance.  

Blame Sun for this insanity, especially since there is no documented
way to actually determine which physical memory address are safe to
use with this facility --- so any use of this particular RTSJ class
*guarantees* that the Java program will be completely non-portable.

So if something does actually use the rmem device, it the rmem module
(see below) sets the user TAINT flag, for the same reason that we want
to set the taint flag after loading a module from ATI or NVidia.
Technically speaking, we don't need to be able to set it via the /proc
interface, but it seems like a useful thing that could be useful for
other applications.

The basic idea as far as debuging is concerned when someone posts an
oops on LKML is the same as any other taint flag; if you see that it
came from a tainted kernel, you know not to waste any time looking at
the oops.  If this goes to our support people, they will know to ask
for the JVM log files, which will show the use of this nasty RTSJ
capability, and they will know to ask the right questions.

> > +	if (!capable(CAP_SYS_ADMIN)) {
> > +		return -EPERM;
> > +	}
> 
> Aren't the /proc file permissions sufficient?

Well, that would mean that anyone with CAP_DAC_OVERRIDE would be able
to raise the taint level.  I think CAP_SYS_ADMIN is actually the
better capability; we do something similar with
/proc/sys/kernel/cap-bound, which requires CAP_SYS_MODULE.



						- Ted

These two kernel modules are needed for use by the TCK conformance
test which tests the JVM's RTSJ implementation.  Unfortunately, RTSJ
requires that Java programs have direct access to physical memory, and
/dev/mem does not allow mmap to work to anything beyond I/O mapped
memory regions on the x86 platform.  Since this is a spectacularly bad
idea (so much for write once, debug everywhere) and could potentially
destablize the kernel, set the TAINT_USER flag if available.

Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>

Index: 2.6.15-rc6/drivers/char/Kconfig
===================================================================
--- 2.6.15-rc6.orig/drivers/char/Kconfig	2005-12-24 15:52:06.000000000 -0500
+++ 2.6.15-rc6/drivers/char/Kconfig	2005-12-24 15:52:13.000000000 -0500
@@ -1013,5 +1013,23 @@
 	  sysfs directory, /sys/devices/platform/telco_clock, with a number of
 	  files for controlling the behavior of this hardware.
 
+config ALLOC_RTSJ_MEM
+	tristate "RTSJ-specific hack to reserve memory"
+	default m
+	help
+	  The RTSJ TCK conformance test requires reserving some physical
+	  memory for testing /dev/rmem.
+
+config RMEM
+	tristate "Access to physical memory via /dev/rmem"
+	default m
+	help
+	  The /dev/mem device only allows mmap() memory availble to
+	  I/O mapped memory; it does not allow access to "real"
+	  physical memory.  The /dev/rmem device is a hack which does
+	  allow access to physical memory.  We use this instead of
+	  patching /dev/mem because we don't expect this functionality
+	  to ever be accepted into mainline.
+
 endmenu
 
Index: 2.6.15-rc6/drivers/char/Makefile
===================================================================
--- 2.6.15-rc6.orig/drivers/char/Makefile	2005-12-24 15:52:06.000000000 -0500
+++ 2.6.15-rc6/drivers/char/Makefile	2005-12-24 15:52:13.000000000 -0500
@@ -93,6 +93,10 @@
 
 obj-$(CONFIG_HANGCHECK_TIMER) += hangcheck-timer.o
 obj-$(CONFIG_TCG_TPM) += tpm/
+
+obj-$(CONFIG_ALLOC_RTSJ_MEM) += alloc_rtsj_mem.o
+obj-$(CONFIG_RMEM) += rmem.o
+
 # Files generated that shall be removed upon make clean
 clean-files := consolemap_deftbl.c defkeymap.c qtronixmap.c
 
Index: 2.6.15-rc6/drivers/char/alloc_rtsj_mem.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ 2.6.15-rc6/drivers/char/alloc_rtsj_mem.c	2005-12-24 18:10:57.000000000 -0500
@@ -0,0 +1,88 @@
+/*
+ *  alloc_rtsj_mem.c -- Hack to allocate some memory
+ *
+ *  Copyright (C) 2005 by Theodore Ts'o
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/sysctl.h>
+#include <linux/bootmem.h>
+
+#include <asm/io.h>
+
+MODULE_AUTHOR("Theodore Tso");
+MODULE_DESCRIPTION("RTSJ alloc memory");
+MODULE_LICENSE("GPL");
+
+static void *mem = 0;
+int size = 0, addr = 0;
+
+module_param(size, int, 0444);
+module_param(addr, int, 0444);
+
+static void __exit shutdown_module(void)
+{
+	kfree(mem);
+}
+
+#ifndef MODULE
+void __init alloc_rtsj_mem_early_setup(void)
+{
+	if (size > PAGE_SIZE*2) {
+		mem = alloc_bootmem(size);
+		if (mem) {
+			printk(KERN_INFO "alloc_rtsj_mem: got %d bytes "
+			       "using alloc_bootmem\n", size);
+		} else {
+			printk(KERN_INFO "alloc_rtsj_mem: failed to "
+			       "get %d bytes from alloc_bootmem\n", size);
+		}
+	}
+}
+#endif
+
+static int __init startup_module(void)
+{
+	static char test_string[] = "The BOFH: Servicing users the way the "
+		"military\n\tservices targets for 15 years.\n";
+
+	if (!size)
+		return 0;
+
+	if (!mem) {
+		mem = kmalloc(size, GFP_KERNEL);
+		if (mem) {
+			printk(KERN_INFO "alloc_rtsj_mem: got %d bytes "
+			       "using kmalloc\n", size);
+		} else {
+			printk(KERN_ERR "alloc_rtsj_mem: failed to get "
+			       "%d bytes using kmalloc\n", size);
+			return -ENOMEM;
+		}
+	}
+	memcpy(mem, test_string, min(sizeof(test_string), (size_t) size));
+	addr = virt_to_phys(mem);
+	return 0;
+}
+
+module_init(startup_module);
+module_exit(shutdown_module);
+
Index: 2.6.15-rc6/drivers/char/rmem.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ 2.6.15-rc6/drivers/char/rmem.c	2005-12-24 15:52:13.000000000 -0500
@@ -0,0 +1,135 @@
+/*
+ * Rmem - REALLY simple memory mapping demonstration.
+ *
+ *  Copyright (C) 2005 by Theodore Ts'o
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/init.h>
+
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/fs.h>
+#include <linux/errno.h>
+#include <linux/types.h>
+#include <linux/mm.h>
+#include <linux/kdev_t.h>
+#include <asm/page.h>
+#include <linux/cdev.h>
+#include <linux/device.h>
+
+static int rmem_major = 0;
+module_param(rmem_major, int, 0444);
+
+static struct class *rmem_class;
+
+MODULE_AUTHOR("Theodore Ts'o");
+MODULE_LICENSE("GPL");
+
+struct page *rmem_vma_nopage(struct vm_area_struct *vma,
+                unsigned long address, int *type)
+{
+	struct page *pageptr;
+	unsigned long offset = vma->vm_pgoff << PAGE_SHIFT;
+	unsigned long physaddr = address - vma->vm_start + offset;
+	unsigned long pageframe = physaddr >> PAGE_SHIFT;
+
+	if (!pfn_valid(pageframe))
+		return NOPAGE_SIGBUS;
+	pageptr = pfn_to_page(pageframe);
+	get_page(pageptr);
+	if (type)
+		*type = VM_FAULT_MINOR;
+	return pageptr;
+}
+
+static struct vm_operations_struct rmem_nopage_vm_ops = {
+	.nopage = rmem_vma_nopage,
+};
+
+static int rmem_nopage_mmap(struct file *filp, struct vm_area_struct *vma)
+{
+	unsigned long offset = vma->vm_pgoff << PAGE_SHIFT;
+
+	if (offset >= __pa(high_memory) || (filp->f_flags & O_SYNC))
+		vma->vm_flags |= VM_IO;
+	vma->vm_flags |= VM_RESERVED;
+	vma->vm_ops = &rmem_nopage_vm_ops;
+#ifdef TAINT_USER
+	add_taint(TAINT_USER);
+#endif
+	return 0;
+}
+
+static struct file_operations rmem_nopage_ops = {
+	.owner   = THIS_MODULE,
+	.mmap    = rmem_nopage_mmap,
+};
+
+static struct cdev rmem_cdev = {
+	.kobj	=	{.name = "rmem", },
+	.owner	=	THIS_MODULE,
+};
+
+static int __init rmem_init(void)
+{
+	int result;
+	dev_t dev = MKDEV(rmem_major, 0);
+
+	/* Figure out our device number. */
+	if (rmem_major)
+		result = register_chrdev_region(dev, 1, "rmem");
+	else {
+		result = alloc_chrdev_region(&dev, 0, 1, "rmem");
+		rmem_major = MAJOR(dev);
+	}
+	if (result < 0) {
+		printk(KERN_WARNING "rmem: unable to get major %d\n", rmem_major);
+		return result;
+	}
+	if (rmem_major == 0)
+		rmem_major = result;
+
+	cdev_init(&rmem_cdev, &rmem_nopage_ops);
+	result = cdev_add(&rmem_cdev, dev, 1);
+	if (result) {
+		printk (KERN_NOTICE "Error %d adding /dev/rmem", result);
+		kobject_put(&rmem_cdev.kobj);
+		unregister_chrdev_region(dev, 1);
+		return 1;
+	}
+
+	rmem_class = class_create(THIS_MODULE, "rmem");
+	class_device_create(rmem_class, dev, NULL, "rmem");
+
+	return 0;
+}
+
+
+static void __exit rmem_cleanup(void)
+{
+	cdev_del(&rmem_cdev);
+	unregister_chrdev_region(MKDEV(rmem_major, 0), 1);
+	class_destroy(rmem_class);
+}
+
+
+module_init(rmem_init);
+module_exit(rmem_cleanup);
Index: 2.6.15-rc6/init/main.c
===================================================================
--- 2.6.15-rc6.orig/init/main.c	2005-12-24 15:52:13.000000000 -0500
+++ 2.6.15-rc6/init/main.c	2005-12-24 19:17:49.000000000 -0500
@@ -100,6 +100,12 @@
 #else
 static inline void acpi_early_init(void) { }
 #endif
+#ifdef CONFIG_ALLOC_RTSJ_MEM
+extern void alloc_rtsj_mem_early_setup(void);
+#else
+static inline void alloc_rtsj_mem_early_setup(void) { }
+#endif
+
 
 #ifdef CONFIG_TC
 extern void tc_init(void);
@@ -509,6 +515,7 @@
 	}
 #endif
 	vfs_caches_init_early();
+	alloc_rtsj_mem_early_setup();
 	mem_init();
 	kmem_cache_init();
 	setup_per_cpu_pageset();
