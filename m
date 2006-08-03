Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964833AbWHCS2w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964833AbWHCS2w (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 14:28:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964829AbWHCS2u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 14:28:50 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:63901 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S964833AbWHCS2t
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 14:28:49 -0400
Subject: Re: [PATCH] memory hotadd fixes [4/5] avoid check in acpi
From: keith mannthey <kmannth@us.ibm.com>
Reply-To: kmannth@us.ibm.com
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
       lhms-devel <lhms-devel@lists.sourceforge.net>,
       "y-goto@jp.fujitsu.com" <y-goto@jp.fujitsu.com>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20060803123604.0f909208.kamezawa.hiroyu@jp.fujitsu.com>
References: <20060803123604.0f909208.kamezawa.hiroyu@jp.fujitsu.com>
Content-Type: text/plain
Organization: Linux Technology Center IBM
Date: Thu, 03 Aug 2006 11:28:44 -0700
Message-Id: <1154629724.5925.20.camel@keithlap>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-03 at 12:36 +0900, KAMEZAWA Hiroyuki wrote:
> add_memory() does all necessary check to avoid collision.
> then, acpi layer doesn't have to check region by itself.
> 
> (*) pfn_valid() just returns page struct is valid or not. It returns 0
>     if a section has been already added even is ioresource is not added.
>     ioresource collision check in mm/memory_hotplug.c can do more precise
>     collistion check.
>     added enabled bit check just for sanity check..
> 
> Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
> 
> 
>  drivers/acpi/acpi_memhotplug.c |    9 +--------
>  1 files changed, 1 insertion(+), 8 deletions(-)
> 
> Index: linux-2.6.18-rc3/drivers/acpi/acpi_memhotplug.c
> ===================================================================
> --- linux-2.6.18-rc3.orig/drivers/acpi/acpi_memhotplug.c	2006-08-01 16:11:47.000000000 +0900
> +++ linux-2.6.18-rc3/drivers/acpi/acpi_memhotplug.c	2006-08-02 14:12:45.000000000 +0900
> @@ -230,17 +230,10 @@
>  	 * (i.e. memory-hot-remove function)
>  	 */
>  	list_for_each_entry(info, &mem_device->res_list, list) {
> -		u64 start_pfn, end_pfn;
> -
> -		start_pfn = info->start_addr >> PAGE_SHIFT;
> -		end_pfn = (info->start_addr + info->length - 1) >> PAGE_SHIFT;
> -
> -		if (pfn_valid(start_pfn) || pfn_valid(end_pfn)) {
> -			/* already enabled. try next area */
> +		if (info->enabled) { /* just sanity check...*/
>  			num_enabled++;
>  			continue;
>  		}

This check needs to go.  pfn_valid is a sparsemem specific check. Sanity
checking should be done it the the add_memory code. 

I will test and let you know. This is going to expose some baddness I
see already with my RESERVE path work. (Extra add_memory calls from this
driver during boot....)


Thanks,
keith mannthey <kmannth@us.ibm.com>
Linux Technology Center IBM

