Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263170AbVHEUn2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263170AbVHEUn2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 16:43:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261988AbVHEUn2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 16:43:28 -0400
Received: from smtp.osdl.org ([65.172.181.4]:39641 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263170AbVHEUlX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 16:41:23 -0400
Date: Fri, 5 Aug 2005 13:38:37 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: yhlu <yhlu.kernel@gmail.com>
cc: Roland Dreier <rolandd@cisco.com>, linville@tuxdriver.com,
       Greg KH <gregkh@suse.de>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       openib-general@openib.org
Subject: Re: mthca and LinuxBIOS
In-Reply-To: <86802c44050805132853070f1@mail.gmail.com>
Message-ID: <Pine.LNX.4.58.0508051335440.3258@g5.osdl.org>
References: <20057281331.dR47KhjBsU48JfGE@cisco.com> <521x59a6tb.fsf@cisco.com>
  <86802c440508041230143354c2@mail.gmail.com> <52slxp6o5b.fsf@cisco.com> 
 <86802c440508051103500f6942@mail.gmail.com>  <86802c4405080511079d01532@mail.gmail.com>
 <52psss5k1x.fsf@cisco.com>  <86802c44050805112661d889aa@mail.gmail.com> 
 <86802c4405080512254b9cd496@mail.gmail.com>  <86802c4405080512451cdcae48@mail.gmail.com>
 <86802c44050805132853070f1@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hmm.. This looks half-way sane, but too ugly for words.

I'd much rather see that when we detect a 64-bit resource, we always mark 
the next resource as being reserved some way, and then we just make 
pci_update_resource() ignore such reserved resources.

The

		if((resno & 1)==1) {
			/* check if previous reg is 64 mem */
			..

stuff is really too ugly.

Greg? Ivan?

		Linus


On Fri, 5 Aug 2005, yhlu wrote:
>
> please check the patch for fix overwrite upper 32bit 
> 
> YH
> 
> --- drivers/pci/setup-res.c.orig        2005-08-05 10:08:45.000000000 -0700
> +++ drivers/pci/setup-res.c     2005-08-05 13:25:06.000000000 -0700
> @@ -33,6 +33,18 @@
>         u32 new, check, mask;
>         int reg;
> 
> +        if (resno < 6) {
> +                reg = PCI_BASE_ADDRESS_0 + 4 * resno;
> +                if((resno & 1)==1) {
> +                        /* check if previous reg is 64 mem */
> +                        pci_read_config_dword(dev, reg-4, &check );
> +                        if ((check &
> (PCI_BASE_ADDRESS_SPACE|PCI_BASE_ADDRESS_MEM_TYPE_MASK)) ==
> +                           
> (PCI_BASE_ADDRESS_SPACE_MEMORY|PCI_BASE_ADDRESS_MEM_TYPE_64))
> +                                return;
> +                }
> +
> +        }
> +
>         pcibios_resource_to_bus(dev, &region, res);
> 
>         pr_debug("  got res [%lx:%lx] bus [%lx:%lx] flags %lx for "
> @@ -67,7 +79,7 @@
> 
>         if ((new & (PCI_BASE_ADDRESS_SPACE|PCI_BASE_ADDRESS_MEM_TYPE_MASK)) ==
>             (PCI_BASE_ADDRESS_SPACE_MEMORY|PCI_BASE_ADDRESS_MEM_TYPE_64)) {
> -               new = 0; /* currently everyone zeros the high address */
> +               new = region.start >> 32 ;
>                 pci_write_config_dword(dev, reg + 4, new);
>                 pci_read_config_dword(dev, reg + 4, &check);
>                 if (check != new) {
> 
