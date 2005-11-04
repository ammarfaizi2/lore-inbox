Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161067AbVKDFb2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161067AbVKDFb2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 00:31:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161069AbVKDFb1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 00:31:27 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:17855 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1161067AbVKDFb0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 00:31:26 -0500
Date: Thu, 3 Nov 2005 21:31:20 -0800 (PST)
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Paul Jackson <pj@sgi.com>, Simon Derr <Simon.Derr@bull.net>,
       Andi Kleen <ak@suse.de>, Christoph Lameter <clameter@sgi.com>,
       linux-kernel@vger.kernel.org
Message-Id: <20051104053120.549.73652.sendpatchset@jackhammer.engr.sgi.com>
In-Reply-To: <20051104053109.549.76824.sendpatchset@jackhammer.engr.sgi.com>
References: <20051104053109.549.76824.sendpatchset@jackhammer.engr.sgi.com>
Subject: [PATCH 2/5] cpuset: rebind numa vma mempolicy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When automatically rebinding a NUMA mempolicy of a task
that is moved to a different cpuset, or of the tasks in
a cpuset whose memory placement 'mems' is changed, this
patch adds the code to rebind the mempolicies of the
vma's in the tasks memory space as well.

Signed-off-by: Paul Jackson <pj@sgi.com>

---

 mm/mempolicy.c |   13 +++++++++++--
 1 files changed, 11 insertions(+), 2 deletions(-)

--- 2.6.14-rc5-mm1-cpuset-patches.orig/mm/mempolicy.c	2005-10-29 21:22:39.068225953 -0700
+++ 2.6.14-rc5-mm1-cpuset-patches/mm/mempolicy.c	2005-10-29 21:30:56.420406908 -0700
@@ -1262,10 +1262,19 @@ static void rebind_policy(struct mempoli
 /*
  * Someone moved this task to different nodes.  Fixup mempolicies.
  *
- * TODO - fixup current->mm->vma and shmfs/tmpfs/hugetlbfs policies as well,
- * once we have a cpuset mechanism to mark which cpuset subtree is migrating.
+ * TODO - fixup shmfs/tmpfs/hugetlbfs policies as well.
  */
 void numa_policy_rebind(const nodemask_t *old, const nodemask_t *new)
 {
+	struct mm_struct *mm = current->mm;
+
+	if (mm) {
+		struct vm_area_struct *vma;
+
+		down_write(&mm->mmap_sem);
+		for (vma = mm->mmap; vma; vma = vma->vm_next)
+			rebind_policy(vma->vm_policy, old, new);
+		up_write(&mm->mmap_sem);
+	}
 	rebind_policy(current->mempolicy, old, new);
 }

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
