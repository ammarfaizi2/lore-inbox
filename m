Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261214AbTJCVa0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 17:30:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261223AbTJCVa0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 17:30:26 -0400
Received: from fw.osdl.org ([65.172.181.6]:12757 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261214AbTJCVaY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 17:30:24 -0400
Date: Fri, 3 Oct 2003 14:38:28 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise
To: Pavel Machek <pavel@ucw.cz>
cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [pm] fix oops after saving image
In-Reply-To: <20031002203906.GB7407@elf.ucw.cz>
Message-ID: <Pine.LNX.4.44.0310031433530.28816-100000@cherise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I do not want to waste 4K, does this look better?
> 									Pavel
> 
> --- tmp/linux/kernel/power/swsusp.c	2003-10-02 22:29:06.000000000 +0200
> +++ linux/kernel/power/swsusp.c	2003-10-02 22:27:07.000000000 +0200
> @@ -283,6 +283,9 @@
>  	unsigned long address;
>  	struct page *page;
>  
> +	if (!buffer)
> +		return -ENOMEM;
> +
>  	printk( "Writing data to swap (%d pages): ", nr_copy_pages );
>  	for (i=0; i<nr_copy_pages; i++) {
>  		if (!(i%100))

Argh! This bit was in the previous patch I applied. Please get it 
straight, or just keep adding to one patch and resending it (with an 
itemized list of changes). 

> @@ -345,7 +348,7 @@
>  	printk( "|\n" );
>  
>  	MDELAY(1000);
> -	free_page((unsigned long) buffer);
> +	/* No need to free anything, system is going down, anyway. */
>  	return 0;
>  }

It's technically still incorrect, since you'd still be leaking memory if
suspend failed. And, the comment is still in an unfortunate place.  
Something like this, before the function helps to provide understanding of 
the entire operation:


/**
 *	write_suspend_image - Write entire image to disk. 
 *
 * 	...
 *
 *	Note: The buffer we allocate to use to write the suspend header is 
 *	not freed because it otherwise causes a random Oops that I can't 
 *	find. This is a band-aid that probably only masks the problem, and 
 *	technically bad, since it means we leak memory unconditionally if 
 *	suspend fails. 
 */

static int write_suspend_image(void)
...



	Pat

