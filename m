Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932625AbWCPA3J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932625AbWCPA3J (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 19:29:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932626AbWCPA3J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 19:29:09 -0500
Received: from smtp.osdl.org ([65.172.181.4]:30679 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932625AbWCPA3G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 19:29:06 -0500
Date: Wed, 15 Mar 2006 16:31:19 -0800
From: Andrew Morton <akpm@osdl.org>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: Ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] Make use of PageMappedToDisk() to improve ext3
Message-Id: <20060315163119.5d5efe28.akpm@osdl.org>
In-Reply-To: <1142457602.21442.114.camel@dyn9047017100.beaverton.ibm.com>
References: <1142457602.21442.114.camel@dyn9047017100.beaverton.ibm.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari Pulavarty <pbadari@us.ibm.com> wrote:
>
> Hi Andrew,
> 
> Here is my first pass at making use of PageMappedToDisk() to avoid
> ext3 prepare_write/commit_write handling + journaling.
> 
> I see significant improvements with my micro benchmarks for over-write
> (pages again & again) case. Does this look right to you ?
> 
> 	2.6.16-rc6	2.6.16-rc6+patch
> real	0m6.606s	0m3.705s
> user	0m0.124s	0m0.108s
> sys	0m6.456s	0m3.600s
> 

Those numbers are suspiciously good.  No I/O involved, so I spose it makes
sense.

I suggest you test this with fsx-linux on a 1k blocksize filesystem with lots
of pageout pressure happening.  With a combination of mmapped writes and
write()s.

> 
> Make use of PageMappedToDisk(page) to find out if we need to
> block allocation and skip the calls to it, if not needed.
> When we are not doing block allocation, also avoid calls
> to journal start and adding buffers to transaction.

I worry about this:

> ===================================================================
> --- linux-2.6.16-rc6.orig/fs/buffer.c	2006-03-11 14:12:55.000000000 -0800
> +++ linux-2.6.16-rc6/fs/buffer.c	2006-03-15 13:05:26.000000000 -0800
> @@ -2051,8 +2051,10 @@ static int __block_commit_write(struct i
>  	 * the next read(). Here we 'discover' whether the page went
>  	 * uptodate as a result of this (potentially partial) write.
>  	 */
> -	if (!partial)
> +	if (!partial) {
>  		SetPageUptodate(page);
> +		SetPageMappedToDisk(page);
> +	}
>  	return 0;
>  }

We're setting SetPageMappedToDisk here if all the buffers are uptodate. 
But that doesn't mean they're mapped to disk!  They could be over file
holes and they were brought uptodate with memset.

Are you really sure that we're clearing PageMappedToDisk in all the right
places?  Truncate...

> Index: linux-2.6.16-rc6/fs/ext3/inode.c
> ===================================================================
> --- linux-2.6.16-rc6.orig/fs/ext3/inode.c	2006-03-11 14:12:55.000000000 -0800
> +++ linux-2.6.16-rc6/fs/ext3/inode.c	2006-03-15 13:09:14.000000000 -0800
> @@ -999,6 +999,13 @@ static int ext3_prepare_write(struct fil
>  	handle_t *handle;
>  	int retries = 0;
>  
> +
> +	/*
> + 	 * If the page is already mapped to disk and we are not
> +	 * journalling the data - there is nothing to do.
> +	 */
> +	if (PageMappedToDisk(page) && !ext3_should_journal_data(inode))
> +		return 0;

Yipes.  So we're not attaching the buffers to the journal at all in this
case.  So if nothing has been physically written to the disk yet, a
crash+recovery will expose unwritten-to disk blocks.

OK, that might not happen with this patch because __block_commit_write() is
presently checking BH_uptodate rather than BH_mapped.  And a file hole will
still be a file hole after the crash+recovery.  But if
__block_commit_write() is changed to test buffer_mapped(), I _think_ we can
leak uninitialised data on recovery.

Or maybe you thought all this through and didn't tell me :(

Either way, this optimisation (not attaching the ordered-mode buffers to
the transaction) worries me.  It's largely unrelated to the
PageMappedToDisk() optimisation and should be coded and thought about
separately.  It's a significant change in ordered-mode ext3 semantics.

