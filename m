Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932112AbWGXLXf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932112AbWGXLXf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 07:23:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932117AbWGXLXf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 07:23:35 -0400
Received: from mtagate2.uk.ibm.com ([195.212.29.135]:42720 "EHLO
	mtagate2.uk.ibm.com") by vger.kernel.org with ESMTP id S932112AbWGXLXf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 07:23:35 -0400
Date: Mon, 24 Jul 2006 13:21:12 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Arjan van de Ven <arjan@infradead.org>,
       Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
Subject: [patch] pi-futex: missing pi_waiters plist initialization
Message-ID: <20060724112112.GA16537@osiris.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Initialize init task's pi_waiters plist. Otherwise cpu hotplug of cpu 0
might crash, since rt_mutex_getprio() accesses an uninitialized list head.

call chain which led to crash:

take_cpu_down
sched_idle_next
__setscheduler
rt_mutex_getprio

Using PLIST_HEAD_INIT in the INIT_TASK macro doesn't work unfortunately, since
the pi_waiters member is only conditionally present.

Cc: Arjan van de Ven <arjan@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

 kernel/sched.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/sched.c b/kernel/sched.c
index b44b9a4..db1014d 100644
--- a/kernel/sched.c
+++ b/kernel/sched.c
@@ -6761,6 +6761,11 @@ #endif
 	}
 
 	set_load_weight(&init_task);
+
+#ifdef CONFIG_RT_MUTEXES
+	plist_head_init(&init_task.pi_waiters, &init_task.pi_lock);
+#endif
+
 	/*
 	 * The boot idle thread does lazy MMU switching as well:
 	 */
