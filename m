Return-Path: <linux-kernel-owner+w=401wt.eu-S1947578AbWLIAa5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947578AbWLIAa5 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 19:30:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947585AbWLIAa5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 19:30:57 -0500
Received: from smtp.osdl.org ([65.172.181.25]:57087 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1947578AbWLIAa4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 19:30:56 -0500
Date: Fri, 8 Dec 2006 16:30:20 -0800
From: Andrew Morton <akpm@osdl.org>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: linux-kernel@vger.kernel.org, clameter@engr.sgi.com, apw@shadowen.org
Subject: Re: [RFC] [PATCH] virtual memmap on sparsemem v3 [3/4] static
 virtual mem_map
Message-Id: <20061208163020.4650bbaa.akpm@osdl.org>
In-Reply-To: <20061208160708.c263a393.kamezawa.hiroyu@jp.fujitsu.com>
References: <20061208155608.14dcd2e5.kamezawa.hiroyu@jp.fujitsu.com>
	<20061208160708.c263a393.kamezawa.hiroyu@jp.fujitsu.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Dec 2006 16:07:08 +0900
KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com> wrote:

> This patch adds support for statically allocated virtual mem_map.
> (means virtual address of mem_map array is defined statically.)
> This removes reference to *(&mem_map).
> 
> Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
> 
> 
> Index: devel-2.6.19/include/linux/mmzone.h
> ===================================================================
> --- devel-2.6.19.orig/include/linux/mmzone.h	2006-12-08 15:04:30.000000000 +0900
> +++ devel-2.6.19/include/linux/mmzone.h	2006-12-08 15:05:18.000000000 +0900
> @@ -618,8 +618,13 @@
>  #if (((BITS_PER_LONG/4) * PAGES_PER_SECTION) % PAGE_SIZE) != 0
>  #error "PAGE_SIZE/SECTION_SIZE relationship is not suitable for vmem_map"
>  #endif
> +#ifdef CONFIG_SPARSEMEM_VMEMMAP_STATIC
> +#include <linux/mm_types.h>
> +extern struct page mem_map[];
> +#else
>  extern struct page* mem_map;
>  #endif
> +#endif

This looks rather unpleasant - what went wrong here?

Would prefer to unconditionally include the header file - conditional inclusions
like this can cause compile failures when someone changes a config option.  They
generally raise the complexity level.
