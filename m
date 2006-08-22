Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750733AbWHVFOu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750733AbWHVFOu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 01:14:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750750AbWHVFOu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 01:14:50 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:55431 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750733AbWHVFOt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 01:14:49 -0400
Date: Mon, 21 Aug 2006 22:14:37 -0700
From: Paul Jackson <pj@sgi.com>
To: Nathan Lynch <ntl@pobox.com>
Cc: akpm@osdl.org, anton@samba.org, simon.derr@bull.net,
       nathanl@austin.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: cpusets not cpu hotplug aware
Message-Id: <20060821221437.255808fa.pj@sgi.com>
In-Reply-To: <20060822050401.GB11309@localdomain>
References: <20060821132709.GB8499@krispykreme>
	<20060821104334.2faad899.pj@sgi.com>
	<20060821192133.GC8499@krispykreme>
	<20060821140148.435d15f3.pj@sgi.com>
	<20060821215120.244f1f6f.akpm@osdl.org>
	<20060822050401.GB11309@localdomain>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan wrote:
> I think it would be more sensible for the default (i.e. user hasn't
> explicitly configured any cpusets) behavior on a CONFIG_CPUSETS=y
> kernel to match the behavior with a CONFIG_CPUSETS=n kernel. 

Basically, in this situation, that would mean that the code that
masks a requested sched_setaffinity cpumask with the tasks
cpuset_cpus_allowed():

	cpus_allowed = cpuset_cpus_allowed(p);
	cpus_and(new_mask, new_mask, cpus_allowed);

would not be executed in the case of a kernel configured for cpusets,
when running on a system that wasn't using cpusets.

That's quite doable, and for systems not actually using cpusets, makes
good sense.

But it makes a bit of discontinuity in the system behaviour when
someone starts using cpusets.  If someone makes a cpuset, then suddenly
tasks in the top cpuset start seeing failed sched_setaffinity calls
for any CPU that was brought online after system boot.

If there is some decent way I can get the cpus_allowed of the top
cpuset to track the cpu_online_map, then we avoid this discontinuity
in system behaviour.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
