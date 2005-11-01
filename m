Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750976AbVKAGD7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750976AbVKAGD7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 01:03:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932569AbVKAGD7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 01:03:59 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:37844 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750976AbVKAGD6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 01:03:58 -0500
Date: Mon, 31 Oct 2005 22:04:06 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: mingo@elte.hu
Cc: linux-kernel@vger.kernel.org, oleg@tv-sign.ru, dipankar@in.ibm.com,
       suzannew@cs.pdx.edu, akpm@osdl.org
Subject: [PATCH] Simpler signal-exit concurrency handling
Message-ID: <20051101060405.GA4434@us.ibm.com>
Reply-To: paulmck@us.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

Some simplification in checking signal delivery against concurrent
exit.  Instead of using get_task_struct_rcu(), which increments
the task_struct reference count, check the reference count after
acquiring sighand lock.

Signed-off-by: <paulmck@us.ibm.com>

---

 signal.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff -urpNa linux-2.6.14-rc5-rt5/kernel/signal.c linux-2.6.14-rc5-rt5-ckhand/kernel/signal.c
--- linux-2.6.14-rc5-rt5/kernel/signal.c	2005-10-24 05:59:08.000000000 -0700
+++ linux-2.6.14-rc5-rt5-ckhand/kernel/signal.c	2005-10-31 15:46:14.000000000 -0800
@@ -1150,19 +1150,19 @@ int group_send_sig_info(int sig, struct 
 
 retry:
 	ret = check_kill_permission(sig, info, p);
-	if (!ret && sig && (sp = p->sighand)) {
-		if (!get_task_struct_rcu(p)) {
-			return -ESRCH;
-		}
+	if (!ret && sig && (sp = rcu_dereference(p->sighand))) {
 		spin_lock_irqsave(&sp->siglock, flags);
 		if (p->sighand != sp) {
 			spin_unlock_irqrestore(&sp->siglock, flags);
-			put_task_struct(p);
 			goto retry;
 		}
+		if ((atomic_read(&sp->count) == 0) ||
+		    (atomic_read(&p->usage) == 0)) {
+			spin_unlock_irqrestore(&sp->siglock, flags);
+			return -ESRCH;
+		}
 		ret = __group_send_sig_info(sig, info, p);
 		spin_unlock_irqrestore(&sp->siglock, flags);
-		put_task_struct(p);
 	}
 
 	return ret;
