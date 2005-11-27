Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751059AbVK0N6i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751059AbVK0N6i (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Nov 2005 08:58:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751062AbVK0N6i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Nov 2005 08:58:38 -0500
Received: from mx2.suse.de ([195.135.220.15]:58081 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751056AbVK0N6h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Nov 2005 08:58:37 -0500
Date: Sun, 27 Nov 2005 14:58:33 +0100
From: Andi Kleen <ak@suse.de>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>, "Eric W. Biederman" <ebiederm@xmission.com>,
       "Raj, Ashok" <ashok.raj@intel.com>,
       Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [PATCH] i386/x86_64: Don't IPI to offline cpus on shutdown
Message-ID: <20051127135833.GH20775@brahms.suse.de>
References: <Pine.LNX.4.61.0511270115020.20046@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0511270115020.20046@montezuma.fsmlabs.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 27, 2005 at 02:05:45AM -0800, Zwane Mwaikambo wrote:
> http://bugzilla.kernel.org/show_bug.cgi?id=5203
> 
> There is a small race during SMP shutdown between the processor issuing 
> the shutdown and the other processors clearing themselves off the 
> cpu_online_map as they do this without using the normal cpu offline 
> synchronisation. To avoid this we should wait for all the other processors 
> to clear their corresponding bits and then proceed. This way we can safely 
> make the cpu_online test in smp_send_reschedule, it's safe during normal 
> runtime as smp_send_reschedule is called with a lock held / preemption 
> disabled.

Looking at the backtrace in the bug - how can sys_reboot call do_exit???
I would say the problem is in whatever causes that. It shouldn't 
do that. sys_reboot shouldn't schedule, it's that simple.
Your patch is just papering over that real bug.


Badness in send_IPI_mask_bitmask at arch/i386/kernel/smp.c:168
 [<c0103cd7>] dump_stack+0x17/0x20
 [<c0112286>] send_IPI_mask_bitmask+0x86/0x90
 [<c0112689>] smp_send_reschedule+0x19/0x20
 [<c0117e9b>] resched_task+0x6b/0x90
 [<c01186cb>] try_to_wake_up+0x2db/0x310
 [<c011872a>] wake_up_state+0xa/0x10
 [<c012832b>] signal_wake_up+0x2b/0x40
 [<c0128be0>] __group_complete_signal+0x210/0x250
 [<c0128cb3>] __group_send_sig_info+0x93/0xd0
 [<c0129561>] do_notify_parent+0xe1/0x1c0
 [<c01206b6>] exit_notify+0x366/0x830
 [<c0120e14>] do_exit+0x294/0x3a0
 [<c012b5ef>] sys_reboot+0xcf/0x160
 [<c0102ded>] syscall_call+0x7/0xb


-Andi
