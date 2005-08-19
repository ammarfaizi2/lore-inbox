Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964940AbVHSMAU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964940AbVHSMAU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 08:00:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932665AbVHSMAU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 08:00:20 -0400
Received: from imf16aec.mail.bellsouth.net ([205.152.59.64]:12784 "EHLO
	imf16aec.mail.bellsouth.net") by vger.kernel.org with ESMTP
	id S932658AbVHSMAU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 08:00:20 -0400
Date: Fri, 19 Aug 2005 08:03:14 -0400
From: David Meybohm <dmeybohmlkml@bellsouth.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] preempt race in getppid
Message-ID: <20050819120314.GA1210@localhost>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With CONFIG_PREEMPT && !CONFIG_SMP, it's possible for sys_getppid to
return a bogus value if the parent's task_struct gets reallocated after
current->group_leader->real_parent is read:

        asmlinkage long sys_getppid(void)
        {
                int pid;
                struct task_struct *me = current;
                struct task_struct *parent;

                parent = me->group_leader->real_parent;
RACE HERE =>    for (;;) {
                        pid = parent->tgid;       
        #ifdef CONFIG_SMP
        {
                        struct task_struct *old = parent;

                        /*
                         * Make sure we read the pid before re-reading the
                         * parent pointer:
                         */
                        smp_rmb();
                        parent = me->group_leader->real_parent;
                        if (old != parent)
                                continue;
        }
        #endif
                        break;
                }
                return pid;
        }

If the process gets preempted at the indicated point, the parent process
can go ahead and call exit() and then get wait()'d on to reap its
task_struct. When the preempted process gets resumed, it will not do any
further checks of the parent pointer on !CONFIG_SMP: it will read the
bad pid and return.

So, the same algorithm used when SMP is enabled should be used when
preempt is enabled, which will recheck ->real_parent in this case.

Signed-off-by: David Meybohm <dmeybohmlkml@bellsouth.net>
---

 kernel/timer.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: v2.6/kernel/timer.c
===================================================================
--- v2.6.orig/kernel/timer.c	2005-08-19 07:29:29.000000000 -0400
+++ v2.6/kernel/timer.c	2005-08-19 07:31:25.000000000 -0400
@@ -999,7 +999,7 @@ asmlinkage long sys_getppid(void)
 	parent = me->group_leader->real_parent;
 	for (;;) {
 		pid = parent->tgid;
-#ifdef CONFIG_SMP
+#if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT)
 {
 		struct task_struct *old = parent;
 
