Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268588AbUIQMQ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268588AbUIQMQ6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 08:16:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268719AbUIQMQ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 08:16:57 -0400
Received: from mx1.elte.hu ([157.181.1.137]:14752 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S268588AbUIQMQf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 08:16:35 -0400
Date: Fri, 17 Sep 2004 14:17:45 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] softirqs: fix latency of softirq processing
Message-ID: <20040917121745.GA1149@elte.hu>
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


the attached patch fixes a local_bh_enable() buglet: we first enabled
softirqs then did we do local_softirq_pending() - often this is
preemptible code. So this task could be preempted and there's no
guarantee that softirq processing will occur (except the periodic timer
tick).

the race window is small but existent. This could result in packet
processing latencies or timer expiration latencies - hard to detect and
annoying bugs.

the fix is to invoke softirqs with softirqs enabled but preemption still
disabled. Patch is against 2.6.9-rc2-mm1.

	Ingo

Signed-off-by: Ingo Molnar <mingo@elte.hu>

--- linux/kernel/softirq.c.orig	
+++ linux/kernel/softirq.c	
@@ -137,12 +137,19 @@ EXPORT_SYMBOL(do_softirq);
 
 void local_bh_enable(void)
 {
-	__local_bh_enable();
 	WARN_ON(irqs_disabled());
-	if (unlikely(!in_interrupt() &&
-		     local_softirq_pending()))
+	if (unlikely(!in_interrupt() && local_softirq_pending())) {
+		/*
+		 * Keep preemption disabled until we are done with
+		 * softirq processing:
+	 	 */
+		preempt_count() -= SOFTIRQ_OFFSET - 1;
 		invoke_softirq();
-	preempt_check_resched();
+		preempt_enable();
+	} else {
+		__local_bh_enable();
+		preempt_check_resched();
+	}
 }
 EXPORT_SYMBOL(local_bh_enable);
 
