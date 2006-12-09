Return-Path: <linux-kernel-owner+w=401wt.eu-S1947581AbWLIA3B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947581AbWLIA3B (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 19:29:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947586AbWLIA3B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 19:29:01 -0500
Received: from smtp.osdl.org ([65.172.181.25]:56984 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1947581AbWLIA3A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 19:29:00 -0500
Date: Fri, 8 Dec 2006 16:28:19 -0800
From: Andrew Morton <akpm@osdl.org>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: linux-kernel@vger.kernel.org, clameter@engr.sgi.com, apw@shadowen.org
Subject: Re: [RFC] [PATCH] virtual memmap on sparsemem v3 [1/4]  map and
 unmap
Message-Id: <20061208162819.f809d703.akpm@osdl.org>
In-Reply-To: <20061208160142.d40cf636.kamezawa.hiroyu@jp.fujitsu.com>
References: <20061208155608.14dcd2e5.kamezawa.hiroyu@jp.fujitsu.com>
	<20061208160142.d40cf636.kamezawa.hiroyu@jp.fujitsu.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Dec 2006 16:01:42 +0900
KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com> wrote:

> When we want to map pages into the kernel space by vmalloc()'s routine,
> we always need 'struct page' to do that.
> 
> There are cases where there is no page struct to use (bootstrap, etc..).
> This function is designed to help map any memory to anywhere, anytime.
> 
> Users should manage their virtual/physical space by themselves.
> Because it's complex and danger to manage virtual address space by
> each function's own code, it's better to use fixed address.
> 
> Note: My first purpose is supporting virtual mem_map both at boot/hotplug
>       sharing the same logic.
> 

A little thing:


> +		if (ops->k_pte_alloc) {
> +			ret = ops->k_pte_alloc(pmd, addr, data);
> +			if (ret)
> +				return ret;
> +		} else {
> +			pte = pte_alloc_kernel(pmd, addr);
> +			if (!pte)
> +				return -ENOMEM;
> +		}

> +		if (ops->k_pmd_alloc) {
> +			ret = ops->k_pmd_alloc(pud, addr, data);
> +			if (ret)
> +				return ret;
> +		} else {
> +			pmd = pmd_alloc(&init_mm, pud, addr);
> +			if (!pmd)
> +				return -ENOMEM;

> +		if (ops->k_pud_alloc) {
> +			ret = ops->k_pud_alloc(pgd, addr, data);
> +			if (ret)
> +				return ret;
> +		} else {
> +			pud = pud_alloc(&init_mm, pgd, addr);
> +			if (!pud)
> +				return -ENOMEM;
> +		}

Generally we prefer to simply *require* that the function vector be filled
in appropriately.  So if the caller has no special needs, the caller will
set their gen_map_kern_ops.k_pte_alloc to point at pte_alloc_kernel().

erk, pte_alloc_kernel() is a macro.  As is pmd_alloc(), etc.  Well, let
that be a lesson to us.  What a mess.

I suppose we could go through and convert them all to inlines and then the
compiler will generate an out-of-line copy for us.  Better would be to turn
these things into regular, out-of-line C functions.

What a mess.
