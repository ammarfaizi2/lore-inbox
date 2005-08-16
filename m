Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965120AbVHPFvr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965120AbVHPFvr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 01:51:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965122AbVHPFvr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 01:51:47 -0400
Received: from smtp.osdl.org ([65.172.181.4]:25028 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965120AbVHPFvq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 01:51:46 -0400
Date: Mon, 15 Aug 2005 22:51:42 -0700
From: Chris Wright <chrisw@osdl.org>
To: zach@vmware.com
Cc: akpm@osdl.org, chrisl@vmware.com, chrisw@osdl.org,
       linux-kernel@vger.kernel.org, mbligh@mbligh.org, pratap@vmware.com,
       virtualization@lists.osdl.org
Subject: Re: [PATCH 5/6] i386 virtualization - Make generic set wrprotect a macro
Message-ID: <20050816055142.GX7762@shell0.pdx.osdl.net>
References: <200508152300.j7FN0dD7005336@zach-dev.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508152300.j7FN0dD7005336@zach-dev.vmware.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* zach@vmware.com (zach@vmware.com) wrote:
> Make the generic version of ptep_set_wrprotect a macro.  This is good for
> code uniformity, and fixes the build for architectures which include pgtable.h
> through headers into assembly code, but do not define a ptep_set_wrprotect
> function.

This one is unrelated to other descriptor related changes.  Why is it
included in this series?

> Signed-off-by: Zachary Amsden <zach@vmware.com>
> Index: linux-2.6.13/include/asm-generic/pgtable.h
> ===================================================================
> --- linux-2.6.13.orig/include/asm-generic/pgtable.h	2005-08-12 12:12:55.000000000 -0700
> +++ linux-2.6.13/include/asm-generic/pgtable.h	2005-08-15 13:54:42.000000000 -0700
> @@ -313,11 +313,12 @@
>  #endif
>  
>  #ifndef __HAVE_ARCH_PTEP_SET_WRPROTECT
> -static inline void ptep_set_wrprotect(struct mm_struct *mm, unsigned long address, pte_t *ptep)
> -{
> -	pte_t old_pte = *ptep;
> -	set_pte_at(mm, address, ptep, pte_wrprotect(old_pte));
> -}
> +#define ptep_set_wrprotect(__mm, __address, __ptep)			\
> +({									\
> +	pte_t __old_pte = *(__ptep);					\
> +	set_pte_at((__mm), (__address), (__ptep),			\
> +			pte_wrprotect(__old_pte));			\
> +})
>  #endif

I'm not sure I agree with this approach (although I understand the
motivation).  This should at least be a do {} while(0) type macro,
since it's not returning a value.

thanks,
-chris
