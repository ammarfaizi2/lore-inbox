Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290730AbSBOTe1>; Fri, 15 Feb 2002 14:34:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290715AbSBOTd3>; Fri, 15 Feb 2002 14:33:29 -0500
Received: from nat-pool-meridian.redhat.com ([12.107.208.200]:41248 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S290688AbSBOTdG>; Fri, 15 Feb 2002 14:33:06 -0500
Date: Fri, 15 Feb 2002 14:33:01 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200202151933.g1FJX1S16673@devserv.devel.redhat.com>
To: dalecki@evision-ventures.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: cleanup for i810 chipset for 2.5.5-pre1. Second...
In-Reply-To: <mailman.1013758321.20800.linux-kernel2news@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0202141819080.30210-100000@Expansa.sns.it> <mailman.1013758321.20800.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> diff -ur linux-2.5.4/sound/oss/i810_audio.c linux/sound/oss/i810_audio.c
> --- linux-2.5.4/sound/oss/i810_audio.c	Thu Feb 14 23:26:47 2002
> +++ linux/sound/oss/i810_audio.c	Thu Feb 14 23:09:50 2002
> @@ -66,7 +66,7 @@
>   *
>   *	This driver is cursed. (Ben LaHaise)
>   */
> - 
> +
>  #include <linux/module.h>
>  #include <linux/version.h>
>  #include <linux/string.h>

Leave the syntax sugar out, will you? It's dledford's job to clean it.

> @@ -135,14 +135,17 @@
>  
>  /* the 810's array of pointers to data buffers */
>  
> +/* Since this structure get's accessed by the AC'97 codec device, we fixup the
> + * in core layout of it by adding the packed attribute here. */
> +
>  struct sg_item {
>  #define BUSADDR_MASK	0xFFFFFFFE
> -	u32 busaddr;	
> -#define CON_IOC 	0x80000000 /* interrupt on completion */
> +	u32 bus_addr;
> +#define CON_IOC		0x80000000 /* interrupt on completion */
>  #define CON_BUFPAD	0x40000000 /* pad underrun with last sample, else 0 */
>  #define CON_BUFLEN_MASK	0x0000ffff /* buffer length in samples */
>  	u32 control;
> -};
> +} __attribute__ ((packed));
>  
>  /* an instance of the i810 channel */
>  #define SG_LEN 32

Sounds like a nonsense to me. Show me one architecture that
does not pack the structure correctly without ((packed)).
You got Linux on CRAY-1 going?

> -			sg->busaddr=virt_to_bus(dmabuf->rawbuf+dmabuf->fragsize*i);
> +			sg->bus_addr= dmabuf->dma_handle + dmabuf->fragsize * i;

Close, but no cigar, see below.

> @@ -954,7 +957,7 @@
>  		}
>  		spin_lock_irqsave(&state->card->lock, flags);
>  		outb(2, state->card->iobase+c->port+OFF_CR);   /* reset DMA machine */
> -		outl(virt_to_bus(&c->sg[0]), state->card->iobase+c->port+OFF_BDBAR);
> +		outl(isa_virt_to_bus(&c->sg[0]), state->card->iobase+c->port+OFF_BDBAR);
>  		outb(0, state->card->iobase+c->port+OFF_CIV);
>  		outb(0, state->card->iobase+c->port+OFF_LVI);
>  

Why not to use pci_alloc_consistent here? I did it in 10 minutes,
even posted a patch here.

> @@ -1669,7 +1672,7 @@
>  	if (size > (PAGE_SIZE << dmabuf->buforder))
>  		goto out;
>  	ret = -EAGAIN;
> -	if (remap_page_range(vma->vm_start, virt_to_phys(dmabuf->rawbuf),
> +	if (remap_page_range(vma, vma->vm_start, virt_to_phys(dmabuf->rawbuf),
>  			     size, vma->vm_page_prot))
>  		goto out;
>  	dmabuf->mapped = 1;

OK

> -			outl(virt_to_bus(&c->sg[0]), state->card->iobase+c->port+OFF_BDBAR);
> +			outl(isa_virt_to_bus(&c->sg[0]), state->card->iobase+c->port+OFF_BDBAR);

Same as above - must be reworked.

-- Pete
