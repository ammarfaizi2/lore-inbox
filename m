Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932630AbVKXLsF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932630AbVKXLsF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 06:48:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932633AbVKXLsF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 06:48:05 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:32168 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932630AbVKXLsC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 06:48:02 -0500
Date: Thu, 24 Nov 2005 11:48:01 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Grover <andrew.grover@intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       john.ronciak@intel.com, christopher.leech@intel.com
Subject: Re: [RFC] [PATCH 1/3] ioat: DMA subsystem
Message-ID: <20051124114801.GA20244@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Grover <andrew.grover@intel.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, john.ronciak@intel.com,
	christopher.leech@intel.com
References: <Pine.LNX.4.44.0511231207410.32487-100000@isotope.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0511231207410.32487-100000@isotope.jf.intel.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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

these macros seem rather useless.  if you disagree please submit a patch to
<linux/list.h> - if it gets accepted fine, else just remove this usage.


> +	struct dma_chan *chan = container_of(cd, struct dma_chan, class_dev);

What about a

#define to_dma_chan(cdev) \
	container_of(cd, struct dma_chan, cdev)

helper as we have in many subsystems?

> +static void
> +dma_class_release(struct class_device *cd)
> +{
> +	/* do something */
> +}

umm, yeah.. :)

> +static struct dma_chan *
> +dma_client_chan_alloc(struct dma_client *client)
> +{
> +	struct dma_device *device;
> +	struct dma_chan *chan;
> +
> +	BUG_ON(!client);
> +
> +	/* Find a channel, any DMA engine will do */
> +	list_for_each_entry(device, &dma_device_list, global_node) {
> +		list_for_each_entry(chan, &device->channels, device_node) {
> +			if (chan->client)
> +				continue;

couldn't you use the normal device model list for this?

> +static void
> +dma_client_chan_free(struct dma_chan *chan)
> +{
> +	BUG_ON(!chan);
> +
> +	chan->device->device_free_chan_resources(chan);

you'll get the oops here anyway, no need for the BUG_ON

> +			chan = list_entry(client->channels.next, struct dma_chan, client_node);

please shorten the line length to fit 80 column terminals.

> +static int __init dma_bus_init(void)
> +{
> +	int cpu;
> +
> +	dma_wait_wq = create_workqueue("dmapoll");
> +	for_each_online_cpu(cpu) {
> +		init_completion(&per_cpu(kick_dma_poll, cpu));

you either need to make this for_each_possible_cpu or add a hotplug
cpu notifier.  the first is probably a lot easier :)

