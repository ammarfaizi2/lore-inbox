Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751798AbWKQSHe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751798AbWKQSHe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 13:07:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755759AbWKQSHe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 13:07:34 -0500
Received: from mx.pathscale.com ([64.160.42.68]:12761 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1751695AbWKQSHd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 13:07:33 -0500
Message-ID: <455DFA78.9090401@pathscale.com>
Date: Fri, 17 Nov 2006 10:07:52 -0800
From: "Bryan O'Sullivan" <bos@pathscale.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20061027)
MIME-Version: 1.0
To: Steve Wise <swise@opengridcomputing.com>
Cc: rdreier@cisco.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Subject: Re: [openib-general] [PATCH  04/13] Connection Manager
References: <20061116035826.22635.61230.stgit@dell3.ogc.int> <20061116035847.22635.87333.stgit@dell3.ogc.int>
In-Reply-To: <20061116035847.22635.87333.stgit@dell3.ogc.int>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steve Wise wrote:

> +static void release_tid(struct t3cdev *tdev, u32 hwtid, struct sk_buff *skb)
> +{
> +	struct cpl_tid_release *req;
> +
> +	skb = get_skb(skb, sizeof *req, GFP_KERNEL);
> +	if (!skb) {
> +		return;
> +	}

Style micronit: no curlies for single-statement blocks.

> +void __free_ep(struct iwch_ep_common *epc)
> +{
> +	PDBG("%s ep %p, &refcnt %p state %s, refcnt %d\n",
> +	     __FUNCTION__, epc, &epc->refcnt,
> +	     states[state_read(epc)], atomic_read(&epc->refcnt));
> +
> +	if (atomic_read(&epc->refcnt) == 1) {
> +		goto out;
> +	}
> +	if (!atomic_dec_and_test(&epc->refcnt)) {
> +		return;
> +	}
> +out:
> +	PDBG("free ep %p\n", epc);
> +	kfree(epc);
> +}

Whatever you're trying to do with refcounting and atomics here looks 
extremely dodgy and race-prone to me.  Why are you using atomic ops in 
such a scary manner, instead of just slapping a spinlock around this?

Anyway, please drop this atomic refcounting stuff and use embedded krefs 
instead.  You're tunnelling into a bug mine.

By the way, it would be more consistent with normal kernel naming 
conventions to name these refcount-diddling routines ep_get and ep_put, 
since __ep_free doesn't actually free an object unless it feels like it.

> +int __init iwch_cm_init(void)
> +{
> +	skb_queue_head_init(&rxq);
> +
> +	workq = create_singlethread_workqueue("iw_cxgb3");
> +	if (!workq)
> +		return -ENOMEM;
> +
> +	/*
> +	 * All upcalls from the T3 Core go to sched() to 
> +	 * schedule the processing on a work queue.
> +	 */
> +	t3c_handlers[CPL_ACT_ESTABLISH] = sched;
> +	t3c_handlers[CPL_ACT_OPEN_RPL] = sched;
> +	t3c_handlers[CPL_RX_DATA] = sched;
> +	t3c_handlers[CPL_TX_DMA_ACK] = sched;
> +	t3c_handlers[CPL_ABORT_RPL_RSS] = sched;
> +	t3c_handlers[CPL_ABORT_RPL] = sched;
> +	t3c_handlers[CPL_PASS_OPEN_RPL] = sched;
> +	t3c_handlers[CPL_CLOSE_LISTSRV_RPL] = sched;
> +	t3c_handlers[CPL_PASS_ACCEPT_REQ] = sched;
> +	t3c_handlers[CPL_PASS_ESTABLISH] = sched;
> +	t3c_handlers[CPL_PEER_CLOSE] = sched;
> +	t3c_handlers[CPL_CLOSE_CON_RPL] = sched;
> +	t3c_handlers[CPL_ABORT_REQ_RSS] = sched;
> +	t3c_handlers[CPL_RDMA_TERMINATE] = sched;
> +	t3c_handlers[CPL_RDMA_EC_STATUS] = sched;
> +
> +	/*
> +	 * These are the real handlers that are called from a 
> +	 * work queue.
> +	 */
> +	work_handlers[CPL_ACT_ESTABLISH] = act_establish;
> +	work_handlers[CPL_ACT_OPEN_RPL] = act_open_rpl;
> +	work_handlers[CPL_RX_DATA] = rx_data;
> +	work_handlers[CPL_TX_DMA_ACK] = tx_ack;
> +	work_handlers[CPL_ABORT_RPL_RSS] = abort_rpl;
> +	work_handlers[CPL_ABORT_RPL] = abort_rpl;
> +	work_handlers[CPL_PASS_OPEN_RPL] = pass_open_rpl;
> +	work_handlers[CPL_CLOSE_LISTSRV_RPL] = close_listsrv_rpl;
> +	work_handlers[CPL_PASS_ACCEPT_REQ] = pass_accept_req;
> +	work_handlers[CPL_PASS_ESTABLISH] = pass_establish;
> +	work_handlers[CPL_PEER_CLOSE] = peer_close;
> +	work_handlers[CPL_ABORT_REQ_RSS] = peer_abort;
> +	work_handlers[CPL_CLOSE_CON_RPL] = close_con_rpl;
> +	work_handlers[CPL_RDMA_TERMINATE] = terminate;
> +	work_handlers[CPL_RDMA_EC_STATUS] = ec_status;
> +	return 0;
> +}

This seems mighty peculiar.  Why aren't you keeping this stuff in 
structs, instead of faking up structs via arrays?

	<b
