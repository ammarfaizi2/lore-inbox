Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423159AbWCXGCm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423159AbWCXGCm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 01:02:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423162AbWCXGCl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 01:02:41 -0500
Received: from cantor2.suse.de ([195.135.220.15]:33434 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1423159AbWCXGCk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 01:02:40 -0500
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Fri, 24 Mar 2006 17:00:36 +1100
Message-Id: <1060324060036.2474@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 003 of 3] md: Restore 'remaining' count when retrying an write operation.
References: <20060324165531.2372.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


When retrying a write due to barrier failure, we don't reset
'remaining', so it goes negative and never hits 0 again.


Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./drivers/md/raid1.c |    3 +++
 1 file changed, 3 insertions(+)

diff ./drivers/md/raid1.c~current~ ./drivers/md/raid1.c
--- ./drivers/md/raid1.c~current~	2006-03-24 14:01:30.000000000 +1100
+++ ./drivers/md/raid1.c	2006-03-24 14:06:49.000000000 +1100
@@ -1402,6 +1402,9 @@ static void raid1d(mddev_t *mddev)
 			clear_bit(R1BIO_BarrierRetry, &r1_bio->state);
 			clear_bit(R1BIO_Barrier, &r1_bio->state);
 			for (i=0; i < conf->raid_disks; i++)
+				if (r1_bio->bios[i])
+					atomic_inc(&r1_bio->remaining);
+			for (i=0; i < conf->raid_disks; i++)
 				if (r1_bio->bios[i]) {
 					struct bio_vec *bvec;
 					int j;
