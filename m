Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264639AbUFVUMK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264639AbUFVUMK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 16:12:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265482AbUFVUKb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 16:10:31 -0400
Received: from gw01.mail.saunalahti.fi ([195.197.172.115]:10456 "EHLO
	gw01.mail.saunalahti.fi") by vger.kernel.org with ESMTP
	id S265484AbUFVTdK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 15:33:10 -0400
Date: Tue, 22 Jun 2004 22:29:42 +0300
From: Anssi Saari <as@sci.fi>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: booting 2.6.7 hangs with IRQ handling problems
Message-ID: <20040622192942.GA15367@sci.fi>
Mail-Followup-To: Anssi Saari <as@sci.fi>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

On my home PC I have an AMD Athlon XP 1900+ on an Aopen AK77-600Max
motherboard, VIA KT600 chipset. It works fine with Linux 2.6.6, apart
from the apparently nonexistent support for PATA devices on the Promise
PDC20378, but I can't boot 2.6.7. I've tried vanilla 2.6.7, 2.6.7 with
acpi-20040326 patch and 2.6.7-bk4. acpi=off, noapic or nolapic don't
seem to help.

I captured the boot messages with the serial console, the full log is at
http://www.sci.fi/~as/linux_2.6.7_boot_hang.  Looking through the log,
things seem go fine for a while, until after the cmd64x module loads.
(Putting cmd64x in the kernel didn't help). Then I get this:

irq 10: nobody cared!
 [<c0105ac9>] dump_stack+0x19/0x20
 [<c0106c93>] __report_bad_irq+0x33/0x90
 [<c0106d70>] note_interrupt+0x50/0x80
 [<c0106f89>] do_IRQ+0xa9/0x130
 [<c0105684>] common_interrupt+0x18/0x20
 [<c011cbe5>] do_softirq+0x25/0x30
 [<c0106ff1>] do_IRQ+0x111/0x130
 [<c0105684>] common_interrupt+0x18/0x20
 [<c01070d9>] request_irq+0x89/0xb0
 [<c020b007>] init_irq+0x257/0x430
 [<c020b5d8>] hwif_init+0x108/0x270
 [<c020ac04>] probe_hwif_init+0x14/0x60
 [<c020deec>] ide_setup_pci_device+0x3c/0x70
 [<f983e3d0>] cmd64x_init_one+0x20/0x30 [cmd64x]
 [<c01aeb0d>] pci_device_probe_static+0x2d/0x50
 [<c01aeb50>] __pci_device_probe+0x20/0x40
 [<c01aeb8e>] pci_device_probe+0x1e/0x40
 [<c01f3c42>] bus_match+0x32/0x60
 [<c01f3d40>] driver_attach+0x40/0x80
 [<c01f3fe5>] bus_add_driver+0x85/0xb0
 [<c01f4416>] driver_register+0x36/0x40
 [<c01aeda6>] pci_register_driver+0x56/0x80
 [<c020e026>] ide_pci_register_driver+0x36/0x50
 [<f983e3ed>] cmd64x_ide_init+0xd/0x14 [cmd64x]
 [<c012d3c8>] sys_init_module+0x118/0x240
 [<c0104d17>] syscall_call+0x7/0xb
handlers:
[<c0207cb0>] (ide_intr+0x0/0x180)
Disabling IRQ #10
ide2 at 0xb400-0xb407,0xb802 on irq 10
hde: max request size: 128KiB
irq 10: nobody cared!

This kind of thing goes on for a while, normal boot messages are in
there too, until finally:

Debug: sleeping function called from invalid context at arch/i386/lib/usercopy.c:597
in_atomic():1, irqs_disabled():0
 [<c0105ac9>] dump_stack+0x19/0x20
 [<c01172e6>] __might_sleep+0xa6/0xb0
 [<c01ab6ca>] copy_to_user+0x1a/0x50
 [<c011c4c5>] sys_gettimeofday+0x25/0x60
 [<c0104d17>] syscall_call+0x7/0xb
bad: scheduling while atomic!
 [<c0105ac9>] dump_stack+0x19/0x20
 [<c02890ac>] schedule+0x3c/0x430
 [<c0104d3e>] work_resched+0x5/0x16
bad: scheduling while atomic!
 [<c0105ac9>] dump_stack+0x19/0x20
 [<c02890ac>] schedule+0x3c/0x430
 [<c0116e11>] sys_sched_yield+0x41/0x50
 [<c0289897>] yield+0x17/0x20
 [<c0155c18>] coredump_wait+0x48/0xb0
 [<c0155d54>] do_coredump+0xd4/0x1dd
 [<c0122cda>] get_signal_to_deliver+0x2ba/0x330
 [<c0104ac0>] do_signal+0x50/0xd0
 [<c0104b70>] do_notify_resume+0x30/0x48
 [<c0104d62>] work_notifysig+0x13/0x15
Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing



