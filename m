Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263824AbTLEDID (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 22:08:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263830AbTLEDID
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 22:08:03 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:18651 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S263824AbTLEDH4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 22:07:56 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Jens Axboe <axboe@suse.de>
Date: Fri, 5 Dec 2003 14:07:35 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16335.63095.266710.554162@notabene.cse.unsw.edu.au>
Cc: Linus Torvalds <torvalds@osdl.org>,
       David =?iso-8859-1?Q?Mart=EDnez?= Moreno <ender@debian.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       clubinfo.servers@adi.uam.es, Ingo Molnar <mingo@elte.hu>,
       Nathan Scott <nathans@sgi.com>, Mihai RUSU <dizzy@roedu.net>
Subject: Re: Errors and later panics in 2.6.0-test11.
In-Reply-To: message from Jens Axboe on Thursday December 4
References: <200312031417.18462.ender@debian.org>
	<Pine.LNX.4.58.0312030757120.5258@home.osdl.org>
	<200312031747.16927.ender@debian.org>
	<Pine.LNX.4.58.0312030916080.6950@home.osdl.org>
	<20031204124342.GD1086@suse.de>
	<20031204140738.GE1086@suse.de>
X-Mailer: VM 7.18 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday December 4, axboe@suse.de wrote:
> 
> I can just as easily reproduce with ext2, so I don't think XFS has
> anything to do with it. This is still raid5 with dm linear on top.
> 

Thanks.  The more evidence the better....

After staring at the code over and ove again, I finally saw the
assumption that I was making that was invalid.  I also found a
possible data-corruption bug in the process.

If you have been having problems with raid5, please try this patch and
see if it helps.

Thanks,
NeilBrown

### Comments for ChangeSet
Fix bugs in md/raid5

This patch does three things:
 1/ make sure raid5 doesn't try to handle multiple overlaping 
    requests at the same time as this would confuse things badly.
    Currently it justs BUGs if this is attempted.
 2/ Fix a possible data-loss-on-write problem.  If two or
    more bio's that write to the same page are processed at the
    same time, only the first was actually commited to storage.
 3/ Fix a use-after-free bug.  raid5 keeps the bio's it is given
    in linked lists when more than one bio touch a single page.
    In some cases the tail of this list can be freed, and
    the current test for 'are we at the end' isn't reliable.
    This patch strengths the test to make it reliable.


 ----------- Diffstat output ------------
 ./drivers/md/raid5.c |   34 +++++++++++++++++++++++++---------
 1 files changed, 25 insertions(+), 9 deletions(-)

diff ./drivers/md/raid5.c~current~ ./drivers/md/raid5.c
--- ./drivers/md/raid5.c~current~	2003-12-03 16:25:54.000000000 +1100
+++ ./drivers/md/raid5.c	2003-12-05 13:27:49.000000000 +1100
@@ -40,6 +40,16 @@
 
 #define stripe_hash(conf, sect)	((conf)->stripe_hashtbl[((sect) >> STRIPE_SHIFT) & HASH_MASK])
 
+/* bio's attached to a stripe+device for I/O are linked together in bi_sector
+ * order without overlap.  There may be several bio's per stripe+device, and
+ * a bio could span several devices.
+ * When walking this list for a particular stripe+device, we must never proceed
+ * beyond a bio that extends past this device, as the next bio might no longer 
+ * be valid.
+ * This macro is used to determine the 'next' bio in the list, given the sector
+ * of the current stripe+device
+ */
+#define r5_next_bio(bio, sect) ( ( bio->bi_sector + (bio->bi_size>>9) < sect + STRIPE_SECTORS) ? bio->bi_next : NULL)
 /*
  * The following can be used to debug the driver
  */
@@ -613,7 +623,7 @@ static void copy_data(int frombio, struc
 	int i;
 
 	for (;bio && bio->bi_sector < sector+STRIPE_SECTORS;
-		bio = bio->bi_next) {
+	      bio = r5_next_bio(bio, sector) ) {
 		int page_offset;
 		if (bio->bi_sector >= sector)
 			page_offset = (signed)(bio->bi_sector - sector) * 512;
@@ -738,7 +748,11 @@ static void compute_parity(struct stripe
 	for (i = disks; i--;)
 		if (sh->dev[i].written) {
 			sector_t sector = sh->dev[i].sector;
-			copy_data(1, sh->dev[i].written, sh->dev[i].page, sector);
+			struct bio *wbi = sh->dev[i].written;
+			while (wbi && wbi->bi_sector < sector + STRIPE_SECTORS) {
+				copy_data(1, wbi, sh->dev[i].page, sector);
+				wbi = r5_next_bio(wbi, sector);
+			}
 
 			set_bit(R5_LOCKED, &sh->dev[i].flags);
 			set_bit(R5_UPTODATE, &sh->dev[i].flags);
@@ -791,8 +805,10 @@ static void add_stripe_bio (struct strip
 		bip = &sh->dev[dd_idx].towrite;
 	else
 		bip = &sh->dev[dd_idx].toread;
-	while (*bip && (*bip)->bi_sector < bi->bi_sector)
+	while (*bip && (*bip)->bi_sector < bi->bi_sector) {
+		BUG_ON((*bip)->bi_sector + ((*bip)->bi_size >> 9) > bi->bi_sector);
 		bip = & (*bip)->bi_next;
+	}
 /* FIXME do I need to worry about overlapping bion */
 	if (*bip && bi->bi_next && (*bip) != bi->bi_next)
 		BUG();
@@ -813,7 +829,7 @@ static void add_stripe_bio (struct strip
 		for (bi=sh->dev[dd_idx].towrite;
 		     sector < sh->dev[dd_idx].sector + STRIPE_SECTORS &&
 			     bi && bi->bi_sector <= sector;
-		     bi = bi->bi_next) {
+		     bi = r5_next_bio(bi, sh->dev[dd_idx].sector)) {
 			if (bi->bi_sector + (bi->bi_size>>9) >= sector)
 				sector = bi->bi_sector + (bi->bi_size>>9);
 		}
@@ -883,7 +899,7 @@ static void handle_stripe(struct stripe_
 			spin_unlock_irq(&conf->device_lock);
 			while (rbi && rbi->bi_sector < dev->sector + STRIPE_SECTORS) {
 				copy_data(0, rbi, dev->page, dev->sector);
-				rbi2 = rbi->bi_next;
+				rbi2 = r5_next_bio(rbi, dev->sector);
 				spin_lock_irq(&conf->device_lock);
 				if (--rbi->bi_phys_segments == 0) {
 					rbi->bi_next = return_bi;
@@ -928,7 +944,7 @@ static void handle_stripe(struct stripe_
 			if (bi) to_write--;
 
 			while (bi && bi->bi_sector < sh->dev[i].sector + STRIPE_SECTORS){
-				struct bio *nextbi = bi->bi_next;
+				struct bio *nextbi = r5_next_bio(bi, sh->dev[i].sector);
 				clear_bit(BIO_UPTODATE, &bi->bi_flags);
 				if (--bi->bi_phys_segments == 0) {
 					md_write_end(conf->mddev);
@@ -941,7 +957,7 @@ static void handle_stripe(struct stripe_
 			bi = sh->dev[i].written;
 			sh->dev[i].written = NULL;
 			while (bi && bi->bi_sector < sh->dev[i].sector + STRIPE_SECTORS) {
-				struct bio *bi2 = bi->bi_next;
+				struct bio *bi2 = r5_next_bio(bi, sh->dev[i].sector);
 				clear_bit(BIO_UPTODATE, &bi->bi_flags);
 				if (--bi->bi_phys_segments == 0) {
 					md_write_end(conf->mddev);
@@ -957,7 +973,7 @@ static void handle_stripe(struct stripe_
 				sh->dev[i].toread = NULL;
 				if (bi) to_read--;
 				while (bi && bi->bi_sector < sh->dev[i].sector + STRIPE_SECTORS){
-					struct bio *nextbi = bi->bi_next;
+					struct bio *nextbi = r5_next_bio(bi, sh->dev[i].sector);
 					clear_bit(BIO_UPTODATE, &bi->bi_flags);
 					if (--bi->bi_phys_segments == 0) {
 						bi->bi_next = return_bi;
@@ -1000,7 +1016,7 @@ static void handle_stripe(struct stripe_
 			    wbi = dev->written;
 			    dev->written = NULL;
 			    while (wbi && wbi->bi_sector < dev->sector + STRIPE_SECTORS) {
-				    wbi2 = wbi->bi_next;
+				    wbi2 = r5_next_bio(wbi, dev->sector);
 				    if (--wbi->bi_phys_segments == 0) {
 					    md_write_end(conf->mddev);
 					    wbi->bi_next = return_bi;
