Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264405AbUENCxk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264405AbUENCxk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 22:53:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264406AbUENCxk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 22:53:40 -0400
Received: from fw.osdl.org ([65.172.181.6]:4001 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265119AbUENCxi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 22:53:38 -0400
Date: Thu, 13 May 2004 19:53:10 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Subject: Re: [RFC/RFT] [PATCH] EXT3: Retry allocation after journal commit
Message-Id: <20040513195310.5725fa43.akpm@osdl.org>
In-Reply-To: <E1BOQmf-0005cP-4Q@thunk.org>
References: <E1BOQmf-0005cP-4Q@thunk.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Theodore Ts'o" <tytso@mit.edu> wrote:
>
> It is possible for block allocation to fail, even if there is space in
>  the filesystem, because all of the free blocks were recently deleted and
>  so could not be allocated until after the currently running transaction
>  is committed.   This can result in a very strange and surprising result
>  where a system call such as a mkdir() will fail even though there is
>  plenty of disk space apparently available.

I merged a little patch for this into post-2.6.6, but that only addresses
prepare_write().

I wonder if there's much value in having ext3_has_free_blocks()?  We could
just retry three times even if the fs is really full?

I'd be inclined to pass a pointer to the `retry' counter into
ext3_should_retry_alloc() and implement the counting in there.  It'll tidy
things up a bit and consolidates that piece of policy in a single place.

