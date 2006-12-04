Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935964AbWLDLMF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935964AbWLDLMF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 06:12:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935959AbWLDLMF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 06:12:05 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:6363 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S935957AbWLDLMC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 06:12:02 -0500
Date: Mon, 4 Dec 2006 14:08:26 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Steve Wise <swise@opengridcomputing.com>
Cc: rdreier@cisco.com, netdev@vger.kernel.org, openib-general@openib.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH  v2 04/13] Connection Manager
Message-ID: <20061204110825.GA26251@2ka.mipt.ru>
References: <20061202224917.27014.15424.stgit@dell3.ogc.int> <20061202224958.27014.65970.stgit@dell3.ogc.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20061202224958.27014.65970.stgit@dell3.ogc.int>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Mon, 04 Dec 2006 14:08:28 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 02, 2006 at 04:49:58PM -0600, Steve Wise (swise@opengridcomputing.com) wrote:
> +static int send_halfclose(struct iwch_ep *ep, gfp_t gfp)
> +{
> +	struct cpl_close_con_req *req;
> +	struct sk_buff *skb;
> +
> +	PDBG("%s ep %p\n", __FUNCTION__, ep);
> +	skb = get_skb(NULL, sizeof(*req), gfp);
> +	if (!skb) {
> +		printk(KERN_ERR MOD "%s - failed to alloc skb\n", __FUNCTION__);
> +		return -ENOMEM;
> +	}
> +	skb->priority = CPL_PRIORITY_DATA;
> +	set_arp_failure_handler(skb, arp_failure_discard);
> +	req = (struct cpl_close_con_req *) skb_put(skb, sizeof(*req));
> +	req->wr.wr_hi = htonl(V_WR_OP(FW_WROPCODE_OFLD_CLOSE_CON));
> +	req->wr.wr_lo = htonl(V_WR_TID(ep->hwtid));
> +	OPCODE_TID(req) = htonl(MK_OPCODE_TID(CPL_CLOSE_CON_REQ, ep->hwtid));
> +	l2t_send(ep->com.tdev, skb, ep->l2t);
> +	return 0;
> +}
> +
> +static int send_abort(struct iwch_ep *ep, struct sk_buff *skb, gfp_t gfp)
> +{
> +	struct cpl_abort_req *req;
> +
> +	PDBG("%s ep %p\n", __FUNCTION__, ep);
> +	skb = get_skb(skb, sizeof(*req), gfp);
> +	if (!skb) {
> +		printk(KERN_ERR MOD "%s - failed to alloc skb.\n",
> +		       __FUNCTION__);
> +		return -ENOMEM;
> +	}
> +	skb->priority = CPL_PRIORITY_DATA;
> +	set_arp_failure_handler(skb, abort_arp_failure);
> +	req = (struct cpl_abort_req *) skb_put(skb, sizeof(*req));
> +	req->wr.wr_hi = htonl(V_WR_OP(FW_WROPCODE_OFLD_HOST_ABORT_CON_REQ));
> +	req->wr.wr_lo = htonl(V_WR_TID(ep->hwtid));
> +	OPCODE_TID(req) = htonl(MK_OPCODE_TID(CPL_ABORT_REQ, ep->hwtid));
> +	req->cmd = CPL_ABORT_SEND_RST;
> +	l2t_send(ep->com.tdev, skb, ep->l2t);
> +	return 0;
> +}
> +
> +static int send_connect(struct iwch_ep *ep)
> +{
> +	struct cpl_act_open_req *req;
> +	struct sk_buff *skb;
> +	u32 opt0h, opt0l, opt2;
> +	unsigned int mtu_idx;
> +	int wscale;
> +
> +	PDBG("%s ep %p\n", __FUNCTION__, ep);
> +
> +	skb = get_skb(NULL, sizeof(*req), GFP_KERNEL);
> +	if (!skb) {
> +		printk(KERN_ERR MOD "%s - failed to alloc skb.\n",
> +		       __FUNCTION__);
> +		return -ENOMEM;
> +	}
> +	mtu_idx = find_best_mtu(T3C_DATA(ep->com.tdev), dst_mtu(ep->dst));
> +	wscale = compute_wscale(rcv_win);
> +	opt0h = V_NAGLE(0) |
> +	    V_NO_CONG(nocong) |
> +	    V_KEEP_ALIVE(1) |
> +	    F_TCAM_BYPASS |
> +	    V_WND_SCALE(wscale) |
> +	    V_MSS_IDX(mtu_idx) |
> +	    V_L2T_IDX(ep->l2t->idx) | V_TX_CHANNEL(ep->l2t->smt_idx);
> +	opt0l = V_TOS((ep->tos >> 2) & M_TOS) | V_RCV_BUFSIZ(rcv_win>>10);
> +	opt2 = V_FLAVORS_VALID(0) | V_CONG_CONTROL_FLAVOR(0);
> +	skb->priority = CPL_PRIORITY_SETUP;
> +	set_arp_failure_handler(skb, act_open_req_arp_failure);
> +
> +	req = (struct cpl_act_open_req *) skb_put(skb, sizeof(*req));
> +	req->wr.wr_hi = htonl(V_WR_OP(FW_WROPCODE_FORWARD));
> +	OPCODE_TID(req) = htonl(MK_OPCODE_TID(CPL_ACT_OPEN_REQ, ep->atid));
> +	req->local_port = ep->com.local_addr.sin_port;
> +	req->peer_port = ep->com.remote_addr.sin_port;
> +	req->local_ip = ep->com.local_addr.sin_addr.s_addr;
> +	req->peer_ip = ep->com.remote_addr.sin_addr.s_addr;
> +	req->opt0h = htonl(opt0h);
> +	req->opt0l = htonl(opt0l);
> +	req->params = 0;
> +	req->opt2 = htonl(opt2);
> +	l2t_send(ep->com.tdev, skb, ep->l2t);
> +	return 0;
> +}

...

> +static int act_establish(struct t3cdev *tdev, struct sk_buff *skb, void *ctx)
> +{
> +	struct iwch_ep *ep = ctx;
> +	struct cpl_act_establish *req = cplhdr(skb);
> +	unsigned int tid = GET_TID(req);
> +
> +	PDBG("%s ep %p tid %d\n", __FUNCTION__, ep, tid);
> +
> +	dst_confirm(ep->dst);
> +
> +	/* setup the hwtid for this connection */
> +	ep->hwtid = tid;
> +	cxgb3_insert_tid(ep->com.tdev, &t3c_client, ep, tid);
> +
> +	ep->snd_seq = ntohl(req->snd_isn);
> +
> +	set_emss(ep, ntohs(req->tcp_opt));
> +
> +	/* dealloc the atid */
> +	cxgb3_free_atid(ep->com.tdev, ep->atid);
> +
> +	/* start MPA negotiation */
> +	send_mpa_req(ep, skb);
> +
> +	return 0;
> +}
> +
> +static void abort_connection(struct iwch_ep *ep, struct sk_buff *skb)
> +{
> +	PDBG("%s ep %p\n", __FILE__, ep);
> +	state_set(&ep->com, ABORTING);
> +	send_abort(ep, skb, GFP_KERNEL);
> +}

Could you convince network core developers that it is not own TCP
implementation which will mess with existing one?

This and a lot of other changes in this driver definitely says you
implement your own stack of protocols on top of infiniband hardware.

-- 
	Evgeniy Polyakov
