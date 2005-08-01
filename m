Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261329AbVHAWvv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261329AbVHAWvv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 18:51:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261283AbVHAVMg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 17:12:36 -0400
Received: from az33egw01.freescale.net ([192.88.158.102]:17804 "EHLO
	az33egw01.freescale.net") by vger.kernel.org with ESMTP
	id S261281AbVHAVMW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 17:12:22 -0400
In-Reply-To: <20050801201314.GC2473@redhat.com>
References: <20050801201314.GC2473@redhat.com>
Mime-Version: 1.0 (Apple Message framework v733)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <FF77F641-DA9B-422A-96D0-2BBA1F32A6A8@freescale.com>
Cc: <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
From: Kumar Gala <kumar.gala@freescale.com>
Subject: Re: i2c-mpc build fix.
Date: Mon, 1 Aug 2005 16:12:03 -0500
To: Dave Jones <davej@redhat.com>
X-Mailer: Apple Mail (2.733)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Let's be careful and not remove them twice.  I know Andrew's already  
sent a patch to linus to remove the duplication.

- kumar

On Aug 1, 2005, at 3:13 PM, Dave Jones wrote:

> Somehow, these functions got included twice.
>
> drivers/i2c/busses/i2c-mpc.c:386: error: redefinition of  
> 'fsl_i2c_probe'
> drivers/i2c/busses/i2c-mpc.c:292: error: previous definition of
> 'fsl_i2c_probe' was here
> drivers/i2c/busses/i2c-mpc.c:444: error: redefinition of
> 'fsl_i2c_remove'
> drivers/i2c/busses/i2c-mpc.c:350: error: previous definition of
> 'fsl_i2c_remove' was here
> drivers/i2c/busses/i2c-mpc.c:459: error: redefinition of
> 'fsl_i2c_driver'
> drivers/i2c/busses/i2c-mpc.c:365: error: previous definition of
> 'fsl_i2c_driver' was here
> drivers/i2c/busses/i2c-mpc.c:467: error: redefinition of  
> 'fsl_i2c_init'
> drivers/i2c/busses/i2c-mpc.c:373: error: previous definition of
> 'fsl_i2c_init' was here
> drivers/i2c/busses/i2c-mpc.c:472: error: redefinition of  
> 'fsl_i2c_exit'
> drivers/i2c/busses/i2c-mpc.c:378: error: previous definition of
> 'fsl_i2c_exit' was here
> drivers/i2c/busses/i2c-mpc.c:476: error: redefinition of '__inittest'
> drivers/i2c/busses/i2c-mpc.c:382: error: previous definition of
> '__inittest' was here
> drivers/i2c/busses/i2c-mpc.c:476: error: redefinition of 'init_module'
> drivers/i2c/busses/i2c-mpc.c:382: error: previous definition of
> 'init_module' was here
> drivers/i2c/busses/i2c-mpc.c:477: error: redefinition of '__exittest'
> drivers/i2c/busses/i2c-mpc.c:383: error: previous definition of
> '__exittest' was here
> drivers/i2c/busses/i2c-mpc.c:477: error: redefinition of
> 'cleanup_module'
> drivers/i2c/busses/i2c-mpc.c:383: error: previous definition of
> 'cleanup_module' was here
>
> Signed-off-by: Dave Jones <davej@redhat.com>
>
>
> --- linux-2.6.12/drivers/i2c/busses/i2c-mpc.c~    2005-08-01
> 16:07:47.000000000 -0400
> +++ linux-2.6.12/drivers/i2c/busses/i2c-mpc.c    2005-08-01
> 16:10:31.000000000 -0400
> @@ -382,100 +382,6 @@ static void __exit fsl_i2c_exit(void)
>  module_init(fsl_i2c_init);
>  module_exit(fsl_i2c_exit);
>
> -static int fsl_i2c_probe(struct device *device)
> -{
> -    int result = 0;
> -    struct mpc_i2c *i2c;
> -    struct platform_device *pdev = to_platform_device(device);
> -    struct fsl_i2c_platform_data *pdata;
> -    struct resource *r = platform_get_resource(pdev, IORESOURCE_MEM,
> 0);
> -
> -    pdata = (struct fsl_i2c_platform_data *)
> pdev->dev.platform_data;
> -
> -    if (!(i2c = kmalloc(sizeof(*i2c), GFP_KERNEL))) {
> -        return -ENOMEM;
> -    }
> -    memset(i2c, 0, sizeof(*i2c));
> -
> -    i2c->irq = platform_get_irq(pdev, 0);
> -    i2c->flags = pdata->device_flags;
> -    init_waitqueue_head(&i2c->queue);
> -
> -    i2c->base = ioremap((phys_addr_t)r->start, MPC_I2C_REGION);
> -
> -    if (!i2c->base) {
> -        printk(KERN_ERR "i2c-mpc - failed to map controller\n");
> -        result = -ENOMEM;
> -        goto fail_map;
> -    }
> -
> -    if (i2c->irq != 0)
> -        if ((result = request_irq(i2c->irq, mpc_i2c_isr,
> -                      SA_SHIRQ, "i2c-mpc", i2c)) <
> 0) {
> -            printk(KERN_ERR
> -                   "i2c-mpc - failed to attach
> interrupt\n");
> -            goto fail_irq;
> -        }
> -
> -    mpc_i2c_setclock(i2c);
> -    dev_set_drvdata(device, i2c);
> -
> -    i2c->adap = mpc_ops;
> -    i2c_set_adapdata(&i2c->adap, i2c);
> -    i2c->adap.dev.parent = &pdev->dev;
> -    if ((result = i2c_add_adapter(&i2c->adap)) < 0) {
> -        printk(KERN_ERR "i2c-mpc - failed to add adapter\n");
> -        goto fail_add;
> -    }
> -
> -    return result;
> -
> -      fail_add:
> -    if (i2c->irq != 0)
> -        free_irq(i2c->irq, NULL);
> -      fail_irq:
> -    iounmap(i2c->base);
> -      fail_map:
> -    kfree(i2c);
> -    return result;
> -};
> -
> -static int fsl_i2c_remove(struct device *device)
> -{
> -    struct mpc_i2c *i2c = dev_get_drvdata(device);
> -
> -    i2c_del_adapter(&i2c->adap);
> -    dev_set_drvdata(device, NULL);
> -
> -    if (i2c->irq != 0)
> -        free_irq(i2c->irq, i2c);
> -
> -    iounmap(i2c->base);
> -    kfree(i2c);
> -    return 0;
> -};
> -
> -/* Structure for a device driver */
> -static struct device_driver fsl_i2c_driver = {
> -    .name = "fsl-i2c",
> -    .bus = &platform_bus_type,
> -    .probe = fsl_i2c_probe,
> -    .remove = fsl_i2c_remove,
> -};
> -
> -static int __init fsl_i2c_init(void)
> -{
> -    return driver_register(&fsl_i2c_driver);
> -}
> -
> -static void __exit fsl_i2c_exit(void)
> -{
> -    driver_unregister(&fsl_i2c_driver);
> -}
> -
> -module_init(fsl_i2c_init);
> -module_exit(fsl_i2c_exit);
> -
>  MODULE_AUTHOR("Adrian Cox <adrian@humboldt.co.uk>");
>  MODULE_DESCRIPTION
>      ("I2C-Bus adapter for MPC107 bridge and MPC824x/85xx/52xx
> processors");
> -
> To unsubscribe from this list: send the line "unsubscribe linux- 
> kernel"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

