Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261476AbVGCR1H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261476AbVGCR1H (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Jul 2005 13:27:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261480AbVGCR1H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Jul 2005 13:27:07 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:23541 "EHLO
	godzilla.mvista.com") by vger.kernel.org with ESMTP id S261476AbVGCR1A
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Jul 2005 13:27:00 -0400
Date: Sun, 3 Jul 2005 10:26:50 -0700 (PDT)
From: Daniel Walker <dwalker@mvista.com>
To: Anton Blanchard <anton@samba.org>
cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] quieten OOM killer noise
In-Reply-To: <20050723150209.GA15055@krispykreme>
Message-ID: <Pine.LNX.4.10.10507031021410.5964-100000@godzilla.mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Why not just remove the printk's when DEBUG_KERNEL is off. The problem
that I've found is that the latency in the system sky rockets when OOM
triggers. It's due to the excessive printk usage. 

I'm sure it's not ifdef'ed for a reason , but it would be nice to have an
easy way to silence it.

Daniel

On Sun, 24 Jul 2005, Anton Blanchard wrote:

> 
> We now print statistics when invoking the OOM killer, however this
> information is not rate limited and you can get into situations where
> the console is continually spammed.
> 
> For example, when a task is exiting the OOM killer will simply return
> (waiting for that task to exit and clear up memory). If the VM
> continually calls back into the OOM killer we get thousands of copies of
> show_mem() on the console.
> 
> Use printk_ratelimit() to quieten it.
> 
> Signed-off-by: Anton Blanchard <anton@samba.org>
> 
> Index: foobar2/mm/oom_kill.c
> ===================================================================
> --- foobar2.orig/mm/oom_kill.c	2005-07-02 15:56:13.000000000 +1000
> +++ foobar2/mm/oom_kill.c	2005-07-04 01:38:59.474324542 +1000
> @@ -258,9 +258,11 @@
>  	struct mm_struct *mm = NULL;
>  	task_t * p;
>  
> -	printk("oom-killer: gfp_mask=0x%x\n", gfp_mask);
> -	/* print memory stats */
> -	show_mem();
> +	if (printk_ratelimit()) {
> +		printk("oom-killer: gfp_mask=0x%x\n", gfp_mask);
> +		/* print memory stats */
> +		show_mem();
> +	}
>  
>  	read_lock(&tasklist_lock);
>  retry:
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

