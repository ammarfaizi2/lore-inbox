Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965318AbWJ2R6p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965318AbWJ2R6p (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 12:58:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965319AbWJ2R6o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 12:58:44 -0500
Received: from host-233-54.several.ru ([213.234.233.54]:41115 "EHLO
	mail.screens.ru") by vger.kernel.org with ESMTP id S965318AbWJ2R6o
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 12:58:44 -0500
Date: Sun, 29 Oct 2006 21:58:26 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: Shailabh Nagar <nagar@watson.ibm.com>, Balbir Singh <balbir@in.ibm.com>,
       Jay Lan <jlan@sgi.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] xacct_add_tsk: fix pure theoretical ->mm use-after-free
Message-ID: <20061029185826.GA1619@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paranoid fix. The task can free its ->mm after the 'if (p->mm)' check.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- STATS/kernel/tsacct.c~3_mm	2006-10-27 01:03:26.000000000 +0400
+++ STATS/kernel/tsacct.c	2006-10-29 21:46:12.000000000 +0300
@@ -80,13 +80,17 @@ void bacct_add_tsk(struct taskstats *sta
  */
 void xacct_add_tsk(struct taskstats *stats, struct task_struct *p)
 {
+	struct mm_struct *mm;
+
 	/* convert pages-jiffies to Mbyte-usec */
 	stats->coremem = jiffies_to_usecs(p->acct_rss_mem1) * PAGE_SIZE / MB;
 	stats->virtmem = jiffies_to_usecs(p->acct_vm_mem1) * PAGE_SIZE / MB;
-	if (p->mm) {
+	mm = get_task_mm(p);
+	if (mm) {
 		/* adjust to KB unit */
-		stats->hiwater_rss   = p->mm->hiwater_rss * PAGE_SIZE / KB;
-		stats->hiwater_vm    = p->mm->hiwater_vm * PAGE_SIZE / KB;
+		stats->hiwater_rss   = mm->hiwater_rss * PAGE_SIZE / KB;
+		stats->hiwater_vm    = mm->hiwater_vm * PAGE_SIZE / KB;
+		mmput(mm);
 	}
 	stats->read_char	= p->rchar;
 	stats->write_char	= p->wchar;

