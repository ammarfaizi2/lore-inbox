Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269245AbUINKRz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269245AbUINKRz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 06:17:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269249AbUINKRz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 06:17:55 -0400
Received: from mx1.elte.hu ([157.181.1.137]:28631 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S269245AbUINKRv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 06:17:51 -0400
Date: Tue, 14 Sep 2004 12:19:04 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: [patch] sched, vfs: fix scheduling latencies in prune_dcache() and select_parent()
Message-ID: <20040914101904.GD24622@elte.hu>
References: <20040914091529.GA21553@elte.hu> <20040914093855.GA23258@elte.hu> <20040914095110.GA24094@elte.hu> <20040914095731.GA24622@elte.hu> <20040914100652.GB24622@elte.hu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="hxkXGo8AKqTJ+9QI"
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


--hxkXGo8AKqTJ+9QI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


the attached patch fixes long scheduling latencies in select_parent()
and prune_dcache(). The prune_dcache() lock-break is easy, but for
select_parent() the only viable solution i found was to break out if
there's a resched necessary - the reordering is not necessary and the
dcache scanning/shrinking will later on do it anyway.

This patch has been in the -VP patchset for weeks.

	Ingo

--hxkXGo8AKqTJ+9QI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="fix-latency-dcache.patch"


the attached patch fixes long scheduling latencies in select_parent()
and prune_dcache(). The prune_dcache() lock-break is easy, but for
select_parent() the only viable solution i found was to break out if
there's a resched necessary - the reordering is not necessary and the
dcache scanning/shrinking will later on do it anyway.

This patch has been in the -VP patchset for weeks.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

--- linux/fs/dcache.c.orig	
+++ linux/fs/dcache.c	
@@ -381,6 +381,8 @@ static void prune_dcache(int count)
 		struct dentry *dentry;
 		struct list_head *tmp;
 
+		cond_resched_lock(&dcache_lock);
+
 		tmp = dentry_unused.prev;
 		if (tmp == &dentry_unused)
 			break;
@@ -553,6 +555,14 @@ resume:
 		struct dentry *dentry = list_entry(tmp, struct dentry, d_child);
 		next = tmp->next;
 
+		/*
+		 * select_parent() is a performance optimization, it is
+		 * not necessary to complete it. Abort if a reschedule is
+		 * pending:
+		 */
+		if (need_resched())
+			goto out;
+
 		if (!list_empty(&dentry->d_lru)) {
 			dentry_stat.nr_unused--;
 			list_del_init(&dentry->d_lru);
@@ -590,6 +600,7 @@ this_parent->d_parent->d_name.name, this
 #endif
 		goto resume;
 	}
+out:
 	spin_unlock(&dcache_lock);
 	return found;
 }

--hxkXGo8AKqTJ+9QI--
