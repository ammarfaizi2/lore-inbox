Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269243AbUINKMQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269243AbUINKMQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 06:12:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269245AbUINKMQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 06:12:16 -0400
Received: from mx2.elte.hu ([157.181.151.9]:29902 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S269243AbUINKMF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 06:12:05 -0400
Date: Tue, 14 Sep 2004 12:13:28 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: [patch] sched, vfs: fix scheduling latencies in invalidate_inodes()
Message-ID: <20040914101328.GC24622@elte.hu>
References: <20040914091529.GA21553@elte.hu> <20040914093855.GA23258@elte.hu> <20040914095110.GA24094@elte.hu> <20040914095731.GA24622@elte.hu> <20040914100652.GB24622@elte.hu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Bu8it7iiRSEf40bY"
Content-Disposition: inline
In-Reply-To: <20040914100652.GB24622@elte.hu>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Bu8it7iiRSEf40bY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


the attached patch fixes long scheduling latencies in
invalidate_inodes(). The lock-break is a bit tricky to not get into a
livelock scenario: we use a dummy inode as a marker at which point we
can continue the scanning after the schedule.

this patch has been tested as part of the -VP patchset for weeks.

	Ingo

--Bu8it7iiRSEf40bY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="fix-latency-invalidate-inodes.patch"


the attached patch fixes long scheduling latencies in
invalidate_inodes(). The lock-break is a bit tricky to not get into a
livelock scenario: we use a dummy inode as a marker at which point we
can continue the scanning after the schedule.

this patch has been tested as part of the -VP patchset for weeks.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

--- linux/fs/inode.c.orig	
+++ linux/fs/inode.c	
@@ -296,7 +296,7 @@ static void dispose_list(struct list_hea
 /*
  * Invalidate all inodes for a device.
  */
-static int invalidate_list(struct list_head *head, struct super_block * sb, struct list_head * dispose)
+static int invalidate_list(struct list_head *head, struct super_block * sb, struct list_head * dispose, struct list_head *mark)
 {
 	struct list_head *next;
 	int busy = 0, count = 0;
@@ -306,6 +306,20 @@ static int invalidate_list(struct list_h
 		struct list_head * tmp = next;
 		struct inode * inode;
 
+		/*
+		 * Preempt if necessary. To make this safe we use a dummy
+		 * inode as a marker - we can continue off that point.
+		 * We rely on this sb's inodes (including the marker) not
+		 * getting reordered within the list during umount. Other
+		 * inodes might get reordered.
+		 */
+		if (lock_need_resched(&inode_lock)) {
+			list_add_tail(mark, next);
+			BUG_ON(mark->next != next);
+			cond_resched_lock(&inode_lock);
+			tmp = next = mark->next;
+			list_del(mark);
+		}
 		next = next->next;
 		if (tmp == head)
 			break;
@@ -347,18 +361,26 @@ int invalidate_inodes(struct super_block
 {
 	int busy;
 	LIST_HEAD(throw_away);
+	struct inode *marker;
+	struct list_head *mark;
+
+	marker = kmalloc(sizeof(*marker), SLAB_KERNEL|__GFP_REPEAT);
+	memset(marker, 0, sizeof(*marker));
+	mark = &marker->i_list;
 
 	down(&iprune_sem);
 	spin_lock(&inode_lock);
-	busy = invalidate_list(&inode_in_use, sb, &throw_away);
-	busy |= invalidate_list(&inode_unused, sb, &throw_away);
-	busy |= invalidate_list(&sb->s_dirty, sb, &throw_away);
-	busy |= invalidate_list(&sb->s_io, sb, &throw_away);
+	busy = invalidate_list(&inode_in_use, sb, &throw_away, mark);
+	busy |= invalidate_list(&inode_unused, sb, &throw_away, mark);
+	busy |= invalidate_list(&sb->s_dirty, sb, &throw_away, mark);
+	busy |= invalidate_list(&sb->s_io, sb, &throw_away, mark);
 	spin_unlock(&inode_lock);
 
 	dispose_list(&throw_away);
 	up(&iprune_sem);
 
+	kfree(marker);
+
 	return busy;
 }
 
@@ -429,6 +451,8 @@ static void prune_icache(int nr_to_scan)
 	for (nr_scanned = 0; nr_scanned < nr_to_scan; nr_scanned++) {
 		struct inode *inode;
 
+		cond_resched_lock(&inode_lock);
+
 		if (list_empty(&inode_unused))
 			break;
 

--Bu8it7iiRSEf40bY--
