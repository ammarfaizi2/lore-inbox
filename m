Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422718AbWHECtx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422718AbWHECtx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 22:49:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422719AbWHECtx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 22:49:53 -0400
Received: from mx1.redhat.com ([66.187.233.31]:1257 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1422718AbWHECtw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 22:49:52 -0400
Date: Fri, 4 Aug 2006 22:49:47 -0400
From: Dave Jones <davej@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>,
       Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.18-rc3-g3b445eea BUG: warning at /usr/src/linux-git/kernel/cpu.c:51/unlock_cpu_hotplug()
Message-ID: <20060805024947.GE13393@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
	LKML <linux-kernel@vger.kernel.org>
References: <6bffcb0e0608041204u4dad7cd6rab0abc3eca6747c0@mail.gmail.com> <Pine.LNX.4.64.0608041222400.5167@g5.osdl.org> <20060804222400.GC18792@redhat.com> <20060805003142.GH18792@redhat.com> <20060805021051.GA13393@redhat.com> <20060805022356.GC13393@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060805022356.GC13393@redhat.com>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2006 at 10:23:56PM -0400, Dave Jones wrote:

 > Duh.  Everything becomes clearer the moment you post a diff to lkml.
 
Right, with that silly thinko out of the way, things make _slightly_
more sense, but I'm still puzzled. Here's the trace (with the DWARF
noise stripped out).

CPU1 called lock_cpu_hotplug() for app cpuspeed. recursive_depth=0
 [<c0104edc>] show_trace_log_lvl+0x58/0x152
 [<c01054c2>] show_trace+0xd/0x10
 [<c01055db>] dump_stack+0x19/0x1b
 [<c013e8c3>] lock_cpu_hotplug+0x39/0xbf
 [<c029fbae>] store_scaling_governor+0x142/0x1a3
 [<c029f1a5>] store+0x37/0x48
 [<c01a6561>] sysfs_write_file+0xab/0xd1
 [<c016f99f>] vfs_write+0xab/0x157
 [<c016ffe4>] sys_write+0x3b/0x60
 [<c0103db9>] sysenter_past_esp+0x56/0x8d
cpuspeed acquired cpu_bitmask_lock

CPU1 called lock_cpu_hotplug() for app cpuspeed. recursive_depth=0
 [<c0104edc>] show_trace_log_lvl+0x58/0x152
 [<c01054c2>] show_trace+0xd/0x10
 [<c01055db>] dump_stack+0x19/0x1b
 [<c013e8c3>] lock_cpu_hotplug+0x39/0xbf
 [<c0132f3c>] __create_workqueue+0x52/0x122
 [<f901234b>] cpufreq_governor_dbs+0x9f/0x2c3 [cpufreq_ondemand]
 [<c029f7b6>] __cpufreq_governor+0x57/0xd8
 [<c029f985>] __cpufreq_set_policy+0x14e/0x1bc
 [<c029fbc5>] store_scaling_governor+0x159/0x1a3
 [<c029f1a5>] store+0x37/0x48
 [<c01a6561>] sysfs_write_file+0xab/0xd1
 [<c016f99f>] vfs_write+0xab/0x157
 [<c016ffe4>] sys_write+0x3b/0x60
 [<c0103db9>] sysenter_past_esp+0x56/0x8d
Lukewarm IQ detected in hotplug locking
BUG: warning at kernel/cpu.c:46/lock_cpu_hotplug()

CPU1 called unlock_cpu_hotplug() for app cpuspeed. recursive_depth=1
 [<c0104edc>] show_trace_log_lvl+0x58/0x152
 [<c01054c2>] show_trace+0xd/0x10
 [<c01055db>] dump_stack+0x19/0x1b
 [<c013e980>] unlock_cpu_hotplug+0x37/0xb7
 [<c0132fea>] __create_workqueue+0x100/0x122
 [<f901234b>] cpufreq_governor_dbs+0x9f/0x2c3 [cpufreq_ondemand]
 [<c029f7b6>] __cpufreq_governor+0x57/0xd8
 [<c029f985>] __cpufreq_set_policy+0x14e/0x1bc
 [<c029fbc5>] store_scaling_governor+0x159/0x1a3
 [<c029f1a5>] store+0x37/0x48
 [<c01a6561>] sysfs_write_file+0xab/0xd1
 [<c016f99f>] vfs_write+0xab/0x157
 [<c016ffe4>] sys_write+0x3b/0x60
 [<c0103db9>] sysenter_past_esp+0x56/0x8d

CPU1 called unlock_cpu_hotplug() for app cpuspeed. recursive_depth=0
 [<c0104edc>] show_trace_log_lvl+0x58/0x152
 [<c01054c2>] show_trace+0xd/0x10
 [<c01055db>] dump_stack+0x19/0x1b
 [<c013e980>] unlock_cpu_hotplug+0x37/0xb7
 [<c029fbe5>] store_scaling_governor+0x179/0x1a3
 [<c029f1a5>] store+0x37/0x48
 [<c01a6561>] sysfs_write_file+0xab/0xd1
 [<c016f99f>] vfs_write+0xab/0x157
 [<c016ffe4>] sys_write+0x3b/0x60
 [<c0103db9>] sysenter_past_esp+0x56/0x8d

So in these traces we're seeing
lock
 lock
 unlock
unlock

But what I really don't understand is the ordering here.
Immediately after that first trace we should see an unlock.
store_scaling_governor does a lock/unlock pair, with no chance
of returning with the hotplug lock still held.

In the second trace however, cpuspeed is off doing something
completely different.

How can this happen?

My head hurts.

		Dave

-- 
http://www.codemonkey.org.uk
