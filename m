Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750936AbWELGHt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750936AbWELGHt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 02:07:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750942AbWELGHt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 02:07:49 -0400
Received: from ns2.suse.de ([195.135.220.15]:12231 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750934AbWELGHs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 02:07:48 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Fri, 12 May 2006 16:07:31 +1000
Message-Id: <1060512060731.7994@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
       Paul Clements <paul.clements@steeleye.com>
Subject: [PATCH 001 of 8] md/bitmap: Fix online removal of file-backed bitmaps
References: <20060512160121.7872.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


When "mdadm --grow /dev/mdX --bitmap=none" is used to remove
a filebacked bitmap, the bitmap was disconnected from the array,
but the file wasn't closed (until the array was stopped).

The file also wasn't closed if adding the bitmap file failed.

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./drivers/md/md.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff ./drivers/md/md.c~current~ ./drivers/md/md.c
--- ./drivers/md/md.c~current~	2006-05-12 15:49:10.000000000 +1000
+++ ./drivers/md/md.c	2006-05-12 15:54:48.000000000 +1000
@@ -3588,10 +3588,13 @@ static int set_bitmap_file(mddev_t *mdde
 		mddev->pers->quiesce(mddev, 1);
 		if (fd >= 0)
 			err = bitmap_create(mddev);
-		if (fd < 0 || err)
+		if (fd < 0 || err) {
 			bitmap_destroy(mddev);
+			fd = -1; /* make sure to put the file */
+		}
 		mddev->pers->quiesce(mddev, 0);
-	} else if (fd < 0) {
+	}
+	if (fd < 0) {
 		if (mddev->bitmap_file)
 			fput(mddev->bitmap_file);
 		mddev->bitmap_file = NULL;
