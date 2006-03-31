Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751188AbWCaCoI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751188AbWCaCoI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 21:44:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751195AbWCaCoI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 21:44:08 -0500
Received: from smtp.osdl.org ([65.172.181.4]:10717 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751188AbWCaCoH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 21:44:07 -0500
Date: Thu, 30 Mar 2006 18:43:25 -0800
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: torvalds@osdl.org, jeff@garzik.org, axboe@suse.de, mingo@elte.hu,
       linux-kernel@vger.kernel.org, Robert S Peterson <rpeterso@redhat.com>
Subject: Re: [PATCH] splice support #2
Message-Id: <20060330184325.35e21117.akpm@osdl.org>
In-Reply-To: <442C7EF5.8090703@yahoo.com.au>
References: <20060330100630.GT13476@suse.de>
	<20060330120055.GA10402@elte.hu>
	<20060330120512.GX13476@suse.de>
	<Pine.LNX.4.64.0603300853190.27203@g5.osdl.org>
	<442C440B.2090700@garzik.org>
	<Pine.LNX.4.64.0603301259220.27203@g5.osdl.org>
	<442C7EF5.8090703@yahoo.com.au>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <nickpiggin@yahoo.com.au> wrote:
>
> Also,
>  might you be able to do a single file-sized file<->file splice,
>  and have it do a remote copy on a suitable network fs

splice() may not be suitable for such filesystems.  Quoting Robert Peterson
from earlier this week:


> The problem is that
> loop.c circumvents proper locking by going directly to prepare_write
> rather than following the normal process.  If I added some kind of
> library callbacks to allow cluster locking, it would break the
> normal locking sequence of an ordinary write.
>
> The normal sequence of an ordinary write typically looks like:
>
> 1. write
> 2.   (Take care of cluster locking if necessary)
> 3.   generic_file_write_nolock
> 4.      generic_file_aio_write_nolock
> 5.         generic_file_buffered_write
> 6.            a_ops->prepare_write
> etc.
>
> Right now, loop.c is circumventing step 2 (optional cluster locking
> if needed by the underlying fs) by bypassing the "write" op.  If I 
> added callbacks to prepare_write at (7) as you suggest, it would either
> (a) introduce deadlocks conflicting with step 2 above or
> (b) require the underlying fs to use its own versions of 3,4,5, and 6,
> thus bypassing a great deal of vfs, which is not good for anyone.
>
> Some could argue that loop.c should always use write rather than
> prepare_write/commit_write, but most fs's don't have special
> locking needs and therefore using them is a performance boost.
>
