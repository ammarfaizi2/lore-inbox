Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261784AbUK2Ubo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261784AbUK2Ubo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 15:31:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261785AbUK2Ubo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 15:31:44 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:48565 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261784AbUK2Ua2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 15:30:28 -0500
Subject: Re: [PATCH] CKRM: 8/10 CKRM:  Resource controller for prioritizing
	inbound network requests
From: Dave Hansen <haveblue@us.ibm.com>
To: Gerrit Huizenga <gh@us.ibm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Rik van Riel <riel@redhat.com>,
       Chris Mason <mason@suse.com>,
       ckrm-tech <ckrm-tech@lists.sourceforge.net>
In-Reply-To: <E1CYqcL-0005A1-00@w-gerrit.beaverton.ibm.com>
References: <E1CYqcL-0005A1-00@w-gerrit.beaverton.ibm.com>
Content-Type: text/plain
Message-Id: <1101760138.9548.6.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 29 Nov 2004 12:28:58 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You sure do like C++ comments, don't you :)

On Mon, 2004-11-29 at 10:51, Gerrit Huizenga wrote:
> +#ifdef CONFIG_ACCEPT_QUEUES
> +#define TCP_ACCEPTQ_SHARE	13	/* Set accept queue share */
> +#endif

Why does a #define need an #ifdef?  It's not like there's object size
bloat from it.

> +#ifdef CONFIG_ACCEPT_QUEUES
> +
> +#define NUM_ACCEPT_QUEUES	8 	/* Must be power of 2 */
> +
> +struct tcp_acceptq_info {
> +	unsigned char acceptq_shares;
> +	unsigned long acceptq_wait_time;
> +	unsigned int acceptq_qcount;
> +	unsigned int acceptq_count;
> +};
> +#endif

Same here.  Are you just trying to make sure that uses of those
variables don't happen outside of your other #ifdef'd code?

> +struct tcp_listen_opt
> +{
> +	u8			max_qlen_log;	/* log_2 of maximal queued SYNs */
> +	int			qlen;
> +#ifdef CONFIG_ACCEPT_QUEUES
> +	int			qlen_young[NUM_ACCEPT_QUEUES];
> +#else
> +	int			qlen_young;
> +#endif
> +	int			clock_hand;
> +	u32			hash_rnd;
> +	struct open_request	*syn_table[TCP_SYNQ_HSIZE];
> +};

Icky.  How about just making NUM_ACCEPT_QUEUES=1 when your option is
off?  Should all compile down to the same thing.

> +		if (prev_class < 0) {
> +			req->dl_next = tp->accept_queue;
> +			tp->accept_queue = req;
> +		}
> +		else {
> +			req->dl_next = tp->acceptq[prev_class].aq_tail->dl_next;
> +			tp->acceptq[prev_class].aq_tail->dl_next = req;
> +		}
> +	}

Documentation/CodingStyle.  else and brakets on one line, please.

> +static void *laq_res_alloc(struct ckrm_core_class *core,
> +			   struct ckrm_core_class *parent)
> +{
...
> +	res = kmalloc(sizeof(ckrm_laq_res_t), GFP_ATOMIC);
> +	if (res) {
> +		memset(res, 0, sizeof(res));
> +		spin_lock_init(&res->reslock);
> +		laq_res_hold(res);
> +		res->my_depth = pdepth;
> +		if (pdepth == 2)	// listen class
> +			res->my_id = 0;
> +		else if (pdepth == 3)
> +			res->my_id = atoi(laq_get_name(core));
> +		res->core = core;
> +		res->pcore = parent;
> +
> +		// rescls in place, now initialize contents other than 
> +		// hierarchy pointers
> +		laq_res_initcls(res);	// acts as initialising value
> +	}
> +
> +	return res;
> +}

Generally, these look nicer if you do this:

        res = kmalloc()
        if (!res)
        	return res;
        
        ...
        stuff from old if() here
        ...
        
-- Dave

