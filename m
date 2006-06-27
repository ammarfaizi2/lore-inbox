Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030710AbWF0HI4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030710AbWF0HI4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 03:08:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030680AbWF0HFr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 03:05:47 -0400
Received: from ns1.suse.de ([195.135.220.2]:20355 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030684AbWF0HF0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 03:05:26 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Tue, 27 Jun 2006 17:05:20 +1000
Message-Id: <1060627070520.25986@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 003 of 12] md: Delay starting md threads until array is completely setup.
References: <20060627170010.25835.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


When an array is started we start one or two threads (two if
there is a reshape or recovery that needs to be completed).

We currently start these *before* the array is completely set up and
in particular before queue->queuedata is set.  If the thread
actually starts very quickly on another CPU, we can end up
dereferencing queue->queuedata and oops.

This patch also makes sure we don't try to start a recovery if
a reshape is being restarted.

### Diffstat output
 ./drivers/md/md.c    |   10 +++++-----
 ./drivers/md/raid5.c |    3 ---
 2 files changed, 5 insertions(+), 8 deletions(-)

diff .prev/drivers/md/md.c ./drivers/md/md.c
--- .prev/drivers/md/md.c	2006-06-27 12:17:32.000000000 +1000
+++ ./drivers/md/md.c	2006-06-27 12:17:32.000000000 +1000
@@ -3100,8 +3100,7 @@ static int do_md_run(mddev_t * mddev)
 		}
 	
 	set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
-	md_wakeup_thread(mddev->thread);
	
+
 	if (mddev->sb_dirty)
 		md_update_sb(mddev);
 
@@ -3121,7 +3120,7 @@ static int do_md_run(mddev_t * mddev)
 	 * start recovery here.  If we leave it to md_check_recovery,
 	 * it will remove the drives and not do the right thing
 	 */
-	if (mddev->degraded) {
+	if (mddev->degraded && !mddev->sync_thread) {
 		struct list_head *rtmp;
 		int spares = 0;
 		ITERATE_RDEV(mddev,rdev,rtmp)
@@ -3142,10 +3141,11 @@ static int do_md_run(mddev_t * mddev)
 				       mdname(mddev));
 				/* leave the spares where they are, it shouldn't hurt */
 				mddev->recovery = 0;
-			} else
-				md_wakeup_thread(mddev->sync_thread);
+			}
 		}
 	}
+	md_wakeup_thread(mddev->thread);
+	md_wakeup_thread(mddev->sync_thread); /* possibly kick off a reshape */
 
 	mddev->changed = 1;
 	md_new_event(mddev);

diff .prev/drivers/md/raid5.c ./drivers/md/raid5.c
--- .prev/drivers/md/raid5.c	2006-06-27 12:16:41.000000000 +1000
+++ ./drivers/md/raid5.c	2006-06-27 12:17:32.000000000 +1000
@@ -3248,9 +3248,6 @@ static int run(mddev_t *mddev)
 		set_bit(MD_RECOVERY_RUNNING, &mddev->recovery);
 		mddev->sync_thread = md_register_thread(md_do_sync, mddev,
 							"%s_reshape");
-		/* FIXME if md_register_thread fails?? */
-		md_wakeup_thread(mddev->sync_thread);
-
 	}
 
 	/* read-ahead size must cover two whole stripes, which is
