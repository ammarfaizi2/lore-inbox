Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030451AbVKWWo0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030451AbVKWWo0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 17:44:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030457AbVKWWo0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 17:44:26 -0500
Received: from mail.dvmed.net ([216.237.124.58]:27782 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030461AbVKWWoX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 17:44:23 -0500
Message-ID: <4384F0C4.1090209@pobox.com>
Date: Wed, 23 Nov 2005 17:44:20 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Grover <andrew.grover@intel.com>
CC: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       john.ronciak@intel.com, christopher.leech@intel.com
Subject: Re: [RFC] [PATCH 1/3] ioat: DMA subsystem
References: <Pine.LNX.4.44.0511231207410.32487-100000@isotope.jf.intel.com>
In-Reply-To: <Pine.LNX.4.44.0511231207410.32487-100000@isotope.jf.intel.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Mostly ok, but some minor nits. Andrew Grover wrote: >
	index 0000000..f2cc2d7 > --- /dev/null > +++ b/drivers/dma/cb_list.h >
	@@ -0,0 +1,12 @@ > +/* Extra macros that build on <linux/list.h> */ >
	+#ifndef CB_LIST_H > +#define CB_LIST_H > + > +#include <linux/list.h>
	> + > +/* Provide some safty to list_add, which I find easy to swap the
	arguments to */ > + > +#define list_add_entry(pos, head, member)
	list_add(&pos->member, head) > +#define list_add_entry_tail(pos, head,
	member) list_add_tail(&pos->member, head) > + > +#endif /* CB_LIST_H */
	[...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Mostly ok, but some minor nits.



Andrew Grover wrote:
> index 0000000..f2cc2d7
> --- /dev/null
> +++ b/drivers/dma/cb_list.h
> @@ -0,0 +1,12 @@
> +/* Extra macros that build on <linux/list.h> */
> +#ifndef CB_LIST_H
> +#define CB_LIST_H
> +
> +#include <linux/list.h>
> +
> +/* Provide some safty to list_add, which I find easy to swap the arguments to */
> +
> +#define list_add_entry(pos, head, member)      list_add(&pos->member, head)
> +#define list_add_entry_tail(pos, head, member) list_add_tail(&pos->member, head)
> +
> +#endif /* CB_LIST_H */

Maybe this just adds fuel to the fire, given your code comment, but I 
tend to think most people are used to

	object_foo(object, other args...)

where the object in question is "the list".  That would imply a

	list_foo(head, others args...)

pattern.

As a side note, I have the same problem as you, WRT swapping the 
list_add arguments.  I've always thought that was the one big drawback 
to Linus's otherwise elegant list implementation.

general nits:

1) docbook-able function headers, with useful documentation, would be 
nice.  Using libata as an example, even if I don't provide any useful 
function description, I at least document the locking details/context 
for each function.

2) more inline code commenting would be nice.



> +			if (chan->device->device_alloc_chan_resources(chan) >= 0) {
> +				chan->client = client;
> +				list_add_entry_tail(chan, &client->channels, client_node);
> +				return chan;
> +			}


device_alloc_chan_resources is a very long name.  :)


> +static void
> +dma_client_chan_free(struct dma_chan *chan)
> +{
> +	BUG_ON(!chan);
> +
> +	chan->device->device_free_chan_resources(chan);
> +	chan->client = NULL;
> +}

ditto


> +static void
> +dma_chans_rebalance(void)

explanation of this function would be nice.  remember to answer "how?" 
and "why?", not "what?".


> +{
> +	struct dma_client *client;
> +	struct dma_chan *chan;
> +
> +	list_for_each_entry(client, &dma_client_list, global_node) {

locking of dma_client_list?

> +		while (client->chans_desired > client->chan_count) {
> +			chan = dma_client_chan_alloc(client);
> +			if (!chan)
> +				break;
> +
> +			client->chan_count++;
> +			client->event_callback(client, chan, DMA_RESOURCE_ADDED);
> +		}
> +
> +		while (client->chans_desired < client->chan_count) {
> +			chan = list_entry(client->channels.next, struct dma_chan, client_node);
> +			list_del(&chan->client_node);
> +			client->chan_count--;
> +			client->event_callback(client, chan, DMA_RESOURCE_REMOVED);
> +			dma_client_chan_free(chan);

In general, this DMA_RESOURCE_REMOVED operation feels like a "yanking 
the carpet out from under my feet" operation, something we should avoid 
for object-lifetime reasons.

However in this case, AFAICS dmaengine.c completely controls object 
lifetime, so I do not see a real problem.  I'm just nervous.  :)


> +		}
> +	}
> +}
> +
> +struct dma_client *
> +dma_async_client_register(dma_event_callback event_callback)
> +{
> +	struct dma_client *client;
> +
> +	BUG_ON(!event_callback);
> +
> +	client = kmalloc(sizeof(*client), GFP_KERNEL);
> +	if (!client)
> +		return NULL;
> +
> +	INIT_LIST_HEAD(&client->channels);
> +
> +	client->chans_desired = 0;
> +	client->chan_count = 0;
> +	client->event_callback = event_callback;
> +
> +	list_add_entry_tail(client, &dma_client_list, global_node);
> +
> +	return client;

Possible SMP bug here?

So far, in my code read, I was presuming that the caller was doing some 
sort of locking on dma_client_list and dma_device_list.  (Hint: need 
locking docs for each function)

But if you are using GFP_KERNEL, it certainly appears that two callers 
could race with each other when touching dma_client_list.



> +dma_cookie_t
> +dma_async_memcpy_buf_to_buf(
> +	struct dma_chan *chan,
> +	void *dest,
> +	void *src,
> +	size_t len)
> +{
> +	chan->bytes_transferred += len;
> +	chan->memcpy_count++;
> +
> +	return chan->device->device_memcpy_buf_to_buf(chan, dest, src, len);
> +}
> +
> +dma_cookie_t
> +dma_async_memcpy_buf_to_pg(
> +	struct dma_chan *chan,
> +	struct page *page,
> +	unsigned int offset,
> +	void *kdata,
> +	size_t len)
> +{
> +	chan->bytes_transferred += len;
> +	chan->memcpy_count++;
> +
> +	return chan->device->device_memcpy_buf_to_pg(chan, page, offset, kdata, len);
> +}
> +
> +dma_cookie_t
> +dma_async_memcpy_pg_to_pg(
> +	struct dma_chan *chan,
> +	struct page *dest_pg,
> +	unsigned int dest_off,
> +	struct page *src_pg,
> +	unsigned int src_off,
> +	size_t len)
> +{
> +	chan->bytes_transferred += len;
> +	chan->memcpy_count++;
> +
> +	return chan->device->device_memcpy_pg_to_pg(chan, dest_pg, dest_off,
> +		src_pg, src_off, len);
> +}
> +
> +void
> +dma_async_memcpy_issue_pending(struct dma_chan *chan)
> +{
> +	return chan->device->device_memcpy_issue_pending(chan);
> +}
> +
> +enum dma_status_t
> +dma_async_memcpy_complete(struct dma_chan *chan, dma_cookie_t cookie, dma_cookie_t *last, dma_cookie_t *used)
> +{
> +	return chan->device->device_memcpy_complete(chan, cookie, last, used);
> +}

Making these 'static inline' might be a good idea?


> +int
> +dma_async_device_register(struct dma_device *device)
> +{
> +	static int id;
> +	int chancnt = 0;
> +	struct dma_chan* chan;
> +
> +	if (!device)
> +		return -ENODEV;
> +
> +	list_add_entry_tail(device, &dma_device_list, global_node);
> +
> +	dma_chans_rebalance();
> +
> +	device->dev_id = id++;
> +
> +	/* represent channels in sysfs. Probably want devs too */
> +	list_for_each_entry(chan, &device->channels, device_node) {
> +		chan->chan_id = chancnt++;
> +		chan->class_dev.class = &dma_devclass;
> +		chan->class_dev.dev = NULL;
> +		snprintf(chan->class_dev.class_id, BUS_ID_SIZE, "dma%dchan%d",
> +			device->dev_id, chan->chan_id);
> +
> +		chan->min_copy_size = DMA_DEFAULT_MIN_COPY_SIZE;
> +		class_device_register(&chan->class_dev);
> +	}
> +
> +	return 0;
> +}
> +
> +void
> +dma_async_device_unregister(struct dma_device* device)
> +{
> +	struct dma_chan *chan;
> +
> +	BUG_ON(!device);
> +
> +	list_for_each_entry(chan, &device->channels, device_node) {
> +		if (chan->client) {
> +			list_del(&chan->client_node);
> +			chan->client->chan_count--;
> +			chan->client->event_callback(chan->client, chan, DMA_RESOURCE_REMOVED);
> +			dma_client_chan_free(chan);
> +		}
> +		class_device_unregister(&chan->class_dev);
> +	}
> +
> +	list_del(&device->global_node);
> +
> +	dma_chans_rebalance();
> +}
> +
> +static struct workqueue_struct *dma_wait_wq;
> +static LIST_HEAD(dma_poll_list);
> +
> +enum dma_status_t
> +dma_async_wait_for_completion(struct dma_chan *chan, dma_cookie_t cookie)
> +{
> +	while (dma_async_memcpy_complete(chan, cookie, NULL, NULL) == DMA_IN_PROGRESS)
> +		schedule();

1) Is it worth adding a loop above the 'while', which does

	retries = 5
	while (operation == in progress &&
	       retries-- > 0)
		udelay(1)

2) at that point, perhaps replace schedule() with schedule_timeout(1). 
WARNING:  this might introduce too much latency, and be a bad idea.


> +	return DMA_SUCCESS;
> +}
> +
> +#if 0
> +static void
> +dma_poll(void *data)
> +{
> +	struct dma_completion *comp = data;
> +
> +	comp->status = dma_memcpy_complete(comp->chan, comp->cookie);
> +	while (comp->status == DMA_IN_PROGRESS) {
> +		comp->chan->device->device_arm_interrupt(comp->chan);
> +		wait_for_completion(&__get_cpu_var(kick_dma_poll));
> +		comp->status = dma_memcpy_complete(comp->chan, comp->cookie);
> +	}
> +	complete(&comp->comp);
> +}
> +
> +enum dma_status_t
> +dma_wait_for_completion(struct dma_chan *chan, dma_cookie_t cookie)
> +{
> +	enum dma_status_t status;
> +	DECLARE_DMA_COMPLETION(comp, chan, cookie);
> +	DECLARE_WORK(dma_wait_work, dma_poll, &comp);
> +
> +	BUG_ON(in_interrupt());
> +
> +	status = dma_memcpy_complete(chan, cookie);
> +	if (status != DMA_IN_PROGRESS)
> +		return status;
> +
> +	queue_work(dma_wait_wq, &dma_wait_work);
> +	wait_for_completion(&comp.comp);
> +	return comp.status;
> +}
> +#endif

is this for future use?  never to be used?


> +static int __init dma_bus_init(void)
> +{
> +	int cpu;
> +
> +	dma_wait_wq = create_workqueue("dmapoll");

dma_wait_wq is never used, due to #if 0


> +	for_each_online_cpu(cpu) {
> +		init_completion(&per_cpu(kick_dma_poll, cpu));
> +	}
> +	return class_register(&dma_devclass);
> +}
> +
> +subsys_initcall(dma_bus_init);
> +
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
> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> new file mode 100644
> index 0000000..7b4f58b
> --- /dev/null
> +++ b/include/linux/dmaengine.h
> @@ -0,0 +1,268 @@
> +/*******************************************************************************
> +
> +  
> +  Copyright(c) 2004 - 2005 Intel Corporation. All rights reserved.
> +  
> +  This program is free software; you can redistribute it and/or modify it 
> +  under the terms of the GNU General Public License as published by the Free 
> +  Software Foundation; either version 2 of the License, or (at your option) 
> +  any later version.
> +  
> +  This program is distributed in the hope that it will be useful, but WITHOUT 
> +  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or 
> +  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for 
> +  more details.
> +  
> +  You should have received a copy of the GNU General Public License along with
> +  this program; if not, write to the Free Software Foundation, Inc., 59 
> +  Temple Place - Suite 330, Boston, MA  02111-1307, USA.
> +  
> +  The full GNU General Public License is included in this distribution in the
> +  file called LICENSE.
> +  
> +*******************************************************************************/
> +
> +
> +#ifndef DMAENGINE_H
> +#define DMAENGINE_H
> +
> +#include <linux/device.h>
> +#include <linux/uio.h>
> +#include <linux/skbuff.h>
> +
> +DECLARE_PER_CPU(struct completion, kick_dma_poll);
> +
> +#define DMA_DEFAULT_MIN_COPY_SIZE 16
> +
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
> +
> +/**
> + * typedef dma_cookie_t
> + *
> + * if dma_cookie_t is >0 it's a DMA request cookie, <0 it's an error code
> + */
> +typedef s32 dma_cookie_t;

More natural to use [signed] long?  i.e. a machine int.  Or _must_ this 
match hardware somewhere?


> +/*#define dma_submit_error(cookie) ((cookie) < 0 ? 1 : 0)*/
> +
> +/**
> + * enum dma_status_t - DMA transaction status
> + * @DMA_SUCCESS: transaction completed successfully
> + * @DMA_IN_PROGRESS: transaction not yet processed
> + * @DMA_ERROR: transaction failed
> + */
> +enum dma_status_t {
> +	DMA_SUCCESS,
> +	DMA_IN_PROGRESS,
> +	DMA_ERROR,
> +};
> +
> +/**
> + * struct dma_chan - devices supply DMA channels, clients use them
> + * @client: ptr to the client user of this chan, will be NULL when unused
> + * @device: ptr to the dma device who supplies this channel, always !NULL
> + * @client_node: used to add this to the client chan list
> + * @device_node: used to add this to the device chan list
> + */
> +struct dma_chan
> +{
> +	struct dma_client *client;
> +	struct dma_device *device;
> +	dma_cookie_t cookie;
> +
> +	/* sysfs */
> +	int chan_id;
> +	struct class_device class_dev;
> +
> +	/* stats */
> +	unsigned long memcpy_count;
> +	unsigned long bytes_transferred;
> +	unsigned int min_copy_size;

very very minor nit, but it bugs me at least:  the stats variables 
strike me as overly long and verbose.


> +	struct list_head client_node;
> +	struct list_head device_node;
> +
> +	cpumask_t cpumask;
> +};
> +
> +/*
> + * typedef dma_event_callback - function pointer to a DMA event callback
> + */
> +typedef void (*dma_event_callback) (struct dma_client *client, struct dma_chan *chan, enum dma_event_t event);
> +
> +/**
> + * struct dma_client - info on the entity making use of DMA services
> + * @event_callback: func ptr to call when something happens
> + * @chan_count: number of chans allocated
> + * @chans_desired: number of chans requested. Can be +- chan_count
> + * @port: upstream DMA port from the client's PCI device
> + * @channels: the list of DMA channels allocated
> + * @global_node: list_head for global dma_client_list
> + */
> +struct dma_client {
> +	dma_event_callback	event_callback;
> +	unsigned int		chan_count;
> +	unsigned int		chans_desired;
> +
> +	/* TODO keep some stats */
> +	struct list_head	channels;
> +	struct list_head	global_node;
> +};
> +
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
> +
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

names feel a bit long


