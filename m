Return-Path: <linux-kernel-owner+w=401wt.eu-S965135AbWLMUCR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965135AbWLMUCR (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 15:02:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965088AbWLMUCQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 15:02:16 -0500
Received: from agminet02.oracle.com ([141.146.126.229]:33369 "EHLO
	agminet02.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965147AbWLMUCP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 15:02:15 -0500
X-Greylist: delayed 381 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Dec 2006 15:02:15 EST
Date: Wed, 13 Dec 2006 11:55:38 -0800
From: Mark Fasheh <mark.fasheh@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, jim.houston@ccur.com, sunil.mushran@oracle.com
Subject: [PATCH] Conditionally check expected_preempt_count in __resched_legal()
Message-ID: <20061213195537.GH6831@ca-server1.us.oracle.com>
Reply-To: Mark Fasheh <mark.fasheh@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Oracle Corporation
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 2d7d253548cffdce80f4e03664686e9ccb1b0ed7 ("fix cond_resched() fix")
introduced an 'expected_preempt_count' parameter to __resched_legal() to fix
a bug where it was returning a false negative when called from
cond_resched_lock() and preemption was enabled.

Unfortunately this broke things for when preemption is disabled.
preempt_count() will always return zero, thus failing the check against
any value of expected_preempt_count not equal to zero. cond_resched_lock()
for example, passes an expected_preempt_count value of 1.

So fix the fix for the cond_resched() fix by skipping the check of
preempt_count() against expected_preempt_count when preemption is disabled.

Credit should go to Sunil Mushran for spotting the bug during testing.

Signed-off-by: Mark Fasheh <mark.fasheh@oracle.com>
---
 kernel/sched.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/kernel/sched.c b/kernel/sched.c
index 8a0afb9..82b971f 100644
--- a/kernel/sched.c
+++ b/kernel/sched.c
@@ -4616,8 +4616,10 @@ asmlinkage long sys_sched_yield(void)
 
 static inline int __resched_legal(int expected_preempt_count)
 {
+#ifdef CONFIG_PREEMPT
 	if (unlikely(preempt_count() != expected_preempt_count))
 		return 0;
+#endif
 	if (unlikely(system_state != SYSTEM_RUNNING))
 		return 0;
 	return 1;
-- 
1.4.2.4

