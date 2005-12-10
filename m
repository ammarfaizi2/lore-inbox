Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965043AbVLJKjO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965043AbVLJKjO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Dec 2005 05:39:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965055AbVLJKjO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Dec 2005 05:39:14 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:39810 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S965043AbVLJKjO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Dec 2005 05:39:14 -0500
Date: Sat, 10 Dec 2005 02:39:02 -0800 (PST)
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Simon Derr <Simon.Derr@bull.net>,
       Paul Jackson <pj@sgi.com>, Andi Kleen <ak@suse.de>,
       Christoph Lameter <clameter@sgi.com>
Message-Id: <20051210103902.20736.14870.sendpatchset@jackhammer.engr.sgi.com>
Subject: [PATCH] Cpuset: cant mmput inside tasklist_lock fix
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mmput() inside tasklist_lock() can deadlock (thanks, Andrew).

To fix, move the range check before getting the mm, so the mm
doesn't have to be mmput if the check failed.

Also the BUG() was excessively cruel (panics) for this case.
Even though "it can't happen", still it is easy to carry
on and keep the kernel healthy, at the penalty of not placing
memory exactly where the user expected.

Signed-off-by: Paul Jackson <pj@sgi.com>

---

 kernel/cpuset.c |   14 +++++---------
 1 files changed, 5 insertions(+), 9 deletions(-)

--- 2.6.15-rc3-mm1.orig/kernel/cpuset.c	2005-12-10 01:06:00.717770568 -0800
+++ 2.6.15-rc3-mm1/kernel/cpuset.c	2005-12-10 01:29:23.604065478 -0800
@@ -881,20 +881,16 @@ static int update_nodemask(struct cpuset
 	do_each_thread(g, p) {
 		struct mm_struct *mm;
 
+		if (n >= ntasks) {
+			printk(KERN_WARNING
+				"Cpuset mempolicy rebind incomplete.\n");
+			continue;
+		}
 		if (p->cpuset != cs)
 			continue;
 		mm = get_task_mm(p);
 		if (!mm)
 			continue;
-		if (n >= ntasks) {
-			if (printk_ratelimit()) {
-				printk (KERN_ERR
-					"Cpuset mempolicy rebind failed.\n");
-				BUG();
-			}
-			mmput(mm);
-			continue;
-		}
 		mmarray[n++] = mm;
 	} while_each_thread(g, p);
 	write_unlock_irq(&tasklist_lock);

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
