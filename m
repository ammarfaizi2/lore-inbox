Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265800AbUGTLXM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265800AbUGTLXM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 07:23:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265799AbUGTLXM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 07:23:12 -0400
Received: from aun.it.uu.se ([130.238.12.36]:48377 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S265805AbUGTLWp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 07:22:45 -0400
Date: Tue, 20 Jul 2004 13:22:37 +0200 (MEST)
Message-Id: <200407201122.i6KBMbPR021614@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: akpm@osdl.org
Subject: [RFC][2.6.8-rc1-mm1] perfctr inheritance locking issue
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

There is another locking problem with the per-process
performance counter inheritance changes I sent you.

I currently use task_lock(tsk) to synchronise accesses
to tsk->thread.perfctr, when that pointer could change.

The write_lock_irq(&tasklist_lock) in release_task() is
needed to prevent ->parent from changing while releasing the
child, but the parent's ->thread.perfctr must also be locked.
However, sched.h explicitly forbids holding task_lock()
simultaneously with write_lock_irq(&tasklist_lock). Ouch.

My options seem to boil down to one of the following:
1. Forget task_lock(), always take the tasklist_lock.
   This should work but would lock the task list briefly at
   operations like set_cpus_allowed(), and creating/deleting
   a task's perfctr state object. I don't like that.
2. Add a 'spinlock_t perfctr_lock;' to the thread_struct,
   next to the perfctr state pointer. This is much cleaner,
   but increases the size of the thread struct slightly.

I think I prefer option #2. Any objections to that?

/Mikael
