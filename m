Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261961AbVACXcn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261961AbVACXcn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 18:32:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261954AbVACXcM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 18:32:12 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:39610 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S261960AbVACXbA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 18:31:00 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Kristian Eide <kreide@online.no>
Date: Tue, 4 Jan 2005 10:30:34 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16857.54682.183762.561368@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: raid5 crash (possible VM problem???)
In-Reply-To: message from Kristian Eide on Thursday December 23
References: <200412222304.36585.kreide@online.no>
	<16841.65119.240314.917998@cse.unsw.edu.au>
	<200412232045.26137.kreide@online.no>
X-Mailer: VM 7.19 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday December 23, kreide@online.no wrote:
> > I doubt very much that this would happen with ext3.  I don't know
> > about xfs, but I doubt it would happen their either.
> > When using some other filesystem, what sort of data corruption are you
> > getting?
> 
> This is with ext3:
> 
> kernel BUG at drivers/md/raid5.c:813!

This is very suspect...
This BUG is triggered if raid5 receives a read request while there is
already an outstanding read request that overlaps the new one.
i.e. this->sector  < that->sector and
     this->sector + this->size > that->sector

I admit that my understanding of ext3 isn't perfect, but I would be VERY
surprised if ext3 would ever submit overlapping requests.  
I guess it could happen if the filesystem were corrupted (and two
files claimed to own the same block) but I doubt that is the case
here.

I suspect there is a problem somewhere else.. in the VM maybe??

You could try this patch.  It might hide the real problem, or it might
cause it to manifest in some other way.
It changes the raid5 behaviour so that if an overlap is found, it
doesn't BUG, but instead waits a little while and tries again.

NeilBrown

Signed-off-by: Neil Brown <neilb@cse.unsw.edu.au>

### Diffstat output
 ./drivers/md/raid5.c |   18 ++++++++++++++----
 1 files changed, 14 insertions(+), 4 deletions(-)

diff ./drivers/md/raid5.c~current~ ./drivers/md/raid5.c
--- ./drivers/md/raid5.c~current~	2004-12-20 12:24:19.000000000 +1100
+++ ./drivers/md/raid5.c	2004-12-28 17:02:44.000000000 +1100
@@ -232,6 +232,7 @@ static struct stripe_head *__find_stripe
 }
 
 static void unplug_slaves(mddev_t *mddev);
+static void raid5_unplug_device(request_queue_t *q);
 
 static struct stripe_head *get_active_stripe(raid5_conf_t *conf, sector_t sector,
 					     int pd_idx, int noblock) 
@@ -793,7 +794,7 @@ static void compute_parity(struct stripe
  * toread/towrite point to the first in a chain. 
  * The bi_next chain must be in order.
  */
-static void add_stripe_bio (struct stripe_head *sh, struct bio *bi, int dd_idx, int forwrite)
+static int add_stripe_bio (struct stripe_head *sh, struct bio *bi, int dd_idx, int forwrite)
 {
 	struct bio **bip;
 	raid5_conf_t *conf = sh->raid_conf;
@@ -810,10 +811,10 @@ static void add_stripe_bio (struct strip
 	else
 		bip = &sh->dev[dd_idx].toread;
 	while (*bip && (*bip)->bi_sector < bi->bi_sector) {
-		BUG_ON((*bip)->bi_sector + ((*bip)->bi_size >> 9) > bi->bi_sector);
+		if ((*bip)->bi_sector + ((*bip)->bi_size >> 9) > bi->bi_sector)
+			return 0; /* cannot add just now due to overlap */
 		bip = & (*bip)->bi_next;
 	}
-/* FIXME do I need to worry about overlapping bion */
 	if (*bip && bi->bi_next && (*bip) != bi->bi_next)
 		BUG();
 	if (*bip)
@@ -840,6 +841,7 @@ static void add_stripe_bio (struct strip
 		if (sector >= sh->dev[dd_idx].sector + STRIPE_SECTORS)
 			set_bit(R5_OVERWRITE, &sh->dev[dd_idx].flags);
 	}
+	return 1;
 }
 
 
@@ -1413,7 +1415,15 @@ static int make_request (request_queue_t
 		sh = get_active_stripe(conf, new_sector, pd_idx, (bi->bi_rw&RWA_MASK));
 		if (sh) {
 
-			add_stripe_bio(sh, bi, dd_idx, (bi->bi_rw&RW_MASK));
+			while (!add_stripe_bio(sh, bi, dd_idx, (bi->bi_rw&RW_MASK))) {
+				/* add failed due to overlap.  Flush everything
+				 * and wait a while
+				 * FIXME - overlapping requests should be handled better
+				 */
+				raid5_unplug_device(mddev->queue);
+				set_current_state(TASK_UNINTERRUPTIBLE);
+				schedule_timeout(1);
+			}
 
 			raid5_plug_device(conf);
 			handle_stripe(sh);
