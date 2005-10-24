Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750843AbVJXATU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750843AbVJXATU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Oct 2005 20:19:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750845AbVJXATU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Oct 2005 20:19:20 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:63658 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750843AbVJXATT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Oct 2005 20:19:19 -0400
Date: Sun, 23 Oct 2005 17:19:13 -0700 (PDT)
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Simon.Derr@bull.net, Paul Jackson <pj@sgi.com>,
       linux-kernel@vger.kernel.org, Christoph Lameter <clameter@sgi.com>,
       Linus Torvalds <torvalds@osdl.org>
Message-Id: <20051024001913.7030.71597.sendpatchset@jackhammer.engr.sgi.com>
Subject: [PATCH] cpuset confine pdflush to its cpuset
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch keeps pdflush daemons on the same cpuset as their
parent, the kthread daemon.

Some large NUMA configurations put as much as they can of
kernel threads and other classic Unix load in what's called a
bootcpuset, keeping the rest of the system free for dedicated
jobs.

This effort is thwarted by pdflush, which dynamically destroys
and recreates pdflush daemons depending on load.

It's easy enough to force the originally created pdflush deamons
into the bootcpuset, at system boottime.  But the pdflush
threads created later were allowed to run freely across the
system, due to the necessary line in their startup kthread():

        set_cpus_allowed(current, CPU_MASK_ALL);

By simply coding pdflush to start its threads with the
cpus_allowed restrictions of its cpuset (inherited from kthread,
its parent) we can ensure that dynamically created pdflush
threads are also kept in the bootcpuset.

On systems w/o cpusets, or w/o a bootcpuset implementation,
the following will have no affect, leaving pdflush to run on
any CPU, as before.

Signed-off-by: Paul Jackson <pj@sgi.com>

---

 mm/pdflush.c |   13 +++++++++++++
 1 files changed, 13 insertions(+)

--- 2.6.14-rc4-mm1-cpuset-patches.orig/mm/pdflush.c	2005-10-17 22:39:41.033879927 -0700
+++ 2.6.14-rc4-mm1-cpuset-patches/mm/pdflush.c	2005-10-23 17:17:03.720802617 -0700
@@ -20,6 +20,7 @@
 #include <linux/fs.h>		// Needed by writeback.h
 #include <linux/writeback.h>	// Prototypes pdflush_operation()
 #include <linux/kthread.h>
+#include <linux/cpuset.h>
 
 
 /*
@@ -170,12 +171,24 @@ static int __pdflush(struct pdflush_work
 static int pdflush(void *dummy)
 {
 	struct pdflush_work my_work;
+	cpumask_t cpus_allowed;
 
 	/*
 	 * pdflush can spend a lot of time doing encryption via dm-crypt.  We
 	 * don't want to do that at keventd's priority.
 	 */
 	set_user_nice(current, 0);
+
+	/*
+	 * Some configs put our parent kthread in a limited cpuset,
+	 * which kthread() overrides, forcing cpus_allowed == CPU_MASK_ALL.
+	 * Our needs are more modest - cut back to our cpusets cpus_allowed.
+	 * This is needed as pdflush's are dynamically created and destroyed.
+	 * The boottime pdflush's are easily placed w/o these 2 lines.
+	 */
+	cpus_allowed = cpuset_cpus_allowed(current);
+	set_cpus_allowed(current, cpus_allowed);
+
 	return __pdflush(&my_work);
 }
 

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
