Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751438AbWE2W2i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751438AbWE2W2i (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 18:28:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751439AbWE2W2i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 18:28:38 -0400
Received: from wr-out-0506.google.com ([64.233.184.224]:50924 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751438AbWE2W2h convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 18:28:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qwTQEU6Qf7NKlIN28klq3qcuYgwF4YabqkAk/NmtrEtWvvf4CZVa2zc+MW04RUtIOJCPqkgd3SUGnjMFllGuREQyziOr6UwOmAqkCKlCMfhLZRD/ImU/9trq+RthpVe8Wd88nGMpFtiHHPS5dy/c3dwtIkK0ivLx64BRCQ41eDs=
Message-ID: <6bffcb0e0605291528qe24a0a3r3841c37c5323de6a@mail.gmail.com>
Date: Tue, 30 May 2006 00:28:37 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Ingo Molnar" <mingo@elte.hu>
Subject: Re: [patch 00/61] ANNOUNCE: lock validator -V1
Cc: linux-kernel@vger.kernel.org, "Arjan van de Ven" <arjan@infradead.org>,
       "Andrew Morton" <akpm@osdl.org>, "Dave Jones" <davej@codemonkey.org.uk>
In-Reply-To: <20060529212109.GA2058@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060529212109.GA2058@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/05/06, Ingo Molnar <mingo@elte.hu> wrote:
> We are pleased to announce the first release of the "lock dependency
> correctness validator" kernel debugging feature, which can be downloaded
> from:
>
>   http://redhat.com/~mingo/lockdep-patches/
>
[snip]

I get this while loading cpufreq modules

=====================================================
[ BUG: possible circular locking deadlock detected! ]
-----------------------------------------------------
modprobe/1942 is trying to acquire lock:
 (&anon_vma->lock){--..}, at: [<c10609cf>] anon_vma_link+0x1d/0xc9

but task is already holding lock:
 (&mm->mmap_sem/1){--..}, at: [<c101e5a0>] copy_process+0xbc6/0x1519

which lock already depends on the new lock,
which could lead to circular deadlocks!

the existing dependency chain (in reverse order) is:

-> #1 (cpucontrol){--..}:
       [<c10394be>] lockdep_acquire+0x69/0x82
       [<c11ed759>] __mutex_lock_slowpath+0xd0/0x347
       [<c11ed9ec>] mutex_lock+0x1c/0x1f
       [<c103dda5>] __lock_cpu_hotplug+0x36/0x56
       [<c103ddde>] lock_cpu_hotplug+0xa/0xc
       [<c1199e06>] __cpufreq_driver_target+0x15/0x50
       [<c119a1c2>] cpufreq_governor_performance+0x1a/0x20
       [<c1198b0a>] __cpufreq_governor+0xa0/0x1a9
       [<c1198ce2>] __cpufreq_set_policy+0xcf/0x100
       [<c11991c6>] cpufreq_set_policy+0x2d/0x6f
       [<c1199cae>] cpufreq_add_dev+0x34f/0x492
       [<c114b8c8>] sysdev_driver_register+0x58/0x9b
       [<c119a036>] cpufreq_register_driver+0x80/0xf4
       [<fd97b02a>] ct_get_next+0x17/0x3f [ip_conntrack]
       [<c10410e1>] sys_init_module+0xa6/0x230
       [<c11ef9ab>] sysenter_past_esp+0x54/0x8d

-> #0 (&anon_vma->lock){--..}:
       [<c10394be>] lockdep_acquire+0x69/0x82
       [<c11ed759>] __mutex_lock_slowpath+0xd0/0x347
       [<c11ed9ec>] mutex_lock+0x1c/0x1f
       [<c11990eb>] cpufreq_update_policy+0x34/0xd8
       [<fd9ad50b>] cpufreq_stat_cpu_callback+0x1b/0x7c [cpufreq_stats]
       [<fd9b007d>] cpufreq_stats_init+0x7d/0x9b [cpufreq_stats]
       [<c10410e1>] sys_init_module+0xa6/0x230
       [<c11ef9ab>] sysenter_past_esp+0x54/0x8d

other info that might help us debug this:

1 locks held by modprobe/1942:
  #0:  (cpucontrol){--..}, at: [<c11ed9ec>] mutex_lock+0x1c/0x1f

stack backtrace:
 <c1003f36> show_trace+0xd/0xf  <c1004449> dump_stack+0x17/0x19
 <c103863e> print_circular_bug_tail+0x59/0x64  <c1038e91>
__lockdep_acquire+0x848/0xa39
 <c10394be> lockdep_acquire+0x69/0x82  <c11ed759>
__mutex_lock_slowpath+0xd0/0x347
 <c11ed9ec> mutex_lock+0x1c/0x1f  <c11990eb> cpufreq_update_policy+0x34/0xd8
 <fd9ad50b> cpufreq_stat_cpu_callback+0x1b/0x7c [cpufreq_stats]
<fd9b007d> cpufreq_stats_init+0x7d/0x9b [cpufreq_stats]
 <c10410e1> sys_init_module+0xa6/0x230  <c11ef9ab> sysenter_past_esp+0x54/0x8d

Here is dmesg http://www.stardust.webpages.pl/files/lockdep/2.6.17-rc4-mm3-lockdep1/lockdep-dmesg3

Here is config
http://www.stardust.webpages.pl/files/lockdep/2.6.17-rc4-mm3-lockdep1/lockdep-config2

BTW I still must revert lockdep-serial.patch - it doesn't compile on
my gcc 4.1.1

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
