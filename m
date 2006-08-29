Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751197AbWH2Fkk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751197AbWH2Fkk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 01:40:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751189AbWH2Fki
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 01:40:38 -0400
Received: from mx1.suse.de ([195.135.220.2]:13472 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751174AbWH2FkE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 01:40:04 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Tue, 29 Aug 2006 15:39:59 +1000
Message-Id: <1060829053959.6664@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 004 of 4] md: Make messages about resync/recovery etc more specific.
References: <20060829153414.6475.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It is possible to request a 'check' of an md/raid array where
the whole array is read and consistancies are reported.

This uses the same mechanisms as 'resync' and so reports in the
kernel logs that a resync is being started.
This understandably confuses/worries people.

Also the text in /proc/mdstat suggests a 'resync' is happen when it is
just a check.

This patch changes those messages to be more specific about
what is happening.

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./drivers/md/md.c |   47 +++++++++++++++++++++++++++++++----------------
 1 file changed, 31 insertions(+), 16 deletions(-)

diff .prev/drivers/md/md.c ./drivers/md/md.c
--- .prev/drivers/md/md.c	2006-08-29 15:22:40.000000000 +1000
+++ ./drivers/md/md.c	2006-08-29 15:23:57.000000000 +1000
@@ -4641,9 +4641,11 @@ static void status_resync(struct seq_fil
 	seq_printf(seq, " %s =%3u.%u%% (%llu/%llu)",
 		   (test_bit(MD_RECOVERY_RESHAPE, &mddev->recovery)?
 		    "reshape" :
-		      (test_bit(MD_RECOVERY_SYNC, &mddev->recovery) ?
-		       "resync" : "recovery")),
-		      per_milli/10, per_milli % 10,
+		    (test_bit(MD_RECOVERY_CHECK, &mddev->recovery)?
+		     "check" :
+		     (test_bit(MD_RECOVERY_SYNC, &mddev->recovery) ?
+		      "resync" : "recovery"))),
+		   per_milli/10, per_milli % 10,
 		   (unsigned long long) resync,
 		   (unsigned long long) max_blocks);
 
@@ -5032,6 +5034,7 @@ void md_do_sync(mddev_t *mddev)
 	int skipped = 0;
 	struct list_head *rtmp;
 	mdk_rdev_t *rdev;
+	char *desc;
 
 	/* just incase thread restarts... */
 	if (test_bit(MD_RECOVERY_DONE, &mddev->recovery))
@@ -5039,6 +5042,18 @@ void md_do_sync(mddev_t *mddev)
 	if (mddev->ro) /* never try to sync a read-only array */
 		return;
 
+	if (test_bit(MD_RECOVERY_SYNC, &mddev->recovery)) {
+		if (test_bit(MD_RECOVERY_CHECK, &mddev->recovery))
+			desc = "data-check";
+		else if (test_bit(MD_RECOVERY_REQUESTED, &mddev->recovery))
+			desc = "requested-resync";
+		else
+			desc = "resync";
+	} else if (test_bit(MD_RECOVERY_RESHAPE, &mddev->recovery))
+		desc = "reshape";
+	else
+		desc = "recovery";
+
 	/* we overload curr_resync somewhat here.
 	 * 0 == not engaged in resync at all
 	 * 2 == checking that there is no conflict with another sync
@@ -5082,10 +5097,10 @@ void md_do_sync(mddev_t *mddev)
 				prepare_to_wait(&resync_wait, &wq, TASK_UNINTERRUPTIBLE);
 				if (!kthread_should_stop() &&
 				    mddev2->curr_resync >= mddev->curr_resync) {
-					printk(KERN_INFO "md: delaying resync of %s"
-					       " until %s has finished resync (they"
+					printk(KERN_INFO "md: delaying %s of %s"
+					       " until %s has finished (they"
 					       " share one or more physical units)\n",
-					       mdname(mddev), mdname(mddev2));
+					       desc, mdname(mddev), mdname(mddev2));
 					mddev_put(mddev2);
 					schedule();
 					finish_wait(&resync_wait, &wq);
@@ -5121,12 +5136,12 @@ void md_do_sync(mddev_t *mddev)
 				j = rdev->recovery_offset;
 	}
 
-	printk(KERN_INFO "md: syncing RAID array %s\n", mdname(mddev));
-	printk(KERN_INFO "md: minimum _guaranteed_ reconstruction speed:"
-		" %d KB/sec/disc.\n", speed_min(mddev));
+	printk(KERN_INFO "md: %s of RAID array %s\n", desc, mdname(mddev));
+	printk(KERN_INFO "md: minimum _guaranteed_  speed:"
+		" %d KB/sec/disk.\n", speed_min(mddev));
 	printk(KERN_INFO "md: using maximum available idle IO bandwidth "
-	       "(but not more than %d KB/sec) for reconstruction.\n",
-	       speed_max(mddev));
+	       "(but not more than %d KB/sec) for %s.\n",
+	       speed_max(mddev), desc);
 
 	is_mddev_idle(mddev); /* this also initializes IO event counters */
 
@@ -5152,8 +5167,8 @@ void md_do_sync(mddev_t *mddev)
 
 	if (j>2) {
 		printk(KERN_INFO 
-			"md: resuming recovery of %s from checkpoint.\n",
-			mdname(mddev));
+		       "md: resuming %s of %s from checkpoint.\n",
+		       desc, mdname(mddev));
 		mddev->curr_resync = j;
 	}
 
@@ -5236,7 +5251,7 @@ void md_do_sync(mddev_t *mddev)
 			}
 		}
 	}
-	printk(KERN_INFO "md: %s: sync done.\n",mdname(mddev));
+	printk(KERN_INFO "md: %s: %s done.\n",mdname(mddev), desc);
 	/*
 	 * this also signals 'finished resyncing' to md_stop
 	 */
@@ -5256,8 +5271,8 @@ void md_do_sync(mddev_t *mddev)
 			if (test_bit(MD_RECOVERY_INTR, &mddev->recovery)) {
 				if (mddev->curr_resync >= mddev->recovery_cp) {
 					printk(KERN_INFO
-					       "md: checkpointing recovery of %s.\n",
-					       mdname(mddev));
+					       "md: checkpointing %s of %s.\n",
+					       desc, mdname(mddev));
 					mddev->recovery_cp = mddev->curr_resync;
 				}
 			} else
