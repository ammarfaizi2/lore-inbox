Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751857AbWEPQ2v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751857AbWEPQ2v (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 12:28:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751858AbWEPQ2v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 12:28:51 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:15460 "EHLO
	dwalker1.mvista.com") by vger.kernel.org with ESMTP
	id S1751857AbWEPQ2u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 12:28:50 -0400
Date: Tue, 16 May 2006 09:28:18 -0700
Message-Id: <200605161628.k4GGSID1004173@dwalker1.mvista.com>
From: Daniel Walker <dwalker@mvista.com>
To: mingo@elte.hu
CC: rostedt@goodmis.org, linux-kernel@vger.kernel.org
Subject: [PATCH -rt] scheduling while atomic in fs/file.c 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quite the smp_processor_id() warnings. The timer was pinned
before, but the spinlock protection is such that the timer
can migrate with out issues. Allowing the timers to 
migrate (although not often) will allow them to
move off busy cpu's , and potentially follow the
work queue that they wake up. 

Signed-Off-By: Daniel Walker <dwalker@mvista.com>

Index: linux-2.6.16/fs/file.c
===================================================================
--- linux-2.6.16.orig/fs/file.c
+++ linux-2.6.16/fs/file.c
@@ -137,7 +137,9 @@ static void free_fdtable_rcu(struct rcu_
 		kfree(fdt->fd);
 		kfree(fdt);
 	} else {
-		fddef = &get_cpu_var(fdtable_defer_list);
+
+		fddef = &per_cpu(fdtable_defer_list, raw_smp_processor_id());
+
 		spin_lock(&fddef->lock);
 		fdt->next = fddef->next;
 		fddef->next = fdt;
@@ -149,7 +151,6 @@ static void free_fdtable_rcu(struct rcu_
 		if (!schedule_work(&fddef->wq))
 			mod_timer(&fddef->timer, 5);
 		spin_unlock(&fddef->lock);
-		put_cpu_var(fdtable_defer_list);
 	}
 }
 
