Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262007AbUFXBIX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262007AbUFXBIX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 21:08:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263448AbUFXBIW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 21:08:22 -0400
Received: from fw.osdl.org ([65.172.181.6]:18655 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262007AbUFXBIU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 21:08:20 -0400
Date: Wed, 23 Jun 2004 18:07:22 -0700
From: Andrew Morton <akpm@osdl.org>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [oom]: [0/4] fix OOM deadlock running OAST
Message-Id: <20040623180722.69a8ea6f.akpm@osdl.org>
In-Reply-To: <20040624003249.GM1552@holomorphy.com>
References: <0406231407.HbLbJbXaHbKbWa5aJb1a4aKb0a3aKb1a0a2aMbMbYa3aLbMb3aJbWaJbXaMbLb1a342@holomorphy.com>
	<20040623151659.70333c6d.akpm@osdl.org>
	<20040623223146.GG1552@holomorphy.com>
	<20040623153758.40e3a865.akpm@osdl.org>
	<20040623230730.GJ1552@holomorphy.com>
	<20040623163819.013c8585.akpm@osdl.org>
	<20040624000308.GK1552@holomorphy.com>
	<20040623171818.39b73d52.akpm@osdl.org>
	<20040624002651.GL1552@holomorphy.com>
	<20040624003249.GM1552@holomorphy.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>
> On Wed, Jun 23, 2004 at 05:26:51PM -0700, William Lee Irwin III wrote:
> > Then it sounds like the smaller fix below may be better for you.
> 
> Also, as we're fixing this a different way, could you clarify for me
> which of the pieces of the original fix or related things (e.g. the
> zone->all_unreclaimable stuff, yanking PG_wired stuff off the LRU,
> maybe more) you wanted me to rework and send back in later?
> 

Well none, really.  This problem is now fixed, is it not?

It would be nice to fix up the unrelated issue of putting unbacked pages
onto the LRU.  Could do that by adding backing_dev_info.not_on_lru, check
that in the various places where we add pages to the LRU.


Or, conceivably, do it lazily: take these pages off the LRU if we encounter
them in page reclaim.  This might be a net win - do extra work for the rare
case, less work for the common case.

Something like this:

--- 25/mm/vmscan.c~a	2004-06-23 18:05:19.738648736 -0700
+++ 25-akpm/mm/vmscan.c	2004-06-23 18:06:00.386469328 -0700
@@ -367,6 +367,17 @@ static int shrink_list(struct list_head 
 		if (page_mapped(page) || PageSwapCache(page))
 			sc->nr_scanned++;
 
+		mapping = page_mapping(page);
+
+		if (mapping && mapping->backing_dev_info->not_on_lru) {
+			/*
+			 * comment goes here
+			 */
+			unlock_page(page);
+			page_cache_release(page);
+			continue;
+		}
+
 		page_map_lock(page);
 		referenced = page_referenced(page);
 		if (referenced && page_mapping_inuse(page)) {
@@ -386,11 +397,11 @@ static int shrink_list(struct list_head 
 			page_map_unlock(page);
 			if (!add_to_swap(page))
 				goto activate_locked;
+			mapping = page_mapping(page);
 			page_map_lock(page);
 		}
 #endif /* CONFIG_SWAP */
 
-		mapping = page_mapping(page);
 		may_enter_fs = (sc->gfp_mask & __GFP_FS) ||
 			(PageSwapCache(page) && (sc->gfp_mask & __GFP_IO));
 
_

