Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262201AbUKQDqE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262201AbUKQDqE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 22:46:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262200AbUKQDqE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 22:46:04 -0500
Received: from fw.osdl.org ([65.172.181.6]:47826 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262201AbUKQDp4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 22:45:56 -0500
Date: Tue, 16 Nov 2004 19:45:37 -0800
From: Andrew Morton <akpm@osdl.org>
To: Chris Ross <chris@tebibyte.org>
Cc: marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, piggin@cyberone.com.au, riel@redhat.com,
       andrea@novell.com, mmokrejs@ribosome.natur.cuni.cz, tglx@linutronix.de
Subject: Re: [PATCH] fix spurious OOM kills
Message-Id: <20041116194537.7cc64c2a.akpm@osdl.org>
In-Reply-To: <4193E056.6070100@tebibyte.org>
References: <20041111112922.GA15948@logos.cnet>
	<4193E056.6070100@tebibyte.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Ross <chris@tebibyte.org> wrote:
>
> the oom killer strikes at the linking stage.

Can you beat on this patch a bit?

--- 25/mm/vmscan.c~a	2004-11-16 19:25:55.360041112 -0800
+++ 25-akpm/mm/vmscan.c	2004-11-16 19:26:45.791374384 -0800
@@ -918,11 +918,11 @@ int try_to_free_pages(struct zone **zone
 		lru_pages += zone->nr_active + zone->nr_inactive;
 	}
 
-	for (priority = DEF_PRIORITY; priority >= 0; priority--) {
+	for (priority = DEF_PRIORITY; priority >= -1; priority--) {
 		sc.nr_mapped = read_page_state(nr_mapped);
 		sc.nr_scanned = 0;
 		sc.nr_reclaimed = 0;
-		sc.priority = priority;
+		sc.priority = (priority < 0) ? 0 : priority;
 		shrink_caches(zones, &sc);
 		shrink_slab(sc.nr_scanned, gfp_mask, lru_pages);
 		if (reclaim_state) {
_


It just adds another priority-0 scanning pass before declaring oom.  It
works for me.

See, when redoing the 2.5 scanning code a couple of years ago I reduced the
amount of scanning which we do before declaring oom (compared with 2.4) by
quite a lot.  It was basically a "lets try this and see who complains"
exercise.

And since that time, the way in which `priority' is interpreted has
changed, which may have worsened things.

Presently we're scanning the entire active list twice and the entire
inactive list twice.  I suspect that if the inactive list is full of
referenced pages, that just isn't enough.  However it's hard to work out
what _is_ enough.  Still, it doesn't hurt to do a bit more scanning before
going off killing things, so the above seems a safe approach.

If the above still doesn't work, try replacing -1 with -2, etc.


