Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932834AbWKJK23@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932834AbWKJK23 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 05:28:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932835AbWKJK23
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 05:28:29 -0500
Received: from ausmtp04.au.ibm.com ([202.81.18.152]:49297 "EHLO
	ausmtp04.au.ibm.com") by vger.kernel.org with ESMTP id S932635AbWKJK21
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 05:28:27 -0500
Message-ID: <45545429.7080903@in.ibm.com>
Date: Fri, 10 Nov 2006 15:57:53 +0530
From: Balbir Singh <balbir@in.ibm.com>
Reply-To: balbir@in.ibm.com
Organization: IBM
User-Agent: Thunderbird 1.5.0.7 (X11/20060922)
MIME-Version: 1.0
To: Pavel Emelianov <xemul@openvz.org>
CC: dev@openvz.org, ckrm-tech@lists.sourceforge.net, haveblue@us.ibm.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux MM <linux-mm@kvack.org>, rohitseth@google.com
Subject: Re: [ckrm-tech] [RFC][PATCH 6/8] RSS controller shares allocation
References: <20061109193523.21437.86224.sendpatchset@balbir.in.ibm.com>	<20061109193619.21437.84173.sendpatchset@balbir.in.ibm.com> <45544240.80609@openvz.org>
In-Reply-To: <45544240.80609@openvz.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Emelianov wrote:
> Balbir Singh wrote:
>> Support shares assignment and propagation.
>>
>> Signed-off-by: Balbir Singh <balbir@in.ibm.com>
>> ---
>>
>>  kernel/res_group/memctlr.c |   59 ++++++++++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 58 insertions(+), 1 deletion(-)
> 
> [snip]
> 
>> +static void recalc_and_propagate(struct memctlr *res, struct memctlr *parres)
>> +{
>> +	struct resource_group *child = NULL;
>> +	int child_divisor;
>> +	u64 numerator;
>> +	struct memctlr *child_res;
>> +
>> +	if (parres) {
>> +		if (res->shares.max_shares == SHARE_DONT_CARE ||
>> +			parres->shares.max_shares == SHARE_DONT_CARE)
>> +			return;
>> +
>> +		child_divisor = parres->shares.child_shares_divisor;
>> +		if (child_divisor == 0)
>> +			return;
>> +
>> +		numerator = (u64)(parres->shares.unused_min_shares *
>> +				res->shares.max_shares);
>> +		do_div(numerator, child_divisor);
>> +		numerator = (u64)(parres->nr_pages * numerator);
>> +		do_div(numerator, SHARE_DEFAULT_DIVISOR);
>> +		res->nr_pages = numerator;
>> +	}
>> +
>> +	for_each_child(child, res->rgroup) {
>> +		child_res = get_memctlr(child);
>> +		BUG_ON(!child_res);
>> +		recalc_and_propagate(child_res, res);
> 
> Recursion? Won't it eat all the stack in case of a deep tree?

The depth of the hierarchy can be controlled. Recursion is needed
to do a DFS walk

> 
>> +	}
>> +
>> +}
>> +
>> +static void memctlr_shares_changed(struct res_shares *shares)
>> +{
>> +	struct memctlr *res, *parres;
>> +
>> +	res = get_memctlr_from_shares(shares);
>> +	if (!res)
>> +		return;
>> +
>> +	if (is_res_group_root(res->rgroup))
>> +		parres = NULL;
>> +	else
>> +		parres = get_memctlr((struct container *)res->rgroup->parent);
>> +
>> +	recalc_and_propagate(res, parres);
>> +}
>> +
>>  struct res_controller memctlr_rg = {
>>  	.name = res_ctlr_name,
>>  	.ctlr_id = NO_RES_ID,
>>  	.alloc_shares_struct = memctlr_alloc_instance,
>>  	.free_shares_struct = memctlr_free_instance,
>>  	.move_task = memctlr_move_task,
>> -	.shares_changed = NULL,
>> +	.shares_changed = memctlr_shares_changed,
> 
> I didn't find where in this patches this callback is called.

It's a part of the resource groups infrastructure. It's been ported
on top of Paul Menage's containers patches. The code can be easily
adapted to work directly with containers instead of resource groups
if required.



-- 

	Balbir Singh,
	Linux Technology Center,
	IBM Software Labs
