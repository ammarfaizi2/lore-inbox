Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030249AbVHPRGY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030249AbVHPRGY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 13:06:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030248AbVHPRGX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 13:06:23 -0400
Received: from siaag2ai.mx.compuserve.com ([149.174.40.147]:33705 "EHLO
	siaag2ai.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1030249AbVHPRGX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 13:06:23 -0400
Date: Tue, 16 Aug 2005 13:03:44 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [PATCH 3/6] i386 virtualization - Make ldt a desc struct
To: Zachary Amsden <zach@vmware.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200508161306_MC3-1-A75D-6646@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Aug 2005 at 15:59:39 -0700, zach@vmware.com wrote:

> --- linux-2.6.13.orig/include/asm-i386/mmu_context.h  2005-08-15 11:16:59.000000000 -0700
> +++ linux-2.6.13/include/asm-i386/mmu_context.h       2005-08-15 11:19:49.000000000 -0700
> @@ -19,7 +19,7 @@
>       memset(&mm->context, 0, sizeof(mm->context));
>       init_MUTEX(&mm->context.sem);
>       old_mm = current->mm;
> -     if (old_mm && unlikely(old_mm->context.size > 0)) {
> +     if (old_mm && unlikely(old_mm->context.ldt)) {  <==================
>               retval = copy_ldt(&mm->context, &old_mm->context);
>       }
>       if (retval == 0)
> @@ -32,7 +32,7 @@
>   */
>  static inline void destroy_context(struct mm_struct *mm)
>  {
> -     if (unlikely(mm->context.size))
> +     if (unlikely(mm->context.ldt))    <==================
>               destroy_ldt(mm);
>       del_lazy_mm(mm);
>  }

  Here you changed the code so it no longer tests the size field, however:

> --- linux-2.6.13.orig/arch/i386/kernel/ldt.c  2005-08-15 11:16:59.000000000 -0700
> +++ linux-2.6.13/arch/i386/kernel/ldt.c       2005-08-15 11:19:49.000000000 -0700
<--SNIP-->
> @@ -97,14 +96,16 @@
>  
>  void destroy_ldt(struct mm_struct *mm)
>  {
> +     int pages = mm->context.ldt_pages;
> +
>       if (mm == current->active_mm)
>               clear_LDT();
> -     ClearPagesLDT(mm->context.ldt, (mm->context.size * LDT_ENTRY_SIZE) / PAGE_SIZE);
> -     if (mm->context.size*LDT_ENTRY_SIZE > PAGE_SIZE)
> +     ClearPagesLDT(mm->context.ldt, pages);
> +     if (pages > 1)
>               vfree(mm->context.ldt);
>       else
>               kfree(mm->context.ldt);
> -     mm->context.size = 0;
> +     mm->context.ldt_pages = 0;   <====================
>  }
>  
>  static int read_ldt(void __user * ptr, unsigned long bytecount)

  destroy_ldt does not zero "ldt", just the size.  Potential bug?

  Also:

> --- linux-2.6.13.orig/arch/i386/kernel/ldt.c  2005-08-15 11:16:59.000000000 -0700
> +++ linux-2.6.13/arch/i386/kernel/ldt.c       2005-08-15 11:19:49.000000000 -0700
> @@ -28,28 +28,27 @@
>  }
>  #endif
>  
> -static inline int alloc_ldt(mm_context_t *pc, const int oldsize, int mincount, const int reload)
> +static inline int alloc_ldt(mm_context_t *pc, const int old_pages, int new_pages, const int reload)
>  {
> -     void *oldldt;
> -     void *newldt;
> +     struct desc_struct *oldldt;
> +     struct desc_struct *newldt;

  Can't this be declared on one line?


  ...and BTW could you add:

        QUILT_DIFF_OPTS=-p

to your shell env?  It makes the patches much easier to review.

__
Chuck
