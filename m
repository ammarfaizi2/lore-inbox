Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965002AbWI2Cxt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965002AbWI2Cxt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 22:53:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964948AbWI2Cxs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 22:53:48 -0400
Received: from cantor.suse.de ([195.135.220.2]:28047 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751381AbWI2CxX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 22:53:23 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Fri, 29 Sep 2006 12:53:16 +1000
Message-Id: <1060929025316.15249@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 004 of 6] md: Use ffz instead of find_first_set to convert multiplier to shift.
References: <20060929125047.14064.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Paul Clements <paul.clements@steeleye.com>

find_first_set doesn't find the least-significant bit on bigendian
machines, so it is really wrong to use it.

ffs is closer, but takes an 'int' and we have a 'unsigned long'.
So use ffz(~X) to convert a chunksize into a chunkshift.


Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./drivers/md/bitmap.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff .prev/drivers/md/bitmap.c ./drivers/md/bitmap.c
--- .prev/drivers/md/bitmap.c	2006-09-29 11:44:38.000000000 +1000
+++ ./drivers/md/bitmap.c	2006-09-29 11:49:40.000000000 +1000
@@ -1444,8 +1444,7 @@ int bitmap_create(mddev_t *mddev)
 	if (err)
 		goto error;
 
-	bitmap->chunkshift = find_first_bit(&bitmap->chunksize,
-					sizeof(bitmap->chunksize));
+	bitmap->chunkshift = ffz(~bitmap->chunksize);
 
 	/* now that chunksize and chunkshift are set, we can use these macros */
  	chunks = (blocks + CHUNK_BLOCK_RATIO(bitmap) - 1) /
