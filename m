Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265865AbUBBWIM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 17:08:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265877AbUBBWIM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 17:08:12 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:8330 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S265865AbUBBWII
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 17:08:08 -0500
Date: Mon, 2 Feb 2004 23:04:48 +0100
From: Francois Romieu <romieu@fr.zoreil.com>
To: Max Asbock <masbock@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Driver for IBM RSA service processor (1/2)
Message-ID: <20040202230448.A18524@electric-eye.fr.zoreil.com>
References: <200402021129.53193.masbock@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200402021129.53193.masbock@us.ibm.com>; from masbock@us.ibm.com on Mon, Feb 02, 2004 at 11:29:53AM -0800
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Max Asbock <masbock@us.ibm.com> :
> diff -urN linux-2.6.1/drivers/misc/ibmasm/event.c linux-2.6.1-ibmasm/drivers/misc/ibmasm/event.c
> --- linux-2.6.1/drivers/misc/ibmasm/event.c	1969-12-31 16:00:00.000000000 -0800
> +++ linux-2.6.1-ibmasm/drivers/misc/ibmasm/event.c	2004-01-20 11:16:29.000000000 -0800
[...]
> +void ibmasm_receive_event(struct service_processor *sp, void *data, size_t data_size)
> +{
[...]
> +	/* advance indices in the buffer */
> +	buffer->next_index = ++(buffer->next_index) % IBMASM_NUM_EVENTS;

-> buffer->next_index = (buffer->next_index + 1) % IBMASM_NUM_EVENTS;

> diff -urN linux-2.6.1/drivers/misc/ibmasm/module.c linux-2.6.1-ibmasm/drivers/misc/ibmasm/module.c
> --- linux-2.6.1/drivers/misc/ibmasm/module.c	1969-12-31 16:00:00.000000000 -0800
> +++ linux-2.6.1-ibmasm/drivers/misc/ibmasm/module.c	2004-01-20 13:05:38.000000000 -0800
[...]
> +static int __init ibmasm_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
> +{
> +	int result = 0;

-> It can be set directly to -ENOMEM (and removed from several lines below).
   It will be overriden later if everything succeeds.

> diff -urN linux-2.6.1/drivers/misc/ibmasm/remote.c linux-2.6.1-ibmasm/drivers/misc/ibmasm/remote.c
> --- linux-2.6.1/drivers/misc/ibmasm/remote.c	1969-12-31 16:00:00.000000000 -0800
> +++ linux-2.6.1-ibmasm/drivers/misc/ibmasm/remote.c	2004-01-14 16:42:01.000000000 -0800
[...]
> +void ibmasm_free_remote_queue(struct service_processor *sp)
> +{
> +	if (sp->remote_queue.start)
> +		kfree(sp->remote_queue.start);
> +}

-> kfree(NULL) does not hurt. The 'if' can be removed.

[...]
> +size_t ibmasm_events_available(struct remote_queue *q)
> +{
> +	ssize_t diff = q->writer - q->reader;
> +
> +	if (diff >= 0)
> +		return diff;
> +	else
> +		return (q->end - q->reader);
> +}

-> return (diff >= 0) ? diff : q->end - q->reader; 
   Your choice.

--
Ueimor
