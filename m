Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263664AbUGQWi2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263664AbUGQWi2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jul 2004 18:38:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262744AbUGQWfq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jul 2004 18:35:46 -0400
Received: from digitalimplant.org ([64.62.235.95]:15849 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S262114AbUGQWex
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jul 2004 18:34:53 -0400
Date: Sat, 17 Jul 2004 15:34:44 -0700 (PDT)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: linux-kernel@vger.kernel.org
cc: pavel@ucw.cz
Subject: [2/25] Merge pmdisk and swsusp
Message-ID: <Pine.LNX.4.50.0407171526540.22290-100000@monsoon.he.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ChangeSet 1.1844, 2004/07/17 09:07:44-07:00, mochel@digitalimplant.org

[Power Mgmt] Remove duplicate relocate_pagedir() from pmdisk.

- Expose and use version in swsusp.


 kernel/power/pmdisk.c |   91 --------------------------------------------------
 kernel/power/power.h  |    2 +
 kernel/power/swsusp.c |   12 ++----
 3 files changed, 8 insertions(+), 97 deletions(-)


diff -Nru a/kernel/power/pmdisk.c b/kernel/power/pmdisk.c
--- a/kernel/power/pmdisk.c	2004-07-17 14:51:52 -07:00
+++ b/kernel/power/pmdisk.c	2004-07-17 14:51:52 -07:00
@@ -732,93 +732,6 @@

 /* More restore stuff */

-#define does_collide(addr) does_collide_order(pm_pagedir_nosave, addr, 0)
-
-/*
- * Returns true if given address/order collides with any orig_address
- */
-static int __init does_collide_order(suspend_pagedir_t *pagedir,
-				     unsigned long addr, int order)
-{
-	int i;
-	unsigned long addre = addr + (PAGE_SIZE<<order);
-
-	for(i=0; i < pmdisk_pages; i++)
-		if((pagedir+i)->orig_address >= addr &&
-			(pagedir+i)->orig_address < addre)
-			return 1;
-
-	return 0;
-}
-
-/*
- * We check here that pagedir & pages it points to won't collide with pages
- * where we're going to restore from the loaded pages later
- */
-static int __init check_pagedir(void)
-{
-	int i;
-
-	for(i=0; i < pmdisk_pages; i++) {
-		unsigned long addr;
-
-		do {
-			addr = get_zeroed_page(GFP_ATOMIC);
-			if(!addr)
-				return -ENOMEM;
-		} while (does_collide(addr));
-
-		(pm_pagedir_nosave+i)->address = addr;
-	}
-	return 0;
-}
-
-static int __init relocate_pagedir(void)
-{
-	/*
-	 * We have to avoid recursion (not to overflow kernel stack),
-	 * and that's why code looks pretty cryptic
-	 */
-	suspend_pagedir_t *old_pagedir = pm_pagedir_nosave;
-	void **eaten_memory = NULL;
-	void **c = eaten_memory, *m, *f;
-	int err;
-
-	pr_debug("pmdisk: Relocating pagedir\n");
-
-	if(!does_collide_order(old_pagedir, (unsigned long)old_pagedir, pagedir_order)) {
-		pr_debug("pmdisk: Relocation not necessary\n");
-		return 0;
-	}
-
-	err = -ENOMEM;
-	while ((m = (void *) __get_free_pages(GFP_ATOMIC, pagedir_order)) != NULL) {
-		if (!does_collide_order(old_pagedir, (unsigned long)m,
-					pagedir_order)) {
-			pm_pagedir_nosave =
-				memcpy(m, old_pagedir,
-				       PAGE_SIZE << pagedir_order);
-			err = 0;
-			break;
-		}
-		eaten_memory = m;
-		printk( "." );
-		*eaten_memory = c;
-		c = eaten_memory;
-	}
-
-	c = eaten_memory;
-	while(c) {
-		printk(":");
-		f = c;
-		c = *c;
-		free_pages((unsigned long)f, pagedir_order);
-	}
-	printk("|\n");
-	return err;
-}
-
-
 static struct block_device * resume_bdev;


@@ -1041,9 +954,7 @@
 		return error;
 	if ((error = read_pagedir()))
 		return error;
-	if ((error = relocate_pagedir()))
-		goto FreePagedir;
-	if ((error = check_pagedir()))
+	if ((error = swsusp_pagedir_relocate()))
 		goto FreePagedir;
 	if ((error = read_image_data()))
 		goto FreePagedir;
diff -Nru a/kernel/power/power.h b/kernel/power/power.h
--- a/kernel/power/power.h	2004-07-17 14:51:52 -07:00
+++ b/kernel/power/power.h	2004-07-17 14:51:52 -07:00
@@ -19,6 +19,8 @@
 }
 #endif

+extern int swsusp_pagedir_relocate(void);
+
 extern struct semaphore pm_sem;
 #define power_attr(_name) \
 static struct subsys_attribute _name##_attr = {	\
diff -Nru a/kernel/power/swsusp.c b/kernel/power/swsusp.c
--- a/kernel/power/swsusp.c	2004-07-17 14:51:52 -07:00
+++ b/kernel/power/swsusp.c	2004-07-17 14:51:52 -07:00
@@ -874,7 +874,7 @@
 /*
  * Returns true if given address/order collides with any orig_address
  */
-static int does_collide_order(suspend_pagedir_t *pagedir, unsigned long addr,
+static int __init does_collide_order(suspend_pagedir_t *pagedir, unsigned long addr,
 		int order)
 {
 	int i;
@@ -892,7 +892,7 @@
  * We check here that pagedir & pages it points to won't collide with pages
  * where we're going to restore from the loaded pages later
  */
-static int check_pagedir(void)
+static int __init check_pagedir(void)
 {
 	int i;

@@ -910,7 +910,7 @@
 	return 0;
 }

-static int relocate_pagedir(void)
+int __init swsusp_pagedir_relocate(void)
 {
 	/*
 	 * We have to avoid recursion (not to overflow kernel stack),
@@ -953,7 +953,7 @@
 		free_pages((unsigned long)f, pagedir_order);
 	}
 	printk("|\n");
-	return ret;
+	return check_pagedir();
 }

 /*
@@ -1089,9 +1089,7 @@
 	}
 	BUG_ON (next.val);

-	if (relocate_pagedir())
-		return -ENOMEM;
-	if (check_pagedir())
+	if (swsusp_pagedir_relocate())
 		return -ENOMEM;

 	printk( "Reading image data (%d pages): ", nr_copy_pages );
