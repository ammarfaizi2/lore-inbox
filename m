Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265396AbUFCARr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265396AbUFCARr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 20:17:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265418AbUFCARr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 20:17:47 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:46015 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265407AbUFCARd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 20:17:33 -0400
Message-ID: <40BE6E0A.9050403@pobox.com>
Date: Wed, 02 Jun 2004 20:17:14 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: Ingo Molnar <mingo@elte.hu>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       Linus Torvalds <torvalds@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>
Subject: Re: [announce] [patch] NX (No eXecute) support for x86,	2.6.7-rc2-bk2
References: <20040602205025.GA21555@elte.hu> <1086221461.29390.327.camel@bach>
In-Reply-To: <1086221461.29390.327.camel@bach>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
> On Thu, 2004-06-03 at 06:50, Ingo Molnar wrote:
> 
>>furthermore, the patch also implements 'NX protection' for kernelspace
>>code: only the kernel code and modules are executable - so even
> 
> 
> No, actually, it doesn't quite do that:
> 
> --- linux/kernel/module.c.orig	
> +++ linux/kernel/module.c	
> @@ -1431,7 +1431,7 @@ static struct module *load_module(void _
>  
>  	/* Suck in entire file: we'll want most of it. */
>  	/* vmalloc barfs on "unusual" numbers.  Check here */
> -	if (len > 64 * 1024 * 1024 || (hdr = vmalloc(len)) == NULL)
> +	if (len > 64 * 1024 * 1024 || (hdr = vmalloc_exec(len)) == NULL)
>  		return ERR_PTR(-ENOMEM);
>  	if (copy_from_user(hdr, umod, len) != 0) {
>  		err = -EFAULT;
> 
> This is where we such the module file into kernel memory to parse it,
> not where we actually copy the memory.
> 
> You want to replace the arch-specific module_alloc() function for this.
> Or even better, reset the NX bit only on executable sections (in the
> arch-specific module_finalize(), using mod->core_text_size and
> mod->init_text_size).  No generic changes necessary.
> 
> What surprises me is that this error didn't cause your kernel to explode
> the moment you inserted a module containing a function...


bah, modules are for lame people who don't want to squeeze that last 
%0.00001 of additional performance out of their kernel by reducing TLB 
and I-cache misses...

	Jeff


