Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263018AbVHENe6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263018AbVHENe6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 09:34:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263015AbVHENe5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 09:34:57 -0400
Received: from wproxy.gmail.com ([64.233.184.204]:16978 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263018AbVHENe4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 09:34:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=qqFE4B81Qt+GXYv2Xj1vWnhI4ZXQwYKquNc0AsRDfvCwGvtQTdXJyNIPrXputZEaD/91xi+Q/udvDSP5PNh0gM1Asxy4PNcCsOO/r5bEie8caDlJPk9DTNgBh3Ao6jpV8RSYU2MkXYL64S2UBa5AKj9CzYMYrrEExIHhnJFaono=
Date: Fri, 5 Aug 2005 17:43:04 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Jamey Hicks <jamey@handhelds.org>
Cc: Andrew Zabolotny <anpaza@mail.ru>, Russell King <rmk@arm.linux.org.uk>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: platform-device-driver-for-mq11xx-graphics-chip.patch added to -mm tree
Message-ID: <20050805134304.GA3852@mipter.zuzino.mipt.ru>
References: <200508050719.j757J9KO032652@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508050719.j757J9KO032652@shell0.pdx.osdl.net>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 05, 2005 at 12:18:03AM -0700, akpm@osdl.org wrote:
> From: Jamey Hicks <jamey@handhelds.org>
> 
> This patch adds platform_device driver for MQ11xx system-on-chip graphics
> chip.  This chip is used in several non-PCI ARM and MIPS platforms such as
> the iPAQ H5550.  Two subsequent patches add support for the framebuffer and
> USB gadget subdevices.  This patch adds the toplevel driver to
> drivers/platform because it does not provide any specific functionality
> (e.g., framebuffer) and it not tied to a named physical bus.  In these
> platforms, the MQ11xx is tied directly to the host bus.
> 
> Signed-off-by: Jamey Hicks <jamey@handhelds.org>
> Signed-off-by: Andrew Zabolotny <anpaza@mail.ru>
> Cc: Russell King <rmk@arm.linux.org.uk>
> Signed-off-by: Andrew Morton <akpm@osdl.org>

> --- /dev/null
> +++ devel-akpm/drivers/platform/mq11xx_base.c

> +#include <linux/version.h>

Unneeded.

> +static void
> +mq_setfreeblocks (struct mq_data *mqdata, int nblocks)
> +{

> +		temp = kmalloc (newmax * sizeof (struct mq_freemem_list),
> +				GFP_KERNEL);
> +		memcpy (temp, mqdata->freelist, nfb * sizeof (struct mq_freemem_list));

Unchecked kmalloc().

> +static int
> +mq_initialize (struct device *dev, int num_resources,
> +	       struct resource *resource, int instance)
> +{
> +	int i, j, k, rc, chipmask;
> +	struct mq_data *mqdata;
> +	struct mediaq11xx_init_data *init_data =
> +		(struct mediaq11xx_init_data *)dev->platform_data;
> +
> +	if (!init_data || num_resources != 4) {
> +		printk (KERN_ERR "mq11xx_base: Incorrect platform resources!\n");
> +		return -ENODEV;
> +	}
> +
> +	mqdata = kmalloc (sizeof (struct mq_data), GFP_KERNEL);
> +	if (!mqdata)
> +		return -ENOMEM;
> +	memset (mqdata, 0, sizeof (struct mq_data));
> +	dev_set_drvdata (dev, mqdata);
> +
> +#define IOREMAP(v, n, el) \
> +	mqdata->base.v = ioremap (resource[n].start, \
> +		resource[n].end - resource[n].start + 1); \
> +	if (!mqdata->base.v) goto el; \
> +	mqdata->base.paddr_##v = resource[n].start;
> +
> +	IOREMAP (gfxram, 0, err0);
> +	IOREMAP (ram, 1, err1);
> +	IOREMAP (regs, 2, err2);
> +
> +#undef IOREMAP
> +
> +	/* Check how much RAM is accessible through the unsynced window */
> +	mqdata->unsynced_ram_skip =
> +		(resource [0].end - resource [0].start) -
> +		(resource [1].end - resource [1].start);
> +	mqdata->base.ram -= mqdata->unsynced_ram_skip;
> +	mqdata->base.paddr_ram -= mqdata->unsynced_ram_skip;
> +
> +	mqdata->ndevices = MQ_SUBDEVS_REAL_COUNT;
> +	mqdata->devices = kmalloc (mqdata->ndevices *
> +		(sizeof (struct platform_device)), GFP_KERNEL);
> +	if (!mqdata->devices)
> +		goto err3;
> +
> +	mqdata->mq_init = init_data;
> +	if (mq11xx_init (mqdata)) {
> +		printk (KERN_ERR "MediaQ device initialization failed!\n");
		printk (KERN_NOTICE "leaking mqdata, mqdata->base.gfxram, "
				    "mqdata->base.ram, mqdata->base.regs, "
				    "mqdata->devices\n");

> +		return -ENODEV;
> +	}

> +	mqdata->freelist = kmalloc (MEMBLOCK_MINCOUNT * sizeof (struct mq_freemem_list),
> +				    GFP_KERNEL);
> +	mqdata->freelist [0].addr = 0;

Unchecked kmalloc().

> +		res = kmalloc (sdev->num_resources * sizeof (struct resource), GFP_KERNEL);
> +		sdev->resource = res;
> +		memset (res, 0, sdev->num_resources * sizeof (struct resource));

Unchecked kmalloc().

> +		mqdata->power_on [i] = 1;;
					^^

> +static int
> +mq_remove (struct device *dev)
> +{
> +	return mq_finalize (dev);
> +}

	.remove = mq_finalize,
or
	s/mq_finalize/mq_remove/g

> +static void
> +mq_shutdown (struct device *dev)
> +{
> +	//struct mq_data *mqdata = dev_get_drvdata (dev);
> +}
> +
> +static int
> +mq_suspend (struct device *dev, u32 state, u32 level)

pm_message_t state

> +{
> +	//struct mq_data *mqdata = dev_get_drvdata (dev);
> +	return 0;
> +}
> +
> +static int
> +mq_resume (struct device *dev, u32 level)
> +{
> +	//struct mq_data *mqdata = dev_get_drvdata (dev);
> +	return 0;
> +}

Pass NULL? Add them later when they'll be implemented.

> --- /dev/null
> +++ devel-akpm/drivers/platform/mq11xx.h
> @@ -0,0 +1,925 @@
> +/*
> + * drivers/misc/soc/mq11xx.h

Not true.

> +/* This union uses unnamed structs. This is a gcc extension, but what the
> + * hell, the kernel is not compilable by anything else anyway...

icc

> --- /dev/null
> +++ devel-akpm/drivers/platform/.tmp_versions/mq11xx_base.mod
> @@ -0,0 +1,2 @@
> +drivers/platform/mq11xx_base.ko
> +drivers/platform/mq11xx_base.o

Drop this.

Casts to "void *" in iounmap() are bogus.

Is this correct?

--- linux-platform.orig/drivers/platform/mq11xx.h
+++ linux-platform/drivers/platform/mq11xx.h
@@ -821,15 +821,15 @@ enum
  */
 struct mediaq11xx_base {
 	/* Memory that is serialized between CPU and gfx engine */
-	u8 *gfxram;
+	u8 __iomem *gfxram;
 	/* Memory that is not synchronized between CPU and GE.
 	 * WARNING: NEVER TOUCH MEMORY ALLOCATED WITH THE 'gfx' FLAG
 	 * (SEE BELOW) VIA THE "ram" POINTER!!! SUCH ADDRESSES CAN BE
 	 * BOGUS AND POSSIBLY BELONG TO OTHER PROCESS OR DRIVER!!!
 	 */
-	volatile u8 *ram;
+	volatile u8 __iomem *ram;
 	/* MediaQ registers */
-	volatile struct mediaq11xx_regs *regs;
+	volatile struct mediaq11xx_regs __iomem *regs;
 	/* Chip flavour */
 	int chip;
 	/* Chip name (1132, 1178 etc) */

