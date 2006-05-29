Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751370AbWE2Vcx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751370AbWE2Vcx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 17:32:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751368AbWE2V0l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 17:26:41 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:58593 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751370AbWE2V0i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 17:26:38 -0400
Date: Mon, 29 May 2006 23:26:58 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>
Subject: [patch 48/61] lock validator: special locking: timer.c
Message-ID: <20060529212658.GV3155@elte.hu>
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

teach special (recursive) locking code to the lock validator. Has no
effect on non-lockdep kernels.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
---
 kernel/timer.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

Index: linux/kernel/timer.c
===================================================================
--- linux.orig/kernel/timer.c
+++ linux/kernel/timer.c
@@ -1496,6 +1496,13 @@ asmlinkage long sys_sysinfo(struct sysin
 	return 0;
 }
 
+/*
+ * lockdep: we want to track each per-CPU base as a separate lock-type,
+ * but timer-bases are kmalloc()-ed, so we need to attach separate
+ * keys to them:
+ */
+static struct lockdep_type_key base_lock_keys[NR_CPUS];
+
 static int __devinit init_timers_cpu(int cpu)
 {
 	int j;
@@ -1530,7 +1537,7 @@ static int __devinit init_timers_cpu(int
 		base = per_cpu(tvec_bases, cpu);
 	}
 
-	spin_lock_init(&base->lock);
+	spin_lock_init_key(&base->lock, base_lock_keys + cpu);
 	for (j = 0; j < TVN_SIZE; j++) {
 		INIT_LIST_HEAD(base->tv5.vec + j);
 		INIT_LIST_HEAD(base->tv4.vec + j);
