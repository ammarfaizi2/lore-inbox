Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319037AbSIDDob>; Tue, 3 Sep 2002 23:44:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319038AbSIDDob>; Tue, 3 Sep 2002 23:44:31 -0400
Received: from dp.samba.org ([66.70.73.150]:58582 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S319037AbSIDDoa>;
	Tue, 3 Sep 2002 23:44:30 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 1/2 daemonize() calls reparent_to_init() cleanup
Date: Wed, 04 Sep 2002 13:48:42 +1000
Message-Id: <20020904034904.57D582C057@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Initialize child_reaper at idle thread entry: eg. ksoftirqd's PPID is
0, because it calls reparent_to_init() before child_reaper is
initialized.

Name: Early child_reaper initialization
Author: Rusty Russell
Status: Trivial

D: This sets child_reaper to the idle thread upon creation, so that
D: ksoftirqd's reparent_to_init call doesn't get the swapper as parent.

--- working-2.5.33-hotcpu-cpudown-i386/init/main.c.~1~	Tue Sep  3 14:05:43 2002
+++ working-2.5.33-hotcpu-cpudown-i386/init/main.c	Wed Sep  4 13:33:32 2002
@@ -490,16 +493,6 @@
  */
 static void __init do_basic_setup(void)
 {
-	/*
-	 * Tell the world that we're going to be the grim
-	 * reaper of innocent orphaned children.
-	 *
-	 * We don't want people to have to make incorrect
-	 * assumptions about where in the task array this
-	 * can be found.
-	 */
-	child_reaper = current;
-
 #if defined(CONFIG_MTRR)	/* Do this after SMP initialization */
 /*
  * We should probably create some architecture-dependent "fixup after
@@ -545,6 +538,16 @@
 	static char * argv_sh[] = { "sh", NULL, };
 
 	lock_kernel();
+	/*
+	 * Tell the world that we're going to be the grim
+	 * reaper of innocent orphaned children.
+	 *
+	 * We don't want people to have to make incorrect
+	 * assumptions about where in the task array this
+	 * can be found.
+	 */
+	child_reaper = current;
+
 	/* Sets up cpus_possible() */
 	smp_prepare_cpus(max_cpus);
 

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
