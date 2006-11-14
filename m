Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933241AbWKNAWh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933241AbWKNAWh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 19:22:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933243AbWKNAWh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 19:22:37 -0500
Received: from cantor.suse.de ([195.135.220.2]:31641 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S933240AbWKNAWg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 19:22:36 -0500
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Tue, 14 Nov 2006 11:22:28 +1100
Message-Id: <1061114002228.31156@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 001 of 4] md: Fix innocuous bug in raid6 stripe_to_pdidx
References: <20061114111600.31061.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


stripe_to_pdidx finds the index of the parity disk for a given
stripe.
It assumes raid5 in that it uses "disks-1" to determine the number
of data disks.

This is incorrect for raid6 but fortunately the two usages cancel each
other out.  The only way that 'data_disks' affects the calculation of
pd_idx in raid5_compute_sector is when it is divided into the
sector number.  But as that sector number is calculated by multiplying
in the wrong value of 'data_disks' the division produces the right
value.

So it is innocuous but needs to be fixed.

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./drivers/md/raid5.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff .prev/drivers/md/raid5.c ./drivers/md/raid5.c
--- .prev/drivers/md/raid5.c	2006-11-14 10:05:00.000000000 +1100
+++ ./drivers/md/raid5.c	2006-11-14 10:33:41.000000000 +1100
@@ -1355,8 +1355,10 @@ static int stripe_to_pdidx(sector_t stri
 	int pd_idx, dd_idx;
 	int chunk_offset = sector_div(stripe, sectors_per_chunk);
 
-	raid5_compute_sector(stripe*(disks-1)*sectors_per_chunk
-			     + chunk_offset, disks, disks-1, &dd_idx, &pd_idx, conf);
+	raid5_compute_sector(stripe * (disks - conf->max_degraded)
+			     *sectors_per_chunk + chunk_offset,
+			     disks, disks - conf->max_degraded,
+			     &dd_idx, &pd_idx, conf);
 	return pd_idx;
 }
 
