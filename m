Return-Path: <linux-kernel-owner+w=401wt.eu-S932965AbWL0QOt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932965AbWL0QOt (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 11:14:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932987AbWL0QOt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 11:14:49 -0500
Received: from nz-out-0506.google.com ([64.233.162.227]:56730 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932965AbWL0QOs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 11:14:48 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KHpGL+MVzZN1XmIlORZLkNp0nq0KM1N38b6LDQX3y4w678wyaFof+7xO3wLiUyYYNq7QqnWj1b8QA6MX6mUAhSfQCXk7IXNF2iX3ist51JkiCUScth75pXUPu0j8n0qc6q4AOXCEFGv39QJqcry1W5TIDWflvkBSijK/AtlJaBw=
Message-ID: <b0943d9e0612270814m30fe8813mad20f22f9d188896@mail.gmail.com>
Date: Wed, 27 Dec 2006 16:14:47 +0000
From: "Catalin Marinas" <catalin.marinas@gmail.com>
To: "Ingo Molnar" <mingo@elte.hu>
Subject: Re: [PATCH 2.6.20-rc1 00/10] Kernel memory leak detector 0.13
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20061217094143.GA15372@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061216153346.18200.51408.stgit@localhost.localdomain>
	 <20061216165738.GA5165@elte.hu>
	 <b0943d9e0612161539s50fd6086v9246d6b0ffac949a@mail.gmail.com>
	 <20061217085859.GB2938@elte.hu> <20061217090943.GA9246@elte.hu>
	 <20061217092828.GA14181@elte.hu> <20061217094143.GA15372@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/12/06, Ingo Molnar <mingo@elte.hu> wrote:
> it would be nice to record 1) the jiffies value at the time of
> allocation, 2) the PID and the comm of the task that did the allocation.
> The jiffies timestamp would be useful to see the age of the allocation,
> and the PID/comm is useful for context.

Trying to copy the comm with get_task_comm, I get the lockdep report
below, caused by acquiring the task's alloc_lock. Any idea how to go
around this?

=================================
[ INFO: inconsistent lock state ]
2.6.20-rc2 #211
---------------------------------
inconsistent {hardirq-on-W} -> {in-hardirq-W} usage.
swapper/0 [HC1[1]:SC0[0]:HE0:SE1] takes:
 (init_task.alloc_lock){+-..}, at: [<c007d950>] get_task_comm+0x24/0x40
{hardirq-on-W} state was registered at:
  [<c00493d0>] lock_acquire+0x80/0x94
  [<c020cf1c>] _spin_lock+0x30/0x40
  [<c0027c80>] copy_process+0x8b8/0x1208
  [<c0028874>] do_fork+0xc0/0x1e0
  [<c001497c>] kernel_thread+0x70/0x80
  [<c000f864>] rest_init+0x1c/0x30
  [<c000fa9c>] start_kernel+0x224/0x27c
  [<00008078>] 0x8078
irq event stamp: 33758
hardirqs last  enabled at (33757): [<c0014ef8>] default_idle+0x44/0x50
hardirqs last disabled at (33758): [<c00131d4>] __irq_svc+0x34/0xc0
softirqs last  enabled at (33750): [<c002f97c>] __do_softirq+0x10c/0x124
softirqs last disabled at (33745): [<c002fde0>] irq_exit+0x58/0x60

other info that might help us debug this:
1 lock held by swapper/0:
 #0:  (&lp->lock){+...}, at: [<c0146b9c>] smc_interrupt+0x28/0x784

stack backtrace:
[<c0018cf4>] (dump_stack+0x0/0x14) from [<c00471b4>]
(print_usage_bug+0x11c/0x154)
[<c0047098>] (print_usage_bug+0x0/0x154) from [<c0047b60>]
(mark_lock+0xe0/0x4c8)
 r8 = 00000001  r7 = C02A4348  r6 = 00000000  r5 = 00000002
 r4 = C02A4638
[<c0047a80>] (mark_lock+0x0/0x4c8) from [<c0048b34>]
(__lock_acquire+0x424/0xc40)
[<c0048710>] (__lock_acquire+0x0/0xc40) from [<c00493d0>]
(lock_acquire+0x80/0x94)
[<c0049350>] (lock_acquire+0x0/0x94) from [<c020cf1c>] (_spin_lock+0x30/0x40)
[<c020ceec>] (_spin_lock+0x0/0x40) from [<c007d950>] (get_task_comm+0x24/0x40)
 r4 = C02A4348
[<c007d92c>] (get_task_comm+0x0/0x40) from [<c0075570>]
(memleak_alloc+0x168/0x2b4)
 r6 = C7596E60  r5 = A0000193  r4 = C7596E64
[<c0075408>] (memleak_alloc+0x0/0x2b4) from [<c0072800>]
(kmem_cache_alloc+0x110/0x124)
[<c00726f0>] (kmem_cache_alloc+0x0/0x124) from [<c0199228>]
(__alloc_skb+0x34/0x130)
[<c01991f4>] (__alloc_skb+0x0/0x130) from [<c0146f04>]
(smc_interrupt+0x390/0x784)
[<c0146b74>] (smc_interrupt+0x0/0x784) from [<c005322c>]
(handle_IRQ_event+0x2c/0x68)
[<c0053200>] (handle_IRQ_event+0x0/0x68) from [<c0054d94>]
(handle_level_irq+0xe4/0x150)
 r7 = C02A1128  r6 = C7805C20  r5 = 00000029  r4 = C02A1100
[<c0054cb0>] (handle_level_irq+0x0/0x150) from [<c001469c>]
(asm_do_IRQ+0x70/0x9c)
 r7 = 00008000  r6 = 00000029  r5 = 00000000  r4 = C029E000
[<c001462c>] (asm_do_IRQ+0x0/0x9c) from [<c00131d4>] (__irq_svc+0x34/0xc0)
 r5 = FF000100  r4 = FFFFFFFF
[<c0014eb4>] (default_idle+0x0/0x50) from [<c0014cb0>] (cpu_idle+0x30/0x4c)
[<c0014c80>] (cpu_idle+0x0/0x4c) from [<c000f870>] (rest_init+0x28/0x30)
 r5 = C02C3D30  r4 = C04DB2A4
[<c000f848>] (rest_init+0x0/0x30) from [<c000fa9c>] (start_kernel+0x224/0x27c)
[<c000f878>] (start_kernel+0x0/0x27c) from [<00008078>] (0x8078)

-- 
Catalin
