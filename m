Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751369AbWE2Vb1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751369AbWE2Vb1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 17:31:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751357AbWE2VbU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 17:31:20 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:5346 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751369AbWE2V1Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 17:27:16 -0400
Date: Mon, 29 May 2006 23:27:37 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>
Subject: [patch 56/61] lock validator: special locking: jbd
Message-ID: <20060529212737.GD3155@elte.hu>
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

teach special (non-nested) unlocking code to the lock validator. Has no
effect on non-lockdep kernels.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
---
 fs/jbd/checkpoint.c |    2 +-
 fs/jbd/commit.c     |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

Index: linux/fs/jbd/checkpoint.c
===================================================================
--- linux.orig/fs/jbd/checkpoint.c
+++ linux/fs/jbd/checkpoint.c
@@ -135,7 +135,7 @@ void __log_wait_for_space(journal_t *jou
 			log_do_checkpoint(journal);
 			spin_lock(&journal->j_state_lock);
 		}
-		mutex_unlock(&journal->j_checkpoint_mutex);
+		mutex_unlock_non_nested(&journal->j_checkpoint_mutex);
 	}
 }
 
Index: linux/fs/jbd/commit.c
===================================================================
--- linux.orig/fs/jbd/commit.c
+++ linux/fs/jbd/commit.c
@@ -838,7 +838,7 @@ restart_loop:
 	J_ASSERT(commit_transaction == journal->j_committing_transaction);
 	journal->j_commit_sequence = commit_transaction->t_tid;
 	journal->j_committing_transaction = NULL;
-	spin_unlock(&journal->j_state_lock);
+	spin_unlock_non_nested(&journal->j_state_lock);
 
 	if (commit_transaction->t_checkpoint_list == NULL) {
 		__journal_drop_transaction(journal, commit_transaction);
