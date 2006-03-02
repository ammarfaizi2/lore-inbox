Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751162AbWCBGNo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751162AbWCBGNo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 01:13:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbWCBGNo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 01:13:44 -0500
Received: from cantor.suse.de ([195.135.220.2]:48814 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751162AbWCBGNo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 01:13:44 -0500
From: Neil Brown <neilb@suse.de>
To: "matteo brancaleoni" <mbrancaleoni@gmail.com>
Date: Thu, 2 Mar 2006 17:12:49 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17414.36065.898271.383401@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Bio & Biovec-1 increasing cache size, never freed during disk IO
In-Reply-To: message from matteo brancaleoni on Wednesday March 1
References: <d6fe45ba0602251245h32b9ac5dw65246ed6e1bba607@mail.gmail.com>
	<d6fe45ba0602271238q10fea0f8tfc29f0d51c4df1c8@mail.gmail.com>
	<17411.33114.403066.812228@cse.unsw.edu.au>
	<d6fe45ba0602280705l6f38f1b8j3126d0be638be8fa@mail.gmail.com>
	<17412.56916.247822.749271@cse.unsw.edu.au>
	<d6fe45ba0603010246j15132126x3cb233092319c772@mail.gmail.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday March 1, mbrancaleoni@gmail.com wrote:
> Hi Neil.
> 
> unfortunately the patch does nothing, the problem persists.
> Tested with 2.6.16-rc5.
> (I've double checked if the patch was applied correctly)
> 
> Can I do anything to be of some more help?

Yes, try another patch. :-)  and tell me if you have CONFIG_DEBUG_SLAB
set... there was another use-after-free bug which CONFIG_DEBUG_SLAB
would have made worse.

This patch should fix it all up.

Thanks again,
NeilBrown


Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./drivers/md/raid1.c |   13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff ./drivers/md/raid1.c~current~ ./drivers/md/raid1.c
--- ./drivers/md/raid1.c~current~	2006-02-27 11:52:18.000000000 +1100
+++ ./drivers/md/raid1.c	2006-03-01 10:44:49.000000000 +1100
@@ -306,6 +306,7 @@ static int raid1_end_write_request(struc
 	r1bio_t * r1_bio = (r1bio_t *)(bio->bi_private);
 	int mirror, behind = test_bit(R1BIO_BehindIO, &r1_bio->state);
 	conf_t *conf = mddev_to_conf(r1_bio->mddev);
+	struct bio *to_put = NULL;
 
 	if (bio->bi_size)
 		return 1;
@@ -323,6 +324,7 @@ static int raid1_end_write_request(struc
 		 * this branch is our 'one mirror IO has finished' event handler:
 		 */
 		r1_bio->bios[mirror] = NULL;
+		to_put = bio;
 		if (!uptodate) {
 			md_error(r1_bio->mddev, conf->mirrors[mirror].rdev);
 			/* an I/O failed, we can't clear the bitmap */
@@ -375,7 +377,7 @@ static int raid1_end_write_request(struc
 			/* Don't dec_pending yet, we want to hold
 			 * the reference over the retry
 			 */
-			return 0;
+			goto out;
 		}
 		if (test_bit(R1BIO_BehindIO, &r1_bio->state)) {
 			/* free extra copy of the data pages */
@@ -392,10 +394,11 @@ static int raid1_end_write_request(struc
 		raid_end_bio_io(r1_bio);
 	}
 
-	if (r1_bio->bios[mirror]==NULL)
-		bio_put(bio);
-
 	rdev_dec_pending(conf->mirrors[mirror].rdev, conf->mddev);
+ out:
+	if (to_put)
+		bio_put(to_put);
+
 	return 0;
 }
 
@@ -857,7 +860,7 @@ static int make_request(request_queue_t 
 	atomic_set(&r1_bio->remaining, 0);
 	atomic_set(&r1_bio->behind_remaining, 0);
 
-	do_barriers = bio->bi_rw & BIO_RW_BARRIER;
+	do_barriers = bio_barrier(bio);
 	if (do_barriers)
 		set_bit(R1BIO_Barrier, &r1_bio->state);
 
