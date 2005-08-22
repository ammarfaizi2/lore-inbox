Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751125AbVHVUit@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751125AbVHVUit (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 16:38:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751127AbVHVUit
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 16:38:49 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:1203 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751125AbVHVUim (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 16:38:42 -0400
Date: Mon, 22 Aug 2005 13:38:23 -0700
From: Paul Jackson <pj@sgi.com>
To: hawkes@jackhammer.engr.sgi.com (John Hawkes)
Cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@elte.hu,
       dino@in.ibm.com, nickpiggin@yahoo.com.au, akpm@osdl.org
Subject: Re: [PATCH] ia64 cpuset + build_sched_domains() mangles structures
Message-Id: <20050822133823.6b206d87.pj@sgi.com>
In-Reply-To: <43074328.MailOXV1UXUHF@jackhammer.engr.sgi.com>
References: <43074328.MailOXV1UXUHF@jackhammer.engr.sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[P.S. - I just noticed that Dinakar is reporting another problem,
        something about a panic on stress testing.  Dinakar - should
	we adapt what I call choice (2) below, to disable this feature
	in 2.6.13, instead of the choice (3) I recommend below? -pj ]

In separate email, Nick suggested disabling some of this mechanism in
2.6.13, in order to provide more soak time for Hawkes dynamic sched
domain fix for partial nodes in 2.6.14.

Nick's hope was to find some quick and easy (and safe) way to avoid the
oops that Hawkes found for 2.6.13 (which is almost out the door).

There are three easy ways I see offhand one might do to avoid this
oops in 2.6.13

 1) disable 'cpu_exclusive' cpusets
 2) disable Dinakar's patch entirely.
 3) disable Dinakar's patch just for partial node cpusets.
 
The 'cpu_exclusive' cpusets are already in the kernel, as of 2.6.12,
though until Dinakar's patch is added, they are of limited usefulness.
I'd mildly prefer not to disable them in 2.6.13 (choice (1) above),
unless we can't find a better way.  A few poor folks off in some corner
of cpuset land would probably notice that something that worked in
2.6.12 was disconnected in 2.6.13.

What Dinakar's patch, added for 2.6.13, does is (roughly):

  If the cpuset code notices that it is setting up a cpuset
  marked 'cpu_exclusive', then the cpuset code calls the
  dynamic sched domain code to define a sched domain along
  the boundaries of that cpuset.

The safest, mind numbingly simple thing to do that would avoid
the oops that Hawkes reported is to simply not have the cpuset
code call the code to setup a dynamic sched domain.  This is
choice (2) above, and could be done at the last hour with
relative safety.

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

For a half-dozen easy lines of code, if we have a few hours and
a chance for Dinakar and Hawkes to concur, the best solution is
choice (3) above.  The cpuset code that calls out to the code
to setup a dynamic sched domain already avoides that call out for
a variety of conditions (such as an empty cpuset or the top
cpuset).  It can just as easily avoid the call out for one more
reason, that being that the cpuset in question is not on node
boundaries (for some node, uses a proper non-empty subset of the
cpus on that node).

Here is an untested patch that does this:

=====

Index: linux-2.6.13-cpuset-mempolicy-migrate/kernel/cpuset.c
===================================================================
--- linux-2.6.13-cpuset-mempolicy-migrate.orig/kernel/cpuset.c
+++ linux-2.6.13-cpuset-mempolicy-migrate/kernel/cpuset.c
@@ -636,6 +636,23 @@ static void update_cpu_domains(struct cp
 		return;
 
 	/*
+	 * Hack to avoid 2.6.13 partial node dynamic sched domain bug.
+	 * Require the 'cpu_exclusive' cpuset to include all (or none)
+	 * of the CPUs on each node, or return w/o changing sched domains.
+	 * Remove this hack when dynamic sched domains fixed.
+	 */
+	{
+		int i, j;
+
+		for_each_cpu_mask(i, cur->cpus_allowed) {
+			for_each_cpu_mask(j, node_to_cpumask(cpu_to_node(i))) {
+				if (!cpu_isset(j, cur->cpus_allowed))
+					return;
+			}
+		}
+	}
+
+	/*
 	 * Get all cpus from parent's cpus_allowed not part of exclusive
 	 * children
 	 */

=====

I recommend this last patch above - choice (3).  It provides what
Dinakar intended to allow user control of sched domains, while
avoiding the corner case that Hawkes reported, where a sched
domain not on a node boundary could oops the kernel.

I will prepare a real patch that does (3), and send it out later
today.


-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
