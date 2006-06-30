Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933024AbWF3SvT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933024AbWF3SvT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 14:51:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933036AbWF3SvT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 14:51:19 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:49896 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S933024AbWF3SvS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 14:51:18 -0400
Date: Fri, 30 Jun 2006 20:46:21 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Vernon Mauery <vernux@us.ibm.com>, Thomas Gleixner <tglx@linutronix.de>
Subject: [patch] pi-futex: fix mm_struct memory leak
Message-ID: <20060630184621.GA29503@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.1 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5173]
	0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vernon Mauery <vernux@us.ibm.com>
Subject: pi-futex: fix mm_struct memory leak

lock_queue was getting called essentially twice in a row and was
continually incrementing the mm_count ref count, thus causing a
memory leak.

Dinakar Guniguntala provided a proper fix for the problem that simply 
grabs the spinlock for the hash bucket queue rather than calling 
lock_queue.

The second time we do a queue_lock in futex_lock_pi, we really only need 
to take the hash bucket lock.

Signed-off-by: Dinakar Guniguntala <dino@in.ibm.com>
Signed-off-by: Vernon Mauery <vernux@us.ibm.com>
Acked-by: Paul E. McKenney <paulmck@us.ibm.com>
Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 kernel/futex.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux/kernel/futex.c
===================================================================
--- linux.orig/kernel/futex.c
+++ linux/kernel/futex.c
@@ -1208,7 +1208,7 @@ static int do_futex_lock_pi(u32 __user *
 	}
 
 	down_read(&curr->mm->mmap_sem);
-	hb = queue_lock(&q, -1, NULL);
+	spin_lock(q.lock_ptr);
 
 	/*
 	 * Got the lock. We might not be the anticipated owner if we
