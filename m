Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288485AbSAQK5c>; Thu, 17 Jan 2002 05:57:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288484AbSAQK5X>; Thu, 17 Jan 2002 05:57:23 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:34060 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S288485AbSAQK5J>;
	Thu, 17 Jan 2002 05:57:09 -0500
Message-ID: <3C46AE02.FAEEFA7B@mandrakesoft.com>
Date: Thu, 17 Jan 2002 05:57:06 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.2-pre9fs7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Kent E Yoder <yoder1@us.ibm.com>
CC: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IBM Lanstreamer bugfixes
In-Reply-To: <OFDECC5A17.29748904-ON85256B43.006B2B67@raleigh.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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
