Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262170AbUEQTCX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262170AbUEQTCX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 15:02:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262175AbUEQTCX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 15:02:23 -0400
Received: from fmr10.intel.com ([192.55.52.30]:39657 "EHLO
	fmsfmr003.fm.intel.com") by vger.kernel.org with ESMTP
	id S262170AbUEQTCU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 15:02:20 -0400
Subject: Re: libata Promise driver regression 2.6.5->2.6.6
From: Len Brown <len.brown@intel.com>
To: Sergey Vlasov <vsu@altlinux.ru>, Brad Campbell <brad@wasp.net.au>
Cc: linux-kernel@vger.kernel.org,
       ACPI Developers <acpi-devel@lists.sourceforge.net>
In-Reply-To: <A6974D8E5F98D511BB910002A50A6647615FB7A9@hdsmsx403.hd.intel.com>
References: <A6974D8E5F98D511BB910002A50A6647615FB7A9@hdsmsx403.hd.intel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1084820518.12349.347.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 17 May 2004 15:01:59 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-05-16 at 13:49, Sergey Vlasov wrote:
> On Sun, 16 May 2004 21:18:48 +0400, Brad Campbell wrote:
> 
> > I have been using 2.6.5 happily for a while now on this machine.
> > It's an Asus A7V600 with 3 Promise SATA150-TX4 SATA cards.
> > 
> > With 2.6.6 (and 2.6.6-bk3) it hangs with a dma timeout on boot
> detecting the 9th sata drive (there 
> > are 10). I left it for about 10 minutes to see if anything else
> transpired but it just sat there.
> > I'm on a serial console to this machine at the moment and I could
> not get it to respond to the magic 
> > sysrq key over serial either.
> > 
> > I have placed all relevant info including a capture of 2.6.5 boot
> and 2.6.6 boot, plus all requested 
> > info from linux/REPORTING-BUGS on my webpage
> > 
> > Normal working dmesg
> > http://www.wasp.net.au/~brad/2.6.5.log
> > 
> > Hung up dmesg
> > http://www.wasp.net.au/~brad/2.6.6.log
> > 
> > .config and all other info I could gather.
> > http://www.wasp.net.au/~brad/2.6.6.config
> > Much as I'd love to be subscribed, I just can't keep up with the
> volume so please cc: me.
> > Willing to try patches/hacks/suggestions
> 
> Looks like ACPI problems.  First, for some reason ACPI in 2.6.6
> decided to
> use PIC mode, while 2.6.5 used IOAPIC mode.

This is because the 2.6.6 .config did not include IOAPIC support.

>   Second, IRQ 12 was chosen for
> the Promise controller which failed; this is a known problem in 2.6.6,
> the patch at http://bugzilla.kernel.org/show_bug.cgi?id=2665 should
> fix it.

Yes, this is going to be a problem:

ata9: SATA max UDMA/133 cmd 0xE080E200 ctl 0xE080E238 bmdma 0x0 irq 12
ata10: SATA max UDMA/133 cmd 0xE080E280 ctl 0xE080E2B8 bmdma 0x0 irq 12
ata11: SATA max UDMA/133 cmd 0xE080E300 ctl 0xE080E338 bmdma 0x0 irq 12
ata12: SATA max UDMA/133 cmd 0xE080E380 ctl 0xE080E3B8 bmdma 0x0 irq 12

But it isn't caused by bug 2665.

ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 11 *12)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *5 6 7 9 10 11 12)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 *9 10 11 12)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 *9 10 11 12)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 *11 12)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 10 11 12) *15,
disabled.
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
SCSI subsystem initialized
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 12
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 9
ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 9
ACPI: PCI Interrupt Link [LNKG] enabled at IRQ 11

LNKH would have hit the bug fixed in 2665.
However, LNKH isn't enabled, so we don't hit that bug.

LNKC, OTOH, is already enabled on IRQ12; and both
2.6.5 and 2.6.6 will leave it there unless you explicity
tell Linux to move IRQs in PIC mode with "acpi_irq_balance".

apples/apples comparison would be to boot your 2.6.5 kernel with
"noapic".  I expect 2.6.5 will have the same issue with IRQ12
in PIC mode.  Unusual for a BIOS to put PCI devices on IRQ12 like
that...

-Len


