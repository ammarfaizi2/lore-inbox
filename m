Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265337AbTLNDyS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Dec 2003 22:54:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265338AbTLNDyS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Dec 2003 22:54:18 -0500
Received: from dp.samba.org ([66.70.73.150]:19899 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S265337AbTLNDyQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Dec 2003 22:54:16 -0500
Date: Sun, 14 Dec 2003 14:53:56 +1100
From: Anton Blanchard <anton@samba.org>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: prepare_to_wait/waitqueue_active issues in 2.6
Message-ID: <20031214035356.GM17683@krispykreme>
References: <20031214034059.GL17683@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031214034059.GL17683@krispykreme>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> End result is waitqueue_active returns 0 and buffer_locked returns 1.
> We miss a wakeup. Game over. Ive attached a patch that forces the check
> to happen after we are put on the waitqueue. Thanks to Brian Twichell
> for the analysis and suggested fix for this.

This time for sure.

Anton

===== mm/filemap.c 1.212 vs edited =====
--- 1.212/mm/filemap.c	Sun Oct 26 16:41:06 2003
+++ edited/mm/filemap.c	Sun Dec 14 14:25:45 2003
@@ -299,6 +299,7 @@
 
 	do {
 		prepare_to_wait(waitqueue, &wait, TASK_UNINTERRUPTIBLE);
+		smp_mb();
 		if (test_bit(bit_nr, &page->flags)) {
 			sync_page(page);
 			io_schedule();
@@ -372,6 +373,7 @@
 
 	while (TestSetPageLocked(page)) {
 		prepare_to_wait(wqh, &wait, TASK_UNINTERRUPTIBLE);
+		smp_mb();
 		if (PageLocked(page)) {
 			sync_page(page);
 			io_schedule();
===== fs/buffer.c 1.215 vs edited =====
--- 1.215/fs/buffer.c	Tue Sep 30 11:12:02 2003
+++ edited/fs/buffer.c	Sun Dec 14 14:24:26 2003
@@ -131,6 +131,7 @@
 
 	do {
 		prepare_to_wait(wqh, &wait, TASK_UNINTERRUPTIBLE);
+		smp_mb();
 		if (buffer_locked(bh)) {
 			blk_run_queues();
 			io_schedule();
