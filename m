Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261158AbVCETDI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261158AbVCETDI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 14:03:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261156AbVCETDI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 14:03:08 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:31436 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261267AbVCESlK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 13:41:10 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: ncunningham@linuxmail.org
Subject: Re: BIOS overwritten during resume (was: Re: Asus L5D resume on battery power)
Date: Sat, 5 Mar 2005 19:43:25 +0100
User-Agent: KMail/1.7.1
Cc: Pavel Machek <pavel@suse.cz>, Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       paul.devriendt@amd.com
References: <200502252237.04110.rjw@sisk.pl> <20050304110408.GL1345@elf.ucw.cz> <1109946109.3772.267.camel@desktop.cunningham.myip.net.au>
In-Reply-To: <1109946109.3772.267.camel@desktop.cunningham.myip.net.au>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200503051943.25814.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Friday, 4 of March 2005 15:21, Nigel Cunningham wrote:
[-- snip --]
> 
> Will something like this patch help?
> 
[-- snip --]

I think that the changes below are unnecessary.  free_all_bootmem() is
actually called _before_ the loop in mem_init() in which PG_nosave is set for
the first time, so there's no need to clear it earlier.

> diff -ruNp 208-e820-table-support-old/mm/bootmem.c 208-e820-table-support-new/mm/bootmem.c
> --- 208-e820-table-support-old/mm/bootmem.c	2005-01-12 17:07:15.902387400 +1100
> +++ 208-e820-table-support-new/mm/bootmem.c	2005-01-12 17:23:44.087160480 +1100
> @@ -280,12 +280,14 @@ static unsigned long __init free_all_boo
>  
>  			count += BITS_PER_LONG;
>  			__ClearPageReserved(page);
> +			ClearPageNosave(page);
>  			order = ffs(BITS_PER_LONG) - 1;
>  			set_page_refs(page, order);
>  			for (j = 1; j < BITS_PER_LONG; j++) {
>  				if (j + 16 < BITS_PER_LONG)
>  					prefetchw(page + j + 16);
>  				__ClearPageReserved(page + j);
> +				ClearPageNosave(page + j);
>  			}
>  			__free_pages(page, order);
>  			i += BITS_PER_LONG;
> @@ -296,6 +298,7 @@ static unsigned long __init free_all_boo
>  				if (v & m) {
>  					count++;
>  					__ClearPageReserved(page);
> +					ClearPageNosave(page);
>  					set_page_refs(page, 0);
>  					__free_page(page);
>  				}
> @@ -316,6 +319,7 @@ static unsigned long __init free_all_boo
>  	for (i = 0; i < ((bdata->node_low_pfn-(bdata->node_boot_start >> PAGE_SHIFT))/8 + PAGE_SIZE-1)/PAGE_SIZE; i++,page++) {
>  		count++;
>  		__ClearPageReserved(page);
> +		ClearPageNosave(page);
>  		set_page_count(page, 1);
>  		__free_page(page);
>  	}

Greets,
Rafael
 

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
