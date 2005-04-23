Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261515AbVDWHJp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261515AbVDWHJp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Apr 2005 03:09:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261507AbVDWHJp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Apr 2005 03:09:45 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:10637 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261515AbVDWHJX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Apr 2005 03:09:23 -0400
Date: Sat, 23 Apr 2005 12:54:24 +0530
From: Dinakar Guniguntala <dino@in.ibm.com>
To: Paul Jackson <pj@sgi.com>
Cc: Simon.Derr@bull.net, nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net, akpm@osdl.org, dipankar@in.ibm.com,
       colpatch@us.ibm.com
Subject: Re: [Lse-tech] Re: [RFC PATCH] Dynamic sched domains aka Isolated cpusets
Message-ID: <20050423072424.GA3929@in.ibm.com>
Reply-To: dino@in.ibm.com
References: <1097110266.4907.187.camel@arrakis> <20050418202644.GA5772@in.ibm.com> <20050418225427.429accd5.pj@sgi.com> <20050419093438.GB3963@in.ibm.com> <20050419102348.118005c1.pj@sgi.com> <20050420071606.GA3931@in.ibm.com> <20050420120946.145a5973.pj@sgi.com> <20050421162738.GA4200@in.ibm.com> <20050422142618.08d74ede.pj@sgi.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ew6BAiZeqk4r7MaW"
Content-Disposition: inline
In-Reply-To: <20050422142618.08d74ede.pj@sgi.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 22, 2005 at 02:26:18PM -0700, Paul Jackson wrote:

>  3) Extend the exclusive capability to include isolation from parents,
>     along the lines of your patch.

This was precisely the design that I first came up not so long ago, but 
never posted. The reason being that I thought all parties involved had
already agreed to this design because of some reason (unknown to me)
that was already discussed in detail during the last flurry of emails.

Now that you have asked this question and actually said that this would
probably be a better design, I wholeheartedly agree and whats more
I already have most of the code required. Infact here it is

I think I'll redo the patch and post it for review shortly

	-Dinakar

(Warning, this has all the warts that have previosuly been pointed
out and more)



--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="sd-cpuset-v1-mail.patch"

diff -Naurp linux-2.6.12-rc1-mm1.orig/kernel/cpuset.c linux-2.6.12-rc1-mm1/kernel/cpuset.c
--- linux-2.6.12-rc1-mm1.orig/kernel/cpuset.c	2005-04-13 14:42:36.000000000 +0530
+++ linux-2.6.12-rc1-mm1/kernel/cpuset.c	2005-04-13 21:18:26.876673392 +0530
@@ -58,6 +58,7 @@
 struct cpuset {
 	unsigned long flags;		/* "unsigned long" so bitops work */
 	cpumask_t cpus_allowed;		/* CPUs allowed to tasks in cpuset */
+	cpumask_t domain_span;		/* CPUs associated with a sched domain */
 	nodemask_t mems_allowed;	/* Memory Nodes allowed to tasks */
 
 	atomic_t count;			/* count tasks using this cpuset */
@@ -129,6 +130,7 @@ static atomic_t cpuset_mems_generation =
 static struct cpuset top_cpuset = {
 	.flags = ((1 << CS_CPU_EXCLUSIVE) | (1 << CS_MEM_EXCLUSIVE)),
 	.cpus_allowed = CPU_MASK_ALL,
+	.domain_span = CPU_MASK_ALL,
 	.mems_allowed = NODE_MASK_ALL,
 	.count = ATOMIC_INIT(0),
 	.sibling = LIST_HEAD_INIT(top_cpuset.sibling),
@@ -602,6 +604,60 @@ static int validate_change(const struct 
 	return 0;
 }
 
+static void rebuild_domains(cpumask_t change_map, struct cpuset *cs)
+{
+	struct cpuset *parent = cs->parent;
+
+	lock_cpu_hotplug();
+	detach_domains(change_map);
+	if (!cpus_empty(parent->domain_span))
+		build_sched_domains(parent->domain_span);
+	if (cpus_equal(cs->domain_span, cs->cpus_allowed))
+		build_sched_domains(cs->domain_span);
+	attach_domains(change_map);
+	unlock_cpu_hotplug();
+}
+
+static void update_sched_domain(struct cpuset *cs)
+{
+	struct cpuset *parent = cs->parent;
+	cpumask_t temp_map, change_map;
+	cpumask_t p_old_span = parent->domain_span, c_old_span = cs->domain_span;
+
+	if (is_removed(cs) || !is_cpu_exclusive(cs)) {
+		/* Exclusive bit off and no CPUs defined in cpuset (7) */
+		if (cpus_empty(cs->cpus_allowed))
+			return;
+		/* Exclusive bit off or delete an exclusive cpuset (5,6) */
+		cpus_or(parent->domain_span, parent->domain_span, cs->cpus_allowed);
+		change_map = parent->domain_span;
+		cs->domain_span = CPU_MASK_NONE;
+	}
+	else if (is_cpu_exclusive(cs)) {
+		if (cpus_subset(cs->cpus_allowed, cs->domain_span)) {
+			/* Remove some CPUs from an exclusive cpuset (4) */
+			cpus_andnot(temp_map, cs->domain_span, cs->cpus_allowed);
+			cpus_or(parent->domain_span, parent->domain_span, temp_map);
+			cpus_or(change_map, parent->domain_span, cs->domain_span);
+		}
+		else {
+			/* No CPUs defined in this cpuset as yet (2) */
+			if (cpus_empty(cs->cpus_allowed))
+				return;
+			/* Turn exclusive on or add CPUs to an exclusive cpuset (1,3) */
+			change_map = parent->domain_span;
+			cpus_andnot(temp_map, parent->cpus_allowed, cs->cpus_allowed);
+			cpus_and(parent->domain_span, parent->domain_span, temp_map);
+		}
+		cs->domain_span = cs->cpus_allowed;
+	}
+
+	if ((!cpus_equal(p_old_span, parent->domain_span)) 
+	    && (!cpus_equal(c_old_span, cs->domain_span))
+	    && (!cpus_equal(p_old_span, cs->domain_span)))
+		rebuild_domains(change_map, cs);
+}
+
 static int update_cpumask(struct cpuset *cs, char *buf)
 {
 	struct cpuset trialcs;
@@ -615,8 +671,11 @@ static int update_cpumask(struct cpuset 
 	if (cpus_empty(trialcs.cpus_allowed))
 		return -ENOSPC;
 	retval = validate_change(cs, &trialcs);
-	if (retval == 0)
+	if (retval == 0) {
 		cs->cpus_allowed = trialcs.cpus_allowed;
+		if (is_cpu_exclusive(cs))
+			update_sched_domain(cs);
+	}
 	return retval;
 }
 
@@ -779,6 +838,8 @@ static ssize_t cpuset_common_file_write(
 		break;
 	case FILE_CPU_EXCLUSIVE:
 		retval = update_flag(CS_CPU_EXCLUSIVE, cs, buffer);
+		if (!retval)
+			update_sched_domain(cs);
 		break;
 	case FILE_MEM_EXCLUSIVE:
 		retval = update_flag(CS_MEM_EXCLUSIVE, cs, buffer);
@@ -1258,6 +1319,7 @@ static long cpuset_create(struct cpuset 
 	if (notify_on_release(parent))
 		set_bit(CS_NOTIFY_ON_RELEASE, &cs->flags);
 	cs->cpus_allowed = CPU_MASK_NONE;
+	cs->domain_span  = CPU_MASK_NONE;
 	cs->mems_allowed = NODE_MASK_NONE;
 	atomic_set(&cs->count, 0);
 	INIT_LIST_HEAD(&cs->sibling);
@@ -1319,6 +1381,8 @@ static int cpuset_rmdir(struct inode *un
 	spin_lock(&cs->dentry->d_lock);
 	parent = cs->parent;
 	set_bit(CS_REMOVED, &cs->flags);
+	if (is_cpu_exclusive(cs))
+		update_sched_domain(cs);
 	list_del(&cs->sibling);	/* delete my sibling from parent->children */
 	if (list_empty(&parent->children))
 		check_for_release(parent);
@@ -1343,6 +1407,7 @@ int __init cpuset_init(void)
 	int err;
 
 	top_cpuset.cpus_allowed = CPU_MASK_ALL;
+	top_cpuset.domain_span  = CPU_MASK_ALL;
 	top_cpuset.mems_allowed = NODE_MASK_ALL;
 
 	atomic_inc(&cpuset_mems_generation);
@@ -1378,7 +1443,9 @@ out:
 
 void __init cpuset_init_smp(void)
 {
-	top_cpuset.cpus_allowed = cpu_online_map;
+	cpus_complement(top_cpuset.cpus_allowed, cpu_isolated_map);
+	cpus_and(top_cpuset.cpus_allowed, top_cpuset.cpus_allowed, cpu_online_map);
+	top_cpuset.domain_span  = top_cpuset.cpus_allowed;
 	top_cpuset.mems_allowed = node_online_map;
 }

--ew6BAiZeqk4r7MaW--
