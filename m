Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261891AbVCLIHh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261891AbVCLIHh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Mar 2005 03:07:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261886AbVCLIFw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Mar 2005 03:05:52 -0500
Received: from mail.kroah.org ([69.55.234.183]:9691 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261888AbVCLIFD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Mar 2005 03:05:03 -0500
Date: Fri, 11 Mar 2005 23:28:18 -0800
From: Greg KH <greg@kroah.com>
To: long <tlnguyen@snoqualmie.dp.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       tom.l.nguyen@intel.com
Subject: Re: [PATCH 3/6] PCI Express Advanced Error Reporting Driver
Message-ID: <20050312072818.GD11236@kroah.com>
References: <200503120014.j2C0Ee4B020311@snoqualmie.dp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503120014.j2C0Ee4B020311@snoqualmie.dp.intel.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 11, 2005 at 04:14:40PM -0800, long wrote:
> This patch includes the source code of event-logged component of PCI
> Express Advanced Error Reporting driver.
> 
> Signed-off-by: T. Long Nguyen <tom.l.nguyen@intel.com>
> 
> --------------------------------------------------------------------
> diff -urpN linux-2.6.11-rc5/drivers/pci/pcie/aer/aerdrv_event.c patch-2.6.11-rc5-aerc3-split3/drivers/pci/pcie/aer/aerdrv_event.c
> --- linux-2.6.11-rc5/drivers/pci/pcie/aer/aerdrv_event.c	1969-12-31 19:00:00.000000000 -0500
> +++ patch-2.6.11-rc5-aerc3-split3/drivers/pci/pcie/aer/aerdrv_event.c	2005-03-09 13:26:28.000000000 -0500
> @@ -0,0 +1,752 @@
> +/*
> + * Copyright (C) 2005 Intel
> + * Copyright (C) Tom Long Nguyen (tom.l.nguyen@intel.com)
> + *
> + */
> +
> +#include <linux/module.h>
> +#include <linux/pci.h>
> +#include <linux/kernel.h>
> +#include <linux/errno.h>
> +#include <linux/pm.h>
> +#include <linux/suspend.h>
> +
> +#include "aerdrv.h"
> +
> +LIST_HEAD(evt_queue);			/* Define Event Queue List */

Make this static?


> +/**
> + * evt_queue_push - store an event node into an event log list 
> + * @node: pointer to an event log node
> + *
> + * Invoked when a new error being recorded
> + **/
> +static void evt_queue_push(struct event_node *node)
> +{
> +	struct list_head *head = &evt_queue;
> +	struct event_node *tmp = NULL;
> +
> +	/* Lock access into an error event queue */
> +	down(&evt_sema);	
> +	if (records > eventlog_size) {
> +		/* Exceed event log buffer size. Delete oldest one. */
> +		tmp = container_of(head->next, struct event_node, e_node);
> +		list_del(&tmp->e_node);
> +	} else
> +		records++;
> +	list_add_tail(&node->e_node, head);	
> +	up(&evt_sema);	
> +	if (tmp) 
> +		free_node(tmp);
> +
> +	/* Wake up event parsing thread */
> +	if (aer_get_auto_mode())
> +		wake_up(&kevtd_wait);
> +}
> +
> +/**
> + * evt_queue_pop - restore an event node from an event log list 
> + * @where: either from top or bottom of a list
> + *
> + * Invoked when an error being consumed
> + **/
> +static struct event_node* evt_queue_pop(int where)
> +{
> +	struct list_head *head = &evt_queue;
> +	struct event_node *evt_node = NULL;
> +
> +	if (!list_empty(head)) {
> +		head = ((where == GET_ERR_RECORD_TOP) ? head->prev : head->next);
> +		evt_node = container_of(head, struct event_node, e_node);
> +		list_del(&evt_node->e_node);
> +		records--;
> +	}
> +
> +	return evt_node;
> +}

The lock is not held in the pop, like it is in the push function.  Any
reason for this?

thanks,

greg k-h
