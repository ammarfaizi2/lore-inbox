Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268019AbUH1V0h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268019AbUH1V0h (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 17:26:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268029AbUH1VYh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 17:24:37 -0400
Received: from gprs214-188.eurotel.cz ([160.218.214.188]:20864 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S268019AbUH1VXa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 17:23:30 -0400
Date: Sat, 28 Aug 2004 23:23:15 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>,
       Patrick Mochel <mochel@digitalimplant.org>
Subject: swsusp error: do not oops after allocation failure 
Message-ID: <20040828212315.GA1763@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This checks error return from swsusp_alloc, preventing oops when
memory can not be allocated. Please apply,
								Pavel

--- clean-mm.middle/kernel/power/swsusp.c	2004-08-20 14:11:31.000000000 +0200
+++ linux-mm/kernel/power/swsusp.c	2004-08-28 23:18:52.000000000 +0200
@@ -677,9 +677,9 @@
 	calc_order();
 	pagedir_save = (suspend_pagedir_t *)__get_free_pages(GFP_ATOMIC | __GFP_COLD,
 							     pagedir_order);
-	if(!pagedir_save)
+	if (!pagedir_save)
 		return -ENOMEM;
-	memset(pagedir_save,0,(1 << pagedir_order) * PAGE_SIZE);
+	memset(pagedir_save, 0, (1 << pagedir_order) * PAGE_SIZE);
 	pagedir_nosave = pagedir_save;
 	return 0;
 }
@@ -784,6 +784,7 @@
 int suspend_prepare_image(void)
 {
 	unsigned int nr_needed_pages = 0;
+	int error;
 
 	pr_debug("swsusp: critical section: \n");
 	if (save_highmem()) {
@@ -796,7 +797,9 @@
 	printk("swsusp: Need to copy %u pages\n",nr_copy_pages);
 	nr_needed_pages = nr_copy_pages + PAGES_FOR_IO;
 
-	swsusp_alloc();
+	error = swsusp_alloc();
+	if (error)
+		return error;
 	
 	/* During allocating of suspend pagedir, new cold pages may appear. 
 	 * Kill them.

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
