Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750712AbWHVFKa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750712AbWHVFKa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 01:10:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750731AbWHVFKa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 01:10:30 -0400
Received: from smtp.osdl.org ([65.172.181.4]:59059 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750712AbWHVFK2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 01:10:28 -0400
Date: Mon, 21 Aug 2006 22:07:53 -0700
From: Andrew Morton <akpm@osdl.org>
To: Paul Jackson <pj@sgi.com>
Cc: Nathan Lynch <ntl@pobox.com>, anton@samba.org, simon.derr@bull.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpuset code prevents binding tasks to new cpus
Message-Id: <20060821220753.05609683.akpm@osdl.org>
In-Reply-To: <20060821214224.4949fc28.pj@sgi.com>
References: <20060821132709.GB8499@krispykreme>
	<20060821104334.2faad899.pj@sgi.com>
	<20060821192133.GC8499@krispykreme>
	<20060821204251.GB9828@localdomain>
	<20060821160454.9e44427b.pj@sgi.com>
	<20060821232738.GA11309@localdomain>
	<20060821214224.4949fc28.pj@sgi.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Aug 2006 21:42:24 -0700
Paul Jackson <pj@sgi.com> wrote:

> > Will it actually break anything?
> 
> It will break any user code that thought it could actually run on the
> CPUs listed in its cpuset, if it happens to be in a task in the top
> cpuset.  I'm pretty sure I've got some cpuset users who would be
> harmed by this change.
> 
> One degree of freedom for change we do have is that, as best I know,
> no one is doing anything serious with both cpu hotplug/unplug and with
> cpusets at the same time on the same system.  For instance, I am
> willing to wager that no one is counting on the CPUs in the top cpuset
> remaining constant if a CPU comes on or off line.  I say this because
> so far as I know, serious cpuset users aren't taking CPUs on and
> off line.  I've rather been expecting cpusets and cpu hotplug to
> butt heads for a couple of years now.  Looks like the time has come.
> 
> So if I'm right, we could change the API to have the top_cpuset
> cpus_allowed track the cpus_online_map dynamically, rather than being a
> static copy of the cpus_online_map value at system boot, with little
> or no negative impact on users.
> 
> For adding CPUs, that is easy enough, using a register_cpu_notifier
> callback to add new CPUs to top_cpuset.cpus_allowed.

register_hotcpu_notifier(), please.  That exists so all the cpu-hotplug
goop can be put inside #ifdef CONFIG_HOTPLUG_CPU,

>  This may seem
> like overkill to Nathan, but I think it is necessary, to keep the
> top cpusets CPUs tracking what's online, rather than changing it to
> what's possible (which can be a -much- bigger set of CPUs on some
> configurations, and likely surprising to existing cpuset-aware code.)
> Automatically adding newly onlined CPUs to just the top cpuset (but not
> to other cpusets) does treat the top cpuset as a special case, but I
> doubt this will surprise existing cpuset aware code, and corresponds
> nicely to what hotplug aware, cpuset clueless code will expect.
> 
> For removing CPUs, this is a bit harder, as one cannot remove a CPU
> from a cpuset without first removing it from any child cpusets of
> that cpuset.  So I will need to scan the cpuset hierarchy, from the
> bottom up, removing the CPU about to be offline'd, and in the case that
> this was the last CPU in a cpuset, finding some fallback setting for
> that cpuset.  I suspect that means moving any poor tasks left in that
> soon to be useless (no CPUs) cpuset into the parent cpuset, then
> empty'ing the cpus_allowed for that cpuset.  If the user doesn't like
> this default action, they should have done what they wanted first, by
> adapting their cpuset configuration in anticipation of taking the CPU
> offline.  Taking CPUs offline will likely surprise (as in break)
> existing cpuset aware code, but I don't know any way around that.
> 
> In any event, as a workaround with existing kernels, I suspect you could
> make use of the existing /sbin/hotplug mechanism to run the (bash syntax)
> following commands to add a newly online CPU $cpu to the top cpuset's cpus:
> 
> 	test -d /dev/cpuset || mkdir /dev/cpuset
> 	test -f /dev/cpuset/cpus || mount -t cpuset cpuset /dev/cpuset
> 	/bin/echo $(</dev/cpuset/cpus),$cpu > /dev/cpuset/cpus
> 
> This workaround presumes that the number of the CPU being added, $cpu,
> is visible to the user level hotplug script - offhand I don't know if
> that is so or not.

Please, let's get this into the udev tarball and let it trickle out.
