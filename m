Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030516AbVKXAIM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030516AbVKXAIM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 19:08:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932604AbVKXAIL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 19:08:11 -0500
Received: from mail.kroah.org ([69.55.234.183]:5324 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932599AbVKXAIJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 19:08:09 -0500
Date: Wed, 23 Nov 2005 16:07:54 -0800
From: Greg KH <greg@kroah.com>
To: Andrew Grover <andrew.grover@intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       john.ronciak@intel.com, christopher.leech@intel.com
Subject: Re: [RFC] [PATCH 1/3] ioat: DMA subsystem
Message-ID: <20051124000754.GA1059@kroah.com>
References: <Pine.LNX.4.44.0511231207410.32487-100000@isotope.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0511231207410.32487-100000@isotope.jf.intel.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2005 at 12:26:42PM -0800, Andrew Grover wrote:
> +static void
> +dma_class_release(struct class_device *cd)
> +{
> +	/* do something */
> +}

Well, then actually do something here.  Don't try to trick the kernel to
not complain about the lack of a release function by giving it an empty
function.  This is wrong.

> +static struct class dma_devclass = {
> +	.name		= "dma",
> +	.release	= dma_class_release,
> +	.class_dev_attrs = dma_class_attrs,
> +};

Why not just use class_device_create() and friends, instead of building
your own class this way?  It will take care of your "look at the lack of
my release function" issues, and make things easier to handle.

> +EXPORT_SYMBOL(dma_async_client_register);
> +EXPORT_SYMBOL(dma_async_client_unregister);
> +EXPORT_SYMBOL(dma_async_client_chan_request);
> +EXPORT_SYMBOL(dma_async_memcpy_buf_to_buf);
> +EXPORT_SYMBOL(dma_async_memcpy_buf_to_pg);
> +EXPORT_SYMBOL(dma_async_memcpy_pg_to_pg);
> +EXPORT_SYMBOL(dma_async_memcpy_complete);
> +EXPORT_SYMBOL(dma_async_memcpy_issue_pending);
> +EXPORT_SYMBOL(dma_async_device_register);
> +EXPORT_SYMBOL(dma_async_device_unregister);
> +EXPORT_SYMBOL(dma_async_wait_for_completion);
> +EXPORT_PER_CPU_SYMBOL(kick_dma_poll);

EXPORT_SYMBOL_GPL() perhaps?

> +/**
> + * enum dma_event_t - resource PNP/power managment events
> + * @DMA_RESOURCE_SUSPEND: DMA device going into low power state
> + * @DMA_RESOURCE_RESUME: DMA device returning to full power
> + * @DMA_RESOURCE_ADDED: DMA device added to the system
> + * @DMA_RESOURCE_REMOVED: DMA device removed from the system
> + */
> +enum dma_event_t {
> +	DMA_RESOURCE_SUSPEND,
> +	DMA_RESOURCE_RESUME,
> +	DMA_RESOURCE_ADDED,
> +	DMA_RESOURCE_REMOVED,
> +};

Why "_t" for an enum?

> +/**
> + * struct dma_device - info on the entity supplying DMA services
> + * @chancnt: how many DMA channels are supported
> + * @channels: the list of struct dma_chan
> + * @global_node: list_head for global dma_device_list
> + * Other func ptrs: used to make use of this device's capabilities
> + */
> +struct dma_device {
> +
> +	unsigned int chancnt;
> +	struct list_head channels;
> +	struct list_head global_node;
> +
> +	int dev_id;
> +	/*struct class_device class_dev;*/

Commented out?

> +	int (*device_alloc_chan_resources)(struct dma_chan *chan);
> +	void (*device_free_chan_resources)(struct dma_chan *chan);
> +	dma_cookie_t (*device_memcpy_buf_to_buf)(struct dma_chan *chan, void *dest,
> +		void *src, size_t len);
> +	dma_cookie_t (*device_memcpy_buf_to_pg)(struct dma_chan *chan, struct page *page,
> +		unsigned int offset, void *kdata, size_t len);
> +	dma_cookie_t (*device_memcpy_pg_to_pg)(struct dma_chan *chan, struct page *dest_pg,
> +		unsigned int dest_off, struct page *src_pg, unsigned int src_off,
> +		size_t len);
> +	void (*device_arm_interrupt)(struct dma_chan *chan);
> +	enum dma_status_t (*device_memcpy_complete)(struct dma_chan *chan, dma_cookie_t cookie, dma_cookie_t *last, dma_cookie_t *used);
> +	void (*device_memcpy_issue_pending)(struct dma_chan *chan);
> +};
> +
> +/* --- public DMA engine API --- */
> +
> +struct dma_client *
> +dma_async_client_register(dma_event_callback event_callback);
> +
> +void
> +dma_async_client_unregister(struct dma_client *client);
> +
> +void
> +dma_async_client_chan_request(struct dma_client *client, unsigned int number);

Put return types on the same line as the function please.

> +dma_cookie_t
> +dma_async_memcpy_buf_to_buf(
> +	struct dma_chan *chan,
> +	void *dest,
> +	void *src,
> +	size_t len);

Ick, don't duplicate the acpi coding style here please :)

> +static inline enum dma_status_t
> +dma_async_is_complete(
> +	dma_cookie_t cookie,
> +	dma_cookie_t last_complete,
> +	dma_cookie_t last_used) {
> +	

Trailing space :(

thanks,

greg k-h
