Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263731AbUGQWpb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263731AbUGQWpb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jul 2004 18:45:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263713AbUGQWoq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jul 2004 18:44:46 -0400
Received: from digitalimplant.org ([64.62.235.95]:53481 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S262927AbUGQWgG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jul 2004 18:36:06 -0400
Date: Sat, 17 Jul 2004 15:35:57 -0700 (PDT)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: linux-kernel@vger.kernel.org
cc: pavel@ucw.cz
Subject: [20/25] Merge pmdisk and swsusp
Message-ID: <Pine.LNX.4.50.0407171531580.22290-100000@monsoon.he.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ChangeSet 1.1862, 2004/07/17 13:25:16-07:00, mochel@digitalimplant.org

[Power Mgmt] Remove pmdisk_free()

- Change name of free_suspend_pagedir() to swsusp_free().
- Call from kernel/power/disk.c


 kernel/power/disk.c   |    6 +++---
 kernel/power/pmdisk.c |   12 ------------
 kernel/power/swsusp.c |    9 +++++----
 3 files changed, 8 insertions(+), 19 deletions(-)


diff -Nru a/kernel/power/disk.c b/kernel/power/disk.c
--- a/kernel/power/disk.c	2004-07-17 14:50:41 -07:00
+++ b/kernel/power/disk.c	2004-07-17 14:50:41 -07:00
@@ -27,7 +27,7 @@
 extern int swsusp_write(void);
 extern int swsusp_read(void);
 extern int swsusp_resume(void);
-extern int pmdisk_free(void);
+extern int swsusp_free(void);


 /**
@@ -180,7 +180,7 @@
 		}
 	} else
 		pr_debug("PM: Image restored successfully.\n");
-	pmdisk_free();
+	swsusp_free();
  Done:
 	finish();
 	return error;
@@ -231,7 +231,7 @@
 	pr_debug("PM: Restore failed, recovering.n");
 	finish();
  Free:
-	pmdisk_free();
+	swsusp_free();
  Done:
 	pr_debug("PM: Resume from disk failed.\n");
 	return 0;
diff -Nru a/kernel/power/pmdisk.c b/kernel/power/pmdisk.c
--- a/kernel/power/pmdisk.c	2004-07-17 14:50:41 -07:00
+++ b/kernel/power/pmdisk.c	2004-07-17 14:50:41 -07:00
@@ -42,18 +42,6 @@
  */


-/**
- *	pmdisk_free - Free memory allocated to hold snapshot.
- */
-
-int pmdisk_free(void)
-{
-	extern void free_suspend_pagedir(unsigned long this_pagedir);
-	pr_debug( "Freeing prev allocated pagedir\n" );
-	free_suspend_pagedir((unsigned long)pagedir_save);
-	return 0;
-}
-
 static int __init pmdisk_setup(char *str)
 {
 	if (strlen(str)) {
diff -Nru a/kernel/power/swsusp.c b/kernel/power/swsusp.c
--- a/kernel/power/swsusp.c	2004-07-17 14:50:41 -07:00
+++ b/kernel/power/swsusp.c	2004-07-17 14:50:41 -07:00
@@ -656,14 +656,15 @@
 	}
 }

-void free_suspend_pagedir(unsigned long this_pagedir)
+void swsusp_free(void)
 {
+	unsigned long p = (unsigned long)pagedir_save;
 	struct zone *zone;
 	for_each_zone(zone) {
 		if (!is_highmem(zone))
-			free_suspend_pagedir_zone(zone, this_pagedir);
+			free_suspend_pagedir_zone(zone, p);
 	}
-	free_pages(this_pagedir, pagedir_order);
+	free_pages(p, pagedir_order);
 }

 static int prepare_suspend_processes(void)
@@ -816,7 +817,7 @@
 	}
 	if ((error = alloc_image_pages())) {
 		pr_debug("suspend: Allocating image pages failed.\n");
-		free_suspend_pagedir((unsigned long)pagedir_save);
+		swsusp_free();
 		return error;
 	}

