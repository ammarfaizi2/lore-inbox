Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135474AbRDWP6x>; Mon, 23 Apr 2001 11:58:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135484AbRDWP6n>; Mon, 23 Apr 2001 11:58:43 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:30136 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S135474AbRDWP63>;
	Mon, 23 Apr 2001 11:58:29 -0400
Message-ID: <3AE45121.926C4B51@mandrakesoft.com>
Date: Mon, 23 Apr 2001 11:58:25 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Marcus Meissner <Marcus.Meissner@caldera.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] es1371 pci fix/cleanup
In-Reply-To: <20010423175158.A15604@caldera.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcus Meissner wrote:
> 
> Hi,
> 
> This moves pci_enable_device in the es1371 driver before any resource
> access and also replaces the RSRCISIOREGION by just pci_resource_flags
> as suggested by Jeff.
> 
> Tested and verified.
> 
> Ciao, Marcus
> 
> Index: drivers/sound/es1371.c
> ===================================================================
> RCS file: /build/mm/work/repository/linux-mm/drivers/sound/es1371.c,v
> retrieving revision 1.7
> diff -u -r1.7 es1371.c
> --- drivers/sound/es1371.c      2001/04/17 17:26:05     1.7
> +++ drivers/sound/es1371.c      2001/04/23 15:49:15
> @@ -2771,9 +2771,6 @@
>         { SOUND_MIXER_WRITE_IGAIN, 0x4040 }
>  };
> 
> -#define RSRCISIOREGION(dev,num) (pci_resource_start((dev), (num)) != 0 && \
> -                                (pci_resource_flags((dev), (num)) & IORESOURCE_IO))
> -
>  static int __devinit es1371_probe(struct pci_dev *pcidev, const struct pci_device_id *pciid)
>  {
>         struct es1371_state *s;
> @@ -2783,8 +2780,11 @@
>         signed long tmo2;
>         unsigned int cssr;
> 
> -       if (!RSRCISIOREGION(pcidev, 0))
> +       if (pci_enable_device(pcidev))
>                 return -1;
> +
> +       if (!(pci_resource_flags(pcidev, 0) & IORESOURCE_IO))
> +               return -1;
>         if (pcidev->irq == 0)
>                 return -1;

Looks ok except error returns.

pci_enable_device - obtain its return value, and return that.

no IORESOURCE_IO or pcidev->irq==0 - I guess -ENODEV would be
appropriate.  (basically look at errno.h and make a judgement call which
error best fits the situation)

-- 
Jeff Garzik      | The difference between America and England is that
Building 1024    | the English think 100 miles is a long distance and
MandrakeSoft     | the Americans think 100 years is a long time.
                 |      (random fortune)
