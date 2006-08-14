Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751879AbWHNGOM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751879AbWHNGOM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 02:14:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751875AbWHNGOM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 02:14:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:2747 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751872AbWHNGOL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 02:14:11 -0400
From: Neil Brown <neilb@suse.de>
To: Chuck Ebbert <76306.1226@compuserve.com>
Date: Mon, 14 Aug 2006 16:14:06 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17632.5294.559058.66914@cse.unsw.edu.au>
Cc: linux-raid <linux-raid@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [bug?] raid1 integrity checking is broken on 2.6.18-rc4
In-Reply-To: message from Chuck Ebbert on Saturday August 12
References: <200608120252_MC3-1-C7DD-BA91@compuserve.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday August 12, 76306.1226@compuserve.com wrote:
> Doing this on a raid1 array:
>         echo "check" >/sys/block/md0/md/sync_action
> 
> On 2.6.16.27:
>         Activity lights on both mirrors show activity for a while,
>         then the array status prints on the console.
> 
> On 2.6.18-rc4 + the below patch:
>         Drive activity light blinks once on one drive, then the
>         array status prints (obviously no checking takes place.)
> 

Thanks for the report.
Easily duplicated, easily fixed.
I'll make sure this patch gets into 2.6.18.

Thanks again,
NeilBrown

Signed-off-by: Neil Brown <neilb@suse.de>

diff .prev/drivers/md/raid1.c ./drivers/md/raid1.c
--- .prev/drivers/md/raid1.c	2006-07-31 17:24:36.000000000 +1000
+++ ./drivers/md/raid1.c	2006-08-14 15:52:48.000000000 +1000
@@ -1644,15 +1644,16 @@ static sector_t sync_request(mddev_t *md
 		return 0;
 	}
 
-	/* before building a request, check if we can skip these blocks..
-	 * This call the bitmap_start_sync doesn't actually record anything
-	 */
 	if (mddev->bitmap == NULL &&
 	    mddev->recovery_cp == MaxSector &&
+	    !test_bit(MD_RECOVERY_REQUESTED, &mddev->recovery) &&
 	    conf->fullsync == 0) {
 		*skipped = 1;
 		return max_sector - sector_nr;
 	}
+	/* before building a request, check if we can skip these blocks..
+	 * This call the bitmap_start_sync doesn't actually record anything
+	 */
 	if (!bitmap_start_sync(mddev->bitmap, sector_nr, &sync_blocks, 1) &&
 	    !conf->fullsync && !test_bit(MD_RECOVERY_REQUESTED, &mddev->recovery)) {
 		/* We can skip this block, and probably several more */

