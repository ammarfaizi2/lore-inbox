Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263241AbVCJVm1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263241AbVCJVm1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 16:42:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263252AbVCJVmS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 16:42:18 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:57806 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S263224AbVCJViX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 16:38:23 -0500
Subject: Re: [PATCH] add a clear_pages function to clear pages of higher
	order
From: Dave Hansen <haveblue@us.ibm.com>
To: Christoph Lameter <clameter@sgi.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Mel Gorman <mel@csn.ul.ie>
In-Reply-To: <Pine.LNX.4.58.0503101229420.13911@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0503101229420.13911@schroedinger.engr.sgi.com>
Content-Type: text/plain
Date: Thu, 10 Mar 2005 13:38:03 -0800
Message-Id: <1110490683.24355.17.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-03-10 at 12:35 -0800, Christoph Lameter wrote:
> +#ifdef __HAVE_ARCH_CLEAR_PAGES
> +	if (!PageHighMem(page)) {
> +		clear_pages(page_address(page), order);
> +		return;
> +	}
> +#endif
> +
>  	for(i = 0; i < (1 << order); i++)
>  		clear_highpage(page + i);
>  }
...
> --- linux-2.6.11.orig/include/asm-ia64/page.h	2005-03-01 23:37:48.000000000 -0800
> +++ linux-2.6.11/include/asm-ia64/page.h	2005-03-10 10:57:10.000000000 -0800
> @@ -56,8 +56,10 @@
>  # ifdef __KERNEL__
>  #  define STRICT_MM_TYPECHECKS
> 
> -extern void clear_page (void *page);
> +extern void clear_pages (void *page, int order);
>  extern void copy_page (void *to, void *from);
> +#define clear_page(__page) clear_pages(__page, 0)
> +#define __HAVE_ARCH_CLEAR_PAGES

Although this is a simple instance, could this please be done in a
Kconfig file?  If that #define happens inside of other #ifdefs, it can
be quite hard to decipher the special .config incantation to get it set.
On the other hand, if the dependencies are spelled out in a Kconfig
entry...

BTW, I tried applying this to 2.6.11-bk6, and it rejected:
...
patching file include/asm-i386/page.h
Hunk #2 FAILED at 28.
1 out of 2 hunks FAILED -- saving rejects to file
include/asm-i386/page.h.rej
...

There were some more rejects as well.  Were there some other patches
applied first?

-- Dave

