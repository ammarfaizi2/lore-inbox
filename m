Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261821AbUJYNsX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261821AbUJYNsX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 09:48:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261828AbUJYNsW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 09:48:22 -0400
Received: from pop.gmx.net ([213.165.64.20]:31408 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261821AbUJYNqp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 09:46:45 -0400
X-Authenticated: #4399952
Date: Mon, 25 Oct 2004 16:03:30 +0200
From: Florian Schmidt <mista.tapas@gmx.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: "K.R. Foley" <kr@cybsft.com>, linux-kernel@vger.kernel.org,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Mark_H_Johnson@Raytheon.com, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Alexander Batyrshin <abatyrshin@ru.mvista.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0
Message-ID: <20041025160330.394e9071@mango.fruits.de>
In-Reply-To: <20041025132605.GA9516@elte.hu>
References: <20041020094508.GA29080@elte.hu>
	<20041021132717.GA29153@elte.hu>
	<20041022133551.GA6954@elte.hu>
	<20041022155048.GA16240@elte.hu>
	<20041022175633.GA1864@elte.hu>
	<20041025104023.GA1960@elte.hu>
	<417CDE90.6040201@cybsft.com>
	<20041025111046.GA3630@elte.hu>
	<20041025121210.GA6555@elte.hu>
	<20041025152458.3e62120a@mango.fruits.de>
	<20041025132605.GA9516@elte.hu>
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Oct 2004 15:26:05 +0200
Ingo Molnar <mingo@elte.hu> wrote:

> does the patch below fix this?

looks like it. they didn't show on first boot of the new kernel with patch
applied. 

Btw: i still experience some "pauses". They are different now though. It
seems i can trigger them by reloading a page in mozilla (not always). This
BUG definetly looks related. Dunno, when exactly it happened (related to
what i did at that moment), but it's the only one in dmesg output on this
bootup. Each of the pauses is accompanied by a high cpu usage of ksoftirqd.
I cannot retrigger the BUG though.

mozilla-bin/763: BUG in futex_wait at kernel/futex.c:542
 [<c0132962>] futex_wait+0x192/0x1a0 (12)
 [<c0131c55>] sub_preempt_count+0x65/0xd0 (64)
 [<c01ef17b>] __up_write+0x13b/0x320 (8)
 [<c0131788>] check_preempt_timing+0x58/0x290 (8)
 [<c0131c55>] sub_preempt_count+0x65/0xd0 (4)
 [<c01ef17b>] __up_write+0x13b/0x320 (4)
 [<c02b94d3>] down_read+0xd3/0x2b0 (8)
 [<c0131c55>] sub_preempt_count+0x65/0xd0 (4)
 [<c01eef11>] up_read+0x111/0x240 (8)
 [<c0131788>] check_preempt_timing+0x58/0x290 (8)
 [<c0131c55>] sub_preempt_count+0x65/0xd0 (4)
 [<c01eef11>] up_read+0x111/0x240 (4)
 [<c0115f60>] default_wake_function+0x0/0x20 (104)
 [<c0115f60>] default_wake_function+0x0/0x20 (32)
 [<c0132c17>] do_futex+0x47/0xa0 (40)
 [<c0132d60>] sys_futex+0xf0/0x100 (40)
 [<c010617b>] syscall_call+0x7/0xb (68)
preempt count: 00000001
. 1-level deep critical section nesting:
.. entry 1: print_traces+0x17/0x90 [<c0131fc7>] / (dump_stack+0x23/0x30 [<c0106733>])

Here's the syslog entry:

Oct 25 15:56:31 mango kernel: mozilla-bin/763: BUG in futex_wait at kernel/futex.c:542
Oct 25 15:56:31 mango kernel:  [futex_requeue+162/608] futex_wait+0x192/0x1a0 (12)
Oct 25 15:56:31 mango kernel:  [print_name_offset+149/160] sub_preempt_count+0x65/0xd0 (64)
Oct 25 15:56:31 mango kernel:  [zlib_inflateReset+43/128] __up_write+0x13b/0x320 (8)
Oct 25 15:56:31 mango kernel:  [kfifo_alloc+216/240] check_preempt_timing+0x58/0x290 (8)
Oct 25 15:56:31 mango kernel:  [print_name_offset+149/160] sub_preempt_count+0x65/0xd0 (4)
Oct 25 15:56:31 mango kernel:  [zlib_inflateReset+43/128] __up_write+0x13b/0x320 (4)
Oct 25 15:56:31 mango kernel:  [__func__.0+318/987] down_read+0xd3/0x2b0 (8)
Oct 25 15:56:31 mango kernel:  [print_name_offset+149/160] sub_preempt_count+0x65/0xd0 (4)
Oct 25 15:56:31 mango kernel:  [zlib_inflate_fast+465/1024] up_read+0x111/0x240 (8)
Oct 25 15:56:31 mango kernel:  [kfifo_alloc+216/240] check_preempt_timing+0x58/0x290 (8)
Oct 25 15:56:31 mango kernel:  [print_name_offset+149/160] sub_preempt_count+0x65/0xd0 (4)
Oct 25 15:56:31 mango kernel:  [zlib_inflate_fast+465/1024] up_read+0x111/0x240 (4)
Oct 25 15:56:31 mango kernel:  [wake_up_process+32/48] default_wake_function+0x0/0x20 (104)
Oct 25 15:56:31 mango kernel:  [wake_up_process+32/48] default_wake_function+0x0/0x20 (32)
Oct 25 15:56:31 mango kernel:  [unqueue_me+103/256] do_futex+0x47/0xa0 (40)
Oct 25 15:56:31 mango kernel:  [futex_wait+176/400] sys_futex+0xf0/0x100 (40)
Oct 25 15:56:31 mango kernel:  [irq_entries_start+107/128] syscall_call+0x7/0xb (68)
Oct 25 15:56:31 mango kernel: preempt count: 00000001
Oct 25 15:56:31 mango kernel: . 1-level deep critical section nesting:
Oct 25 15:56:31 mango kernel: .. entry 1: print_traces+0x17/0x90 [update_max_trace+23/160] / (dump_stack+0x23/0x30 [show_registers+131/464])
