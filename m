Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262810AbVCDAkA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262810AbVCDAkA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 19:40:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262750AbVCDAgE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 19:36:04 -0500
Received: from fmr19.intel.com ([134.134.136.18]:25282 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S262810AbVCDAfA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 19:35:00 -0500
From: "Sean Hefty" <sean.hefty@intel.com>
To: "'Jeff Garzik'" <jgarzik@pobox.com>, "Roland Dreier" <roland@topspin.com>
Cc: <akpm@osdl.org>, <linux-kernel@vger.kernel.org>,
       <openib-general@openib.org>
Subject: RE: [openib-general] Re: [PATCH][26/26] IB: MAD cancel callbacks fromthread
Date: Thu, 3 Mar 2005 16:34:43 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1478
thread-index: AcUgTkKNX3bthzfXSz2SAY0hG9c76AAAN/tA
In-Reply-To: <4227A6CF.6080805@pobox.com>
Message-ID: <ORSMSX401FRaqbC8wSA0000000e@orsmsx401.amr.corp.intel.com>
X-OriginalArrivalTime: 04 Mar 2005 00:34:44.0639 (UTC) FILETIME=[F649AAF0:01C52051]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Roland Dreier wrote:
>> +void cancel_sends(void *data)
>> +{
>> +	struct ib_mad_agent_private *mad_agent_priv;
>> +	struct ib_mad_send_wr_private *mad_send_wr;
>> +	struct ib_mad_send_wc mad_send_wc;
>> +	unsigned long flags;
>> +
>> +	mad_agent_priv = (struct ib_mad_agent_private *)data;
>
>don't add casts to a void pointer, that's silly.

This is my bad.

>> +	mad_send_wc.status = IB_WC_WR_FLUSH_ERR;
>> +	mad_send_wc.vendor_err = 0;
>> +
>> +	spin_lock_irqsave(&mad_agent_priv->lock, flags);
>> +	while (!list_empty(&mad_agent_priv->canceled_list)) {
>> +		mad_send_wr = list_entry(mad_agent_priv->canceled_list.next,
>> +					 struct ib_mad_send_wr_private,
>> +					 agent_list);
>> +
>> +		list_del(&mad_send_wr->agent_list);
>> +		spin_unlock_irqrestore(&mad_agent_priv->lock, flags);
>> +
>> +		mad_send_wc.wr_id = mad_send_wr->wr_id;
>> +		mad_agent_priv->agent.send_handler(&mad_agent_priv->agent,
>> +						   &mad_send_wc);
>> +
>> +		kfree(mad_send_wr);
>> +		if (atomic_dec_and_test(&mad_agent_priv->refcount))
>> +			wake_up(&mad_agent_priv->wait);
>> +		spin_lock_irqsave(&mad_agent_priv->lock, flags);
>> +	}
>> +	spin_unlock_irqrestore(&mad_agent_priv->lock, flags);
>
>dumb question... why is the lock dropped?  is it just for the
>send_handler(), or also for wr_id assigned, kfree, and wake_up() ?

The lock is dropped to avoid calling the user back with it held.  The if
statement / wake_up call near the bottom of the loop can be replaced with a
simple atomic_dec.  The test should always fail.  The lock is to protect
access to the canceled_list.

(Sorry about the mailer...)

- Sean

