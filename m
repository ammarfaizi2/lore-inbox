Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267749AbUIUPgW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267749AbUIUPgW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 11:36:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267760AbUIUPgW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 11:36:22 -0400
Received: from mx1.elte.hu ([157.181.1.137]:46767 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S267749AbUIUPgF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 11:36:05 -0400
Date: Tue, 21 Sep 2004 17:37:50 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: [patch] fix diskstats_show() accounting with PREEMPT
Message-ID: <20040921153750.GA21449@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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


there is another (minor) bug that the smp_processor_id() debugger
unearthed: diskstats_show() could do a disk_round_stats() ->
disk_stat_add() with preemption enabled - possibly resulting in losing
statistics updates.

Patch attached. (The overwhelming majority of disk_stat_add() callers
have preemption disabled so fixing the remaining two was the best.)

	Ingo

Signed-off-by: Ingo Molnar <mingo@elte.hu>

--- linux/drivers/block/genhd.c.orig	
+++ linux/drivers/block/genhd.c	
@@ -365,7 +365,9 @@ static ssize_t disk_size_read(struct gen
 
 static ssize_t disk_stats_read(struct gendisk * disk, char *page)
 {
+	preempt_disable();
 	disk_round_stats(disk);
+	preempt_enable();
 	return sprintf(page,
 		"%8u %8u %8llu %8u "
 		"%8u %8u %8llu %8u "
@@ -494,7 +496,9 @@ static int diskstats_show(struct seq_fil
 				"\n\n");
 	*/
  
+	preempt_disable();
 	disk_round_stats(gp);
+	preempt_enable();
 	seq_printf(s, "%4d %4d %s %u %u %llu %u %u %u %llu %u %u %u %u\n",
 		gp->major, n + gp->first_minor, disk_name(gp, n, buf),
 		disk_stat_read(gp, reads), disk_stat_read(gp, read_merges),
