Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751293AbWHVEva@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751293AbWHVEva (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 00:51:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751296AbWHVEva
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 00:51:30 -0400
Received: from smtp.osdl.org ([65.172.181.4]:43693 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751293AbWHVEv3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 00:51:29 -0400
Date: Mon, 21 Aug 2006 21:51:20 -0700
From: Andrew Morton <akpm@osdl.org>
To: Paul Jackson <pj@sgi.com>
Cc: Anton Blanchard <anton@samba.org>, simon.derr@bull.net,
       nathanl@austin.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: cpusets not cpu hotplug aware
Message-Id: <20060821215120.244f1f6f.akpm@osdl.org>
In-Reply-To: <20060821140148.435d15f3.pj@sgi.com>
References: <20060821132709.GB8499@krispykreme>
	<20060821104334.2faad899.pj@sgi.com>
	<20060821192133.GC8499@krispykreme>
	<20060821140148.435d15f3.pj@sgi.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Aug 2006 14:01:48 -0700
Paul Jackson <pj@sgi.com> wrote:

> Anton wrote:
> 
> > Maybe the notifier is the right way to go, but it seems strange to
> > create two copies of cpu_online_map (with the associated possibiliy of
> > the two getting out of sync).
> 
> Every cpuset in the system, of which this top_cpuset is just the first,
> has a set of cpus and memory nodes on which tasks in that cpuset are
> allowed to operate.  It's not just top_cpuset that we need to understand
> how to relate to hotplug and unplug.
> 
> I'll bet there is more hidden state in mm/mempolicy.c, for mbind()
> and set_mempolicy(), and in kernel/sched.c for the sched_setaffinity(),
> which was derived from what memory nodes or cpus were online.  For
> example, I see several fields in 'struct mempolicy' that contain
> node numbers in some form, and the 'cpus_allowed' field in the task
> struct that sched_setaffinity sets.
> 
> How does hotplug and unplug interact with these various saved states?
> 
> > Its up to the cpusets code to register a hotplug notifier to update the
> > top_cpuset maps.
> 
> That, or user level code, when it adds or removes a cpu or a memory
> node, needs to be responsible for adding or removing that cpu or node
> to or from whichever cpusets are affected.
> 
> For example, if you just added cpu 31, to a system that had been
> running on cpus 0 to 30, you can add cpu 31 to the top cpuset by
> doing:
> 
> 	mkdir /dev/cpuset		 	# if not already done
> 	mount -t cpuset cpuset /dev/cpuset	# if not already done
> 	/bin/echo 0-31 > /dev/cpsuet/cpus
> 
> > If cpuset_cpus_allowed doesnt return the current online mask and we want
> > to schedule on a cpu that has been added since boot it looks like we
> > will fail.
> 
> In general, on systems actually using cpusets, that -is- what should
> happen.  Just because a cpu was brought online doesn't mean it was
> intended to be allowed in any given tasks current cpuset.
> 
> Granted, I would guess users of systems not using cpusets (but
> still have cpusets configured in their kernel, as is common in some
> distro kernels), would expect the behaviour you expected - bringing
> a cpu (or memory node) on or offline would make it available (or
> not) for something like a sched_setaffinity (or mbind/set_mempolicy)
> immediately, without having to invoke some magic cpuset voodoo.
> 
> Offhand, this sounds to me like a choice of two modes of operation.
> 
>     If you aren't actually using cpusets (so every task is in the
>     original top_cpuset) then you'd expect that cpuset to "get out
>     of the way", meaning top_cpuset (the only cpuset, in this case)
>     tracked whatever cpus and nodes were online at the moment.
> 
>     If instead you start messing with cpusets (creating more than one
>     of them and moving tasks between them) then you'd expect cpusets
>     to be enforced, without automatically adding newly added cpus or
>     memory nodes to existing cpusets.  Only the user knows which
>     cpusets should get the added cpus or memory nodes in this case.
> 
> I don't jump for joy over yet another modal state flag.  But I don't see
> a better alternative -- do you?
> 

If the kernel provider (ie: distro) has enabled cpusets then it would be
appropriate that they also provide a hotplug script which detects whether their
user is actually using cpusets and if not, to take some sensible default action. 
ie: add the newly-added CPU to the system's single cpuset, no?

iow: perhaps send a patch against the upstream udev package.

