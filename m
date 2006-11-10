Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946117AbWKJJLn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946117AbWKJJLn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 04:11:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946112AbWKJJLm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 04:11:42 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:56234 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1946117AbWKJJLl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 04:11:41 -0500
Message-ID: <4554412C.3070904@openvz.org>
Date: Fri, 10 Nov 2006 12:06:52 +0300
From: Pavel Emelianov <xemul@openvz.org>
User-Agent: Thunderbird 1.5 (X11/20060317)
MIME-Version: 1.0
To: Balbir Singh <balbir@in.ibm.com>
CC: Linux MM <linux-mm@kvack.org>, dev@openvz.org,
       ckrm-tech@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       haveblue@us.ibm.com, rohitseth@google.com
Subject: Re: [RFC][PATCH 4/8] RSS controller accounting
References: <20061109193523.21437.86224.sendpatchset@balbir.in.ibm.com> <20061109193600.21437.74220.sendpatchset@balbir.in.ibm.com>
In-Reply-To: <20061109193600.21437.74220.sendpatchset@balbir.in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Balbir Singh wrote:
> Account RSS usage of a task and the associated container. The definition
> of RSS was debated and discussed in the following thread
> 
> 	http://lkml.org/lkml/2006/10/10/130
> 
> 
> The code tracks all resident pages (including shared pages) as RSS. This patch
> can easily adapt to the definition of RSS that will be agreed upon. This
> implementation provides a proof of concept RSS controller.
> 
> The accounting is inspired from Rohit Seth's container patches.
> 
> TODO's
> 
> 1. Merge file_rss and anon_rss tracking with the current rss tracking to
>    maximize code reuse
> 2. Add/remove RSS tracking as the definition of RSS evolves
> 
> 
> Signed-off-by: Balbir Singh <balbir@in.ibm.com>
> ---
> 

[snip]

> --- linux-2.6.19-rc2/kernel/res_group/memctlr.c~container-memctlr-acct	2006-11-09 21:46:22.000000000 +0530
> +++ linux-2.6.19-rc2-balbir/kernel/res_group/memctlr.c	2006-11-09 21:47:06.000000000 +0530
> @@ -37,6 +37,8 @@ static struct resource_group *root_rgrou
>  static const char version[] = "0.01";
>  static struct memctlr *memctlr_root;
>  
> +#define MEMCTLR_MAGIC	0xdededede
> +
>  struct mem_counter {
>  	atomic_long_t	rss;
>  };
> @@ -49,6 +51,7 @@ struct memctlr {
>  	/* Statistics */
>  	int successes;
>  	int failures;
> +	int magic;

What is this magic for? Is it just for debugging?

[snip]

> +static inline struct memctlr *get_memctlr_from_page(struct page *page)
> +{
> +	struct resource_group *rgroup;
> +	struct memctlr *res;
> +
> +	/*
> +	 * Is the resource groups infrastructure initialized?
> +	 */
> +	if (!memctlr_root)
> +		return NULL;
> +
> +	rcu_read_lock();
> +	rgroup = (struct resource_group *)rcu_dereference(current->container);
> +	rcu_read_unlock();
> +
> +	res = get_memctlr(rgroup);
> +	if (!res)
> +		return NULL;
> +
> +	BUG_ON(res->magic != MEMCTLR_MAGIC);
> +	return res;
> +}

I don't see how page passed to this function is involved into
'struct memctlr *res' determining. Could you comment this?

[snip]

> --- linux-2.6.19-rc2/mm/rmap.c~container-memctlr-acct	2006-11-09 21:46:22.000000000 +0530
> +++ linux-2.6.19-rc2-balbir/mm/rmap.c	2006-11-09 21:46:22.000000000 +0530
> @@ -537,6 +537,7 @@ void page_add_anon_rmap(struct page *pag
>  	if (atomic_inc_and_test(&page->_mapcount))
>  		__page_set_anon_rmap(page, vma, address);
>  	/* else checking page index and mapping is racy */
> +	memctlr_inc_rss(page);
>  }
>  
>  /*
> @@ -553,6 +554,7 @@ void page_add_new_anon_rmap(struct page 
>  {
>  	atomic_set(&page->_mapcount, 0); /* elevate count by 1 (starts at -1) */
>  	__page_set_anon_rmap(page, vma, address);
> +	memctlr_inc_rss(page);
>  }
>  
>  /**
> @@ -565,6 +567,7 @@ void page_add_file_rmap(struct page *pag
>  {
>  	if (atomic_inc_and_test(&page->_mapcount))
>  		__inc_zone_page_state(page, NR_FILE_MAPPED);
> +	memctlr_inc_rss(page);

Consider a task maps one file page 100 times in different places
and touches 'all of them'. In this case I see that you'll get
100 in rss counter while real rss will be just 1.

>  }
>  
>  /**
> @@ -596,8 +599,9 @@ void page_remove_rmap(struct page *page)
>  		if (page_test_and_clear_dirty(page))
>  			set_page_dirty(page);
>  		__dec_zone_page_state(page,
> -				PageAnon(page) ? NR_ANON_PAGES : NR_FILE_MAPPED);
> +				PageAnon(page) ?  NR_ANON_PAGES : NR_FILE_MAPPED);

What is this extra space after a question-mark for?

>  	}
> +	memctlr_dec_rss(page, mm);
>  }
>  
>  /*
> diff -puN include/linux/rmap.h~container-memctlr-acct include/linux/rmap.h
> --- linux-2.6.19-rc2/include/linux/rmap.h~container-memctlr-acct	2006-11-09 21:46:22.000000000 +0530
> +++ linux-2.6.19-rc2-balbir/include/linux/rmap.h	2006-11-09 21:46:22.000000000 +0530
> @@ -8,6 +8,7 @@
>  #include <linux/slab.h>
>  #include <linux/mm.h>
>  #include <linux/spinlock.h>
> +#include <linux/memctlr.h>
>  
>  /*
>   * The anon_vma heads a list of private "related" vmas, to scan if
> @@ -84,6 +85,7 @@ void page_remove_rmap(struct page *);
>  static inline void page_dup_rmap(struct page *page)
>  {
>  	atomic_inc(&page->_mapcount);
> +	memctlr_inc_rss(page);
>  }

I'm not sure this is correct. page_dup_rmap() happens in the context
of forking process and thus you'll increment rss counter on current.
But this must be incremented at new task's counter, mustn't it?
