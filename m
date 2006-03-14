Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932502AbWCNVjU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932502AbWCNVjU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 16:39:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932501AbWCNVjU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 16:39:20 -0500
Received: from xenotime.net ([66.160.160.81]:8622 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932496AbWCNVjT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 16:39:19 -0500
Date: Tue, 14 Mar 2006 13:41:10 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: mingo@elte.hu, rmk+serial@arm.linux.org.uk
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: soft lockup in serial8250_console_write(?)
Message-Id: <20060314134110.3470fc63.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.2 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

(x86_64; 2.6.16-rc6;
serial console configured but nothing connected to the serial port)

I'm seeing an occasional soft lockup, maybe in serial8250_console_write().
(drivers/serial/8250.c)

This function calls wait_for_xmitr() [inline], which in worst case
can spin for 1.010 seconds.  Could this be the cause of a soft lockup?


[  101.448855] BUG: soft lockup detected on CPU#0!
[  101.448858] CPU 0:
[  101.448860] Modules linked in:
[  101.448863] Pid: 1, comm: swapper Not tainted 2.6.16-rc6 #3
[  101.448866] RIP: 0010:[<ffffffff8013009b>] <ffffffff8013009b>{__do_softirq+75}
[  101.448874] RSP: 0000:ffffffff804dc9a8  EFLAGS: 00000206
[  101.448877] RAX: ffff81007f63dfd8 RBX: ffffffff804dc8f8 RCX: 000000000000000a
[  101.448880] RDX: 0000000000000022 RSI: 0000000000000002 RDI: ffff81007f622740
[  101.448883] RBP: ffffffff8010aef0 R08: 0000000000000083 R09: ffff81007f287638
[  101.448886] R10: 0000000000000002 R11: 0000000000000000 R12: ffffffff804dc9c8
[  101.448889] R13: ffffffff80529d00 R14: 0000000000000022 R15: ffffffff8010d34d
[  101.448892] FS:  0000000000000000(0000) GS:ffffffff80529000(0000) knlGS:0000000000000000
[  101.448895] CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
[  101.448898] CR2: 0000000000000000 CR3: 0000000000101000 CR4: 00000000000006e0
[  101.448900] 
[  101.448900] Call Trace: <IRQ> <ffffffff8010bb92>{call_softirq+30}
[  101.448908]        <ffffffff8010d309>{do_softirq+49} <ffffffff8012fe63>{irq_exit+72}
[  101.448915]        <ffffffff80115ab1>{smp_apic_timer_interrupt+75} <ffffffff8010b536>{apic_timer_interrupt+98} <EOI>
[  101.448923]        <ffffffff8028607e>{serial8250_console_write+516} <ffffffff8012add7>{release_console_sem+335}
[  101.448936]        <ffffffff8012b188>{register_console+433} <ffffffff803134cb>{usb_serial_console_init+51}
[  101.448943]        <ffffffff80312556>{usb_serial_probe+3989} <ffffffff8012b8c3>{vprintk+721}
[  101.448956]        <ffffffff803a3bb7>{_spin_unlock_irq+9} <ffffffff8012b93f>{printk+103}
[  101.448964]        <ffffffff8013a084>{call_usermodehelper_keys+274} <ffffffff802f1dc8>{usb_probe_interface+223}
[  101.448975]        <ffffffff8028f1ff>{driver_probe_device+90} <ffffffff8028f35c>{__driver_attach+135}
[  101.448983]        <ffffffff8028f2d5>{__driver_attach+0} <ffffffff8028e726>{bus_for_each_dev+73}
[  101.448990]        <ffffffff8028f094>{driver_attach+28} <ffffffff8028ea48>{bus_add_driver+114}
[  101.448996]        <ffffffff8028f7f9>{driver_register+180} <ffffffff802f1c7a>{usb_register_driver+134}
[  101.449003]        <ffffffff803112e6>{usb_serial_register+570} <ffffffff805550fc>{belkin_sa_init+39}
[  101.449012]        <ffffffff8010820b>{init+451} <ffffffff8010b842>{child_rip+8}
[  101.449020]        <ffffffff80108048>{init+0} <ffffffff8010b83a>{child_rip+0}

---
