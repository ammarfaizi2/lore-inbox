Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750710AbWBISyo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750710AbWBISyo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 13:54:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750708AbWBISyd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 13:54:33 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:17545 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750705AbWBISyc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 13:54:32 -0500
From: Paul Jackson <pj@sgi.com>
To: akpm@osdl.org
Cc: steiner@sgi.com, dgc@sgi.com, Simon.Derr@bull.net, ak@suse.de,
       linux-kernel@vger.kernel.org, Paul Jackson <pj@sgi.com>,
       clameter@sgi.com
Date: Thu, 09 Feb 2006 10:54:24 -0800
Message-Id: <20060209185424.8596.89333.sendpatchset@jackhammer.engr.sgi.com>
In-Reply-To: <20060209185418.8596.90838.sendpatchset@jackhammer.engr.sgi.com>
References: <20060209185418.8596.90838.sendpatchset@jackhammer.engr.sgi.com>
Subject: [PATCH v2 02/07] cpuset use combined atomic_inc_return calls
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Jackson <pj@sgi.com>

Replace pairs of calls to <atomic_inc, atomic_read>, with a single
call atomic_inc_return, saving a few bytes of source and kernel text.

Signed-off-by: Paul Jackson <pj@sgi.com>

---

 kernel/cpuset.c |   11 ++++-------
 1 files changed, 4 insertions(+), 7 deletions(-)

--- 2.6.16-rc1-mm5.orig/kernel/cpuset.c	2006-02-07 16:26:03.511639777 -0800
+++ 2.6.16-rc1-mm5/kernel/cpuset.c	2006-02-07 16:26:43.563843169 -0800
@@ -858,8 +858,7 @@ static int update_nodemask(struct cpuset
 
 	mutex_lock(&callback_mutex);
 	cs->mems_allowed = trialcs.mems_allowed;
-	atomic_inc(&cpuset_mems_generation);
-	cs->mems_generation = atomic_read(&cpuset_mems_generation);
+	cs->mems_generation = atomic_inc_return(&cpuset_mems_generation);
 	mutex_unlock(&callback_mutex);
 
 	set_cpuset_being_rebound(cs);		/* causes mpol_copy() rebind */
@@ -1770,8 +1769,7 @@ static long cpuset_create(struct cpuset 
 	atomic_set(&cs->count, 0);
 	INIT_LIST_HEAD(&cs->sibling);
 	INIT_LIST_HEAD(&cs->children);
-	atomic_inc(&cpuset_mems_generation);
-	cs->mems_generation = atomic_read(&cpuset_mems_generation);
+	cs->mems_generation = atomic_inc_return(&cpuset_mems_generation);
 	fmeter_init(&cs->fmeter);
 
 	cs->parent = parent;
@@ -1861,7 +1859,7 @@ int __init cpuset_init_early(void)
 	struct task_struct *tsk = current;
 
 	tsk->cpuset = &top_cpuset;
-	tsk->cpuset->mems_generation = atomic_read(&cpuset_mems_generation);
+	tsk->cpuset->mems_generation = atomic_inc_return(&cpuset_mems_generation);
 	return 0;
 }
 
@@ -1880,8 +1878,7 @@ int __init cpuset_init(void)
 	top_cpuset.mems_allowed = NODE_MASK_ALL;
 
 	fmeter_init(&top_cpuset.fmeter);
-	atomic_inc(&cpuset_mems_generation);
-	top_cpuset.mems_generation = atomic_read(&cpuset_mems_generation);
+	top_cpuset.mems_generation = atomic_inc_return(&cpuset_mems_generation);
 
 	init_task.cpuset = &top_cpuset;
 

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
