Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965140AbWGKEa7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965140AbWGKEa7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 00:30:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965144AbWGKEa7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 00:30:59 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:41921 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S965140AbWGKEa6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 00:30:58 -0400
Subject: [Patch 3/6] per task delay accounting taskstats interface: fix
	early sem init
From: Shailabh Nagar <nagar@watson.ibm.com>
Reply-To: nagar@watson.ibm.com
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Jay Lan <jlan@sgi.com>,
       Chris Sturtivant <csturtiv@sgi.com>, Paul Jackson <pj@sgi.com>,
       Balbir Singh <balbir@in.ibm.com>,
       Chandra Seetharaman <sekharan@us.ibm.com>
In-Reply-To: <1152591838.14142.114.camel@localhost.localdomain>
References: <1152591838.14142.114.camel@localhost.localdomain>
Content-Type: text/plain
Organization: IBM
Message-Id: <1152592255.14142.125.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 11 Jul 2006 00:30:55 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shift initialization of semaphores taken on exit() path
to earlier in the bootup sequence. Without this fix,
booting on large cpu machines hangs at down_read() called 
on one of the per-cpu semaphores declared in taskstats.

Signed-Off-By: Shailabh Nagar <nagar@watson.ibm.com>
 kernel/taskstats.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

Index: linux-2.6.18-rc1/kernel/taskstats.c
===================================================================
--- linux-2.6.18-rc1.orig/kernel/taskstats.c	2006-07-10 23:44:16.000000000 -0400
+++ linux-2.6.18-rc1/kernel/taskstats.c	2006-07-10 23:44:20.000000000 -0400
@@ -501,15 +501,20 @@ static struct genl_ops taskstats_ops = {
 /* Needed early in initialization */
 void __init taskstats_init_early(void)
 {
+	unsigned int i;
+
 	taskstats_cache = kmem_cache_create("taskstats_cache",
 						sizeof(struct taskstats),
 						0, SLAB_PANIC, NULL, NULL);
+	for_each_possible_cpu(i) {
+		INIT_LIST_HEAD(&(per_cpu(listener_array, i).list));
+		init_rwsem(&(per_cpu(listener_array, i).sem));
+	}
 }
 
 static int __init taskstats_init(void)
 {
 	int rc;
-	unsigned int i;
 
 	rc = genl_register_family(&family);
 	if (rc)
@@ -519,11 +524,6 @@ static int __init taskstats_init(void)
 	if (rc < 0)
 		goto err;
 
-	for_each_possible_cpu(i) {
-		INIT_LIST_HEAD(&(per_cpu(listener_array, i).list));
-		init_rwsem(&(per_cpu(listener_array, i).sem));
-	}
-
 	family_registered = 1;
 	return 0;
 err:


