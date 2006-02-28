Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932159AbWB1D0m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932159AbWB1D0m (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 22:26:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932162AbWB1D0m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 22:26:42 -0500
Received: from smtp.osdl.org ([65.172.181.4]:44978 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932159AbWB1D0m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 22:26:42 -0500
Date: Mon, 27 Feb 2006 19:25:32 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: pavel@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH -mm 2/2] mm: make shrink_all_memory try harder
Message-Id: <20060227192532.0a71e19b.akpm@osdl.org>
In-Reply-To: <200602271930.03171.rjw@sisk.pl>
References: <200602271926.20294.rjw@sisk.pl>
	<200602271930.03171.rjw@sisk.pl>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Rafael J. Wysocki" <rjw@sisk.pl> wrote:
>
> Make shrink_all_memory() repeat the attempts to free more memory if there
> seems to be no pages to free.
> 

This description doesn't describe what the problem is, not how the patch
fixes it.  So I'm kinda left guessing.

> ===================================================================
> --- linux-2.6.16-rc4-mm2.orig/mm/vmscan.c
> +++ linux-2.6.16-rc4-mm2/mm/vmscan.c
> @@ -33,6 +33,7 @@
>  #include <linux/cpuset.h>
>  #include <linux/notifier.h>
>  #include <linux/rwsem.h>
> +#include <linux/delay.h>
>  
>  #include <asm/tlbflush.h>
>  #include <asm/div64.h>
> @@ -1793,17 +1794,24 @@ unsigned long shrink_all_memory(unsigned
>  	struct reclaim_state reclaim_state = {
>  		.reclaimed_slab = 0,
>  	};
> +	int retry = 2;
>  
>  	current->reclaim_state = &reclaim_state;
> -	for_each_pgdat(pgdat) {
> -		unsigned long freed;
> +	do {
> +		for_each_pgdat(pgdat) {
> +			unsigned long freed;
>  
> -		freed = balance_pgdat(pgdat, nr_to_free, 0);
> -		ret += freed;
> -		nr_to_free -= freed;
> -		if (nr_to_free <= 0)
> +			freed = balance_pgdat(pgdat, nr_to_free, 0);
> +			ret += freed;
> +			nr_to_free -= freed;
> +			if (nr_to_free <= 0)
> +				break;
> +		}
> +		if (ret > 0)
>  			break;
> -	}
> +		if (retry)
> +			msleep_interruptible(100);

TASK_INTERRUPTIBLE sleeps won't do anything if someone has sent this
process a signal.    They should be used with caution.


Something like the below, I guess.  But it's hard to fix something when you
don't know what you're fixing.

swsusp should call drop_pagecache() and then drop_slab() before trying to
use shrink_all_memory(), btw.


diff -puN mm/vmscan.c~mm-make-shrink_all_memory-try-harder mm/vmscan.c
--- devel/mm/vmscan.c~mm-make-shrink_all_memory-try-harder	2006-02-27 19:17:29.000000000 -0800
+++ devel-akpm/mm/vmscan.c	2006-02-27 19:21:08.000000000 -0800
@@ -33,6 +33,7 @@
 #include <linux/cpuset.h>
 #include <linux/notifier.h>
 #include <linux/rwsem.h>
+#include <linux/delay.h>
 
 #include <asm/tlbflush.h>
 #include <asm/div64.h>
@@ -1783,11 +1784,13 @@ unsigned long shrink_all_memory(unsigned
 	pg_data_t *pgdat;
 	unsigned long nr_to_free = nr_pages;
 	unsigned long ret = 0;
+	unsigned retry = 2;
 	struct reclaim_state reclaim_state = {
 		.reclaimed_slab = 0,
 	};
 
 	current->reclaim_state = &reclaim_state;
+repeat:
 	for_each_pgdat(pgdat) {
 		unsigned long freed;
 
@@ -1797,6 +1800,10 @@ unsigned long shrink_all_memory(unsigned
 		if ((long)nr_to_free <= 0)
 			break;
 	}
+	if (retry-- && ret < nr_pages) {
+		blk_congestion_wait(WRITE, HZ/5);
+		goto repeat;
+	}
 	current->reclaim_state = NULL;
 	return ret;
 }
_

But then, the above could be implemented by the caller, so I don't know
what's going on..

