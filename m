Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263818AbUECSJV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263818AbUECSJV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 14:09:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263827AbUECSJV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 14:09:21 -0400
Received: from fw.osdl.org ([65.172.181.6]:11230 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263818AbUECSJP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 14:09:15 -0400
Date: Mon, 3 May 2004 11:08:54 -0700
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: alexeyk@mysql.com, linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: Random file I/O regressions in 2.6
Message-Id: <20040503110854.5abcdc7e.akpm@osdl.org>
In-Reply-To: <409629A5.8070201@yahoo.com.au>
References: <200405022357.59415.alexeyk@mysql.com>
	<409629A5.8070201@yahoo.com.au>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <nickpiggin@yahoo.com.au> wrote:
>
> What ends up happening is that readahead gets turned off, then the
> 16K read ends up being done in 4 synchronous 4K chunks. Because they
> are synchronous, they have no chance of being merged with one another
> either.

yup.

> I have attached a proof of concept hack... I think what should really
> happen is that page_cache_readahead should be taught about the size
> of the requested read, and ensures that a decent amount of reading is
> done while within the read request window, even if
> beyond-request-window-readahead has been previously unsuccessful.

The "readahead turned itself off" thing is there to avoid doing lots of
pagecache lookups in the very common case where the file is fully cached.

The place which needs attention is handle_ra_miss().  But first I'd like to
reacquaint myself with the intent behind the lazy-readahead patch.  Was
never happy with the complexity and special-cases which that introduced.

>  		cond_resched();
> -		page_cache_readahead(mapping, ra, filp, index);
> +		page_cache_readahead(mapping, ra, filp, index + desc->count);
>  

`index' is a pagecache index and desc->count is a byte counter.
