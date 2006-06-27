Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030680AbWF0HI5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030680AbWF0HI5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 03:08:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030703AbWF0HFt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 03:05:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:59299 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030675AbWF0HFV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 03:05:21 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Tue, 27 Jun 2006 17:05:15 +1000
Message-Id: <1060627070515.25974@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 002 of 12] md: Set desc_nr correctly for version-1 superblocks.
References: <20060627170010.25835.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This has to be done in ->load_super, not ->validate_super

Without this, hot-adding devices to an array doesn't always
work right - though there is a work around in mdadm-2.5.2 to
make this less of an issue.

### Diffstat output
 ./drivers/md/md.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff .prev/drivers/md/md.c ./drivers/md/md.c
--- .prev/drivers/md/md.c	2006-06-27 12:15:17.000000000 +1000
+++ ./drivers/md/md.c	2006-06-27 12:17:32.000000000 +1000
@@ -1064,6 +1064,11 @@ static int super_1_load(mdk_rdev_t *rdev
 	if (rdev->sb_size & bmask)
 		rdev-> sb_size = (rdev->sb_size | bmask)+1;
 
+	if (sb->level == cpu_to_le32(LEVEL_MULTIPATH))
+		rdev->desc_nr = -1;
+	else
+		rdev->desc_nr = le32_to_cpu(sb->dev_number);
+
 	if (refdev == 0)
 		ret = 1;
 	else {
@@ -1173,7 +1178,6 @@ static int super_1_validate(mddev_t *mdd
 	}
 	if (mddev->level != LEVEL_MULTIPATH) {
 		int role;
-		rdev->desc_nr = le32_to_cpu(sb->dev_number);
 		role = le16_to_cpu(sb->dev_roles[rdev->desc_nr]);
 		switch(role) {
 		case 0xffff: /* spare */
