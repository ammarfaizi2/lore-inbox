Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261153AbUJWMdS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261153AbUJWMdS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 08:33:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261156AbUJWMdR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 08:33:17 -0400
Received: from smtp1.netcabo.pt ([212.113.174.28]:48606 "EHLO
	exch01smtp09.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S261153AbUJWMcs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 08:32:48 -0400
Message-ID: <32880.192.168.1.5.1098534617.squirrel@192.168.1.5>
In-Reply-To: <20041023102909.GD30270@elte.hu>
References: <20041016153344.GA16766@elte.hu> <20041018145008.GA25707@elte.hu>
    <20041019124605.GA28896@elte.hu> <20041019180059.GA23113@elte.hu>
    <20041020094508.GA29080@elte.hu> <20041021132717.GA29153@elte.hu>
    <20041022133551.GA6954@elte.hu> <20041022155048.GA16240@elte.hu>
    <20041022175633.GA1864@elte.hu>
    <32871.192.168.1.5.1098491242.squirrel@192.168.1.5>
    <20041023102909.GD30270@elte.hu>
Date: Sat, 23 Oct 2004 13:30:17 +0100 (WEST)
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-U10.2
From: "Rui Nuno Capela" <rncbc@rncbc.org>
To: "Ingo Molnar" <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, "Lee Revell" <rlrevell@joe-job.com>,
       mark_h_johnson@raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       "Bill Huey" <bhuey@lnxw.com>, "Adam Heath" <doogie@debian.org>,
       "Florian Schmidt" <mista.tapas@gmx.net>,
       "Thomas Gleixner" <tglx@linutronix.de>,
       "Michal Schmidt" <xschmi00@stud.feec.vutbr.cz>,
       "Fernando Pablo Lopez-Lezcano" <nando@ccrma.stanford.edu>,
       "Alexander Batyrshin" <abatyrshin@ru.mvista.com>
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
X-OriginalArrivalTime: 23 Oct 2004 12:32:45.0389 (UTC) FILETIME=[65E36FD0:01C4B8FC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
>
> Rui Nuno Capela wrote:
>
>> Regarding the jackd -R issue, I was trying to capture some debug data
>> via netconsole on my laptop (P4/UP) running RT-U10.2, and when the
>> system freezes as reported before, I was able to kick the SysRq+T.
>> But, instead of a task trace list, I get the following:
>>
>> SysRq : <3>BUG: sleeping function called from invalid context IRQ 1(776)
>> at kernel/mutex.c:37
>> in_atomic():1 [00000001], irqs_disabled():1
>>  [<c0104ee4>] dump_stack+0x1e/0x20 (20)
>>  [<c0114a23>] __might_sleep+0xb2/0xc7 (36)
>>  [<c012c0f2>] _mutex_lock+0x39/0x5e (28)
>
>> preempt count: 00000002
>> . 2-level deep critical section nesting:
>> .. entry 1: __sysrq_lock_table+0x12/0x14 [<c01f482b>] /
>> (__handle_sysrq+0x1a/0xed [<c01f482b>])
>> .. entry 2: print_traces+0x16/0x48 [<c0104ee4>] / (dump_stack+0x1e/0x20
>
> does the patch below help?
>
> 	Ingo
>
> --- linux/drivers/char/sysrq.c.orig
> +++ linux/drivers/char/sysrq.c
> @@ -252,7 +252,7 @@ static struct sysrq_key_op sysrq_kill_op
>
>
>  /* Key Operations table and lock */
> -static DECLARE_RAW_SPINLOCK(sysrq_key_table_lock);
> +static DECLARE_SPINLOCK(sysrq_key_table_lock);
>  #define SYSRQ_KEY_TABLE_LENGTH 36
>  static struct sysrq_key_op *sysrq_key_table[SYSRQ_KEY_TABLE_LENGTH] = {
>  /* 0 */	&sysrq_loglevel_op,
>

Nope. Same result:

SysRq : <3>BUG: sleeping function called from invalid context IRQ 1(776)
at kernel/mutex.c:37
in_atomic():0 [00000000], irqs_disabled():1
 [<c0104ee4>] dump_stack+0x1e/0x20 (20)
 [<c0114a23>] __might_sleep+0xb2/0xc7 (36)
 [<c012c0f2>] _mutex_lock+0x39/0x5e (28)
 [<c012c13a>] _mutex_lock_irqsave+0x11/0x15 (12)
 [<c027f913>] refill_skbs+0x13/0x6d (20)
 [<c027fa38>] find_skb+0x5d/0x9d (24)
 [<c027fb60>] netpoll_send_udp+0x3b/0x298 (48)
 [<e0136047>] write_msg+0x47/0x5c [netconsole] (36)
 [<c0117804>] __call_console_drivers+0x51/0x60 (32)
 [<c0117910>] call_console_drivers+0x6d/0x147 (40)
 [<c0117caf>] release_console_sem+0x48/0x100 (36)
 [<c0117bd5>] vprintk+0x127/0x174 (36)
 [<c0117aac>] printk+0x18/0x1a (16)
 [<c01f4835>] __handle_sysrq+0x38/0xed (40)
 [<c01ee426>] kbd_event+0xeb/0xfa (40)
 [<c025f694>] input_event+0x160/0x3d4 (44)
 [<c02620a2>] atkbd_report_key+0x3b/0x95 (32)
 [<c0262358>] atkbd_interrupt+0x25c/0x590 (60)
 [<c01f6fbe>] serio_interrupt+0x4f/0xa5 (44)
 [<c01f78b7>] i8042_interrupt+0xb8/0x1b8 (40)
 [<c0131dbc>] handle_IRQ_event+0x48/0x79 (32)
 [<c01325dd>] do_hardirq+0x86/0x123 (40)
 [<c0132712>] do_irqd+0x98/0xc9 (36)
 [<c012b7d7>] kthread+0x9c/0xc9 (48)
 [<c0102305>] kernel_thread_helper+0x5/0xb (548454420)
preempt count: 00000001
. 1-level deep critical section nesting:
.. entry 1: print_traces+0x16/0x48 [<c0104ee4>] / (dump_stack+0x1e/0x20
[<c0104ee4>])


Bye.
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org

