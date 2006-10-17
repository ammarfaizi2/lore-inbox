Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932177AbWJQHMg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932177AbWJQHMg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 03:12:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932179AbWJQHMg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 03:12:36 -0400
Received: from fc-cn.com ([218.25.172.144]:13582 "HELO mail.fc-cn.com")
	by vger.kernel.org with SMTP id S932176AbWJQHMe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 03:12:34 -0400
Message-ID: <4534865E.7020504@fc-cn.com>
Date: Tue, 17 Oct 2006 15:29:34 +0800
From: Qi Yong <qiyong@fc-cn.com>
Organization: FCD
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060620 Debian/1.7.13-0.2
X-Accept-Language: en
MIME-Version: 1.0
To: Dave Hansen <haveblue@us.ibm.com>
CC: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: [RFC][PATCH 3/9] actual generic PAGE_SIZE infrastructure
References: <20060830221604.E7320C0F@localhost.localdomain> <20060830221606.40937644@localhost.localdomain>
In-Reply-To: <20060830221606.40937644@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen wrote:

>* Add _ALIGN_UP() which we'll use now and _ALIGN_DOWN(), just for
>  parity.
>* Define ASM_CONST() macro to help using constants in both assembly
>  and C code.  Several architectures have some form of this, and
>  they will be consolidated around this one.
>* Actually create PAGE_SHIFT and PAGE_SIZE macros
>* For now, require that architectures enable GENERIC_PAGE_SIZE in
>  order to get this new code.  This option will be removed by the
>  last patch in the series, and makes the series bisect-safe.
>* Note that this moves the compiler.h define outside of the
>  #ifdef __KERNEL__, but that's OK because it has its own.
>
>Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
>---
>
> threadalloc-dave/include/asm-generic/page.h |   31 ++++++++++++++++++--
> threadalloc-dave/mm/Kconfig                 |   43 ++++++++++++++++++++++++++++
> 2 files changed, 71 insertions(+), 3 deletions(-)
>
>diff -puN include/asm-generic/page.h~generic-PAGE_SIZE-infrastructure include/asm-generic/page.h
>--- threadalloc/include/asm-generic/page.h~generic-PAGE_SIZE-infrastructure	2006-08-30 15:15:00.000000000 -0700
>+++ threadalloc-dave/include/asm-generic/page.h	2006-08-30 15:15:01.000000000 -0700
>@@ -1,11 +1,36 @@
> #ifndef _ASM_GENERIC_PAGE_H
> #define _ASM_GENERIC_PAGE_H
> 
>+#include <linux/compiler.h>
>+#include <linux/align.h>
>+
> #ifdef __KERNEL__
>-#ifndef __ASSEMBLY__
> 
>-#include <linux/compiler.h>
>+#ifdef __ASSEMBLY__
>+#define ASM_CONST(x) x
>+#else
>+#define __ASM_CONST(x) x##UL
>+#define ASM_CONST(x) __ASM_CONST(x)
>+#endif
>+
>+#ifdef CONFIG_ARCH_GENERIC_PAGE_SIZE
>+
>+#define PAGE_SHIFT      CONFIG_PAGE_SHIFT
>+#define PAGE_SIZE       (ASM_CONST(1) << PAGE_SHIFT)
>  
>

Your generic page.h hides PAGE_SIZE under "#ifdef __KERNEL__".
That would cause severe userland compile failures.

Most archs have PAGE_SIZE visible to userland.
Please keep PAGE_SIZE and its friends outside "#ifdef __KERNEL__".


-- qiyong

>+
>+/*
>+ * Subtle: (1 << PAGE_SHIFT) is an int, not an unsigned long. So if we
>+ * assign PAGE_MASK to a larger type it gets extended the way we want
>+ * (i.e. with 1s in the high bits)
>+ */
>+#define PAGE_MASK      (~((1 << PAGE_SHIFT) - 1))
> 
>+/* to align the pointer to the (next) page boundary */
>+#define PAGE_ALIGN(addr)        ALIGN(addr, PAGE_SIZE)
>+
>+#endif /* CONFIG_ARCH_GENERIC_PAGE_SIZE */
>+
>+#ifndef __ASSEMBLY__
> #ifndef CONFIG_ARCH_HAVE_GET_ORDER
> /* Pure 2^n version of get_order */
> static __inline__ __attribute_const__ int get_order(unsigned long size)
>@@ -22,7 +47,7 @@ static __inline__ __attribute_const__ in
> }
> 
> #endif	/* CONFIG_ARCH_HAVE_GET_ORDER */
>-#endif /*  __ASSEMBLY__ */
>+#endif  /* __ASSEMBLY__ */
> #endif	/* __KERNEL__ */
> 
> #endif	/* _ASM_GENERIC_PAGE_H */
>  
>
-- 
Qi Yong

