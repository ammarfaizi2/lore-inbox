Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751459AbWENPpV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751459AbWENPpV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 May 2006 11:45:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751466AbWENPpV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 May 2006 11:45:21 -0400
Received: from [63.81.120.158] ([63.81.120.158]:61904 "EHLO
	dwalker1.mvista.com") by vger.kernel.org with ESMTP
	id S1751459AbWENPpU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 May 2006 11:45:20 -0400
Date: Sun, 14 May 2006 08:45:06 -0700
Message-Id: <200605141545.k4EFj6Cv001901@dwalker1.mvista.com>
From: Daniel Walker <dwalker@mvista.com>
To: mingo@elte.hu
CC: linux-kernel@vger.kernel.org
Subject: [PATCH -rt] scheduling while atomic in fs/file.c 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quite the smp_processor_id() wanrings. I don't see any SMP
concerns here . It just adds to a percpu list, so it shouldn't
matter if it switches after sampling fdtable_defer_list .

Signed-Off-By: Daniel Walker <dwalker@mvista.com>

Index: linux-2.6.16/fs/file.c
===================================================================
--- linux-2.6.16.orig/fs/file.c
+++ linux-2.6.16/fs/file.c
@@ -138,6 +138,8 @@ static void free_fdtable_rcu(struct rcu_
 		kfree(fdt);
 	} else {
 		fddef = &get_cpu_var(fdtable_defer_list);
+		put_cpu_var(fdtable_defer_list);
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
 
