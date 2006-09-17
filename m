Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965036AbWIQRx1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965036AbWIQRx1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Sep 2006 13:53:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965037AbWIQRx1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Sep 2006 13:53:27 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:53431 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S965036AbWIQRxZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Sep 2006 13:53:25 -0400
X-Mozilla-Status: 0001
X-Mozilla-Status2: 00000000
X-Sieve: CMU Sieve 2.3
X-Spam-TestScore: none
X-Spam-TokenSummary: Bayes not run.
X-Spam-Relay-Country: US ** US US ** US US ** US
From: Balbir Singh <balbir@in.ibm.com>
To: Kirill Korotaev <dev@sw.ru>
Cc: Rik van Riel <riel@redhat.com>, Srivatsa <vatsa@in.ibm.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
       Dave Hansen <haveblue@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Christoph Hellwig <hch@infradead.org>,
       Andrey Savochkin <saw@sw.ru>, Matt Helsley <matthltc@us.ibm.com>,
       Hugh Dickins <hugh@veritas.com>, Alexey Dobriyan <adobriyan@mail.ru>,
       Oleg Nesterov <oleg@tv-sign.ru>, devel@openvz.org,
       Pavel Emelianov <xemul@openvz.org>, Balbir Singh <balbir@in.ibm.com>
Date: Sun, 17 Sep 2006 20:42:21 +0530
Message-Id: <20060917151221.11160.57605.sendpatchset@localhost.localdomain>
In-Reply-To: <20060917151212.11160.2513.sendpatchset@localhost.localdomain>
References: <20060917151212.11160.2513.sendpatchset@localhost.localdomain>
Subject: [RFC][PATCH 1/4] Add a beancounter per tgid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Create one beancounter per thread group. This is the base patch and serves
as the starting point for aggregating thread groups.

Signed-off-by: Balbir Singh <balbir@in.ibm.com>
---

 kernel/bc/misc.c |   11 +++++++----
 kernel/fork.c    |    4 ++--
 2 files changed, 9 insertions(+), 6 deletions(-)

diff -puN kernel/bc/misc.c~per-tgid-beancounters kernel/bc/misc.c
--- linux-2.6.18-rc5/kernel/bc/misc.c~per-tgid-beancounters	2006-09-12 22:27:02.000000000 +0530
+++ linux-2.6.18-rc5-balbir/kernel/bc/misc.c	2006-09-17 20:30:55.000000000 +0530
@@ -12,15 +12,18 @@
 
 void bc_task_charge(struct task_struct *parent, struct task_struct *new)
 {
-	struct task_beancounter *old_bc;
 	struct task_beancounter *new_bc;
 	struct beancounter *bc;
 
-	old_bc = &parent->task_bc;
 	new_bc = &new->task_bc;
+	bc = beancounter_findcreate(new->tgid, BC_ALLOC);
+	if (!bc) {
+		printk(KERN_WARNING "failed to create bc %d for tgid %d\n",
+			bc->bc_id, new->tgid);
+		return;
+	}
 
-	bc = old_bc->fork_bc;
-	new_bc->exec_bc = get_beancounter(bc);
+	new_bc->exec_bc = bc;
 	new_bc->fork_bc = get_beancounter(bc);
 }
 
diff -puN kernel/fork.c~per-tgid-beancounters kernel/fork.c
--- linux-2.6.18-rc5/kernel/fork.c~per-tgid-beancounters	2006-09-12 22:27:02.000000000 +0530
+++ linux-2.6.18-rc5-balbir/kernel/fork.c	2006-09-12 22:32:26.000000000 +0530
@@ -994,8 +994,6 @@ static struct task_struct *copy_process(
 	if (!p)
 		goto fork_out;
 
-	bc_task_charge(current, p);
-
 #ifdef CONFIG_TRACE_IRQFLAGS
 	DEBUG_LOCKS_WARN_ON(!p->hardirqs_enabled);
 	DEBUG_LOCKS_WARN_ON(!p->softirqs_enabled);
@@ -1106,6 +1104,8 @@ static struct task_struct *copy_process(
 	if (clone_flags & CLONE_THREAD)
 		p->tgid = current->tgid;
 
+	bc_task_charge(current, p);
+
 	if ((retval = security_task_alloc(p)))
 		goto bad_fork_cleanup_policy;
 	if ((retval = audit_alloc(p)))
_

-- 

	Balbir Singh,
	Linux Technology Center,
	IBM Software Labs
