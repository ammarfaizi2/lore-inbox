Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261487AbVCXTz2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261487AbVCXTz2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 14:55:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261489AbVCXTz2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 14:55:28 -0500
Received: from hobbit.corpit.ru ([81.13.94.6]:22616 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S261487AbVCXTyw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 14:54:52 -0500
Message-ID: <42431B0A.2000407@tls.msk.ru>
Date: Thu, 24 Mar 2005 22:54:50 +0300
From: Michael Tokarev <mjt@tls.msk.ru>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Interesting tidbit: NetMos 9835 card, IRQ, and ACPI
References: <42430EAD.3050605@tls.msk.ru> <20050324191654.D4189@flint.arm.linux.org.uk>
In-Reply-To: <20050324191654.D4189@flint.arm.linux.org.uk>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> On Thu, Mar 24, 2005 at 10:02:05PM +0300, Michael Tokarev wrote:
[]
>>  # cat /sys/bus/pci/devices/0000:01:00.0/irq
>>  11
>>  # modprobe 8250
>>  # setserial /dev/ttyS2 irq 11 port 0xa400 autoconfig
>>
>>the serial port does not work: close'int the file
>>after writing something stalls for a while, and nothing
>>gets written.  Ok.
> 
> setserial shouldn't be used to configure PCI-based serial ports.  It's
> expected to fail. 8)

Well.. it worked this way since kernel 2.2.x, ie, for ages.
2.6.10 or 2.6.11 broke it.

>>  # rmmod 8250
>>  # modprobe parport_pc
>>  ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 18 (level, low) -> IRQ 193
>>  # cat /sys/bus/pci/devices/0000:01:00.0/irq
>>  193
>>  # rmmod parport_pc # as it will conflict with 8250 here
>>  # modprobe 8250
>>  # setserial /dev/ttyS2 irq 193 port 0xa400 autoconfig
>>
>>now the serial port works.
> 
> That's because parport_pc seems to think it should be driving this
> combination serial/parallel device.  That's actually something that

After thinking a bit more, I see the problem: parport_pc, when
claiming the device, performs initialisation stuff which changes
the IRQ.  While 8250[_pci] module does not know this device and
does not perform any additional initialisation, hence it does not
work.

> parport_serial should be doing, and there's a patch in -mm to fix
> this:
> 
> http://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc1/2.6.12-rc1-mm2/broken-out/netmos-parallel-serial-combo-support.patch
> 
> However, this patch seems to claim that the 9835 is not supported
> by anything in the kernel at present, so how is parport_pc finding
> your card?  Have you applied any patches?

It was 2.6.11.5 without any relevant patches applied.

I saw the post by Bjorn Helgaas at Mar-23.  Tried applying
it and now I may say for sure: the patch made the whole
thing to work just fine.  When loading 8250_pci module
(never did that before, tried now without the patch -
obviously it doesn't recognize the card), both serial
ports gets recognized automatically and correctly, and
the IRQ gets changed from 11 to 193 automatically too:

Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 18 (level, low) -> IRQ 193
ttyS4 at I/O 0xa400 (irq = 193) is a 16550A
ttyS5 at I/O 0xa000 (irq = 193) is a 16550A

And oh.. now the ports are at ttyS[45], I used for them
to be at ttyS[23]... Oh well...

The patch does not apply to 2.6.11 - several hunks, notable
all the parport stuff, fails.  I'll dig into this a bit
later today (hopefully).  8250 changes are enouth for the
serial port to work, parallel port still does not work --
without the missing patch hunks.

And oh..  From the description of the patch, it looks like
it *fixes* the "9835 card is unsupported" problem, not as
"9835 is still unsupported".  Confusing a bit, but it's
how I read it... ;)

/mjt
