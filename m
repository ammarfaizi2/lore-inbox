Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261311AbVEZLSP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261311AbVEZLSP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 07:18:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261309AbVEZLSP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 07:18:15 -0400
Received: from mx1.elte.hu ([157.181.1.137]:463 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261311AbVEZLSD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 07:18:03 -0400
Date: Thu, 26 May 2005 13:17:42 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Arjan van de Ven <arjanv@infradead.org>, linux-kernel@vger.kernel.org
Subject: [patch] enable PREEMPT_BKL on !PREEMPT+SMP too
Message-ID: <20050526111742.GA18272@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the only sane way to clean up the current 3 lock_kernel() variants seems 
to be to remove the spinlock-based BKL implementations altogether, and 
to keep the semaphore-based one only. If we dont want to do that for
whatever reason then i'm afraid we have to live with the current
complexity. (but i'm open for other cleanup suggestions as well.)

to explore this possibility we'll (at a minimum) have to know whether
the semaphore-based BKL works fine on plain SMP too. The patch below
enables this.

the patch may make sense in isolation as well, as it might bring
performance benefits: code that would formerly spin on the BKL spinlock
will now schedule away and give up the CPU. It might introduce
performance regressions as well, if any performance-critical code uses
the BKL heavily and gets overscheduled due to the semaphore. I very much
hope there is no such performance-critical codepath left though.

patch depends on:

  consolidate-preempt-options-into-kernel-kconfigpreempt.patch

tested on x86-SMP. All other PREEMPT_BKL-using arches (x64, ppc64) 
should work fine too.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

--- linux/kernel/Kconfig.preempt.orig
+++ linux/kernel/Kconfig.preempt
@@ -13,7 +13,7 @@ config PREEMPT
 
 config PREEMPT_BKL
 	bool "Preempt The Big Kernel Lock"
-	depends on PREEMPT
+	depends on SMP || PREEMPT
 	default y
 	help
 	  This option reduces the latency of the kernel by making the
