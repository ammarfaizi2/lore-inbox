Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964860AbWIDPpW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964860AbWIDPpW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 11:45:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964881AbWIDPpW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 11:45:22 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:58088 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S964880AbWIDPpU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 11:45:20 -0400
Message-ID: <44FC4A2B.5050004@in.ibm.com>
Date: Mon, 04 Sep 2006 21:15:47 +0530
From: Balbir Singh <balbir@in.ibm.com>
Reply-To: balbir@in.ibm.com
Organization: IBM India Private Limited
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.6) Gecko/20060730 SeaMonkey/1.0.4
MIME-Version: 1.0
To: Kirill Korotaev <dev@sw.ru>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>,
       Pavel Emelianov <xemul@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       devel@openvz.org, Rik van Riel <riel@redhat.com>,
       Andi Kleen <ak@suse.de>, Oleg Nesterov <oleg@tv-sign.ru>,
       Alexey Dobriyan <adobriyan@mail.ru>, Matt Helsley <matthltc@us.ibm.com>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>
Subject: Re: [PATCH 6/7] BC: kernel memory (core)
References: <44F45045.70402@sw.ru> <44F45601.9060807@sw.ru> <44F48A6A.40501@in.ibm.com> <44FC1A58.3090506@sw.ru>
In-Reply-To: <44FC1A58.3090506@sw.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kirill Korotaev wrote:
> Balbir Singh wrote:
>> Kirill Korotaev wrote:

>>> +#ifdef CONFIG_BEANCOUNTERS
>>> +    union {
>>> +        struct beancounter    *page_bc;
>>> +    } bc;
>>> +#endif
>>> };
>>>
>>> +#define page_bc(page)            ((page)->bc.page_bc)
>>
>>
>> Minor comment - page->(bc).page_bc has too many repititions of page 
>> and bc - see
>> the Practice of Programming by Kernighan and Pike
>>
>> I missed the part of why you wanted to have a union (in struct page 
>> for bc)?
> because this union is used both for kernel memory accounting and user 
> memeory tracking.

Ok.. that's good. I remember seeing a user_bc sometime back in the code.
I had some idea about allowing tasks to migrate across resources (bean
counters), which I think can be easily done for user space pages, if the
user limits are tracked separately.

> 
>>> const char *bc_rnames[] = {
>>> +    "kmemsize",    /* 0 */
>>> };
>>>
>>> static struct hlist_head bc_hash[BC_HASH_SIZE];
>>> @@ -221,6 +222,8 @@ static void init_beancounter_syslimits(s
>>> {     int k;
>>>
>>> +    bc->bc_parms[BC_KMEMSIZE].limit = 32 * 1024 * 1024;
>>> +
>>
>>
>> Can't this be configurable CONFIG_XXX or a #defined constant?
> This is some arbitraty limited container, just to make sure it is not
> created unlimited. User space should initialize limits properly after 
> creation
> anyway. So I don't see reasons to make it configurable, do you?

May be its not very important now but configurable limits will help a confused
user. Even if we decide to use this number for now, a constant like
BC_DEFAULT_MEM_LIMIT is easier to read.

>> I wonder if bc_page_charge() should be called bc_page_charge_failed()?
>> Does it make sense to atleast partially start reclamation here? I know 
>> with
>> bean counters we cannot reclaim from a particular container, but for now
>> we could kick off kswapd() or call shrink_all_memory() inline (Dave's 
>> patches do this to shrink memory from the particular cpuset). Or do 
>> you want to leave this
>> slot open for later?
> yes. my intention is to account correctly all needed information first.
> After we agree on accounting, we can agree on how to do reclamaition.
> 

That sounds like a good plan.

-- 

	Balbir Singh,
	Linux Technology Center,
	IBM Software Labs
