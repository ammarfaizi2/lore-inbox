Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312242AbSCRITg>; Mon, 18 Mar 2002 03:19:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312243AbSCRIT0>; Mon, 18 Mar 2002 03:19:26 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:10505 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S312242AbSCRITO>;
	Mon, 18 Mar 2002 03:19:14 -0500
Date: Mon, 18 Mar 2002 09:18:45 +0100
From: Jens Axboe <axboe@suse.de>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, marcelo@conectiva.com.br,
        alan@lxorguk.ukuu.org.uk, andrea@suse.de
Subject: Re: [PATCH] page_to_phys() fix for >4GB pages (i386)
Message-ID: <20020318081845.GF22756@suse.de>
In-Reply-To: <200203152257.g2FMv9h10896@eng2.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15 2002, Badari Pulavarty wrote:
> Hi,
> 
> I found that page_to_phys() is broken for pages > 4GB on x86.
> It is truncating the physical addresses to 32bit, loosing higher
> bits. (pci_map_sg() uses this).
> 
> Here is the patch to fix it. Marcelo, could you consider this
> patch ? I have not looked at 2.5 yet, it may be needed there also.
> 
> Thanks,
> Badari
> 
> 
> --- linux/include/asm-i386/io.h Fri Mar 15 11:19:28 2002
> +++ linux.new/include/asm-i386/io.h     Fri Mar 15 11:20:38 2002
> @@ -76,7 +76,11 @@
>  /*
>   * Change "struct page" to physical address.
>   */
> +#ifdef CONFIG_HIGHMEM64G
> +#define page_to_phys(page)     ((u64)(page - mem_map) << PAGE_SHIFT)
> +#else
>  #define page_to_phys(page)     ((page - mem_map) << PAGE_SHIFT)
> +#endif
> 
>  extern void * __ioremap(unsigned long offset, unsigned long size, unsigned long flags);

Ugh, this would indeed explain an unfixed problem with compaq arrays
corrupting data with > 4gb of ram. Thanks, good spotting!

-- 
Jens Axboe

