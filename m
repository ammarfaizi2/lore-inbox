Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267904AbUIKIaj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267904AbUIKIaj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 04:30:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267796AbUIKI3X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 04:29:23 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:49133 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S267772AbUIKI3A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 04:29:00 -0400
Date: Sat, 11 Sep 2004 01:28:26 -0700 (PDT)
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Paul Jackson <pj@sgi.com>, Simon Derr <Simon.Derr@bull.net>,
       linux-kernel@vger.kernel.org
Message-Id: <20040911082828.10372.39917.52342@sam.engr.sgi.com>
In-Reply-To: <20040911082810.10372.86008.84920@sam.engr.sgi.com>
References: <20040911082810.10372.86008.84920@sam.engr.sgi.com>
Subject: [Patch 3/4] cpusets remove useless validation check
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As reported to me by Simon Derr, there was an off by one
error in checking the usage count in validate_change().
However, after realizing that there was no way to exploit
this error, I determined that the check (for an empty
cpuset) could never fail here.  This is because:
 1) other code ensures we only attach a task to non-empty
    cpusets, and
 2) there is no way to make a non-empty cpuset empty again.

So, rather than fix the useless check, just remove it.

Signed-off-by: Paul Jackson <pj@sgi.com>

Index: 2.6.9-rc1-mm4/kernel/cpuset.c
===================================================================
--- 2.6.9-rc1-mm4.orig/kernel/cpuset.c	2004-09-08 18:44:33.000000000 -0700
+++ 2.6.9-rc1-mm4/kernel/cpuset.c	2004-09-08 18:45:40.000000000 -0700
@@ -501,14 +501,6 @@ static int validate_change(const struct 
 	if (cur == &top_cpuset)
 		return -EPERM;
 
-	/* Any in-use cpuset must have at least ONE cpu and mem */
-	if (atomic_read(&trial->count) > 1) {
-		if (cpus_empty(trial->cpus_allowed))
-			return -ENOSPC;
-		if (nodes_empty(trial->mems_allowed))
-			return -ENOSPC;
-	}
-
 	/* We must be a subset of our parent cpuset */
 	if (!is_cpuset_subset(trial, par))
 		return -EACCES;

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
