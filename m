Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753810AbWKMFCI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753810AbWKMFCI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 00:02:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753885AbWKMFCI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 00:02:08 -0500
Received: from mail.suse.de ([195.135.220.2]:21466 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1753810AbWKMFCF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 00:02:05 -0500
From: Neil Brown <neilb@suse.de>
To: Jurriaan <thunder7@xs4all.nl>
Date: Mon, 13 Nov 2006 16:01:59 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17751.64583.924110.954687@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: trouble with mounting a 1.5 TB raid6 volume in 2.6.19-rc5-mm1
In-Reply-To: message from jurriaan on Saturday November 11
References: <20061111183835.GA3801@amd64.of.nowhere>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday November 11, thunder7@xs4all.nl wrote:
> I have a 8 disk 1.5 TB raid6 volume that won't mount in 2.6.19-rc5-mm1.
> Below the output of trying to mount the ext3 volume, which fails, and
> the very wrong output after mounting it as ext2. Also, mdstat details,
> .config and dmesg output.
> 
> This volume works just fine in 2.6.18-mm3 or 2.6.19-rc2-mm2. I'm willing
> to test, but I'm not that willing to wreck my volume :-)

Can you try reverting this patch (patch -p1 -R) ?

It is the most likely candidate.  Meanwhile I look to see if I can
see how this could be happening.

NeilBrown


--------------------------
Enable bypassing cache for reads.

From: "Raz Ben-Jehuda(caro)" <raziebe@gmail.com>

Call the chunk_aligned_read where appropriate.

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./drivers/md/raid5.c |    5 +++++
 1 file changed, 5 insertions(+)

diff .prev/drivers/md/raid5.c ./drivers/md/raid5.c
--- .prev/drivers/md/raid5.c	2006-11-06 11:29:14.000000000 +1100
+++ ./drivers/md/raid5.c	2006-11-06 11:29:14.000000000 +1100
@@ -2798,6 +2798,11 @@ static int make_request(request_queue_t 
 	disk_stat_inc(mddev->gendisk, ios[rw]);
 	disk_stat_add(mddev->gendisk, sectors[rw], bio_sectors(bi));
 
+	if ( bio_data_dir(bi) == READ &&
+	     mddev->reshape_position == MaxSector &&
+	     chunk_aligned_read(q,bi))
+            		return 0;
+
 	logical_sector = bi->bi_sector & ~((sector_t)STRIPE_SECTORS-1);
 	last_sector = bi->bi_sector + (bi->bi_size>>9);
 	bi->bi_next = NULL;
