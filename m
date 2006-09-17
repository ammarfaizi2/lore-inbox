Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965038AbWIQRxq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965038AbWIQRxq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Sep 2006 13:53:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965040AbWIQRxp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Sep 2006 13:53:45 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:52201 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S965038AbWIQRxi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Sep 2006 13:53:38 -0400
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
Date: Sun, 17 Sep 2006 20:42:40 +0530
Message-Id: <20060917151240.11160.86828.sendpatchset@localhost.localdomain>
In-Reply-To: <20060917151212.11160.2513.sendpatchset@localhost.localdomain>
References: <20060917151212.11160.2513.sendpatchset@localhost.localdomain>
Subject: [RFC][PATCH 3/4] Aggregated beancounters syscall support
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Change the system calls to operate with aggregated beancounters instead
of beancounters.

Signed-off-by: Balbir Singh <balbir@in.ibm.com>
---

 kernel/bc/sys.c |   91 ++++++++++++++++++++++++++++++++++++++------------------
 1 files changed, 63 insertions(+), 28 deletions(-)

diff -puN kernel/bc/sys.c~aggr-bc-syscalls kernel/bc/sys.c
--- linux-2.6.18-rc5/kernel/bc/sys.c~aggr-bc-syscalls	2006-09-17 20:34:02.000000000 +0530
+++ linux-2.6.18-rc5-balbir/kernel/bc/sys.c	2006-09-17 20:34:02.000000000 +0530
@@ -10,39 +10,60 @@
 
 #include <bc/beancounter.h>
 #include <bc/task.h>
+#include <bc/vmpages.h>
 
 asmlinkage long sys_get_bcid(void)
 {
 	struct beancounter *bc;
 
 	bc = get_exec_bc();
-	return bc->bc_id;
+	return bc->ab->ab_id;
 }
 
-asmlinkage long sys_set_bcid(bcid_t id)
+asmlinkage long sys_set_bcid(bcid_t id, pid_t pid)
 {
 	int error;
-	struct beancounter *bc;
-	struct task_beancounter *task_bc;
-
-	task_bc = &current->task_bc;
+	struct beancounter *bc, *new_bc;
+	struct aggr_beancounter *ab;
+	struct task_struct *tsk;
 
 	/* You may only set an bc as root */
 	error = -EPERM;
 	if (!capable(CAP_SETUID))
+		return error;
+
+	read_lock(&tasklist_lock);
+	tsk = find_task_by_pid(pid);
+	if (!tsk) {
+		read_unlock(&tasklist_lock);
+		error = -ESRCH;
 		goto out;
+	}
+	read_unlock(&tasklist_lock);
+
+	error = -EINVAL;
+	if (id == tsk->task_bc.exec_bc->ab->ab_id)
+		return error;
 
 	/* Ok - set up a beancounter entry for this user */
 	error = -ENOMEM;
-	bc = beancounter_findcreate(id, BC_ALLOC);
-	if (bc == NULL)
+	ab = ab_findcreate(id, BC_ALLOC);
+	if (ab == NULL)
 		goto out;
 
-	/* install bc */
-	put_beancounter(task_bc->exec_bc);
-	task_bc->exec_bc = bc;
-	put_beancounter(task_bc->fork_bc);
-	task_bc->fork_bc = get_beancounter(bc);
+	/*
+	 * Check if limits allow the move - or reclaim if required
+	 * TODO:
+	 */
+
+	get_task_struct(tsk);
+	bc = tsk->task_bc.exec_bc;
+	new_bc = beancounter_relocate(ab, bc->ab, tsk->tgid);
+	put_task_struct(tsk);
+	if (new_bc == NULL) {
+		put_aggr_beancounter(ab);
+		error = -ESRCH;
+	}
 	error = 0;
 out:
 	return error;
@@ -53,7 +74,7 @@ asmlinkage long sys_set_bclimit(bcid_t i
 {
 	int error;
 	unsigned long flags;
-	struct beancounter *bc;
+	struct aggr_beancounter *ab;
 	unsigned long new_limits[2];
 
 	error = -EPERM;
@@ -74,45 +95,59 @@ asmlinkage long sys_set_bclimit(bcid_t i
 		goto out;
 
 	error = -ENOENT;
-	bc = beancounter_findcreate(id, BC_LOOKUP);
-	if (bc == NULL)
+	ab = ab_findcreate(id, BC_LOOKUP);
+	if (ab == NULL)
 		goto out;
 
-	spin_lock_irqsave(&bc->bc_lock, flags);
-	bc->bc_parms[resource].barrier = new_limits[0];
-	bc->bc_parms[resource].limit = new_limits[1];
-	spin_unlock_irqrestore(&bc->bc_lock, flags);
+	spin_lock_irqsave(&ab->ab_lock, flags);
+	ab->ab_parms[resource].barrier = new_limits[0];
+	ab->ab_parms[resource].limit = new_limits[1];
+	spin_unlock_irqrestore(&ab->ab_lock, flags);
 
-	put_beancounter(bc);
+	put_aggr_beancounter(ab);
 	error = 0;
 out:
 	return error;
 }
 
-int sys_get_bcstat(bcid_t id, unsigned long resource,
-		struct bc_resource_parm __user *uparm)
+int sys_get_bcstat(bcid_t bc_id, bcid_t ab_id, unsigned long resource,
+			struct bc_resource_parm __user *bc_uparm,
+			struct ab_resource_parm __user *ab_uparm)
 {
 	int error;
 	unsigned long flags;
 	struct beancounter *bc;
-	struct bc_resource_parm parm;
+	struct aggr_beancounter *ab;
+	struct bc_resource_parm bc_parm;
+	struct ab_resource_parm ab_parm;
 
 	error = -EINVAL;
 	if (resource >= BC_RESOURCES)
 		goto out;
 
 	error = -ENOENT;
-	bc = beancounter_findcreate(id, BC_LOOKUP);
-	if (bc == NULL)
+	ab = ab_findcreate(ab_id, BC_LOOKUP);
+	if (ab == NULL)
 		goto out;
+	spin_lock_irqsave(&ab->ab_lock, flags);
+	bc = beancounter_find_locked(ab, bc_id);
+	if (bc == NULL) {
+		spin_unlock_irqrestore(&ab->ab_lock, flags);
+		goto out;
+	}
 
 	spin_lock_irqsave(&bc->bc_lock, flags);
-	parm = bc->bc_parms[resource];
+	bc_parm = bc->bc_parms[resource];
 	spin_unlock_irqrestore(&bc->bc_lock, flags);
+	ab_parm = ab->ab_parms[resource];
+	spin_unlock_irqrestore(&ab->ab_lock, flags);
 	put_beancounter(bc);
+	put_aggr_beancounter(ab);
 
 	error = 0;
-	if (copy_to_user(uparm, &parm, sizeof(parm)))
+	if (copy_to_user(bc_uparm, &bc_parm, sizeof(bc_parm)))
+		error = -EFAULT;
+	if (copy_to_user(ab_uparm, &ab_parm, sizeof(ab_parm)))
 		error = -EFAULT;
 
 out:
_

-- 

	Balbir Singh,
	Linux Technology Center,
	IBM Software Labs
