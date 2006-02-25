Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1160999AbWBYOjV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1160999AbWBYOjV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 09:39:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030262AbWBYOjV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 09:39:21 -0500
Received: from mail.stormboxes.com ([207.234.184.232]:50840 "EHLO
	dedicated.stormboxes.com") by vger.kernel.org with ESMTP
	id S1030261AbWBYOjU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 09:39:20 -0500
Message-ID: <44006C0E.7030106@stormboxes.com>
Date: Sat, 25 Feb 2006 09:39:10 -0500
From: Aubin LaBrosse <aubin@stormboxes.com>
User-Agent: Thunderbird 1.5 (Macintosh/20051201)
MIME-Version: 1.0
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
CC: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] for_each_online_pgdat (take2)  [2/5]  for_each_bootmem
References: <20060225151013.701ecc49.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20060225151013.701ecc49.kamezawa.hiroyu@jp.fujitsu.com>
Content-Type: multipart/mixed;
 boundary="------------000703010507060803030400"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000703010507060803030400
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

KAMEZAWA Hiroyuki wrote:
> This patch adds list_head to bootmem_data_t and make bootmems use it.
> bootmem list is sorted by node_boot_start.
>
> Only nodes against which init_bootmem() is called are linked to the list.
> (i386 allocates bootmem from only one node not from all online nodes.)
>
> A summary:
>  1. for_each_online_pgdat() traverses all *online* nodes.
>  2. alloc_bootmem() allocates memory only from initialized-for-bootmem nodes.
>
> Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
>
> Index: linux-2.6.16-rc4-mm2/include/linux/bootmem.h
> ===================================================================
> --- linux-2.6.16-rc4-mm2.orig/include/linux/bootmem.h
> +++ linux-2.6.16-rc4-mm2/include/linux/bootmem.h
> @@ -38,6 +38,7 @@ typedef struct bootmem_data {
>  	unsigned long last_pos;
>  	unsigned long last_success;	/* Previous allocation point.  To speed
>  					 * up searching */
> +	struct list_head list;
>  } bootmem_data_t;
>  
>  extern unsigned long __init bootmem_bootmap_pages (unsigned long);
> Index: linux-2.6.16-rc4-mm2/mm/bootmem.c
> ===================================================================
> --- linux-2.6.16-rc4-mm2.orig/mm/bootmem.c
> +++ linux-2.6.16-rc4-mm2/mm/bootmem.c
> @@ -33,6 +33,7 @@ EXPORT_SYMBOL(max_pfn);		/* This is expo
>  				 * dma_get_required_mask(), which uses
>  				 * it, can be an inline function */
>  
> +LIST_HEAD(bdata_list);
>  #ifdef CONFIG_CRASH_DUMP
>  /*
>   * If we have booted due to a crash, max_pfn will be a very low value. We need
> @@ -52,6 +53,27 @@ unsigned long __init bootmem_bootmap_pag
>  
>  	return mapsize;
>  }
> +/*
> + * link bdata in order
> + */
> +static void link_bootmem(bootmem_data_t *bdata)
> +{
> +	bootmem_data_t *ent;
> +	if (list_empty(&bdata_list)) {
> +		list_add(&bdata->list, &bdata_list);
> +		return;
> +	}
> +	/* insert in order */
> +	list_for_each_entry(ent, &bdata_list, list) {
> +		if (ent->node_boot_start < ent->node_boot_start) {
>   
       not a kernel hacker, but even I know that that 'if' isn't what 
you want. :)
> +			list_add_tail(&bdata->list, &ent->list);
> +			return;
> +		}
> +	}
> +	list_add_tail(&bdata->list, &bdata_list);
> +	return;
> +}
> +
>  
>  /*
>   * Called once to set up the allocator itself.
> @@ -62,13 +84,11 @@ static unsigned long __init init_bootmem
>  	bootmem_data_t *bdata = pgdat->bdata;
>  	unsigned long mapsize = ((end - start)+7)/8;
>  
> -	pgdat->pgdat_next = pgdat_list;
> -	pgdat_list = pgdat;
> -
>  	mapsize = ALIGN(mapsize, sizeof(long));
>  	bdata->node_bootmem_map = phys_to_virt(mapstart << PAGE_SHIFT);
>  	bdata->node_boot_start = (start << PAGE_SHIFT);
>  	bdata->node_low_pfn = end;
> +	link_bootmem(bdata);
>  
>  	/*
>  	 * Initially all pages are reserved - setup_arch() has to
> @@ -383,12 +403,11 @@ unsigned long __init free_all_bootmem (v
>  
>  void * __init __alloc_bootmem(unsigned long size, unsigned long align, unsigned long goal)
>  {
> -	pg_data_t *pgdat = pgdat_list;
> +	bootmem_data_t *bdata;
>  	void *ptr;
>  
> -	for_each_pgdat(pgdat)
> -		if ((ptr = __alloc_bootmem_core(pgdat->bdata, size,
> -						 align, goal, 0)))
> +	list_for_each_entry(bdata, &bdata_list, list)
> +		if ((ptr = __alloc_bootmem_core(bdata, size, align, goal, 0)))
>  			return(ptr);
>  
>  	/*
> @@ -416,11 +435,11 @@ void * __init __alloc_bootmem_node(pg_da
>  
>  void * __init __alloc_bootmem_low(unsigned long size, unsigned long align, unsigned long goal)
>  {
> -	pg_data_t *pgdat = pgdat_list;
> +	bootmem_data_t *bdata;
>  	void *ptr;
>  
> -	for_each_pgdat(pgdat)
> -		if ((ptr = __alloc_bootmem_core(pgdat->bdata, size,
> +	list_for_each_entry(bdata, &bdata_list, list)
> +		if ((ptr = __alloc_bootmem_core(bdata, size,
>  						 align, goal, LOW32LIMIT)))
>  			return(ptr);
>  
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>   


--------------000703010507060803030400
Content-Type: text/x-vcard; charset=utf-8;
 name="aubin.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="aubin.vcf"

begin:vcard
fn:Aubin LaBrosse
n:LaBrosse;Aubin
email;internet:aubin@stormboxes.com
tel;work:589-0692
tel;home:429-1520
tel;cell:493-0121
version:2.1
end:vcard


--------------000703010507060803030400--
