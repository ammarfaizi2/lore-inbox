Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750888AbWDTGaX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750888AbWDTGaX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 02:30:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751083AbWDTGaW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 02:30:22 -0400
Received: from ns2.suse.de ([195.135.220.15]:58860 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750896AbWDTGaW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 02:30:22 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Thu, 20 Apr 2006 16:29:55 +1000
Message-Id: <1060420062955.7727@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-kernel@vger.kernel.org
Cc: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Subject: [PATCH] Remove softlockup from invalidate_mapping_pages.
References: <20060420160549.7637.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch fixes a problem with invalidate_mapping_pages.
Please look at the patch description and then come back here, because
there are some things I don't understand which you might be able to
help me with.
...

Thanks. 
I have had 2 reports of softlockups in this code apparently related to md. 
md calls invalidate_bdev on all the component block devices that it is 
building into an array.  These block devices are very likely to have just one
page in their mapping, right near the end as mdadm will have read the 
superblock which lives near the end.

However, I cannot see why the page would be locked.
Being locked for read is very unlikely because mdadm would have already
read the superblock.  I guess locked for read-ahead might be possible
(I assume readahead does lock the pages) but as only one or maybe two reads 
are a performed by mdadm, not much readahead should be generated.

Being locked for write also seems unlikely as if mdadm were to write
(which is fairly unlikely but not impossible) it would fsync() straight
away so by the time that it comes to assemble the array, all io
should have finished.

So that is (1) - I don't see why the page would be locked.

And (2) - I have a report (on linux-raid) of a soft-lockup which
lasted 76 seconds! 
Now if the device was 100Gig, that is 25million page addresses or 
3microseconds per loop. Is that at all likely for this loop - it 
does take and drop a spinlock but could that come close to a
few thousand cycles?

And the processor in this case was a dual-core amd64 - with SMP enabled.
I can imaging a long lockup on a uniprocessor, but if a second processor
core is free to unlock the page when the IO (Whatever it is) completes,
a 76 second delay would be unexpected.

The original bug report can be found at
  http://marc.theaimsgroup.com/?l=linux-raid&m=114550096908177&w=2

Finally (3) - I think that invalidate_mapping_pages should probably
have a cond_resched() call in it, except that drop_pagecache_sb in
fs/drop_caches.c calls it with the "inode_lock" spinlock held, which
would be bad.  Would it be safe (or could it be made safe) to drop and
regain the lock around that call?

Comments welcome, but in any case I think the patch is needed.

Thanks for your time,
NeilBrown




### Comments for Changeset

If invalidate_mapping_pages is called to invalidate a very large
mapping (e.g. a very large block device) and if the only active page
in that device is near the end  (or at least, at a very large  index),
such as, say, the superblock of an md array, and if that page
happens to be locked when invalidate_mapping_pages is called,
then
  pagevec_lookup will return this page and
  as it is locked, 'next' will be incremented and pagevec_lookup
  will be called again. and again. and again.
  while we count from 0 upto a very large number.

We should really always set 'next' to 'page->index+1' before going
around the loop again, not just if the page isn't locked.


Cc: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./mm/truncate.c |   10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff ./mm/truncate.c~current~ ./mm/truncate.c
--- ./mm/truncate.c~current~	2006-04-20 15:27:22.000000000 +1000
+++ ./mm/truncate.c	2006-04-20 15:38:20.000000000 +1000
@@ -238,13 +238,11 @@ unsigned long invalidate_mapping_pages(s
 		for (i = 0; i < pagevec_count(&pvec); i++) {
 			struct page *page = pvec.pages[i];
 
-			if (TestSetPageLocked(page)) {
-				next++;
+			next = page->index+1;
+
+			if (TestSetPageLocked(page))
 				continue;
-			}
-			if (page->index > next)
-				next = page->index;
-			next++;
+
 			if (PageDirty(page) || PageWriteback(page))
 				goto unlock;
 			if (page_mapped(page))
