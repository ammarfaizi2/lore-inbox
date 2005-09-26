Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751373AbVIZT3F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751373AbVIZT3F (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 15:29:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751328AbVIZT3F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 15:29:05 -0400
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:48075 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S1751373AbVIZT3E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 15:29:04 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: [PATCH][Fix] swsusp: avoid problems if there are too many pages to save
Date: Mon, 26 Sep 2005 21:29:07 +0200
User-Agent: KMail/1.8.2
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
References: <200509252018.36867.rjw@sisk.pl> <200509261454.09702.rjw@sisk.pl> <20050926142608.GA32249@elf.ucw.cz>
In-Reply-To: <20050926142608.GA32249@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509262129.08316.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following patch makes swsusp avoid problems during resume if there are too many
pages to save on suspend.  It adds a constant that allows us to verify if we are going to
save too many pages and implements the check (this is done as early as we can tell that
the check will trigger, which is in swsusp_alloc()).

This is to replace swsusp-prevent-swsusp-from-failing-if-theres-too-many-pagedir-pages.patch

Please consider for applying.

Greetings,
Rafael


Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

Index: linux-2.6.14-rc2-git6/kernel/power/power.h
===================================================================
--- linux-2.6.14-rc2-git6.orig/kernel/power/power.h	2005-09-26 20:58:33.000000000 +0200
+++ linux-2.6.14-rc2-git6/kernel/power/power.h	2005-09-26 21:05:37.000000000 +0200
@@ -9,6 +9,9 @@
 #define SUSPEND_CONSOLE	(MAX_NR_CONSOLES-1)
 #endif
 
+#define MAX_PBES	((PAGE_SIZE - sizeof(struct new_utsname) \
+			- 4 - 3*sizeof(unsigned long) - sizeof(int) \
+			- sizeof(void *)) / sizeof(swp_entry_t))
 
 struct swsusp_info {
 	struct new_utsname	uts;
@@ -18,7 +21,7 @@
 	unsigned long		image_pages;
 	unsigned long		pagedir_pages;
 	suspend_pagedir_t	* suspend_pagedir;
-	swp_entry_t		pagedir[768];
+	swp_entry_t		pagedir[MAX_PBES];
 } __attribute__((aligned(PAGE_SIZE)));
 
 
Index: linux-2.6.14-rc2-git6/kernel/power/swsusp.c
===================================================================
--- linux-2.6.14-rc2-git6.orig/kernel/power/swsusp.c	2005-09-26 20:59:30.000000000 +0200
+++ linux-2.6.14-rc2-git6/kernel/power/swsusp.c	2005-09-26 21:05:13.000000000 +0200
@@ -931,6 +931,10 @@
 	if (!enough_swap())
 		return -ENOSPC;
 
+	if (MAX_PBES < nr_copy_pages / PBES_PER_PAGE +
+	    !!(nr_copy_pages % PBES_PER_PAGE))
+		return -ENOSPC;
+
 	if (!(pagedir_save = alloc_pagedir(nr_copy_pages))) {
 		printk(KERN_ERR "suspend: Allocating pagedir failed.\n");
 		return -ENOMEM;
