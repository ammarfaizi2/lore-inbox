Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031887AbWLGJ2t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031887AbWLGJ2t (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 04:28:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031883AbWLGJ2t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 04:28:49 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:45565 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031888AbWLGJ2s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 04:28:48 -0500
Date: Thu, 7 Dec 2006 10:27:26 +0100
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>
Subject: [patch] lockdep: improve lockdep_reset()
Message-ID: <20061207092726.GA1103@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -5.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-5.9 required=5.9 tests=ALL_TRUSTED,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0050]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: [patch] lockdep: improve lockdep_reset()
From: Ingo Molnar <mingo@elte.hu>

clear all the chains during lockdep_reset(). This fixes
some locking-selftest false positives i saw on -rt. (never
saw those on mainline though, but it could happen.)

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 kernel/lockdep.c |    3 +++
 1 file changed, 3 insertions(+)

Index: linux/kernel/lockdep.c
===================================================================
--- linux.orig/kernel/lockdep.c
+++ linux/kernel/lockdep.c
@@ -2438,6 +2438,7 @@ EXPORT_SYMBOL_GPL(lock_release);
 void lockdep_reset(void)
 {
 	unsigned long flags;
+	int i;
 
 	raw_local_irq_save(flags);
 	current->curr_chain_key = 0;
@@ -2448,6 +2449,8 @@ void lockdep_reset(void)
 	nr_softirq_chains = 0;
 	nr_process_chains = 0;
 	debug_locks = 1;
+	for (i = 0; i < CHAINHASH_SIZE; i++)
+		INIT_LIST_HEAD(chainhash_table + i);
 	raw_local_irq_restore(flags);
 }
 

----- End forwarded message -----
