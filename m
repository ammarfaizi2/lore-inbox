Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161098AbVKDI2x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161098AbVKDI2x (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 03:28:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161101AbVKDI2x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 03:28:53 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:56245 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1161098AbVKDI2x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 03:28:53 -0500
Date: Fri, 4 Nov 2005 00:28:33 -0800 (PST)
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Simon Derr <Simon.Derr@bull.net>, Andi Kleen <ak@suse.de>,
       Paul Jackson <pj@sgi.com>, linux-kernel@vger.kernel.org,
       Christoph Lameter <clameter@sgi.com>
Message-Id: <20051104082833.8786.5266.sendpatchset@jackhammer.engr.sgi.com>
Subject: [PATCH 6/5] cpuset: rebind numa vma mempolicy fix
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch:
  [PATCH 2/5] cpuset: rebind numa vma mempolicy
requires this fix to avoid a deadlock situation
in certain cpuset removal cases.

It's ok to not complete the refresh_mems() operation
if we notice we are already holding mmap_sem.  We
will try again, next time we allocate memory.

Signed-off-by: Paul Jackson <pj@sgi.com>

---

 (This fix was included in my testing, but in another
  patch that has not been sent in yet.)

 kernel/cpuset.c |    5 +++++
 1 files changed, 5 insertions(+)

--- 2.6.14-rc5-mm1-cpuset-patches.orig/kernel/cpuset.c	2005-11-03 21:18:26.783391082 -0800
+++ 2.6.14-rc5-mm1-cpuset-patches/kernel/cpuset.c	2005-11-03 23:11:15.480042373 -0800
@@ -656,7 +656,12 @@ static void refresh_mems(void)
 	if (current->cpuset_mems_generation != my_cpusets_mem_gen) {
 		struct cpuset *cs;
 		nodemask_t oldmem = current->mems_allowed;
+		struct mm_struct *mm = current->mm;
 
+		/* numa_policy_rebind() needs mmap_sem - don't nest */
+		if (!mm || !down_write_trylock(&mm->mmap_sem))
+			return;
+		up_write(&mm->mmap_sem);
 		down(&callback_sem);
 		task_lock(current);
 		cs = current->cpuset;

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
