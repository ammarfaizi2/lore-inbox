Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261707AbVCXTRn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261707AbVCXTRn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 14:17:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261188AbVCXTRn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 14:17:43 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:42248 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261707AbVCXTRB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 14:17:01 -0500
Date: Thu, 24 Mar 2005 19:16:54 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Interesting tidbit: NetMos 9835 card, IRQ, and ACPI
Message-ID: <20050324191654.D4189@flint.arm.linux.org.uk>
Mail-Followup-To: Michael Tokarev <mjt@tls.msk.ru>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <42430EAD.3050605@tls.msk.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <42430EAD.3050605@tls.msk.ru>; from mjt@tls.msk.ru on Thu, Mar 24, 2005 at 10:02:05PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2005 at 10:02:05PM +0300, Michael Tokarev wrote:
> Found an interesting issue here.
> 
> HP ProLiant ML150 box (dual xeon 2.4GHz) with intel
> chipset (lspci output below) and NetMos PCI 9835
> Multi-I/O Controller.
> 
> Boot with no fancy options on kernel command line.
> 
>   # cat /sys/bus/pci/devices/0000:01:00.0/irq
>   11
>   # modprobe 8250
>   # setserial /dev/ttyS2 irq 11 port 0xa400 autoconfig
> 
> the serial port does not work: close'int the file
> after writing something stalls for a while, and nothing
> gets written.  Ok.

setserial shouldn't be used to configure PCI-based serial ports.  It's
expected to fail. 8)

>   # rmmod 8250
>   # modprobe parport_pc
>   ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 18 (level, low) -> IRQ 193
>   # cat /sys/bus/pci/devices/0000:01:00.0/irq
>   193
>   # rmmod parport_pc # as it will conflict with 8250 here
>   # modprobe 8250
>   # setserial /dev/ttyS2 irq 193 port 0xa400 autoconfig
> 
> now the serial port works.

That's because parport_pc seems to think it should be driving this
combination serial/parallel device.  That's actually something that
parport_serial should be doing, and there's a patch in -mm to fix
this:

http://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc1/2.6.12-rc1-mm2/broken-out/netmos-parallel-serial-combo-support.patch

However, this patch seems to claim that the 9835 is not supported
by anything in the kernel at present, so how is parport_pc finding
your card?  Have you applied any patches?

> BTW, we have another prob with this very Netmos card and this very
> machine: sometimes, the whole machine hangs hard when using serial
> driver, so only power button helps.  Happens with 2.4.* kernels
> (it assigns IRQ18 to the card) and with earlier 2.6.x kernels.
> Dunno if the two are related.

That's a separate problem.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
