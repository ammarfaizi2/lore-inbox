Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946092AbWKJJQa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946092AbWKJJQa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 04:16:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946108AbWKJJQa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 04:16:30 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:58646 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1946092AbWKJJQ3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 04:16:29 -0500
Message-ID: <45544240.80609@openvz.org>
Date: Fri, 10 Nov 2006 12:11:28 +0300
From: Pavel Emelianov <xemul@openvz.org>
User-Agent: Thunderbird 1.5 (X11/20060317)
MIME-Version: 1.0
To: Balbir Singh <balbir@in.ibm.com>
CC: Linux MM <linux-mm@kvack.org>, dev@openvz.org,
       ckrm-tech@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       haveblue@us.ibm.com, rohitseth@google.com
Subject: Re: [RFC][PATCH 6/8] RSS controller shares allocation
References: <20061109193523.21437.86224.sendpatchset@balbir.in.ibm.com> <20061109193619.21437.84173.sendpatchset@balbir.in.ibm.com>
In-Reply-To: <20061109193619.21437.84173.sendpatchset@balbir.in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Balbir Singh wrote:
> Support shares assignment and propagation.
> 
> Signed-off-by: Balbir Singh <balbir@in.ibm.com>
> ---
> 
>  kernel/res_group/memctlr.c |   59 ++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 58 insertions(+), 1 deletion(-)

[snip]

> +static void recalc_and_propagate(struct memctlr *res, struct memctlr *parres)
> +{
> +	struct resource_group *child = NULL;
> +	int child_divisor;
> +	u64 numerator;
> +	struct memctlr *child_res;
> +
> +	if (parres) {
> +		if (res->shares.max_shares == SHARE_DONT_CARE ||
> +			parres->shares.max_shares == SHARE_DONT_CARE)
> +			return;
> +
> +		child_divisor = parres->shares.child_shares_divisor;
> +		if (child_divisor == 0)
> +			return;
> +
> +		numerator = (u64)(parres->shares.unused_min_shares *
> +				res->shares.max_shares);
> +		do_div(numerator, child_divisor);
> +		numerator = (u64)(parres->nr_pages * numerator);
> +		do_div(numerator, SHARE_DEFAULT_DIVISOR);
> +		res->nr_pages = numerator;
> +	}
> +
> +	for_each_child(child, res->rgroup) {
> +		child_res = get_memctlr(child);
> +		BUG_ON(!child_res);
> +		recalc_and_propagate(child_res, res);

Recursion? Won't it eat all the stack in case of a deep tree?

> +	}
> +
> +}
> +
> +static void memctlr_shares_changed(struct res_shares *shares)
> +{
> +	struct memctlr *res, *parres;
> +
> +	res = get_memctlr_from_shares(shares);
> +	if (!res)
> +		return;
> +
> +	if (is_res_group_root(res->rgroup))
> +		parres = NULL;
> +	else
> +		parres = get_memctlr((struct container *)res->rgroup->parent);
> +
> +	recalc_and_propagate(res, parres);
> +}
> +
>  struct res_controller memctlr_rg = {
>  	.name = res_ctlr_name,
>  	.ctlr_id = NO_RES_ID,
>  	.alloc_shares_struct = memctlr_alloc_instance,
>  	.free_shares_struct = memctlr_free_instance,
>  	.move_task = memctlr_move_task,
> -	.shares_changed = NULL,
> +	.shares_changed = memctlr_shares_changed,

I didn't find where in this patches this callback is called.
