Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751113AbWIJVcv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751113AbWIJVcv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 17:32:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751122AbWIJVcv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 17:32:51 -0400
Received: from taganka54-host.corbina.net ([213.234.233.54]:14047 "EHLO
	mail.screens.ru") by vger.kernel.org with ESMTP id S1751113AbWIJVcu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 17:32:50 -0400
Date: Mon, 11 Sep 2006 01:32:43 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Dipankar Sarma <dipankar@in.ibm.com>
Cc: "Paul E. McKenney" <paulmck@us.ibm.com>,
       Srivatsa Vaddagiri <vatsa@in.ibm.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] rcu_do_batch: make ->qlen decrement irq safe
Message-ID: <20060910213242.GB437@oleg>
References: <20060910150820.GA7433@oleg> <20060910205827.GD4690@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060910205827.GD4690@in.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

rcu_do_batch() decrements rdp->qlen with irqs enabled. This is not good,
it can also be modified by call_rcu() from interrupt.

Decrement ->qlen once with irqs disabled, after a main loop.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- rc6-mm1/kernel/rcupdate.c~	2006-08-22 16:22:49.000000000 +0400
+++ rc6-mm1/kernel/rcupdate.c	2006-09-11 01:24:17.000000000 +0400
@@ -241,12 +241,16 @@ static void rcu_do_batch(struct rcu_data
 		next = rdp->donelist = list->next;
 		list->func(list);
 		list = next;
-		rdp->qlen--;
 		if (++count >= rdp->blimit)
 			break;
 	}
+
+	local_irq_disable();
+	rdp->qlen -= count;
+	local_irq_enable();
 	if (rdp->blimit == INT_MAX && rdp->qlen <= qlowmark)
 		rdp->blimit = blimit;
+
 	if (!rdp->donelist)
 		rdp->donetail = &rdp->donelist;
 	else

