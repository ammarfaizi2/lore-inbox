Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262641AbVAPXnA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262641AbVAPXnA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 18:43:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262650AbVAPXnA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 18:43:00 -0500
Received: from gprs215-109.eurotel.cz ([160.218.215.109]:64942 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S262641AbVAPXmz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 18:42:55 -0500
Date: Mon, 17 Jan 2005 00:42:43 +0100
From: Pavel Machek <pavel@ucw.cz>
To: xhejtman@mail.muni.cz, Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: swsusp: remove O(n^2) algorithm in page relocation
Message-ID: <20050116234243.GA14917@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This removes another O(n^2) algorithm from page relocation in
swsusp. Relocation took as long as reading pages from disk on my
machine, and it took minutes for some poor testers. Please apply,

							Pavel

From: Lukas Hejtmanek <xhejtman@mail.muni.cz>
Signed-off-by: Pavel Machek <pavel@suse.cz>

--- linux-cvs/kernel/power/swsusp.c	2005-01-16 22:29:25.000000000 +0100
+++ linux/kernel/power/swsusp.c	2005-01-16 23:10:29.000000000 +0100
@@ -893,26 +893,18 @@
 	return error;
 }
 
-
-
 /* More restore stuff */
 
-#define does_collide(addr) does_collide_order(pagedir_nosave, addr, 0)
-
 /*
  * Returns true if given address/order collides with any orig_address 
  */
-static int __init does_collide_order(suspend_pagedir_t *pagedir, unsigned long addr,
-		int order)
+static int __init does_collide_order(unsigned long addr, int order)
 {
 	int i;
-	unsigned long addre = addr + (PAGE_SIZE<<order);
 	
-	for (i=0; i < nr_copy_pages; i++)
-		if ((pagedir+i)->orig_address >= addr &&
-			(pagedir+i)->orig_address < addre)
+	for (i=0; i < (1<<order); i++)
+		if (!PageNosaveFree(virt_to_page(addr + i * PAGE_SIZE)))
 			return 1;
-
 	return 0;
 }
 
@@ -931,7 +923,7 @@
 			addr = get_zeroed_page(GFP_ATOMIC);
 			if(!addr)
 				return -ENOMEM;
-		} while (does_collide(addr));
+		} while (does_collide_order(addr, 0));
 
 		(pagedir_nosave+i)->address = addr;
 	}
@@ -948,16 +940,34 @@
 	void **eaten_memory = NULL;
 	void **c = eaten_memory, *m, *f;
 	int ret = 0;
+	struct zone *zone;
+	int i;
+	struct pbe *p;
+	unsigned long zone_pfn;
 
 	printk("Relocating pagedir ");
 
-	if (!does_collide_order(old_pagedir, (unsigned long)old_pagedir, pagedir_order)) {
+	/* Set page flags */
+	
+	for_each_zone(zone) {
+        	for (zone_pfn = 0; zone_pfn < zone->spanned_pages; ++zone_pfn)
+                	SetPageNosaveFree(pfn_to_page(zone_pfn + 
+					zone->zone_start_pfn));
+	}
+
+	/* Clear orig address */
+
+	for(i = 0, p = pagedir_nosave; i < nr_copy_pages; i++, p++) {
+		ClearPageNosaveFree(virt_to_page(p->orig_address));
+	}
+
+	if (!does_collide_order((unsigned long)old_pagedir, pagedir_order)) {
 		printk("not necessary\n");
 		return check_pagedir();
 	}
 
 	while ((m = (void *) __get_free_pages(GFP_ATOMIC, pagedir_order)) != NULL) {
-		if (!does_collide_order(old_pagedir, (unsigned long)m, pagedir_order))
+		if (!does_collide_order((unsigned long)m, pagedir_order))
 			break;
 		eaten_memory = m;
 		printk( "." ); 

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
