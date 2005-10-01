Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750798AbVJALcc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750798AbVJALcc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Oct 2005 07:32:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750801AbVJALcc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Oct 2005 07:32:32 -0400
Received: from wproxy.gmail.com ([64.233.184.202]:36489 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750798AbVJALcb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Oct 2005 07:32:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=i+Jq1QvhsFRWtiU11LhIf3I/EKOgT0r5wE4ltkT/CEmFKsTQtSx6Ydj9iJQAiJHYi4D/IQYkx7db0JckYILS2wUMaIbFZ1yupsmy+XMvFg8H8t6p5GlxK2BYyTrbpGcJxfjfKihkVY2cV1/KYO0prtPKBhhnC+wi/fjVEJOsvk0=
Message-ID: <3888a5cd0510010432h52ede401g6fe34b7f93a3c342@mail.gmail.com>
Date: Sat, 1 Oct 2005 13:32:30 +0200
From: Jiri Slaby <lnx4us@gmail.com>
Reply-To: Jiri Slaby <lnx4us@gmail.com>
To: dsaxena@plexity.net
Subject: Re: [PATCH] [I2C] kmalloc + memset -> kzalloc conversion
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org
In-Reply-To: <20051001073631.GK25424@plexity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051001073631.GK25424@plexity.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/1/05, Deepak Saxena <dsaxena@plexity.net> wrote:
>
> Signed-off-by: Deepak Saxena <dsaxena@plexity.net>
>
[snip]
> --- a/drivers/i2c/busses/i2c-keywest.c
> +++ b/drivers/i2c/busses/i2c-keywest.c
> @@ -535,13 +535,12 @@ create_iface(struct device_node *np, str
>
>         tsize = sizeof(struct keywest_iface) +
>                 (sizeof(struct keywest_chan) + 4) * nchan;
> -       iface = (struct keywest_iface *) kmalloc(tsize, GFP_KERNEL);
> +       iface = (struct keywest_iface *) kzalloc(tsize, GFP_KERNEL);
cast isn't needed
>         if (iface == NULL) {
>                 printk(KERN_ERR "i2c-keywest: can't allocate inteface !\n");
>                 pmac_low_i2c_unlock(np);
>                 return -ENOMEM;
>         }
> -       memset(iface, 0, tsize);
>         spin_lock_init(&iface->lock);
>         init_completion(&iface->complete);
>         iface->node = of_node_get(np);
> diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
> --- a/drivers/i2c/busses/i2c-mpc.c
> +++ b/drivers/i2c/busses/i2c-mpc.c
> @@ -296,10 +296,9 @@ static int fsl_i2c_probe(struct device *
>
>         pdata = (struct fsl_i2c_platform_data *) pdev->dev.platform_data;
>
> -       if (!(i2c = kmalloc(sizeof(*i2c), GFP_KERNEL))) {
> +       if (!(i2c = kzalloc(sizeof(*i2c), GFP_KERNEL))) {
>                 return -ENOMEM;
>         }
> -       memset(i2c, 0, sizeof(*i2c));
>
>         i2c->irq = platform_get_irq(pdev, 0);
>         i2c->flags = pdata->device_flags;
> diff --git a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2c-mv64xxx.c
> --- a/drivers/i2c/busses/i2c-mv64xxx.c
> +++ b/drivers/i2c/busses/i2c-mv64xxx.c
> @@ -500,13 +500,11 @@ mv64xxx_i2c_probe(struct device *dev)
>         if ((pd->id != 0) || !pdata)
>                 return -ENODEV;
>
> -       drv_data = kmalloc(sizeof(struct mv64xxx_i2c_data), GFP_KERNEL);
> +       drv_data = kzalloc(sizeof(struct mv64xxx_i2c_data), GFP_KERNEL);
>
>         if (!drv_data)
>                 return -ENOMEM;
>
> -       memset(drv_data, 0, sizeof(struct mv64xxx_i2c_data));
> -
>         if (mv64xxx_i2c_map_regs(pd, drv_data)) {
>                 rc = -ENODEV;
>                 goto exit_kfree;
> diff --git a/drivers/i2c/busses/i2c-nforce2.c b/drivers/i2c/busses/i2c-nforce2.c
> --- a/drivers/i2c/busses/i2c-nforce2.c
> +++ b/drivers/i2c/busses/i2c-nforce2.c
> @@ -313,10 +313,9 @@ static int __devinit nforce2_probe(struc
>         int res1, res2;
>
>         /* we support 2 SMBus adapters */
> -       if (!(smbuses = (void *)kmalloc(2*sizeof(struct nforce2_smbus),
> +       if (!(smbuses = (void *)kzalloc(2*sizeof(struct nforce2_smbus),
>                                         GFP_KERNEL)))
cast from (void*) to (void*)? No...
