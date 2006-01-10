Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751099AbWAJPFx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751099AbWAJPFx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 10:05:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751101AbWAJPFx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 10:05:53 -0500
Received: from wproxy.gmail.com ([64.233.184.196]:22607 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751099AbWAJPFw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 10:05:52 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ltwWjHCoxSGg96eUF6agOb+HCeQOelo/UbO0NoJ6r5htNkY+UbKn5wLzhXxBiXYBmSuZTBj1Z/Qg6iBpMw0LQtdYp4lEoM/y5MqsBpA1Evf9r2R4vhjNFmq9IOT3qk59DjYdnaDb3UVCmFZ/JZVPPWKDdDaHO0M7lTesMPIy9Pg=
Message-ID: <37219a840601100705i61066fa4ufca7caa7390ca341@mail.gmail.com>
Date: Tue, 10 Jan 2006 10:05:51 -0500
From: Michael Krufky <mkrufky@gmail.com>
To: Russell King <rmk@arm.linux.org.uk>,
       Linux and Kernel Video <video4linux-list@redhat.com>
Subject: Re: [CFT 3/3] Add bttv sub bus_type probe and remove methods
Cc: LKML <linux-kernel@vger.kernel.org>, Greg K-H <greg@kroah.com>
In-Reply-To: <20060106114059.13.32@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060105142951.13.01@flint.arm.linux.org.uk>
	 <20060106114059.13.32@flint.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/6/06, Russell King <rmk@arm.linux.org.uk> wrote:
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
>
> (This is an additional patch - on lkml, see
>  "[CFT 1/29] Add bus_type probe, remove, shutdown methods.")
>
> ---
>  drivers/media/dvb/bt8xx/dvb-bt8xx.c |   23 +++++++++++------------
>  drivers/media/video/bttv-gpio.c     |   24 ++++++++++++++++++++++--
>  drivers/media/video/bttv.h          |    2 ++
>  drivers/media/video/ir-kbd-gpio.c   |   17 ++++++++---------
>  4 files changed, 43 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/media/dvb/bt8xx/dvb-bt8xx.c b/drivers/media/dvb/bt8xx/dvb-bt8xx.c
> --- a/drivers/media/dvb/bt8xx/dvb-bt8xx.c
> +++ b/drivers/media/dvb/bt8xx/dvb-bt8xx.c
> @@ -787,9 +787,8 @@ static int __init dvb_bt8xx_load_card(st
>         return 0;
>  }
>
> -static int dvb_bt8xx_probe(struct device *dev)
> +static int dvb_bt8xx_probe(struct bttv_sub_device *sub)
>  {
> -       struct bttv_sub_device *sub = to_bttv_sub_dev(dev);
>         struct dvb_bt8xx_card *card;
>         struct pci_dev* bttv_pci_dev;
>         int ret;
> @@ -907,13 +906,13 @@ static int dvb_bt8xx_probe(struct device
>                 return ret;
>         }
>
> -       dev_set_drvdata(dev, card);
> +       dev_set_drvdata(&sub->dev, card);
>         return 0;
>  }
>
> -static int dvb_bt8xx_remove(struct device *dev)
> +static int dvb_bt8xx_remove(struct bttv_sub_device *sub)
>  {
> -       struct dvb_bt8xx_card *card = dev_get_drvdata(dev);
> +       struct dvb_bt8xx_card *card = dev_get_drvdata(&sub->dev);
>
>         dprintk("dvb_bt8xx: unloading card%d\n", card->bttv_nr);
>
> @@ -936,14 +935,14 @@ static int dvb_bt8xx_remove(struct devic
>  static struct bttv_sub_driver driver = {
>         .drv = {
>                 .name           = "dvb-bt8xx",
> -               .probe          = dvb_bt8xx_probe,
> -               .remove         = dvb_bt8xx_remove,
> -               /* FIXME:
> -                * .shutdown    = dvb_bt8xx_shutdown,
> -                * .suspend     = dvb_bt8xx_suspend,
> -                * .resume      = dvb_bt8xx_resume,
> -                */
>         },
> +       .probe          = dvb_bt8xx_probe,
> +       .remove         = dvb_bt8xx_remove,
> +       /* FIXME:
> +        * .shutdown    = dvb_bt8xx_shutdown,
> +        * .suspend     = dvb_bt8xx_suspend,
> +        * .resume      = dvb_bt8xx_resume,
> +        */
>  };
>
>  static int __init dvb_bt8xx_init(void)
> diff --git a/drivers/media/video/bttv-gpio.c b/drivers/media/video/bttv-gpio.c
> --- a/drivers/media/video/bttv-gpio.c
> +++ b/drivers/media/video/bttv-gpio.c
> @@ -47,9 +47,29 @@ static int bttv_sub_bus_match(struct dev
>         return 0;
>  }
>
> +static int bttv_sub_probe(struct device *dev)
> +{
> +       struct bttv_sub_device *sdev = to_bttv_sub_dev(dev);
> +       struct bttv_sub_driver *sub = to_bttv_sub_drv(dev->driver);
> +
> +       return sub->probe ? sub->probe(sdev) : -ENODEV;
> +}
> +
> +static int bttv_sub_remove(struct device *dev)
> +{
> +       struct bttv_sub_device *sdev = to_bttv_sub_dev(dev);
> +       struct bttv_sub_driver *sub = to_bttv_sub_drv(dev->driver);
> +
> +       if (sub->remove)
> +               sub->remove(sdev);
> +       return 0;
> +}
> +
>  struct bus_type bttv_sub_bus_type = {
> -       .name  = "bttv-sub",
> -       .match = &bttv_sub_bus_match,
> +       .name   = "bttv-sub",
> +       .match  = &bttv_sub_bus_match,
> +       .probe  = bttv_sub_probe,
> +       .remove = bttv_sub_remove,
>  };
>  EXPORT_SYMBOL(bttv_sub_bus_type);
>
> diff --git a/drivers/media/video/bttv.h b/drivers/media/video/bttv.h
> --- a/drivers/media/video/bttv.h
> +++ b/drivers/media/video/bttv.h
> @@ -334,6 +334,8 @@ struct bttv_sub_device {
>  struct bttv_sub_driver {
>         struct device_driver   drv;
>         char                   wanted[BUS_ID_SIZE];
> +       int                    (*probe)(struct bttv_sub_device *sub);
> +       void                   (*remove)(struct bttv_sub_device *sub);
>         void                   (*gpio_irq)(struct bttv_sub_device *sub);
>         int                    (*any_irq)(struct bttv_sub_device *sub);
>  };
> diff --git a/drivers/media/video/ir-kbd-gpio.c b/drivers/media/video/ir-kbd-gpio.c
> --- a/drivers/media/video/ir-kbd-gpio.c
> +++ b/drivers/media/video/ir-kbd-gpio.c
> @@ -319,15 +319,15 @@ module_param(repeat_period, int, 0644);
>         printk(KERN_DEBUG DEVNAME ": " fmt , ## arg)
>
>  static void ir_irq(struct bttv_sub_device *sub);
> -static int ir_probe(struct device *dev);
> -static int ir_remove(struct device *dev);
> +static int ir_probe(struct bttv_sub_device *sub);
> +static int ir_remove(struct bttv_sub_device *sub);
>
>  static struct bttv_sub_driver driver = {
>         .drv = {
>                 .name   = DEVNAME,
> -               .probe  = ir_probe,
> -               .remove = ir_remove,
>         },
> +       .probe          = ir_probe,
> +       .remove         = ir_remove,
>         .gpio_irq       = ir_irq,
>  };
>
> @@ -570,9 +570,8 @@ static void ir_rc5_timer_keyup(unsigned
>
>  /* ---------------------------------------------------------------------- */
>
> -static int ir_probe(struct device *dev)
> +static int ir_probe(struct bttv_sub_device *sub)
>  {
> -       struct bttv_sub_device *sub = to_bttv_sub_dev(dev);
>         struct IR *ir;
>         struct input_dev *input_dev;
>         IR_KEYTAB_TYPE *ir_codes = NULL;
> @@ -707,7 +706,7 @@ static int ir_probe(struct device *dev)
>         }
>
>         /* all done */
> -       dev_set_drvdata(dev, ir);
> +       dev_set_drvdata(&sub->dev, ir);
>         input_register_device(ir->input);
>
>         /* the remote isn't as bouncy as a keyboard */
> @@ -717,9 +716,9 @@ static int ir_probe(struct device *dev)
>         return 0;
>  }
>
> -static int ir_remove(struct device *dev)
> +static int ir_remove(struct bttv_sub_device *sub)
>  {
> -       struct IR *ir = dev_get_drvdata(dev);
> +       struct IR *ir = dev_get_drvdata(&sub->dev);
>
>         if (ir->polling) {
>                 del_timer(&ir->timer);
>
> --
> video4linux-list mailing list
> Unsubscribe mailto:video4linux-list-request@redhat.com?subject=unsubscribe
> https://www.redhat.com/mailman/listinfo/video4linux-list
>

Russell-

I apologize for not emailing you earlier... I didnt see this patch
originally, but I saw it this morning in GregKH's quilt tree...

We've gotten rid of ir-kbd-gpio.c , in favor of bttv-input.c ...

This change hit Linus' tree yesterday.

http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=4abdfed5676e5ef7f2461bb76f5929068a9cc9cf

Please regenerate your patch.

Thanks,

Michael Krufky
