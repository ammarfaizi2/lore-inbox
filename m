Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262248AbVERQqn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262248AbVERQqn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 12:46:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262336AbVERQqf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 12:46:35 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:17339 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262311AbVERQpK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 12:45:10 -0400
Date: Wed, 18 May 2005 08:33:15 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: "Salomon, Frank" <frank.salomon@wincor-nixdorf.com>
Cc: linux-net <linux-net@vger.kernel.org>, linux-kernel@vger.kernel.org,
       Don Fry <brazilnut@us.ibm.com>
Subject: Re: pci-irq VIA82C586 problem on IBM 4694-205 kernel version 2.4.29
Message-ID: <20050518113315.GC7793@logos.cnet>
References: <428379AC.9080206@wincor-nixdorf.com> <20050512162803.GA15201@us.ibm.com> <42847C64.5080405@wincor-nixdorf.com> <20050513164654.GB30792@us.ibm.com> <4289FF48.9070205@wincor-nixdorf.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4289FF48.9070205@wincor-nixdorf.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Frank,

On Tue, May 17, 2005 at 04:27:20PM +0200, Salomon, Frank wrote:
> Hi All,
> 
> With kernel version 2.4.18 I have no problem to run pcnet32.o on the IBM 
> 4694-205. Now I switch to kernel version 2.4.29. insmod crc32 : ok , 
> insmod mii : ok , insmod pcnet32 : ok.
> 
> But if I run ifconfig (ifup) the system fries. Can't toggle the numlock 
> led. I find out that the system generates permanently interrupts from 
> the pcnet32 chip after calling request_irq (irq=9).
> 
> lspci:
> 00:00.0 Host bridge: VIA Technologies, Inc. VT82C585VP [Apollo VP1/VPX] 
> (rev 25)
> 00:07.0 ISA bridge: VIA Technologies, Inc. VT82C586/A/B PCI-to-ISA 
> [Apollo VP] (rev 47)
> 00:07.1 IDE interface: VIA Technologies, Inc. VT82C586/B/686A/B PIPC Bus 
> Master IDE (rev 06)
> 00:07.2 USB Controller: VIA Technologies, Inc. USB (rev 02)
> 00:07.3 Non-VGA unclassified device: VIA Technologies, Inc. VT82C586B 
> ACPI (rev 10)
> 00:0a.0 VGA compatible controller: Cirrus Logic GD 5446
> 00:0b.0 Ethernet controller: Advanced Micro Devices [AMD] 79c970 
> [PCnet32 LANCE] (rev 43)
> 
> 
> A possible solution could be (only tested on IBM 4694-205 and I don't 
> have other systems with VIA Tech.):

Why the current get/set methods for via pirq do not work as expected? 
                                                                                                                                                                                   
/*
 * The VIA pirq rules are nibble-based, like ALI,
 * but without the ugly irq number munging.
 * However, PIRQD is in the upper instead of lower nibble.
 */
static int pirq_via_get(struct pci_dev *router, struct pci_dev *dev, int pirq)
{
        return read_config_nybble(router, 0x55, pirq == 4 ? 5 : pirq);
}
                                                                                
static int pirq_via_set(struct pci_dev *router, struct pci_dev *dev, int pirq, int irq)
{
        write_config_nybble(router, 0x55, pirq == 4 ? 5 : pirq, irq);
        return 1;
}

Only difference is that your change ignores the "pirq" value... Is that 
the problem?


> diff -u 2.4.29_orig/arch/i386/kernel/pci-irq.c 
> 2.4.29/arch/i386/kernel/pci-irq.c
> --- 2.4.29_orig/arch/i386/kernel/pci-irq.c      Wed Jan 19 15:09:25 2005
> +++ 2.4.29/arch/i386/kernel/pci-irq.c   Tue May 17 15:55:28 2005
> @@ -214,6 +214,17 @@
>         return 1;
>  }
> 
> +static int pirq_via_586_get(struct pci_dev *router, struct pci_dev 
> *dev, int pirq)
> +{
> +       return read_config_nybble(router, 0x55, pirq);
> +}
> +static int pirq_via_586_set(struct pci_dev *router, struct pci_dev 
> *dev, int pirq, int irq)
> +{
> +       write_config_nybble(router, 0x55, pirq, irq);
> +       return 1;
> +}
> +
> +
>  /*
>   * ITE 8330G pirq rules are nibble-based
>   * FIXME: pirqmap may be { 1, 0, 3, 2 },
> @@ -649,6 +660,10 @@
>         switch(device)
>         {
>                 case PCI_DEVICE_ID_VIA_82C586_0:
> +                       r->name = "VIA";
> +                       r->get = pirq_via_586_get;
> +                       r->set = pirq_via_586_set;
> +                       return 1;
>                 case PCI_DEVICE_ID_VIA_82C596:
>                 case PCI_DEVICE_ID_VIA_82C686:
>                 case PCI_DEVICE_ID_VIA_8231:
