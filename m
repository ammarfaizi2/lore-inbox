Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424253AbWKJGGP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424253AbWKJGGP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 01:06:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966087AbWKJGGP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 01:06:15 -0500
Received: from smtp.osdl.org ([65.172.181.4]:16044 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S966046AbWKJGGO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 01:06:14 -0500
Date: Thu, 9 Nov 2006 22:05:15 -0800
From: Andrew Morton <akpm@osdl.org>
To: eric@buddington.net
Cc: Eric Buddington <ebuddington@verizon.net>, linux-kernel@vger.kernel.org,
       Greg KH <greg@kroah.com>, Kay Sievers <kay.sievers@novell.com>,
       Jaroslav Kysela <perex@suse.cz>, Takashi Iwai <tiwai@suse.de>
Subject: Re: 2.6.19-rc4-mm2: BUG modprobeing sound driver
Message-Id: <20061109220515.7a127070.akpm@osdl.org>
In-Reply-To: <20061109142208.GA4291@pool-70-109-251-157.wma.east.verizon.net>
References: <20061109142208.GA4291@pool-70-109-251-157.wma.east.verizon.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 09 Nov 2006 09:22:09 -0500
Eric Buddington <ebuddington@verizon.net> wrote:

> Kernel 2.6.19-rc4-mm2 on an Athlon XP / SiS 741 motherboard chipset
> 
> In the process of modprobe-ing all the sound modules to figure out
> which I needed (is that kosher? Well, I did it anyway), I got the
> following BUG. Share and enjoy.
> 
> [  673.745969] BUG: unable to handle kernel NULL pointer dereference at virtual address 00000064
> [  673.745974]  printing eip:
> [  673.745977] c02d1ae5
> [  673.745979] *pde = 00000000
> [  673.745986] Oops: 0000 [#1]
> [  673.745988] PREEMPT 
> [  673.745992] last sysfs file: /devices/pci0000:00/0000:00:00.0/class
> [  673.746131] CPU:    0
> [  673.746133] EIP:    0060:[<c02d1ae5>]    Not tainted VLI
> [  673.746135] EFLAGS: 00010246   (2.6.19-rc4-mm2 #1)
> [  673.746150] EIP is at device_del+0x8/0x156
> [  673.746154] eax: 00000000   ebx: 00000000   ecx: c1aff240   edx: c1679380
> [  673.746159] esi: 00000000   edi: 0000ffff   ebp: d0bd9cd0   esp: d0bd9cc4
> [  673.746162] ds: 007b   es: 007b   ss: 0068
> [  673.746166] Process modprobe (pid: 5689, ti=d0bd8000 task=f50eb1b0 task.ti=d0bd8000)
> [  673.746169] Stack: 00000000 d085ee00 0000ffff d0bd9cdc c02d1c3e d085ee00 d0bd9cf4 f8a196e3 
> [  673.746177]        d0bd9cf4 f8a19d5b 00000000 00000000 d0bd9d1c f8a19ea4 ee290000 00000286 
> [  673.746185]        ee290000 ffffffed 0000ffff ee290000 ffffffed 0000ffff d0bd9d88 f8c18539 
> [  673.746192] Call Trace:
> [  673.746212]  [<c02d1c3e>] device_unregister+0xb/0x15
> [  673.746220]  [<f8a196e3>] snd_card_do_free+0xe6/0xf5 [snd]
> [  673.746264]  [<f8a19ea4>] snd_card_free+0x77/0x81 [snd]
> [  673.746283]  [<f8c18539>] snd_serial_probe+0x47a/0x528 [snd_serial_u16550]
> [  673.746329]  [<c02d49ee>] platform_drv_probe+0xf/0x11
> [  673.746339]  [<c02d3682>] really_probe+0x79/0x105
> [  673.746349]  [<c02d37a3>] driver_probe_device+0x95/0xa1
> [  673.746357]  [<c02d37b7>] __device_attach+0x8/0xa
> [  673.746363]  [<c02d2c5d>] bus_for_each_drv+0x37/0x60
> [  673.746371]  [<c02d3830>] device_attach+0x62/0x76
> [  673.746377]  [<c02d2bd2>] bus_attach_device+0x21/0x42
> [  673.746384]  [<c02d1fa1>] device_add+0x2a8/0x3eb
> [  673.746390]  [<c02d4ce1>] platform_device_add+0xee/0x11e
> [  673.746398]  [<c02d4ede>] platform_device_register_simple+0x35/0x4b
> [  673.746405]  [<f8c18079>] alsa_card_serial_init+0x39/0x7f [snd_serial_u16550]

Yup, trivial to reproduce: modprobe snd_serial_u16550 -> splat.

Bisection indicates that this oops is triggered by
gregkh-driver-sound-device.patch.

snd_serial_probe() never got to call snd_card_register(), so card->dev is
NULL.

snd_serial_probe() calls snd_card_free(card) on the error path and
snd_card_do_free() does device_del(card->dev) which oopses over the null
pointer it got.  
