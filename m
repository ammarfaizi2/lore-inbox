Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262292AbVC2KZD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262292AbVC2KZD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 05:25:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262286AbVC2KZB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 05:25:01 -0500
Received: from smtp206.mail.sc5.yahoo.com ([216.136.129.96]:2937 "HELO
	smtp206.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262292AbVC2KYA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 05:24:00 -0500
Message-ID: <42492CBC.1060406@yahoo.com.au>
Date: Tue, 29 Mar 2005 20:23:56 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Jens Axboe <axboe@suse.de>, "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] use cheaper elv_queue_empty when unplug a device
References: <200503290253.j2T2rqg25691@unix-os.sc.intel.com>	 <20050329080646.GE16636@suse.de>  <42491DBE.6020303@yahoo.com.au> <1112091026.6282.43.camel@laptopd505.fenrus.org>
In-Reply-To: <1112091026.6282.43.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> On Tue, 2005-03-29 at 19:19 +1000, Nick Piggin wrote:
> 
>>- removes the relock/retry merge mechanism in __make_request if we
>>   aren't able to get the GFP_ATOMIC allocation. Just fall through
>>   and assume the chances of getting a merge will be small (is this
>>   a valid assumption? Should measure it I guess).
> 
> 
> this may have a potential problem; if the vm gets in trouble, you
> suddenly start to generate worse IO patterns, which means IO performance
> goes down right when it's most needed.....
> 

Sorry my wording was incorrect. It currently *always* retries the
merge if it had at first failed, and after the patch, we never retry.
So it should not result in behavioural shifts when there is a VM load
is high.

It seems to be a clear source of problems for Kenneth though, because
his workload appears to have almost zero merges, so he'll always be
invoking the merge logic twice.

I agree there is potential for subtle interactions. But generally the
block layer is surprisingly well behaved in my experience.

As Jens said, the complete removal of the GFP_ATOMIC allocation probably
has the most potential for problems in this regard, although bios are not
using GFP_ATOMIC allocations, so I would be a little surprised if it made
a really noticable difference.

