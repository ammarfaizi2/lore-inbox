Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752504AbWCQEtQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752504AbWCQEtQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 23:49:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752492AbWCQEtO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 23:49:14 -0500
Received: from mx1.suse.de ([195.135.220.2]:43753 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751354AbWCQEsw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 23:48:52 -0500
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Fri, 17 Mar 2006 15:47:35 +1100
Message-Id: <1060317044735.16047@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 003 of 13] md: Update status_resync to handle LARGE devices.
References: <20060317154017.15880.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


status_resync - used by /proc/mdstat to report the status of a resync,
assumes that device sizes will always fit into an 'unsigned long' This
is no longer the case...

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./drivers/md/md.c |   30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff ./drivers/md/md.c~current~ ./drivers/md/md.c
--- ./drivers/md/md.c~current~	2006-03-17 11:48:08.000000000 +1100
+++ ./drivers/md/md.c	2006-03-17 11:48:30.000000000 +1100
@@ -4040,7 +4040,10 @@ static void status_unused(struct seq_fil
 
 static void status_resync(struct seq_file *seq, mddev_t * mddev)
 {
-	unsigned long max_blocks, resync, res, dt, db, rt;
+	sector_t max_blocks, resync, res;
+	unsigned long dt, db, rt;
+	int scale;
+	unsigned int per_milli;
 
 	resync = (mddev->curr_resync - atomic_read(&mddev->recovery_active))/2;
 
@@ -4056,9 +4059,22 @@ static void status_resync(struct seq_fil
 		MD_BUG();
 		return;
 	}
-	res = (resync/1024)*1000/(max_blocks/1024 + 1);
+	/* Pick 'scale' such that (resync>>scale)*1000 will fit
+	 * in a sector_t, and (max_blocks>>scale) will fit in a
+	 * u32, as those are the requirements for sector_div.
+	 * Thus 'scale' must be at least 10
+	 */
+	scale = 10;
+	if (sizeof(sector_t) > sizeof(unsigned long)) {
+		while ( max_blocks/2 > (1ULL<<(scale+32)))
+			scale++;
+	}
+	res = (resync>>scale)*1000;
+	sector_div(res, (u32)((max_blocks>>scale)+1));
+
+	per_milli = res;
 	{
-		int i, x = res/50, y = 20-x;
+		int i, x = per_milli/50, y = 20-x;
 		seq_printf(seq, "[");
 		for (i = 0; i < x; i++)
 			seq_printf(seq, "=");
@@ -4067,10 +4083,12 @@ static void status_resync(struct seq_fil
 			seq_printf(seq, ".");
 		seq_printf(seq, "] ");
 	}
-	seq_printf(seq, " %s =%3lu.%lu%% (%lu/%lu)",
+	seq_printf(seq, " %s =%3u.%u%% (%llu/%llu)",
 		      (test_bit(MD_RECOVERY_SYNC, &mddev->recovery) ?
 		       "resync" : "recovery"),
-		      res/10, res % 10, resync, max_blocks);
+		      per_milli/10, per_milli % 10,
+		   (unsigned long long) resync,
+		   (unsigned long long) max_blocks);
 
 	/*
 	 * We do not want to overflow, so the order of operands and
@@ -4084,7 +4102,7 @@ static void status_resync(struct seq_fil
 	dt = ((jiffies - mddev->resync_mark) / HZ);
 	if (!dt) dt++;
 	db = resync - (mddev->resync_mark_cnt/2);
-	rt = (dt * ((max_blocks-resync) / (db/100+1)))/100;
+	rt = (dt * ((unsigned long)(max_blocks-resync) / (db/100+1)))/100;
 
 	seq_printf(seq, " finish=%lu.%lumin", rt / 60, (rt % 60)/6);
 
