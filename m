Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422710AbWHECK7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422710AbWHECK7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 22:10:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161513AbWHECK7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 22:10:59 -0400
Received: from mx1.redhat.com ([66.187.233.31]:24793 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1161511AbWHECK6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 22:10:58 -0400
Date: Fri, 4 Aug 2006 22:10:51 -0400
From: Dave Jones <davej@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>,
       Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       Dave Jones <davej@codemonkey.org.uk>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.18-rc3-g3b445eea BUG: warning at /usr/src/linux-git/kernel/cpu.c:51/unlock_cpu_hotplug()
Message-ID: <20060805021051.GA13393@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
	Dave Jones <davej@codemonkey.org.uk>,
	LKML <linux-kernel@vger.kernel.org>
References: <6bffcb0e0608041204u4dad7cd6rab0abc3eca6747c0@mail.gmail.com> <Pine.LNX.4.64.0608041222400.5167@g5.osdl.org> <20060804222400.GC18792@redhat.com> <20060805003142.GH18792@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060805003142.GH18792@redhat.com>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2006 at 08:31:42PM -0400, Dave Jones wrote:
 > On Fri, Aug 04, 2006 at 06:24:00PM -0400, Dave Jones wrote:
 >  >  > DaveJ, any ideas?
 >  > 
 >  > So I'm at a loss to explain why this made this bug suddenly appear, but
 >  > I don't think this is anything new.   Fixing it however...
 >  > I'm looking at it, but I don't see anything obvious yet.
 >  
 > Ok, debugging this is getting ridiculous.  I dug out a core duo,
 > built a kernel and watched it spontaneously reboot before it even got to init.

Hmm, this went away after a ccache flush & a rebuild. Old crud left behind
from earlier debugging I guess.

So I added this diff..

diff --git a/kernel/cpu.c b/kernel/cpu.c
index f230f9a..31210a0 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -31,6 +31,14 @@ void lock_cpu_hotplug(void)
 {
 	struct task_struct *tsk = current;
 
+	if (jiffies > HZ * 60) {
+		printk ("CPU%d called lock_cpu_hotplug() for app %s. recursive_depth=%d\n",
+			smp_processor_id(),
+			current->comm,
+			recursive_depth);
+		dump_stack();
+	}
+
 	if (tsk == recursive) {
 		static int warnings = 10;
 		if (warnings) {
@@ -42,18 +50,30 @@ void lock_cpu_hotplug(void)
 		return;
 	}
 	mutex_lock(&cpu_bitmask_lock);
+	if (jiffies > HZ * 60)
+		printk ("%s acquired cpu_bitmask_lock\n", current->comm);
 	recursive = tsk;
 }
 EXPORT_SYMBOL_GPL(lock_cpu_hotplug);
 
 void unlock_cpu_hotplug(void)
 {
+	if (jiffies > HZ * 120) {
+		printk ("CPU%d called unlock_cpu_hotplug() for app %s. recursive_depth=%d\n",
+			smp_processor_id(),
+			current->comm,
+			recursive_depth);
+		dump_stack();
+	}
+
 	WARN_ON(recursive != current);
 	if (recursive_depth) {
 		recursive_depth--;
 		return;
 	}
 	mutex_unlock(&cpu_bitmask_lock);
+	if (jiffies > HZ * 120)
+		printk ("%s released cpu_bitmask_lock\n", current->comm);
 	recursive = NULL;
 }
 EXPORT_SYMBOL_GPL(unlock_cpu_hotplug);

In the hope to better understand what the hell is going on.
Here's what happened when I started the cpuspeed service

(That DWARF unwinder stuck thing is really darned annoying btw)

CPU1 called lock_cpu_hotplug() for app modprobe. recursive_depth=0
 [<c0104edc>] show_trace_log_lvl+0x58/0x152
 [<c01054c2>] show_trace+0xd/0x10
 [<c01055db>] dump_stack+0x19/0x1b
 [<c013e8c3>] lock_cpu_hotplug+0x39/0xbf
 [<c01499c8>] stop_machine_run+0x11/0x38
 [<c0141943>] sys_init_module+0x166d/0x1847
 [<c0103db9>] sysenter_past_esp+0x56/0x8d
DWARF2 unwinder stuck at sysenter_past_esp+0x56/0x8d
Leftover inexact backtrace:
 [<c01054c2>] show_trace+0xd/0x10
 [<c01055db>] dump_stack+0x19/0x1b
 [<c013e8c3>] lock_cpu_hotplug+0x39/0xbf
 [<c01499c8>] stop_machine_run+0x11/0x38
 [<c0141943>] sys_init_module+0x166d/0x1847
 [<c0103db9>] sysenter_past_esp+0x56/0x8d
modprobe acquired cpu_bitmask_lock

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
DWARF2 unwinder stuck at sysenter_past_esp+0x56/0x8d
Leftover inexact backtrace:
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

I have questions.

1. How come the printk at the end of unlock_cpu_hotplug() never
got hit when modprobe got to the end of stop_machine_run() ?

2. How come another process acquired this mutex when the previous
one aparently never released it ?

Moving on ...

CPU1 called lock_cpu_hotplug() for app cpuspeed. recursive_depth=0
 [<c0104edc>] show_trace_log_lvl+0x58/0x152
 [<c01054c2>] show_trace+0xd/0x10
 [<c01055db>] dump_stack+0x19/0x1b
 [<c013e8c3>] lock_cpu_hotplug+0x39/0xbf
 [<c0132f3c>] __create_workqueue+0x52/0x122
 [<f8faf34b>] cpufreq_governor_dbs+0x9f/0x2c3 [cpufreq_ondemand]
 [<c029f7b6>] __cpufreq_governor+0x57/0xd8
 [<c029f985>] __cpufreq_set_policy+0x14e/0x1bc
 [<c029fbc5>] store_scaling_governor+0x159/0x1a3
 [<c029f1a5>] store+0x37/0x48
 [<c01a6561>] sysfs_write_file+0xab/0xd1
 [<c016f99f>] vfs_write+0xab/0x157
 [<c016ffe4>] sys_write+0x3b/0x60
 [<c0103db9>] sysenter_past_esp+0x56/0x8d
DWARF2 unwinder stuck at sysenter_past_esp+0x56/0x8d
Leftover inexact backtrace:
 [<c01054c2>] show_trace+0xd/0x10
 [<c01055db>] dump_stack+0x19/0x1b
 [<c013e8c3>] lock_cpu_hotplug+0x39/0xbf
 [<c0132f3c>] __create_workqueue+0x52/0x122
 [<f8faf34b>] cpufreq_governor_dbs+0x9f/0x2c3 [cpufreq_ondemand]
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
 [<c0104edc>] show_trace_log_lvl+0x58/0x152
 [<c01054c2>] show_trace+0xd/0x10
 [<c01055db>] dump_stack+0x19/0x1b
 [<c013e8fc>] lock_cpu_hotplug+0x72/0xbf
 [<c0132f3c>] __create_workqueue+0x52/0x122
 [<f8faf34b>] cpufreq_governor_dbs+0x9f/0x2c3 [cpufreq_ondemand]
 [<c029f7b6>] __cpufreq_governor+0x57/0xd8
 [<c029f985>] __cpufreq_set_policy+0x14e/0x1bc
 [<c029fbc5>] store_scaling_governor+0x159/0x1a3
 [<c029f1a5>] store+0x37/0x48
 [<c01a6561>] sysfs_write_file+0xab/0xd1
 [<c016f99f>] vfs_write+0xab/0x157
 [<c016ffe4>] sys_write+0x3b/0x60
 [<c0103db9>] sysenter_past_esp+0x56/0x8d
DWARF2 unwinder stuck at sysenter_past_esp+0x56/0x8d
Leftover inexact backtrace:
 [<c01054c2>] show_trace+0xd/0x10
 [<c01055db>] dump_stack+0x19/0x1b
 [<c013e8fc>] lock_cpu_hotplug+0x72/0xbf
 [<c0132f3c>] __create_workqueue+0x52/0x122
 [<f8faf34b>] cpufreq_governor_dbs+0x9f/0x2c3 [cpufreq_ondemand]
 [<c029f7b6>] __cpufreq_governor+0x57/0xd8
 [<c029f985>] __cpufreq_set_policy+0x14e/0x1bc
 [<c029fbc5>] store_scaling_governor+0x159/0x1a3
 [<c029f1a5>] store+0x37/0x48
 [<c01a6561>] sysfs_write_file+0xab/0xd1
 [<c016f99f>] vfs_write+0xab/0x157
 [<c016ffe4>] sys_write+0x3b/0x60
 [<c0103db9>] sysenter_past_esp+0x56/0x8d


Ok, now that it's done insulting my IQ, recursive_depth should be 1.
However ... 


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


WTF is going on here ?
In the whole log, recursive_depth is always 0.


At this stage, it gets into a death spiral printing out the same
crap over and over again.  I put the full log at
http://people.redhat.com/davej/hotplug-wtf.txt

Note how the acquire/releases don't match up at all. Scary.

		Dave

-- 
http://www.codemonkey.org.uk
