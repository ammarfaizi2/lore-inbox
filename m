Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262352AbTJNM6G (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 08:58:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262353AbTJNM6F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 08:58:05 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:1690 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262352AbTJNM6A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 08:58:00 -0400
Date: Tue, 14 Oct 2003 14:57:23 +0200
From: Jens Axboe <axboe@suse.de>
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ide barrier support, #2
Message-ID: <20031014125723.GR1107@suse.de>
References: <GurO.7cg.43@gated-at.bofh.it> <m3zng4ou90.fsf@averell.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3zng4ou90.fsf@averell.firstfloor.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 14 2003, Andi Kleen wrote:
> Jens Axboe <axboe@suse.de> writes:
> 
> This adds support for XFS for log writes (not for fsync).
> Based on the 2.4 XFS patch for write barriers I did some time ago.
> 
> It just does a flush, not a barrier. I think that's enough for
> log writes because XFS waits until the log write has hit disk.
> 
> It doesn't do anything special when the flush fails - just
> shuts down the file system as usual. 
> 
> diff -u linux/fs/xfs/pagebuf/page_buf.c-o linux-2.6.0test6-work/fs/xfs/pagebuf/page_buf.c
> --- linux/fs/xfs/pagebuf/page_buf.c-o	2003-09-28 10:52:55.000000000 +0200
> +++ linux/fs/xfs/pagebuf/page_buf.c	2003-10-14 14:48:44.000000000 +0200
> @@ -1403,12 +1403,12 @@
>  
>  submit_io:
>  	if (likely(bio->bi_size)) {
> -		if (pb->pb_flags & PBF_READ) {
> -			submit_bio(READ, bio);
> -		} else {
> -			submit_bio(WRITE, bio);
> -		}
> -
> +		int cmd = WRITE; 
> +		if (pb->pb_flags & PBF_READ)
> +			cmd = READ;
> +		else if (pb->pb_flags & PBF_FLUSH)
> +			cmd = WRITESYNC;

Uh be careful! It must be WRITEBARRIER, not WRITESYNC. I think I'll kill
WRITEBARRIER and just call it WRITESYNC, it's more logical. I've added
the modified variant, thanks.

-- 
Jens Axboe

