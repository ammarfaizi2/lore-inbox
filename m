Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750755AbWDTHjh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750755AbWDTHjh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 03:39:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750756AbWDTHjh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 03:39:37 -0400
Received: from smtp.osdl.org ([65.172.181.4]:17887 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750755AbWDTHjg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 03:39:36 -0400
Date: Thu, 20 Apr 2006 00:38:39 -0700
From: Andrew Morton <akpm@osdl.org>
To: NeilBrown <neilb@suse.de>
Cc: linux-kernel@vger.kernel.org, sgunderson@bigfoot.com
Subject: Re: [PATCH] Remove softlockup from invalidate_mapping_pages.
Message-Id: <20060420003839.1a41c36f.akpm@osdl.org>
In-Reply-To: <1060420062955.7727@suse.de>
References: <20060420160549.7637.patches@notabene>
	<1060420062955.7727@suse.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NeilBrown <neilb@suse.de> wrote:
>
> The following patch fixes a problem with invalidate_mapping_pages.
> Please look at the patch description and then come back here, because
> there are some things I don't understand which you might be able to
> help me with.
> ...
> 
> Thanks. 
> I have had 2 reports of softlockups in this code apparently related to md. 
> md calls invalidate_bdev on all the component block devices that it is 
> building into an array.  These block devices are very likely to have just one
> page in their mapping, right near the end as mdadm will have read the 
> superblock which lives near the end.
> 
> However, I cannot see why the page would be locked.
> Being locked for read is very unlikely because mdadm would have already
> read the superblock.  I guess locked for read-ahead might be possible
> (I assume readahead does lock the pages) but as only one or maybe two reads 
> are a performed by mdadm, not much readahead should be generated.
> 
> Being locked for write also seems unlikely as if mdadm were to write
> (which is fairly unlikely but not impossible) it would fsync() straight
> away so by the time that it comes to assemble the array, all io
> should have finished.
> 
> So that is (1) - I don't see why the page would be locked.

Dunno.   memory reclaim could lock the page, but that'd be pretty rare.

> And (2) - I have a report (on linux-raid) of a soft-lockup which
> lasted 76 seconds! 
> Now if the device was 100Gig, that is 25million page addresses or 
> 3microseconds per loop. Is that at all likely for this loop - it 
> does take and drop a spinlock but could that come close to a
> few thousand cycles?

Maybe this CPU is holding some lock which pervents the page-unlocking thread
from unlocking the page?

You could perhaps do

	page->who_locked_me = __builtin_return_address(<something>);

in lock_page().  And in TestSetPageLocked().  It'd take some poking. 
Alternatively a well-timed sysrq-T might tell you.


As you point out, the loop will count up to page->index one-at-a-time.  3us
sounds rather heavy, but the radix-tree gang-lookup code isn't terribly
efficient, and the tree will be deep.

> And the processor in this case was a dual-core amd64 - with SMP enabled.
> I can imaging a long lockup on a uniprocessor, but if a second processor
> core is free to unlock the page when the IO (Whatever it is) completes,
> a 76 second delay would be unexpected.

yup.

> The original bug report can be found at
>   http://marc.theaimsgroup.com/?l=linux-raid&m=114550096908177&w=2
> 
> Finally (3) - I think that invalidate_mapping_pages should probably
> have a cond_resched() call in it, except that drop_pagecache_sb in
> fs/drop_caches.c calls it with the "inode_lock" spinlock held, which
> would be bad.

Yes, we used to have a cond_resched() in there, but I took it out, for that
reason.  I'm bad.

  Would it be safe (or could it be made safe) to drop and
> regain the lock around that call?

Hard.  We're walking a long list-head chain which is pinned by that lock.

> If invalidate_mapping_pages is called to invalidate a very large
> mapping (e.g. a very large block device) and if the only active page
> in that device is near the end  (or at least, at a very large  index),
> such as, say, the superblock of an md array, and if that page
> happens to be locked when invalidate_mapping_pages is called,
> then
>   pagevec_lookup will return this page and
>   as it is locked, 'next' will be incremented and pagevec_lookup
>   will be called again. and again. and again.
>   while we count from 0 upto a very large number.
> 
> We should really always set 'next' to 'page->index+1' before going
> around the loop again, not just if the page isn't locked.
> 

OK.

> Cc: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
> Signed-off-by: Neil Brown <neilb@suse.de>
> 
> ### Diffstat output
>  ./mm/truncate.c |   10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff ./mm/truncate.c~current~ ./mm/truncate.c
> --- ./mm/truncate.c~current~	2006-04-20 15:27:22.000000000 +1000
> +++ ./mm/truncate.c	2006-04-20 15:38:20.000000000 +1000
> @@ -238,13 +238,11 @@ unsigned long invalidate_mapping_pages(s
>  		for (i = 0; i < pagevec_count(&pvec); i++) {
>  			struct page *page = pvec.pages[i];
>  
> -			if (TestSetPageLocked(page)) {
> -				next++;
> +			next = page->index+1;
> +
> +			if (TestSetPageLocked(page))
>  				continue;
> -			}
> -			if (page->index > next)
> -				next = page->index;
> -			next++;
> +
>  			if (PageDirty(page) || PageWriteback(page))
>  				goto unlock;
>  			if (page_mapped(page))

We're not supposed to look at page->index of an unlocked page.

In practice, I think it's OK - there's no _reason_ why anyone would want to
trash the ->index of a just-truncated page.  However I think it'd be saner
to a) only look at ->index after we've tried to lock the page and b) make
sure that ->index is really "to the right" of where we're currently at.

How's this look?

--- devel/mm/truncate.c~remove-softlockup-from-invalidate_mapping_pages	2006-04-20 00:20:49.000000000 -0700
+++ devel-akpm/mm/truncate.c	2006-04-20 00:28:18.000000000 -0700
@@ -230,14 +230,24 @@ unsigned long invalidate_mapping_pages(s
 			pagevec_lookup(&pvec, mapping, next, PAGEVEC_SIZE)) {
 		for (i = 0; i < pagevec_count(&pvec); i++) {
 			struct page *page = pvec.pages[i];
+			pgoff_t index;
+			int locked;
 
-			if (TestSetPageLocked(page)) {
-				next++;
-				continue;
-			}
-			if (page->index > next)
-				next = page->index;
+			locked = TestSetPageLocked(page);
+
+			/*
+			 * We really shouldn't be looking at the ->index of an
+			 * unlocked page.  But we're not allowed to lock these
+			 * pages.  So we rely upon nobody altering the ->index
+			 * of this (pinned-by-us) page.
+			 */
+			index = page->index;
+			if (index > next)
+				next = index;
 			next++;
+			if (!locked)
+				continue;
+
 			if (PageDirty(page) || PageWriteback(page))
 				goto unlock;
 			if (page_mapped(page))
_


