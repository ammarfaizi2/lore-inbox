Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750835AbWA2GT3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750835AbWA2GT3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 01:19:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750837AbWA2GT3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 01:19:29 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:18398 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750835AbWA2GT3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 01:19:29 -0500
To: Andrew Morton <akpm@osdl.org>
CC: <linux-kernel@vger.kernel.org>
Subject: [PATCH] exec: Only allow a threaded init to exec from the
 thread_group_leader
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sat, 28 Jan 2006 23:18:57 -0700
Message-ID: <m14q3nh7zi.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The weird things we do when we exec from a thread group are just ugly.
Those ugly things do not handle the case of init and I suspect
extending that code to properly support a threaded init would be just
hideous, and impossible to maintain. 

So just in case someone ever threads init return an error for the
unimplemented case.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>


---

 fs/exec.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

408dad0f2b7067b23929866150e73b2b2f12d662
diff --git a/fs/exec.c b/fs/exec.c
index 055378d..c9d8e31 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -600,6 +600,12 @@ static int de_thread(struct task_struct 
 	if (thread_group_empty(current))
 		goto no_thread_group;
 
+	/* A threaded init must exec from it's primary thread.
+	 * As the init task (i.e. child_reaper) may not exit.
+	 */
+	if (!thread_group_leader(current) && (current->tgid == 1))
+		return -EINVAL;
+	
 	/*
 	 * Kill all other threads in the thread group.
 	 * We must hold tasklist_lock to call zap_other_threads.
-- 
1.1.5.g3480

