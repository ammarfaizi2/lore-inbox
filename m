Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261611AbTICIEz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 04:04:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261619AbTICIEz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 04:04:55 -0400
Received: from dp.samba.org ([66.70.73.150]:37025 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261611AbTICIEo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 04:04:44 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: neilb@cse.unsw.edu.au
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: [PATCH] MODULE_ALIAS for md
Date: Wed, 03 Sep 2003 18:04:05 +1000
Message-Id: <20030903080444.559AA2C013@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rather than hardcoded names in modprobe, modules can offer their own
aliases (which are overridden by config files).

Here are the drivers/md ones.  Also uses try_then_request_module() to
clean up some request_module code.

Name: Module Aliases Inside Modules: md
Author: Rusty Russell
Status: Trivial

D: MODULE_ALIAS() macros for md.  Also uses try_then_request_module in 
D: dm_get_target_type().

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .12741-linux-2.6.0-test4-bk4/drivers/md/dm-target.c .12741-linux-2.6.0-test4-bk4.updated/drivers/md/dm-target.c
--- .12741-linux-2.6.0-test4-bk4/drivers/md/dm-target.c	2003-06-15 11:29:53.000000000 +1000
+++ .12741-linux-2.6.0-test4-bk4.updated/drivers/md/dm-target.c	2003-09-03 15:58:19.000000000 +1000
@@ -56,20 +56,11 @@ static struct tt_internal *get_target_ty
 	return ti;
 }
 
-static void load_module(const char *name)
-{
-	request_module("dm-%s", name);
-}
-
 struct target_type *dm_get_target_type(const char *name)
 {
-	struct tt_internal *ti = get_target_type(name);
-
-	if (!ti) {
-		load_module(name);
-		ti = get_target_type(name);
-	}
+	struct tt_internal *ti;
 
+	ti = try_then_request_module(get_target_type(name), "dm-%s", name);
 	return ti ? &ti->tt : NULL;
 }
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .12741-linux-2.6.0-test4-bk4/drivers/md/linear.c .12741-linux-2.6.0-test4-bk4.updated/drivers/md/linear.c
--- .12741-linux-2.6.0-test4-bk4/drivers/md/linear.c	2003-08-25 11:58:18.000000000 +1000
+++ .12741-linux-2.6.0-test4-bk4.updated/drivers/md/linear.c	2003-09-03 15:55:16.000000000 +1000
@@ -296,3 +296,4 @@ static void linear_exit (void)
 module_init(linear_init);
 module_exit(linear_exit);
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("md-personality-1"); /* LINEAR */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .12741-linux-2.6.0-test4-bk4/drivers/md/multipath.c .12741-linux-2.6.0-test4-bk4.updated/drivers/md/multipath.c
--- .12741-linux-2.6.0-test4-bk4/drivers/md/multipath.c	2003-08-25 11:58:18.000000000 +1000
+++ .12741-linux-2.6.0-test4-bk4.updated/drivers/md/multipath.c	2003-09-03 15:55:16.000000000 +1000
@@ -509,3 +509,4 @@ static void __exit multipath_exit (void)
 module_init(multipath_init);
 module_exit(multipath_exit);
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("md-personality-7"); /* MULTIPATH */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .12741-linux-2.6.0-test4-bk4/drivers/md/raid0.c .12741-linux-2.6.0-test4-bk4.updated/drivers/md/raid0.c
--- .12741-linux-2.6.0-test4-bk4/drivers/md/raid0.c	2003-09-03 09:55:15.000000000 +1000
+++ .12741-linux-2.6.0-test4-bk4.updated/drivers/md/raid0.c	2003-09-03 15:55:16.000000000 +1000
@@ -461,3 +461,4 @@ static void raid0_exit (void)
 module_init(raid0_init);
 module_exit(raid0_exit);
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("md-personality-2"); /* RAID0 */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .12741-linux-2.6.0-test4-bk4/drivers/md/raid1.c .12741-linux-2.6.0-test4-bk4.updated/drivers/md/raid1.c
--- .12741-linux-2.6.0-test4-bk4/drivers/md/raid1.c	2003-08-25 11:58:18.000000000 +1000
+++ .12741-linux-2.6.0-test4-bk4.updated/drivers/md/raid1.c	2003-09-03 15:55:16.000000000 +1000
@@ -1197,3 +1197,4 @@ static void raid_exit(void)
 module_init(raid_init);
 module_exit(raid_exit);
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("md-personality-3"); /* RAID1 */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .12741-linux-2.6.0-test4-bk4/drivers/md/raid5.c .12741-linux-2.6.0-test4-bk4.updated/drivers/md/raid5.c
--- .12741-linux-2.6.0-test4-bk4/drivers/md/raid5.c	2003-09-03 09:55:15.000000000 +1000
+++ .12741-linux-2.6.0-test4-bk4.updated/drivers/md/raid5.c	2003-09-03 15:55:16.000000000 +1000
@@ -1780,3 +1780,4 @@ static void raid5_exit (void)
 module_init(raid5_init);
 module_exit(raid5_exit);
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("md-personality-4"); /* RAID5 */


--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
