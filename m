Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261251AbRETBMA>; Sat, 19 May 2001 21:12:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261252AbRETBLu>; Sat, 19 May 2001 21:11:50 -0400
Received: from are.twiddle.net ([64.81.246.98]:26885 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S261251AbRETBLj>;
	Sat, 19 May 2001 21:11:39 -0400
Date: Sat, 19 May 2001 18:11:27 -0700
From: Richard Henderson <rth@twiddle.net>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: alpha iommu fixes
Message-ID: <20010519181127.A14645@twiddle.net>
Mail-Followup-To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010518214617.A701@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010518214617.A701@jurassic.park.msu.ru>; from ink@jurassic.park.msu.ru on Fri, May 18, 2001 at 09:46:17PM +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 18, 2001 at 09:46:17PM +0400, Ivan Kokshaysky wrote:
> -void
> -cia_pci_tbi(struct pci_controller *hose, dma_addr_t start, dma_addr_t end)
> -{
> -	wmb();
> -	*(vip)CIA_IOC_PCI_TBIA = 3;	/* Flush all locked and unlocked.  */
> -	mb();
> -	*(vip)CIA_IOC_PCI_TBIA;
> -}

I'd rather keep this around.  It should be possible to use on CIA2.

> +/* Even if the tbia works, we cannot use it. It effectively locks the
> + * chip (as well as direct write to the tag registers) if there is a
> + * SG DMA operation in progress. This is true at least for PYXIS rev. 1.

Uggg.  How did you discover this?

> +/*	__save_and_cli(flags);	Don't need this -- we're called from
> +				pci_unmap_xx() or iommu_arena_alloc()
> +				with IPL_MAX after spin_lock_irqsave() */

Just delete it, don't comment it out.  You might mention in the
function header comment that we're called with interrupts disabled.

>  	*(vip)CIA_IOC_CIA_CTRL = ctrl;
>  	mb();
> -	*(vip)CIA_IOC_CIA_CTRL;
> -	mb();

I'm pretty sure you don't want to do this.  You're risking a
subsequent i/o being posted through the PCI bridge before this
takes effect.  An "mb" is only effective inside the CPU.



r~
