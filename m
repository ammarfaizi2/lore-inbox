Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269076AbUJTV06@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269076AbUJTV06 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 17:26:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267619AbUJTVWY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 17:22:24 -0400
Received: from lirs02.phys.au.dk ([130.225.28.43]:40126 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S269059AbUJTVUU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 17:20:20 -0400
Date: Wed, 20 Oct 2004 23:19:33 +0200 (METDST)
From: Esben Nielsen <simlo@phys.au.dk>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U8
In-Reply-To: <20041020094508.GA29080@elte.hu>
Message-Id: <Pine.OSF.4.05.10410202314420.5152-100000@da410.ifa.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-DAIMI-Spam-Score: -2.82 () ALL_TRUSTED
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
 I finally got around to get my labtop up running with this. It works -
nearly that is - X even started up!

When I start the network I get the trace below. And my network runs
awfully slowly. Could seem like the interrupt doesn't work correctly....

Regards,
Esben

Oct 20 21:45:53 localhost kernel: e100: Intel(R) PRO/100 Network Driver,
3.1.4-k
2-NAPI
Oct 20 21:45:53 localhost kernel: e100: Copyright(c) 1999-2004 Intel
Corporation
Oct 20 21:45:53 localhost kernel: ACPI: PCI interrupt 0000:00:09.0[A] ->
GSI 11 
(level, low) -> IRQ 11
Oct 20 21:45:53 localhost kernel: e100: eth0: e100_probe: addr 0x41280000,
irq 1
1, MAC addr 00:D0:59:2D:91:84
Oct 20 21:45:53 localhost kernel: ip/1988: BUG in enable_irq at
/misc/frodo_opt3
/simlo/Linux-RT/linux-2.6.9-rc4-mm1-rt-u8.1/kernel/irq/manage.c:111
Oct 20 21:45:53 localhost kernel:  [<c013614e>] enable_irq+0xee/0x100 (12)
Oct 20 21:45:53 localhost kernel:  [<d089741e>] e100_up+0x10e/0x200 [e100]
(48)
Oct 20 21:45:54 localhost kernel:  [<d08987c0>] e100_open+0x30/0x80 [e100]
(48)
Oct 20 21:45:54 localhost kernel:  [<c010fe00>] mcount+0x14/0x18 (12)
Oct 20 21:45:54 localhost kernel:  [<c02ea108>] dev_open+0x88/0xa0 (20)
Oct 20 21:45:54 localhost kernel:  [<c02eb82d>]
dev_change_flags+0x5d/0x140 (28)
Oct 20 21:45:54 localhost kernel:  [<c02e976e>] __dev_get_by_name+0xe/0xd0
(8)
Oct 20 21:45:54 localhost kernel:  [<c03293b7>] devinet_ioctl+0x277/0x6e0
(28)
Oct 20 21:45:54 localhost kernel:  [<c032b834>] inet_ioctl+0x64/0xb0 (108)
Oct 20 21:45:54 localhost kernel:  [<c02e0ae8>] sock_ioctl+0xc8/0x250 (28)
Oct 20 21:45:54 localhost kernel:  [<c016a319>] sys_ioctl+0xc9/0x230 (32)
Oct 20 21:45:54 localhost kernel:  [<c01046fd>]
sysenter_past_esp+0x52/0x71 (44)
Oct 20 21:45:54 localhost kernel: preempt count: 00000002
Oct 20 21:45:54 localhost kernel: . 2-level deep critical section nesting:
Oct 20 21:45:54 localhost kernel: .. entry 1: enable_irq+0x2e/0x100 /
(e100_up+0
x10e/0x200 [e100])
Oct 20 21:45:54 localhost kernel: .. entry 2: print_traces+0x1d/0x60 /
(dump_sta
ck+0x23/0x30)
Oct 20 21:45:54 localhost kernel: 
Oct 20 21:45:54 localhost kernel: e100: eth0: e100_watchdog: link up, 
10Mbps, ha



On Wed, 20 Oct 2004, Ingo Molnar wrote:

> 
> i have released the -U8 Real-Time Preemption patch:
> 
>   http://redhat.com/~mingo/realtime-preempt/realtime-preempt-2.6.9-rc4-mm1-U8
> 
> this too is a fixes-only release. It includes the many semaphore-abuse
> and sleep_on() fixes/improvements from Thomas Gleixner, and it also
> includes a couple of semaphore related fixes.
> 
> I believe the semaphore fixes should resolve a number of the deadlocks
> reported for -U7.
> 
> In particular it seems the only sane and reliable way to convert RCU
> locking was to allow the following semantics for rwsems: allow reads to
> nest, and allow self-read-recursion of a self-write-held semaphore. My
> current implementation for this allows semaphore unfairness, but that
> can be fixed later on. Most importantly, the RCU to RT-locking
> conversions are much more automatic now and map nicely to what the code
> is doing upstream. Most of the time they involve a conversion of a
> spinlock or semaphore into a rwlock or rwsem. The old code maps to new
> code almost automatically, the only manual work needed was to associate
> the rcu_read_lock() with the writers-lock that it excludes against,
> which is a pretty clear (but not automatic, and hence not automatable)
> decision. This way i could convert some more networking code, and
> simplify the older changes and hopefully get rid of some deadlocks. The
> locking API is still not in its final form, but it's getting closer.
> 
> Changes since -U7:
> 
>  - deadlock fix: sysfs/driver-base semaphore fixes from Thomas Gleixner
> 
>  - deadlock fix: scsi semaphore fixes from Thomas Gleixner
> 
>  - NFS sleep_on() fixes from Thomas Gleixner
> 
>  - rawmidid.c sleep_on() fix from Thomas Gleixner
> 
>  - [ i've added more wait_for_completion_*() primitives, to ease 
>      conversion of other semaphore-(ab-)using code. ]
> 
>  - make rwsems self-recursive
> 
>  - RCU lock conversion: convert rtnl_sem RCU use.
> 
>  - netfilter deadlock fix - clean up RCU locking.
> 
> to create a -U8 tree from scratch, the patching order is:
> 
>    http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.8.tar.bz2
>  + http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.9-rc4.bz2
>  + http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc4/2.6.9-rc4-mm1/2.6.9-rc4-mm1.bz2
>  + http://redhat.com/~mingo/realtime-preempt/realtime-preempt-2.6.9-rc4-mm1-U8
> 
> 	Ingo
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

