Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263083AbUKZXyA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263083AbUKZXyA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 18:54:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263073AbUKZTlb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 14:41:31 -0500
Received: from zeus.kernel.org ([204.152.189.113]:4291 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262454AbUKZT1p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:27:45 -0500
Date: Thu, 25 Nov 2004 20:36:06 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Suspend 2 merge: 30/51: Enable slab alloc fallback to suspend memory pool
Message-ID: <20041125193606.GD1302@elf.ucw.cz>
References: <1101292194.5805.180.camel@desktop.cunninghams> <1101297401.5805.311.camel@desktop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1101297401.5805.311.camel@desktop.cunninghams>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> When we are preparing the image and have eaten all available memory, but
> before page allocations have been switched over to the memory pool, we
> sometimes need to allocate memory from slab for the image metadata (swap
> header information). This code allows the slab allocator to fall back to
> the memory pool in such circumstances. There is some extra debugging
> code there at the moment while I seek to diagnose intermittent slab
> corruption (not sure if it's suspend related).

More reasons to dislike two pagesets. Also you probably should not
printk() with two !!s in it (but without severity). Is it bug or not?


> diff -ruN 817-enable-slab-alloc-fallback-to-suspend-memory-pool-old/mm/slab.c 817-enable-slab-alloc-fallback-to-suspend-memory-pool-new/mm/slab.c
> --- 817-enable-slab-alloc-fallback-to-suspend-memory-pool-old/mm/slab.c	2004-11-24 15:48:55.066733152 +1100
> +++ 817-enable-slab-alloc-fallback-to-suspend-memory-pool-new/mm/slab.c	2004-11-23 07:11:42.000000000 +1100
> @@ -874,14 +874,30 @@
>  	flags |= cachep->gfpflags;
>  	if (likely(nodeid == -1)) {
>  		addr = (void*)__get_free_pages(flags, cachep->gfporder);
> +		if (unlikely((!addr) && (current->pid == suspend_task) &&
> +		    test_suspend_state(SUSPEND_SLAB_ALLOC_FALLBACK))) {
> +			addr = (void *) suspend2_get_grabbed_pages(0);
> +			printk("!! Slab addition satisfied via fallback code.\n");
> +		}
>  		if (!addr)
>  			return NULL;
> +		if (unlikely(test_suspend_state(SUSPEND_RUNNING)))
> +			printk("Order %d allocation %p added to slab %p.\n",
> +				cachep->gfporder, addr, cachep);
>  		page = virt_to_page(addr);
>  	} else {

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
