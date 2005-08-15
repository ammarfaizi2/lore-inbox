Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964878AbVHOSJM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964878AbVHOSJM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 14:09:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964879AbVHOSJM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 14:09:12 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:34748 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964878AbVHOSJL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 14:09:11 -0400
Date: Mon, 15 Aug 2005 11:09:08 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [-mm PATCH 4/32] mm: fix-up schedule_timeout() usage
Message-ID: <20050815180908.GG2854@us.ibm.com>
References: <20050815180514.GC2854@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050815180514.GC2854@us.ibm.com>
X-Operating-System: Linux 2.6.12 (i686)
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Description: Use schedule_timeout_{,un}interruptible() instead of
set_current_state()/schedule_timeout() to reduce kernel size.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>


---

 mm/oom_kill.c |    3 +--
 mm/swapfile.c |    3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff -urpN 2.6.13-rc5-mm1/mm/oom_kill.c 2.6.13-rc5-mm1-dev/mm/oom_kill.c
--- 2.6.13-rc5-mm1/mm/oom_kill.c	2005-08-07 09:58:16.000000000 -0700
+++ 2.6.13-rc5-mm1-dev/mm/oom_kill.c	2005-08-10 15:23:34.000000000 -0700
@@ -290,6 +290,5 @@ retry:
 	 * Give "p" a good chance of killing itself before we
 	 * retry to allocate memory.
 	 */
-	__set_current_state(TASK_INTERRUPTIBLE);
-	schedule_timeout(1);
+	schedule_timeout_interruptible(1);
 }
diff -urpN 2.6.13-rc5-mm1/mm/swapfile.c 2.6.13-rc5-mm1-dev/mm/swapfile.c
--- 2.6.13-rc5-mm1/mm/swapfile.c	2005-08-07 10:05:22.000000000 -0700
+++ 2.6.13-rc5-mm1-dev/mm/swapfile.c	2005-08-10 15:23:41.000000000 -0700
@@ -1151,8 +1151,7 @@ asmlinkage long sys_swapoff(const char _
 	p->highest_bit = 0;		/* cuts scans short */
 	while (p->flags >= SWP_SCANNING) {
 		spin_unlock(&swap_lock);
-		set_current_state(TASK_UNINTERRUPTIBLE);
-		schedule_timeout(1);
+		schedule_timeout_uninterruptible(1);
 		spin_lock(&swap_lock);
 	}
 
