Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262902AbUDEPlc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 11:41:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262917AbUDEPlc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 11:41:32 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:38139 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262931AbUDEPlV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 11:41:21 -0400
Subject: Re: Migrate pages from a ccNUMA node to another - patch
From: Dave Hansen <haveblue@us.ibm.com>
To: Zoltan.Menyhart@bull.net
Cc: Hirokazu Takahashi <taka@valinux.co.jp>, linux-ia64@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       iwamoto@valinux.co.jp
In-Reply-To: <4071763E.7293CFCC@nospam.org>
References: <40695802.1F13AB0D@nospam.org>
	 <20040330.210804.71938972.taka@valinux.co.jp>
	 <40698501.BD3E12BF@nospam.org>
	 <20040403.115833.74749140.taka@valinux.co.jp>
	 <4071763E.7293CFCC@nospam.org>
Content-Type: text/plain
Message-Id: <1081179633.8956.2992.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 05 Apr 2004 08:40:33 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-04-05 at 08:07, Zoltan Menyhart wrote:
> Hirokazu Takahashi wrote:
> 
> > I guess aruguments src_node, mm and pte would be redundant since
> > they can be looked up from old_p with the reverse mapping scheme.
> 
> In my version 0.2, I can do with only the following arguments:
>  *		node:	Destination NUMA node
>  *		mm:	-> victim "mm_struct"
>  *		pte:	-> PTE of the page to be moved
> (If I have "mm" at hand, why not to use it ? Why not to avoid fetching the r-map
> page struct ?)

That's a good point.  There is at least some cost (at least 1 lock)
associated with walking the rmap chains.  If it can be avoided, it might
as well be.  

But, if someone needs the "no walk" interface, just wrap the function:

foo(page)
{
	rmap_results = get_rmap_stuff(page);
	__foo(page, rmap_results);
}

__foo(page, rmap_results)
{
...
}

> > >Notes: "pte" can be NULL if I do not know it apriori
> > >       I cannot release "mm->page_table_lock" otherwise I have to re-scan the "mm->pgd".
> > 
> > Re-schan plicy would be much better since migrating pages is heavy work.
> > I don't think that holding mm->page_table_lock for long time would be
> > good idea.
> 
> Re-scanning is "cache killer", at least on IA64 with huge user memory size.
> I have more than 512 Mbytes user memory and its PTEs do not fit into the L2 cache.
> 
> In my current design, I have the outer loops: PGD, PMD and PTE walking; and once
> I find a valid PTE, I check it against the list of max. 2048 physical addresses as
> the inner loop.
> I reversed them: walking through the list of max. 2048 physical addresses as outer
> loop and the PGD - PMD - PTE scans as inner loops resulted in 4 to 5 times slower
> migration.

Could you explain where you're getting these "magic numbers?"  I don't
quite understand the significance of 2048 physical addresses or 512 MB
of memory.

Zoltan, it appears that we have a bit of an inherent conflict with how
much CPU each of you is expecting to use in the removal and migration
cases.  You're coming from a HPC environment where each CPU cycle is
valuable, while the people trying to remove memory are probably going to
be taking CPUs offline soon anyway, and care a bit less about how
efficient they're being with CPU and cache resources.  

Could you be a bit more explicit about how expensive (cpu-wise) these
migrate operations can be?

-- Dave

