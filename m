Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424654AbWKPVah@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424654AbWKPVah (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 16:30:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424656AbWKPVah
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 16:30:37 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:24018 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1424654AbWKPVae (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 16:30:34 -0500
Date: Thu, 16 Nov 2006 13:30:33 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: "Myaskouvskey, Artiom" <artiom.myaskouvskey@intel.com>
Cc: davej@codemonkey.org.uk, hpa@zytor.com, linux-kernel@vger.kernel.org,
       shai.satt@intel.com
Subject: Re: [PATCH 2.6.19-rc5-git7] EFI: mapping memory region of runtime
 services when using memmap kernel parameter
Message-Id: <20061116133033.c4f60cc2.randy.dunlap@oracle.com>
In-Reply-To: <C1467C8B168BCF40ACEC2324C1A2B074A6A69F@hasmsx411.ger.corp.intel.com>
References: <C1467C8B168BCF40ACEC2324C1A2B074A6A69F@hasmsx411.ger.corp.intel.com>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Nov 2006 22:50:03 +0200 Myaskouvskey, Artiom wrote:

> From: Artiom Myaskouvskey <artiom.myaskouvskey@intel.com>
> 
>  
> 
> When using memmap kernel parameter in EFI boot we should also add to memory map 
> 
> memory regions of runtime services to enable their mapping later.
> 
>  
> 
> Signed-off-by: Artiom Myaskouvskey <artiom.myaskouvskey@intel.com>
> 
> ---

The patch does not apply cleanly due to extra blank lines
between each real/expected line.

More comments below.


> diff -uprN linux-2.6.19-rc5-git7.orig/include/linux/efi.h linux-2.6.19-rc5-git7/include/linux/efi.h
> 
> --- linux-2.6.19-rc5-git7.orig/include/linux/efi.h    2006-11-16 20:45:58.000000000 +0200
> 
> +++ linux-2.6.19-rc5-git7/include/linux/efi.h   2006-11-16 22:10:54.000000000 +0200
> 
> @@ -302,6 +302,7 @@ extern void efi_initialize_iomem_resourc
> 
>                               struct resource *data_resource);
> 
>  extern unsigned long __init efi_get_time(void);
> 
>  extern int __init efi_set_rtc_mmss(unsigned long nowtime);
> 
> +extern int is_available_memory(efi_memory_desc_t * md);
> 
>  extern struct efi_memory_map memmap;
> 
>  
> 
>  /**
> 
> diff -uprN linux-2.6.19-rc5-git7.orig/arch/i386/kernel/setup.c linux-2.6.19-rc5-git7/arch/i386/kernel/setup.c
> 
> --- linux-2.6.19-rc5-git7.orig/arch/i386/kernel/setup.c     2006-11-16 20:45:19.000000000 +0200
> 
> +++ linux-2.6.19-rc5-git7/arch/i386/kernel/setup.c    2006-11-16 22:05:01.000000000 +0200
> 
> @@ -349,25 +349,42 @@ static void __init probe_roms(void)
> 
>  static void __init limit_regions(unsigned long long size)
> 
>  {
> 
>       unsigned long long current_addr = 0;
> 
> -     int i;
> 
> +     int i , j;

	int i, j;

> 
>       if (efi_enabled) {
> 
> -           efi_memory_desc_t *md;
> 
> -           void *p;
> 
> +           efi_memory_desc_t *md, *next_md = 0;
> 
> +           void *p, *p1;
> 
>  
> 
> -           for (p = memmap.map, i = 0; p < memmap.map_end;
> 
> -                 p += memmap.desc_size, i++) {
> 
> +           for (p = memmap.map, i = 0,j = 0, p1 = memmap.map;

	space after comma, please.

> +                       p < memmap.map_end; p += memmap.desc_size, i++) {
> 
>                   md = p;
> 
> -                 current_addr = md->phys_addr + (md->num_pages << 12);
> 
> -                 if (md->type == EFI_CONVENTIONAL_MEMORY) {
> 
> +                 next_md = p1;
> 
> +                 current_addr = md->phys_addr + PFN_PHYS(md->num_pages);
> 
> +                 if (is_available_memory(md)) {
> 
> +                       if (md->phys_addr >= size) continue;

	Split to 2 lines:
			if (condition)
				continue;

> +                       memcpy(next_md, md, memmap.desc_size);
> 
>                         if (current_addr >= size) {
> 
> -                             md->num_pages -=
> 
> -                                   (((current_addr-size) + PAGE_SIZE-1) >> PAGE_SHIFT);
> 
> -                             memmap.nr_map = i + 1;
> 
> -                             return;
> 
> +                             next_md->num_pages -=
> 
> +                                   PFN_UP(current_addr-size);

					...(current_addr - size);
> 
>                         }
> 
> +                       p1 += memmap.desc_size;
> 
> +                       next_md = p1;
> 
> +                       j++;
> 
> +                 }
> 
> +                 else if ((md->attribute & EFI_MEMORY_RUNTIME) ==
> 
> +                             EFI_MEMORY_RUNTIME) {
> 
> +                       /* In order to make runtime services available
> 
> +                       * we have to include runtime
> 
> +                       * memory regions in memory map */
> 
> +                       memcpy(next_md, md, memmap.desc_size);
> 
> +                       p1 += memmap.desc_size;
> 
> +                       next_md = p1;
> 
> +                       j++;
> 
>                   }
> 
>             }
> 
> +           memmap.nr_map = j;
> 
> +           memmap.map_end = memmap.map + (memmap.nr_map * memmap.desc_size);
> 
> +           return;
> 
>       }
> 
>       for (i = 0; i < e820.nr_map; i++) {
> 
>             current_addr = e820.map[i].addr + e820.map[i].size;
> 
>  
> -

---
~Randy
