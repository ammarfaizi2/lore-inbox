Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262107AbVDVSxz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262107AbVDVSxz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Apr 2005 14:53:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262108AbVDVSxz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Apr 2005 14:53:55 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:26243 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262107AbVDVSxv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Apr 2005 14:53:51 -0400
Date: Fri, 22 Apr 2005 11:50:55 -0700
From: Paul Jackson <pj@sgi.com>
To: dino@in.ibm.com
Cc: Simon.Derr@bull.net, nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net, akpm@osdl.org, dipankar@in.ibm.com,
       colpatch@us.ibm.com
Subject: Re: [RFC PATCH] Dynamic sched domains aka Isolated cpusets (v0.2)
Message-Id: <20050422115055.5c5b9e25.pj@sgi.com>
In-Reply-To: <20050421173135.GB4200@in.ibm.com>
References: <1097110266.4907.187.camel@arrakis>
	<20050418202644.GA5772@in.ibm.com>
	<20050421173135.GB4200@in.ibm.com>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A few code details (still working on more substantive reply):

+	/* An isolated cpuset has to be exclusive */
+	if ((is_cpu_isolated(trial) && !is_cpu_exclusive(cur)) 
+	   || (!is_cpu_exclusive(trial) && is_cpu_isolated(cur)))
+		return -EINVAL;

Is the above code equivalant to what the comment states:

	if (is_cpu_isolated(trial) <= is_cpu_exclusive(trial))
		return -EINVAL;

+	t = old_parent = *par;
+	cpus_or(all_map, cs->cpus_allowed, cs->isolated_map);
+
+	/* If cpuset empty or top_cpuset, return */
+        if (cpus_empty(all_map) || par == NULL)
+                return;

If the (par == NULL) check succeeds, then perhaps the earlier (*par)
dereference will have oopsed first?

+	struct cpuset *par = cs->parent, t, old_parent;

Looks like 't' was chosen to be a one-char variable name, to keep some
lines below within 80 columns.  I'd do the same myself.  But this leaves
a non-symmetrical naming pattern for the new and old parent cpuset values.

Perhaps the following would work better?

	struct cpuset *parptr;
	struct cpuset o, n;	/* old and new parent cpuset values */

+static void update_cpu_domains(struct cpuset *cs, cpumask_t old_map)

Could old_map be passed as a (const cpumask_t *)?  The stack space of
this code, just for cpumask_t's (see the old and new above) is getting
large for (really) big systems.

+	/* Make the change */
+	par->cpus_allowed = t.cpus_allowed;
+	par->isolated_map = t.isolated_map;

Why don't you need to propogate upward this change to the parents
cpus_allowed and isolated_map?  If a parents isolated_map grows (or
shrinks), doesn't that affect every ancestor, all the way to the top
cpuset?

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
