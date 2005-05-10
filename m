Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261607AbVEJKzh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261607AbVEJKzh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 06:55:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261608AbVEJKzg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 06:55:36 -0400
Received: from cantor.suse.de ([195.135.220.2]:41915 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261607AbVEJKzN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 06:55:13 -0400
Date: Tue, 10 May 2005 12:55:06 +0200
From: Andi Kleen <ak@suse.de>
To: Jens Axboe <axboe@suse.de>
Cc: Andi Kleen <ak@suse.de>, "Rafael J. Wysocki" <rjw@sisk.pl>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [BUG][Resend] 2.6.12-rc3-mm3: Kernel BUG at "mm/slab.c":1219
Message-ID: <20050510105506.GF25612@wotan.suse.de>
References: <200505092239.37834.rjw@sisk.pl> <20050509205251.GK25167@wotan.suse.de> <20050510061858.GB21649@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050510061858.GB21649@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Some slab change, perhaps? There's nothing special about the init_bio()
> slab call:
> 
>         bio_slab = kmem_cache_create("bio", sizeof(struct bio), 0,
>                             SLAB_HWCACHE_ALIGN|SLAB_PANIC, NULL, NULL);
> 
> 
> Hmm, this looks strange. That bug happens if:
> 
>         if ((!name) ||
>                 in_interrupt() ||
>                 (size < BYTES_PER_WORD) ||
>                 (size > (1<<MAX_OBJ_ORDER)*PAGE_SIZE) ||
>                 (dtor && !ctor)) {
>                         printk(KERN_ERR "%s: Early error in slab %s\n",
>                                         __FUNCTION__, name);
>                         BUG();
>                 }
> 
> It must be in_interrupt() triggering, perhaps something change in the
> boot sequence?

I would add a printk for all arguments on top of kmem_cache_create
and decompose the big if () into smaller if (...) BUG() so that you
can see which condition triggers exactly.

Then if you suspect compiler issues you can edit the Makefile and
recompile the kernel with -O1

Rafael, can you try that perhaps?

-Andi
