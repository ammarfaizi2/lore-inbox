Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751399AbVHYTsA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751399AbVHYTsA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 15:48:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751413AbVHYTsA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 15:48:00 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:19689 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1751399AbVHYTr6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 15:47:58 -0400
Date: Thu, 25 Aug 2005 12:47:56 -0700 (PDT)
From: Paul Jackson <pj@sgi.com>
To: torvalds@osdl.org, Andrew Morton <akpm@osdl.org>
Cc: nickpiggin@yahoo.com.au, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, paulus@samba.org, mingo@elte.hu,
       hawkes@sgi.com, Paul Jackson <pj@sgi.com>, dino@in.ibm.com
Message-Id: <20050825194756.7341.83327.sendpatchset@jackhammer.engr.sgi.com>
In-Reply-To: <20050825194750.7341.75723.sendpatchset@jackhammer.engr.sgi.com>
References: <20050825194750.7341.75723.sendpatchset@jackhammer.engr.sgi.com>
Subject: [PATCH 2.6.13-rc7 2/2] completely disable cpu_exclusive sched domain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At the suggestion of Nick Piggin and Dinakar, totally disable
the facility to allow cpu_exclusive cpusets to define dynamic
sched domains in Linux 2.6.13, in order to avoid problems
first reported by John Hawkes (corrupt sched data structures
and kernel oops).

This has been built for ppc64, i386, ia64, x86_64, sparc, alpha.
It has been built, booted and tested for cpuset functionality
on an SN2 (ia64).

Dinakar or Nick - could you verify that it for sure does avoid
the problems Hawkes reported.  Hawkes is out of town, and I don't
have the recipe to reproduce what he found.

Signed-off-by: Paul Jackson <pj@sgi.com>                                                  

Index: linux-2.6.13-rc7/kernel/cpuset.c
===================================================================
--- linux-2.6.13-rc7.orig/kernel/cpuset.c
+++ linux-2.6.13-rc7/kernel/cpuset.c
@@ -627,6 +627,14 @@ static int validate_change(const struct 
  * Call with cpuset_sem held.  May nest a call to the
  * lock_cpu_hotplug()/unlock_cpu_hotplug() pair.
  */
+
+/*
+ * Hack to avoid 2.6.13 partial node dynamic sched domain bug.
+ * Disable letting 'cpu_exclusive' cpusets define dynamic sched
+ * domains, until the sched domain can handle partial nodes.
+ * Remove this #if hackery when sched domains fixed.
+ */
+#if 0
 static void update_cpu_domains(struct cpuset *cur)
 {
 	struct cpuset *c, *par = cur->parent;
@@ -667,6 +675,11 @@ static void update_cpu_domains(struct cp
 	partition_sched_domains(&pspan, &cspan);
 	unlock_cpu_hotplug();
 }
+#else
+static void update_cpu_domains(struct cpuset *cur)
+{
+}
+#endif
 
 static int update_cpumask(struct cpuset *cs, char *buf)
 {

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
