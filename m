Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261206AbVALQDz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261206AbVALQDz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 11:03:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261229AbVALQDz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 11:03:55 -0500
Received: from fw.osdl.org ([65.172.181.6]:30381 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261206AbVALQDt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 11:03:49 -0500
Date: Wed, 12 Jan 2005 08:03:44 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] do_brk() needs mmap_sem write-locked
In-Reply-To: <20050112002117.GA27653@logos.cnet>
Message-ID: <Pine.LNX.4.58.0501120800500.2373@ppc970.osdl.org>
References: <20050112002117.GA27653@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Looks good, except for a small nit:

On Tue, 11 Jan 2005, Marcelo Tosatti wrote:
> diff -Nur linux-2.6-curr.orig/mm/mmap.c linux-2.6-curr/mm/mmap.c
> --- linux-2.6-curr.orig/mm/mmap.c	2005-01-11 22:48:49.000000000 -0200
> +++ linux-2.6-curr/mm/mmap.c	2005-01-11 23:43:10.704800272 -0200
> @@ -1891,6 +1891,12 @@
>  	}
>  
>  	/*
> +	 * mm->mmap_sem is required to protect against another thread
> +	 * changing the mappings in case we sleep.
> +	 */
> +	WARN_ON(down_read_trylock(&mm->mmap_sem));
> +
> +	/*
>  	 * Clear old maps.  this also does some error checking for us
>  	 */
>   munmap_back:
> 

if that warning ever triggers, mmap_sem will now be locked, and that will 
cause problems. So I suspect it's better to do

	if (down_read_trylock(&mm->mmap_sem)) {
		WARN_ON(1);
		up_read(&mm->mmap_sem);
	}

and move that into a helper function of its own (something like
"verify_mmap_write_lock_held()").

		Linus
