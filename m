Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964848AbWBDWlo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964848AbWBDWlo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 17:41:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964849AbWBDWlo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 17:41:44 -0500
Received: from smtp.osdl.org ([65.172.181.4]:57232 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964848AbWBDWlo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 17:41:44 -0500
Date: Sat, 4 Feb 2006 14:41:11 -0800
From: Andrew Morton <akpm@osdl.org>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: bcrl@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH, V2] i386: instead of poisoning .init zone, change
 protection bits to force a fault
Message-Id: <20060204144111.7e33569f.akpm@osdl.org>
In-Reply-To: <43DD2C15.1090800@cosmosbay.com>
References: <m1r76rft2t.fsf@ebiederm.dsl.xmission.com>
	<m17j8jfs03.fsf@ebiederm.dsl.xmission.com>
	<20060128235113.697e3a2c.akpm@osdl.org>
	<200601291620.28291.ioe-lkml@rameria.de>
	<20060129113312.73f31485.akpm@osdl.org>
	<43DD1FDC.4080302@cosmosbay.com>
	<20060129200504.GD28400@kvack.org>
	<43DD2C15.1090800@cosmosbay.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Dumazet <dada1@cosmosbay.com> wrote:
>
> 
> Chasing some invalid accesses to .init zone, I found that free_init_pages() 
> was properly freeing the pages but virtual was still usable.
> 
> A poisoning (memset(page, 0xcc, PAGE_SIZE)) was done but this is not reliable.
> 
> A new config option DEBUG_INITDATA is introduced to mark this initdata as not 
> present at all so that buggy code can trigger a fault.
> 
> This option is not meant for production machines because it may split one or 
> two huge page (2MB or 4MB) into small pages and thus slow down kernel a bit.
> 
> (After that we could map non possible cpu percpu data to the initial 
> percpudata that is included in .init and discarded in free_initmem())
> 
> ...
>
> --- a/arch/i386/mm/init.c	2006-01-25 10:17:24.000000000 +0100
> +++ b/arch/i386/mm/init.c	2006-01-29 22:38:53.000000000 +0100
> @@ -750,11 +750,18 @@
>  	for (addr = begin; addr < end; addr += PAGE_SIZE) {
>  		ClearPageReserved(virt_to_page(addr));
>  		set_page_count(virt_to_page(addr), 1);
> +#ifdef CONFIG_DEBUG_INITDATA
> +		change_page_attr(virt_to_page(addr), 1, __pgprot(0));
> +#else
>  		memset((void *)addr, 0xcc, PAGE_SIZE);
> +#endif
>  		free_page(addr);
>  		totalram_pages++;
>  	}
>  	printk(KERN_INFO "Freeing %s: %ldk freed\n", what, (end - begin) >> 10);
> +#ifdef CONFIG_DEBUG_INITDATA
> +	global_flush_tlb();
> +#endif
>  }
>  

This doesn't seem very pointful.

We unmap the page, then return it to the page allocator.  Then someone
reallocates the page, tries to use it and goes oops.

If CONFIG_DEBUG_PAGEALLOC is also set, the kernel will remap the page when
it's allocated and everything works OK.  So this patch requires
CONFIG_DEBUG_PAGEALLOC.

But if CONFIG_DEBUG_PAGEALLOC is set, we'll have unmapped that page in
free_page() _anyway_, so why bother using this patch?

The only enhancement I can think of here is to not free the page, so it's
permanently leaked and permanently unmapped.

--- devel/arch/i386/mm/init.c~i386-instead-of-poisoning-init-zone-change-protection-fix	2006-02-04 14:33:33.000000000 -0800
+++ devel-akpm/arch/i386/mm/init.c	2006-02-04 14:34:07.000000000 -0800
@@ -751,11 +751,15 @@ void free_init_pages(char *what, unsigne
 		ClearPageReserved(virt_to_page(addr));
 		set_page_count(virt_to_page(addr), 1);
 #ifdef CONFIG_DEBUG_INITDATA
+		/*
+		 * Unmap the page, and leak it.  So any further accesses will
+		 * oops.
+		 */
 		change_page_attr(virt_to_page(addr), 1, __pgprot(0));
 #else
 		memset((void *)addr, 0xcc, PAGE_SIZE);
-#endif
 		free_page(addr);
+#endif
 		totalram_pages++;
 	}
 	printk(KERN_INFO "Freeing %s: %ldk freed\n", what, (end - begin) >> 10);
_

But is there much point in doing this?  Does it offer much more than
CONFIG_DEBUG_PAGEALLOC?

