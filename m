Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751110AbWGDFpo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751110AbWGDFpo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 01:45:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751114AbWGDFpo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 01:45:44 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:42694 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751110AbWGDFpn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 01:45:43 -0400
Date: Tue, 4 Jul 2006 14:47:24 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Christoph Lameter <clameter@sgi.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, hugh@veritas.com,
       kernel@kolivas.org, marcelo@kvack.org, nickpiggin@yahoo.com.au,
       clameter@sgi.com, ak@suse.de
Subject: Re: [RFC 3/8] Move HIGHMEM counter into highmem.c/.h
Message-Id: <20060704144724.65c43a38.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20060703215550.7566.79975.sendpatchset@schroedinger.engr.sgi.com>
References: <20060703215534.7566.8168.sendpatchset@schroedinger.engr.sgi.com>
	<20060703215550.7566.79975.sendpatchset@schroedinger.engr.sgi.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Jul 2006 14:55:50 -0700 (PDT)
Christoph Lameter <clameter@sgi.com> wrote:

> Move highmem counters into highmem.c/.h
> 
> Move the totalhigh_pages definition into highmem.c/.h
> 
Hi, I love this patch series :)

I found this :
== arch/um/kernel/mem.c ==

void mem_init(void)
{
<snip>
   totalhigh_pages = highmem >> PAGE_SHIFT;
....
==
this should be covered by CONFIG_HIGHMEM if you change totalhigh_pages 
to be #define.

Regards,
-Kame



> Signed-off-by: Christoph Lameter <clameter@sgi.com>
> 
> Index: linux-2.6.17-mm6/include/linux/highmem.h
> ===================================================================
> --- linux-2.6.17-mm6.orig/include/linux/highmem.h	2006-07-03 13:47:21.556579985 -0700
> +++ linux-2.6.17-mm6/include/linux/highmem.h	2006-07-03 14:03:39.168021629 -0700
> @@ -24,11 +24,14 @@ static inline void flush_kernel_dcache_p
>  
>  /* declarations for linux/mm/highmem.c */
>  unsigned int nr_free_highpages(void);
> +extern unsigned long totalhigh_pages;
>  
>  #else /* CONFIG_HIGHMEM */
>  
>  static inline unsigned int nr_free_highpages(void) { return 0; }
>  
> +#define totalhigh_pages 0
> +
>  static inline void *kmap(struct page *page)
>  {
>  	might_sleep();
> Index: linux-2.6.17-mm6/include/linux/swap.h
> ===================================================================
> --- linux-2.6.17-mm6.orig/include/linux/swap.h	2006-07-03 13:47:22.066314085 -0700
> +++ linux-2.6.17-mm6/include/linux/swap.h	2006-07-03 14:03:39.168998131 -0700
> @@ -162,7 +162,6 @@ extern void swapin_readahead(swp_entry_t
>  
>  /* linux/mm/page_alloc.c */
>  extern unsigned long totalram_pages;
> -extern unsigned long totalhigh_pages;
>  extern unsigned long totalreserve_pages;
>  extern long nr_swap_pages;
>  extern unsigned int nr_free_pages(void);
> Index: linux-2.6.17-mm6/mm/page_alloc.c
> ===================================================================
> --- linux-2.6.17-mm6.orig/mm/page_alloc.c	2006-07-03 14:03:19.964129358 -0700
> +++ linux-2.6.17-mm6/mm/page_alloc.c	2006-07-03 14:03:39.170951135 -0700
> @@ -51,7 +51,6 @@ EXPORT_SYMBOL(node_online_map);
>  nodemask_t node_possible_map __read_mostly = NODE_MASK_ALL;
>  EXPORT_SYMBOL(node_possible_map);
>  unsigned long totalram_pages __read_mostly;
> -unsigned long totalhigh_pages __read_mostly;
>  unsigned long totalreserve_pages __read_mostly;
>  long nr_swap_pages;
>  int percpu_pagelist_fraction;
> Index: linux-2.6.17-mm6/mm/shmem.c
> ===================================================================
> --- linux-2.6.17-mm6.orig/mm/shmem.c	2006-07-03 13:47:22.646356337 -0700
> +++ linux-2.6.17-mm6/mm/shmem.c	2006-07-03 14:03:39.171927638 -0700
> @@ -45,6 +45,7 @@
>  #include <linux/namei.h>
>  #include <linux/ctype.h>
>  #include <linux/migrate.h>
> +#include <linux/highmem.h>
>  
>  #include <asm/uaccess.h>
>  #include <asm/div64.h>
> Index: linux-2.6.17-mm6/mm/highmem.c
> ===================================================================
> --- linux-2.6.17-mm6.orig/mm/highmem.c	2006-07-03 13:47:22.613155266 -0700
> +++ linux-2.6.17-mm6/mm/highmem.c	2006-07-03 14:03:39.172904140 -0700
> @@ -46,6 +46,7 @@ static void *mempool_alloc_pages_isa(gfp
>   */
>  #ifdef CONFIG_HIGHMEM
>  
> +unsigned long totalhigh_pages __read_mostly;
>  static int pkmap_count[LAST_PKMAP];
>  static unsigned int last_pkmap_nr;
>  static  __cacheline_aligned_in_smp DEFINE_SPINLOCK(kmap_lock);
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

