Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262819AbVCDATU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262819AbVCDATU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 19:19:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262814AbVCDARp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 19:17:45 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:56509 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262810AbVCDAIE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 19:08:04 -0500
Message-ID: <4227A6CF.6080805@pobox.com>
Date: Thu, 03 Mar 2005 19:07:43 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Roland Dreier <roland@topspin.com>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH][26/26] IB: MAD cancel callbacks from thread
References: <2005331520.zA1xypugai2bUq7X@topspin.com>
In-Reply-To: <2005331520.zA1xypugai2bUq7X@topspin.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Dreier wrote:
> +void cancel_sends(void *data)
> +{
> +	struct ib_mad_agent_private *mad_agent_priv;
> +	struct ib_mad_send_wr_private *mad_send_wr;
> +	struct ib_mad_send_wc mad_send_wc;
> +	unsigned long flags;
> +
> +	mad_agent_priv = (struct ib_mad_agent_private *)data;

don't add casts to a void pointer, that's silly.



> +	mad_send_wc.status = IB_WC_WR_FLUSH_ERR;
> +	mad_send_wc.vendor_err = 0;
> +
> +	spin_lock_irqsave(&mad_agent_priv->lock, flags);
> +	while (!list_empty(&mad_agent_priv->canceled_list)) {
> +		mad_send_wr = list_entry(mad_agent_priv->canceled_list.next,
> +					 struct ib_mad_send_wr_private,
> +					 agent_list);
> +
> +		list_del(&mad_send_wr->agent_list);
> +		spin_unlock_irqrestore(&mad_agent_priv->lock, flags);
> +
> +		mad_send_wc.wr_id = mad_send_wr->wr_id;
> +		mad_agent_priv->agent.send_handler(&mad_agent_priv->agent,
> +						   &mad_send_wc);
> +
> +		kfree(mad_send_wr);
> +		if (atomic_dec_and_test(&mad_agent_priv->refcount))
> +			wake_up(&mad_agent_priv->wait);
> +		spin_lock_irqsave(&mad_agent_priv->lock, flags);
> +	}
> +	spin_unlock_irqrestore(&mad_agent_priv->lock, flags);

dumb question... why is the lock dropped?  is it just for the 
send_handler(), or also for wr_id assigned, kfree, and wake_up() ?

