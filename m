Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261246AbSJ1O0K>; Mon, 28 Oct 2002 09:26:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261258AbSJ1O0K>; Mon, 28 Oct 2002 09:26:10 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:52237 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261246AbSJ1O0J>;
	Mon, 28 Oct 2002 09:26:09 -0500
Date: Mon, 28 Oct 2002 14:32:26 +0000
From: Matthew Wilcox <willy@debian.org>
To: "David S. Miller" <davem@redhat.com>
Cc: alan@lxorguk.ukuu.org.uk, rmk@arm.linux.org.uk, hugh@veritas.com,
       willy@debian.org, akpm@zip.com.au, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] shmem missing cache flush
Message-ID: <20021028143226.N27461@parcelfarce.linux.theplanet.co.uk>
References: <1035212657.27259.154.camel@irongate.swansea.linux.org.uk> <20021021.082107.56539790.davem@redhat.com> <1035216742.27318.189.camel@irongate.swansea.linux.org.uk> <20021028.061059.38206858.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021028.061059.38206858.davem@redhat.com>; from davem@redhat.com on Mon, Oct 28, 2002 at 06:10:59AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2002 at 06:10:59AM -0800, David S. Miller wrote:
> Here goes.  I contacted Anton and Paulus about flush_icache_page as
> that is on the hitlist next and ppc/ppc64 is the only well maintained
> port using that.

s/well maintained port/port that linus takes patches from regularly/

What do you want to do about flush_icache_page?  You want to change it
to flush_dcache_page at eviction time, and then we can purge that page
from our icache in update_mmu_cache?

> --- ./include/asm-parisc/pgalloc.h.~1~	Mon Oct 28 05:56:41 2002
> +++ ./include/asm-parisc/pgalloc.h	Mon Oct 28 06:00:13 2002
> @@ -72,7 +72,7 @@ flush_kernel_dcache_range(unsigned long 
>  	asm volatile("syncdma" : : );
>  }
>  
> -extern void __flush_page_to_ram(unsigned long address);
> +#error flush_page_to_ram is obsoleted, please convert to flush_dcache_page
>  
>  #define flush_cache_all()			flush_all_caches()
>  #define flush_cache_mm(foo)			flush_all_caches()
> @@ -99,9 +99,6 @@ extern inline void flush_cache_mm(struct
>                  __flush_dcache_range(vmaddr, PAGE_SIZE); \
>                  __flush_icache_range(vmaddr, PAGE_SIZE); \
>  } while(0)
> -
> -#define flush_page_to_ram(page)	\
> -        __flush_page_to_ram((unsigned long)page_address(page))
>  
>  #define flush_icache_range(start, end) \
>          __flush_icache_range(start, end - start)

You may as well drop this hunk from the diff; our current tree doesn't
even have these functions; just:

static inline void
flush_page_to_ram(struct page *page)
{
}

in asm/cacheflush.h

-- 
Revolutions do not require corporate support.
