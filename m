Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932253AbWAZDt3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932253AbWAZDt3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 22:49:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932249AbWAZDt2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 22:49:28 -0500
Received: from [202.53.187.9] ([202.53.187.9]:21227 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S932250AbWAZDt1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 22:49:27 -0500
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [ 13/23] [Suspend2] Add support for thawing just kernel threads or all threads.
Date: Thu, 26 Jan 2006 13:45:53 +1000
To: linux-kernel@vger.kernel.org
To: linux-kernel@vger.kernel.org
Message-Id: <20060126034552.3178.99871.stgit@localhost.localdomain>
In-Reply-To: <20060126034518.3178.55397.stgit@localhost.localdomain>
References: <20060126034518.3178.55397.stgit@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Modify the thaw_processes routine so that it takes and implements a
parameter saying whether to thaw all processes, or just kernel space.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/process.c |   25 +++++++++++++++++++------
 1 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/kernel/power/process.c b/kernel/power/process.c
index a3aca9a..dffe645 100644
--- a/kernel/power/process.c
+++ b/kernel/power/process.c
@@ -182,13 +182,26 @@ static int freeze_process(struct notifie
 	return 0;
 }
 
-void thaw_processes(void)
+void thaw_processes(int do_all_threads)
 {
-	freezer_message("Restarting tasks..");
-	complete_all(&thaw);
-	while (atomic_read(&nr_frozen) > 0)
-		schedule();
-	freezer_message("done\n");
+	if (do_all_threads) {
+		clear_freezer_state(FREEZER_ON);
+		clear_freezer_state(ABORT_FREEZING);
+	}
+
+	complete_all(&kernelspace_thaw);
+	while (atomic_read(&nr_kernelspace_frozen) > 0)
+		yield();
+
+	init_completion(&kernelspace_thaw);
+	freezer_make_fses_rw();
+
+	if (do_all_threads) {
+		complete_all(&userspace_thaw);
+		while (atomic_read(&nr_userspace_frozen) > 0)
+			yield();
+		init_completion(&userspace_thaw);
+	}
 }
 
 static inline void freeze(struct task_struct *p)

--
Nigel Cunningham		nigel at suspend2 dot net
