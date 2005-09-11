Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964983AbVIKRoe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964983AbVIKRoe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 13:44:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964987AbVIKRoe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 13:44:34 -0400
Received: from xenotime.net ([66.160.160.81]:41096 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S964983AbVIKRoe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 13:44:34 -0400
Date: Sun, 11 Sep 2005 10:44:31 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>
Subject: [PATCH] use add_taint() for setting tainted bit flags
Message-Id: <20050911104431.1d755c4e.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Use the add_taint() interface for setting tainted bit flags
instead of doing it manually.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---

 arch/i386/kernel/smpboot.c |    2 +-
 arch/x86_64/kernel/mce.c   |    2 +-
 kernel/module.c            |   11 ++++++-----
 mm/page_alloc.c            |    3 ++-
 4 files changed, 10 insertions(+), 8 deletions(-)

diff -Naurp linux-2613-git10/arch/i386/kernel/smpboot.c~use_add_taint linux-2613-git10/arch/i386/kernel/smpboot.c
--- linux-2613-git10/arch/i386/kernel/smpboot.c~use_add_taint	2005-09-10 19:29:17.000000000 -0700
+++ linux-2613-git10/arch/i386/kernel/smpboot.c	2005-09-10 21:23:23.000000000 -0700
@@ -202,7 +202,7 @@ static void __devinit smp_store_cpu_info
 				goto valid_k7;
 
 		/* If we get here, it's not a certified SMP capable AMD system. */
-		tainted |= TAINT_UNSAFE_SMP;
+		add_taint(TAINT_UNSAFE_SMP);
 	}
 
 valid_k7:
diff -Naurp linux-2613-git10/arch/x86_64/kernel/mce.c~use_add_taint linux-2613-git10/arch/x86_64/kernel/mce.c
--- linux-2613-git10/arch/x86_64/kernel/mce.c~use_add_taint	2005-08-28 16:41:01.000000000 -0700
+++ linux-2613-git10/arch/x86_64/kernel/mce.c	2005-09-10 21:22:24.000000000 -0700
@@ -212,7 +212,7 @@ void do_machine_check(struct pt_regs * r
 			panicm_found = 1;
 		}
 
-		tainted |= TAINT_MACHINE_CHECK;
+		add_taint(TAINT_MACHINE_CHECK);
 	}
 
 	/* Never do anything final in the polling timer */
diff -Naurp linux-2613-git10/kernel/module.c~use_add_taint linux-2613-git10/kernel/module.c
--- linux-2613-git10/kernel/module.c~use_add_taint	2005-09-10 19:29:27.000000000 -0700
+++ linux-2613-git10/kernel/module.c	2005-09-10 21:19:21.000000000 -0700
@@ -20,6 +20,7 @@
 #include <linux/module.h>
 #include <linux/moduleloader.h>
 #include <linux/init.h>
+#include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/elf.h>
@@ -498,7 +499,7 @@ static inline int try_force(unsigned int
 {
 	int ret = (flags & O_TRUNC);
 	if (ret)
-		tainted |= TAINT_FORCED_MODULE;
+		add_taint(TAINT_FORCED_MODULE);
 	return ret;
 }
 #else
@@ -897,7 +898,7 @@ static int check_version(Elf_Shdr *sechd
 	if (!(tainted & TAINT_FORCED_MODULE)) {
 		printk("%s: no version for \"%s\" found: kernel tainted.\n",
 		       mod->name, symname);
-		tainted |= TAINT_FORCED_MODULE;
+		add_taint(TAINT_FORCED_MODULE);
 	}
 	return 1;
 }
@@ -1352,7 +1353,7 @@ static void set_license(struct module *m
 	if (!mod->license_gplok && !(tainted & TAINT_PROPRIETARY_MODULE)) {
 		printk(KERN_WARNING "%s: module license '%s' taints kernel.\n",
 		       mod->name, license);
-		tainted |= TAINT_PROPRIETARY_MODULE;
+		add_taint(TAINT_PROPRIETARY_MODULE);
 	}
 }
 
@@ -1610,7 +1611,7 @@ static struct module *load_module(void _
 	modmagic = get_modinfo(sechdrs, infoindex, "vermagic");
 	/* This is allowed: modprobe --force will invalidate it. */
 	if (!modmagic) {
-		tainted |= TAINT_FORCED_MODULE;
+		add_taint(TAINT_FORCED_MODULE);
 		printk(KERN_WARNING "%s: no version magic, tainting kernel.\n",
 		       mod->name);
 	} else if (!same_magic(modmagic, vermagic)) {
@@ -1739,7 +1740,7 @@ static struct module *load_module(void _
 	    (mod->num_gpl_syms && !gplcrcindex)) {
 		printk(KERN_WARNING "%s: No versions for exported symbols."
 		       " Tainting kernel.\n", mod->name);
-		tainted |= TAINT_FORCED_MODULE;
+		add_taint(TAINT_FORCED_MODULE);
 	}
 #endif
 
diff -Naurp linux-2613-git10/mm/page_alloc.c~use_add_taint linux-2613-git10/mm/page_alloc.c
--- linux-2613-git10/mm/page_alloc.c~use_add_taint	2005-09-10 19:29:27.000000000 -0700
+++ linux-2613-git10/mm/page_alloc.c	2005-09-10 21:21:37.000000000 -0700
@@ -22,6 +22,7 @@
 #include <linux/pagemap.h>
 #include <linux/bootmem.h>
 #include <linux/compiler.h>
+#include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/suspend.h>
 #include <linux/pagevec.h>
@@ -117,7 +118,7 @@ static void bad_page(const char *functio
 	set_page_count(page, 0);
 	reset_page_mapcount(page);
 	page->mapping = NULL;
-	tainted |= TAINT_BAD_PAGE;
+	add_taint(TAINT_BAD_PAGE);
 }
 
 #ifndef CONFIG_HUGETLB_PAGE

---
