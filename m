Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932211AbVKJWeU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932211AbVKJWeU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 17:34:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932212AbVKJWeU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 17:34:20 -0500
Received: from maggie.cs.pitt.edu ([130.49.220.148]:20126 "EHLO
	maggie.cs.pitt.edu") by vger.kernel.org with ESMTP id S932211AbVKJWeT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 17:34:19 -0500
From: Claudio Scordino <cloud.of.andor@gmail.com>
To: linux-kernel@vger.kernel.org, kernelnewbies@nl.linux.org
Subject: [PATCH] getrusage sucks
Date: Thu, 10 Nov 2005 23:34:09 +0100
User-Agent: KMail/1.8
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511102334.10926.cloud.of.andor@gmail.com>
X-Spam-Score: -1.665/8 BAYES_00 SA-version=3.000002
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Does exist any _real_ reason why getrusage can't be invoked by a task to know 
statistics of another task ?

The changes would be very trivial, as shown by the following patch.

              Claudio


diff --git a/kernel/sys.c b/kernel/sys.c
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -1746,9 +1746,13 @@ int getrusage(struct task_struct *p, int

 asmlinkage long sys_getrusage(int who, struct rusage __user *ru)
 {
-  if (who != RUSAGE_SELF && who != RUSAGE_CHILDREN)
-     return -EINVAL;
-  return getrusage(current, who, ru);
+  if (who != RUSAGE_SELF && who != RUSAGE_CHILDREN) {
+      struct task_struct* tsk = find_task_by_pid(who);
+      if (tsk == NULL)
+        return -EINVAL;
+     return getrusage(tsk, RUSAGE_SELF, ru);
+   } else
+     return getrusage(current, who, ru);
 }

 asmlinkage long sys_umask(int mask)
