Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750795AbWJJOEZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750795AbWJJOEZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 10:04:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750793AbWJJOEZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 10:04:25 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:36779 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750795AbWJJOEY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 10:04:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=b1drUacP7bSjaDbQ89lFepbnua9UuTBmIfbHaK15+XigAQf6As8MqQu7dz7TEzo8+Cq1xV5jcmSf2F8wfFMjrLxickpcE2Z/FCkuGicJ65Vo7Obtt5Hw5FymLl0vjGvdGpsGYR69WxSQjp0+mYfd/ROs3KaKN93FgYaW18tq4LI=
Message-ID: <6bffcb0e0610100704m32ccc6bakb446671f04b04c2b@mail.gmail.com>
Date: Tue, 10 Oct 2006 16:04:22 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: 2.6.19-rc1-mm1
Cc: "Pavel Machek" <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@sisk.pl>,
       linux-kernel@vger.kernel.org, "Neil Brown" <neilb@cse.unsw.edu.au>,
       "Ingo Molnar" <mingo@elte.hu>
In-Reply-To: <6bffcb0e0610100610p6eb65726of92b85f7d49e80bb@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061010000928.9d2d519a.akpm@osdl.org>
	 <6bffcb0e0610100610p6eb65726of92b85f7d49e80bb@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/06, Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
> Hi,
>
> On 10/10/06, Andrew Morton <akpm@osdl.org> wrote:
> >
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc1/2.6.19-rc1-mm1/
> >
>
> Kernel 2.6.19-rc1-mm1 + Neil's avoid_lockdep_warning_in_md.patch
> (http://www.ussg.iu.edu/hypermail/linux/kernel/0610.1/0642.html)
>
> (I'll try to reproduce this without Neil's patch).

I can't reproduce this without Neil's patch.

>
> echo shutdown > /sys/power/disk; echo disk > /sys/power/state
>
> =======================================================
> [ INFO: possible circular locking dependency detected ]
> 2.6.19-rc1-mm1 #4
> -------------------------------------------------------
> bash/2404 is trying to acquire lock:
>  ((cpu_chain).rwsem){..--}, at: [<c012e6a0>]
> blocking_notifier_call_chain+0x11/0x2d
>
> but task is already holding lock:
>  (workqueue_mutex){--..}, at: [<c0313dea>] mutex_lock+0x1c/0x1f
>
> which lock already depends on the new lock.
>
> the existing dependency chain (in reverse order) is:
>
> -> #1 (workqueue_mutex){--..}:
>        [<c013a4d0>] add_lock_to_list+0x5c/0x7a
>        [<c013c5f5>] __lock_acquire+0x9f3/0xaef
>        [<c013ca5b>] lock_acquire+0x71/0x91
>        [<c0313baf>] __mutex_lock_slowpath+0xd2/0x2f1
>        [<c0313dea>] mutex_lock+0x1c/0x1f
>        [<c0131767>] workqueue_cpu_callback+0x109/0x1ff
>        [<c012e30f>] notifier_call_chain+0x20/0x31
>        [<c012e6ac>] blocking_notifier_call_chain+0x1d/0x2d
>        [<c014126b>] _cpu_down+0x48/0x1ff
>        [<c01415fc>] disable_nonboot_cpus+0x9b/0x12f
>        [<c0146bd3>] prepare_processes+0xf/0x73
>        [<c0146e78>] pm_suspend_disk+0xa/0x11c
>        [<c01460d4>] enter_state+0x5a/0x185
>        [<c0146285>] state_store+0x86/0x9c
>        [<c01ad6dc>] subsys_attr_store+0x20/0x25
>        [<c01ad7df>] sysfs_write_file+0xaa/0xd3
>        [<c0177189>] vfs_write+0xcd/0x179
>        [<c0177834>] sys_write+0x3b/0x71
>        [<c0103241>] sysenter_past_esp+0x56/0x8d
>        [<ffffffff>] 0xffffffff
>
> -> #0 ((cpu_chain).rwsem){..--}:
>        [<c013bbce>] print_circular_bug_tail+0x30/0x64
>        [<c013c52c>] __lock_acquire+0x92a/0xaef
>        [<c013ca5b>] lock_acquire+0x71/0x91
>        [<c0138202>] down_read+0x28/0x3c
>        [<c012e6a0>] blocking_notifier_call_chain+0x11/0x2d
>        [<c014138b>] _cpu_down+0x168/0x1ff
>        [<c01415fc>] disable_nonboot_cpus+0x9b/0x12f
>        [<c0146bd3>] prepare_processes+0xf/0x73
>        [<c0146e78>] pm_suspend_disk+0xa/0x11c
>        [<c01460d4>] enter_state+0x5a/0x185
>        [<c0146285>] state_store+0x86/0x9c
>        [<c01ad6dc>] subsys_attr_store+0x20/0x25
>        [<c01ad7df>] sysfs_write_file+0xaa/0xd3
>        [<c0177189>] vfs_write+0xcd/0x179
>        [<c0177834>] sys_write+0x3b/0x71
>        [<c0103241>] sysenter_past_esp+0x56/0x8d
>        [<ffffffff>] 0xffffffff
>
> other info that might help us debug this:
>
> 2 locks held by bash/2404:
>  #0:  (cpu_add_remove_lock){--..}, at: [<c0313dea>] mutex_lock+0x1c/0x1f
>  #1:  (workqueue_mutex){--..}, at: [<c0313dea>] mutex_lock+0x1c/0x1f
>
> stack backtrace:
>  [<c01042e6>] dump_trace+0x64/0x1cd
>  [<c0104461>] show_trace_log_lvl+0x12/0x25
>  [<c0104a08>] show_trace+0xd/0x10
>  [<c0104a4f>] dump_stack+0x19/0x1b
>  [<c013bbf7>] print_circular_bug_tail+0x59/0x64
>  [<c013c52c>] __lock_acquire+0x92a/0xaef
>  [<c013ca5b>] lock_acquire+0x71/0x91
>  [<c0138202>] down_read+0x28/0x3c
>  [<c012e6a0>] blocking_notifier_call_chain+0x11/0x2d
>  [<c014138b>] _cpu_down+0x168/0x1ff
>  [<c01415fc>] disable_nonboot_cpus+0x9b/0x12f
>  [<c0146bd3>] prepare_processes+0xf/0x73
>  [<c0146e78>] pm_suspend_disk+0xa/0x11c
>  [<c01460d4>] enter_state+0x5a/0x185
>  [<c0146285>] state_store+0x86/0x9c
>  [<c01ad6dc>] subsys_attr_store+0x20/0x25
>  [<c01ad7df>] sysfs_write_file+0xaa/0xd3
>  [<c0177189>] vfs_write+0xcd/0x179
>  [<c0177834>] sys_write+0x3b/0x71
>  [<c0103241>] sysenter_past_esp+0x56/0x8d
> DWARF2 unwinder stuck at sysenter_past_esp+0x56/0x8d
> Leftover inexact backtrace:
>  =======================
>
> config & dmesg http://www.stardust.webpages.pl/files/tbf/euridica/2.6.19-rc1-mm1/

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/)
