Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264498AbUBOVnc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 16:43:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265203AbUBOVnc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 16:43:32 -0500
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:62197 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S264498AbUBOVnb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 16:43:31 -0500
Date: Sun, 15 Feb 2004 16:43:26 -0500
From: Willem Riede <wrlk@riede.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.6.3-rc3 ide-tape: sleeping function called from invalid context
Message-ID: <20040215214326.GY4957@serve.riede.org>
Reply-To: wrlk@riede.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 2.0.16
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Problem:

Feb 15 16:11:22 fallguy kernel: Debug: sleeping function called from invalid context at kernel/sched.c:1870
Feb 15 16:11:22 fallguy kernel: in_atomic():0, irqs_disabled():1
Feb 15 16:11:22 fallguy kernel: Call Trace:
Feb 15 16:11:22 fallguy kernel:  [<c0127b91>] __might_sleep+0x91/0xc0
Feb 15 16:11:22 fallguy kernel:  [<c0125c1a>] wait_for_completion+0x1a/0x190
Feb 15 16:11:22 fallguy kernel:  [<e0ddb117>] idetape_initiate_read+0x1b7/0x250 [ide_tape]
Feb 15 16:11:22 fallguy kernel:  [<e0dd9752>] idetape_wait_for_request+0x92/0xf0 [ide_tape]
Feb 15 16:11:22 fallguy kernel:  [<e0dda992>] idetape_wait_first_stage+0xa2/0xd0 [ide_tape]
Feb 15 16:11:22 fallguy kernel:  [<e0ddb2c7>] idetape_get_logical_blk+0x117/0x270 [ide_tape]
Feb 15 16:11:22 fallguy kernel:  [<e0ddb47a>] idetape_add_chrdev_read_request+0x5a/0x200 [ide_tape]
Feb 15 16:11:22 fallguy kernel:  [<e0dd9313>] idetape_copy_stage_to_user+0x83/0xf0 [ide_tape]
Feb 15 16:11:22 fallguy kernel:  [<e0ddc39c>] idetape_chrdev_read+0x18c/0x240 [ide_tape]
Feb 15 16:11:22 fallguy kernel:  [<c016c601>] vfs_read+0xd1/0x120
Feb 15 16:11:22 fallguy kernel:  [<c016c858>] sys_read+0x38/0x60
Feb 15 16:11:22 fallguy kernel:  [<c010bc3f>] syscall_call+0x7/0xb

Fix (against 2.6.3-rc3):

--- p0/drivers/ide/ide-tape.c	2004-02-15 16:35:31.000000000 -0500
+++ p1/drivers/ide/ide-tape.c	2004-02-15 16:36:58.000000000 -0500
@@ -3212,7 +3212,7 @@
 #endif /* IDETAPE_DEBUG_BUGS */
 	rq->waiting = &wait;
 	tape->waiting = &wait;
-	spin_unlock(&tape->spinlock);
+	spin_unlock_irq(&tape->spinlock);
 	wait_for_completion(&wait);
 	/* The stage and its struct request have been deallocated */
 	tape->waiting = NULL;


Regards, Willem Riede.
