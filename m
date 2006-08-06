Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751498AbWHFQ74@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751498AbWHFQ74 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 12:59:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751505AbWHFQ74
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 12:59:56 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:34006 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751498AbWHFQ7z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 12:59:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pMVuVzyJGl2hMa8xheSRCZIWi/qvRtZ9cSuNlkAKcg2Ql0dGmBrAh0iaMlTmQIv4V6Z040t03SnqHujOQ0pm1m9gvdMBm5l9BPh7DJL4Ce8iCEwh6McYJeQo1BBKzZAazhbMOigDNDRwrDQfB5CR2Kc7RpOmR5ItBlyjEooAVtM=
Message-ID: <6bffcb0e0608060959m164436baj9c4c602496e87f5d@mail.gmail.com>
Date: Sun, 6 Aug 2006 18:59:54 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Dave Jones" <davej@redhat.com>, "Linus Torvalds" <torvalds@osdl.org>,
       "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.18-rc3-g3b445eea BUG: warning at /usr/src/linux-git/kernel/cpu.c:51/unlock_cpu_hotplug()
In-Reply-To: <20060805064727.GF13393@redhat.com>
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
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

On 05/08/06, Dave Jones <davej@redhat.com> wrote:
> On Fri, Aug 04, 2006 at 10:49:47PM -0400, Dave Jones wrote:
>
> This trace now makes a lot more sense to me.
>
>  > CPU1 called lock_cpu_hotplug() for app cpuspeed. recursive_depth=0
>  >  [<c0104edc>] show_trace_log_lvl+0x58/0x152
>  >  [<c01054c2>] show_trace+0xd/0x10
>  >  [<c01055db>] dump_stack+0x19/0x1b
>  >  [<c013e8c3>] lock_cpu_hotplug+0x39/0xbf
>  >  [<c029fbae>] store_scaling_governor+0x142/0x1a3
>  >  [<c029f1a5>] store+0x37/0x48
>  >  [<c01a6561>] sysfs_write_file+0xab/0xd1
>  >  [<c016f99f>] vfs_write+0xab/0x157
>  >  [<c016ffe4>] sys_write+0x3b/0x60
>  >  [<c0103db9>] sysenter_past_esp+0x56/0x8d
>  > cpuspeed acquired cpu_bitmask_lock
>  >
>  > CPU1 called lock_cpu_hotplug() for app cpuspeed. recursive_depth=0
>  >  [<c0104edc>] show_trace_log_lvl+0x58/0x152
>  >  [<c01054c2>] show_trace+0xd/0x10
>  >  [<c01055db>] dump_stack+0x19/0x1b
>  >  [<c013e8c3>] lock_cpu_hotplug+0x39/0xbf
>  >  [<c0132f3c>] __create_workqueue+0x52/0x122
>  >  [<f901234b>] cpufreq_governor_dbs+0x9f/0x2c3 [cpufreq_ondemand]
>  >  [<c029f7b6>] __cpufreq_governor+0x57/0xd8
>  >  [<c029f985>] __cpufreq_set_policy+0x14e/0x1bc
>  >  [<c029fbc5>] store_scaling_governor+0x159/0x1a3
>  >  [<c029f1a5>] store+0x37/0x48
>  >  [<c01a6561>] sysfs_write_file+0xab/0xd1
>  >  [<c016f99f>] vfs_write+0xab/0x157
>  >  [<c016ffe4>] sys_write+0x3b/0x60
>  >  [<c0103db9>] sysenter_past_esp+0x56/0x8d
>  > Lukewarm IQ detected in hotplug locking
>  > BUG: warning at kernel/cpu.c:46/lock_cpu_hotplug()
>
> So when we write to sysfs to set the governor, we end up in store_scaling_governor()
> which takes the hotplug lock, and then calls off into the governor to let it
> do its thing. Part of ondemand's "thing" is to create a workqueue.
> unfortunatly, __create_workqueue also takes the hotplug lock.
>
> Creating a variant of __create_workqueue that doesn't take the lock
> seems really nasty.
>
> We could remove the locking from store_scaling_governor() and make the governors
> themselves have to do the locking, but I'm not sure that's entirely safe.
>
> We could do something really disgusting like ...
>
>         unlock_cpu_hotplug()
>         ...
>         create_workqueue()
>         ...
>         lock_cpu_hotplug()
>
> in ondemand, which opens up a tiny race window, but as ugly as it is,
> looks to be the best solution of the bunch right now.
>
> Comments?
>
> The really sad part is this is completely unrelated to the original bug reported
> in this thread, which shows just how widespread this braindamage is.
> Michal's traces really don't really scream anything obvious to me.
> (Though given it took me 4 hours to decode my own traces above, this is no
> real sign of how big a problem this might be).
>
> Michal, could you apply this diff.. http://lkml.org/lkml/diff/2006/8/4/381/1
> (change the '120' to '60' first), and send me the debug spew that you get ?
> You'll have to wait until a minute of uptime has passed. Oh, and edit
> include/linux/jiffies.h to change INITIAL_JIFFIES to '0'.

I hope that this one will help

BUG: using smp_processor_id() in preemptible [00000001] code: cpuspeed/1433
caller is lock_cpu_hotplug+0x25/0xc5
 [<fd95918f>] store_speed+0x36/0x9b [cpufreq_userspace]
 [<c029fa95>] store+0x37/0x48
 [<c0104007>] show_trace_log_lvl+0x58/0x159
 [<c0104765>] show_trace+0xd/0x10
 [<c010482d>] dump_stack+0x19/0x1b
 [<c01fc842>] debug_smp_processor_id+0x96/0xac
 [<c01a8197>] sysfs_write_file+0xa6/0xcc
 [<c013e0db>] lock_cpu_hotplug+0x25/0xc5
 [<fd95918f>] store_speed+0x36/0x9b [cpufreq_userspace]
 [<c029fa95>] store+0x37/0x48
 [<c01a8197>] sysfs_write_file+0xa6/0xcc
 [<c0171577>] vfs_write+0xcd/0x179
 [<c0171c20>] sys_write+0x3b/0x71
 [<c010318d>] sysenter_past_esp+0x56/0x8d
DWARF2 unwinder stuck at sysenter_past_esp+0x56/0x8d
Leftover inexact backtrace:
 [<c0104765>] show_trace+0xd/0x10
 [<c010482d>] dump_stack+0x19/0x1b
 [<c01fc842>] debug_smp_processor_id+0x96/0xac
 [<c013e0db>] lock_cpu_hotplug+0x25/0xc5
 [<fd95918f>] store_speed+0x36/0x9b [cpufreq_userspace]
 [<c029fa95>] store+0x37/0x48
 [<c01a8197>]  [<c0171577>] vfs_write+0xcd/0x179

It's from 2.6.18-rc3-mm2.

Config and dmesg log -> http://www.stardust.webpages.pl/files/mm/2.6.18-rc3-mm2/

>
>                 Dave
>
> --
> http://www.codemonkey.org.uk
>

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
