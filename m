Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964971AbWHHPvT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964971AbWHHPvT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 11:51:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964972AbWHHPvT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 11:51:19 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:31854 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S964971AbWHHPvS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 11:51:18 -0400
Message-ID: <44D8B2C5.1080905@sw.ru>
Date: Tue, 08 Aug 2006 19:50:29 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       alan@lxorguk.ukuu.org.uk, muli@il.ibm.com, B.Steinbrink@gmx.de,
       stable@kernel.org, Dave Hansen <haveblue@us.ibm.com>
Subject: [PATCH] sys_getppid oopses on debug kernel (v2)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sys_getppid() optimization can access a freed memory.
On kernels with DEBUG_SLAB turned ON, this results in Oops.
As Dave Hansen noted, this optimization is also unsafe
for memory hotplug.

So this patch always takes the lock to be safe.

Signed-Off-By: Kirill Korotaev <dev@openvz.org>


--- ./kernel/timer.c.ppiddbg	2006-07-14 19:11:06.000000000 +0400
+++ ./kernel/timer.c	2006-08-08 19:45:57.000000000 +0400
@@ -1342,28 +1342,11 @@ asmlinkage long sys_getpid(void)
 asmlinkage long sys_getppid(void)
 {
 	int pid;
-	struct task_struct *me = current;
-	struct task_struct *parent;
 
-	parent = me->group_leader->real_parent;
-	for (;;) {
-		pid = parent->tgid;
-#if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT)
-{
-		struct task_struct *old = parent;
+	read_lock(&tasklist_lock);
+	pid = current->group_leader->real_parent->tgid;
+	read_unlock(&tasklist_lock);
 
-		/*
-		 * Make sure we read the pid before re-reading the
-		 * parent pointer:
-		 */
-		smp_rmb();
-		parent = me->group_leader->real_parent;
-		if (old != parent)
-			continue;
-}
-#endif
-		break;
-	}
 	return pid;
 }
 
