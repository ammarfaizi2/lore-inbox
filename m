Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932145AbWE3GHF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932145AbWE3GHF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 02:07:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932146AbWE3GHF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 02:07:05 -0400
Received: from wr-out-0506.google.com ([64.233.184.225]:52001 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932145AbWE3GHD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 02:07:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MjF12oKb8lP754jc/AWFG1gahdUcPBUBPjy1LiPIvvDwI7z4KbEXhoISid+7OqEHyNRQ4qmvBQap2nAEIU/iWYUEsqLxulc1EnFM9hqTDEkeP2pBmoGrmjmljy32/5iifnrtG/w6lKorB0FDoMnG9T93lMk1l1J4TderliqYQJE=
Message-ID: <6bffcb0e0605292307y14dd9618r8ccc42ccb0289788@mail.gmail.com>
Date: Tue, 30 May 2006 08:07:03 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Arjan van de Ven" <arjan@infradead.org>
Subject: Re: [patch 00/61] ANNOUNCE: lock validator -V1
Cc: "Dave Jones" <davej@redhat.com>, "Andrew Morton" <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, "Ingo Molnar" <mingo@elte.hu>
In-Reply-To: <1148967947.3636.4.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060529212109.GA2058@elte.hu>
	 <6bffcb0e0605291528qe24a0a3r3841c37c5323de6a@mail.gmail.com>
	 <20060529224107.GA6037@elte.hu> <20060529230908.GC333@redhat.com>
	 <1148967947.3636.4.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 30/05/06, Arjan van de Ven <arjan@infradead.org> wrote:
>
> > I'm feeling a bit overwhelmed by the voluminous output of this checker.
> > Especially as (directly at least) cpufreq doesn't touch vma's, or mmap's.
>
> the reporter doesn't have CONFIG_KALLSYMS_ALL enabled which gives
> sometimes misleading backtraces (should lockdep just enable KALLSYMS_ALL
> to get more useful bugreports?)

Here is bug with CONFIG_KALLSYMS_ALL enabled.

=====================================================
[ BUG: possible circular locking deadlock detected! ]
-----------------------------------------------------
modprobe/1950 is trying to acquire lock:
 (&sighand->siglock){.+..}, at: [<c102b632>] do_notify_parent+0x12b/0x1b9

but task is already holding lock:
 (tasklist_lock){..-<B1>}, at: [<c1023473>] do_exit+0x608/0xa43

which lock already depends on the new lock,
which could lead to circular deadlocks!

the existing dependency chain (in reverse order) is:

-> #1 (cpucontrol){--..}:
       [<c10394be>] lockdep_acquire+0x69/0x82
       [<c11ed729>] __mutex_lock_slowpath+0xd0/0x347
       [<c11ed9bc>] mutex_lock+0x1c/0x1f
       [<c103dda5>] __lock_cpu_hotplug+0x36/0x56
       [<c103ddde>] lock_cpu_hotplug+0xa/0xc
       [<c1199dd6>] __cpufreq_driver_target+0x15/0x50
       [<c119a192>] cpufreq_governor_performance+0x1a/0x20
       [<c1198ada>] __cpufreq_governor+0xa0/0x1a9
       [<c1198cb2>] __cpufreq_set_policy+0xcf/0x100
       [<c1199196>] cpufreq_set_policy+0x2d/0x6f
       [<c1199c7e>] cpufreq_add_dev+0x34f/0x492
       [<c114b898>] sysdev_driver_register+0x58/0x9b
       [<c119a006>] cpufreq_register_driver+0x80/0xf4
       [<fd91402a>] ipt_local_out_hook+0x2a/0x65 [iptable_filter]
       [<c10410e1>] sys_init_module+0xa6/0x230
       [<c11ef97b>] sysenter_past_esp+0x54/0x8d

-> #0 (&sighand->siglock){.+..}:
       [<c10394be>] lockdep_acquire+0x69/0x82
       [<c11ed729>] __mutex_lock_slowpath+0xd0/0x347
       [<c11ed9bc>] mutex_lock+0x1c/0x1f
       [<c11990bb>] cpufreq_update_policy+0x34/0xd8
       [<fd9a350b>] cpufreq_stat_cpu_callback+0x1b/0x7c [cpufreq_stats]
       [<fd9a607d>] cpufreq_stats_init+0x7d/0x9b [cpufreq_stats]
       [<c10410e1>] sys_init_module+0xa6/0x230
       [<c11ef97b>] sysenter_past_esp+0x54/0x8d

other info that might help us debug this:

1 locks held by modprobe/1950:
 #0:  (cpucontrol){--..}, at: [<c11ed9bc>] mutex_lock+0x1c/0x1f

stack backtrace:
 [<c1003ed6>] show_trace+0xd/0xf
 [<c10043e9>] dump_stack+0x17/0x19
 [<c103863e>] print_circular_bug_tail+0x59/0x64
 [<c1038e91>] __lockdep_acquire+0x848/0xa39
 [<c10394be>] lockdep_acquire+0x69/0x82
 [<c11ed729>] __mutex_lock_slowpath+0xd0/0x347
 [<c11ed9bc>] mutex_lock+0x1c/0x1f
 [<c11990bb>] cpufreq_update_policy+0x34/0xd8
 [<fd9a350b>] cpufreq_stat_cpu_callback+0x1b/0x7c [cpufreq_stats]
 [<fd9a607d>] cpufreq_stats_init+0x7d/0x9b [cpufreq_stats]
 [<c10410e1>] sys_init_module+0xa6/0x230
 [<c11ef97b>] sysenter_past_esp+0x54/0x8d


>
> the problem is this, there are 2 scenarios in this bug:
>
> One
> ---
> store_scaling_governor takes policy->lock and then calls __cpufreq_set_policy
> __cpufreq_set_policy calls __cpufreq_governor
> __cpufreq_governor  calls __cpufreq_driver_target via cpufreq_governor_performance
> __cpufreq_driver_target calls lock_cpu_hotplug() (which takes the hotplug lock)
>
>
> Two
> ---
> cpufreq_stats_init lock_cpu_hotplug() and then calls cpufreq_stat_cpu_callback
> cpufreq_stat_cpu_callback calls cpufreq_update_policy
> cpufreq_update_policy takes the policy->lock
>
>
> so this looks like a real honest AB-BA deadlock to me...

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
