Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261463AbVDZKp7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261463AbVDZKp7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 06:45:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261477AbVDZKp7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 06:45:59 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:43923 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261463AbVDZKoq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 06:44:46 -0400
Date: Tue, 26 Apr 2005 12:44:24 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: [patch 1/3] swsusp: kill unneccessary does_collide_order
Message-ID: <20050426104424.GA15732@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The following patch removes the unnecessary function does_collide_order().
    
This function is no longer necessary, as currently there are only 0-order
allocations in swsusp, and the use of it is confusing.
    
Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Signed-off-by: Pavel Machek <pavel@suse.cz>

Index: kernel/power/swsusp.c
===================================================================
--- 43765d4b40a4a3c64f2a32b684f4041e2f01644d/kernel/power/swsusp.c  (mode:100644 sha1:ae5bebc3b18fa648857863fae0ec34ae7a105661)
+++ d8c41efce19593001c280a07cde0506788b4347d/kernel/power/swsusp.c  (mode:100644 sha1:c3bf8c03c883657ff6bc5237868fe9a6494372e4)
@@ -929,21 +929,6 @@
 	return error;
 }
 
-/* More restore stuff */
-
-/*
- * Returns true if given address/order collides with any orig_address 
- */
-static int does_collide_order(unsigned long addr, int order)
-{
-	int i;
-	
-	for (i=0; i < (1<<order); i++)
-		if (!PageNosaveFree(virt_to_page(addr + i * PAGE_SIZE)))
-			return 1;
-	return 0;
-}
-
 /**
  *	On resume, for storing the PBE list and the image,
  *	we can only use memory pages that do not conflict with the pages
@@ -973,7 +958,7 @@
 	unsigned long m;
 
 	m = get_zeroed_page(gfp_mask);
-	while (does_collide_order(m, 0)) {
+	while (!PageNosaveFree(virt_to_page(m))) {
 		eat_page((void *)m);
 		m = get_zeroed_page(gfp_mask);
 		if (!m)
@@ -1061,7 +1046,7 @@
 	/* Relocate colliding pages */
 
 	for_each_pb_page (pbpage, pblist) {
-		if (does_collide_order((unsigned long)pbpage, 0)) {
+		if (!PageNosaveFree(virt_to_page((unsigned long)pbpage))) {
 			m = (void *)get_usable_page(GFP_ATOMIC | __GFP_COLD);
 			if (!m) {
 				error = -ENOMEM;



!-------------------------------------------------------------flip-



-- 
Boycott Kodak -- for their patent abuse against Java.
