Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932795AbWKSSfu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932795AbWKSSfu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 13:35:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932792AbWKSSfu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 13:35:50 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:10723 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S932795AbWKSSft (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 13:35:49 -0500
Message-ID: <4560A348.8000106@oracle.com>
Date: Sun, 19 Nov 2006 10:32:40 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: "Myaskouvskey, Artiom" <artiom.myaskouvskey@intel.com>
CC: davej@codemonkey.org.uk, hpa@zytor.com, linux-kernel@vger.kernel.org,
       "Satt, Shai" <shai.satt@intel.com>
Subject: Re: [PATCH 2.6.19-rc6-git2] EFI: mapping memory region of runtime
 services when using memmap kernel parameter
References: <C1467C8B168BCF40ACEC2324C1A2B074A6A6A1@hasmsx411.ger.corp.intel.com>
In-Reply-To: <C1467C8B168BCF40ACEC2324C1A2B074A6A6A1@hasmsx411.ger.corp.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Myaskouvskey, Artiom wrote:
> From: Artiom Myaskouvskey <artiom.myaskouvskey@intel.com>
> 
> When using memmap kernel parameter in EFI boot we should also add to memory map 
> memory regions of runtime services to enable their mapping later.
> 
> Signed-off-by: Artiom Myaskouvskey <artiom.myaskouvskey@intel.com>
> ---

The double linefeeds are gone. which is Good.
It looks like you ignored the rest of my comments.  :(

and for some reason, when I save this from tbird or sylpheed,
all I get is base64 mess.  Can anyone tell me how to convert
that to something that is usable?

(I wonder why I didn't see this patch version on lkml...)

> diff -uprN linux-2.6.19-rc6-git2.original/include/linux/efi.h linux-2.6.19-rc6-git2/include/linux/efi.h
> --- linux-2.6.19-rc6-git2.original/include/linux/efi.h	2006-11-19 10:47:41.000000000 +0200
> +++ linux-2.6.19-rc6-git2/include/linux/efi.h	2006-11-19 11:06:35.000000000 +0200
> @@ -302,6 +302,7 @@ extern void efi_initialize_iomem_resourc
>  					struct resource *data_resource);
>  extern unsigned long __init efi_get_time(void);
>  extern int __init efi_set_rtc_mmss(unsigned long nowtime);
> +extern int is_available_memory(efi_memory_desc_t * md);
>  extern struct efi_memory_map memmap;
>  
>  /**
> diff -uprN linux-2.6.19-rc6-git2.original/arch/i386/kernel/setup.c linux-2.6.19-rc6-git2/arch/i386/kernel/setup.c
> --- linux-2.6.19-rc6-git2.original/arch/i386/kernel/setup.c	2006-11-19 10:48:20.000000000 +0200
> +++ linux-2.6.19-rc6-git2/arch/i386/kernel/setup.c	2006-11-19 11:23:27.000000000 +0200
> @@ -349,25 +349,44 @@ static void __init probe_roms(void)
>  static void __init limit_regions(unsigned long long size)
>  {
>  	unsigned long long current_addr = 0;
> -	int i;
> +	int i , j;
>  
>  	if (efi_enabled) {
> -		efi_memory_desc_t *md;
> -		void *p;
> +		efi_memory_desc_t *md, *next_md = 0;
> +		void *p, *p1;
>  
> -		for (p = memmap.map, i = 0; p < memmap.map_end;
> -			p += memmap.desc_size, i++) {
> +		for (p = memmap.map, i = 0,j = 0, p1 = memmap.map;
> +			p < memmap.map_end; p += memmap.desc_size, i++) {
>  			md = p;
> -			current_addr = md->phys_addr + (md->num_pages << 12);
> -			if (md->type == EFI_CONVENTIONAL_MEMORY) {
> +			next_md = p1;
> +			current_addr = md->phys_addr + 
> +				PFN_PHYS(md->num_pages);
> +			if (is_available_memory(md)) {
> +				if (md->phys_addr >= size) continue;
> +				memcpy(next_md, md, memmap.desc_size);
>  				if (current_addr >= size) {
> -					md->num_pages -=
> -						(((current_addr-size) + PAGE_SIZE-1) >> PAGE_SHIFT);
> -					memmap.nr_map = i + 1;
> -					return;
> +					next_md->num_pages -=
> +						PFN_UP(current_addr-size);
>  				}
> +				p1 += memmap.desc_size;
> +				next_md = p1;
> +				j++;
> +			}
> +			else if ((md->attribute & EFI_MEMORY_RUNTIME) ==
> +						EFI_MEMORY_RUNTIME) {
> +				/* In order to make runtime services 
> +				 * available we have to include runtime
> +				 * memory regions in memory map */
> +				memcpy(next_md, md, memmap.desc_size);
> +				p1 += memmap.desc_size;
> +				next_md = p1;
> +				j++;
>  			}
>  		}
> +		memmap.nr_map = j;
> +		memmap.map_end = memmap.map + 
> +			(memmap.nr_map * memmap.desc_size);
> +		return;
>  	}
>  	for (i = 0; i < e820.nr_map; i++) {
>  		current_addr = e820.map[i].addr + e820.map[i].size;


-- 
~Randy
