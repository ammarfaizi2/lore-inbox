Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751599AbWA1Ro7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751599AbWA1Ro7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jan 2006 12:44:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751600AbWA1Ro7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jan 2006 12:44:59 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:8133 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1751598AbWA1Ro7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jan 2006 12:44:59 -0500
Message-ID: <43DBBFA9.8D5E231A@tv-sign.ru>
Date: Sat, 28 Jan 2006 22:02:01 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Dipankar Sarma <dipankar@in.ibm.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Srivatsa Vaddagiri <vatsa@in.ibm.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] rcu_process_callbacks: don't cli() while testing ->nxtlist
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

__rcu_process_callbacks() disables interrupts to protect itself
from call_rcu() which adds new entries to ->nxtlist.

However we can check "->nxtlist != NULL" with interrupts enabled,
we can't get "false positives" because call_rcu() can only change
this condition from 0 to 1.

Tested with rcutorture.ko.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- RC-1/kernel/rcupdate.c~	2006-01-19 18:13:07.000000000 +0300
+++ RC-1/kernel/rcupdate.c	2006-01-29 00:13:24.000000000 +0300
@@ -381,8 +381,8 @@ static void __rcu_process_callbacks(stru
 		rdp->curtail = &rdp->curlist;
 	}
 
-	local_irq_disable();
 	if (rdp->nxtlist && !rdp->curlist) {
+		local_irq_disable();
 		rdp->curlist = rdp->nxtlist;
 		rdp->curtail = rdp->nxttail;
 		rdp->nxtlist = NULL;
@@ -407,9 +407,8 @@ static void __rcu_process_callbacks(stru
 			rcu_start_batch(rcp);
 			spin_unlock(&rcp->lock);
 		}
-	} else {
-		local_irq_enable();
 	}
+
 	rcu_check_quiescent_state(rcp, rdp);
 	if (rdp->donelist)
 		rcu_do_batch(rdp);
