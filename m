Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262178AbVBKX5A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262178AbVBKX5A (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 18:57:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262266AbVBKX5A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 18:57:00 -0500
Received: from relay1.tiscali.de ([62.26.116.129]:9709 "EHLO
	webmail.tiscali.de") by vger.kernel.org with ESMTP id S262178AbVBKX44
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 18:56:56 -0500
Message-ID: <420D4646.4010600@tiscali.de>
Date: Sat, 12 Feb 2005 00:56:54 +0100
From: Matthias-Christian Ott <matthias.christian@tiscali.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050108)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nathan Lynch <ntl@pobox.com>
CC: lkml <linux-kernel@vger.kernel.org>, Rusty Russell <rusty@rustcorp.com.au>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6-bk: cpu hotplug + preempt = smp_processor_id warnings galore
References: <20050211232821.GA14499@otto>
In-Reply-To: <20050211232821.GA14499@otto>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan Lynch wrote:

>Hi-
>
>With 2.6.11-rc3-bk7 on ppc64 I am seeing lots of smp_processor_id
>warnings whenever I hotplug cpus:
>
># echo 0 > /sys/devices/system/cpu/cpu1/online 
>cpu 1 (hwid 1) Ready to die...
>BUG: using smp_processor_id() in preemptible [00000001] code:
>ksoftirqd/1/5
>caller is .ksoftirqd+0xbc/0x1f8
>Call Trace:
>[c0000000fffbbce0] [ffffffffffffffff] 0xffffffffffffffff (unreliable)
>[c0000000fffbbd60] [c0000000001c9f1c] .smp_processor_id+0x154/0x168
>[c0000000fffbbe20] [c00000000005f414] .ksoftirqd+0xbc/0x1f8
>[c0000000fffbbed0] [c0000000000764cc] .kthread+0x128/0x134
>[c0000000fffbbf90] [c000000000014248] .kernel_thread+0x4c/0x6c
>
>I believe the above warning is caused by the local_softirq_pending
>call on a "foreign" cpu before ksoftirqd/1 has been stopped.  Looking
>at the code, I think this doesn't indicate a real bug, but it would be
>better if ksoftirqd didn't check local_softirq_pending after it's been
>kicked off its cpu, right?
>
>
># echo 1 > /sys/devices/system/cpu/cpu1/online 
>BUG: using smp_processor_id() in preemptible [00000001] code:
>swapper/0
>caller is .dedicated_idle+0x68/0x22c
>Call Trace:
>[c0000000fffafc50] [ffffffffffffffff] 0xffffffffffffffff (unreliable)
>[c0000000fffafcd0] [c0000000001c9f1c] .smp_processor_id+0x154/0x168
>[c0000000fffafd90] [c00000000000f998] .dedicated_idle+0x68/0x22c
>[c0000000fffafe80] [c00000000000fce8] .cpu_idle+0x34/0x4c
>[c0000000fffaff00] [c00000000003a744] .start_secondary+0x10c/0x150
>[c0000000fffaff90] [c00000000000bd28] .enable_64b_mode+0x0/0x28
>
>Should ppc64 simply use _smp_processor_id() in its idle loop code
>(like i386)?
>
>If I online and offline cpus rapidly enough I can eventually get the
>following:
>
>printk: 49 messages suppressed.
>BUG: using smp_processor_id() in preemptible [00000001] code:
>events/3/1262
>caller is .cache_reap+0x21c/0x2b8
>Call Trace:
>[c0000000ed67bb90] [ffffffffffffffff] 0xffffffffffffffff (unreliable)
>[c0000000ed67bc10] [c0000000001c9f1c] .smp_processor_id+0x154/0x168
>[c0000000ed67bcd0] [c0000000000938e8] .cache_reap+0x21c/0x2b8
>[c0000000ed67bda0] [c00000000006f4bc] .worker_thread+0x230/0x310
>[c0000000ed67bed0] [c0000000000764cc] .kthread+0x128/0x134
>[c0000000ed67bf90] [c000000000014248] .kernel_thread+0x4c/0x6c
>
>And this will repeat over and over even after I stop hotplugging
>cpus...  from the same events thread so I think it's somehow gotten
>"stuck"?
>
>Anything I can do to further debug?
>
>
>Nathan
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>
Hi!
Use get_cpu() (It disables preemption) or __smp_processor_id () (on a smp).

Matthias-Christian Ott
