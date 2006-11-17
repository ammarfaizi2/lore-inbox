Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755730AbWKQS0m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755730AbWKQS0m (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 13:26:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752153AbWKQS0m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 13:26:42 -0500
Received: from rrcs-24-153-218-104.sw.biz.rr.com ([24.153.218.104]:1728 "EHLO
	smtp.opengridcomputing.com") by vger.kernel.org with ESMTP
	id S1751850AbWKQS0l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 13:26:41 -0500
Subject: Re: [openib-general] [PATCH  04/13] Connection Manager
From: Steve Wise <swise@opengridcomputing.com>
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: rdreier@cisco.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       openib-general@openib.org
In-Reply-To: <455DFA78.9090401@pathscale.com>
References: <20061116035826.22635.61230.stgit@dell3.ogc.int>
	 <20061116035847.22635.87333.stgit@dell3.ogc.int>
	 <455DFA78.9090401@pathscale.com>
Content-Type: text/plain
Date: Fri, 17 Nov 2006 12:26:40 -0600
Message-Id: <1163788000.8457.88.camel@stevo-desktop>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-11-17 at 10:07 -0800, Bryan O'Sullivan wrote:
> Steve Wise wrote:
> 
> > +static void release_tid(struct t3cdev *tdev, u32 hwtid, struct sk_buff *skb)
> > +{
> > +	struct cpl_tid_release *req;
> > +
> > +	skb = get_skb(skb, sizeof *req, GFP_KERNEL);
> > +	if (!skb) {
> > +		return;
> > +	}
> 
> Style micronit: no curlies for single-statement blocks.
> 

yup.

> > +void __free_ep(struct iwch_ep_common *epc)
> > +{
> > +	PDBG("%s ep %p, &refcnt %p state %s, refcnt %d\n",
> > +	     __FUNCTION__, epc, &epc->refcnt,
> > +	     states[state_read(epc)], atomic_read(&epc->refcnt));
> > +
> > +	if (atomic_read(&epc->refcnt) == 1) {
> > +		goto out;
> > +	}
> > +	if (!atomic_dec_and_test(&epc->refcnt)) {
> > +		return;
> > +	}
> > +out:
> > +	PDBG("free ep %p\n", epc);
> > +	kfree(epc);
> > +}
> 
> Whatever you're trying to do with refcounting and atomics here looks 
> extremely dodgy and race-prone to me.  Why are you using atomic ops in 
> such a scary manner, instead of just slapping a spinlock around this?
> 

This logic is the same as kfree_skb() (and kref_put() :).  It optimizes
the case where you're the last one freeing I guess and avoids the
dec-and-test in that case..

> Anyway, please drop this atomic refcounting stuff and use embedded krefs 
> instead.  You're tunnelling into a bug mine.

The kref put code looks very much like the code above.  But I can use
krefs to avoid replicating code.

> 
> By the way, it would be more consistent with normal kernel naming 
> conventions to name these refcount-diddling routines ep_get and ep_put, 
> since __ep_free doesn't actually free an object unless it feels like it.

Again, it was modeled after skb.

> 
> > +int __init iwch_cm_init(void)
> > +{
> > +	skb_queue_head_init(&rxq);
> > +
> > +	workq = create_singlethread_workqueue("iw_cxgb3");
> > +	if (!workq)
> > +		return -ENOMEM;
> > +
> > +	/*
> > +	 * All upcalls from the T3 Core go to sched() to 
> > +	 * schedule the processing on a work queue.
> > +	 */
> > +	t3c_handlers[CPL_ACT_ESTABLISH] = sched;
> > +	t3c_handlers[CPL_ACT_OPEN_RPL] = sched;
> > +	t3c_handlers[CPL_RX_DATA] = sched;
> > +	t3c_handlers[CPL_TX_DMA_ACK] = sched;
> > +	t3c_handlers[CPL_ABORT_RPL_RSS] = sched;
> > +	t3c_handlers[CPL_ABORT_RPL] = sched;
> > +	t3c_handlers[CPL_PASS_OPEN_RPL] = sched;
> > +	t3c_handlers[CPL_CLOSE_LISTSRV_RPL] = sched;
> > +	t3c_handlers[CPL_PASS_ACCEPT_REQ] = sched;
> > +	t3c_handlers[CPL_PASS_ESTABLISH] = sched;
> > +	t3c_handlers[CPL_PEER_CLOSE] = sched;
> > +	t3c_handlers[CPL_CLOSE_CON_RPL] = sched;
> > +	t3c_handlers[CPL_ABORT_REQ_RSS] = sched;
> > +	t3c_handlers[CPL_RDMA_TERMINATE] = sched;
> > +	t3c_handlers[CPL_RDMA_EC_STATUS] = sched;
> > +
> > +	/*
> > +	 * These are the real handlers that are called from a 
> > +	 * work queue.
> > +	 */
> > +	work_handlers[CPL_ACT_ESTABLISH] = act_establish;
> > +	work_handlers[CPL_ACT_OPEN_RPL] = act_open_rpl;
> > +	work_handlers[CPL_RX_DATA] = rx_data;
> > +	work_handlers[CPL_TX_DMA_ACK] = tx_ack;
> > +	work_handlers[CPL_ABORT_RPL_RSS] = abort_rpl;
> > +	work_handlers[CPL_ABORT_RPL] = abort_rpl;
> > +	work_handlers[CPL_PASS_OPEN_RPL] = pass_open_rpl;
> > +	work_handlers[CPL_CLOSE_LISTSRV_RPL] = close_listsrv_rpl;
> > +	work_handlers[CPL_PASS_ACCEPT_REQ] = pass_accept_req;
> > +	work_handlers[CPL_PASS_ESTABLISH] = pass_establish;
> > +	work_handlers[CPL_PEER_CLOSE] = peer_close;
> > +	work_handlers[CPL_ABORT_REQ_RSS] = peer_abort;
> > +	work_handlers[CPL_CLOSE_CON_RPL] = close_con_rpl;
> > +	work_handlers[CPL_RDMA_TERMINATE] = terminate;
> > +	work_handlers[CPL_RDMA_EC_STATUS] = ec_status;
> > +	return 0;
> > +}
> 
> This seems mighty peculiar.  Why aren't you keeping this stuff in 
> structs, instead of faking up structs via arrays?
> 

Its a function handler table.  Given an incoming message with a command
number, we can index into the table using the command number to get the
handler function for that message.



