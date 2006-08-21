Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422804AbWHURtu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422804AbWHURtu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 13:49:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422808AbWHURtu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 13:49:50 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:50331 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1422804AbWHURtt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 13:49:49 -0400
Date: Mon, 21 Aug 2006 23:19:06 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Paul Jackson <pj@sgi.com>
Cc: mingo@elte.hu, nickpiggin@yahoo.com.au, sam@vilain.net,
       linux-kernel@vger.kernel.org, dev@openvz.org, efault@gmx.de,
       balbir@in.ibm.com, sekharan@us.ibm.com, akpm@osdl.org,
       nagar@watson.ibm.com, matthltc@us.ibm.com, dipankar@in.ibm.com,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Subject: Re: [PATCH 7/7] CPU controller V1 - (temporary) cpuset interface
Message-ID: <20060821174906.GB21130@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20060820174015.GA13917@in.ibm.com> <20060820174839.GH13917@in.ibm.com> <20060820134849.ac449471.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060820134849.ac449471.pj@sgi.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 20, 2006 at 01:48:49PM -0700, Paul Jackson wrote:
> Srivatsa wrote:
> > 	- This by no means is any recommendation for cpuset to be chosen as
> > 	  resource management interface!
> 
> Good ;).  My following comments are also neither a recommendation for or
> against this use of cpusets.

Good :)

> To keep the ever growing namespace of per-cpuset files clear, I'd
> prefer naming these two new files something such as:
> 
> 	cpu_meter_enabled
> 	cpu_meter_quota

Ok ..

> Perhaps it would help to add a comment in the example shell
> script setup code, right after each of the lines:
> 	# mkdir very_imp_grp
> 	...
> 	# mkdir less_imp_grp
> something like:
> 	# # Because the parent is marked 'cpu_meter_enabled',
> 	# # this mkdir automatically copied 'cpus', 'mems' and
> 	# # 'cpu_meter_enabled' from the parent to the new child.

Ok sure.

> Hmmm ... with this automatic copy, and with the carefully imposed
> sequence of operations on the order in which such metered groups can be
> setup and torn down, you are implicitly imposing additional constraints
> on what configurations of cpusets support metered cpu groups
> 
> The constraints seem to be that all metered child cpusets of a
> metered parent must have the same cpus and mems, and must also be
> marked metered.  And the parent must be cpu_exclusive, and the children
> cannot be cpu_exclusive.  And the children must have no children of
> their own.

Yes. IMHO allowing metered child cpusets to have different cpus doesnt
make much sense because the child cpusets represent some task-grouping
here (which has been provided some CPU bandwidth) rather than a cpuset in its 
true-sense.

> I can certainly imagine that such constraints make it easier to write
> correct scheduler group management code.  And I can certainly allow
> that the cpuset style API, allowing one bit at a time to be changed
> with each separate open/write/close sequence of system calls, makes it
> difficult to impose such constraints over the state of several settings
> at once.

Could you elaborate this a bit? What do you mean by "difficult to impose
such constraints"? Are you referring to things like after metered child
cpusets have been created, any changes to cpus field of parent has to be
reflected in all its child-cpusets 'atomically'?

> It sure would be nice to avoid the implicit side affects of copying
> parent state on the mkdir, and it sure would be nice to reduce the
> enforced sequencing of operations. 

How would this help?

> If you actually ended up using cpusets for this API, then this deserves
> some more head scratching.

There is atleast another serious issue in using cpusets for this API -
how do we easily find all tasks belonging to a cpuset? There seems to be
no easy way of doing this, w/o walking thr' the complete task-list.

We need this task-list for various reasons - like change
taks->load_weight of all tasks in a child-cpuset when its cpu quota is
changed etc.

> In the "validate_meters()" routine:
> 
> +	/* Cant change meter setting if parent is metered */
> +	if (is_changed && parent && is_metered(parent))
> +		return -EINVAL;
> 
> Would the narrower check "Must meter child of metered parent":
> 	if (parent && is_metered(parent) && !is_metered(trial))
> be sufficient?

Yes ..although I think the former check is more readable.

> +	/* Turn on metering only if a cpuset is exclusive */
> +	if (is_metered(trial) && !is_cpu_exclusive(cur))
> +		return -EINVAL;
> +
> +	/* Cant change exclusive setting if a cpuset is metered */
> +	if (!is_cpu_exclusive(trial) && is_metered(cur))
> +		return -EINVAL;
> 
> Can the above two checks be collapsed to one check:
> 
> 	/* Can only meter if cpu_exclusive */
> 	if (is_metered(trial) && !is_cpu_exclusive(trial))
> 		return -EINVAL;
> 
> Hmmm ... perhaps that's not right either.  If I understood this right,
> the -children- in a metered group are -always- marked meter on, and
> cpu_exclusive off.  

Yes.

> So they would pass neither your two checks, nor my one rewrite.

Hmm .. your are right. How abt this:

	/* Turn on metering only if a cpuset is exclusive */
	if (!is_metered(parent) && is_metered(trial) && !is_cpu_exclusive(cur))
		return -EINVAL;

	/* Cant change exclusive setting if a cpuset is metered */
	if (!is_metered(parent) && !is_cpu_exclusive(trial) && is_metered(cur))
		return -EINVAL;

> After doing your example, try:
> 	/bin/echo 1 > /dev/cpuset/grp_a/very_imp_grp/notify_on_release
> and see if it fails, EINVAL.  I'll bet it does.

Or perhaps even /bin/echo 0 > /dev/cpuset/grp_a/very_imp_grp/cpu_exclsuive
(to see the failure)?


> +	/* Cant change exclusive setting if parent is metered */
> +	if (parent && is_metered(parent) && is_cpu_exclusive(trial))
> +		return -EINVAL;
> 
> Comment doesn't seem to match code.  s/change/turn on/ ?

Yes, "turn on" perhaps makes better sense here in the comment.

> +#ifdef CONFIG_CPUMETER
> +	FILE_METER_FLAG,
> +	FILE_METER_QUOTA,
> +#endif
> 
> Could these names match the per-cpuset file names:
> 	FILE_CPU_METER_ENABLED
> 	FILE_CPU_METER_QUOTA

Sure ..Will fix in the next version.

> One other question ... how does all this interact with Suresh's
> dynamic sched domains?

By "all this" I presume you are referring to the changes to cpuset in
this patch. I see little interaction. AFAICS all metered child-cpusets should 
be in the same dynamic sched-domain afaics.

-- 
Regards,
vatsa
