Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751352AbWE2VhK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751352AbWE2VhK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 17:37:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751356AbWE2VZ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 17:25:56 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:5587 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751355AbWE2VZj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 17:25:39 -0400
Date: Mon, 29 May 2006 23:25:59 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>
Subject: [patch 35/61] lock validator: special locking: direct-IO
Message-ID: <20060529212559.GI3155@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060529212109.GA2058@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>

teach special (rwsem-in-irq) locking code to the lock validator. Has no
effect on non-lockdep kernels.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
---
---
 fs/direct-io.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

Index: linux/fs/direct-io.c
===================================================================
--- linux.orig/fs/direct-io.c
+++ linux/fs/direct-io.c
@@ -220,7 +220,8 @@ static void dio_complete(struct dio *dio
 	if (dio->end_io && dio->result)
 		dio->end_io(dio->iocb, offset, bytes, dio->map_bh.b_private);
 	if (dio->lock_type == DIO_LOCKING)
-		up_read(&dio->inode->i_alloc_sem);
+		/* lockdep: non-owner release */
+		up_read_non_owner(&dio->inode->i_alloc_sem);
 }
 
 /*
@@ -1261,7 +1262,8 @@ __blockdev_direct_IO(int rw, struct kioc
 		}
 
 		if (dio_lock_type == DIO_LOCKING)
-			down_read(&inode->i_alloc_sem);
+			/* lockdep: not the owner will release it */
+			down_read_non_owner(&inode->i_alloc_sem);
 	}
 
 	/*
