Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932268AbWEHPpr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932268AbWEHPpr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 11:45:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932315AbWEHPpr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 11:45:47 -0400
Received: from smtp.osdl.org ([65.172.181.4]:39329 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932268AbWEHPpq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 11:45:46 -0400
Date: Mon, 8 May 2006 08:43:01 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
Cc: florin@iucha.net, linux-kernel@vger.kernel.org, torvalds@osdl.org,
       linux@dominikbrodowski.net
Subject: Re: pcmcia oops on 2.6.17-rc[12]
Message-Id: <20060508084301.5025b25d.akpm@osdl.org>
In-Reply-To: <20060508145609.GA3983@rhlx01.fht-esslingen.de>
References: <20060423192251.GD8896@iucha.net>
	<20060423150206.546b7483.akpm@osdl.org>
	<20060508145609.GA3983@rhlx01.fht-esslingen.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Mohr <andi@rhlx01.fht-esslingen.de> wrote:
>
> Hi,
> 
> On Sun, Apr 23, 2006 at 03:02:06PM -0700, Andrew Morton wrote:
> > It's actually not an oops - it's a warning, telling us that i82365 is
> > requesting an IRQ in non-sharing mode, but there's already a handler
> > registered for that IRQ (which might or might not be shareable).
> 
> And the same thing on a Toshiba Satellite 4280, P3/450, 2.6.17-rc3-ck2:
> 
> setup_irq: irq handler mismatch
>  <c0103248> show_trace+0xd/0xf   <c010325f> dump_stack+0x15/0x17
>  <c012aeca> setup_irq+0xd9/0xe8   <c012b002> request_irq+0x6e/0x8c
>  <c020cdfd> serial8250_startup+0x263/0x394   <c020a1aa> uart_startup+0x68/0xf1
>  <c020adba> uart_ioctl+0x554/0x847   <c01f31ed> tty_ioctl+0xbae/0xc36
>  <c0151eec> do_ioctl+0x3c/0x4f   <c01520ed> vfs_ioctl+0x1ee/0x205
>  <c015212e> sys_ioctl+0x2a/0x44   <c01029bb> sysenter_past_esp+0x54/0x75
>
> ...
> 
> # cat /proc/interrupts
>            CPU0
>   0:   31607214          XT-PIC  timer
>   1:      11092          XT-PIC  i8042
>   2:          0          XT-PIC  cascade
>   3:      36368          XT-PIC  pcnet_cs
>   8:          3          XT-PIC  rtc
>   9:         84          XT-PIC  acpi
>  11:      73639          XT-PIC  yenta, yenta, uhci_hcd:usb1, YMFPCI, irda0
>  12:       9996          XT-PIC  i8042
>  14:      63830          XT-PIC  ide0
>  15:     536942          XT-PIC  ide1
> NMI:          0
> LOC:          0
> ERR:          0

So 8250 is requesting an IRQ for non-sharing mode and it's actually
failing, because something else is already using that IRQ.  The difference
is that the kernel now generates a warning when this happens.


> # lspci
> 0000:00:00.0 Host bridge: Intel Corporation 440BX/ZX/DX - 82443BX/ZX/DX Host bridge (rev 03)
> 0000:00:01.0 PCI bridge: Intel Corporation 440BX/ZX/DX - 82443BX/ZX/DX AGP bridge (rev 03)
> 0000:00:05.0 Bridge: Intel Corporation 82371AB/EB/MB PIIX4 ISA (rev 02)
> 0000:00:05.1 IDE interface: Intel Corporation 82371AB/EB/MB PIIX4 IDE (rev 01)
> 0000:00:05.2 USB Controller: Intel Corporation 82371AB/EB/MB PIIX4 USB (rev 01)
> 0000:00:05.3 Bridge: Intel Corporation 82371AB/EB/MB PIIX4 ACPI (rev 03)
> 0000:00:07.0 Communication controller: Agere Systems 56k WinModem (rev 01)
> 0000:00:09.0 IRDA controller: Toshiba America Info Systems FIR Port Type-DO
> 0000:00:0b.0 CardBus bridge: Toshiba America Info Systems ToPIC100 PCI to Cardbus Bridge with ZV Support (rev 20)
> 0000:00:0b.1 CardBus bridge: Toshiba America Info Systems ToPIC100 PCI to Cardbus Bridge with ZV Support (rev 20)
> 0000:00:0c.0 Multimedia audio controller: Yamaha Corporation YMF-744B [DS-1S Audio Controller] (rev 02)
> 0000:01:00.0 VGA compatible controller: S3 Inc. 86C270-294 Savage/IX-MV (rev 11)
> 
> > Your machine should otherwise continue to work OK.  Is that the case?
> 
> It seems so, yes.

I don't see how your 8250 can be working if serial_link_irq_chain() has failed.

> > i82365 appears to be poking around in interrupt space trying to find an IRQ
> > which isn't shared with anyone else (I'm not sure why, but these sorts of
> > things tend to be derived from hard experience).
> > 
> > Anyway.  We need to either a) make i82365 better-behaved or b) remove the
> > warning or c) allow callers to suppress the warning (SA_PROBEIRQ?).
> 
> Add SA_PROBEIRQ to 8250.c, then, I guess?

That would be appropriate if it is actually expected that the request_irq()
in there will fail, and we still manage to make the hardware work via some
fallback method.  But I don't immediately see any code which does that.

Russell, any opinions?

Thanks.

