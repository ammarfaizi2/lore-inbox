Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261801AbVGGB27@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261801AbVGGB27 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 21:28:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262376AbVGGB26
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 21:28:58 -0400
Received: from wproxy.gmail.com ([64.233.184.207]:21228 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261801AbVGGB1L convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 21:27:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NlVQg2eqYrzCNZqfpEH9uWqsLXqX+o/rNodQwWNpyAaYXER+BGte4T9l3HEdWk8RLjBPRz5A2YbP/ZdQ2lqBqLm5yGBtxFd+lK0OvZf5JA05cJEIviuFvHSo3G/ZdBEcHI3iQpRx8p22KBuPzUlGEEpY/ooPfDW+CrCiOVVcy+U=
Message-ID: <9e47339105070618273dfb6ff8@mail.gmail.com>
Date: Wed, 6 Jul 2005 21:27:11 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Tero Roponen <teanropo@cc.jyu.fi>, ink@jurassic.park.msu.ru
Subject: Re: 2.6.13-rc2 hangs at boot
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.58.0507061638380.13297@tukki.cc.jyu.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.GSO.4.58.0507061638380.13297@tukki.cc.jyu.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm dead on a Dell PE400SC without reverting this.

On 7/6/05, Tero Roponen <teanropo@cc.jyu.fi> wrote:
> Hi,
> 
> my computer (a ThinkPad 380XD laptop) hangs at boot in 2.6.13-rc2.
> When I revert the patch below everything seems to be fine.
> 
> thanks,
> Tero Roponen
> 
> 
> Patch to revert:
> 
> Author: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
> Date: Wed, 15 Jun 2005 14:59:27 +0000 (+0400)
> Source: http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=299de0343c7d18448a69c635378342e9214b14af
> 
>   [PATCH] PCI: pci_assign_unassigned_resources() on x86
> 
>   - Add sanity check for io[port,mem]_resource in setup-bus.c. These
>     resources look like "free" as they have no parents, but obviously
>     we must not touch them.
>   - In i386.c:pci_allocate_bus_resources(), if a bridge resource cannot be
>     allocated for some reason, then clear its flags. This prevents any child
>     allocations in this range, so the setup-bus code will work with a clean
>     resource sub-tree.
>   - i386.c:pcibios_enable_resources() doesn't enable bridges, as it checks
>     only resources 0-5, which looks like a clear bug to me. I suspect it
>     might break hotplug as well in some cases.
> 
>   From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
>   Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
> 
> --- a/arch/i386/pci/common.c
> +++ b/arch/i386/pci/common.c
> @@ -165,6 +165,7 @@ static int __init pcibios_init(void)
>         if ((pci_probe & PCI_BIOS_SORT) && !(pci_probe & PCI_NO_SORT))
>                 pcibios_sort();
>  #endif
> +       pci_assign_unassigned_resources();
>         return 0;
>  }
> 
> --- a/arch/i386/pci/i386.c
> +++ b/arch/i386/pci/i386.c
> @@ -106,11 +106,16 @@ static void __init pcibios_allocate_bus_
>                 if ((dev = bus->self)) {
>                         for (idx = PCI_BRIDGE_RESOURCES; idx < PCI_NUM_RESOURCES; idx++) {
>                                 r = &dev->resource[idx];
> -                               if (!r->start)
> +                               if (!r->flags)
>                                         continue;
>                                 pr = pci_find_parent_resource(dev, r);
> -                               if (!pr || request_resource(pr, r) < 0)
> +                               if (!r->start || !pr || request_resource(pr, r) < 0) {
>                                         printk(KERN_ERR "PCI: Cannot allocate resource region %d of bridge %s\n", idx, pci_name(dev));
> +                                       /* Something is wrong with the region.
> +                                          Invalidate the resource to prevent child
> +                                          resource allocations in this range. */
> +                                       r->flags = 0;
> +                               }
>                         }
>                 }
>                 pcibios_allocate_bus_resources(&bus->children);
> @@ -227,7 +232,7 @@ int pcibios_enable_resources(struct pci_
> 
>         pci_read_config_word(dev, PCI_COMMAND, &cmd);
>         old_cmd = cmd;
> -       for(idx=0; idx<6; idx++) {
> +       for(idx = 0; idx < PCI_NUM_RESOURCES; idx++) {
>                 /* Only set up the requested stuff */
>                 if (!(mask & (1<<idx)))
>                         continue;
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -273,6 +273,8 @@ find_free_bus_resource(struct pci_bus *b
> 
>         for (i = 0; i < PCI_BUS_NUM_RESOURCES; i++) {
>                 r = bus->resource[i];
> +               if (r == &ioport_resource || r == &iomem_resource)
> +                       continue;
>                 if (r && (r->flags & type_mask) == type && !r->parent)
>                         return r;
>         }
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


-- 
Jon Smirl
jonsmirl@gmail.com
