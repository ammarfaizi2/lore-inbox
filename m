Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751255AbWEQWSQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751255AbWEQWSQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 18:18:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751246AbWEQWSK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 18:18:10 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:53379 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1751245AbWEQWMI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 18:12:08 -0400
Message-Id: <20060517221415.346181000@sous-sol.org>
References: <20060517221312.227391000@sous-sol.org>
Date: Wed, 17 May 2006 00:00:22 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Linus Torvalds <torvalds@g5.osdl.org>, Oleg Nesterov <oleg@tv-sign.ru>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Roland McGrath <roland@redhat.com>
Subject: [PATCH 22/22] [PATCH] ptrace_attach: fix possible deadlock schenario with irqs
Content-Disposition: inline; filename=ptrace_attach-fix-possible-deadlock-schenario-with-irqs.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

Eric Biederman points out that we can't take the task_lock while holding
tasklist_lock for writing, because another CPU that holds the task lock
might take an interrupt that then tries to take tasklist_lock for writing.

Which would be a nasty deadlock, with one CPU spinning forever in an
interrupt handler (although admittedly you need to really work at
triggering it ;)

Since the ptrace_attach() code is special and very unusual, just make it
be extra careful, and use trylock+repeat to avoid the possible deadlock.

Cc: Oleg Nesterov <oleg@tv-sign.ru>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Roland McGrath <roland@redhat.com>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---

 kernel/ptrace.c |   20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

--- linux-2.6.16.16.orig/kernel/ptrace.c
+++ linux-2.6.16.16/kernel/ptrace.c
@@ -156,8 +156,26 @@ int ptrace_attach(struct task_struct *ta
 	if (task->tgid == current->tgid)
 		goto out;
 
-	write_lock_irq(&tasklist_lock);
+repeat:
+	/*
+	 * Nasty, nasty.
+	 *
+	 * We want to hold both the task-lock and the
+	 * tasklist_lock for writing at the same time.
+	 * But that's against the rules (tasklist_lock
+	 * is taken for reading by interrupts on other
+	 * cpu's that may have task_lock).
+	 */
 	task_lock(task);
+	local_irq_disable();
+	if (!write_trylock(&tasklist_lock)) {
+		local_irq_enable();
+		task_unlock(task);
+		do {
+			cpu_relax();
+		} while (!write_can_lock(&tasklist_lock));
+		goto repeat;
+	}
 
 	/* the same process cannot be attached many times */
 	if (task->ptrace & PT_PTRACED)

--
