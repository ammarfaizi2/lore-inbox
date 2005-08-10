Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965218AbVHJRPF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965218AbVHJRPF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 13:15:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965220AbVHJRPE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 13:15:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:16341 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965218AbVHJRPD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 13:15:03 -0400
Date: Wed, 10 Aug 2005 10:13:35 -0700
From: Andrew Morton <akpm@osdl.org>
To: David Howells <dhowells@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Boot failure with slab debugging patch
Message-Id: <20050810101335.61aaddab.akpm@osdl.org>
In-Reply-To: <15113.1123688409@warthog.cambridge.redhat.com>
References: <15113.1123688409@warthog.cambridge.redhat.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:
>
> This patch in 2.6.13-rc5-mm1:
> 
>  	slab-leak-detector-give-longer-traces.patch
> 
>  Causes the kernel to die with an oops on my test box during boot (see
>  attached), just about here, I think:
> 
>  	static void inline *
>  	cache_alloc_debugcheck_after(kmem_cache_t *cachep,
>  				unsigned int __nocast flags, void *objp, void *caller)
>  	{
>  		if (!objp)	
>  			return objp;
>  		if (cachep->flags & SLAB_POISON) {
>  	#ifdef CONFIG_DEBUG_PAGEALLOC
>  			if ((cachep->objsize % PAGE_SIZE) == 0 && OFF_SLAB(cachep))
>  				kernel_map_pages(virt_to_page(objp), cachep->objsize/PAGE_SIZE, 1);
>  			else
>  				check_poison_obj(cachep, objp);
>  	#else
>  			check_poison_obj(cachep, objp);
>  	#endif
>  			poison_obj(cachep, objp, POISON_INUSE);
>  		}
>  		if (cachep->flags & SLAB_STORE_USER) {
>  			*dbg_userword1(cachep, objp) = caller; /* address(0) */
>  			*dbg_userword2(cachep, objp) = __builtin_return_address(1);
>  --->			*dbg_userword3(cachep, objp) = __builtin_return_address(2);
>  		}
> 
> 
>  Shortly after the call instruction to dbg_userword3().
> 
>  Repealing that patch permits the kernel to work again.

Yup, sorry about that.  For some system calls the __builtin_return_address()
just walks off the top of the stack.
