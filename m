Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311885AbSGYMcY>; Thu, 25 Jul 2002 08:32:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312558AbSGYMcY>; Thu, 25 Jul 2002 08:32:24 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:42762
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S311885AbSGYMcV>; Thu, 25 Jul 2002 08:32:21 -0400
Date: Thu, 25 Jul 2002 05:30:00 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: martin@dalecki.de, Vojtech Pavlik <vojtech@suse.cz>,
       William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC/CFT] cmd640 irqlocking fixes
In-Reply-To: <1027602528.9488.68.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.10.10207250526000.4719-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


EEK!

Alan, how are you going to sync to access to the shared HBA registers if
the lock is decoupled from the main loop?  Since there are general
register mucking abouts during data transfers, iirc the behavors of the
CMD640B I use for testing.  You have me a little close to the edge of my
seat on concern.


On 25 Jul 2002, Alan Cox wrote:

> Martin this patch should do the job. It uses the correct pci_config_lock
> and it also adds the 2.4 probe safety checks for deciding which pci
> modes to use.
> 
> --- ../linux-2.5.28/drivers/ide/cmd640.c	Thu Jul 25 10:49:19 2002
> +++ drivers/ide/cmd640.c	Thu Jul 25 11:41:27 2002
> @@ -216,27 +216,27 @@
>  
>  /* PCI method 1 access */
>  
> -static void put_cmd640_reg_pci1 (unsigned short reg, byte val)
> +extern spinlock_t pci_config_lock;
> +
> +static void put_cmd640_reg_pci1 (unsigned short reg, u8 val)
>  {
>  	unsigned long flags;
> -
> -	save_flags(flags);
> -	cli();
> -	outl_p((reg & 0xfc) | cmd640_key, 0xcf8);
> +	
> +	spin_lock_irqsave(&pci_config_lock, flags);
> +	outb_p((reg & 0xfc) | cmd640_key, 0xcf8);
>  	outb_p(val, (reg & 3) | 0xcfc);
> -	restore_flags(flags);
> +	spin_unlock_irqrestore(&pci_config_lock, flags);
>  }
>  
>  static u8 get_cmd640_reg_pci1 (unsigned short reg)
>  {
>  	u8 b;
>  	unsigned long flags;
> -
> -	save_flags(flags);
> -	cli();
> -	outl_p((reg & 0xfc) | cmd640_key, 0xcf8);
> -	b = inb_p((reg & 3) | 0xcfc);
> -	restore_flags(flags);
> +	
> +	spin_lock_irqsave(&pci_config_lock, flags);
> +	outb_p((reg & 0xfc) | cmd640_key, 0xcf8);
> +	b=inb_p((reg & 3) | 0xcfc);
> +	spin_unlock_irqrestore(&pci_config_lock, flags);
>  	return b;
>  }
>  
> @@ -245,26 +245,24 @@
>  static void put_cmd640_reg_pci2 (unsigned short reg, u8 val)
>  {
>  	unsigned long flags;
> -
> -	save_flags(flags);
> -	cli();
> +	
> +	spin_lock_irqsave(&pci_config_lock, flags);
>  	outb_p(0x10, 0xcf8);
>  	outb_p(val, cmd640_key + reg);
>  	outb_p(0, 0xcf8);
> -	restore_flags(flags);
> +	spin_unlock_irqrestore(&pci_config_lock, flags);
>  }
>  
>  static u8 get_cmd640_reg_pci2 (unsigned short reg)
>  {
>  	u8 b;
>  	unsigned long flags;
> -
> -	save_flags(flags);
> -	cli();
> +	
> +	spin_lock_irqsave(&pci_config_lock, flags);
>  	outb_p(0x10, 0xcf8);
>  	b = inb_p(cmd640_key + reg);
>  	outb_p(0, 0xcf8);
> -	restore_flags(flags);
> +	spin_unlock_irqrestore(&pci_config_lock, flags);
>  	return b;
>  }
>  
> @@ -701,9 +699,62 @@
>  
>  #endif
>  
> +/**
> + *	pci_conf1	-	check for PCI type 1 configuration
> + *	
> + *	Issues a safe probe sequence for PCI configuration type 1 and
> + *	returns non-zero if conf1 is supported. Takes the pci_config lock
> + */
> + 
> +static int pci_conf1(void)
> +{
> +	u32 tmp;
> +	unsigned long flags;
> +	
> +	spin_lock_irqsave(&pci_config_lock, flags);
> +
> +	OUT_BYTE(0x01, 0xCFB);
> +	tmp = inl(0xCF8);
> +	outl(0x80000000, 0xCF8);
> +	if (inl(0xCF8) == 0x80000000) {
> +		spin_unlock_irqrestore(&pci_config_lock, flags);
> +		outl(tmp, 0xCF8);
> +		return 1;
> +	}
> +	outl(tmp, 0xCF8);
> +	spin_unlock_irqrestore(&pci_config_lock, flags);
> +	return 0;
> +}
> +
> +/**
> + *	pci_conf2	-	check for PCI type 2 configuration
> + *	
> + *	Issues a safe probe sequence for PCI configuration type 2 and
> + *	returns non-zero if conf2 is supported. Takes the pci_config lock.
> + */
> + 
> +
> +static int pci_conf2(void)
> +{
> +	unsigned long flags;
> +	spin_lock_irqsave(&pci_config_lock, flags);
> +	
> +	OUT_BYTE(0x00, 0xCFB);
> +	OUT_BYTE(0x00, 0xCF8);
> +	OUT_BYTE(0x00, 0xCFA);
> +	if (IN_BYTE(0xCF8) == 0x00 && IN_BYTE(0xCF8) == 0x00) {
> +		spin_unlock_irqrestore(&pci_config_lock, flags);
> +		return 1;
> +	}
> +	spin_unlock_irqrestore(&pci_config_lock, flags);
> +	return 0;
> +}
> +
> +
>  /*
>   * Probe for a cmd640 chipset, and initialize it if found.  Called from ide.c
>   */
> + 
>  int __init ide_probe_for_cmd640x(void)
>  {
>  #ifdef CONFIG_BLK_DEV_CMD640_ENHANCED
> @@ -718,9 +769,10 @@
>  		bus_type = "VLB";
>  	} else {
>  		cmd640_vlb = 0;
> -		if (probe_for_cmd640_pci1())
> +		/* Find out what kind of PCI probing is supported */
> +		if (pci_conf1() && probe_for_cmd640_pci1())
>  			bus_type = "PCI (type1)";
> -		else if (probe_for_cmd640_pci2())
> +		else if (pci_conf2() && probe_for_cmd640_pci2())
>  			bus_type = "PCI (type2)";
>  		else
>  			return 0;
> 

Andre Hedrick
LAD Storage Consulting Group

