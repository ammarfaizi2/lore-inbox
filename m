Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129166AbQKQWN6>; Fri, 17 Nov 2000 17:13:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129171AbQKQWNs>; Fri, 17 Nov 2000 17:13:48 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:25102 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129166AbQKQWNa>;
	Fri, 17 Nov 2000 17:13:30 -0500
Message-ID: <3A15A638.86278EBB@mandrakesoft.com>
Date: Fri, 17 Nov 2000 16:42:16 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Adam J. Richter" <adam@yggdrasil.com>
CC: willy@meta-x.org, davem@redhat.com, linux-kernel@vger.kernel.org,
        wtarreau@yahoo.fr
Subject: Re: sunhme.c patch for new PCI interface (UNTESTED)
In-Reply-To: <200011160833.AAA06880@adam.yggdrasil.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Adam J. Richter" wrote:
> -static struct happy_meal *root_happy_dev = NULL;
> -
>  #ifdef CONFIG_SBUS
> +static struct happy_meal *root_happy_dev = NULL;
>  static struct quattro *qfe_sbus_list = NULL;
>  #endif

don't initialize static to zero/null explicitly..
> -       if (dev == NULL) {
> -               dev = init_etherdev(0, sizeof(struct happy_meal));
> -       } else {
> -               dev->priv = kmalloc(sizeof(struct happy_meal), GFP_KERNEL);
> -               if (dev->priv == NULL)
> -                       return -ENOMEM;
> -       }
> +       dev = init_etherdev(0, sizeof(struct happy_meal));

allocation failure not checked

> -static int __init happy_meal_pci_init(struct net_device *dev, struct pci_dev *pdev)
> +static int __devinit happy_meal_pci_probe(struct pci_dev *pdev,
> +                                         const struct pci_device_id *id)

Are you aware of any hotplug sunhme hardware?  If no, don't change it to
__devinit...

> -       if (dev == NULL) {
> -               dev = init_etherdev(0, sizeof(struct happy_meal));
> -       } else {
> -               dev->priv = kmalloc(sizeof(struct happy_meal), GFP_KERNEL);
> -               if (dev->priv == NULL)
> -                       return -ENOMEM;
> -       }
> +       dev = init_etherdev(0, sizeof(struct happy_meal));

check for failure.

also, ether_setup() call is not needed if you always call
init_etherdev(NULL, ...).


> +static void __devexit happy_meal_pci_remove (struct pci_dev *pdev)
> +{
> +       struct happy_meal *hp = pdev->driver_data;
> +
> +       pci_free_consistent(hp->happy_dev,
> +                           PAGE_SIZE,
> +                           hp->happy_block,
> +                           hp->hblock_dvma);
> +       unregister_netdev(hp->dev);
> +       kfree(hp->dev);
> +}

zero pdev->driver_data.  If this driver has to be portable, use
pci_{get,set}_drvdata() instead of directly accessing ::driver_data.

> +static struct pci_device_id happymeal_pci_ids[] __devinitdata = {

again, no __devxxx if not hotplug.

>  #ifdef CONFIG_PCI
> -       cards += happy_meal_pci_probe(dev);
> +       return pci_module_init(&happy_meal_pci_driver);
> +#else
> +       return (cards > 0) ? 0 : -ENODEV;
>  #endif

ifdef not needed

> +#ifdef CONFIG_PCI
> +       pci_unregister_driver (&happy_meal_pci_driver);
> +#endif

ifdef not needed.

-- 
Jeff Garzik             |
Building 1024           | The chief enemy of creativity is "good" sense
MandrakeSoft            |          -- Picasso
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
