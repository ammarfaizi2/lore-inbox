Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263761AbUGQXUC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263761AbUGQXUC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jul 2004 19:20:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263806AbUGQWvr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jul 2004 18:51:47 -0400
Received: from digitalimplant.org ([64.62.235.95]:22249 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S262380AbUGQWfD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jul 2004 18:35:03 -0400
Date: Sat, 17 Jul 2004 15:34:53 -0700 (PDT)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: linux-kernel@vger.kernel.org
cc: pavel@ucw.cz
Subject: [4/25] Merge pmdisk and swsusp
Message-ID: <Pine.LNX.4.50.0407171527500.22290-100000@monsoon.he.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ChangeSet 1.1846, 2004/07/17 09:25:59-07:00, mochel@digitalimplant.org

[Power Mgmt] Share variables between pmdisk and swsusp.

- In pmdisk, change pm_pagedir_nosave back to pagedir_nosave, and
  pmdisk_pages back to nr_copy_pages.
- Mark them, and other page count/pagedir variables extern.
- Make sure they're not static in swsusp.
- Remove mention from include/linux/suspend.h, since no one else needs them.


 arch/i386/power/pmdisk.S |    4 +-
 include/linux/suspend.h  |    3 -
 kernel/power/pmdisk.c    |   76 +++++++++++++++++++++++------------------------
 kernel/power/swsusp.c    |    8 ++--
 4 files changed, 44 insertions(+), 47 deletions(-)


diff -Nru a/arch/i386/power/pmdisk.S b/arch/i386/power/pmdisk.S
--- a/arch/i386/power/pmdisk.S	2004-07-17 14:51:44 -07:00
+++ b/arch/i386/power/pmdisk.S	2004-07-17 14:51:44 -07:00
@@ -24,7 +24,7 @@
 	movl $swsusp_pg_dir-__PAGE_OFFSET,%ecx
 	movl %ecx,%cr3

-	movl	pm_pagedir_nosave,%ebx
+	movl	pagedir_nosave,%ebx
 	xorl	%eax, %eax
 	xorl	%edx, %edx
 	.p2align 4,,7
@@ -41,7 +41,7 @@

 	incl	%eax
 	addl	$16, %edx
-	cmpl	pmdisk_pages,%eax
+	cmpl	nr_copy_pages,%eax
 	jb .L1455
 	.p2align 4,,7
 .L1453:
diff -Nru a/include/linux/suspend.h b/include/linux/suspend.h
--- a/include/linux/suspend.h	2004-07-17 14:51:44 -07:00
+++ b/include/linux/suspend.h	2004-07-17 14:51:44 -07:00
@@ -45,9 +45,6 @@
 /* kernel/power/swsusp.c */
 extern int software_suspend(void);

-extern unsigned int nr_copy_pages __nosavedata;
-extern suspend_pagedir_t *pagedir_nosave __nosavedata;
-
 #else	/* CONFIG_SOFTWARE_SUSPEND */
 static inline int software_suspend(void)
 {
diff -Nru a/kernel/power/pmdisk.c b/kernel/power/pmdisk.c
--- a/kernel/power/pmdisk.c	2004-07-17 14:51:44 -07:00
+++ b/kernel/power/pmdisk.c	2004-07-17 14:51:44 -07:00
@@ -47,15 +47,15 @@
 extern int is_head_of_free_region(struct page *);

 /* Variables to be preserved over suspend */
-static int pagedir_order_check;
-static int nr_copy_pages_check;
+extern int pagedir_order_check;
+extern int nr_copy_pages_check;

 /* For resume= kernel option */
 static char resume_file[256] = CONFIG_PM_DISK_PARTITION;

 static dev_t resume_device;
 /* Local variables that should not be affected by save */
-unsigned int pmdisk_pages __nosavedata = 0;
+extern unsigned int nr_copy_pages;

 /* Suspend pagedir is allocated before final copy, therefore it
    must be freed after resume
@@ -66,9 +66,9 @@
    allocated at time of resume, that travels through memory not to
    collide with anything.
  */
-suspend_pagedir_t *pm_pagedir_nosave __nosavedata = NULL;
-static suspend_pagedir_t *pagedir_save;
-static int pagedir_order __nosavedata = 0;
+extern suspend_pagedir_t *pagedir_nosave;
+extern suspend_pagedir_t *pagedir_save;
+extern int pagedir_order;


 struct pmdisk_info {
@@ -184,13 +184,13 @@
 	swp_entry_t entry;
 	int i;

-	for (i = 0; i < pmdisk_pages; i++) {
-		entry = (pm_pagedir_nosave + i)->swap_address;
+	for (i = 0; i < nr_copy_pages; i++) {
+		entry = (pagedir_nosave + i)->swap_address;
 		if (entry.val)
 			swap_free(entry);
 		else
 			break;
-		(pm_pagedir_nosave + i)->swap_address = (swp_entry_t){0};
+		(pagedir_nosave + i)->swap_address = (swp_entry_t){0};
 	}
 }

@@ -206,12 +206,12 @@
 	int error = 0;
 	int i;

-	printk( "Writing data to swap (%d pages): ", pmdisk_pages );
-	for (i = 0; i < pmdisk_pages && !error; i++) {
+	printk( "Writing data to swap (%d pages): ", nr_copy_pages );
+	for (i = 0; i < nr_copy_pages && !error; i++) {
 		if (!(i%100))
 			printk( "." );
-		error = write_swap_page((pm_pagedir_nosave+i)->address,
-					&((pm_pagedir_nosave+i)->swap_address));
+		error = write_swap_page((pagedir_nosave+i)->address,
+					&((pagedir_nosave+i)->swap_address));
 	}
 	printk(" %d Pages done.\n",i);
 	return error;
@@ -239,9 +239,9 @@

 static int write_pagedir(void)
 {
-	unsigned long addr = (unsigned long)pm_pagedir_nosave;
+	unsigned long addr = (unsigned long)pagedir_nosave;
 	int error = 0;
-	int n = SUSPEND_PD_PAGES(pmdisk_pages);
+	int n = SUSPEND_PD_PAGES(nr_copy_pages);
 	int i;

 	pmdisk_info.pagedir_pages = n;
@@ -282,7 +282,7 @@
 	memcpy(&pmdisk_info.uts,&system_utsname,sizeof(system_utsname));

 	pmdisk_info.cpus = num_online_cpus();
-	pmdisk_info.image_pages = pmdisk_pages;
+	pmdisk_info.image_pages = nr_copy_pages;
 }

 /**
@@ -396,7 +396,7 @@
 		if (saveable(&pfn))
 			n++;
 	}
-	pmdisk_pages = n;
+	nr_copy_pages = n;
 }


@@ -424,7 +424,7 @@
 			p++;
 		}
 	}
-	BUG_ON(n != pmdisk_pages);
+	BUG_ON(n != nr_copy_pages);
 }


@@ -437,7 +437,7 @@
 	struct pbe * p;
 	int i;

-	for (i = 0, p = pagedir_save; i < pmdisk_pages; i++, p++) {
+	for (i = 0, p = pagedir_save; i < nr_copy_pages; i++, p++) {
 		ClearPageNosave(virt_to_page(p->address));
 		free_page(p->address);
 	}
@@ -460,13 +460,13 @@
 	int diff;
 	int order;

-	order = get_bitmask_order(SUSPEND_PD_PAGES(pmdisk_pages));
-	pmdisk_pages += 1 << order;
+	order = get_bitmask_order(SUSPEND_PD_PAGES(nr_copy_pages));
+	nr_copy_pages += 1 << order;
 	do {
-		diff = get_bitmask_order(SUSPEND_PD_PAGES(pmdisk_pages)) - order;
+		diff = get_bitmask_order(SUSPEND_PD_PAGES(nr_copy_pages)) - order;
 		if (diff) {
 			order += diff;
-			pmdisk_pages += 1 << diff;
+			nr_copy_pages += 1 << diff;
 		}
 	} while(diff);
 	pagedir_order = order;
@@ -488,7 +488,7 @@
 	if(!pagedir_save)
 		return -ENOMEM;
 	memset(pagedir_save,0,(1 << pagedir_order) * PAGE_SIZE);
-	pm_pagedir_nosave = pagedir_save;
+	pagedir_nosave = pagedir_save;
 	return 0;
 }

@@ -503,7 +503,7 @@
 	struct pbe * p;
 	int i;

-	for (i = 0, p = pagedir_save; i < pmdisk_pages; i++, p++) {
+	for (i = 0, p = pagedir_save; i < nr_copy_pages; i++, p++) {
 		p->address = get_zeroed_page(GFP_ATOMIC | __GFP_COLD);
 		if(!p->address)
 			goto Error;
@@ -529,7 +529,7 @@

 static int enough_free_mem(void)
 {
-	if(nr_free_pages() < (pmdisk_pages + PAGES_FOR_IO)) {
+	if(nr_free_pages() < (nr_copy_pages + PAGES_FOR_IO)) {
 		pr_debug("pmdisk: Not enough free pages: Have %d\n",
 			 nr_free_pages());
 		return 0;
@@ -553,7 +553,7 @@
 	struct sysinfo i;

 	si_swapinfo(&i);
-	if (i.freeswap < (pmdisk_pages + PAGES_FOR_IO))  {
+	if (i.freeswap < (nr_copy_pages + PAGES_FOR_IO))  {
 		pr_debug("pmdisk: Not enough swap. Need %ld\n",i.freeswap);
 		return 0;
 	}
@@ -582,12 +582,12 @@

 	drain_local_pages();

-	pm_pagedir_nosave = NULL;
+	pagedir_nosave = NULL;
 	pr_debug("pmdisk: Counting pages to copy.\n" );
 	count_pages();

 	pr_debug("pmdisk: (pages needed: %d + %d free: %d)\n",
-		 pmdisk_pages,PAGES_FOR_IO,nr_free_pages());
+		 nr_copy_pages,PAGES_FOR_IO,nr_free_pages());

 	if (!enough_free_mem())
 		return -ENOMEM;
@@ -605,7 +605,7 @@
 		return error;
 	}

-	nr_copy_pages_check = pmdisk_pages;
+	nr_copy_pages_check = nr_copy_pages;
 	pagedir_order_check = pagedir_order;

 	/* During allocating of suspend pagedir, new cold pages may appear.
@@ -622,7 +622,7 @@
 	 * touch swap space! Except we must write out our image of course.
 	 */

-	pr_debug("pmdisk: %d pages copied\n", pmdisk_pages );
+	pr_debug("pmdisk: %d pages copied\n", nr_copy_pages );
 	return 0;
 }

@@ -657,7 +657,7 @@

 int pmdisk_resume(void)
 {
-	BUG_ON (nr_copy_pages_check != pmdisk_pages);
+	BUG_ON (nr_copy_pages_check != nr_copy_pages);
 	BUG_ON (pagedir_order_check != pagedir_order);

 	/* Even mappings of "global" things (vmalloc) need to be fixed */
@@ -838,7 +838,7 @@
 		printk(KERN_ERR "pmdisk: Resume mismatch: %s\n",reason);
 		return -EPERM;
 	}
-	pmdisk_pages = pmdisk_info.image_pages;
+	nr_copy_pages = pmdisk_info.image_pages;
 	return error;
 }

@@ -854,7 +854,7 @@
 	addr =__get_free_pages(GFP_ATOMIC, pagedir_order);
 	if (!addr)
 		return -ENOMEM;
-	pm_pagedir_nosave = (struct pbe *)addr;
+	pagedir_nosave = (struct pbe *)addr;

 	pr_debug("pmdisk: Reading pagedir (%d Pages)\n",n);

@@ -866,7 +866,7 @@
 			error = -EFAULT;
 	}
 	if (error)
-		free_pages((unsigned long)pm_pagedir_nosave,pagedir_order);
+		free_pages((unsigned long)pagedir_nosave,pagedir_order);
 	return error;
 }

@@ -884,8 +884,8 @@
 	int error = 0;
 	int i;

-	printk( "Reading image data (%d pages): ", pmdisk_pages );
-	for(i = 0, p = pm_pagedir_nosave; i < pmdisk_pages && !error; i++, p++) {
+	printk( "Reading image data (%d pages): ", nr_copy_pages );
+	for(i = 0, p = pagedir_nosave; i < nr_copy_pages && !error; i++, p++) {
 		if (!(i%100))
 			printk( "." );
 		error = read_page(swp_offset(p->swap_address),
@@ -913,7 +913,7 @@
  Done:
 	return error;
  FreePagedir:
-	free_pages((unsigned long)pm_pagedir_nosave,pagedir_order);
+	free_pages((unsigned long)pagedir_nosave,pagedir_order);
 	goto Done;
 }

diff -Nru a/kernel/power/swsusp.c b/kernel/power/swsusp.c
--- a/kernel/power/swsusp.c	2004-07-17 14:51:44 -07:00
+++ b/kernel/power/swsusp.c	2004-07-17 14:51:44 -07:00
@@ -84,8 +84,8 @@
 spinlock_t suspend_pagedir_lock __nosavedata = SPIN_LOCK_UNLOCKED;

 /* Variables to be preserved over suspend */
-static int pagedir_order_check;
-static int nr_copy_pages_check;
+int pagedir_order_check;
+int nr_copy_pages_check;

 static int resume_status;
 static char resume_file[256] = "";			/* For resume= kernel option */
@@ -107,8 +107,8 @@
    MMU hardware.
  */
 suspend_pagedir_t *pagedir_nosave __nosavedata = NULL;
-static suspend_pagedir_t *pagedir_save;
-static int pagedir_order __nosavedata = 0;
+suspend_pagedir_t *pagedir_save;
+int pagedir_order __nosavedata = 0;

 struct link {
 	char dummy[PAGE_SIZE - sizeof(swp_entry_t)];
