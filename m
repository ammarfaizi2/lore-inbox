Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261795AbSIXUpv>; Tue, 24 Sep 2002 16:45:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261797AbSIXUpu>; Tue, 24 Sep 2002 16:45:50 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:39940
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S261795AbSIXUps>; Tue, 24 Sep 2002 16:45:48 -0400
Subject: [PATCH] remove preempt workaround in slab.c
From: Robert Love <rml@tech9.net>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-yDMhADy97h/dpK3rqcXW"
Organization: 
Message-Id: <1032900656.1019.91.camel@phantasy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.1.1 (Preview Release)
Date: 24 Sep 2002 16:50:56 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-yDMhADy97h/dpK3rqcXW
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Linus,

Before the irqs_disabled() check in preempt_schedule(), we worked around
some locking issues in slab.c.  Now that we will never preempt with
interrupts disabled, we can remove those and clean things up.

This is courtesy of Manfred Spraul.

Patch is against current BK, please apply.

	Robert Love


--=-yDMhADy97h/dpK3rqcXW
Content-Disposition: attachment; filename=preempt-remove-slab-rml-2.5.38-1.patch
Content-Type: text/x-patch; name=preempt-remove-slab-rml-2.5.38-1.patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

diff -urN linux-2.5.38/mm/slab.c linux/mm/slab.c
--- linux-2.5.38/mm/slab.c	Mon Sep 23 21:43:41 2002
+++ linux/mm/slab.c	Mon Sep 23 21:48:05 2002
@@ -1357,11 +1357,7 @@
 		cc_entry(cc)[cc->avail++] =
 				kmem_cache_alloc_one_tail(cachep, slabp);
 	}
-	/*
-	 * CAREFUL: do not enable preemption yet, the per-CPU
-	 * entries rely on us being atomic.
-	 */
-	_raw_spin_unlock(&cachep->spinlock);
+	spin_unlock(&cachep->spinlock);
 
 	if (cc->avail)
 		return cc_entry(cc)[--cc->avail];
@@ -1389,8 +1385,6 @@
 				STATS_INC_ALLOCMISS(cachep);
 				objp = kmem_cache_alloc_batch(cachep,flags);
 				local_irq_restore(save_flags);
-				/* end of non-preemptible region */
-				preempt_enable();
 				if (!objp)
 					goto alloc_new_slab_nolock;
 				return objp;

--=-yDMhADy97h/dpK3rqcXW--

