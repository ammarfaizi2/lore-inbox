Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750962AbWHPHRs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750962AbWHPHRs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 03:17:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750964AbWHPHRs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 03:17:48 -0400
Received: from mx1.redhat.com ([66.187.233.31]:40080 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750962AbWHPHRr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 03:17:47 -0400
From: Roland McGrath <roland@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
X-Fcc: ~/Mail/linus
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] __dequeue_signal cleanup
Message-Id: <20060816071744.7CAA1180063@magilla.sf.frob.com>
Date: Wed, 16 Aug 2006 00:17:44 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This tightens up __dequeue_signal a little.  It also avoids doing
recalc_sigpending twice in a row, instead doing it once in dequeue_signal.

Signed-off-by: Roland McGrath <roland@redhat.com>
---
 kernel/signal.c |   30 ++++++++++++++----------------
 1 files changed, 14 insertions(+), 16 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index bfdb568..bae6155 100644  
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -417,9 +417,8 @@ static int collect_signal(int sig, struc
 static int __dequeue_signal(struct sigpending *pending, sigset_t *mask,
 			siginfo_t *info)
 {
-	int sig = 0;
+	int sig = next_signal(pending, mask);
 
-	sig = next_signal(pending, mask);
 	if (sig) {
 		if (current->notifier) {
 			if (sigismember(current->notifier_mask, sig)) {
@@ -432,9 +431,7 @@ static int __dequeue_signal(struct sigpe
 
 		if (!collect_signal(sig, pending, info))
 			sig = 0;
-				
 	}
-	recalc_sigpending();
 
 	return sig;
 }
@@ -451,6 +448,7 @@ int dequeue_signal(struct task_struct *t
 	if (!signr)
 		signr = __dequeue_signal(&tsk->signal->shared_pending,
 					 mask, info);
+	recalc_sigpending_tsk(tsk);
  	if (signr && unlikely(sig_kernel_stop(signr))) {
  		/*
  		 * Set a marker that we have dequeued a stop signal.  Our
