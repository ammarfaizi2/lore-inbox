Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964870AbWBACHm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964870AbWBACHm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 21:07:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964871AbWBACHm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 21:07:42 -0500
Received: from gate.crashing.org ([63.228.1.57]:30125 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S964870AbWBACHl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 21:07:41 -0500
Date: Tue, 31 Jan 2006 19:59:37 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
X-X-Sender: galak@gate.crashing.org
To: Linus Torvalds <torvalds@osdl.org>
cc: Alexey Dobriyan <adobriyan@gmail.com>, Ingo Molnar <mingo@elte.hu>,
       "Paul E. McKenney" <paulmck@us.ibm.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Badness in local_bh_enable by [PATCH] fix uidhash_lock <-> RCU
 deadlock
In-Reply-To: <Pine.LNX.4.64.0601311512230.7301@g5.osdl.org>
Message-ID: <Pine.LNX.4.44.0601311957150.32404-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm also seeing a similar issue on an embedded PowerPC.  Makes my serial 
port seem to lose characters or require extra ones.  Through a slightly 
different path than Alexey:

Badness in local_bh_enable at kernel/softirq.c:140
Call Trace:
[C0673D10] [C0007620] show_stack+0x40/0x194 (unreliable)
[C0673D40] [C000C21C] program_check_exception+0x3c4/0x518
[C0673D80] [C000D588] ret_from_except_full+0x0/0x4c
--- Exception: 700 at local_bh_enable+0x1c/0x84
    LR = free_uid+0x5c/0xb4
[C0673E40] [00800144] 0x800144 (unreliable)
[C0673E50] [C0025540] free_uid+0x5c/0xb4
[C0673E60] [C00259FC] flush_sigqueue+0x84/0xb0
[C0673E80] [C0025E10] __exit_signal+0x214/0x250
[C0673EA0] [C001A6A0] release_task+0x94/0x1d0
[C0673EC0] [C001D164] do_wait+0xc44/0xff4
[C0673F40] [C000CEE8] ret_from_syscall+0x0/0x38
--- Exception: c01 at 0xfe68680
    LR = 0x10023c28

- kumar

> On Wed, 1 Feb 2006, Alexey Dobriyan wrote:
> >
> > Flooding boot logs with
> > 
> > Badness in local_bh_enable at kernel/softirq.c:140
> 
> Ok, looks bad. It's through
> 
>     __dequeue_signal():
> 	collect_signal():
> 	    __sigqueue_free():
> 		free_uid()
> 
> where we hold the sigqueue lock. We do _not_ want to do BH processing 
> there with the lock held and interrupts disabled, so the warning is 
> correct, and that uidhash_lock patch potentially causes more problems than 
> it fixes.
> 
> Perhaps the easiest solution is to just make them irq-safe instead 
> of bh-safe? An alternative might be to make __sigqueue_free() do its work 
> through RCU callbacks too, but that seems wrong.
> 
> Comments? Ingo?
> 
> 		Linus
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


