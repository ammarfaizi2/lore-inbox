Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261719AbVDKXrE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261719AbVDKXrE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 19:47:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261725AbVDKXrE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 19:47:04 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:50409 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S261719AbVDKXqz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 19:46:55 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Date: Tue, 12 Apr 2005 09:46:34 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16987.3162.71365.242198@cse.unsw.edu.au>
Cc: Claudio Martins <ctpm@rnl.ist.utl.pt>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Processes stuck on D state on Dual Opteron
In-Reply-To: message from Nick Piggin on Monday April 11
References: <200504050316.20644.ctpm@rnl.ist.utl.pt>
	<200504100328.53762.ctpm@rnl.ist.utl.pt>
	<20050409194746.69cfa230.akpm@osdl.org>
	<200504110138.51872.ctpm@rnl.ist.utl.pt>
	<425A4999.9010209@yahoo.com.au>
	<425A7173.802@yahoo.com.au>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday April 11, nickpiggin@yahoo.com.au wrote:
> 
> Neil, have you had a look at the traces? Do they mean much to you?
> 

Just looked. 
bio_alloc_bioset seems implicated, as does sync_page_io.

sync_page_io used to use a 'struct bio' on the stack, but Jens Axboe
change it to use bio_alloc (don't know why..) and I should have 
checked the change better.

sync_page_io can be called on the write out path, so it should use
GFP_NOIO rather than GFP_KERNEL.

See if this helps.... Actually this patch is against 2.6.12-rc2-mm1
which uses md_super_write instead of sync_page_io (which is now only
used for read).  So if you are using a non-mm kernel (which seems to
be the case) you'll need to apply the patch by hand.


Thanks,
NeilBrown

---
Avoid deadlock in sync_page_io by using GFP_NOIO

..as sync_page_io can be called on the write-out path.
Ditto for md_super_write

Signed-off-by: Neil Brown <neilb@cse.unsw.edu.au>

### Diffstat output
 ./drivers/md/md.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff ./drivers/md/md.c~current~ ./drivers/md/md.c
--- ./drivers/md/md.c~current~	2005-04-08 11:25:26.000000000 +1000
+++ ./drivers/md/md.c	2005-04-12 09:42:29.000000000 +1000
@@ -351,7 +351,7 @@ void md_super_write(mddev_t *mddev, mdk_
 	 * if zero is reached.
 	 * If an error occurred, call md_error
 	 */
-	struct bio *bio = bio_alloc(GFP_KERNEL, 1);
+	struct bio *bio = bio_alloc(GFP_NOIO, 1);
 
 	bio->bi_bdev = rdev->bdev;
 	bio->bi_sector = sector;
@@ -374,7 +374,7 @@ static int bi_complete(struct bio *bio, 
 int sync_page_io(struct block_device *bdev, sector_t sector, int size,
 		   struct page *page, int rw)
 {
-	struct bio *bio = bio_alloc(GFP_KERNEL, 1);
+	struct bio *bio = bio_alloc(GFP_NOIO, 1);
 	struct completion event;
 	int ret;
 
