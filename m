Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261946AbULGVc1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261946AbULGVc1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 16:32:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261943AbULGVb3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 16:31:29 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:48273 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261940AbULGVat (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 16:30:49 -0500
Date: Tue, 7 Dec 2004 22:29:58 +0100
From: Jens Axboe <axboe@suse.de>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Katrina Tsipenyuk <ytsipenyuk@fortifysoftware.com>,
       katrina@fortifysoftware.com, Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH][1/2] fix unchecked returns from kmalloc() (in kernel/module.c)
Message-ID: <20041207212958.GD10083@suse.de>
References: <Pine.LNX.4.61.0412072203070.3320@dragon.hygekrogen.localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0412072203070.3320@dragon.hygekrogen.localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 07 2004, Jesper Juhl wrote:
> 
> Problem reported by Katrina Tsipenyuk and the Fortify Software engineering 
> team in thread with subject "PROBLEM: unchecked returns from kmalloc() in 
> linux-2.6.10-rc2".
> 
> The patch attempts to handle a failed kmalloc() a bit better than it 
> currently is. As I see it (and I'm not familliar with this code) there's 
> no really good way to cope with kmalloc failing on us here, so the best we 
> can do is print an error message and return a meaningful error value. As 
> the function is used with __initcall() I don't think much will actually 
> come of the negatve return, but returning -ENOMEM seems to me to be the 
> proper thing to do. Comments from someone who's actually familliar with 
> the code is very welcome.
> 
> Patch has been compile tested, boot tested, and didn't immediately blow 
> up my kernel, but that's all. Please review before applying.
> 
> Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
> 
> diff -up linux-2.6.10-rc3-bk2-orig/kernel/module.c linux-2.6.10-rc3-bk2/kernel/module.c
> --- linux-2.6.10-rc3-bk2-orig/kernel/module.c	2004-12-06 22:24:56.000000000 +0100
> +++ linux-2.6.10-rc3-bk2/kernel/module.c	2004-12-07 21:17:00.000000000 +0100
> @@ -334,6 +334,10 @@ static int percpu_modinit(void)
>  	pcpu_num_allocated = 2;
>  	pcpu_size = kmalloc(sizeof(pcpu_size[0]) * pcpu_num_allocated,
>  			    GFP_KERNEL);
> +	if (!pcpu_size) {
> +		printk(KERN_ERR "Unable to allocate per-cpu memory for modules.");
> +		return -ENOMEM;
> +	}

I'd say these cases are similar to SLAB_PANIC. Since it runs at boot, if
it fails it's likely an indication of some other problem, so dealing
with it here is silly. Perhaps just panic() on a NULL return.

Both of these fortify cases aren't real problems, imho. They trip a
stupid (no offense to the analyzer, but it's not human :) static
analyzer, that's all.

-- 
Jens Axboe

