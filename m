Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262553AbVEMVsv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262553AbVEMVsv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 17:48:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262492AbVEMVr0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 17:47:26 -0400
Received: from coderock.org ([193.77.147.115]:5013 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S262554AbVEMVol (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 17:44:41 -0400
Message-Id: <20050513214432.640931000@nd47.coderock.org>
Date: Fri, 13 May 2005 23:44:31 +0200
From: domen@coderock.org
To: rth@twiddle.net
Cc: linux-kernel@vger.kernel.org, Nishanth Aravamudan <nacc@us.ibm.com>,
       domen@coderock.org
Subject: [patch 1/1] alpha/osf_sys: use helper functions to convert between tv and jiffies
Content-Disposition: inline; filename=timeval-arch_alpha_kernel_osf_sys
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nishanth Aravamudan <nacc@us.ibm.com>


Use helper functions to convert between timeval structure and jiffies
rather than custom logic.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Domen Puncer <domen@coderock.org>

---
 osf_sys.c |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

Index: quilt/arch/alpha/kernel/osf_sys.c
===================================================================
--- quilt.orig/arch/alpha/kernel/osf_sys.c
+++ quilt/arch/alpha/kernel/osf_sys.c
@@ -1150,16 +1150,13 @@ osf_usleep_thread(struct timeval32 __use
 	if (get_tv32(&tmp, sleep))
 		goto fault;
 
-	ticks = tmp.tv_usec;
-	ticks = (ticks + (1000000 / HZ) - 1) / (1000000 / HZ);
-	ticks += tmp.tv_sec * HZ;
+	ticks = timeval_to_jiffies(&tmp);
 
 	current->state = TASK_INTERRUPTIBLE;
 	ticks = schedule_timeout(ticks);
 
 	if (remain) {
-		tmp.tv_sec = ticks / HZ;
-		tmp.tv_usec = ticks % HZ;
+		jiffies_to_timeval(ticks, &tmp);
 		if (put_tv32(remain, &tmp))
 			goto fault;
 	}

--
