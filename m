Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261508AbUKBUCN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261508AbUKBUCN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 15:02:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261663AbUKBUAX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 15:00:23 -0500
Received: from mx2.elte.hu ([157.181.151.9]:42113 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261795AbUKBT6B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 14:58:01 -0500
Date: Tue, 2 Nov 2004 20:49:15 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Mark_H_Johnson@raytheon.com
Cc: Thomas Gleixner <tglx@linutronix.de>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Lee Revell <rlrevell@joe-job.com>,
       Paul Davis <paul@linuxaudiosystems.com>,
       LKML <linux-kernel@vger.kernel.org>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       jackit-devel <jackit-devel@lists.sourceforge.net>,
       Rui Nuno Capela <rncbc@rncbc.org>, "K.R. Foley" <kr@cybsft.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.6.8
Message-ID: <20041102194915.GC3053@elte.hu>
References: <OF7B340ED3.3EE1B145-ON86256F40.005675F6-86256F40.005676E0@raytheon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF7B340ED3.3EE1B145-ON86256F40.005675F6-86256F40.005676E0@raytheon.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Mark_H_Johnson@raytheon.com <Mark_H_Johnson@raytheon.com> wrote:

> NMI Watchdog detected LOCKUP
> Pid: 3933, comm:             cpu_burn
> EIP: 0073:[<08048340>] CPU: 0
> EIP is at 0x8048340
>  ESP: 007b:bffffa40 EFLAGS: 00200282    Not tainted  
> (2.6.9-mm1-RT-V0.6.7)
> EAX: 00000000 EBX: 00711ffc ECX: bffffadc EDX: bffffad4
> ESI: 00000001 EDI: 007140fc EBP: bffffa48 DS: 007b ES: 007b
> CR0: 8005003b CR2: 00681400 CR3: 015735e0 CR4: 000006f0
>  [<c0105bec>] show_regs+0x14c/0x174 (36)
>  [<c0115f4f>] nmi_watchdog_tick+0x12f/0x140 (28)
>  [<c0109c0c>] default_do_nmi+0x6c/0x110 (96)
>  [<c0109d2d>] do_nmi+0x6d/0x70 (24)
>  [<c0108735>] nmi_stack_correct+0x1e/0x2e (-196314476)

hm, this one is an extremely weird deadlock - the NMI watchdog detected
a _user-space_ deadlock - i.e. the "cpu_burn" user-space code disabled
interrupts for more than ~5 seconds? Sounds quite unlikely and the
EFLAGS register also directly contradicts it, it has 0x200 set so
interrupts are enabled! The only other way for the NMI watchdog to
trigger is if for whatever reason the local APIC timer interrupts are
not getting through and the NMI ticks (which come via a different
interrupt pin) get through.

this is what's happening on the other CPU:

>  [<c0109b5f>] die_nmi+0x5f/0xa0 (24)
>  [<c0115f0f>] nmi_watchdog_tick+0xef/0x140 (28)
>  [<c0109c0c>] default_do_nmi+0x6c/0x110 (96)
>  [<c0109d2d>] do_nmi+0x6d/0x70 (24)
>  [<c0108735>] nmi_stack_correct+0x1e/0x2e (116)
>  [<c013bfed>] __mcount+0x1d/0x30 (16)
>  [<c0114fd8>] mcount+0x14/0x18 (20)
>  [<c0326a81>] _spin_lock+0x11/0x70 (20)
>  [<c01e2308>] _down_write_trylock+0x58/0x290 (52)
>  [<c01e3325>] down_trylock+0x45/0x180 (52)
>  [<c0123f95>] vprintk+0xf5/0x170 (36)
>  [<c0123e8d>] printk+0x1d/0x30 (16)
>  [<c0108945>] show_trace+0x95/0xe0 (32)
>  [<c0108a63>] dump_stack+0x23/0x30 (20)
>  [<c013c98e>] check_preempt_timing+0x16e/0x300 (76)
>  [<c013ce7f>] sub_preempt_count+0x7f/0xf0 (32)
>  [<c01147ba>] flush_tlb_mm+0x5a/0x110 (36)

flush_tlb_mm sends an IPI to the other CPU - maybe there's a connection.

	Ingo
