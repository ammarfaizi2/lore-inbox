Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262605AbUGQXDG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262605AbUGQXDG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jul 2004 19:03:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265247AbUGQXC0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jul 2004 19:02:26 -0400
Received: from digitalimplant.org ([64.62.235.95]:39913 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S262605AbUGQWfd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jul 2004 18:35:33 -0400
Date: Sat, 17 Jul 2004 15:35:25 -0700 (PDT)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: linux-kernel@vger.kernel.org
Subject: [13/25] Merge pmdisk and swsusp
Message-ID: <Pine.LNX.4.50.0407171530270.22290-100000@monsoon.he.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ChangeSet 1.1855, 2004/07/17 11:52:51-07:00, mochel@digitalimplant.org

[Power Mgmt] Merge pmdisk/swsusp image reading code.

- Create swsusp_data_read() and call from read_suspend_image() in both
  swsusp and pmdisk.
- Mark swsusp_pagedir_relocate() as static again.


 kernel/power/pmdisk.c |   38 +++++---------------------------------
 kernel/power/power.h  |    3 ---
 kernel/power/swsusp.c |   48 +++++++++++++++++++++++++++++++++---------------
 3 files changed, 38 insertions(+), 51 deletions(-)


diff -Nru a/kernel/power/pmdisk.c b/kernel/power/pmdisk.c
--- a/kernel/power/pmdisk.c	2004-07-17 14:51:09 -07:00
+++ b/kernel/power/pmdisk.c	2004-07-17 14:51:09 -07:00
@@ -385,33 +385,10 @@
 }


-/**
- *	read_image_data - Read image pages from swap.
- *
- *	You do not need to check for overlaps, check_pagedir()
- *	already did that.
- */
-
-static int __init read_image_data(void)
-{
-	struct pbe * p;
-	int error = 0;
-	int i;
-
-	printk( "Reading image data (%d pages): ", nr_copy_pages );
-	for(i = 0, p = pagedir_nosave; i < nr_copy_pages && !error; i++, p++) {
-		if (!(i%100))
-			printk( "." );
-		error = bio_read_page(swp_offset(p->swap_address),
-				  (void *)p->address);
-	}
-	printk(" %d done.\n",i);
-	return error;
-}
-
-
 static int __init read_suspend_image(void)
 {
+	extern int swsusp_data_read(void);
+
 	int error = 0;

 	if ((error = check_sig()))
@@ -420,15 +397,10 @@
 		return error;
 	if ((error = read_pagedir()))
 		return error;
-	if ((error = swsusp_pagedir_relocate()))
-		goto FreePagedir;
-	if ((error = read_image_data()))
-		goto FreePagedir;
- Done:
+	if ((error = swsusp_data_read())) {
+		free_pages((unsigned long)pagedir_nosave,pagedir_order);
+	}
 	return error;
- FreePagedir:
-	free_pages((unsigned long)pagedir_nosave,pagedir_order);
-	goto Done;
 }


diff -Nru a/kernel/power/power.h b/kernel/power/power.h
--- a/kernel/power/power.h	2004-07-17 14:51:09 -07:00
+++ b/kernel/power/power.h	2004-07-17 14:51:09 -07:00
@@ -18,9 +18,6 @@
 	return -EPERM;
 }
 #endif
-
-extern int swsusp_pagedir_relocate(void);
-
 extern struct semaphore pm_sem;
 #define power_attr(_name) \
 static struct subsys_attribute _name##_attr = {	\
diff -Nru a/kernel/power/swsusp.c b/kernel/power/swsusp.c
--- a/kernel/power/swsusp.c	2004-07-17 14:51:09 -07:00
+++ b/kernel/power/swsusp.c	2004-07-17 14:51:09 -07:00
@@ -1041,7 +1041,7 @@
 	return 0;
 }

-int __init swsusp_pagedir_relocate(void)
+static int __init swsusp_pagedir_relocate(void)
 {
 	/*
 	 * We have to avoid recursion (not to overflow kernel stack),
@@ -1198,6 +1198,34 @@
 }


+/**
+ *	swsusp_read_data - Read image pages from swap.
+ *
+ *	You do not need to check for overlaps, check_pagedir()
+ *	already did that.
+ */
+
+int __init swsusp_data_read(void)
+{
+	struct pbe * p;
+	int error;
+	int i;
+
+	if ((error = swsusp_pagedir_relocate()))
+		return error;
+
+	printk( "Reading image data (%d pages): ", nr_copy_pages );
+	for(i = 0, p = pagedir_nosave; i < nr_copy_pages && !error; i++, p++) {
+		if (!(i%100))
+			printk( "." );
+		error = bio_read_page(swp_offset(p->swap_address),
+				  (void *)p->address);
+	}
+	printk(" %d done.\n",i);
+	return error;
+
+}
+
 extern dev_t __init name_to_dev_t(const char *line);

 static int __init __read_suspend_image(int noresume)
@@ -1205,6 +1233,7 @@
 	union diskpage *cur;
 	swp_entry_t next;
 	int i, nr_pgdir_pages;
+	int error;

 	cur = (union diskpage *)get_zeroed_page(GFP_ATOMIC);
 	if (!cur)
@@ -1272,20 +1301,9 @@
 	}
 	BUG_ON (next.val);

-	if (swsusp_pagedir_relocate())
-		return -ENOMEM;
-
-	printk( "Reading image data (%d pages): ", nr_copy_pages );
-	for(i=0; i < nr_copy_pages; i++) {
-		swp_entry_t swap_address = (pagedir_nosave+i)->swap_address;
-		if (!(i%100))
-			printk( "." );
-		/* You do not need to check for overlaps...
-		   ... check_pagedir already did this work */
-		if (bio_read_page(swp_offset(swap_address) * PAGE_SIZE, (char *)((pagedir_nosave+i)->address)))
-			return -EIO;
-	}
-	printk( "|\n" );
+	error = swsusp_data_read();
+	if (!error)
+		printk( "|\n" );
 	return 0;
 }

