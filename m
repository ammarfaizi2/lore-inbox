Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932370AbWFGRmc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932370AbWFGRmc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 13:42:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932366AbWFGRmb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 13:42:31 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:47549 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932369AbWFGRmF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 13:42:05 -0400
From: Balbir Singh <balbir@in.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Cc: Balbir Singh <balbir@in.ibm.com>
Date: Wed, 07 Jun 2006 23:06:36 +0530
Message-Id: <20060607173636.31231.39254.sendpatchset@localhost.localdomain>
Subject: [PATCH -mm] Fix return value of delayacct_add_tsk()
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Andrew,

This patch is to be applied on top of 
per-task-delay-accounting-taskstats-interface-fix-2.patch

Currently fill_tgid() fails if any thread in a thread_group has a missing
delays structure. This behaviour is incorrect in the case when a thread group
leader exits before any of the other threads in the group. The leader continues
to be examined but has a null tsk->delays struct. The correct behaviour is to
skip threads with a null delays struct and continue accumulating delay
accounting statistics for the other threads.

The patch also adds an explicit check for delay accounting being on since
presence or absence of tsk->delays struct is no longer an equivalent check.


Signed-off-by: Balbir Singh <balbir@in.ibm.com>
Signed-off-by: Shailabh Nagar <nagar@us.ibm.com>

---

 include/linux/delayacct.h |    4 +++-
 1 files changed, 3 insertions(+), 1 deletion(-)

diff -puN include/linux/delayacct.h~per-task-delay-accounting-taskstats-interface-fix-3 include/linux/delayacct.h
--- linux-2.6.17-rc5/include/linux/delayacct.h~per-task-delay-accounting-taskstats-interface-fix-3	2006-06-07 22:57:12.000000000 +0530
+++ linux-2.6.17-rc5-balbir/include/linux/delayacct.h	2006-06-07 22:57:39.000000000 +0530
@@ -80,8 +80,10 @@ static inline void delayacct_blkio_end(v
 static inline int delayacct_add_tsk(struct taskstats *d,
 					struct task_struct *tsk)
 {
-	if (!tsk->delays)
+	if (likely(!delayacct_on))
 		return -EINVAL;
+	if (!tsk->delays)
+		return 0;
 	return __delayacct_add_tsk(d, tsk);
 }
 
_

-- 

	Balbir Singh,
	Linux Technology Center,
	IBM Software Labs
