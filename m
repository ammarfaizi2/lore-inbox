Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267945AbUJDKa6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267945AbUJDKa6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 06:30:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267939AbUJDKa6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 06:30:58 -0400
Received: from vs-kg003.ocn.ad.jp ([210.232.239.81]:21493 "EHLO
	vs-kg003.ocn.ad.jp") by vger.kernel.org with ESMTP id S267945AbUJDKaa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 06:30:30 -0400
From: Jason Stubbs <jstubbs@work-at.co.jp>
Organization: Work@ Inc
To: Andrew Morton <akpm@osdl.org>
Subject: Re: PROBLEM: Consistent lock up on >=2.6.8
Date: Mon, 4 Oct 2004 19:31:00 +0900
User-Agent: KMail/1.7
Cc: linux-kernel@vger.kernel.org
References: <200410041611.17000.jstubbs@work-at.co.jp> <20041004013548.26e853fc.akpm@osdl.org>
In-Reply-To: <20041004013548.26e853fc.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410041931.00159.jstubbs@work-at.co.jp>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 04 October 2004 17:35, Andrew Morton wrote:
> Jason Stubbs <jstubbs@work-at.co.jp> wrote:
> >  Pid: 22433, comm:              openssl
> >  EIP: 0060:[<c02d5082>] CPU: 0
> >  EIP is at _spin_lock+0xa/0x13
> >   EFLAGS: 00000286    Not tainted  (2.6.9-rc3)
> >  EAX: c03b2500 EBX: 00000000 ECX: x031ca80 EDX: 00000000
> >  ESI: f8b9c926 EDI: ffffffff EBP: c03e1f44 DS: 007b ES: 007b
> >  CR0: 8005003b CR2: b7df91df CR3: 3705c000 CR4: 000006d0
>
> Looks like a locking bug.
>
> >  Stack pointer is garbage, not printing trace
>
> Sigh.  That's exactly the info we wanted.  Please try 2.6.9-rc3-mm1 which
> should have that fixed.  Or wait 15 minutes for 2.6.9-rc3-mm2.
>
> Then do the sysrq-P trace again.  You may need to type it a few times.  If
> you manage to get a backtrace of the process which is stuck in spin_lock,
> that's the info we want.

Had to switch to 60-line console to get it but still missing a single line by 
the look of it. Here's what I got:

EIP: 0060:[<c02de1c6>] CPU: 0
EIP is at _spin_lock+0x1b/0x46
 EFLAGS: 00000286    Not tainted  (2.6.9-rc3-mm2)
EAX: c03b5480 EBX: c03b5480 ECX: c0326c80 EDX: 00000000
ESI: f8b9c9fe EDI: ffffffff EBP: c03e4f44 DS: 007b ES: 007b
CR0: 8005003b CR2: b7f1f1df CR3: 36e2c000 CR4: 000006d0
 [<c0219ea6>] __handle_sysrq+0x64/0xd6
 [<c02144ae>] kbd_event+0x8a/0xda
 [<c0268f56>] input_event+0xd2/0x3ac
 [<c026b5ab>] atkbd_report_key+0x2f/0x71
 [<c026b7d5>] atkbd_interrupt+0x1e8/0x500
 [<c021acaa>] serio_interrupt+0x43/0x8e
 [<c021b26d>] i8042_interrupt+0xa6/0x166
 [<c0133a9c>] handle_IRQ_event+0x29/0x5c
 [<c0133bb7>] __do_IRQ+0xe8/0x131
 [<c0106199>] do_IRQ+0x51/0x78
 [<c01048a4>] common_interrupt+0x18/0x20
 [<c0157630>] nr_blockdev_pages+0x10/0x51
 [<f8b9c7ea>] update_defense_level+0x16/0x22a [ip_vs]
 [<f8b9ca06>] defense_timer_handler+0x8/0x2f [ip_vs]
 [<c0123216>] run_timer_softirq+0xd4/0x17d
 [<c011f84d>] __do_softirq+0xb9/0xcb
 [<c01062ab>] do_softirq+0x4f/0x5e
 [<c010eeb7>] smp_apic_timer_interrupt+0x64/0xd0
 [<c0104926>] apic_timer_interrupt+0x1a/0x20
 [<c0139456>] si_meminfo+0x22/0x3f
 [<c017ac5a>] meminfo_read_proc+0x4a/0x22e
 [<c0178bf0>] proc_file_read+0xae/0x203
 [<c01506dd>] vfs_read+0x9d/0xeb
 [<c015091e>] sys_read+0x41/0x6b
 [<c0103ee5>] sysenter_past_esp+0x52/0x71
========================
 [<c0219ea6>] __handle_sysrq+0x64/0xd6
 [<c02144ae>] kbd_event+0x8a/0xda
 [<c0268f56>] input_event+0xd2/0x3ac
 [<c026b5ab>] atkbd_report_key+0x2f/0x71
 [<c026b7d5>] atkbd_interrupt+0x1e8/0x500
 [<c021acaa>] serio_interrupt+0x43/0x8e
 [<c021b26d>] i8042_interrupt+0xa6/0x166
 [<c0133a9c>] handle_IRQ_event+0x29/0x5c
 [<c0133bb7>] __do_IRQ+0xe8/0x131
 [<c0106199>] do_IRQ+0x51/0x78
 [<c01048a4>] common_interrupt+0x18/0x20
 [<c0157630>] nr_blockdev_pages+0x10/0x51
 [<f8b9c7ea>] update_defense_level+0x16/0x22a [ip_vs]
 [<f8b9ca06>] defense_timer_handler+0x8/0x2f [ip_vs]
 [<c0123216>] run_timer_softirq+0xd4/0x17d
 [<c011f84d>] __do_softirq+0xb9/0xcb
 [<c01062ab>] do_softirq+0x4f/0x5e
 [<c010eeb7>] smp_apic_timer_interrupt+0x64/0xd0
 [<c0104926>] apic_timer_interrupt+0x1a/0x20
 [<c0139456>] si_meminfo+0x22/0x3f
 [<c017ac5a>] meminfo_read_proc+0x4a/0x22e
 [<c0178bf0>] proc_file_read+0xae/0x203
 [<c01506dd>] vfs_read+0x9d/0xeb
 [<c015091e>] sys_read+0x41/0x6b
 [<c0103ee5>] sysenter_past_esp+0x52/0x71

Repeatedly doing sysrq+p produces the same except for the following:

EIP: 0060:[<c02de1c9>] CPU: 0
EIP is at _spin_lock+0x1e/0x46

> You may find that all CPUs are stuck in spin_lock().  If so, please send
> each CPU's backtrace.  If you have to type it all in, don't worry about the
> eight-digit hex numbers.

Xeon with HT, but HT is disabled at the moment.

Regards,
Jason Stubbs
