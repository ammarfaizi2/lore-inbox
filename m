Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262671AbVAKBIc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262671AbVAKBIc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 20:08:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262686AbVAKBGx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 20:06:53 -0500
Received: from hell.sks3.muni.cz ([147.251.210.30]:56813 "EHLO
	hell.sks3.muni.cz") by vger.kernel.org with ESMTP id S262703AbVAKBBZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 20:01:25 -0500
Date: Tue, 11 Jan 2005 02:01:23 +0100
From: Lukas Hejtmanek <xhejtman@mail.muni.cz>
To: linux-kernel@vger.kernel.org
Subject: PATCH swsusp: page rellocation speed up
Message-ID: <20050111010122.GA3013@mail.muni.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ikeVEW9yuYc//A+q"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-echelon: NSA, CIA, CI5, MI5, FBI, KGB, BIS, Plutonium, Bin Laden, bomb
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hello,

attached patch should speed up page rellocation at time of resume. Please test.
The diff is against 2.6.10-bk8

-- 
Luká¹ Hejtmánek

--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: attachment; filename=patch

--- a/kernel/power/swsusp.c	2005-01-06 14:08:33.000000000 +0100
+++ b/kernel/power/swsusp.c	2005-01-11 01:03:24.000000000 +0100
@@ -885,25 +885,18 @@
 }
 
 
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
+		if(!PageNosaveFree(virt_to_page(addr + i * PAGE_SIZE)))
 			return 1;
-
 	return 0;
 }
 
@@ -922,7 +915,7 @@
 			addr = get_zeroed_page(GFP_ATOMIC);
 			if(!addr)
 				return -ENOMEM;
-		} while (does_collide(addr));
+		} while (does_collide_order(addr,0));
 
 		(pagedir_nosave+i)->address = addr;
 	}
@@ -939,16 +932,34 @@
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

--ikeVEW9yuYc//A+q--
