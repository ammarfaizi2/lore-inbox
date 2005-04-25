Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262713AbVDYSXX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262713AbVDYSXX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 14:23:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262728AbVDYSXD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 14:23:03 -0400
Received: from mail.dif.dk ([193.138.115.101]:28557 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S262699AbVDYSUx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 14:20:53 -0400
Date: Mon, 25 Apr 2005 20:24:09 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: David Teigland <teigland@redhat.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH 3/7] dlm: recovery
In-Reply-To: <20050425151239.GD6826@redhat.com>
Message-ID: <Pine.LNX.4.62.0504252012120.2941@dragon.hyggekrogen.localhost>
References: <20050425151239.GD6826@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Apr 2005, David Teigland wrote:

> 
> When a node is removed from a lockspace, recovery is required for that
> lockspace on all the remaining lockspace members.  Recovery involves: a
> full rebuild of the distributed resource directory, selecting a new master
> node for locks/resources previously mastered on the removed node, and
> rebuilding master-copy locks on newly selected masters.
> 
> Signed-Off-By: Dave Teigland <teigland@redhat.com>
> Signed-Off-By: Patrick Caulfield <pcaulfie@redhat.com>
> 
> ---

[...]

> +static void receive_rcom_status(struct dlm_ls *ls, struct dlm_rcom *rc_in)
> +{
> +	struct dlm_rcom *rc;
> +	struct dlm_mhandle *mh;
> +	int error, nodeid = rc_in->rc_header.h_nodeid;
> +
> +	error = create_rcom(ls, nodeid, DLM_RCOM_STATUS_REPLY, 0, &rc, &mh);
> +	rc->rc_result = make_status(ls);
> +
> +	error = send_rcom(ls, mh, rc);
> +}

This last assignment seems a bit pointless since you never use the value 
stored in `error' for anything. Shouldn't you be testing `error' at this 
point and take appropriate action? if not, then why bother assigning the 
value in the first place. The same comment goes for the assignment a few 
lines above. Either use the return value or just kill off the local 
variable `error' alltogether and just call create_rcom() and send_rcom() 
and throw away the result... I don't know what's appropriate here, but in 
any case the current code is a bit silly.


> +static void receive_rcom_names(struct dlm_ls *ls, struct dlm_rcom *rc_in)
> +{
> +	struct dlm_rcom *rc;
> +	struct dlm_mhandle *mh;
> +	int error, inlen, outlen;
[...]
> +	error = create_rcom(ls, nodeid, DLM_RCOM_NAMES_REPLY, outlen, &rc, &mh);
> +
> +	error = dlm_copy_master_names(ls, rc_in->rc_buf, inlen, rc->rc_buf,
> +				      outlen, nodeid);
> +
> +	error = send_rcom(ls, mh, rc);
> +}
Some more seemingly pointless assignments of values to `error' that are 
never used.

> +int dlm_send_rcom_lookup(struct dlm_rsb *r, int dir_nodeid)
> +{
> +	struct dlm_rcom *rc;
> +	struct dlm_mhandle *mh;
> +	struct dlm_ls *ls = r->res_ls;
> +	int error;
> +
> +	error = create_rcom(ls, dir_nodeid, DLM_RCOM_LOOKUP, r->res_length,
> +			    &rc, &mh);
> +	memcpy(rc->rc_buf, r->res_name, r->res_length);
> +	rc->rc_id = (unsigned long) r;
> +
> +	error = send_rcom(ls, mh, rc);
> +	return 0;
> +}
Again these assignments to a local `error' variable that's never used.

> +static void receive_rcom_lookup(struct dlm_ls *ls, struct dlm_rcom *rc_in)
> +{
> +	struct dlm_rcom *rc;
> +	struct dlm_mhandle *mh;
> +	int error, ret_nodeid, nodeid = rc_in->rc_header.h_nodeid;
> +	int len = rc_in->rc_header.h_length - sizeof(struct dlm_rcom);
> +
> +	error = dlm_dir_lookup(ls, nodeid, rc_in->rc_buf, len, &ret_nodeid);
> +
> +	error = create_rcom(ls, nodeid, DLM_RCOM_LOOKUP_REPLY, 0, &rc, &mh);
> +	rc->rc_result = ret_nodeid;
> +	rc->rc_id = rc_in->rc_id;
> +
> +	error = send_rcom(ls, mh, rc);
> +}
Yet more error assignments that I don't see the point of. There are more 
of these, but you can find the rest yourself :)


Don't have time right now to look at more code, so I'll stop here for 
now...


-- 
Jesper Juhl


