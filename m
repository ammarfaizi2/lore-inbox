Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289170AbSAQPaT>; Thu, 17 Jan 2002 10:30:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289168AbSAQPaC>; Thu, 17 Jan 2002 10:30:02 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:26012 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S289170AbSAQP3t>; Thu, 17 Jan 2002 10:29:49 -0500
To: jgarzik@e2.ny.us.ibm.com
Cc: linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
MIME-Version: 1.0
Subject: Re: [PATCH] IBM Lanstreamer bugfixes
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OF678618BF.21B7F748-ON85256B44.00542D83@raleigh.ibm.com>
From: "Kent E Yoder" <yoder1@us.ibm.com>
Date: Thu, 17 Jan 2002 09:29:35 -0600
X-MIMETrack: Serialize by Router on D04NM109/04/M/IBM(Release 5.0.9 |November 16, 2001) at
 01/17/2002 10:29:37 AM,
	Serialize complete at 01/17/2002 10:29:37 AM
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your points, I will take a look at these when I can...

Kent



Kent E Yoder wrote:
> This patch fixes several bugs and works around known hardware problems
> which conspired to lock up the system randomly.  Its somewhat large,
> therefore available at:

http://oss.software.ibm.com/developer/opensource/linux/patches/tr/lanstreamer-0.5.1.patch.gz
> 
> * Interrupt function rearranged
> * PCI Configuration changed
> * Tx descriptors had to be reduced to 1 (!)
> * Send/Receive operations are nearly serialized



Marcelo, please do not apply this patch...



Sorry for the delay, review:

1) (in code, not in your patch) prefer kernel-standard types like u32 or
u16 to __u32 and __u16

2) poor formatting:

> +#if STREAMER_IOCTL
> +        dev->do_ioctl = &streamer_ioctl;
> +#else
>                         dev->do_ioctl = NULL;
> +#endif

3) I don't like this playing around with magic numbers.  pci_set_master
and pci_enable_device and pci_disable_device twiddle PCI_COMMAND bits,
too.  Use constants from pci.h make it clear what bits you are clearing,
and what bits you are setting.

> +       pci_write_config_byte (pdev, PCI_CACHE_LINE_SIZE, cls);
> +       pci_read_config_word (pdev, PCI_COMMAND, &pcr);
> +
> +       /* Turn off Fast B2B enable */
> +       pcr &= 0xfdff;
> +       /* Turn on SERR# enable and others */
> +       pcr |= 0x0157;
> +
> +       pci_write_config_word (pdev, PCI_COMMAND, pcr);
> +       pci_read_config_word (pdev, PCI_COMMAND, &pcr);

4) Your code appears to -always- set cache line size to zero.  Is that a
hardware bug?  Look at acenic.c to see a better example of setting PCI
cache line size.

5) what is the purpose of the spin_lock in streamer_open, if open is
serialized?  it worries me that the previous streamer_open code disabled
interrupts and the new one does not, but replaces with a non-irq-saving
lock that appears superfluous.

6) udelay(1) after brand new spin_lock in streamer_interrupt is
suspicious

7) disabling interrupts by zeroing NIC intr mask, in interrupt handler,
is general not needed.  why was this added?  interrupt handlers are not
re-entered so this is not a worry.

8) the while loop in the interrupt looks like it could go on for quite a
while under heavy load, starving out a lot of other kernel code.  it
needs a work limit at the very least...

9) disabling interrupts at the beginning of each TX is wrong.  you
probably want spin_lock_irqsave at critical parts of the xmit.

10) udelay(100) is likely wrong and a sign of a race (perhaps #9, above,
fixes this)

11) replacing save_flags/cli with normal spin_lock in streamer_close is
suspicious and likely wrong.  See issue #5 about streamer_open
serialization.  Have you read Documentation/networking/netdevices.txt ?

12) formatting of streamer_ioctl is grossly different from the rest of
the code

13) SIOCDEVPRIVATE ioctls are going away in 2.5.  (you can implement
include/linux/ethtool.h SIOCETHTOOL interface for lot of the
functionality, though)

-- 
Jeff Garzik      | Alternate titles for LOTR:
Building 1024    | Fast Times at Uruk-Hai
MandrakeSoft     | The Took, the Elf, His Daughter and Her Lover
                 | Samwise Gamgee: International Hobbit of Mystery



