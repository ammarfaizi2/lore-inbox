Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932259AbVIYSpt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932259AbVIYSpt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Sep 2005 14:45:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932262AbVIYSpa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Sep 2005 14:45:30 -0400
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:4550 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S932264AbVIYSp0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Sep 2005 14:45:26 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: [PATCH 3/3][Fix] swsusp: prevent swsusp from failing if there's too many pagedir pages
Date: Sun, 25 Sep 2005 20:44:00 +0200
User-Agent: KMail/1.8.2
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
References: <200509252018.36867.rjw@sisk.pl>
In-Reply-To: <200509252018.36867.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509252044.00928.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There's a silent assumption in swsusp that always
sizeof(struct swsusp_info) <= PAGE_SIZE, which is wrong, because
eg. on x86-64 sizeof(swp_entry_t) = 8.  This causes swsusp to skip some pagedir
pages while reading the image if there are too many of them (depending on the
architecture, approx. 500 on x86-64).

The following patch makes swsusp more flexible with this respect, by allocating
separate swap page(s) (as many as needed) for storing the swap offsets of
pagedir pages (without the patch they are all stored in a struct swsusp_info,
and there may be not enough room for them in this structure).

Please consider for applying,
Rafael


Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

Index: linux-2.6.14-rc2-git3/kernel/power/power.h
===================================================================
--- linux-2.6.14-rc2-git3.orig/kernel/power/power.h	2005-09-25 18:42:31.000000000 +0200
+++ linux-2.6.14-rc2-git3/kernel/power/power.h	2005-09-25 18:56:17.000000000 +0200
@@ -9,6 +9,7 @@
 #define SUSPEND_CONSOLE	(MAX_NR_CONSOLES-1)
 #endif
 
+#define MAX_PB_SWP_PAGES	128
 
 struct swsusp_info {
 	struct new_utsname	uts;
@@ -18,10 +19,12 @@
 	unsigned long		image_pages;
 	unsigned long		pagedir_pages;
 	suspend_pagedir_t	* suspend_pagedir;
-	swp_entry_t		pagedir[768];
+	unsigned		pb_swp_pages;
+	swp_entry_t		pb_swp[MAX_PB_SWP_PAGES];
+	swp_entry_t		* pb_swp_mem[MAX_PB_SWP_PAGES];
 } __attribute__((aligned(PAGE_SIZE)));
 
-
+/* pb_swp_mem and pb_swp_pages are needed for error recovery */
 
 #ifdef CONFIG_SOFTWARE_SUSPEND
 extern int pm_suspend_disk(void);
Index: linux-2.6.14-rc2-git3/kernel/power/swsusp.c
===================================================================
--- linux-2.6.14-rc2-git3.orig/kernel/power/swsusp.c	2005-09-25 18:52:48.000000000 +0200
+++ linux-2.6.14-rc2-git3/kernel/power/swsusp.c	2005-09-25 19:10:16.000000000 +0200
@@ -496,10 +496,17 @@
 
 static void free_pagedir_entries(void)
 {
-	int i;
+	swp_entry_t **ptr, *entry;
+	int j, k;
 
-	for (i = 0; i < swsusp_info.pagedir_pages; i++)
-		swap_free(swsusp_info.pagedir[i]);
+	for (j = 0, ptr = swsusp_info.pb_swp_mem;
+	     j < swsusp_info.pb_swp_pages; j++, ptr++) {
+		for (k = 0, entry = *ptr;
+		     k < PAGE_SIZE/sizeof(swp_entry_t); k++, entry++)
+			if (entry->val)
+				swap_free(*entry);
+		free_page((unsigned long)*ptr);
+	}
 }
 
 
@@ -510,18 +517,49 @@
 
 static int write_pagedir(void)
 {
-	int error = 0;
-	unsigned n = 0;
+	int error = -EFAULT;
+	unsigned k, n, pages = 0;
 	struct pbe * pbe;
+	swp_entry_t * buf;
+
+	if (!(buf = (swp_entry_t *)get_zeroed_page(GFP_KERNEL)))
+		return -ENOMEM;
 
 	printk( "Writing pagedir...");
+	n = 0;
+	swsusp_info.pb_swp_mem[0] = buf;
+	swsusp_info.pb_swp_pages = 1;
+	k = 0;
 	for_each_pb_page (pbe, pagedir_nosave) {
-		if ((error = write_page((unsigned long)pbe, &swsusp_info.pagedir[n++])))
+		error = write_page((unsigned long)pbe, &buf[k++]);
+		if (!error) {
+			pages++;
+			if (k >= PAGE_SIZE/sizeof(swp_entry_t)) {
+				error = write_page((unsigned long)buf, &swsusp_info.pb_swp[n++]);
+				if (n >= MAX_PB_SWP_PAGES)
+					error = -ENOMEM;
+				if (!error) {
+					buf = (swp_entry_t *)get_zeroed_page(GFP_KERNEL);
+					if (buf) {
+						swsusp_info.pb_swp_mem[n] = buf;
+						swsusp_info.pb_swp_pages++;
+						k = 0;
+					} else
+						error = -ENOMEM;
+				}
+			}
+		}
+		if (error)
 			return error;
 	}
+	if (k > 0)
+		error = write_page((unsigned long)buf, &swsusp_info.pb_swp[n++]);
+
+	if (!error) {
+		swsusp_info.pagedir_pages = pages;
+		printk("done (%u pages)\n", pages);
+	}
 
-	swsusp_info.pagedir_pages = n;
-	printk("done (%u pages)\n", n);
 	return error;
 }
 
@@ -1414,33 +1452,58 @@
 static int read_pagedir(struct pbe *pblist)
 {
 	struct pbe *pbpage, *p;
-	unsigned i = 0;
-	int error;
+	unsigned k, n = 0, pages = 0;
+	int error = -EFAULT;
+	swp_entry_t * buf;
+	unsigned long offset;
 
 	if (!pblist)
 		return -EFAULT;
 
+	if (!(buf = (swp_entry_t *)get_zeroed_page(GFP_KERNEL)))
+		return -ENOMEM;
+
 	printk("swsusp: Reading pagedir (%lu pages)\n",
 			swsusp_info.pagedir_pages);
 
-	for_each_pb_page (pbpage, pblist) {
-		unsigned long offset = swp_offset(swsusp_info.pagedir[i++]);
+	if (!(offset = swp_offset(swsusp_info.pb_swp[n++])))
+		goto free_buf;
 
+	if ((error = bio_read_page(offset, (swp_entry_t *)buf)))
+		goto free_buf;
+
+	k = 0;
+	for_each_pb_page (pbpage, pblist) {
 		error = -EFAULT;
+		offset = swp_offset(buf[k++]);
 		if (offset) {
 			p = (pbpage + PB_PAGE_SKIP)->next;
 			error = bio_read_page(offset, (void *)pbpage);
 			(pbpage + PB_PAGE_SKIP)->next = p;
 		}
-		if (error)
+		if (!error) {
+			pages++;
+			if (k >= PAGE_SIZE/sizeof(swp_entry_t)) {
+				error = -EFAULT;
+				offset = swp_offset(swsusp_info.pb_swp[n++]);
+				if (offset) {
+					error = bio_read_page(offset, (swp_entry_t *)buf);
+					k = 0;
+				}
+				if (error)
+					break;
+			}
+		} else
 			break;
 	}
 
+free_buf:
 	if (error)
 		free_pagedir(pblist);
 	else
-		BUG_ON(i != swsusp_info.pagedir_pages);
+		BUG_ON(pages != swsusp_info.pagedir_pages);
 
+	free_page((unsigned long)buf);
 	return error;
 }
 
