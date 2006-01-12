Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964979AbWALJUT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964979AbWALJUT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 04:20:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964981AbWALJUT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 04:20:19 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:16651 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S964979AbWALJUS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 04:20:18 -0500
Date: Thu, 12 Jan 2006 10:20:17 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Matthew Wilcox <willy@parisc-linux.org>
Cc: Kyle McMartin <kyle@parisc-linux.org>, grundler@parisc-linux.org,
       parisc-linux@parisc-linux.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] arch/parisc/mm/init.c: fix SMP=y compilation
Message-ID: <20060112092017.GP29663@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the following compile error with CONFIG_SMP=y:

<--  snip  -->

...
  CC      arch/parisc/mm/init.o
arch/parisc/mm/init.c:795: error: conflicting types for 'flush_tlb_all_local'
include/asm/tlbflush.h:25: error: previous declaration of 'flush_tlb_all_local' was here
arch/parisc/mm/init.c: In function 'flush_tlb_all':
arch/parisc/mm/init.c:1008: error: too many arguments to function 'flush_tlb_all_local'
make[1]: *** [arch/parisc/mm/init.o] Error 1

<--  snip  -->


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 arch/parisc/mm/init.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

--- linux-2.6.15-mm3-hppa/arch/parisc/mm/init.c.old	2006-01-12 10:06:01.000000000 +0100
+++ linux-2.6.15-mm3-hppa/arch/parisc/mm/init.c	2006-01-12 10:07:32.000000000 +0100
@@ -792,8 +792,6 @@ map_hpux_gateway_page(struct task_struct
 EXPORT_SYMBOL(map_hpux_gateway_page);
 #endif
 
-extern void flush_tlb_all_local(void);
-
 void __init paging_init(void)
 {
 	int i;
@@ -802,7 +800,7 @@ void __init paging_init(void)
 	pagetable_init();
 	gateway_init();
 	flush_cache_all_local(); /* start with known state */
-	flush_tlb_all_local();
+	flush_tlb_all_local(NULL);
 
 	for (i = 0; i < npmem_ranges; i++) {
 		unsigned long zones_size[MAX_NR_ZONES] = { 0, 0, 0 };
@@ -993,7 +991,7 @@ void flush_tlb_all(void)
 	    do_recycle++;
 	}
 	spin_unlock(&sid_lock);
-	on_each_cpu((void (*)(void *))flush_tlb_all_local, NULL, 1, 1);
+	on_each_cpu(flush_tlb_all_local, NULL, 1, 1);
 	if (do_recycle) {
 	    spin_lock(&sid_lock);
 	    recycle_sids(recycle_ndirty,recycle_dirty_array);

