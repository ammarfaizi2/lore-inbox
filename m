Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264462AbTLGRqy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 12:46:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264464AbTLGRqy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 12:46:54 -0500
Received: from citrine.spiritone.com ([216.99.193.133]:33710 "EHLO
	citrine.spiritone.com") by vger.kernel.org with ESMTP
	id S264462AbTLGRqu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 12:46:50 -0500
Date: Sun, 07 Dec 2003 09:16:59 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Anton Blanchard <anton@samba.org>, Ingo Molnar <mingo@elte.hu>
cc: Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] sched-HT-2.6.0-test11-A5
Message-ID: <1039560000.1070817418@[10.10.2.4]>
In-Reply-To: <20031207163914.GB19412@krispykreme>
References: <1027750000.1069604762@[10.10.2.4]> <Pine.LNX.4.58.0312011102540.3323@earth> <392900000.1070737269@[10.10.2.4]> <Pine.LNX.4.58.0312061601400.1758@montezuma.fsmlabs.com> <Pine.LNX.4.58.0312071433300.28463@earth> <20031207163914.GB19412@krispykreme>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> i've seen a similar crash once on a 2-way (4-way) HT box, so there some
>> startup race going on most likely.
> 
> Im seeing bootup crashes every now and then on a ppc64 box too. A few
> other things Ive noticed:

ALT+sysrq+t does nothing, but NMI watchdog gives me:

-----------------------------------------

Starting migration thread for cpu 0
NMI Watchdog detected LOCKUP on CPU0, eip c011c11b, registers:
CPU:    0
EIP:    0060:[<c011c11b>]    Not tainted
EFLAGS: 00000086
EIP is at .text.lock.sched+0xee/0x243
eax: 0000000c   ebx: 00000286   ecx: f018a000   edx: c3932bc0
esi: 0000000c   edi: c3932bc0   ebp: f018bfb4   esp: f018bfac
ds: 007b   es: 007b   ss: 0068
Process migration/0 (pid: 2, threadinfo=f018a000 task=f018f330)
Stack: 00000000 00000000 f018bfec c011befe 02000000 00000020 c011bd54 00000000 
       00000000 f018f330 c0309c60 c0309c60 f018a000 f018a000 00000000 00000063 
       00000000 c0107001 f01a3fac 00000000 00000000 
Call Trace:
 [<c011befe>] migration_task+0x1aa/0x1b4
 [<c011bd54>] migration_task+0x0/0x1b4
 [<c0107001>] kernel_thread_helper+0x5/0xc

Code: 7e f8 e9 44 e6 ff ff f3 90 80 7e 04 00 7e f8 e9 6b e6 ff ff 
console shuts up ...

---------------------------------------------

 [<c011befe>] migration_task+0x1aa/0x1b4

is just after the return from complete, so I'd say we're deadlocked
on "spin_lock_irqsave(&x->wait.lock, flags);" in complete. Afraid I 
don't understand what the completion / migration stuff is attempting 
to do, so can't be more help ... I can reproduce this 100% of the 
time if you want something tried though.

M.


