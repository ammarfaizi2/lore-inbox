Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751399AbVJWDVp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751399AbVJWDVp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Oct 2005 23:21:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751400AbVJWDVp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Oct 2005 23:21:45 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:14026 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751399AbVJWDVp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Oct 2005 23:21:45 -0400
Date: Sat, 22 Oct 2005 20:22:26 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, mingo@elte.hu, oleg@tv-sign.ru, dipankar@in.ibm.com,
       hch@infradead.org
Subject: [PATCH] Remove duplicate code in signal.c
Message-ID: <20051023032226.GA6340@us.ibm.com>
Reply-To: paulmck@us.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

The following patch combines a bit of redundant code between
force_sig_info() and force_sig_specific().  Tested on x86 and ppc64.

Signed-off-by: paulmck@us.ibm.com

---

 signal.c |   12 ++----------
 1 files changed, 2 insertions(+), 10 deletions(-)

diff -urpNa -X dontdiff linux-2.6.14-rc2-rt7/kernel/signal.c linux-2.6.14-rc2-rt7-force_sig/kernel/signal.c
--- linux-2.6.14-rc2-rt7/kernel/signal.c	2005-09-29 13:57:15.000000000 -0700
+++ linux-2.6.14-rc2-rt7-force_sig/kernel/signal.c	2005-09-29 18:41:07.000000000 -0700
@@ -920,8 +920,8 @@ force_sig_info(int sig, struct siginfo *
 	if (sigismember(&t->blocked, sig) || t->sighand->action[sig-1].sa.sa_handler == SIG_IGN) {
 		t->sighand->action[sig-1].sa.sa_handler = SIG_DFL;
 		sigdelset(&t->blocked, sig);
-		recalc_sigpending_tsk(t);
 	}
+	recalc_sigpending_tsk(t);
 	ret = specific_send_sig_info(sig, info, t);
 	spin_unlock_irqrestore(&t->sighand->siglock, flags);
 
@@ -931,15 +931,7 @@ force_sig_info(int sig, struct siginfo *
 void
 force_sig_specific(int sig, struct task_struct *t)
 {
-	unsigned long int flags;
-
-	spin_lock_irqsave(&t->sighand->siglock, flags);
-	if (t->sighand->action[sig-1].sa.sa_handler == SIG_IGN)
-		t->sighand->action[sig-1].sa.sa_handler = SIG_DFL;
-	sigdelset(&t->blocked, sig);
-	recalc_sigpending_tsk(t);
-	specific_send_sig_info(sig, (void *)2, t);
-	spin_unlock_irqrestore(&t->sighand->siglock, flags);
+	force_sig_info(sig, (void *)2, t);
 }
 
 /*
