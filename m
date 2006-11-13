Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755262AbWKMQ7V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755262AbWKMQ7V (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 11:59:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755264AbWKMQ7V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 11:59:21 -0500
Received: from xenotime.net ([66.160.160.81]:25761 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1755262AbWKMQ7T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 11:59:19 -0500
Date: Mon, 13 Nov 2006 08:59:22 -0800
From: Randy Dunlap <rdunlap@xenotime.net>
To: "Myaskouvskey, Artiom" <artiom.myaskouvskey@intel.com>
Cc: davej@codemonkey.org.uk, hpa@zytor.com, linux-kernel@vger.kernel.org,
       shai.satt@intel.com
Subject: Re: [PATCH 2.6.19-rc5-git2]  EFI: mapping memory region of runtime
 services when using memmap kernel parameter
Message-Id: <20061113085922.42ac2a73.rdunlap@xenotime.net>
In-Reply-To: <C1467C8B168BCF40ACEC2324C1A2B074A6A69C@hasmsx411.ger.corp.intel.com>
References: <C1467C8B168BCF40ACEC2324C1A2B074A6A69C@hasmsx411.ger.corp.intel.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Nov 2006 13:08:50 +0200 Myaskouvskey, Artiom wrote:

> From: Artiom Myaskouvskey <artiom.myaskouvskey@intel.com>
>  
> When using memmap kernel parameter in EFI boot we should also add to memory map 
> memory regions of runtime services to enable their mapping later.
> 
> Signed-off-by: Artiom Myaskouvskey <artiom.myaskouvskey@intel.com>
> ---

Much better (no line wrap), but still has problems with
a.  extern not in a header file
b.  lines > 80 columns
c.  trailing whitespace (in both EFI patches)


(sorry if you receive duplicates, my original was dropped or blocked;
oh, the email address strings were odd)
(third/final attempt)

> diff -uprN linux-2.6.19-rc5-git2.orig/arch/i386/kernel/setup.c linux-2.6.19-rc5-git2/arch/i386/kernel/setup.c
> --- linux-2.6.19-rc5-git2.orig/arch/i386/kernel/setup.c	2006-11-13 11:15:17.000000000 +0200
> +++ linux-2.6.19-rc5-git2/arch/i386/kernel/setup.c	2006-11-13 11:15:42.000000000 +0200
> @@ -346,28 +346,44 @@ static void __init probe_roms(void)
>  	}
>  }
>  
> +extern int is_available_memory(efi_memory_desc_t * md);
> +
>  static void __init limit_regions(unsigned long long size)
>  {
>  	unsigned long long current_addr = 0;
> -	int i;
> +	int i , j;
>  
> -	if (efi_enabled) {
> -		efi_memory_desc_t *md;
> -		void *p;
> +	if (efi_enabled) {		
> +		efi_memory_desc_t *md, *next_md = 0;
> +		void *p, *p1;
>  
> -		for (p = memmap.map, i = 0; p < memmap.map_end;
> +		for (p = memmap.map, i = 0,j = 0, p1 = memmap.map; p < memmap.map_end;
>  			p += memmap.desc_size, i++) {
>  			md = p;
> +			next_md = p1;
>  			current_addr = md->phys_addr + (md->num_pages << 12);
> -			if (md->type == EFI_CONVENTIONAL_MEMORY) {
> -				if (current_addr >= size) {
> -					md->num_pages -=
> -						(((current_addr-size) + PAGE_SIZE-1) >> PAGE_SHIFT);
> -					memmap.nr_map = i + 1;
> -					return;
> +			if (is_available_memory(md)) {
> +				if (md->phys_addr >= size) continue;
> +				memcpy(next_md, md, memmap.desc_size);				
> +                                if (current_addr >= size) {
> +					next_md->num_pages -= (((current_addr-size) + PAGE_SIZE-1) >> PAGE_SHIFT);
>  				}
> +				p1 += memmap.desc_size;
> +				next_md = p1;
> +				j++;
>  			}
> -		}
> +			else if ((md->attribute & EFI_MEMORY_RUNTIME) == EFI_MEMORY_RUNTIME) {
> +				/* In order to make runtime services available we have to include runtime 
> +				 * memory regions in memory map */
> +				memcpy(next_md, md, memmap.desc_size);
> +				p1 += memmap.desc_size;
> +				next_md = p1;
> +				j++;
> +			}		
> +		}
> +		memmap.nr_map = j;
> +		memmap.map_end = memmap.map + (memmap.nr_map * memmap.desc_size);
> +                return;
>  	}
>  	for (i = 0; i < e820.nr_map; i++) {
>  		current_addr = e820.map[i].addr + e820.map[i].size;
> -

---
~Randy
