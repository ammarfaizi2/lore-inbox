Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263939AbUFINFT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263939AbUFINFT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 09:05:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264357AbUFINFT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 09:05:19 -0400
Received: from gprs214-178.eurotel.cz ([160.218.214.178]:62337 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S263939AbUFINFG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 09:05:06 -0400
Date: Wed, 9 Jun 2004 15:04:51 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Patrick Mochel <mochel@digitalimplant.org>,
       kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>
Subject: Fix memory leak in swsusp
Message-ID: <20040609130451.GA23107@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This fixes 2 memory leaks in swsusp: during relocating pagedir, eaten
pages were not properly freed in error path and even regular freeing
path was freeing one page too little. Please apply,

								Pavel

--- linux-cvs/kernel/power/swsusp.c	2004-05-22 19:39:01.000000000 +0200
+++ linux/kernel/power/swsusp.c	2004-06-06 00:30:09.000000000 +0200
@@ -455,7 +455,7 @@
@@ -503,6 +503,9 @@
 		if (!pbe)
 			continue;
 		pbe->orig_address = (long) page_address(page);
+		/* Copy page is dangerous: it likes to mess with
+		   preempt count on specific cpus. Wrong preempt count is then copied,
+		   oops. */
 		copy_page((void *)pbe->address, (void *)pbe->orig_address);
 		pbe++;
 	}
@@ -923,8 +952,9 @@
 	suspend_pagedir_t *new_pagedir, *old_pagedir = pagedir_nosave;
 	void **eaten_memory = NULL;
 	void **c = eaten_memory, *m, *f;
+	int ret = 0;
 
-	printk("Relocating pagedir");
+	printk("Relocating pagedir ");
 
 	if(!does_collide_order(old_pagedir, (unsigned long)old_pagedir, pagedir_order)) {
 		printk("not necessary\n");
@@ -941,22 +971,23 @@
 		c = eaten_memory;
 	}
 
-	if (!m)
-		return -ENOMEM;
-
-	pagedir_nosave = new_pagedir = m;
-	copy_pagedir(new_pagedir, old_pagedir);
+	if (!m) {
+		printk("out of memory\n");
+		ret = -ENOMEM;
+	} else {
+		pagedir_nosave = new_pagedir = m;
+		copy_pagedir(new_pagedir, old_pagedir);
+	}
 
 	c = eaten_memory;
-	while(c) {
+	while (c) {
 		printk(":");
-		f = *c;
+		f = c;
 		c = *c;
-		if (f)
-			free_pages((unsigned long)f, pagedir_order);
+		free_pages((unsigned long)f, pagedir_order);
 	}
 	printk("|\n");
-	return 0;
+	return ret;
 }
 
 /*

-- 
934a471f20d6580d5aad759bf0d97ddc
