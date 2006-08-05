Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422675AbWHEGre@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422675AbWHEGre (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Aug 2006 02:47:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422674AbWHEGre
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Aug 2006 02:47:34 -0400
Received: from mx1.redhat.com ([66.187.233.31]:14822 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1422648AbWHEGrd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Aug 2006 02:47:33 -0400
Date: Sat, 5 Aug 2006 02:47:28 -0400
From: Dave Jones <davej@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>,
       Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.18-rc3-g3b445eea BUG: warning at /usr/src/linux-git/kernel/cpu.c:51/unlock_cpu_hotplug()
Message-ID: <20060805064727.GF13393@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
	LKML <linux-kernel@vger.kernel.org>
References: <6bffcb0e0608041204u4dad7cd6rab0abc3eca6747c0@mail.gmail.com> <Pine.LNX.4.64.0608041222400.5167@g5.osdl.org> <20060804222400.GC18792@redhat.com> <20060805003142.GH18792@redhat.com> <20060805021051.GA13393@redhat.com> <20060805022356.GC13393@redhat.com> <20060805024947.GE13393@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060805024947.GE13393@redhat.com>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2006 at 10:49:47PM -0400, Dave Jones wrote:

This trace now makes a lot more sense to me.

 > CPU1 called lock_cpu_hotplug() for app cpuspeed. recursive_depth=0
 >  [<c0104edc>] show_trace_log_lvl+0x58/0x152
 >  [<c01054c2>] show_trace+0xd/0x10
 >  [<c01055db>] dump_stack+0x19/0x1b
 >  [<c013e8c3>] lock_cpu_hotplug+0x39/0xbf
 >  [<c029fbae>] store_scaling_governor+0x142/0x1a3
 >  [<c029f1a5>] store+0x37/0x48
 >  [<c01a6561>] sysfs_write_file+0xab/0xd1
 >  [<c016f99f>] vfs_write+0xab/0x157
 >  [<c016ffe4>] sys_write+0x3b/0x60
 >  [<c0103db9>] sysenter_past_esp+0x56/0x8d
 > cpuspeed acquired cpu_bitmask_lock
 > 
 > CPU1 called lock_cpu_hotplug() for app cpuspeed. recursive_depth=0
 >  [<c0104edc>] show_trace_log_lvl+0x58/0x152
 >  [<c01054c2>] show_trace+0xd/0x10
 >  [<c01055db>] dump_stack+0x19/0x1b
 >  [<c013e8c3>] lock_cpu_hotplug+0x39/0xbf
 >  [<c0132f3c>] __create_workqueue+0x52/0x122
 >  [<f901234b>] cpufreq_governor_dbs+0x9f/0x2c3 [cpufreq_ondemand]
 >  [<c029f7b6>] __cpufreq_governor+0x57/0xd8
 >  [<c029f985>] __cpufreq_set_policy+0x14e/0x1bc
 >  [<c029fbc5>] store_scaling_governor+0x159/0x1a3
 >  [<c029f1a5>] store+0x37/0x48
 >  [<c01a6561>] sysfs_write_file+0xab/0xd1
 >  [<c016f99f>] vfs_write+0xab/0x157
 >  [<c016ffe4>] sys_write+0x3b/0x60
 >  [<c0103db9>] sysenter_past_esp+0x56/0x8d
 > Lukewarm IQ detected in hotplug locking
 > BUG: warning at kernel/cpu.c:46/lock_cpu_hotplug()

So when we write to sysfs to set the governor, we end up in store_scaling_governor()
which takes the hotplug lock, and then calls off into the governor to let it
do its thing. Part of ondemand's "thing" is to create a workqueue.
unfortunatly, __create_workqueue also takes the hotplug lock.

Creating a variant of __create_workqueue that doesn't take the lock
seems really nasty.

We could remove the locking from store_scaling_governor() and make the governors
themselves have to do the locking, but I'm not sure that's entirely safe.

We could do something really disgusting like ...

	unlock_cpu_hotplug()
	...
	create_workqueue()
	...
	lock_cpu_hotplug()

in ondemand, which opens up a tiny race window, but as ugly as it is,
looks to be the best solution of the bunch right now.

Comments?

The really sad part is this is completely unrelated to the original bug reported
in this thread, which shows just how widespread this braindamage is.
Michal's traces really don't really scream anything obvious to me.
(Though given it took me 4 hours to decode my own traces above, this is no
real sign of how big a problem this might be).

Michal, could you apply this diff.. http://lkml.org/lkml/diff/2006/8/4/381/1
(change the '120' to '60' first), and send me the debug spew that you get ?
You'll have to wait until a minute of uptime has passed. Oh, and edit
include/linux/jiffies.h to change INITIAL_JIFFIES to '0'.

		Dave

-- 
http://www.codemonkey.org.uk
