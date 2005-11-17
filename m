Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964872AbVKQVLa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964872AbVKQVLa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 16:11:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964874AbVKQVLa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 16:11:30 -0500
Received: from smtp.osdl.org ([65.172.181.4]:41139 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964872AbVKQVL3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 16:11:29 -0500
Date: Thu, 17 Nov 2005 13:11:20 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andy Whitcroft <apw@shadowen.org>
Cc: paulus@samba.org, anton@samba.org, linuxppc64-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, apw@shadowen.org
Subject: Re: [PATCH] ppc64 need HPAGE_SHIFT when huge pages disabled
Message-Id: <20051117131120.5a61b9ba.akpm@osdl.org>
In-Reply-To: <20051117170031.GA30223@shadowen.org>
References: <20051117170031.GA30223@shadowen.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Whitcroft <apw@shadowen.org> wrote:
>
> With the new powerpc architecture we don't seem to be able to disable
> huge pages anymore.
> 
>     mm/built-in.o(.toc1+0xae0): undefined reference to `HPAGE_SHIFT'
>     make: *** [.tmp_vmlinux1] Error 1
> 
> We seem to need to define HPAGE_SHIFT to something when HUGETLB_PAGE isn't
> defined.  This patch defines it to 0 when we have no support.
> 

Yes, i386 defines HPAGE_SHIFT always.

> 
> Signed-off-by: Andy Whitcroft <apw@shadowen.org>
> ---
> diff -upN reference/include/asm-powerpc/page_64.h current/include/asm-powerpc/page_64.h
> --- reference/include/asm-powerpc/page_64.h
> +++ current/include/asm-powerpc/page_64.h
> @@ -86,7 +86,11 @@ static inline void copy_page(void *to, v
>  extern u64 ppc64_pft_size;
>  
>  /* Large pages size */
> +#ifdef CONFIG_HUGETLB_PAGE
>  extern unsigned int HPAGE_SHIFT;
> +#else
> +#define HPAGE_SHIFT 0
> +#endif
>  #define HPAGE_SIZE		((1UL) << HPAGE_SHIFT)
>  #define HPAGE_MASK		(~(HPAGE_SIZE - 1))
>  #define HUGETLB_PAGE_ORDER	(HPAGE_SHIFT - PAGE_SHIFT)

I think this change will cause a compile warning in mm/memory.c:

			if (unlikely(is_vm_hugetlb_page(vma))) {
				unmap_hugepage_range(vma, start, end);
				zap_work -= (end - start) /
						(HPAGE_SIZE / PAGE_SIZE);

This code will be removed by the compiler.  But before that happens, we're
doing a divide by zero and the compiler will whine.

So I'd suggest that you set the !CONFIG_HUGETLB_PAGE value of HPAGE_SHIFT
to PAGE_SHIFT, not to zero.  I'll make that change locally..
