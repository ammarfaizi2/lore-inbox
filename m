Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262416AbUCWJzN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 04:55:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262422AbUCWJzN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 04:55:13 -0500
Received: from lindsey.linux-systeme.com ([62.241.33.80]:48651 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S262416AbUCWJzC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 04:55:02 -0500
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: Andrea Arcangeli <andrea@suse.de>
Subject: Re: do we want to kill VM_RESERVED or not? [was Re: 2.6.5-rc1-aa3]
Date: Tue, 23 Mar 2004 10:54:38 +0100
User-Agent: KMail/1.6.1
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
References: <20040320210306.GA11680@dualathlon.random> <200403221310.38481@WOLK> <20040322124257.GT3649@dualathlon.random>
In-Reply-To: <20040322124257.GT3649@dualathlon.random>
X-Operating-System: Linux 2.6.4-wolk2.1 i686 GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200403231054.38582@WOLK>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 22 March 2004 13:42, Andrea Arcangeli wrote:

Hi Andrea,

> I see, the below patch will avoid your oops (I also removed the stack
> trace dump from memory.c since it's useless to get the stack trace from
> there and this will reduce the noise).
> --- x/mm/memory.c.~1~	2004-03-21 15:21:42.000000000 +0100
> +++ x/mm/memory.c	2004-03-22 13:40:26.852849384 +0100
> @@ -324,9 +324,11 @@ skip_copy_pte_range:
>  					 * Device driver pages must not be
>  					 * tracked by the VM for unmapping.
>  					 */
> -					BUG_ON(!page_mapped(page));
> -					BUG_ON(!page->mapping);
> -					page_add_rmap(page, vma, address, PageAnon(page));
> +					if (likely(page_mapped(page) && page->mapping))
> +						page_add_rmap(page, vma, address, PageAnon(page));
> +					else
> +						printk("Badness in %s at %s:%d\n",
> +						       __FUNCTION__, __FILE__, __LINE__);
>  				} else {
>  					BUG_ON(page_mapped(page));
>  					BUG_ON(page->mapping);
> @@ -1429,7 +1431,9 @@ retry:
>  	 * real anonymous pages, they're "device" reserved pages instead.
>  	 */
>  	reserved = !!(vma->vm_flags & VM_RESERVED);
> -	WARN_ON(reserved == pageable);
> +	if (unlikely(reserved == pageable))
> +		printk("Badness in %s at %s:%d\n",
> +		       __FUNCTION__, __FILE__, __LINE__);
>
>  	/*
>  	 * Should we do an early C-O-W break?

Perfect. Thanks alot.


> many thanks for the help!

You're welcome. Thanks for your help!

ciao, Marc
