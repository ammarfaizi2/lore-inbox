Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263970AbUDNIaz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 04:30:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263972AbUDNIaz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 04:30:55 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:10676 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263970AbUDNIaw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 04:30:52 -0400
Date: Wed, 14 Apr 2004 10:29:51 +0200
From: Jens Axboe <axboe@suse.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] conditionalize some boring buffer_head checks
Message-ID: <20040414082950.GD12558@suse.de>
References: <407CEB91.1080503@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <407CEB91.1080503@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14 2004, Jeff Garzik wrote:
> 
> These checks are executed billions of times per day, with no stack dump 
> bug reports sent to lkml.  Arguably, they will only trigger on buggy 
> filesystems (programmer error), and thus IMO shouldn't even be executed 
> in a non-debug kernel.
> 
> Even though BUG_ON() includes unlikely(), I think this patch -- or 
> something like it -- is preferable.  The buffer_error() checks aren't 
> even marked unlikely().
> 
> This is a micro-optimization on a key kernel fast path.

As Andrew mentioned, this isn't a fast path at all. You are potentially
even going to block on this call, and even if you don't you'll end up
spending a butt load of cycles in the io scheduler.

> ===== fs/buffer.c 1.237 vs edited =====
> --- 1.237/fs/buffer.c	Wed Apr 14 03:18:09 2004
> +++ edited/fs/buffer.c	Wed Apr 14 03:39:15 2004
> @@ -2688,6 +2688,7 @@
>  {
>  	struct bio *bio;
>  
> +#ifdef BH_DEBUG
>  	BUG_ON(!buffer_locked(bh));
>  	BUG_ON(!buffer_mapped(bh));
>  	BUG_ON(!bh->b_end_io);

The last one will be 'caught' at the other end of io completion, so I
guess that could be killed (even though you already lost the context of
the error, then). The first two are buffer state errors, I think those
should be kept unconditionally.

> @@ -2698,6 +2699,7 @@
>  		buffer_error();
>  	if (rw == READ && buffer_dirty(bh))
>  		buffer_error();
> +#endif

I'm fine with killing the buffer_error(), maybe

	if (rw == WRITE && !buffer_uptodate(bh))
		buffer_error();

should be kept though.

-- 
Jens Axboe

