Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268494AbUHLJgg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268494AbUHLJgg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 05:36:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268500AbUHLJgg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 05:36:36 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:61395 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S268494AbUHLJgG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 05:36:06 -0400
Date: Thu, 12 Aug 2004 15:18:37 +0530
From: Dinakar Guniguntala <dino@in.ibm.com>
To: Paul Jackson <pj@sgi.com>
Cc: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] [PATCH] new bitmap list format (for cpusets)
Message-ID: <20040812094837.GA3946@in.ibm.com>
Reply-To: dino@in.ibm.com
References: <20040805100901.3740.99823.84118@sam.engr.sgi.com> <20040811131155.GA4239@in.ibm.com> <20040811091732.411edb6d.pj@sgi.com> <20040811180558.GA4066@in.ibm.com> <20040811134018.1551e03b.pj@sgi.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="1yeeQ81UyVL57Vl7"
Content-Disposition: inline
In-Reply-To: <20040811134018.1551e03b.pj@sgi.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 11, 2004 at 01:40:18PM -0700, Paul Jackson wrote:
> 
> Since I've gotten this far without having the definition of 'struct cpuset'
> exposed in a header file, I'd like to see if I can continue that.  I'll
> give this other approach a try - though it will be a day or so before I
> can get to it - prior commitments.  Unless of course, someone sends me such
> a patch first ;).

Ok revised patch attached

> However an equivalent detail would matter.  Can I mark cpuset_init_smp()
> as "__init" ?  Hmmm ... likely I can, since two routines called at the
> same time, sched_init_smp() and smp_init(), are marked __init.  This
> suggests that my interpretation of that comment was wrong, and that
> you're entirely right -- calls made in either place can be marked
> __init.  Is that comment above misleading?

That I believe applies only to the rest_init function which does not have
the __init qualifier

Regards,

Dinakar



--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="cpuset-init-2.patch"

diff -Naurp linux-2.6.8-rc2-mm2-cs3/include/linux/cpuset.h linux-2.6.8-rc2-mm2-cs3.new/include/linux/cpuset.h
--- linux-2.6.8-rc2-mm2-cs3/include/linux/cpuset.h	2004-08-05 17:22:31.000000000 +0530
+++ linux-2.6.8-rc2-mm2-cs3.new/include/linux/cpuset.h	2004-08-12 18:58:51.000000000 +0530
@@ -15,6 +15,7 @@
 #ifdef CONFIG_CPUSETS
 
 extern int cpuset_init(void);
+extern void cpuset_init_smp(void);
 extern void cpuset_fork(struct task_struct *p);
 extern void cpuset_exit(struct task_struct *p);
 extern const cpumask_t cpuset_cpus_allowed(const struct task_struct *p);
diff -Naurp linux-2.6.8-rc2-mm2-cs3/init/main.c linux-2.6.8-rc2-mm2-cs3.new/init/main.c
--- linux-2.6.8-rc2-mm2-cs3/init/main.c	2004-08-05 17:22:31.000000000 +0530
+++ linux-2.6.8-rc2-mm2-cs3.new/init/main.c	2004-08-12 18:06:54.000000000 +0530
@@ -708,6 +708,8 @@ static int init(void * unused)
 	smp_init();
 	sched_init_smp();
 
+	cpuset_init_smp();
+
 	/*
 	 * Do this before initcalls, because some drivers want to access
 	 * firmware files.
diff -Naurp linux-2.6.8-rc2-mm2-cs3/kernel/cpuset.c linux-2.6.8-rc2-mm2-cs3.new/kernel/cpuset.c
--- linux-2.6.8-rc2-mm2-cs3/kernel/cpuset.c	2004-08-11 22:02:47.000000000 +0530
+++ linux-2.6.8-rc2-mm2-cs3.new/kernel/cpuset.c	2004-08-12 18:55:34.000000000 +0530
@@ -1270,7 +1270,6 @@ int __init cpuset_init(void)
 	struct dentry *root;
 	int err;
 
-	top_cpuset.cpus_allowed = cpu_possible_map;
 	top_cpuset.mems_allowed = node_possible_map;
 
 	init_task.cpuset = &top_cpuset;
@@ -1296,6 +1295,17 @@ out:
 }
 
 /**
+ * cpuset_init_smp - initialize cpus_allowed
+ *
+ * Description: Initialize cpus_allowed after cpu_possible_map is initialized 
+ **/
+
+void __init cpuset_init_smp(void)
+{
+	top_cpuset.cpus_allowed = cpu_possible_map;
+}
+
+/**
  * cpuset_fork - attach newly forked task to its parents cpuset.
  * @p: pointer to task_struct of forking parent process.
  *

--1yeeQ81UyVL57Vl7--
