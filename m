Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131484AbRDWQME>; Mon, 23 Apr 2001 12:12:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132616AbRDWQLz>; Mon, 23 Apr 2001 12:11:55 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:44472 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S131484AbRDWQLg>;
	Mon, 23 Apr 2001 12:11:36 -0400
Message-ID: <3AE45437.8A185AF4@mandrakesoft.com>
Date: Mon, 23 Apr 2001 12:11:35 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Marcus Meissner <Marcus.Meissner@caldera.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] es1371 pci fix/cleanup
In-Reply-To: <20010423175158.A15604@caldera.de> <3AE45121.926C4B51@mandrakesoft.com> <20010423180653.A16759@caldera.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcus Meissner wrote:
> Hmm, I think I spotted all places in the probe function. I also return
> -ENODEV in case we can't request_region() or request_irq().
> 
> Some drivers use EBUSY, some ENOMEM, some ENODEV there, is there
> any standard return value?

request_region/request_mem_region - EBUSY
request_irq - return its return value

> Ciao, Marcus
> 
> Index: drivers/sound/es1371.c
> ===================================================================
> RCS file: /build/mm/work/repository/linux-mm/drivers/sound/es1371.c,v
> retrieving revision 1.7
> diff -u -r1.7 es1371.c
> --- drivers/sound/es1371.c      2001/04/17 17:26:05     1.7
> +++ drivers/sound/es1371.c      2001/04/23 16:03:34
> @@ -2771,22 +2771,22 @@
>         { SOUND_MIXER_WRITE_IGAIN, 0x4040 }
>  };
> 
> -#define RSRCISIOREGION(dev,num) (pci_resource_start((dev), (num)) != 0 && \
> -                                (pci_resource_flags((dev), (num)) & IORESOURCE_IO))
> -
>  static int __devinit es1371_probe(struct pci_dev *pcidev, const struct pci_device_id *pciid)
>  {
>         struct es1371_state *s;
>         mm_segment_t fs;
> -       int i, val;
> +       int i, val, res = -1;
>         unsigned long tmo;
>         signed long tmo2;
>         unsigned int cssr;
> +
> +       if ((res=pci_enable_device(pcidev)))
> +               return res;
> 
> -       if (!RSRCISIOREGION(pcidev, 0))
> -               return -1;
> +       if (!(pci_resource_flags(pcidev, 0) & IORESOURCE_IO))
> +               return -ENODEV;
>         if (pcidev->irq == 0)
> -               return -1;
> +               return -ENODEV;
>         i = pci_set_dma_mask(pcidev, 0xffffffff);
>         if (i) {
>                 printk(KERN_WARNING "es1371: architecture does not support 32bit PCI busmaster DMA\n");
> @@ -2794,7 +2794,7 @@
>         }
>         if (!(s = kmalloc(sizeof(struct es1371_state), GFP_KERNEL))) {
>                 printk(KERN_WARNING PFX "out of memory\n");
> -               return -1;
> +               return -ENOMEM;
>         }
>         memset(s, 0, sizeof(struct es1371_state));
>         init_waitqueue_head(&s->dma_adc.wait);

this part looks ok

> @@ -2822,8 +2822,6 @@
>                 printk(KERN_ERR PFX "io ports %#lx-%#lx in use\n", s->io, s->io+ES1371_EXTENT-1);
>                 goto err_region;
>         }
> -       if (pci_enable_device(pcidev))
> -               goto err_irq;
>         if (request_irq(s->irq, es1371_interrupt, SA_SHIRQ, "es1371", s)) {
>                 printk(KERN_ERR PFX "irq %u in use\n", s->irq);
>                 goto err_irq;
> @@ -2964,7 +2962,7 @@
>         release_region(s->io, ES1371_EXTENT);
>   err_region:
>         kfree(s);
> -       return -1;
> +       return -ENODEV;
>  }
> 
>  static void __devinit es1371_remove(struct pci_dev *dev)

Since you need to propagate return values from different situations,
have an 'err' variable.  Right before each goto err_foo statement, set
err=Exxxxx.  Then, at the very end of the function, return the value of
'err'.  For a request_region failure, set err to EBUSY before calling
goto.  For a request_irq failure, have 'err' take the return value of
request_irq.

	Jeff


-- 
Jeff Garzik      | The difference between America and England is that
Building 1024    | the English think 100 miles is a long distance and
MandrakeSoft     | the Americans think 100 years is a long time.
                 |      (random fortune)
