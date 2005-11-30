Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750706AbVK3UpS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750706AbVK3UpS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 15:45:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750732AbVK3UpS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 15:45:18 -0500
Received: from mail.kroah.org ([69.55.234.183]:37266 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750706AbVK3UpQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 15:45:16 -0500
Date: Wed, 30 Nov 2005 11:54:43 -0800
From: Greg KH <greg@kroah.com>
To: Vitaly Wool <vwool@ru.mvista.com>
Cc: linux-kernel@vger.kernel.org, david-b@pacbell.net, dpervushin@gmail.com,
       akpm@osdl.org, basicmark@yahoo.com, komal_shah802003@yahoo.com,
       stephen@streetfiresound.com, spi-devel-general@lists.sourceforge.net,
       Joachim_Jaeger@digi.com
Subject: Re: [PATCH 2.6-git] SPI core refresh
Message-ID: <20051130195443.GB13952@kroah.com>
References: <20051130195053.713ea9ef.vwool@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051130195053.713ea9ef.vwool@ru.mvista.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30, 2005 at 07:50:53PM +0300, Vitaly Wool wrote:
> Greetings,
> 
> This is an updated version of SPI framework developed by Dmitry Pervushin and Vitaly Wool.
> 
> The main changes are:
> 
> - Matching rmk's 2.6.14-git5+ changes for device_driver suspend and resume calls
> - The character device interface was reworked
> 
> I still think that we need to continue converging with David
> Brownell's core, despite some misalignments happening in the email
> exchange :). Although it's not yet done in our core, I plan to move to 
> - using chained SPI messages as David does
> - maybe rework the SPI device interface more taking David's one as a reference

I think you both need to work together to come to some kind of
understanding before either one can make it into mainline.

> However, there also are some advantages of our core compared to David's I'd like to mention
> 
> - it can be compiled as a module
> - it is DMA-safe

What do you mean by this?

> - it is priority inversion-free

And David's isn't?

> - it can gain more performance with multiple controllers

What do you mean by this?

> - it's more adapted for use in real-time environments

Again, more explaination please.

> - it's not so lightweight, but it leaves less effort for the bus driver developer.

So bus drivers are smaller than David's?  But with what tradeoffs?

> +#define kzalloc(size,type) kcalloc(1,size,type)

kzalloc is already a kernel function, please don't overload it.

> +#define TO_SPI_DEV(device) container_of( device, struct spi_device, dev )
> +struct spi_device {
> +	char name[BUS_ID_SIZE];
> +	void *private;

struct device already has a private pointer, please use that.

> +	int minor;
> +	struct class_device *cdev;

struct class_device has a dev_t, why not use that?

> +#define spi_device_lock( dev )		/* down( dev->dev.sem ) */
> +#define spi_device_unlock( dev )	/* up( dev->dev.sem ) */

Um, that doesn't look good...


> +
> +/*
> + * struct spi_msg
> + *
> + * This structure represent the SPI message internally. You should never use fields of this structure directly

Proper line lenght please.

And document these structures using kerneldoc, explaining what the
different fields are.  Especially for new stuff like this.

> + * Please use corresponding functions to create/destroy/access fields

Those functions are?

> + *
> + */
> +struct spi_msg {
> +	u32  flags;
> +#define SPI_M_RD	0x00000001
> +#define SPI_M_WR	0x00000002	/**< Write mode flag */
> +#define SPI_M_CSREL	0x00000004	/**< CS release level at end of the frame  */
> +#define SPI_M_CS	0x00000008	/**< CS active level at begining of frame ( default low ) */
> +#define SPI_M_CPOL	0x00000010	/**< Clock polarity */
> +#define SPI_M_CPHA	0x00000020	/**< Clock Phase */
> +#define SPI_M_EXTBUF	0x80000000    	/** externally allocated buffers */
> +#define SPI_M_ASYNC_CB	0x40000000      /** use workqueue to deliver callbacks */
> +#define SPI_M_DNA	0x20000000	/** do not allocate buffers */
> +
> +	unsigned short len;	/* msg length           */

u16 perhaps?

> +	unsigned long clock;

Do you really want unsigned long here?

> +	struct spi_device *device;
> +	void *context;
> +	void *arg;
> +	void *parent;		/* in case of complex messages */

That's a lot of void pointers, not good.

> +	struct list_head link;
> +
> +	void (*status) (struct spi_msg * msg, int code);
> +
> +	void *devbuf_rd, *devbuf_wr;

What are these for?

> +	u8 *databuf_rd, *databuf_wr;
> +
> +	struct work_struct wq_item;
> +};
> +
> +#ifdef CONFIG_SPI_CHARDEV
> +extern struct class_device *spi_class_device_create(int minor, struct device *device);
> +extern void spi_class_device_destroy(int minor);
> +#else
> +#define spi_class_device_create(a, b)		NULL
> +#define spi_class_device_destroy(a)		do { } while (0)

Make these inline to get typechecking if the option is disabled.

> +#endif
> +
> +static inline struct spi_msg *spimsg_alloc(struct spi_device *device,
> +					   unsigned flags,
> +					   unsigned short len,
> +					   void (*status) (struct spi_msg *,
> +							   int code))
> +{
> +	struct spi_msg *msg;
> +	struct spi_driver *drv = SPI_DEV_DRV(device);
> +	int msgsize = sizeof (struct spi_msg);
> +
> +	if (drv->alloc || (flags & (SPI_M_RD|SPI_M_WR)) == (SPI_M_RD | SPI_M_WR ) ) {
> +		pr_debug ( "%s: external buffers\n", __FUNCTION__ );
> +		flags |= SPI_M_EXTBUF;
> +	} else {
> +		pr_debug ("%s: no ext buffers, msgsize increased from %d by %d to %d\n", __FUNCTION__,
> +				msgsize, len, msgsize + len );
> +		msgsize += len;
> +	}
> +
> +	msg = kmalloc( msgsize, GFP_KERNEL);
> +	if (!msg)
> +		return NULL;
> +	memset(msg, 0, sizeof(struct spi_msg));
> +	msg->len = len;
> +	msg->status = status;
> +	msg->device = device;
> +	msg->flags = flags;
> +	INIT_LIST_HEAD(&msg->link);
> +
> +	if (flags & SPI_M_DNA )
> +		return msg;
> +
> +	/* otherwise, we need to set up pointers */
> +	if (!(flags & SPI_M_EXTBUF)) {
> +		msg->databuf_rd = msg->databuf_wr =
> +			(u8*)msg + sizeof ( struct spi_msg);
> +	} else {
> +		if (flags & SPI_M_RD) {
> +			msg->devbuf_rd = drv->alloc ?
> +		    		drv->alloc(len, GFP_KERNEL) : kmalloc(len, GFP_KERNEL);
> +			msg->databuf_rd = drv->get_buffer ?
> +		    		drv->get_buffer(device, msg->devbuf_rd) : msg->devbuf_rd;
> +		}
> +		if (flags & SPI_M_WR) {
> +			msg->devbuf_wr = drv->alloc ?
> +		    		drv->alloc(len, GFP_KERNEL) : kmalloc(len, GFP_KERNEL);
> +			msg->databuf_wr = drv->get_buffer ?
> +		    		drv->get_buffer(device, msg->devbuf_wr) : msg->devbuf_wr;
> +		}
> +	}
> +	pr_debug("%s: msg = %p, RD=(%p,%p) WR=(%p,%p). Actual flags = %s+%s\n",
> +		 __FUNCTION__,
> +		 msg,
> +		 msg->devbuf_rd, msg->databuf_rd,
> +		 msg->devbuf_wr, msg->databuf_wr,
> +		 msg->flags & SPI_M_RD ? "RD" : "~rd",
> +		 msg->flags & SPI_M_WR ? "WR" : "~wr");
> +	return msg;
> +}
> +
> +static inline void spimsg_free(struct spi_msg *msg)
> +{
> +	void (*do_free) (const void *) = kfree;
> +	struct spi_driver *drv = SPI_DEV_DRV(msg->device);
> +
> +	if (msg) {
> +
> +		if ( !(msg->flags & SPI_M_DNA) || (msg->flags & SPI_M_EXTBUF) ) {
> +			if (drv->free)
> +				do_free = drv->free;
> +			if (drv->release_buffer) {
> +				if (msg->databuf_rd)
> +					drv->release_buffer(msg->device,
> +						    msg->databuf_rd);
> +				if (msg->databuf_wr)
> +					drv->release_buffer(msg->device,
> +						    msg->databuf_wr);
> +			}
> +			if (msg->devbuf_rd)
> +				do_free(msg->devbuf_rd);
> +			if (msg->devbuf_wr)
> +				do_free(msg->devbuf_wr);
> +		}
> +		kfree(msg);
> +	}
> +}

These are all pretty big functions to be inline in a .h file, don't you
think?

> +extern int spi_bus_populate(struct device *parent, char *device,
> +			    void (*assign) (struct device *parent,
> +					    struct spi_device *));
> +struct spi_device_desc {
> +	char* name;
> +	void* params;
> +};
> +extern int spi_bus_populate2(struct device *parent,
> +			     struct spi_device_desc *devices,
> +			     void (*assign) (struct device *parent,
> +				             struct spi_device *,
> +					     void *));

Where is spi_bus_populate3 and 4?  :)

thanks.

greg k-h
