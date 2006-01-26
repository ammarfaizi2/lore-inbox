Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932262AbWAZDuN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932262AbWAZDuN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 22:50:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932236AbWAZDts
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 22:49:48 -0500
Received: from [202.53.187.9] ([202.53.187.9]:25835 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S932260AbWAZDto (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 22:49:44 -0500
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [ 22/23] [Suspend2] Modify swsusp to thaw kernel threads while eating memory.
Date: Thu, 26 Jan 2006 13:46:11 +1000
To: linux-kernel@vger.kernel.org
To: linux-kernel@vger.kernel.org
Message-Id: <20060126034610.3178.98553.stgit@localhost.localdomain>
In-Reply-To: <20060126034518.3178.55397.stgit@localhost.localdomain>
References: <20060126034518.3178.55397.stgit@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Modify swsusp so that while trying to eat memory, it allows kernel threads
to run. This avoids a deadlock that could otherwise occur if access to a
filesystem is needed while freeing the memory.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/main.c   |    4 ++++
 kernel/power/swsusp.c |    3 +++
 2 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/kernel/power/main.c b/kernel/power/main.c
index 6f854e4..2fed3dc 100644
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -72,6 +72,8 @@ static int suspend_prepare(suspend_state
 		goto Thaw;
 	}
 
+	thaw_processes(FREEZER_KERNEL_THREADS);
+
 	if ((free_pages = nr_free_pages()) < FREE_PAGE_NUMBER) {
 		pr_debug("PM: free some memory\n");
 		shrink_all_memory(FREE_PAGE_NUMBER - free_pages);
@@ -82,6 +84,8 @@ static int suspend_prepare(suspend_state
 		}
 	}
 
+	freeze_processes();
+
 	if (pm_ops->prepare) {
 		if ((error = pm_ops->prepare(state)))
 			goto Thaw;
diff --git a/kernel/power/swsusp.c b/kernel/power/swsusp.c
index 55a18d2..3bc835a 100644
--- a/kernel/power/swsusp.c
+++ b/kernel/power/swsusp.c
@@ -575,6 +575,8 @@ int swsusp_shrink_memory(void)
 	unsigned int i = 0;
 	char *p = "-\\|/";
 
+	thaw_processes(FREEZER_KERNEL_THREADS);
+
 	printk("Shrinking memory...  ");
 	do {
 		size = 2 * count_highmem_pages();
@@ -598,6 +600,7 @@ int swsusp_shrink_memory(void)
 	} while (tmp > 0);
 	printk("\bdone (%lu pages freed)\n", pages);
 
+	freeze_processes();
 	return 0;
 }
 

--
Nigel Cunningham		nigel at suspend2 dot net
