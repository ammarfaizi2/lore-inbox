Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266451AbUHIKXA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266451AbUHIKXA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 06:23:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266459AbUHIKW7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 06:22:59 -0400
Received: from mx2.elte.hu ([157.181.151.9]:14513 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S266451AbUHIKUq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 06:20:46 -0400
Date: Mon, 9 Aug 2004 12:21:25 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       linux-kernel@vger.kernel.org
Subject: [patch] inode-lock-break.patch, 2.6.8-rc3-mm2
Message-ID: <20040809102125.GA12391@elte.hu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ZGiS0Q5IWpPtfppv"
Content-Disposition: inline
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


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


the attached patch does a scheduling-latency lock-break of two functions
within the VFS: prune_icache() [typically triggered by VM load] and
invalidate_inodes() [triggered by e.g. CDROM auto-umounts - reported by
Florian Schmidt].

prune_icache() was easy - it works off a global list head so adding
voluntary_resched_lock() solves the latency.

invalidate_inodes() was trickier - we scan a list filtering for specific
inodes - simple lock-break is incorrect because the list might change at
the cursor, and retrying opens up the potential for livelocks.

The solution i found was to insert a private marker into the list and to
start off that point - the inodes of the superblock in question wont get
reordered within the list because the filesystem is quiet already at
this point. (other inodes of other filesystems might get reordered but
that doesnt matter.)

tested on x86, the patch solves these particular latencies.

	Ingo

--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="inode-lock-break.patch"


the attached patch does a scheduling-latency lock-break of two functions
within the VFS: prune_icache() [typically triggered by VM load] and
invalidate_inodes() [triggered by e.g. CDROM auto-umounts - reported by
Florian Schmidt].

prune_icache() was easy - it works off a global list head so adding
voluntary_resched_lock() solves the latency.

invalidate_inodes() was trickier - we scan a list filtering for specific
inodes - simple lock-break is incorrect because the list might change at
the cursor, and retrying opens up the potential for livelocks.

The solution i found was to insert a private marker into the list and to
start off that point - the inodes of the superblock in question wont get
reordered within the list because the filesystem is quiet already at
this point. (other inodes of other filesystems might get reordered but
that doesnt matter.)

tested on x86, the patch solves these particular latencies.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

--- linux/fs/inode.c.orig	
+++ linux/fs/inode.c	
@@ -296,7 +296,7 @@ static void dispose_list(struct list_hea
 /*
  * Invalidate all inodes for a device.
  */
-static int invalidate_list(struct list_head *head, struct list_head *dispose)
+static int invalidate_list(struct list_head *head, struct list_head *dispose, struct list_head *mark)
 {
 	struct list_head *next;
 	int busy = 0, count = 0;
@@ -306,6 +306,21 @@ static int invalidate_list(struct list_h
 		struct list_head * tmp = next;
 		struct inode * inode;
 
+		/*
+		 * Preempt if necessary. To make this safe we use a dummy
+		 * inode as a marker - we can continue off that point.
+		 * We rely on this sb's inodes (including the marker) not
+		 * getting reordered within the list during umount. Other
+		 * inodes might get reordered.
+		 */
+		if (need_resched()) {
+			list_add_tail(mark, next);
+			spin_unlock(&inode_lock);
+			cond_resched();
+			spin_lock(&inode_lock);
+			tmp = next = mark->next;
+			list_del(mark);
+		}
 		next = next->next;
 		if (tmp == head)
 			break;
@@ -346,15 +361,21 @@ int invalidate_inodes(struct super_block
 {
 	int busy;
 	LIST_HEAD(throw_away);
+	struct inode *marker;
+
+	marker = kmalloc(sizeof(*marker), GFP_KERNEL|__GFP_REPEAT);
+	memset(marker, 0, sizeof(*marker));
 
 	down(&iprune_sem);
 	spin_lock(&inode_lock);
-	busy = invalidate_list(&sb->s_inodes, &throw_away);
+	busy = invalidate_list(&sb->s_inodes, &throw_away, &marker->i_list);
 	spin_unlock(&inode_lock);
 
 	dispose_list(&throw_away);
 	up(&iprune_sem);
 
+	kfree(marker);
+
 	return busy;
 }
 
@@ -425,6 +446,8 @@ static void prune_icache(int nr_to_scan)
 	for (nr_scanned = 0; nr_scanned < nr_to_scan; nr_scanned++) {
 		struct inode *inode;
 
+		cond_resched_lock(&inode_lock);
+
 		if (list_empty(&inode_unused))
 			break;
 

--ZGiS0Q5IWpPtfppv--
