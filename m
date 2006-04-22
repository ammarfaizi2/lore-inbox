Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750899AbWDVSgz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750899AbWDVSgz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Apr 2006 14:36:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750902AbWDVSgz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Apr 2006 14:36:55 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:31149 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1750898AbWDVSgz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Apr 2006 14:36:55 -0400
Date: Sat, 22 Apr 2006 08:03:32 -0700
Message-Id: <200604221503.k3MF3Ws8021873@dwalker1.mvista.com>
From: Daniel Walker <dwalker@mvista.com>
To: mingo@elte.hu
CC: linux-kernel@vger.kernel.org
Subject: [PATCH -rt] scheduling while atomic in fs/file.c 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In free_fdtable_rcu() it does the following,

        } else {
                fddef = &get_cpu_var(fdtable_defer_list);
                spin_lock(&fddef->lock);
		...
                spin_unlock(&fddef->lock);
                put_cpu_var(fdtable_defer_list);
        }

I've never seen a scheduling while atomic, but seems like
it could happen . Not much contention on this lock though.

Signed-Off-By: Daniel Walker <dwalker@mvista.com>

Index: linux-2.6.16/fs/file.c
===================================================================
--- linux-2.6.16.orig/fs/file.c
+++ linux-2.6.16/fs/file.c
@@ -137,7 +137,7 @@ static void free_fdtable_rcu(struct rcu_
 		kfree(fdt->fd);
 		kfree(fdt);
 	} else {
-		fddef = &get_cpu_var(fdtable_defer_list);
+		fddef = &__get_cpu_var(fdtable_defer_list);
 		spin_lock(&fddef->lock);
 		fdt->next = fddef->next;
 		fddef->next = fdt;
@@ -149,7 +149,6 @@ static void free_fdtable_rcu(struct rcu_
 		if (!schedule_work(&fddef->wq))
 			mod_timer(&fddef->timer, 5);
 		spin_unlock(&fddef->lock);
-		put_cpu_var(fdtable_defer_list);
 	}
 }
 
