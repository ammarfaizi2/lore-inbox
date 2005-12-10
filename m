Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964973AbVLJIV6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964973AbVLJIV6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Dec 2005 03:21:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964978AbVLJITd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Dec 2005 03:19:33 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:4057 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S964966AbVLJITG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Dec 2005 03:19:06 -0500
Date: Sat, 10 Dec 2005 00:19:00 -0800 (PST)
From: Paul Jackson <pj@sgi.com>
To: akpm@osdl.org
Cc: Paul Jackson <pj@sgi.com>, Simon Derr <Simon.Derr@bull.net>,
       linux-kernel@vger.kernel.org, Christoph Lameter <clameter@sgi.com>
Message-Id: <20051210081900.12303.58154.sendpatchset@jackhammer.engr.sgi.com>
In-Reply-To: <20051210081843.12303.13344.sendpatchset@jackhammer.engr.sgi.com>
References: <20051210081843.12303.13344.sendpatchset@jackhammer.engr.sgi.com>
Subject: [PATCH 03/10] Cpuset: update_nodemask code reformat
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Restructure code layout of the kernel/cpuset.c update_nodemask()
routine, removing embedded returns and nested if's in favor of
goto completion labels.  This is being done in anticipation of
adding more logic to this routine, which will favor the goto
style structure.

Signed-off-by: Paul Jackson <pj@sgi.com>

---

 kernel/cpuset.c |   25 +++++++++++++++----------
 1 files changed, 15 insertions(+), 10 deletions(-)

--- 2.6.15-rc3-mm1.orig/kernel/cpuset.c	2005-12-07 19:15:37.420771718 -0800
+++ 2.6.15-rc3-mm1/kernel/cpuset.c	2005-12-07 19:16:31.104966322 -0800
@@ -799,18 +799,23 @@ static int update_nodemask(struct cpuset
 	trialcs = *cs;
 	retval = nodelist_parse(buf, trialcs.mems_allowed);
 	if (retval < 0)
-		return retval;
+		goto done;
 	nodes_and(trialcs.mems_allowed, trialcs.mems_allowed, node_online_map);
-	if (nodes_empty(trialcs.mems_allowed))
-		return -ENOSPC;
-	retval = validate_change(cs, &trialcs);
-	if (retval == 0) {
-		down(&callback_sem);
-		cs->mems_allowed = trialcs.mems_allowed;
-		atomic_inc(&cpuset_mems_generation);
-		cs->mems_generation = atomic_read(&cpuset_mems_generation);
-		up(&callback_sem);
+	if (nodes_empty(trialcs.mems_allowed)) {
+		retval = -ENOSPC;
+		goto done;
 	}
+	retval = validate_change(cs, &trialcs);
+	if (retval < 0)
+		goto done;
+
+	down(&callback_sem);
+	cs->mems_allowed = trialcs.mems_allowed;
+	atomic_inc(&cpuset_mems_generation);
+	cs->mems_generation = atomic_read(&cpuset_mems_generation);
+	up(&callback_sem);
+
+done:
 	return retval;
 }
 

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
