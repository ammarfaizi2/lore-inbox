Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932137AbVH3EvZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932137AbVH3EvZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 00:51:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932141AbVH3EvZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 00:51:25 -0400
Received: from wproxy.gmail.com ([64.233.184.207]:63252 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932137AbVH3EvY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 00:51:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bOK+pxLv21AGpxWNwyipPtMX+m6b7ooqhzMpCRshUw8zUjpgjY7JrFN6yPVfJIEsHqRN32saHPOkaRIMJDtrwx/ocgl3FJIk65lu1ApIiPvbqwV6IWMAvnQMJ32iYfEQ/IYGZVKelKBcFNWssusSDsdl6aBJUovhvVKcapB6pII=
Message-ID: <9e473391050829215148807c49@mail.gmail.com>
Date: Tue, 30 Aug 2005 00:51:23 -0400
From: Jon Smirl <jonsmirl@gmail.com>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Ignore disabled ROM resources at setup
Cc: "David S. Miller" <davem@davemloft.net>, benh@kernel.crashing.org,
       linux-kernel@vger.kernel.org, greg@kroah.com, helgehaf@aitel.hist.no
In-Reply-To: <Pine.LNX.4.58.0508292125571.3243@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1125371996.11963.37.camel@gaston>
	 <Pine.LNX.4.58.0508292045590.3243@g5.osdl.org>
	 <Pine.LNX.4.58.0508292056530.3243@g5.osdl.org>
	 <20050829.212021.43291105.davem@davemloft.net>
	 <Pine.LNX.4.58.0508292125571.3243@g5.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/30/05, Linus Torvalds <torvalds@osdl.org> wrote:
> 
> 
> On Mon, 29 Aug 2005, David S. Miller wrote:
> >
> > So I think the kernel, by not enabling the ROM, is doing the
> > right thing here.
> 
> Notice that on ppc even older versions didn't actually _enable_ the rom,
> but they would write the non-enabled address to the PCI_ROM_ADDRESS
> register, so that anybody who read that register would see _where_ the ROM
> would be enabled if it was enabled.
> 
> That's the thing that changed in the commit Ben dislikes. Now, if the ROM
> is disabled, we won't even write the disabled address to the PCI register,
> because it led to trouble on some strange Matrox card. Probably a card
> that nobody has ever used on PPC, and certainly not on a Powerbook, so in
> that sense the apparent breakage on ppc is arguably "unnecessary" as far
> as Ben is concerned.
> 
> But I notice the problem: pci_enable_rom() is indeed broken with the
> change.
> 
> Ben, does this (totally untested) patch fix it for you?
> 
>                         Linus
> 
> ----
> diff --git a/drivers/pci/rom.c b/drivers/pci/rom.c
> --- a/drivers/pci/rom.c
> +++ b/drivers/pci/rom.c
> @@ -23,11 +23,14 @@
>   */
>  static void pci_enable_rom(struct pci_dev *pdev)
>  {
> -       u32 rom_addr;
> +       struct resource *res = pdev->resource + PCI_ROM_RESOURCE;
> +       struct pci_bus_region region;
> 
> -       pci_read_config_dword(pdev, pdev->rom_base_reg, &rom_addr);
> -       rom_addr |= PCI_ROM_ADDRESS_ENABLE;
> -       pci_write_config_dword(pdev, pdev->rom_base_reg, rom_addr);
> +       if (!res->flags)
> +               return;
> +
> +       pcibios_resource_to_bus(pdev, &region, res);
> +       pci_write_config_dword(pdev, pdev->rom_base_reg, region.start | PCI_ROM_ADDRESS_ENABLE);
>  }

I was reading the status out of the PCI config space to account for
our friend X which enables ROMs without informing the OS. With X
around PCI config space can get out of sync with the kernel
structures.


> 
>  /**
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


-- 
Jon Smirl
jonsmirl@gmail.com
