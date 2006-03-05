Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750778AbWCESIQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750778AbWCESIQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 13:08:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750797AbWCESIQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 13:08:16 -0500
Received: from sorrow.cyrius.com ([65.19.161.204]:24590 "EHLO
	sorrow.cyrius.com") by vger.kernel.org with ESMTP id S1750778AbWCESIP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 13:08:15 -0500
Date: Sun, 5 Mar 2006 18:07:57 +0000
From: Martin Michlmayr <tbm@cyrius.com>
To: Jeff Garzik <jgarzik@pobox.com>, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: de2104x: interrupts before interrupt handler is registered
Message-ID: <20060305180757.GA22121@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We have three independent reports about problems with de2104x involving
interrupts.  Alan Stern suggested that it "sure looks as though the
ethernet interface is generating an interrupt request before the
de2104x driver has registered its interrupt handler".

The three reports are:
 - de2104x does not work (non-fatal oops) when uhci_hcd is loaded
   first.  http://lkml.org/lkml/2006/2/3/402  The problem does not
   occur under 2.4 with the tulip module, so this is a regression.
 - fatal de2104x interrupt oops (without uhci_hcd).
   http://lkml.org/lkml/2006/2/5/64
 - "kernel panic after the first transmission attempt times out"
   Regression from 2.4.  http://bugs.debian.org/288821

I have a system on which I can reproduce this bug 100%.  While I have
no idea how to fix the issue, I can provide debugging information and
test a fix.  However, I'm (temporarily) leaving the country in three
weeks and won't have access to this PC for several months, so it would
be great if someone could look into this soon.  Jeff?


1)
eth0: enabling interface
eth0: set link 10baseT auto
eth0:    mode 0x7ffc0040, sia 0x10c4,0xffffef01,0xffffffff,0xffff0008
eth0:    set mode 0x7ffc0040, set sia 0xef01,0xffff,0x8
irq 10: nobody cared (try booting with the "irqpoll" option)
 [<c012f89e>] __report_bad_irq+0x31/0x73
 [<c012f96d>] note_interrupt+0x75/0x98
 [<c012f46a>] __do_IRQ+0x67/0x91
 [<c0104fc1>] do_IRQ+0x19/0x24
 [<c0103afa>] common_interrupt+0x1a/0x20
 [<c0119a1c>] __do_softirq+0x2c/0x7d
 [<c0119a8f>] do_softirq+0x22/0x26
 [<c0104fc6>] do_IRQ+0x1e/0x24
 [<c0103afa>] common_interrupt+0x1a/0x20
 [<c481da07>] de_set_rx_mode+0xf/0x12 [de2104x]
 [<c481e2c1>] de_init_hw+0x6d/0x76 [de2104x]
 [<c481e59e>] de_open+0x64/0xe4 [de2104x]
 [<c0225a5f>] dev_open+0x30/0x66
 [<c0226a9a>] dev_change_flags+0x4d/0xf0
 [<c025d301>] devinet_ioctl+0x224/0x4bd
 [<c0155541>] do_ioctl+0x21/0x50
 [<c0155774>] vfs_ioctl+0x152/0x161
 [<c01557cb>] sys_ioctl+0x48/0x65
 [<c0102a99>] syscall_call+0x7/0xb
handlers:
[<c4890d97>] (usb_hcd_irq+0x0/0x56 [usbcore])
Disabling IRQ #10

3)
eth0:    mode 0x7ffc0040, sia 0x10c4,0xffffef01,0xffffffff,0xffff0008
eth0:    set mode 0x7ffc0040, set sia 0xef01,0xffff,0x8
 [__report_bad_irq+42/144] __report_bad_irq+0x2a/0x90
 [note_interrupt+108/160] note_interrupt+0x6c/0xa0
 [do_IRQ+289/304] do_IRQ+0x121/0x130
 [common_interrupt+24/32] common_interrupt+0x18/0x20
 [__do_softirq+48/128] __do_softirq+0x30/0x80
 [acpi_irq+0/22] acpi_irq+0x0/0x16
 [do_softirq+38/48] do_softirq+0x26/0x30
 [do_IRQ+253/304] do_IRQ+0xfd/0x130
 [common_interrupt+24/32] common_interrupt+0x18/0x20
 [__crc_do_softirq+25311/208152] de_set_rx_mode+0x26/0x50 [de2104x]
 [__crc_do_softirq+28277/208152] de_init_hw+0x8c/0x90 [de2104x]
 [__crc_do_softirq+29105/208152] de_open+0x68/0x140 [de2104x]
 [profile_hook+45/75] profile_hook+0x2d/0x4b
 [dev_open+203/256] dev_open+0xcb/0x100
 [dev_mc_upload+36/80] dev_mc_upload+0x24/0x50
 [dev_change_flags+81/288] dev_change_flags+0x51/0x120
 [devinet_ioctl+582/1424] devinet_ioctl+0x246/0x590
 [inet_ioctl+94/160] inet_ioctl+0x5e/0xa0
 [sock_ioctl+249/688] sock_ioctl+0xf9/0x2b0
 [sys_ioctl+269/656] sys_ioctl+0x10d/0x290
 [syscall_call+7/11] syscall_call+0x7/0xb
eth0: link up, media 10baseT auto

-- 
Martin Michlmayr
http://www.cyrius.com/
