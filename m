Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423161AbWCXGCF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423161AbWCXGCF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 01:02:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423159AbWCXGCF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 01:02:05 -0500
Received: from cantor2.suse.de ([195.135.220.15]:31130 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1423152AbWCXGCC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 01:02:02 -0500
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Fri, 24 Mar 2006 17:00:01 +1100
Message-Id: <1060324060001.2459@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 002 of 3] md: Fix md grow/size code to correctly find the maximum available space.
References: <20060324165531.2372.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


An md array can be asked to change the amount of each device that it
is using, and in particular can be asked to use the maximum available
space.  This currently only works if the first device is not larger
than the rest.  As 'size' gets changed and so 'fit' becomes wrong.
So check if a 'fit' is required early and don't corrupt it.

Signed-off-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./drivers/md/md.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff ./drivers/md/md.c~current~ ./drivers/md/md.c
--- ./drivers/md/md.c~current~	2006-03-24 14:01:30.000000000 +1100
+++ ./drivers/md/md.c	2006-03-24 14:06:49.000000000 +1100
@@ -3575,6 +3575,7 @@ static int update_size(mddev_t *mddev, u
 	mdk_rdev_t * rdev;
 	int rv;
 	struct list_head *tmp;
+	int fit = (size == 0);
 
 	if (mddev->pers->resize == NULL)
 		return -EINVAL;
@@ -3592,7 +3593,6 @@ static int update_size(mddev_t *mddev, u
 		return -EBUSY;
 	ITERATE_RDEV(mddev,rdev,tmp) {
 		sector_t avail;
-		int fit = (size == 0);
 		if (rdev->sb_offset > rdev->data_offset)
 			avail = (rdev->sb_offset*2) - rdev->data_offset;
 		else
