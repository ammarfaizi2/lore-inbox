Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261157AbVALLlr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261157AbVALLlr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 06:41:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261156AbVALLlq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 06:41:46 -0500
Received: from aun.it.uu.se ([130.238.12.36]:33732 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261154AbVALLlh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 06:41:37 -0500
From: Mikael Pettersson <mikpe@user.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16869.3304.862072.953606@alkaid.it.uu.se>
Date: Wed, 12 Jan 2005 12:41:28 +0100
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org
Subject: [PATCH][2.6.10-mm3] remove bogus perfctr_sample_thread() calls
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

2.6.10-mm3 added perfctr_sample_thread() calls in
account_{user,system}_time(). I believe these to be bogus:

1. When they are called from update_process_times(), there
   will be two perfctr_sample_thread()s per tick, one of
   which is redundant.
2. s390's weird timer tick code calls both account_{user,system}_time()
   directly, bypassing update_process_times(). In this case there
   also be two perfctr_sample_thread()s per tick.

I believe the proper fix is to remove the new calls and, should
s390 ever get perfctr support, add _one_ perfctr_sample_thread()
call in s390's account_user_vtime().

The patch below removes the extraneous calls. Please apply.

Signed-off-by: Mikael Pettersson <mikpe@csd.uu.se>

--- linux-2.6.10-mm3/kernel/sched.c.~1~	2005-01-11 23:35:18.000000000 +0100
+++ linux-2.6.10-mm3/kernel/sched.c	2005-01-12 00:28:58.000000000 +0100
@@ -2334,7 +2334,6 @@ void account_user_time(struct task_struc
 	check_rlimit(p, cputime);
 	account_it_virt(p, cputime);
 	account_it_prof(p, cputime);
-	perfctr_sample_thread(&p->thread);
 
 	/* Add user time to cpustat. */
 	tmp = cputime_to_cputime64(cputime);
@@ -2365,8 +2364,6 @@ void account_system_time(struct task_str
 		account_it_prof(p, cputime);
 	}
 
-	perfctr_sample_thread(&p->thread);
-
 	/* Add system time to cpustat. */
 	tmp = cputime_to_cputime64(cputime);
 	if (hardirq_count() - hardirq_offset)
