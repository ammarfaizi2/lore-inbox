Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261883AbULUWZ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261883AbULUWZ3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 17:25:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261884AbULUWZ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 17:25:29 -0500
Received: from mail.dif.dk ([193.138.115.101]:12515 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261883AbULUWZR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 17:25:17 -0500
Date: Tue, 21 Dec 2004 23:36:01 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH][trivial] change rmqueue_bulk argument 'count' to be int
Message-ID: <Pine.LNX.4.61.0412212317040.3518@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Here's a trivial little patch (hopefully without trivial mistakes) to fix 
the function definition for rmqueue_bulk to only accept values it can 
actually handle. 

Let me explain (and please do let me know if I'm mistaken :) ,
in mm/page_alloc.c the function rmqueue_bulk() is defined to take a 
unsigned long as its third argument (count). This argument is then used in 
a for loop and being compared to a signed int - /if/ someone was to ever 
pass in a value larger than what a signed int can hold we'll have an 
infinite loop on our hands. 
This does not currently happen since the only caller of rmqueue_bulk is 
passing in the 'batch' member of 'struct per_cpu_pages' which is an int. 
But, should someone in the future make a change that causes the function 
to be called with a >int value we'll have a nice little infinite loop to 
debug at runtime, so why not let the compiler help us ensure such a 
mistake will be found at compile time? 
If the function can only deal with being passed values up to the maximum 
of a signed int, then it seems wrong to allow it to be passed something 
else. If however situations could arise where it would be desired to pass 
the function something larger than int, then it should stay unsigned long, 
but then the counter variable 'i' used in the for loop should be changed 
to unsigned long instead - I don't know the code well enough to be able to 
judge if that's what should happen instead (but since it currently gets 
passed only int's that seemed like the proper type to normalize to - 
ohh and it'll also get rid of a signed vs unsigned comparison warning 
when building with -W, but that's just a tiny added bonus :).

note. I've only compile tested this patch atm.

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

diff -up linux-2.6.10-rc3-bk13-orig/mm/page_alloc.c linux-2.6.10-rc3-bk13/mm/page_alloc.c
--- linux-2.6.10-rc3-bk13-orig/mm/page_alloc.c	2004-12-06 22:24:56.000000000 +0100
+++ linux-2.6.10-rc3-bk13/mm/page_alloc.c	2004-12-21 23:11:51.000000000 +0100
@@ -396,7 +396,7 @@ static struct page *__rmqueue(struct zon
  * Returns the number of new pages which were placed at *list.
  */
 static int rmqueue_bulk(struct zone *zone, unsigned int order, 
-			unsigned long count, struct list_head *list)
+			int count, struct list_head *list)
 {
 	unsigned long flags;
 	int i;



