Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261183AbVALNLU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261183AbVALNLU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 08:11:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261181AbVALNLT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 08:11:19 -0500
Received: from gprs214-158.eurotel.cz ([160.218.214.158]:16592 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261180AbVALNK1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 08:10:27 -0500
Date: Wed, 12 Jan 2005 14:10:10 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: swsusp: more small fixes
Message-ID: <20050112131010.GA1378@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This adds few missing statics to swsusp.c, prints errors even when
non-debugging and fixes last "pmdisk: " message. Fixed few comments. 
Please apply,

								Pavel

--- clean/kernel/power/swsusp.c	2005-01-12 11:07:40.000000000 +0100
+++ linux/kernel/power/swsusp.c	2005-01-12 11:35:42.000000000 +0100
@@ -420,7 +419,7 @@
 	struct highmem_page *next;
 };
 
-struct highmem_page *highmem_copy = NULL;
+static struct highmem_page *highmem_copy = NULL;
 
 static int save_highmem_zone(struct zone *zone)
 {
@@ -753,21 +753,21 @@
 		return -ENOSPC;
 
 	if ((error = alloc_pagedir())) {
-		pr_debug("suspend: Allocating pagedir failed.\n");
+		printk("suspend: Allocating pagedir failed.\n");
 		return error;
 	}
 	if ((error = alloc_image_pages())) {
-		pr_debug("suspend: Allocating image pages failed.\n");
+		printk("suspend: Allocating image pages failed.\n");
 		swsusp_free();
 		return error;
 	}
 
 	nr_copy_pages_check = nr_copy_pages;
 	pagedir_order_check = pagedir_order;
 	return 0;
 }
 
-int suspend_prepare_image(void)
+static int suspend_prepare_image(void)
 {
 	int error;
 
@@ -931,7 +921,7 @@
 			addr = get_zeroed_page(GFP_ATOMIC);
 			if(!addr)
 				return -ENOMEM;
-		} while (does_collide(addr));
+		} while (does_collide_order(addr, 0));
 
 		(pagedir_nosave+i)->address = addr;
 	}
@@ -1050,12 +1058,12 @@
 	return error;
 }
 
-int bio_read_page(pgoff_t page_off, void * page)
+static int bio_read_page(pgoff_t page_off, void * page)
 {
 	return submit(READ, page_off, page);
 }
 
-int bio_write_page(pgoff_t page_off, void * page)
+static int bio_write_page(pgoff_t page_off, void * page)
 {
 	return submit(WRITE, page_off, page);
 }
@@ -1172,7 +1180,7 @@
 		return -ENOMEM;
 	pagedir_nosave = (struct pbe *)addr;
 
-	pr_debug("pmdisk: Reading pagedir (%d Pages)\n",n);
+	pr_debug("swsusp: Reading pagedir (%d Pages)\n",n);
 
 	for (i = 0; i < n && !error; i++, addr += PAGE_SIZE) {
 		unsigned long offset = swp_offset(swsusp_info.pagedir[i]);


--- clean/kernel/power/main.c	2004-12-25 13:35:03.000000000 +0100
+++ linux/kernel/power/main.c	2005-01-12 10:57:23.000000000 +0100
@@ -99,7 +100,7 @@
  *	@state:		State we're coming out of.
  *
  *	Call platform code to clean up, restart processes, and free the 
- *	console that we've allocated.
+ *	console that we've allocated. This is not called for suspend-to-disk.
  */
 
 static void suspend_finish(suspend_state_t state)


--- clean/kernel/power/disk.c	2004-12-25 13:35:03.000000000 +0100
+++ linux/kernel/power/disk.c	2005-01-12 10:57:23.000000000 +0100
@@ -163,7 +167,7 @@
  *
  *	If we're going through the firmware, then get it over with quickly.
  *
- *	If not, then call swsusp to do it's thing, then figure out how
+ *	If not, then call swsusp to do its thing, then figure out how
  *	to power down the system.
  */
 
@@ -201,7 +205,7 @@
  *	software_resume - Resume from a saved image.
  *
  *	Called as a late_initcall (so all devices are discovered and
- *	initialized), we call pmdisk to see if we have a saved image or not.
+ *	initialized), we call swsusp to see if we have a saved image or not.
  *	If so, we quiesce devices, the restore the saved image. We will
  *	return above (in pm_suspend_disk() ) if everything goes well.
  *	Otherwise, we fail gracefully and return to the normally
@@ -221,7 +225,7 @@
 		return 0;
 	}
 
-	pr_debug("PM: Reading pmdisk image.\n");
+	pr_debug("PM: Reading swsusp image.\n");
 
 	if ((error = swsusp_read()))
 		goto Done;
@@ -284,7 +288,7 @@
 
 static ssize_t disk_show(struct subsystem * subsys, char * buf)
 {
-	return sprintf(buf,"%s\n",pm_disk_modes[pm_disk_mode]);
+	return sprintf(buf, "%s\n", pm_disk_modes[pm_disk_mode]);
 }
 
 

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
