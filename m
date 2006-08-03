Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964776AbWHCSN7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964776AbWHCSN7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 14:13:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964777AbWHCSN7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 14:13:59 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:6299 "EHLO e36.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S964776AbWHCSN6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 14:13:58 -0400
Subject: Re: [PATCH] memory hotadd fixes [1/5] not-aligned memory hotadd
	handling fix
From: keith mannthey <kmannth@us.ibm.com>
Reply-To: kmannth@us.ibm.com
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
       lhms-devel <lhms-devel@lists.sourceforge.net>,
       "y-goto@jp.fujitsu.com" <y-goto@jp.fujitsu.com>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20060803123039.c50feb85.kamezawa.hiroyu@jp.fujitsu.com>
References: <20060803123039.c50feb85.kamezawa.hiroyu@jp.fujitsu.com>
Content-Type: text/plain
Organization: Linux Technology Center IBM
Date: Thu, 03 Aug 2006 11:13:48 -0700
Message-Id: <1154628828.5925.8.camel@keithlap>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-03 at 12:30 +0900, KAMEZAWA Hiroyuki wrote:
> After Keith's report of memory hotadd failure, I increased test patterns.
> These patches are a result of new patterns. But I cannot cover all existing
> memory layout in the world, more tests are needed.
> Now, I think my patch can make things better and want this codes to be tested
> in -mm.patche series is consitsts of 5 patches.

I will test and review today.  
 
Thanks,
  Keith 

> ==
> ioresouce handling code in memory hotplug allows not-aligned memory hot add.
> But when memmap and other memory structures are initialized, parameters
> should be aligned. (if not aligned, initialization of mem_map will do wrong,
> it assumes parameters are aligned.) This patch fix it.
> 
> And this patch allows ioresource collision check to handle -EEXIST.
> 
> Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
> 
> 
>  mm/memory_hotplug.c |   23 ++++++++++++++++-------
>  1 files changed, 16 insertions(+), 7 deletions(-)
> 
> Index: linux-2.6.18-rc3/mm/memory_hotplug.c
> ===================================================================
> --- linux-2.6.18-rc3.orig/mm/memory_hotplug.c	2006-08-01 16:11:56.000000000 +0900
> +++ linux-2.6.18-rc3/mm/memory_hotplug.c	2006-08-01 16:38:19.000000000 +0900
> @@ -76,15 +76,22 @@
>  {
>  	unsigned long i;
>  	int err = 0;
> +	int start_sec, end_sec;
> +	/* during initialize mem_map, align hot-added range to section */
> +	start_sec = pfn_to_section_nr(phys_start_pfn);
> +	end_sec = pfn_to_section_nr(phys_start_pfn + nr_pages - 1);
>  
> -	for (i = 0; i < nr_pages; i += PAGES_PER_SECTION) {
> -		err = __add_section(zone, phys_start_pfn + i);
> +	for (i = start_sec; i <= end_sec; i++) {
> +		err = __add_section(zone, i << PFN_SECTION_SHIFT);
>  
> -		/* We want to keep adding the rest of the
> -		 * sections if the first ones already exist
> +		/*
> +		 * EEXIST is finally dealed with by ioresource collision
> +		 * check. see add_memory() => register_memory_resource()
> +		 * Warning will be printed if there is collision.
>  		 */
>  		if (err && (err != -EEXIST))
>  			break;
> +		err = 0;
>  	}
>  
>  	return err;
> @@ -213,10 +220,10 @@
>  }
>  
>  /* add this memory to iomem resource */
> -static void register_memory_resource(u64 start, u64 size)
> +static int register_memory_resource(u64 start, u64 size)
>  {
>  	struct resource *res;
> -
> +	int ret = 0;
>  	res = kzalloc(sizeof(struct resource), GFP_KERNEL);
>  	BUG_ON(!res);
>  
> @@ -228,7 +235,9 @@
>  		printk("System RAM resource %llx - %llx cannot be added\n",
>  		(unsigned long long)res->start, (unsigned long long)res->end);
>  		kfree(res);
> +		ret = -EEXIST;
>  	}
> +	return ret;
>  }
>  
> 
> @@ -269,7 +278,7 @@
>  	}
>  
>  	/* register this memory as resource */
> -	register_memory_resource(start, size);
> +	ret = register_memory_resource(start, size);
>  
>  	return ret;
>  error:


