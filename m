Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265537AbSK1QNU>; Thu, 28 Nov 2002 11:13:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265568AbSK1QNU>; Thu, 28 Nov 2002 11:13:20 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.106]:61340 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S265537AbSK1QNR>;
	Thu, 28 Nov 2002 11:13:17 -0500
Date: Thu, 28 Nov 2002 08:15:02 -0800
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Adrian Bunk <bunk@fs.tum.de>, Alan Cox <alan@redhat.com>,
       johnstul@us.ibm.com
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.20-rc4-ac1
Message-ID: <1568261310.1038471302@[10.10.2.3]>
In-Reply-To: <20021128130112.GB6981@fs.tum.de>
References: <20021128130112.GB6981@fs.tum.de>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Martin, could you please review whether the patch below which does the
> following is correct?
> 
> - kill the last occurence of CLUSTERED_APIC_NUMAQ
> - only one definition of PCI_CONF1_ADDRESS is needed
>   (#ifndef CONFIG_MULTIQUAD the BUS2LOCAL() has no effect)
> - fix an #endif comment

I'm confused at to what made this break recently .... what release 
did this break on? Either it was something very recent, everyone 
else is asleep, or you're doing something wierd (like compling with
MULTIQUAD on?)

CLUSTERED_APIC_NUMAQ is a part of the Summit patch introduction, 
where John (cc'ed) splits clustered_apic_mode from a boolean into
a switch (in 2.4 ... I did 2.5 differently). Maybe we merged half
of a summit patch somehow, and didn't get the define?

Yeah, I have no idea why I redefined PCI_CONF1_ADDRESS (you're
correct, BUS2LOCAL is a no-op) ... That part of the patch is fine.

M.

> --- linux-2.4.19-full-ac/arch/i386/kernel/pci-pc.c.old	2002-11-28 12:51:01.000000000 +0100
> +++ linux-2.4.19-full-ac/arch/i386/kernel/pci-pc.c	2002-11-28 13:49:50.000000000 +0100
> @@ -51,10 +51,10 @@
>  
>  #ifdef CONFIG_PCI_DIRECT
>  
> -#ifdef CONFIG_MULTIQUAD
>  #define PCI_CONF1_ADDRESS(bus, dev, fn, reg) \
>  	(0x80000000 | (BUS2LOCAL(bus) << 16) | (dev << 11) | (fn << 8) | (reg & ~3))
>  
> +#ifdef CONFIG_MULTIQUAD
>  static int pci_conf1_mq_read (int seg, int bus, int dev, int fn, int reg, int len, u32 *value) /* CONFIG_MULTIQUAD */
>  {
>  	unsigned long flags;
> @@ -173,9 +173,7 @@
>  	pci_conf1_write_mq_config_dword
>  };
>  
> -#endif /* !CONFIG_MULTIQUAD */
> -#define PCI_CONF1_ADDRESS(bus, dev, fn, reg) \
> -	(0x80000000 | (bus << 16) | (dev << 11) | (fn << 8) | (reg & ~3))
> +#endif /* CONFIG_MULTIQUAD */
>  
>  static int pci_conf1_read (int seg, int bus, int dev, int fn, int reg, int len, u32 *value) /* !CONFIG_MULTIQUAD */
>  {
> @@ -478,7 +476,7 @@
>  
>  #ifdef CONFIG_MULTIQUAD			
>  			/* Multi-Quad has an extended PCI Conf1 */
> -			if(clustered_apic_mode == CLUSTERED_APIC_NUMAQ)
> +			if(clustered_apic_logical)
>  				return &pci_direct_mq_conf1;
>  #endif				
>  			return &pci_direct_conf1;
> 
> 


