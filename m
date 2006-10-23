Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751661AbWJWHIe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751661AbWJWHIe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 03:08:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751662AbWJWHIU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 03:08:20 -0400
Received: from ns.suse.de ([195.135.220.2]:56970 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751643AbWJWHIC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 03:08:02 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Mon, 23 Oct 2006 17:07:54 +1000
Message-Id: <1061023070754.29236@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 002 of 4] md: Simplify checking of available size when resizing an array
References: <20061023170347.29132.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


When "mdadm --grow --size=xxx" is used to resize an array (use more or
less of each device), we check the new siza against the available
space in each device.

The already have that number recorded in rdev->size, so calculating it
is pointless (and wrong in one obscure case).

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./drivers/md/md.c |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff .prev/drivers/md/md.c ./drivers/md/md.c
--- .prev/drivers/md/md.c	2006-10-23 16:35:05.000000000 +1000
+++ ./drivers/md/md.c	2006-10-23 16:35:21.000000000 +1000
@@ -4047,11 +4047,8 @@ static int update_size(mddev_t *mddev, u
 		return -EBUSY;
 	ITERATE_RDEV(mddev,rdev,tmp) {
 		sector_t avail;
-		if (rdev->sb_offset > rdev->data_offset)
-			avail = (rdev->sb_offset*2) - rdev->data_offset;
-		else
-			avail = get_capacity(rdev->bdev->bd_disk)
-				- rdev->data_offset;
+		avail = rdev->size * 2;
+
 		if (fit && (size == 0 || size > avail/2))
 			size = avail/2;
 		if (avail < ((sector_t)size << 1))
