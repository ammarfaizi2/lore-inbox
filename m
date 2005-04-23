Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262091AbVDWVtr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262091AbVDWVtr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Apr 2005 17:49:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262088AbVDWVtg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Apr 2005 17:49:36 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:43167 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S262063AbVDWVr5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Apr 2005 17:47:57 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] swsusp: misc cleanups [2/4]
Date: Sat, 23 Apr 2005 23:29:18 +0200
User-Agent: KMail/1.7.1
Cc: LKML <linux-kernel@vger.kernel.org>
References: <200504232320.54477.rjw@sisk.pl>
In-Reply-To: <200504232320.54477.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504232329.18407.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch removes the unnecessary functions does_collide_order().

This function is no longer necessary, as currently there are only 0-order
allocations in swsusp, and the use of it is confusing.

Please consider for applying.


Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

diff -Nurp a/kernel/power/swsusp.c b/kernel/power/swsusp.c
--- a/kernel/power/swsusp.c	2005-04-22 14:48:04.000000000 +0200
+++ b/kernel/power/swsusp.c	2005-04-23 21:39:57.000000000 +0200
@@ -929,21 +929,6 @@ int swsusp_resume(void)
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
@@ -973,7 +958,7 @@ static unsigned long get_usable_page(uns
 	unsigned long m;
 
 	m = get_zeroed_page(gfp_mask);
-	while (does_collide_order(m, 0)) {
+	while (!PageNosaveFree(virt_to_page(m))) {
 		eat_page((void *)m);
 		m = get_zeroed_page(gfp_mask);
 		if (!m)
@@ -1061,7 +1046,7 @@ static struct pbe * swsusp_pagedir_reloc
 	/* Relocate colliding pages */
 
 	for_each_pb_page (pbpage, pblist) {
-		if (does_collide_order((unsigned long)pbpage, 0)) {
+		if (!PageNosaveFree(virt_to_page((unsigned long)pbpage))) {
 			m = (void *)get_usable_page(GFP_ATOMIC | __GFP_COLD);
 			if (!m) {
 				error = -ENOMEM;

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"

