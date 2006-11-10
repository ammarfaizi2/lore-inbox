Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932816AbWKJJw6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932816AbWKJJw6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 04:52:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946235AbWKJJw6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 04:52:58 -0500
Received: from ausmtp04.au.ibm.com ([202.81.18.152]:23024 "EHLO
	ausmtp04.au.ibm.com") by vger.kernel.org with ESMTP id S932816AbWKJJw4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 04:52:56 -0500
Message-ID: <45544665.3020105@in.ibm.com>
Date: Fri, 10 Nov 2006 14:59:09 +0530
From: Balbir Singh <balbir@in.ibm.com>
Reply-To: balbir@in.ibm.com
Organization: IBM
User-Agent: Thunderbird 1.5.0.7 (X11/20060922)
MIME-Version: 1.0
To: Pavel Emelianov <xemul@openvz.org>
CC: Linux MM <linux-mm@kvack.org>, dev@openvz.org,
       ckrm-tech@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       haveblue@us.ibm.com, rohitseth@google.com
Subject: Re: [RFC][PATCH 4/8] RSS controller accounting
References: <20061109193523.21437.86224.sendpatchset@balbir.in.ibm.com> <20061109193600.21437.74220.sendpatchset@balbir.in.ibm.com> <4554412C.3070904@openvz.org>
In-Reply-To: <4554412C.3070904@openvz.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Emelianov wrote:
> Balbir Singh wrote:
>> Account RSS usage of a task and the associated container. The definition
>> of RSS was debated and discussed in the following thread
>>
>> 	http://lkml.org/lkml/2006/10/10/130
>>
>>
>> The code tracks all resident pages (including shared pages) as RSS. This patch
>> can easily adapt to the definition of RSS that will be agreed upon. This
>> implementation provides a proof of concept RSS controller.
>>
>> The accounting is inspired from Rohit Seth's container patches.
>>
>> TODO's
>>
>> 1. Merge file_rss and anon_rss tracking with the current rss tracking to
>>    maximize code reuse
>> 2. Add/remove RSS tracking as the definition of RSS evolves
>>
>>
>> Signed-off-by: Balbir Singh <balbir@in.ibm.com>
>> ---
>>
> 
> [snip]
> 
>> --- linux-2.6.19-rc2/kernel/res_group/memctlr.c~container-memctlr-acct	2006-11-09 21:46:22.000000000 +0530
>> +++ linux-2.6.19-rc2-balbir/kernel/res_group/memctlr.c	2006-11-09 21:47:06.000000000 +0530
>> @@ -37,6 +37,8 @@ static struct resource_group *root_rgrou
>>  static const char version[] = "0.01";
>>  static struct memctlr *memctlr_root;
>>  
>> +#define MEMCTLR_MAGIC	0xdededede
>> +
>>  struct mem_counter {
>>  	atomic_long_t	rss;
>>  };
>> @@ -49,6 +51,7 @@ struct memctlr {
>>  	/* Statistics */
>>  	int successes;
>>  	int failures;
>> +	int magic;
> 
> What is this magic for? Is it just for debugging?
> 

Yes

> [snip]
> 
>> +static inline struct memctlr *get_memctlr_from_page(struct page *page)
>> +{
>> +	struct resource_group *rgroup;
>> +	struct memctlr *res;
>> +
>> +	/*
>> +	 * Is the resource groups infrastructure initialized?
>> +	 */
>> +	if (!memctlr_root)
>> +		return NULL;
>> +
>> +	rcu_read_lock();
>> +	rgroup = (struct resource_group *)rcu_dereference(current->container);
>> +	rcu_read_unlock();
>> +
>> +	res = get_memctlr(rgroup);
>> +	if (!res)
>> +		return NULL;
>> +
>> +	BUG_ON(res->magic != MEMCTLR_MAGIC);
>> +	return res;
>> +}
> 
> I don't see how page passed to this function is involved into
> 'struct memctlr *res' determining. Could you comment this?
> 

Yeah, from page is a misnomer. We just use the current task task.
I'll fix the naming convention


> [snip]
> 
>> --- linux-2.6.19-rc2/mm/rmap.c~container-memctlr-acct	2006-11-09 21:46:22.000000000 +0530
>> +++ linux-2.6.19-rc2-balbir/mm/rmap.c	2006-11-09 21:46:22.000000000 +0530
>> @@ -537,6 +537,7 @@ void page_add_anon_rmap(struct page *pag
>>  	if (atomic_inc_and_test(&page->_mapcount))
>>  		__page_set_anon_rmap(page, vma, address);
>>  	/* else checking page index and mapping is racy */
>> +	memctlr_inc_rss(page);
>>  }
>>  
>>  /*
>> @@ -553,6 +554,7 @@ void page_add_new_anon_rmap(struct page 
>>  {
>>  	atomic_set(&page->_mapcount, 0); /* elevate count by 1 (starts at -1) */
>>  	__page_set_anon_rmap(page, vma, address);
>> +	memctlr_inc_rss(page);
>>  }
>>  
>>  /**
>> @@ -565,6 +567,7 @@ void page_add_file_rmap(struct page *pag
>>  {
>>  	if (atomic_inc_and_test(&page->_mapcount))
>>  		__inc_zone_page_state(page, NR_FILE_MAPPED);
>> +	memctlr_inc_rss(page);
> 
> Consider a task maps one file page 100 times in different places
> and touches 'all of them'. In this case I see that you'll get
> 100 in rss counter while real rss will be just 1.
> 

Hmmm... something for me to think about. Depending on how we define
RSS, the code for accounting should be easy to add & modify depending
on how we define RSS. But you bring up a very good point.

>>  }
>>  
>>  /**
>> @@ -596,8 +599,9 @@ void page_remove_rmap(struct page *page)
>>  		if (page_test_and_clear_dirty(page))
>>  			set_page_dirty(page);
>>  		__dec_zone_page_state(page,
>> -				PageAnon(page) ? NR_ANON_PAGES : NR_FILE_MAPPED);
>> +				PageAnon(page) ?  NR_ANON_PAGES : NR_FILE_MAPPED);
> 
> What is this extra space after a question-mark for?

This is again something I changed and looks my undo was not very good.
Please ignore it, I'll remove it from the diff.

> 
>>  	}
>> +	memctlr_dec_rss(page, mm);
>>  }
>>  
>>  /*
>> diff -puN include/linux/rmap.h~container-memctlr-acct include/linux/rmap.h
>> --- linux-2.6.19-rc2/include/linux/rmap.h~container-memctlr-acct	2006-11-09 21:46:22.000000000 +0530
>> +++ linux-2.6.19-rc2-balbir/include/linux/rmap.h	2006-11-09 21:46:22.000000000 +0530
>> @@ -8,6 +8,7 @@
>>  #include <linux/slab.h>
>>  #include <linux/mm.h>
>>  #include <linux/spinlock.h>
>> +#include <linux/memctlr.h>
>>  
>>  /*
>>   * The anon_vma heads a list of private "related" vmas, to scan if
>> @@ -84,6 +85,7 @@ void page_remove_rmap(struct page *);
>>  static inline void page_dup_rmap(struct page *page)
>>  {
>>  	atomic_inc(&page->_mapcount);
>> +	memctlr_inc_rss(page);
>>  }
> 
> I'm not sure this is correct. page_dup_rmap() happens in the context
> of forking process and thus you'll increment rss counter on current.
> But this must be incremented at new task's counter, mustn't it?

This is fixed in the next patch container-memctlr-task-migration.
Thanks for spotting it.

-- 
	Thanks,
	Balbir Singh,
	Linux Technology Center,
	IBM Software Labs
