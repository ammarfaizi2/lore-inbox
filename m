Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750788AbWC2JLU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750788AbWC2JLU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 04:11:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750789AbWC2JLT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 04:11:19 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:46789 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750788AbWC2JLS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 04:11:18 -0500
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Paul Jackson <pj@sgi.com>, Simon.Derr@bull.net,
       linux-kernel@vger.kernel.org, clameter@sgi.com
Date: Wed, 29 Mar 2006 01:11:14 -0800
Message-Id: <20060329091114.14612.8784.sendpatchset@jackhammer.engr.sgi.com>
In-Reply-To: <20060329091108.14612.84403.sendpatchset@jackhammer.engr.sgi.com>
References: <20060329091108.14612.84403.sendpatchset@jackhammer.engr.sgi.com>
Subject: [PATCH 02/03] Cpuset: unsafe mm reference fix
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Jackson <pj@sgi.com>

Fix unsafe reference to a tasks mm struct, by moving the
reference inside of a convenient nearby properly guarded
code block.

Signed-off-by: Paul Jackson <pj@sgi.com>

---

 kernel/cpuset.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- 2.6.16-mm1.orig/kernel/cpuset.c	2006-03-27 08:44:26.165846244 -0800
+++ 2.6.16-mm1/kernel/cpuset.c	2006-03-27 08:44:27.405861502 -0800
@@ -1183,11 +1183,11 @@ static int attach_task(struct cpuset *cs
 	mm = get_task_mm(tsk);
 	if (mm) {
 		mpol_rebind_mm(mm, &to);
+		if (is_memory_migrate(cs))
+			do_migrate_pages(mm, &from, &to, MPOL_MF_MOVE_ALL);
 		mmput(mm);
 	}
 
-	if (is_memory_migrate(cs))
-		do_migrate_pages(tsk->mm, &from, &to, MPOL_MF_MOVE_ALL);
 	put_task_struct(tsk);
 	synchronize_rcu();
 	if (atomic_dec_and_test(&oldcs->count))

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
