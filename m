Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262795AbSIPSoG>; Mon, 16 Sep 2002 14:44:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262802AbSIPSoG>; Mon, 16 Sep 2002 14:44:06 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:64273
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S262795AbSIPSoF>; Mon, 16 Sep 2002 14:44:05 -0400
Subject: [PATCH] BUG(): sched.c: Line 944
From: Robert Love <rml@tech9.net>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 16 Sep 2002 14:48:58 -0400
Message-Id: <1032202138.969.12.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The current in_atomic() check fails with kernel preemption enabled since
we set preempt_count to PREEMPT_ACTIVE in preempt_schedule().

We need to additionally check whether PREEMPT_ACTIVE is set.

There is also still the issue that bugging out is a bit drastic and a
hindrance to debugging; but I will tackle that later.  For now, please
apply this so we can at least boot with preemption enabled.

Patch is against 2.5.35-bk.

	Robert Love

diff -urN linux-2.5.35/kernel/sched.c linux/kernel/sched.c
--- linux-2.5.35/kernel/sched.c	Sun Sep 15 22:18:24 2002
+++ linux/kernel/sched.c	Mon Sep 16 14:43:54 2002
@@ -940,8 +940,7 @@
 	struct list_head *queue;
 	int idx;
 
-	if (unlikely(in_atomic()))
-		BUG();
+	BUG_ON(in_atomic() && preempt_count() != PREEMPT_ACTIVE);
 
 #if CONFIG_DEBUG_HIGHMEM
 	check_highmem_ptes();
@@ -959,7 +958,7 @@
 	 * if entering off of a kernel preemption go straight
 	 * to picking the next task.
 	 */
-	if (unlikely(preempt_count() & PREEMPT_ACTIVE))
+	if (unlikely(preempt_count() == PREEMPT_ACTIVE))
 		goto pick_next_task;
 
 	switch (prev->state) {

