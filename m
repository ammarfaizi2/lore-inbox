Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964927AbVKAA1f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964927AbVKAA1f (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 19:27:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964926AbVKAA1f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 19:27:35 -0500
Received: from palrel10.hp.com ([156.153.255.245]:8163 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S964879AbVKAA1e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 19:27:34 -0500
Date: Mon, 31 Oct 2005 16:28:11 -0800
From: Grant Grundler <iod00d@hp.com>
To: Roland Dreier <rolandd@cisco.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Subject: Re: [openib-general] [PATCH/RFC] IB: Add SCSI RDMA Protocol (SRP) initiator
Message-ID: <20051101002811.GD3107@esmail.cup.hp.com>
References: <52wtjtk3d1.fsf@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52wtjtk3d1.fsf@cisco.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2005 at 09:23:06AM -0800, Roland Dreier wrote:
> I've posted this several times for review and gotten some (but not
> very much) feedback.

Has anyone purchased IB SRP target and for use with linux?
I've seen references to "Cisco SFS 3001 Multifabric Server Switch"
(TS90) with the optional FC gateway stuff.

Anyway, while I have a TS90, I don't have the FC GW.  If someone
sent me one, I'd plug it into my test ring. I have a switch and
2Gb/s FC JBODs.

Are any native IB/SRP native storage devices available?

(Note that I'm asking only out of curiosity. I'm not going to
rush out and buy one for developement.)


> Is there any objection to me asking Linus to pull this for 2.6.15?

I don't have anything.


Just some nits:

> +#define DRV_VERSION	"0.01"
> +#define DRV_RELDATE	"January 11, 2005"

Implies the driver hasn't changed since Jan 11. Is that correct?
(I find that hard to believe if you got feedback)

Revision numbers are cheap - just roll it to 0.9 (or whatever)
and apply a current date.

> +MODULE_AUTHOR("Roland Dreier");
> +MODULE_DESCRIPTION("InfiniBand SCSI RDMA Protocol driver");

I'd add "initiator" here unless you think this driver could
support targets in the future too.

I do realize the difference between initiator and target for RDMA is
alot smaller than it was for traditional parallel SCSI implementations.
In fact, I'm wondering is one could be implemented for SRP entirely
in userspace.


> +static int srp_create_target_ib(struct srp_target_port *target)
> +{
> +	struct ib_qp_init_attr *init_attr = NULL;

Don't need the NULL assignment here.
BTW, does gcc just throw this away since it gets overwritten?

> +	int ret;
> +
> +	init_attr = kzalloc(sizeof *init_attr, GFP_KERNEL);
> +	if (!init_attr)
> +		return -ENOMEM;
> +
> +	target->cq = ib_create_cq(target->srp_host->dev, srp_completion,
> +				  NULL, target, SRP_CQ_SIZE);
> +	if (IS_ERR(target->cq)) {
> +		ret = PTR_ERR(target->cq);
> +		goto out;
> +	}

Could this be "adjusted" to read:
	if (ret = PTR_ERR(target->qp)) {
		...

I'm sure I do NOT understand the utility of "IS_ERR" in this case.
Most uses of "IS_ERR" seem superfluous.

...
> +	target->qp = ib_create_qp(target->srp_host->pd, init_attr);
> +	if (IS_ERR(target->qp)) {
> +		ret = PTR_ERR(target->qp);
> +		ib_destroy_cq(target->cq);
> +		goto out;
> +	}
> +
> +	ret = srp_init_qp(target, target->qp);
> +	if (ret) {
> +		ib_destroy_qp(target->qp);
> +		ib_destroy_cq(target->cq);
> +		goto out;
> +	}

The second "goto out" can be dropped. Falls through anyway.
I'm ambiviently if it's good coding style or not.
(ie in case someone adds code later).


> +
> +out:
> +	kfree(init_attr);
> +	return ret;
> +}

...
> +static int srp_lookup_path(struct srp_target_port *target)
> +{
> +	target->path.numb_path = 1;
> +
> +	init_completion(&target->done);
> +
> +	target->path_query_id = ib_sa_path_rec_get(target->srp_host->dev,
> +						   target->srp_host->port,
> +						   &target->path,
> +						   IB_SA_PATH_REC_DGID		|
> +						   IB_SA_PATH_REC_SGID		|
> +						   IB_SA_PATH_REC_NUMB_PATH	|
> +						   IB_SA_PATH_REC_PKEY,

My preference is to put the '|' on the next line with expressions behind it.
That way the last line is obviously not a standalone usage when seen
with grep or similar line-based text tool.


> +						   SRP_PATH_REC_TIMEOUT_MS,
> +						   GFP_KERNEL,
> +						   srp_path_rec_completion,
> +						   target, &target->path_query);

...
> +	req->param.starting_psn 	      = 0; /* XXX */

There are still 6 "XXX" markers...don't want to suggest they need
to be fixed.

> +	req->param.private_data 	      = &req->priv;
> +	req->param.private_data_len 	      = sizeof req->priv;
> +	req->param.responder_resources	      = 4;
> +	req->param.remote_cm_response_timeout = 20;
> +	req->param.flow_control 	      = 1;
> +	req->param.local_cm_response_timeout  = 20;
> +	req->param.retry_count 		      = 7;
> +	req->param.rnr_retry_count 	      = 7;
> +	req->param.max_cm_retries 	      = 15;

Are these retry counts specified by some standard or just
"this ought to be enough" kind of numbers?
If the latter, another "XXX" about making them system tunables
(e.g. MOD_PARM or /sys) would be good.


> +	/*
> +	 * Topspin/Cisco SRP targets will reject our login unless we
> +	 * zero out the first 8 bytes of our initiator port ID.  The
> +	 * second 8 bytes must be our local node GUID, but we always
> +	 * use that anyway.
> +	 */

...
> +static int srp_connect_target(struct srp_target_port *target)
> +{
> +	int ret;
> +
> +	ret = srp_lookup_path(target);
> +	if (ret)
> +		return ret;
> +
> +	while (1) {
> +		init_completion(&target->done);
> +		ret = srp_send_req(target);
> +		if (ret)
> +			return ret;
> +		wait_for_completion(&target->done);
> +
> +		/*
> +		 * The CM event handling code will set status to
> +		 * SRP_PORT_REDIRECT if we get a port redirect REJ
> +		 * back, or SRP_DLID_REDIRECT if we get a lid/qp
> +		 * redirect REJ back.
> +		 */
> +		switch (target->status) {
> +		case 0:
> +			return 0;
> +
> +		case SRP_PORT_REDIRECT:
> +			ret = srp_lookup_path(target);
> +			if (ret)
> +				return ret;
> +			break;
> +
> +		case SRP_DLID_REDIRECT:
> +			break;
> +
> +		default:
> +			return target->status;
> +		}
> +	}

Maybe add this for lint?
	/* NOTREACHED */

> +}

Maybe lint is smart enough to realize that these days.


> +static int srp_reconnect_target(struct srp_target_port *target)
> +{
...
> +	ib_destroy_cm_id(target->cm_id);
> +	target->cm_id = new_cm_id;

Is it explained somplace why we drop the old cm_id and create
a new one in this case?
I'm hoping this was explained elsewhere and I just missed it.

...
> +	while (ib_poll_cq(target->cq, 1, &wc) > 0)
> +		; /* nothing */

does a "relax_cpu()" belong in here?


ok..out of time.. I scanned the last couple of hundred lines
and didn't see any nits there.

hth,
grant
