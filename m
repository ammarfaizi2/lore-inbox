Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266242AbUIEKyc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266242AbUIEKyc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 06:54:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266273AbUIEKyc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 06:54:32 -0400
Received: from fw.osdl.org ([65.172.181.6]:7571 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266242AbUIEKy3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 06:54:29 -0400
Date: Sun, 5 Sep 2004 03:52:33 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andrey Savochkin <saw@saw.sw.com.sg>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Q about pagecache data never written to disk
Message-Id: <20040905035233.6a6b5823.akpm@osdl.org>
In-Reply-To: <20040905120147.A9202@castle.nmd.msu.ru>
References: <20040905120147.A9202@castle.nmd.msu.ru>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrey Savochkin <saw@saw.sw.com.sg> wrote:
>
> Let's suppose an mmap'ed (SHARED, RW) file has a hole.
>  AFAICS, we allow to dirty the file pages without allocating the space for the
>  hole - filemap_nopage just "reads" the page filling it with zeroes, and
>  nothing is done about the on-disk data until writepage.
> 
>  So, if the page can't be written to disk (no space), the dirty data just
>  stays in the pagecache.  The data can be read or seen via mmap, but it isn't
>  and never be on disk.  The pagecache stays unsynchronized with the on-disk
>  content forever.

The kernel will make one attampt to write the data to disk.  If that write
hits ENOSPC, the page is not redirtied (ie: the data can be lost).

When that write hits ENOSPC an error flag is set in the address_space and
that will be returned from a subsequent msync().  The application will then
need to do something about it.

If your application doesn't msync() the memory then it doesn't care about
its data anyway.  If your application _does_ msync the pages then we
reliably report errors.

>  Is it the intended behavior?
>  Shouldn't we call the filesystem to fill the hole at the moment of the first
>  write access?

That would be a retrograde step - it would be nice to move in the other
direction: perform disk allocation at writeback time rather than at write()
time, even for regular write() data.  To do that we (probably) need space
reservation APIs.  And yes, we perhaps could reserve space in the
filesystem when that page is first written to.

But then what would we do if there's no space?  SIGBUS?  SIGSEGV? 
Inappropriate.  SIGENOSPC?

