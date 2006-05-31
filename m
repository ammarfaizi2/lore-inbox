Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965095AbWEaSly@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965095AbWEaSly (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 14:41:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965092AbWEaSlx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 14:41:53 -0400
Received: from hera.kernel.org ([140.211.167.34]:46804 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S965094AbWEaSlw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 14:41:52 -0400
To: linux-kernel@vger.kernel.org
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [PATCH 1/2] iWARP Connection Manager.
Date: Wed, 31 May 2006 11:40:59 -0700
Organization: OSDL
Message-ID: <20060531114059.704ef1f1@localhost.localdomain>
References: <20060531182650.3308.81538.stgit@stevo-desktop>
	<20060531182652.3308.1244.stgit@stevo-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Trace: build.pdx.osdl.net 1149100855 22384 10.8.0.54 (31 May 2006 18:40:55 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Wed, 31 May 2006 18:40:55 +0000 (UTC)
X-Newsreader: Sylpheed-Claws 2.1.0 (GTK+ 2.8.6; i486-pc-linux-gnu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 May 2006 13:26:52 -0500
Steve Wise <swise@opengridcomputing.com> wrote:

> 
> This patch provides the new files implementing the iWARP Connection
> Manager.
> ---
> 
>  drivers/infiniband/core/iwcm.c |  887 ++++++++++++++++++++++++++++++++++++++++
>  include/rdma/iw_cm.h           |  254 +++++++++++
>  include/rdma/iw_cm_private.h   |   62 +++
>  3 files changed, 1203 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/infiniband/core/iwcm.c b/drivers/infiniband/core/iwcm.c
> new file mode 100644
> index 0000000..5657ee8
> --- /dev/null
> +++ b/drivers/infiniband/core/iwcm.c
> @@ -0,0 +1,887 @@
> +/*
> + * Copyright (c) 2004, 2005 Intel Corporation.  All rights reserved.
> + * Copyright (c) 2004 Topspin Corporation.  All rights reserved.
> + * Copyright (c) 2004, 2005 Voltaire Corporation.  All rights reserved.
> + * Copyright (c) 2005 Sun Microsystems, Inc. All rights reserved.
> + * Copyright (c) 2005 Open Grid Computing, Inc. All rights reserved.
> + * Copyright (c) 2005 Network Appliance, Inc. All rights reserved.
> + *
> + * This software is available to you under a choice of one of two
> + * licenses.  You may choose to be licensed under the terms of the GNU
> + * General Public License (GPL) Version 2, available from the file
> + * COPYING in the main directory of this source tree, or the
> + * OpenIB.org BSD license below:
> + *
> + *     Redistribution and use in source and binary forms, with or
> + *     without modification, are permitted provided that the following
> + *     conditions are met:
> + *
> + *      - Redistributions of source code must retain the above
> + *        copyright notice, this list of conditions and the following
> + *        disclaimer.
> + *
> + *      - Redistributions in binary form must reproduce the above
> + *        copyright notice, this list of conditions and the following
> + *        disclaimer in the documentation and/or other materials
> + *        provided with the distribution.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> + * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> + * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> + * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
> + * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
> + * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
> + * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
> + * SOFTWARE.
> + *
> + */

Shouldn't all the EXPORT_SYMBOL's in this new code be EXPORT_SYMBOL_GPL
to impede use of binary vendor module's?


> +#include <linux/dma-mapping.h>
> +#include <linux/err.h>
> +#include <linux/idr.h>
> +#include <linux/interrupt.h>
> +#include <linux/pci.h>
> +#include <linux/rbtree.h>
> +#include <linux/spinlock.h>
> +#include <linux/workqueue.h>
> +#include <rdma/iw_cm.h>
> +#include <rdma/iw_cm_private.h>
> +#include <rdma/ib_addr.h>
> +
> +MODULE_AUTHOR("Tom Tucker");
> +MODULE_DESCRIPTION("iWARP CM");
> +MODULE_LICENSE("Dual BSD/GPL");
> +
> +static struct workqueue_struct *iwcm_wq;
> +struct iwcm_work {
> +	struct work_struct work;
> +	struct iwcm_id_private *cm_id;
> +	struct list_head list;
> +	struct iw_cm_event event;
> +};
> +
> +/* 
> + * Release a reference on cm_id. If the last reference is being removed
> + * and iw_destroy_cm_id is waiting, wake up the waiting thread.
> + */
> +static int iwcm_deref_id(struct iwcm_id_private *cm_id_priv)
> +{
> +	int ret = 0;
> +
> +	BUG_ON(atomic_read(&cm_id_priv->refcount)==0);
> +	if (atomic_dec_and_test(&cm_id_priv->refcount)) {
> +		BUG_ON(!list_empty(&cm_id_priv->work_list));
> +		if (waitqueue_active(&cm_id_priv->destroy_wait)) {
> +			BUG_ON(cm_id_priv->state != IW_CM_STATE_DESTROYING);
> +			BUG_ON(test_bit(IWCM_F_CALLBACK_DESTROY,
> +					&cm_id_priv->flags));
> +			ret = 1;
> +			wake_up(&cm_id_priv->destroy_wait);
> +		}
> +	}
> +
> +	return ret;
> +}
> +
> +static void add_ref(struct iw_cm_id *cm_id)
> +{
> +	struct iwcm_id_private *cm_id_priv;
> +	cm_id_priv = container_of(cm_id, struct iwcm_id_private, id);
> +	atomic_inc(&cm_id_priv->refcount);
> +}
> +
> +static void rem_ref(struct iw_cm_id *cm_id)
> +{
> +	struct iwcm_id_private *cm_id_priv;
> +	cm_id_priv = container_of(cm_id, struct iwcm_id_private, id);
> +	iwcm_deref_id(cm_id_priv);
> +}
> +
> +static void cm_event_handler(struct iw_cm_id *cm_id, struct iw_cm_event *event);
> +
> +struct iw_cm_id *iw_create_cm_id(struct ib_device *device,
> +				 iw_cm_handler cm_handler,
> +				 void *context)
> +{
> +	struct iwcm_id_private *cm_id_priv;
> +
> +	cm_id_priv = kzalloc(sizeof *cm_id_priv, GFP_KERNEL);

Please put paren's after sizeof, it is not required by C but it
is easier to read.

> +
> +/* 
> + * CM_ID <-- CLOSING
> + *
> + * Block if a passive or active connection is currenlty being processed. Then
> + * process the event as follows:
> + * - If we are ESTABLISHED, move to CLOSING and modify the QP state
> + *   based on the abrupt flag 
> + * - If the connection is already in the CLOSING or IDLE state, the peer is
> + *   disconnecting concurrently with us and we've already seen the 
> + *   DISCONNECT event -- ignore the request and return 0
> + * - Disconnect on a listening endpoint returns -EINVAL
> + */
> +int iw_cm_disconnect(struct iw_cm_id *cm_id, int abrupt)
> +{
> +	struct iwcm_id_private *cm_id_priv;
> +	unsigned long flags;
> +	int ret = 0;
> +
> +	cm_id_priv = container_of(cm_id, struct iwcm_id_private, id);
> +	/* Wait if we're currently in a connect or accept downcall */
> +	wait_event(cm_id_priv->connect_wait, 
> +		   !test_bit(IWCM_F_CONNECT_WAIT, &cm_id_priv->flags));
> +
> +	spin_lock_irqsave(&cm_id_priv->lock, flags);
> +	switch (cm_id_priv->state) {
> +	case IW_CM_STATE_ESTABLISHED:
> +		cm_id_priv->state = IW_CM_STATE_CLOSING;
> +		spin_unlock_irqrestore(&cm_id_priv->lock, flags);
> +		if (cm_id_priv->qp)	{ /* QP could be <nul> for user-mode client */
> +			if (abrupt)
> +				ret = iwcm_modify_qp_err(cm_id_priv->qp);
> +			else
> +				ret = iwcm_modify_qp_sqd(cm_id_priv->qp);
> +			/* 
> +			 * If both sides are disconnecting the QP could
> +			 * already be in ERR or SQD states
> +			 */
> +			ret = 0;
> +		}
> +		else
> +			ret = -EINVAL;
> +		break;
> +	case IW_CM_STATE_LISTEN:
> +		spin_unlock_irqrestore(&cm_id_priv->lock, flags);
> +		ret = -EINVAL;
> +		break;
> +	case IW_CM_STATE_CLOSING:
> +		/* remote peer closed first */
> +	case IW_CM_STATE_IDLE:	
> +		/* accept or connect returned !0 */
> +		spin_unlock_irqrestore(&cm_id_priv->lock, flags);
> +		break;
> +	case IW_CM_STATE_CONN_RECV:
> +		/* 
> +		 * App called disconnect before/without calling accept after
> +		 * connect_request event delivered.
> +		 */
> +		spin_unlock_irqrestore(&cm_id_priv->lock, flags);
> +		break;
> +	case IW_CM_STATE_CONN_SENT:
> +		/* Can only get here if wait above fails */
> +	default:		
> +		BUG_ON(1);
> +	}

Switch statement's like this where the case does the unlock are error prone
because of the many code paths.

If you just recode slightly by using a separate return in the ESTABLISHED
case, then you can move the unlock outside of the switch.

