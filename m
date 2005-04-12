Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262116AbVDLSfP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262116AbVDLSfP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 14:35:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262339AbVDLSei
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 14:34:38 -0400
Received: from fire.osdl.org ([65.172.181.4]:10955 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262308AbVDLKeP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:34:15 -0400
Message-Id: <200504121033.j3CAXhUl005961@shell0.pdx.osdl.net>
Subject: [patch 198/198] md: remove a number of misleading calls to MD_BUG
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, neilb@cse.unsw.edu.au
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:33:37 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: NeilBrown <neilb@cse.unsw.edu.au>

The conditions that cause these calls to MD_BUG are not kernel bugs, just
oddities in what userspace is asking for.

Also convert analyze_sbs to return void, and the value it returned was
always 0.

Signed-off-by: Neil Brown <neilb@cse.unsw.edu.au>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/drivers/md/md.c |   30 ++++++++----------------------
 1 files changed, 8 insertions(+), 22 deletions(-)

diff -puN drivers/md/md.c~md-remove-a-number-of-misleading-calls-to-md_bug drivers/md/md.c
--- 25/drivers/md/md.c~md-remove-a-number-of-misleading-calls-to-md_bug	2005-04-12 03:21:50.447467720 -0700
+++ 25-akpm/drivers/md/md.c	2005-04-12 03:21:50.453466808 -0700
@@ -1387,7 +1387,7 @@ abort_free:
  */
 
 
-static int analyze_sbs(mddev_t * mddev)
+static void analyze_sbs(mddev_t * mddev)
 {
 	int i;
 	struct list_head *tmp;
@@ -1441,7 +1441,6 @@ static int analyze_sbs(mddev_t * mddev)
 		       " -- starting background reconstruction\n",
 		       mdname(mddev));
 
-	return 0;
 }
 
 int mdp_major = 0;
@@ -1508,10 +1507,9 @@ static int do_md_run(mddev_t * mddev)
 	struct gendisk *disk;
 	char b[BDEVNAME_SIZE];
 
-	if (list_empty(&mddev->disks)) {
-		MD_BUG();
+	if (list_empty(&mddev->disks))
+		/* cannot run an array with no devices.. */
 		return -EINVAL;
-	}
 
 	if (mddev->pers)
 		return -EBUSY;
@@ -1519,10 +1517,8 @@ static int do_md_run(mddev_t * mddev)
 	/*
 	 * Analyze all RAID superblock(s)
 	 */
-	if (!mddev->raid_disks && analyze_sbs(mddev)) {
-		MD_BUG();
-		return -EINVAL;
-	}
+	if (!mddev->raid_disks)
+		analyze_sbs(mddev);
 
 	chunk_size = mddev->chunk_size;
 	pnum = level_to_pers(mddev->level);
@@ -1548,7 +1544,7 @@ static int do_md_run(mddev_t * mddev)
 		 * chunk-size has to be a power of 2 and multiples of PAGE_SIZE
 		 */
 		if ( (1 << ffz(~chunk_size)) != chunk_size) {
-			MD_BUG();
+			printk(KERN_ERR "chunk_size of %d not valid\n", chunk_size);
 			return -EINVAL;
 		}
 		if (chunk_size < PAGE_SIZE) {
@@ -1573,11 +1569,6 @@ static int do_md_run(mddev_t * mddev)
 		}
 	}
 
-	if (pnum >= MAX_PERSONALITY) {
-		MD_BUG();
-		return -EINVAL;
-	}
-
 #ifdef CONFIG_KMOD
 	if (!pers[pnum])
 	{
@@ -1762,10 +1753,8 @@ static void autorun_array(mddev_t *mddev
 	struct list_head *tmp;
 	int err;
 
-	if (list_empty(&mddev->disks)) {
-		MD_BUG();
+	if (list_empty(&mddev->disks))
 		return;
-	}
 
 	printk(KERN_INFO "md: running: ");
 
@@ -3128,7 +3117,6 @@ int register_md_personality(int pnum, md
 	spin_lock(&pers_lock);
 	if (pers[pnum]) {
 		spin_unlock(&pers_lock);
-		MD_BUG();
 		return -EBUSY;
 	}
 
@@ -3140,10 +3128,8 @@ int register_md_personality(int pnum, md
 
 int unregister_md_personality(int pnum)
 {
-	if (pnum >= MAX_PERSONALITY) {
-		MD_BUG();
+	if (pnum >= MAX_PERSONALITY)
 		return -EINVAL;
-	}
 
 	printk(KERN_INFO "md: %s personality unregistered\n", pers[pnum]->name);
 	spin_lock(&pers_lock);
_
