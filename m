Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750702AbVLKONG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750702AbVLKONG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 09:13:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750707AbVLKONF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 09:13:05 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:29369 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750702AbVLKOND (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 09:13:03 -0500
Date: Sun, 11 Dec 2005 15:12:17 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Matt Mackall <mpm@selenic.com>
Subject: [patch -mm] fix SLOB on x64
Message-ID: <20051211141217.GA5912@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


this patch fixes 32-bitness bugs in mm/slob.c. Successfully booted x64 
with SLOB enabled. (i have switched the PREEMPT_RT feature to use the 
SLOB allocator exclusively, so it must work on all platforms)

Signed-off-by: Ingo Molnar <mingo@elte.hu>

Index: linux/mm/slob.c
===================================================================
--- linux.orig/mm/slob.c
+++ linux/mm/slob.c
@@ -198,7 +198,7 @@ void kfree(const void *block)
 	if (!block)
 		return;
 
-	if (!((unsigned int)block & (PAGE_SIZE-1))) {
+	if (!((unsigned long)block & (PAGE_SIZE-1))) {
 		/* might be on the big block list */
 		spin_lock_irqsave(&block_lock, flags);
 		for (bb = bigblocks; bb; last = &bb->next, bb = bb->next) {
@@ -227,7 +227,7 @@ unsigned int ksize(const void *block)
 	if (!block)
 		return 0;
 
-	if (!((unsigned int)block & (PAGE_SIZE-1))) {
+	if (!((unsigned long)block & (PAGE_SIZE-1))) {
 		spin_lock_irqsave(&block_lock, flags);
 		for (bb = bigblocks; bb; bb = bb->next)
 			if (bb->pages == block) {
@@ -326,7 +326,7 @@ void kmem_cache_init(void)
 	void *p = slob_alloc(PAGE_SIZE, 0, PAGE_SIZE-1);
 
 	if (p)
-		free_page((unsigned int)p);
+		free_page((unsigned long)p);
 
 	mod_timer(&slob_timer, jiffies + HZ);
 }
