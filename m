Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751230AbWHTUtR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751230AbWHTUtR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 16:49:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751319AbWHTUtR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 16:49:17 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:27110 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751230AbWHTUtQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 16:49:16 -0400
Date: Sun, 20 Aug 2006 13:48:49 -0700
From: Paul Jackson <pj@sgi.com>
To: vatsa@in.ibm.com
Cc: mingo@elte.hu, nickpiggin@yahoo.com.au, sam@vilain.net,
       linux-kernel@vger.kernel.org, dev@openvz.org, efault@gmx.de,
       balbir@in.ibm.com, sekharan@us.ibm.com, akpm@osdl.org,
       nagar@watson.ibm.com, matthltc@us.ibm.com, dipankar@in.ibm.com,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Subject: Re: [PATCH 7/7] CPU controller V1 - (temporary) cpuset interface
Message-Id: <20060820134849.ac449471.pj@sgi.com>
In-Reply-To: <20060820174839.GH13917@in.ibm.com>
References: <20060820174015.GA13917@in.ibm.com>
	<20060820174839.GH13917@in.ibm.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(I added Suresh to cc list - question relating to his work at bottom of this reply. -pj)

Srivatsa wrote:
> 	- This by no means is any recommendation for cpuset to be chosen as
> 	  resource management interface!

Good ;).  My following comments are also neither a recommendation for or
against this use of cpusets.

>	- Every cpuset directory has two new files - meter_cpu, cpu_quota

To keep the ever growing namespace of per-cpuset files clear, I'd
prefer naming these two new files something such as:

	cpu_meter_enabled
	cpu_meter_quota

You wrote:
> 	- Only cpusets marked as "exclusive" and not having any child cpusets
>	  can be metered. 

and then gave a nice example having cpusets:

	1) /dev/cpuset
	2) /dev/cpuset/grp_a
	3) /dev/cpsuet/grp_a/very_imp_grp
	4) /dev/cpuset/grp_a/less_imp_grp

Your statement tells me cpusets (3) and (4) should be marked
cpu_exclusive, but your example only marked (2) as cpu_exclusive.
Which is it?

Aha - neither is right.  I see further down in the code that
when you create a child of a metered parent, you automatically
copy the 'cpus', 'mems', and meter flag to the new child.

Perhaps it would help to add a comment in the example shell
script setup code, right after each of the lines:
	# mkdir very_imp_grp
	...
	# mkdir less_imp_grp
something like:
	# # Because the parent is marked 'cpu_meter_enabled',
	# # this mkdir automatically copied 'cpus', 'mems' and
	# # 'cpu_meter_enabled' from the parent to the new child.

Essentially, if user does:
	cd /dev/cpuset/...
	echo 1 > cpu_meter_enabled
	mkdir some_grp
the kernel, on the 'mkdir', automatically does:
	cp cpus mems cpu_meter_enabled some_grp

Hmmm ... with this automatic copy, and with the carefully imposed
sequence of operations on the order in which such metered groups can be
setup and torn down, you are implicitly imposing additional constraints
on what configurations of cpusets support metered cpu groups

The constraints seem to be that all metered child cpusets of a
metered parent must have the same cpus and mems, and must also be
marked metered.  And the parent must be cpu_exclusive, and the children
cannot be cpu_exclusive.  And the children must have no children of
their own.

I can certainly imagine that such constraints make it easier to write
correct scheduler group management code.  And I can certainly allow
that the cpuset style API, allowing one bit at a time to be changed
with each separate open/write/close sequence of system calls, makes it
difficult to impose such constraints over the state of several settings
at once.

It sure would be nice to avoid the implicit side affects of copying
parent state on the mkdir, and it sure would be nice to reduce the
enforced sequencing of operations. Off hand, I don't see how to do
this, however.

If you actually ended up using cpusets for this API, then this deserves
some more head scratching.

In the "validate_meters()" routine:

+	/* Cant change meter setting if parent is metered */
+	if (is_changed && parent && is_metered(parent))
+		return -EINVAL;

Would the narrower check "Must meter child of metered parent":
	if (parent && is_metered(parent) && !is_metered(trial))
be sufficient?


+	/* Turn on metering only if a cpuset is exclusive */
+	if (is_metered(trial) && !is_cpu_exclusive(cur))
+		return -EINVAL;
+
+	/* Cant change exclusive setting if a cpuset is metered */
+	if (!is_cpu_exclusive(trial) && is_metered(cur))
+		return -EINVAL;

Can the above two checks be collapsed to one check:

	/* Can only meter if cpu_exclusive */
	if (is_metered(trial) && !is_cpu_exclusive(trial))
		return -EINVAL;

Hmmm ... perhaps that's not right either.  If I understood this right,
the -children- in a metered group are -always- marked meter on, and
cpu_exclusive off.  So they would pass neither your two checks, nor my
one rewrite.

After doing your example, try:
	/bin/echo 1 > /dev/cpuset/grp_a/very_imp_grp/notify_on_release
and see if it fails, EINVAL.  I'll bet it does.


+	/* Cant change exclusive setting if parent is metered */
+	if (parent && is_metered(parent) && is_cpu_exclusive(trial))
+		return -EINVAL;

Comment doesn't seem to match code.  s/change/turn on/ ?

+#ifdef CONFIG_CPUMETER
+	FILE_METER_FLAG,
+	FILE_METER_QUOTA,
+#endif

Could these names match the per-cpuset file names:
	FILE_CPU_METER_ENABLED
	FILE_CPU_METER_QUOTA


One other question ... how does all this interact with Suresh's
dynamic sched domains?

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
