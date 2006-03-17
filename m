Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752505AbWCQBa1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752505AbWCQBa1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 20:30:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752501AbWCQBa1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 20:30:27 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:8636 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1752516AbWCQBaZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 20:30:25 -0500
Subject: [RFC][PATCH] warn when statically-allocated kobjects are used
To: linux-kernel@vger.kernel.org
Cc: gregkh@suse.de, Dave Hansen <haveblue@us.ibm.com>
From: Dave Hansen <haveblue@us.ibm.com>
Date: Thu, 16 Mar 2006 17:30:16 -0800
Message-Id: <20060317013016.5C643E69@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


One of the top ten sysfs problems is that users use statically
allocated kobjects.  This patch reminds them that this is a
naughty thing.

One _really_ nice thing this patch does, is us the kallsyms
mechanism to print out exactly which symbol is being complained
about:

The kobject at, or inside devices_subsys+0x14/0x60 is not dynamically allocated.

There are not very many architectures that actually place a
_sdata or _data symbol in their vmlinux.lds.S.  This patch
causes link errors in all these cases.  Is there an
alternative symbol that we can use, or can we use weak
symbols and detect them, so that they are at least skipped?

Does kernel/kallsyms.c:is_kernel() do the trick, so that we
don't need to use the asm-generic/sections.h variables at all?

---

 mm/memory.c                              |    0 
 work-dave/arch/i386/kernel/vmlinux.lds.S |    2 +
 work-dave/lib/kobject.c                  |   35 +++++++++++++++++++++++++++++++
 3 files changed, 37 insertions(+)

diff -puN arch/i386/kernel/vmlinux.lds.S~kobject-static-work arch/i386/kernel/vmlinux.lds.S
--- work/arch/i386/kernel/vmlinux.lds.S~kobject-static-work	2006-03-16 17:24:46.000000000 -0800
+++ work-dave/arch/i386/kernel/vmlinux.lds.S	2006-03-16 17:24:46.000000000 -0800
@@ -35,6 +35,8 @@ SECTIONS
   __ex_table : AT(ADDR(__ex_table) - LOAD_OFFSET) { *(__ex_table) }
   __stop___ex_table = .;
 
+  _sdata = .;			/* End of text section */
+
   RODATA
 
   /* writeable */
diff -puN lib/kobject.c~kobject-static-work lib/kobject.c
--- work/lib/kobject.c~kobject-static-work	2006-03-16 17:24:46.000000000 -0800
+++ work-dave/lib/kobject.c	2006-03-16 17:24:46.000000000 -0800
@@ -15,6 +15,8 @@
 #include <linux/module.h>
 #include <linux/stat.h>
 #include <linux/slab.h>
+#include <linux/kallsyms.h>
+#include <asm-generic/sections.h>
 
 /**
  *	populate_dir - populate directory with attributes.
@@ -120,12 +122,45 @@ char *kobject_get_path(struct kobject *k
 	return path;
 }
 
+static int ptr_in_range(void *ptr, void *start, void *end)
+{
+	/*
+	 * This should hopefully get rid of causing warnings
+	 * if the architecture did not set one of the section
+	 * variables up.
+	 */
+	if (start >= end)
+		return 0;
+
+	if ((ptr >= start) && (ptr < end))
+		return 1;
+	return 0;
+}
+
+static void verify_dynamic_kobject_allocation(struct kobject *kobj)
+{
+	if (ptr_in_range(kobj, &_data[0], &_edata[0]))
+		goto warn;
+	if (ptr_in_range(kobj, &__bss_start[0], &__bss_stop[0]))
+		goto warn;
+	return;
+warn:
+	printk("---- begin silly warning ----\n");
+	printk("This is a janitorial warning, not a kernel bug.\n");
+	print_symbol("The kobject at, or inside %s is not dynamically allocated.\n",
+			(unsigned long)kobj);
+	printk("kobjects must be dynamically allocated, not static\n");
+	dump_stack();
+	printk("---- end silly warning ----\n");
+}
+
 /**
  *	kobject_init - initialize object.
  *	@kobj:	object in question.
  */
 void kobject_init(struct kobject * kobj)
 {
+	verify_dynamic_kobject_allocation(kobj);
 	kref_init(&kobj->kref);
 	INIT_LIST_HEAD(&kobj->entry);
 	kobj->kset = kset_get(kobj->kset);
diff -L kernel/Ma -puN /dev/null /dev/null
diff -puN kernel/Makefile~kobject-static-work kernel/Makefile
diff -puN kernel/kallsyms.c~kobject-static-work kernel/kallsyms.c
diff -puN mm/memory.c~kobject-static-work mm/memory.c
_
