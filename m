Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262007AbUFJKuz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262007AbUFJKuz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 06:50:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261181AbUFJKuz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 06:50:55 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:24336 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S262007AbUFJKul
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 06:50:41 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: pavel@ucw.cz (Pavel Machek)
Subject: Re: Fix memory leak in swsusp
Cc: mochel@digitalimplant.org, linux-kernel@vger.kernel.org, akpm@zip.com.au
Organization: Core
In-Reply-To: <20040609130451.GA23107@elf.ucw.cz>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.25-1-686-smp (i686))
Message-Id: <E1BYN8O-0008Vg-00@gondolin.me.apana.org.au>
Date: Thu, 10 Jun 2004 20:50:12 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> wrote:
> 
> This fixes 2 memory leaks in swsusp: during relocating pagedir, eaten
> pages were not properly freed in error path and even regular freeing
> path was freeing one page too little. Please apply,

Thanks for the patch.

Here is the same fix for pmdisk.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
--
===== kernel/power/pmdisk.c 1.84 vs edited =====
--- 1.84/kernel/power/pmdisk.c	2004-04-13 03:55:18 +10:00
+++ edited/kernel/power/pmdisk.c	2004-06-10 20:47:15 +10:00
@@ -795,6 +795,7 @@
 	suspend_pagedir_t *new_pagedir, *old_pagedir = pm_pagedir_nosave;
 	void **eaten_memory = NULL;
 	void **c = eaten_memory, *m, *f;
+	int err;
 
 	pr_debug("pmdisk: Relocating pagedir\n");
 
@@ -803,32 +804,31 @@
 		return 0;
 	}
 
+	err = -ENOMEM;
 	while ((m = (void *) __get_free_pages(GFP_ATOMIC, pagedir_order))) {
 		memset(m, 0, PAGE_SIZE);
-		if (!does_collide_order(old_pagedir, (unsigned long)m, pagedir_order))
+		if (!does_collide_order(old_pagedir, (unsigned long)m,
+					pagedir_order)) {
+			pm_pagedir_nosave = new_pagedir = m;
+			copy_pagedir(new_pagedir, old_pagedir);
+			err = 0;
 			break;
+		}
 		eaten_memory = m;
 		printk( "." ); 
 		*eaten_memory = c;
 		c = eaten_memory;
 	}
 
-	if (!m)
-		return -ENOMEM;
-
-	pm_pagedir_nosave = new_pagedir = m;
-	copy_pagedir(new_pagedir, old_pagedir);
-
 	c = eaten_memory;
 	while(c) {
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
+	return err;
 }
 
 
