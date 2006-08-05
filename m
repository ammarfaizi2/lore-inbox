Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422648AbWHELLS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422648AbWHELLS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Aug 2006 07:11:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161602AbWHELLS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Aug 2006 07:11:18 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:33580 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1161601AbWHELLR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Aug 2006 07:11:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=oKVmqW+Ty5ewgMbvB6zHmHqxTL6tlfpYyhtVD0WQisu+IyRT5ZQ7yXySaE19ok2u6BBrFTTfY562MEzQz0Cf7l3SECsSNod6wokuYlZtvNMVsEnGk9UVd4AShKbM2Xa2way+ysk8nmfX4IK7etUjk6jPHsqzEkC8rUnqT28wKek=
Message-ID: <6bffcb0e0608050411q22112b71wced519a6491c6abe@mail.gmail.com>
Date: Sat, 5 Aug 2006 13:11:17 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Dave Jones" <davej@redhat.com>, "Linus Torvalds" <torvalds@osdl.org>,
       "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.18-rc3-g3b445eea BUG: warning at /usr/src/linux-git/kernel/cpu.c:51/unlock_cpu_hotplug()
In-Reply-To: <6bffcb0e0608050354k4dd0bb0ep337216e984ce41d7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <6bffcb0e0608041204u4dad7cd6rab0abc3eca6747c0@mail.gmail.com>
	 <Pine.LNX.4.64.0608041222400.5167@g5.osdl.org>
	 <20060804222400.GC18792@redhat.com>
	 <20060805003142.GH18792@redhat.com>
	 <20060805021051.GA13393@redhat.com>
	 <20060805022356.GC13393@redhat.com>
	 <20060805024947.GE13393@redhat.com>
	 <20060805064727.GF13393@redhat.com>
	 <6bffcb0e0608050354k4dd0bb0ep337216e984ce41d7@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/08/06, Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
> On 05/08/06, Dave Jones <davej@redhat.com> wrote:
> > On Fri, Aug 04, 2006 at 10:49:47PM -0400, Dave Jones wrote:
> >
> > This trace now makes a lot more sense to me.
> >
> >  > CPU1 called lock_cpu_hotplug() for app cpuspeed. recursive_depth=0
> >  >  [<c0104edc>] show_trace_log_lvl+0x58/0x152
> >  >  [<c01054c2>] show_trace+0xd/0x10
> >  >  [<c01055db>] dump_stack+0x19/0x1b
> >  >  [<c013e8c3>] lock_cpu_hotplug+0x39/0xbf
> >  >  [<c029fbae>] store_scaling_governor+0x142/0x1a3
> >  >  [<c029f1a5>] store+0x37/0x48
> >  >  [<c01a6561>] sysfs_write_file+0xab/0xd1
> >  >  [<c016f99f>] vfs_write+0xab/0x157
> >  >  [<c016ffe4>] sys_write+0x3b/0x60
> >  >  [<c0103db9>] sysenter_past_esp+0x56/0x8d
> >  > cpuspeed acquired cpu_bitmask_lock
> >  >
> >  > CPU1 called lock_cpu_hotplug() for app cpuspeed. recursive_depth=0
> >  >  [<c0104edc>] show_trace_log_lvl+0x58/0x152
> >  >  [<c01054c2>] show_trace+0xd/0x10
> >  >  [<c01055db>] dump_stack+0x19/0x1b
> >  >  [<c013e8c3>] lock_cpu_hotplug+0x39/0xbf
> >  >  [<c0132f3c>] __create_workqueue+0x52/0x122
> >  >  [<f901234b>] cpufreq_governor_dbs+0x9f/0x2c3 [cpufreq_ondemand]
> >  >  [<c029f7b6>] __cpufreq_governor+0x57/0xd8
> >  >  [<c029f985>] __cpufreq_set_policy+0x14e/0x1bc
> >  >  [<c029fbc5>] store_scaling_governor+0x159/0x1a3
> >  >  [<c029f1a5>] store+0x37/0x48
> >  >  [<c01a6561>] sysfs_write_file+0xab/0xd1
> >  >  [<c016f99f>] vfs_write+0xab/0x157
> >  >  [<c016ffe4>] sys_write+0x3b/0x60
> >  >  [<c0103db9>] sysenter_past_esp+0x56/0x8d
> >  > Lukewarm IQ detected in hotplug locking
> >  > BUG: warning at kernel/cpu.c:46/lock_cpu_hotplug()
> >
> > So when we write to sysfs to set the governor, we end up in store_scaling_governor()
> > which takes the hotplug lock, and then calls off into the governor to let it
> > do its thing. Part of ondemand's "thing" is to create a workqueue.
> > unfortunatly, __create_workqueue also takes the hotplug lock.
> >
> > Creating a variant of __create_workqueue that doesn't take the lock
> > seems really nasty.
> >
> > We could remove the locking from store_scaling_governor() and make the governors
> > themselves have to do the locking, but I'm not sure that's entirely safe.
> >
> > We could do something really disgusting like ...
> >
> >         unlock_cpu_hotplug()
> >         ...
> >         create_workqueue()
> >         ...
> >         lock_cpu_hotplug()
> >
> > in ondemand, which opens up a tiny race window, but as ugly as it is,
> > looks to be the best solution of the bunch right now.
> >
> > Comments?
> >
> > The really sad part is this is completely unrelated to the original bug reported
> > in this thread, which shows just how widespread this braindamage is.
> > Michal's traces really don't really scream anything obvious to me.
> > (Though given it took me 4 hours to decode my own traces above, this is no
> > real sign of how big a problem this might be).
> >
> > Michal, could you apply this diff.. http://lkml.org/lkml/diff/2006/8/4/381/1
> > (change the '120' to '60' first), and send me the debug spew that you get ?
> > You'll have to wait until a minute of uptime has passed. Oh, and edit
> > include/linux/jiffies.h to change INITIAL_JIFFIES to '0'.
>
> p4-clockmod: P4/Xeon(TM) CPU On-Demand Clock Modulation available
> ip_tables: (C) 2000-2006 Netfilter Core Team
> Netfilter messages via NETLINK v0.30.
> BUG: warning at /usr/src/linux-git/kernel/cpu.c:69/unlock_cpu_hotplug()
>  [<c0132a91>] unlock_cpu_hotplug+0x63/0xb2
>  [<c013a3a0>] stop_machine_run+0x2e/0x34
>  [<c013573a>] sys_init_module+0x15a0/0x178a
>  [<c015b86b>] do_sync_read+0xb6/0xf1
>  [<c0102d51>] sysenter_past_esp+0x56/0x79
> ip_conntrack version 2.4 (8192 buckets, 65536 max) - 224 bytes per conntrack
> NET: Registered protocol family 17
> skge eth0: enabling interface
> skge eth0: Link is up at 100 Mbps, full duplex, flow control tx and rx
> w83627hf 9191-0290: Reading VID from GPIO5
> NET: Registered protocol family 10
> IPv6 over IPv4 tunneling driver
> audit(1154774854.770:5): avc:  denied  { write } for  pid=1360
> comm="cpuspeed" name="cpufreq" dev=sysfs ino=4863
> scontext=system_u:system_r:cpuspeed_t:s0
> tcontext=system_u:object_r:sysfs_t:s0 tclass=dir
> eth0: no IPv6 routers present
> CPU0 called lock_cpu_hotplug() for app amarokapp. recursive_depth=0
>  [<c01329ab>] lock_cpu_hotplug+0x36/0xb9
>  [<c01182ce>] sched_getaffinity+0xf/0x83
>  [<c0118361>] sys_sched_getaffinity+0x1f/0x41
>  [<c0102d51>] sysenter_past_esp+0x56/0x79
> amarokapp acquired cpu_bitmask_lock
> CPU0 called unlock_cpu_hotplug() for app amarokapp. recursive_depth=0
>  [<c0132a62>] unlock_cpu_hotplug+0x34/0xb2
>  [<c0118323>] sched_getaffinity+0x64/0x83
>  [<c0118361>] sys_sched_getaffinity+0x1f/0x41
>  [<c0102d51>] sysenter_past_esp+0x56/0x79
> amarokapp released cpu_bitmask_lock
> CPU0 called lock_cpu_hotplug() for app amarokapp. recursive_depth=0
>  [<c01329ab>] lock_cpu_hotplug+0x36/0xb9
>  [<c01195ca>] sched_setaffinity+0xf/0xd5
>  [<c01196cb>] sys_sched_setaffinity+0x3b/0x41
>  [<c0102d51>] sysenter_past_esp+0x56/0x79
> amarokapp acquired cpu_bitmask_lock
> CPU0 called unlock_cpu_hotplug() for app amarokapp. recursive_depth=0
>  [<c0132a62>] unlock_cpu_hotplug+0x34/0xb2
>  [<c0119689>] sched_setaffinity+0xce/0xd5
>  [<c01196cb>] sys_sched_setaffinity+0x3b/0x41
>  [<c0102d51>] sysenter_past_esp+0x56/0x79
> amarokapp released cpu_bitmask_lock

audit(1154775731.471:6): avc:  denied  { write } for  pid=1361
comm="cpuspeed" name="cpufreq" dev=sysfs ino=4863
scontext=system_u:system_r:cpuspeed_t:s0
tcontext=system_u:object_r:sysfs_t:s0 tclass=dir
CPU0 called lock_cpu_hotplug() for app konsole. recursive_depth=0
 [<c01329ab>] lock_cpu_hotplug+0x36/0xb9
 [<c012aadf>] flush_workqueue+0x25/0x57
 [<c020e1b7>] release_dev+0x485/0x5f2
 [<c016f7f8>] d_lookup+0x1b/0x3b
 [<c012d8d6>] remove_wait_queue+0xc/0x34
 [<c020e333>] tty_release+0xf/0x18
 [<c015c943>] __fput+0x90/0x15e
 [<c015a361>] filp_close+0x4e/0x54
 [<c0102d51>] sysenter_past_esp+0x56/0x79
konsole acquired cpu_bitmask_lock
CPU0 called unlock_cpu_hotplug() for app konsole. recursive_depth=0
 [<c0132a62>] unlock_cpu_hotplug+0x34/0xb2
 [<c020e1b7>] release_dev+0x485/0x5f2
 [<c016f7f8>] d_lookup+0x1b/0x3b
 [<c012d8d6>] remove_wait_queue+0xc/0x34
 [<c020e333>] tty_release+0xf/0x18
 [<c015c943>] __fput+0x90/0x15e
 [<c015a361>] filp_close+0x4e/0x54
 [<c0102d51>] sysenter_past_esp+0x56/0x79
konsole released cpu_bitmask_lock

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
