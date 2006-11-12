Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752636AbWKLSq7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752636AbWKLSq7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Nov 2006 13:46:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752638AbWKLSq7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Nov 2006 13:46:59 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:5867 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1752636AbWKLSq6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Nov 2006 13:46:58 -0500
Date: Sun, 12 Nov 2006 10:46:55 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: "Myaskouvskey, Artiom" <artiom.myaskouvskey@intel.com>
Cc: <davej@codemonkey.org.uk>, <hpa@zytor.com>, <linux-kernel@vger.kernel.org>,
       "Narayanan, Chandramouli" <chandramouli.narayanan@intel.com>,
       "Jiossy, Rami" <rami.jiossy@intel.com>,
       "Satt, Shai" <shai.satt@intel.com>
Subject: Re: [PATCH 2.6.18.2] EFI: mapping memory region of runtime services
 when using memmap kernel parameter
Message-Id: <20061112104655.d934317b.randy.dunlap@oracle.com>
In-Reply-To: <C1467C8B168BCF40ACEC2324C1A2B074016C5DE9@hasmsx411.ger.corp.intel.com>
References: <C1467C8B168BCF40ACEC2324C1A2B074016C5DE9@hasmsx411.ger.corp.intel.com>
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

On Sun, 12 Nov 2006 17:45:26 +0200 Myaskouvskey, Artiom wrote:

> 
> From: Artiom Myaskouvskey <artiom.myaskouvskey@intel.com>
>  
> When using memmap kernel parameter in EFI boot we should also map memory
> regions of runtime services to enable their mapping later.
> 
> Signed-off-by: Artiom Myaskouvskey <artiom.myaskouvskey@intel.com>
> ---

Hi,

It's not clear to me why you are sending a patch to 2.6.18.2.
If this should be applied to current mainline, then the patch
should be made against current source tree.  OTOH, if the patch
is meant to be made to the stable tree, you need to cc: stable@kernel.org .


> diff -uprN linux-2.6.18.2.orig/arch/i386/kernel/setup.c
> linux-2.6.18.2/arch/i386/kernel/setup.c
> --- linux-2.6.18.2.orig/arch/i386/kernel/setup.c	2006-11-12
> 11:22:22.000000000 +0200
> +++ linux-2.6.18.2/arch/i386/kernel/setup.c	2006-11-12
> 16:31:32.000000000 +0200
> @@ -364,28 +364,44 @@ static void __init probe_roms(void)
>  	}
>  }
>  
> +extern int is_available_memory(efi_memory_desc_t * md);
> +

Externs should be in header files.  Please do that and also fix
this one:
./arch/i386/mm/init.c:195:extern int is_available_memory(efi_memory_desc_t *);

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
> +		for (p = memmap.map, i = 0,j = 0, p1 = memmap.map; p <
> memmap.map_end;

patch: **** malformed patch at line 37: memmap.map_end;

(it seems that the line was split by your mail client or server)
The line is also too long (> 80 characters).

>  			p += memmap.desc_size, i++) {
>  			md = p;
> +			next_md = p1;
>  			current_addr = md->phys_addr + (md->num_pages <<
> 12);

patch: **** malformed patch at line 41: 12);
(split by mail client or server)

> -			if (md->type == EFI_CONVENTIONAL_MEMORY) {
> -				if (current_addr >= size) {
> -					md->num_pages -=
> -						(((current_addr-size) +
> PAGE_SIZE-1) >> PAGE_SHIFT);

patch: **** malformed patch at line 45: PAGE_SIZE-1) >> PAGE_SHIFT);
(line was split again)

> -					memmap.nr_map = i + 1;
> -					return;
> +			if (is_available_memory(md)) {
> +				if (md->phys_addr >= size) continue;
> +				memcpy(next_md, md, memmap.desc_size);
> 
> +                                if (current_addr >= size) {
> +					next_md->num_pages -=
> (((current_addr-size) + PAGE_SIZE-1) >> PAGE_SHIFT);

patch: **** malformed patch at line 53: (((current_addr-size) + PAGE_SIZE-1) >> PAGE_SHIFT);

ditto

>  				}
> +				p1 += memmap.desc_size;
> +				next_md = p1;
> +				j++;
>  			}
> -		}
> +			else if ((md->attribute & EFI_MEMORY_RUNTIME) ==
> EFI_MEMORY_RUNTIME) {

patch: **** malformed patch at line 60: EFI_MEMORY_RUNTIME) {
ditto

> +				/* In order to make runtime services
> available we have to include runtime 

patch: **** malformed patch at line 61: available we have to include runtime

Please observer 80-column limit.
Also the line above ends with whitespace.  Please chop that off.
Also, your mailer has split that long line so that the patch is
malformed -- does not apply.

> +				 * memory regions in memory map */
> +				memcpy(next_md, md, memmap.desc_size);
> +				p1 += memmap.desc_size;
> +				next_md = p1;
> +				j++;
> +			}		
> +		}
> +		memmap.nr_map = j;
> +		memmap.map_end = memmap.map + (memmap.nr_map *
> memmap.desc_size);

patch: **** malformed patch at line 70: memmap.desc_size);
ditto

> +                return;
>  	}
>  	for (i = 0; i < e820.nr_map; i++) {
>  		current_addr = e820.map[i].addr + e820.map[i].size;
> -

---
~Randy
