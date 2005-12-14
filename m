Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932167AbVLNIl2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932167AbVLNIl2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 03:41:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932152AbVLNIl0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 03:41:26 -0500
Received: from omx3-ext.sgi.com ([192.48.171.25]:61910 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S932143AbVLNIlD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 03:41:03 -0500
Date: Wed, 14 Dec 2005 00:40:49 -0800 (PST)
From: Paul Jackson <pj@sgi.com>
To: akpm@osdl.org
Cc: Eric Dumazet <dada1@cosmosbay.com>, linux-kernel@vger.kernel.org,
       Nick Piggin <nickpiggin@yahoo.com.au>, Simon Derr <Simon.Derr@bull.net>,
       Andi Kleen <ak@suse.de>, Paul Jackson <pj@sgi.com>,
       Christoph Lameter <clameter@sgi.com>
Message-Id: <20051214084049.21054.34108.sendpatchset@jackhammer.engr.sgi.com>
In-Reply-To: <20051214084031.21054.13829.sendpatchset@jackhammer.engr.sgi.com>
References: <20051214084031.21054.13829.sendpatchset@jackhammer.engr.sgi.com>
Subject: [PATCH 04/04] Cpuset: skip rcu check if task is in root cpuset
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For systems that aren't using cpusets, but have them
CONFIG_CPUSET enabled in their kernel (eventually this
may be most distribution kernels), this patch removes
even the minimal rcu_read_lock() from the memory page
allocation path.

Actually, it removes that rcu call for any task that is
in the root cpuset (top_cpuset), which on systems not
actively using cpusets, is all tasks.

We don't need the rcu check for tasks in the top_cpuset,
because the top_cpuset is statically allocated, so at
no risk of being freed out from underneath us.

Signed-off-by: Paul Jackson <pj@sgi.com>

---

 kernel/cpuset.c |   13 +++++++++----
 1 files changed, 9 insertions(+), 4 deletions(-)

--- 2.6.15-rc3-mm1.orig/kernel/cpuset.c	2005-12-13 18:14:42.529952708 -0800
+++ 2.6.15-rc3-mm1/kernel/cpuset.c	2005-12-13 20:54:26.323911532 -0800
@@ -647,10 +647,15 @@ void cpuset_update_task_memory_state()
 	struct task_struct *tsk = current;
 	struct cpuset *cs;
 
-	rcu_read_lock();
-	cs = rcu_dereference(tsk->cpuset);
-	my_cpusets_mem_gen = cs->mems_generation;
-	rcu_read_unlock();
+	if (tsk->cpuset == &top_cpuset) {
+		/* Don't need rcu for top_cpuset.  It's never freed. */
+		my_cpusets_mem_gen = top_cpuset.mems_generation;
+	} else {
+		rcu_read_lock();
+		cs = rcu_dereference(tsk->cpuset);
+		my_cpusets_mem_gen = cs->mems_generation;
+		rcu_read_unlock();
+	}
 
 	if (my_cpusets_mem_gen != tsk->cpuset_mems_generation) {
 		down(&callback_sem);

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
