Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161029AbWJDRZo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161029AbWJDRZo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 13:25:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964911AbWJDRZo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 13:25:44 -0400
Received: from smtp.osdl.org ([65.172.181.4]:27308 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964915AbWJDRZn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 13:25:43 -0400
Date: Wed, 4 Oct 2006 10:25:22 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeff Moyer <jmoyer@redhat.com>
Cc: linux-kernel@vger.kernel.org, zach.brown@oracle.com
Subject: Re: [patch] call truncate_inode_pages in the DIO fallback to
 buffered I/O path
Message-Id: <20061004102522.d58c00ef.akpm@osdl.org>
In-Reply-To: <x49zmcc6mhh.fsf@segfault.boston.devel.redhat.com>
References: <x49zmcc6mhh.fsf@segfault.boston.devel.redhat.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 04 Oct 2006 13:04:42 -0400
Jeff Moyer <jmoyer@redhat.com> wrote:

> Hi,
> 
> It seems that Oracle creates sparse files when doing table creates, and
> then populates those files using O_DIRECT I/O.  That means that every I/O to
> the sparse file falls back to buffered I/O.  Currently, such a sequential
> O_DIRECT write to a sparse file will end up populating the page cache.  The
> problem is that we don't invalidate the page cache pages used to perform
> the buffered fallback.

Why is this a problem?  It's just like someone did a write(), and we'll
invalidate the pagecache on the next direct-io operation.

>  After talking this over with Zach, we agreed that
> there should be a call to truncate_inode_pages_range after the buffered I/O
> fallback.
> 
> Attached is a patch which addresses the problem in my testing.  I wrote a
> simple test program that creates a sparse file and issues sequential DIO
> writes to it.  Before the patch, the page cache would grow as the file was
> written.  With the patch, the page cache does not grow.
> 
> Comments welcome.
> 
> Cheers,
> 
> Jeff
> 
> Signed-off-by: Jeff Moyer <jmoyer@redhat.com>
> 
> --- linux-2.6.18.i686/mm/filemap.c.orig	2006-10-02 12:59:25.000000000 -0400
> +++ linux-2.6.18.i686/mm/filemap.c	2006-10-04 12:54:51.000000000 -0400
> @@ -2350,7 +2350,7 @@ __generic_file_aio_write_nolock(struct k
>  				unsigned long nr_segs, loff_t *ppos)
>  {
>  	struct file *file = iocb->ki_filp;
> -	const struct address_space * mapping = file->f_mapping;
> +	struct address_space * mapping = file->f_mapping;
>  	size_t ocount;		/* original count */
>  	size_t count;		/* after file limit checks */
>  	struct inode 	*inode = mapping->host;
> @@ -2417,6 +2417,15 @@ __generic_file_aio_write_nolock(struct k
>  
>  	written = generic_file_buffered_write(iocb, iov, nr_segs,
>  			pos, ppos, count, written);
> +
> +	/*
> +	 *  When falling through to buffered I/O, we need to ensure that the
> +	 *  page cache pages are written to disk and invalidated to preserve
> +	 *  the expected O_DIRECT semantics.
> +	 */
> +	if (unlikely(file->f_flags & O_DIRECT))
> +		truncate_inode_pages_range(mapping, pos, pos + count - 1);
> +
>  out:
>  	current->backing_dev_info = NULL;
>  	return written ? written : err;

eek.  truncate_inode_pages() will throw away dirty data.  Very dangerous,
much chin-scratching needed.

It also has security implications: if a user can force this shootdown to
happen against dirty data at the right time (perhaps with multiple
processes) then a subsequent read of that part of the file will yield
uninitialised disk data.
