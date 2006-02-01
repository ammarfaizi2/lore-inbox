Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030290AbWBACl1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030290AbWBACl1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 21:41:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030272AbWBACl1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 21:41:27 -0500
Received: from omta02ps.mx.bigpond.com ([144.140.83.154]:40538 "EHLO
	omta02ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1030290AbWBACl1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 21:41:27 -0500
Message-ID: <43E01FD3.3080100@bigpond.net.au>
Date: Wed, 01 Feb 2006 13:41:23 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Kumar Gala <galak@kernel.crashing.org>,
       Alexey Dobriyan <adobriyan@gmail.com>, Ingo Molnar <mingo@elte.hu>,
       "Paul E. McKenney" <paulmck@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: Badness in local_bh_enable by [PATCH] fix uidhash_lock <-> RCU
 deadlock
References: <Pine.LNX.4.44.0601311957150.32404-100000@gate.crashing.org>
In-Reply-To: <Pine.LNX.4.44.0601311957150.32404-100000@gate.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta02ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Wed, 1 Feb 2006 02:41:24 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kumar Gala wrote:
> I'm also seeing a similar issue on an embedded PowerPC.  Makes my serial 
> port seem to lose characters or require extra ones.  Through a slightly 
> different path than Alexey:
> 
> Badness in local_bh_enable at kernel/softirq.c:140
> Call Trace:
> [C0673D10] [C0007620] show_stack+0x40/0x194 (unreliable)
> [C0673D40] [C000C21C] program_check_exception+0x3c4/0x518
> [C0673D80] [C000D588] ret_from_except_full+0x0/0x4c
> --- Exception: 700 at local_bh_enable+0x1c/0x84
>     LR = free_uid+0x5c/0xb4
> [C0673E40] [00800144] 0x800144 (unreliable)
> [C0673E50] [C0025540] free_uid+0x5c/0xb4
> [C0673E60] [C00259FC] flush_sigqueue+0x84/0xb0
> [C0673E80] [C0025E10] __exit_signal+0x214/0x250
> [C0673EA0] [C001A6A0] release_task+0x94/0x1d0
> [C0673EC0] [C001D164] do_wait+0xc44/0xff4
> [C0673F40] [C000CEE8] ret_from_syscall+0x0/0x38
> --- Exception: c01 at 0xfe68680
>     LR = 0x10023c28
> 
> - kumar
> 
> 
>>On Wed, 1 Feb 2006, Alexey Dobriyan wrote:
>>
>>>Flooding boot logs with
>>>
>>>Badness in local_bh_enable at kernel/softirq.c:140
>>
>>Ok, looks bad. It's through
>>
>>    __dequeue_signal():
>>	collect_signal():
>>	    __sigqueue_free():
>>		free_uid()
>>
>>where we hold the sigqueue lock. We do _not_ want to do BH processing 
>>there with the lock held and interrupts disabled, so the warning is 
>>correct, and that uidhash_lock patch potentially causes more problems than 
>>it fixes.
>>
>>Perhaps the easiest solution is to just make them irq-safe instead 
>>of bh-safe? An alternative might be to make __sigqueue_free() do its work 
>>through RCU callbacks too, but that seems wrong.
>>
>>Comments? Ingo?
>>
>>		Linus

More data points.  I'm seeing two slightly different to each other (one 
has a preempt_schedule() in the middle of the call sequence) and 
different to those already reported versions of this problem on a Pentium 4:

Badness in local_bh_enable at kernel/softirq.c:140
[<c011928f>] local_bh_enable+0x7e/0x88
[<c011f01a>] __dequeue_signal+0x164/0x1d6
[<c011f104>] dequeue_signal+0x78/0xc1
[<c011ffc3>] get_signal_to_deliver+0x5c/0x55e
[<c0148b88>] do_wp_page+0x20e/0x353
[<c01023e5>] do_notify_resume+0x8e/0x6a1
[<c036fdd7>] notifier_call_chain+0x27/0x40
[<c011ea10>] sigprocmask+0x62/0xd8
[<c011eb59>] sys_rt_sigprocmask+0xd3/0xf8
[<c0102bb2>] work_notifysig+0x13/0x19
Badness in local_bh_enable at kernel/softirq.c:140
[<c011928f>] local_bh_enable+0x7e/0x88
[<c011f01a>] __dequeue_signal+0x164/0x1d6
[<c011f104>] dequeue_signal+0x78/0xc1
[<c011ffc3>] get_signal_to_deliver+0x5c/0x55e
[<c0148b88>] do_wp_page+0x20e/0x353
[<c01023e5>] do_notify_resume+0x8e/0x6a1
[<c036cc83>] preempt_schedule+0x4a/0x56
[<c036fdd7>] notifier_call_chain+0x27/0x40
[<c011ea10>] sigprocmask+0x62/0xd8
[<c011eb59>] sys_rt_sigprocmask+0xd3/0xf8
[<c0102bb2>] work_notifysig+0x13/0x19

-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
