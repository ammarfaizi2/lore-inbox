Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317512AbSGXUMQ>; Wed, 24 Jul 2002 16:12:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317521AbSGXUMQ>; Wed, 24 Jul 2002 16:12:16 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:46725 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S317512AbSGXUKu>; Wed, 24 Jul 2002 16:10:50 -0400
Date: Wed, 24 Jul 2002 16:14:02 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200207242014.g6OKE2K21460@devserv.devel.redhat.com>
To: "Christoph Baumann" <cb@sorcus.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Resolving physical addresses (change in 2.4.x?)
In-Reply-To: <mailman.1027491420.32334.linux-kernel2news@redhat.com>
References: <mailman.1027491420.32334.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Even recognizing these as unmapped and resolving anew, produced a frozen
> machine once the DMA used these addresses. Was there a change in 2.4.x so
> that my resolving routine now works incorrect?
> 
> /*resolve virt. addresses to phys.*/
> unsigned long ch_get_physpage(unsigned long virtaddr)
> {
>   /*Stuff for browsing through the memory page tables*/
>   pgd_t *pgd_t_dir;
>   pmd_t *pmd_t_dir;
>   pte_t *pte_t_dir;
> 
>   /*Get physical address*/
>   pgd_t_dir=pgd_offset(current->mm,virtaddr);
>   pmd_t_dir=pmd_offset(pgd_t_dir,virtaddr);
>   pte_t_dir=pte_offset(pmd_t_dir,virtaddr);
>   return virt_to_bus((void *)pte_page(*pte_t_dir));
> }

Are you crazy? This routing could NEVER work; pge_page returns
a pointer to a struct page. I always was suspicious of this
technique; even if you find out how to use page_address,
what do you do about the bus address? On some architectures,
the bus address is only known to the part that manages a
north bridge; it may even be stored in hardware registers.
No matter how popular this trick is, it is highly illegal.

To work properly, your driver has to remember virtual and bus
addresses that were mapped with pci_alloc_sg. They are returned to
you for this very purpose. In most cases you have to to track I/Os 
anyway, so just add a field to whatever management structure you use.

-- Pete
