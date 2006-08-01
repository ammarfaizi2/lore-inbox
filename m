Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030420AbWHAEIz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030420AbWHAEIz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 00:08:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932378AbWHAEIz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 00:08:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:53963 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932288AbWHAEIy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 00:08:54 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Tue, 1 Aug 2006 14:08:47 +1000
Message-Id: <1060801040847.11976@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Simon Kirby <sim@netnation.com>
Subject: [PATCH] md: Fix a bug that recently crept into md/linear
References: <20060801140742.11940.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixed a bug in 2.6.18-rc3 It would be good if it can get
into -final.

Thanks,
NeilBrown


### Comments for Changeset

A recent patch that allowed linear arrays to be reconfigured on-line
allowed in a bug which results in divide by zero - not all
mddev->array_size were converted to conf->array_size.

This patch finished the conversion and fixed the bug.

The offending patch was commit 7c7546ccf6463edbeee8d9aac6de7be1cd80d08a.

Thanks to Simon Kirby <sim@netnation.com> for the bug report.

Cc: Simon Kirby <sim@netnation.com>
Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./drivers/md/linear.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff .prev/drivers/md/linear.c ./drivers/md/linear.c
--- .prev/drivers/md/linear.c	2006-08-01 11:06:15.000000000 +1000
+++ ./drivers/md/linear.c	2006-08-01 11:06:23.000000000 +1000
@@ -162,7 +162,7 @@ static linear_conf_t *linear_conf(mddev_
 		goto out;
 	}
 
-	min_spacing = mddev->array_size;
+	min_spacing = conf->array_size;
 	sector_div(min_spacing, PAGE_SIZE/sizeof(struct dev_info *));
 
 	/* min_spacing is the minimum spacing that will fit the hash
@@ -171,7 +171,7 @@ static linear_conf_t *linear_conf(mddev_
 	 * that is larger than min_spacing as use the size of that as
 	 * the actual spacing
 	 */
-	conf->hash_spacing = mddev->array_size;
+	conf->hash_spacing = conf->array_size;
 	for (i=0; i < cnt-1 ; i++) {
 		sector_t sz = 0;
 		int j;
@@ -228,7 +228,7 @@ static linear_conf_t *linear_conf(mddev_
 	curr_offset = 0;
 	i = 0;
 	for (curr_offset = 0;
-	     curr_offset < mddev->array_size;
+	     curr_offset < conf->array_size;
 	     curr_offset += conf->hash_spacing) {
 
 		while (i < mddev->raid_disks-1 &&
