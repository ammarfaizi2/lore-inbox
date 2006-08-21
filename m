Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750885AbWHUTWv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750885AbWHUTWv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 15:22:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750889AbWHUTWv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 15:22:51 -0400
Received: from ozlabs.org ([203.10.76.45]:35207 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1750883AbWHUTWu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 15:22:50 -0400
Date: Tue, 22 Aug 2006 05:21:33 +1000
From: Anton Blanchard <anton@samba.org>
To: Paul Jackson <pj@sgi.com>
Cc: simon.derr@bull.net, nathanl@austin.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: cpusets not cpu hotplug aware
Message-ID: <20060821192133.GC8499@krispykreme>
References: <20060821132709.GB8499@krispykreme> <20060821104334.2faad899.pj@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060821104334.2faad899.pj@sgi.com>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

> Your query confuses me, about 4 different ways ...
> 
> 1) What does sched_setaffinity have to do with this part of cpusets?

long sched_setaffinity(pid_t pid, cpumask_t new_mask)
{
...
	cpus_allowed = cpuset_cpus_allowed(p);
	cpus_and(new_mask, new_mask, cpus_allowed);
	retval = set_cpus_allowed(p, new_mask);

If cpuset_cpus_allowed doesnt return the current online mask and we want
to schedule on a cpu that has been added since boot it looks like we
will fail.

> 2) What did you mean by "statically assigned"?  At boot, whatever cpus
>    and memory nodes are online are copied to the top_cpuset's settings.
>    As Simon suggests, it would be up to the hotplug/hotunplug folks to
>    update these top_cpuset settings, as cpus and nodes come and go.

Its up to the cpusets code to register a hotplug notifier to update the
top_cpuset maps.

> 3) I don't understand what you thought was suspicious here.
> 4) I don't understand what you expected to see instead here.

If the top level cpuset pointed to cpu_online_map instead of a boot time
copy we wouldnt need any hotplug gunk in the cpusets code.

Maybe the notifier is the right way to go, but it seems strange to
create two copies of cpu_online_map (with the associated possibiliy of
the two getting out of sync).

Anton
