Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292780AbSCDTKU>; Mon, 4 Mar 2002 14:10:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292779AbSCDTKK>; Mon, 4 Mar 2002 14:10:10 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:1548 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S292770AbSCDTJ4>;
	Mon, 4 Mar 2002 14:09:56 -0500
Message-ID: <3C83C698.25D28157@mandrakesoft.com>
Date: Mon, 04 Mar 2002 14:10:16 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Kent Yoder <key@austin.ibm.com>
CC: linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
Subject: Re: [PATCH] IBM Lanstreamer bugfixes (round 3)
In-Reply-To: <Pine.LNX.4.33.0203041230180.11370-100000@janetreno.austin.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kent Yoder wrote:
>   Ok, hopefully below is the section you were referring to:
> 
> -------
> 
>   pci_read_config_byte(pdev, PCI_CACHE_LINE_SIZE, &cls);
>   cls <<= 2;
>   if (cls != SMP_CACHE_BYTES) {
>          printk(KERN_INFO "  PCI cache line size set incorrectly "
>                 "(%i bytes) by BIOS/FW, ", cls);
>          if (cls > SMP_CACHE_BYTES)
>                 printk("expecting %i\n", SMP_CACHE_BYTES);
>          else {
>                 printk("correcting to %i\n", SMP_CACHE_BYTES);
>                 pci_write_config_byte(pdev, PCI_CACHE_LINE_SIZE,
>                                       SMP_CACHE_BYTES >> 2);
>          }
>   }

this gets cache line size correct

>   /* Turn off Fast B2B enable */
>   pcr &= ~PCI_COMMAND_FAST_BACK;
>   /* Turn on SERR# enable and others */
>   pcr |= (PCI_COMMAND_SERR | PCI_COMMAND_INVALIDATE | PCI_COMMAND_PARITY |
>           PCI_COMMAND_IO   | PCI_COMMAND_MEMORY);
> 
>   pci_write_config_word (pdev, PCI_COMMAND, pcr);
>   pci_read_config_word (pdev, PCI_COMMAND, &pcr);

You only need to worry about the PCI_COMMAND_INVALIDATE bit here, unless
your chip requires other setup, or you care to handle PCI hard errors in
the driver.

>  Out of curiosity, does it in fact make sense to use memory write and
> invalidate and set cache line size to 0 in some cases?  This seems to go
> against the PCI spec, which, if I'm reading it correctly, says that memory
> write and invalidate is the same as a memory write, but it guarantees that
> at least 1 cache line will be written.  So, setting cacheline size =0 would
> negate this effect(?)

The rule is, never ever enable MWI if cache line size is zero.

MWI -does- make a difference in performance, though you may need to
check lanstreamer docs to see if there is a chip-specific MWI bit you
need to enable, over and above the PCI_COMMAND bit.

	Jeff


-- 
Jeff Garzik      |
Building 1024    |
MandrakeSoft     | Choose life.
