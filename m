Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262616AbVAPVwM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262616AbVAPVwM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 16:52:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262617AbVAPVwM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 16:52:12 -0500
Received: from gprs214-69.eurotel.cz ([160.218.214.69]:39892 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262616AbVAPVwB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 16:52:01 -0500
Date: Sun, 16 Jan 2005 22:51:45 +0100
From: Pavel Machek <pavel@suse.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: hugang@soulinfo.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.10-mm3: swsusp: out of memory on resume (was: Re: Ho ho ho - Linux v2.6.10)
Message-ID: <20050116215145.GF2757@elf.ucw.cz>
References: <Pine.LNX.4.58.0412241434110.17285@ppc970.osdl.org> <20050114143400.GA27657@hugang.soulinfo.com> <200501141825.42407.rjw@sisk.pl> <200501152243.21483.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501152243.21483.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > Has this patch been ported to x86_64?  Or is there a newer version of it anywhere,
> > > > or an alternative?
> > > > 
> > > 
> > > Ok, Here is a new patch with x86_64 support, But I have not machine, So
> > > Need someone test it. 
> > 
> > OK, I will.
> 
> I have tested it and it works well.  For me, it speeds up the resume process significantly,
> so I vote for including it into -mm (at least ;-)).  I'll be testing it further to see if it really
> solves my "out of memory" problems on resume.

Try Lukas's patch, it should provide equivalent speedups.
									Pavel

--- linux-cvs/kernel/power/swsusp.c	2005-01-16 22:29:25.000000000 +0100
+++ linux/kernel/power/swsusp.c	2005-01-16 22:49:10.000000000 +0100
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
