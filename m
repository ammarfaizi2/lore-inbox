Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750828AbVKLAwP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750828AbVKLAwP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 19:52:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750830AbVKLAwP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 19:52:15 -0500
Received: from smtp.osdl.org ([65.172.181.4]:48093 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750828AbVKLAwO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 19:52:14 -0500
Date: Fri, 11 Nov 2005 16:51:56 -0800
From: Andrew Morton <akpm@osdl.org>
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-mm1
Message-Id: <20051111165156.05391fef.akpm@osdl.org>
In-Reply-To: <6bffcb0e0511111631h52ff73e1q@mail.gmail.com>
References: <20051106182447.5f571a46.akpm@osdl.org>
	<6bffcb0e0511111631h52ff73e1q@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
>
> [1.] One line summary of the problem:
>  Oops when starting system (perhaps /etc/init.d/networking)
> 
>  [4.] Kernel version (from /proc/version):
>  Linux version 2.6.14-mm1 (michal@debian) (gcc version 4.0.3 20051023
>  (prerelease) (Debian 4.0.2-3)) #2 SMP PREEMPT Mon Nov 7 14:11:39 CET
>  2005
> 
>  [5.] Output of Oops
>  Nov 12 01:16:57 debian kernel: EXT3 FS on sda3, internal journal
>  Nov 12 01:16:57 debian kernel: EXT3-fs: mounted filesystem with
>  ordered data mode.
>  Nov 12 01:16:57 debian kernel: fill_kobj_path: path = '/block/sda/sda3'
>  Nov 12 01:16:57 debian kernel: irq 20: nobody cared (try booting with
>  the "irqpoll" option)
>  Nov 12 01:16:57 debian kernel:  [<c0103e68>] dump_stack+0x1e/0x20
>  Nov 12 01:16:57 debian kernel:  [<c0143079>] __report_bad_irq+0x2b/0x90
>  Nov 12 01:16:57 debian kernel:  [<c0143189>] note_interrupt+0x79/0xd0
>  Nov 12 01:16:57 debian kernel:  [<c0142ab8>] __do_IRQ+0xe9/0x101
>  Nov 12 01:16:57 debian kernel:  [<c01051c7>] do_IRQ+0x67/0xa7
>  Nov 12 01:16:57 debian kernel:  =======================
>  Nov 12 01:16:57 debian kernel:  [<c0103952>] common_interrupt+0x1a/0x20
>  Nov 12 01:16:57 debian kernel:  [<c0100df4>] cpu_idle+0x49/0xa0
>  Nov 12 01:16:57 debian kernel:  [<c01002e5>] rest_init+0x45/0x47
>  Nov 12 01:16:57 debian kernel:  [<c036095a>] start_kernel+0x18a/0x19d
>  Nov 12 01:16:57 debian kernel:  [<c0100210>] 0xc0100210
>  Nov 12 01:16:57 debian kernel: ---------------------------
>  Nov 12 01:16:57 debian kernel: | preempt count: 00010001 ]
>  Nov 12 01:16:57 debian kernel: | 1 level deep critical section nesting:
>  Nov 12 01:16:57 debian kernel: ----------------------------------------
>  Nov 12 01:16:57 debian kernel: .. [<c0100e49>] .... cpu_idle+0x9e/0xa0
>  Nov 12 01:16:57 debian kernel: .....[<c01002e5>] ..   ( <= rest_init+0x45/0x47)
>  Nov 12 01:16:57 debian kernel:
>  Nov 12 01:16:57 debian kernel: handlers:
>  Nov 12 01:16:57 debian kernel: [<f98e77b4>]
>  (snd_intel8x0_interrupt+0x0/0x27a [snd_intel8x0])
>  Nov 12 01:16:57 debian kernel: Disabling IRQ #20
>  Nov 12 01:16:57 debian kernel: kobject af_packet: registering. parent:
>  <NULL>, set: module
>  Nov 12 01:16:57 debian kernel: kobject_hotplug

Crap.  This is one of those crashes where the sound people, the PCI people,
the ACPI people and the PM people all earnestly hope that it's the other
guy's bug and you and I are left with a mess on our hands.

Possibly the card didn't get powered up.  I know there's a way to get all
those snd_printk()'s to print something, but I never have much success
finding the right value for the right /proc file to make it happen.

So can you add this please?

--- devel/sound/pci/intel8x0.c~a	2005-11-11 16:47:00.000000000 -0800
+++ devel-akpm/sound/pci/intel8x0.c	2005-11-11 16:48:13.000000000 -0800
@@ -779,6 +779,7 @@ static irqreturn_t snd_intel8x0_interrup
 	unsigned int i;
 
 	status = igetdword(chip, chip->int_sta_reg);
+	printk("status: 0x%8x\n", status);
 	if (status == 0xffffffff)	/* we are not yet resumed */
 		return IRQ_NONE;
 
_

and let us know what it says?

Also, it would be useful if you could disable the sound driver in config
and see if you can get it booted.  If so, then generate the `dmesg -s
1000000' output for good and bad kernels and let's see what they look like.

Thanks.
