Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267160AbSLRFuO>; Wed, 18 Dec 2002 00:50:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267170AbSLRFuO>; Wed, 18 Dec 2002 00:50:14 -0500
Received: from holomorphy.com ([66.224.33.161]:11963 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S267160AbSLRFuN>;
	Wed, 18 Dec 2002 00:50:13 -0500
Date: Tue, 17 Dec 2002 21:57:42 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: chris@wirex.com
Cc: greg@kroah.com, linux-kernel@vger.kernel.org
Subject: converting cap_set_pg() to for_each_task_pid()
Message-ID: <20021218055742.GE12812@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	chris@wirex.com, greg@kroah.com, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a pending patch that converts cap_set_pg() to the
for_each_task_pid() API. Could you review this, and if it
pass, include it in your tree?


Thanks,
Bill


cap_set_pg() wants to find all processes in a given process group. This
converts it to use for_each_task_pid().

 capability.c |   16 +++++++++-------
 1 files changed, 9 insertions(+), 7 deletions(-)


diff -urpN wli-2.5.51-bk1-4/kernel/capability.c wli-2.5.51-bk1-5/kernel/capability.c
--- wli-2.5.51-bk1-4/kernel/capability.c	2002-12-09 18:45:43.000000000 -0800
+++ wli-2.5.51-bk1-5/kernel/capability.c	2002-12-11 18:32:44.000000000 -0800
@@ -84,13 +84,15 @@ static inline void cap_set_pg(int pgrp, 
 			      kernel_cap_t *inheritable,
 			      kernel_cap_t *permitted)
 {
-     task_t *g, *target;
-
-     do_each_thread(g, target) {
-             if (target->pgrp != pgrp)
-                     continue;
-	     security_capset_set(target, effective, inheritable, permitted);
-     } while_each_thread(g, target);
+	task_t *g, *target;
+	struct list_head *l;
+	struct pid *pid;
+
+	for_each_task_pid(pgrp, PIDTYPE_PGID, g, l, pid) {
+		target = g;
+		while_each_thread(g, target)
+			security_capset_set(target, effective, inheritable, permitted);
+	}
 }
 
 /*
