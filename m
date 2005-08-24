Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932079AbVHXUbU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932079AbVHXUbU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 16:31:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932124AbVHXUbU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 16:31:20 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:37030 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932079AbVHXUbT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 16:31:19 -0400
Date: Wed, 24 Aug 2005 13:31:07 -0700
From: Paul Jackson <pj@sgi.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: dino@in.ibm.com, paulus@samba.org, akpm@osdl.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, mingo@elte.hu, hawkes@sgi.com
Subject: Re: [PATCH 2.6.13-rc6] cpu_exclusive sched domains build fix
Message-Id: <20050824133107.2ca733c3.pj@sgi.com>
In-Reply-To: <430C617E.8080002@yahoo.com.au>
References: <20050824111510.11478.49764.sendpatchset@jackhammer.engr.sgi.com>
	<20050824112640.GB5197@in.ibm.com>
	<20050824044648.66f7e25a.pj@sgi.com>
	<430C617E.8080002@yahoo.com.au>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick wrote:
> I get the feeling that exclusive cpusets should just be
> completely disabled for 2.6.13

No no - not disable exclusive cpusets - disable using them to try
to define sched domains.

That is, I hope you mean that Dinakar's patch that uses cpu_exclusive
cpusets to define sched domains should be disabled for 2.6.13.  For
what they were worth (not a whole lot, granted), cpu_exclusive cpusets
have been in the kernel since 2.6.12.  They just didn't have any affect
in the placement of sched domains.  So long as they continue to do not
a whole lot, I see more risk than gain in disabling them for 2.6.13.

So long as the cpuset code stops making any calls to partition_sched_domains()
whatsoever, then we should be back where we were in 2.6.12, so far as the
scheduler is concerned - right?

I hope that the following (untested, unbuilt) patch, that I suggested
in my "Mon, 22 Aug 2005 13:38:23 -0700" message best meets you
suggestion above ... and I quote:

==========

The safest, mind numbingly simple thing to do that would avoid the oops
that Hawkes reported is to simply not have the cpuset code call the
code to setup a dynamic sched domain.  This is choice (2) above, and
could be done at the last hour with relative safety.

Here is an untested patch that does (2):

=====

Index: linux-2.6.13-cpuset-mempolicy-migrate/kernel/cpuset.c
===================================================================
--- linux-2.6.13-cpuset-mempolicy-migrate.orig/kernel/cpuset.c
+++ linux-2.6.13-cpuset-mempolicy-migrate/kernel/cpuset.c
@@ -627,6 +627,15 @@ static int validate_change(const struct 
  * Call with cpuset_sem held.  May nest a call to the
  * lock_cpu_hotplug()/unlock_cpu_hotplug() pair.
  */
+
+/*
+ * Hack to avoid 2.6.13 partial node dynamic sched domain bug.
+ * Disable letting 'cpu_exclusive' cpusets define dynamic sched
+ * domains, until the sched domain can handle partial nodes.
+ * Remove this ifdef hackery when sched domains fixed.
+ */
+#define DISABLE_EXCLUSIVE_CPU_DOMAINS 1
+#ifdef DISABLE_EXCLUSIVE_CPU_DOMAINS
 static void update_cpu_domains(struct cpuset *cur)
 {
 	struct cpuset *c, *par = cur->parent;
@@ -667,6 +676,11 @@ static void update_cpu_domains(struct cp
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


=====


-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
