Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752212AbWCFNCy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752212AbWCFNCy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 08:02:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752164AbWCFNCy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 08:02:54 -0500
Received: from spirit.analogic.com ([204.178.40.4]:56076 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP
	id S1751951AbWCFNCx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 08:02:53 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <20060305180757.GA22121@deprecation.cyrius.com>
x-originalarrivaltime: 06 Mar 2006 13:02:52.0016 (UTC) FILETIME=[46DA1700:01C6411E]
Content-class: urn:content-classes:message
Subject: Re: de2104x: interrupts before interrupt handler is registered
Date: Mon, 6 Mar 2006 08:02:46 -0500
Message-ID: <Pine.LNX.4.61.0603060752240.20597@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: de2104x: interrupts before interrupt handler is registered
Thread-Index: AcZBHkbh2P2PMm4aRsKtyf26r82jwQ==
References: <20060305180757.GA22121@deprecation.cyrius.com>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Martin Michlmayr" <tbm@cyrius.com>
Cc: "Jeff Garzik" <jgarzik@pobox.com>, <netdev@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 5 Mar 2006, Martin Michlmayr wrote:

> We have three independent reports about problems with de2104x involving
> interrupts.  Alan Stern suggested that it "sure looks as though the
> ethernet interface is generating an interrupt request before the
> de2104x driver has registered its interrupt handler".
>
> The three reports are:
> - de2104x does not work (non-fatal oops) when uhci_hcd is loaded
>   first.  http://lkml.org/lkml/2006/2/3/402  The problem does not
>   occur under 2.4 with the tulip module, so this is a regression.
> - fatal de2104x interrupt oops (without uhci_hcd).
>   http://lkml.org/lkml/2006/2/5/64
> - "kernel panic after the first transmission attempt times out"
>   Regression from 2.4.  http://bugs.debian.org/288821
>
> I have a system on which I can reproduce this bug 100%.  While I have
> no idea how to fix the issue, I can provide debugging information and
> test a fix.  However, I'm (temporarily) leaving the country in three
> weeks and won't have access to this PC for several months, so it would
> be great if someone could look into this soon.  Jeff?
>
>
> 1)
> eth0: enabling interface
> eth0: set link 10baseT auto
> eth0:    mode 0x7ffc0040, sia 0x10c4,0xffffef01,0xffffffff,0xffff0008
> eth0:    set mode 0x7ffc0040, set sia 0xef01,0xffff,0x8
> irq 10: nobody cared (try booting with the "irqpoll" option)
> [<c012f89e>] __report_bad_irq+0x31/0x73
> [<c012f96d>] note_interrupt+0x75/0x98
> [<c012f46a>] __do_IRQ+0x67/0x91
> [<c0104fc1>] do_IRQ+0x19/0x24
> [<c0103afa>] common_interrupt+0x1a/0x20
> [<c0119a1c>] __do_softirq+0x2c/0x7d
> [<c0119a8f>] do_softirq+0x22/0x26
> [<c0104fc6>] do_IRQ+0x1e/0x24
> [<c0103afa>] common_interrupt+0x1a/0x20
> [<c481da07>] de_set_rx_mode+0xf/0x12 [de2104x]
> [<c481e2c1>] de_init_hw+0x6d/0x76 [de2104x]
> [<c481e59e>] de_open+0x64/0xe4 [de2104x]
> [<c0225a5f>] dev_open+0x30/0x66
> [<c0226a9a>] dev_change_flags+0x4d/0xf0
> [<c025d301>] devinet_ioctl+0x224/0x4bd
> [<c0155541>] do_ioctl+0x21/0x50
> [<c0155774>] vfs_ioctl+0x152/0x161
> [<c01557cb>] sys_ioctl+0x48/0x65
> [<c0102a99>] syscall_call+0x7/0xb
> handlers:
> [<c4890d97>] (usb_hcd_irq+0x0/0x56 [usbcore])
> Disabling IRQ #10
>
> 3)
> eth0:    mode 0x7ffc0040, sia 0x10c4,0xffffef01,0xffffffff,0xffff0008
> eth0:    set mode 0x7ffc0040, set sia 0xef01,0xffff,0x8
> [__report_bad_irq+42/144] __report_bad_irq+0x2a/0x90
> [note_interrupt+108/160] note_interrupt+0x6c/0xa0
> [do_IRQ+289/304] do_IRQ+0x121/0x130
> [common_interrupt+24/32] common_interrupt+0x18/0x20
> [__do_softirq+48/128] __do_softirq+0x30/0x80
> [acpi_irq+0/22] acpi_irq+0x0/0x16
> [do_softirq+38/48] do_softirq+0x26/0x30
> [do_IRQ+253/304] do_IRQ+0xfd/0x130
> [common_interrupt+24/32] common_interrupt+0x18/0x20
> [__crc_do_softirq+25311/208152] de_set_rx_mode+0x26/0x50 [de2104x]
> [__crc_do_softirq+28277/208152] de_init_hw+0x8c/0x90 [de2104x]
> [__crc_do_softirq+29105/208152] de_open+0x68/0x140 [de2104x]
> [profile_hook+45/75] profile_hook+0x2d/0x4b
> [dev_open+203/256] dev_open+0xcb/0x100
> [dev_mc_upload+36/80] dev_mc_upload+0x24/0x50
> [dev_change_flags+81/288] dev_change_flags+0x51/0x120
> [devinet_ioctl+582/1424] devinet_ioctl+0x246/0x590
> [inet_ioctl+94/160] inet_ioctl+0x5e/0xa0
> [sock_ioctl+249/688] sock_ioctl+0xf9/0x2b0
> [sys_ioctl+269/656] sys_ioctl+0x10d/0x290
> [syscall_call+7/11] syscall_call+0x7/0xb
> eth0: link up, media 10baseT auto
>
> --
> Martin Michlmayr
> http://www.cyrius.com/
> -

This started to happen in a lot of PCI drivers once it became
necessary to call pci_enable_device() in order to make the
returned IRQ values valid. This has been reported numerious
times and has not been fixed. Basically, in order to get
the correct value, one needs to disable the board in some
unspecified way so it is not possible for it to generate
an interrupt before enabling the board. With some devices
this may not be possible!

Cheers,
Dick Johnson
Penguin : Linux version 2.6.15.4 on an i686 machine (5589.47 BogoMips).
Warning : 98.36% of all statistics are fiction, book release in April.
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
