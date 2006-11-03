Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753502AbWKCTqk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753502AbWKCTqk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 14:46:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753504AbWKCTqk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 14:46:40 -0500
Received: from mgw-ext12.nokia.com ([131.228.20.171]:40402 "EHLO
	mgw-ext12.nokia.com") by vger.kernel.org with ESMTP
	id S1753502AbWKCTqj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 14:46:39 -0500
Date: Fri, 3 Nov 2006 21:46:11 +0200
From: Guillem Jover <guillem.jover@nokia.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Allowing user processes to rise their oom_adj value
Message-ID: <20061103194611.GA22891@ziggurat.research.nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
X-OriginalArrivalTime: 03 Nov 2006 19:46:37.0810 (UTC) FILETIME=[C6846520:01C6FF80]
X-Nokia-AV: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently a user process cannot rise its own oom_adj value (i.e.
unprotecting itself from the OOM killer). As this value is stored
in the task structure it gets inherited and the unprivileged childs
will be unable to rise it.

The EPERM will be handled by the generic proc fs layer, as only
processes with the proper caps or the owner of the process will be
able to write to the file. So we allow only the processes with
CAP_SYS_RESOURCE to lower the value, otherwise it will get an EACCES
which seems more appropriate than EPERM.

Signed-off-by: Guillem Jover <guillem.jover@nokia.com>
---
 fs/proc/base.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 8df2740..955bb0a 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -682,8 +682,6 @@ static ssize_t oom_adjust_write(struct f
 	char buffer[PROC_NUMBUF], *end;
 	int oom_adjust;
 
-	if (!capable(CAP_SYS_RESOURCE))
-		return -EPERM;
 	memset(buffer, 0, sizeof(buffer));
 	if (count > sizeof(buffer) - 1)
 		count = sizeof(buffer) - 1;
@@ -698,6 +696,10 @@ static ssize_t oom_adjust_write(struct f
 	task = get_proc_task(file->f_dentry->d_inode);
 	if (!task)
 		return -ESRCH;
+	if (oom_adjust < task->oomkilladj && !capable(CAP_SYS_RESOURCE)) {
+		put_task_struct(task);
+		return -EACCES;
+	}
 	task->oomkilladj = oom_adjust;
 	put_task_struct(task);
 	if (end - buffer == 0)
-- 
1.4.3.3

