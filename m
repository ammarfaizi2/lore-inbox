Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751151AbWJLWBx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751151AbWJLWBx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 18:01:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751171AbWJLWBx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 18:01:53 -0400
Received: from mx1.redhat.com ([66.187.233.31]:52657 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751151AbWJLWBw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 18:01:52 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: Zach Brown <zach.brown@oracle.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] call truncate_inode_pages in the DIO fallback to buffered I/O path
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
X-PCLoadLetter: What the f**k does that mean?
References: <x49zmcc6mhh.fsf@segfault.boston.devel.redhat.com>
	<20061004102522.d58c00ef.akpm@osdl.org> <4523F486.1000604@oracle.com>
	<x49mz8c6k83.fsf@segfault.boston.devel.redhat.com>
	<20061004111603.20cdaa35.akpm@osdl.org> <45240034.2040704@oracle.com>
	<20061004121645.fd2765e4.akpm@osdl.org>
	<x49ejtn7qfy.fsf@segfault.boston.devel.redhat.com>
	<20061004165504.c1dd3dd3.akpm@osdl.org>
	<x49ac4a5zkw.fsf@segfault.boston.devel.redhat.com>
	<20061006131148.9c6b88ab.akpm@osdl.org> <m3odsi4x3a.fsf@redhat.com>
	<20061011113720.463e331c.akpm@osdl.org>
From: Jeff Moyer <jmoyer@redhat.com>
Date: Thu, 12 Oct 2006 18:01:43 -0400
In-Reply-To: <20061011113720.463e331c.akpm@osdl.org> (Andrew Morton's message of "Wed, 11 Oct 2006 11:37:20 -0700")
Message-ID: <x491wpdb3co.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.5-b27 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

==> Regarding Re: [patch] call truncate_inode_pages in the DIO fallback to buffered I/O path; Andrew Morton <akpm@osdl.org> adds:

akpm> So I'd propose:

> diff -puN mm/filemap.c~direct-io-sync-and-invalidate-file-region-when-falling-back-to-buffered-write-fix mm/filemap.c
> --- a/mm/filemap.c~direct-io-sync-and-invalidate-file-region-when-falling-back-to-buffered-write-fix
> +++ a/mm/filemap.c
> @@ -2291,19 +2291,30 @@ __generic_file_aio_write_nolock(struct k
>  		written_buffered = generic_file_buffered_write(iocb, iov,
>  						nr_segs, pos, ppos, count,
>  						written);
> +		/*
> +		 * If generic_file_buffered_write() retuned a synchronous error
> +		 * then we want to return the number of bytes which were
> +		 * direct-written, or the error code if that was zero.  Note
> +		 * that this differs from normal direct-io semantics, which
> +		 * will return -EFOO even if some bytes were written.
> +		 */
> +		if (written_buffered < 0) {
> +			err = written_buffered;
> +			goto out;
> +		}

>  		/*
>  		 * We need to ensure that the page cache pages are written to
>  		 * disk and invalidated to preserve the expected O_DIRECT
>  		 * semantics.
>  		 */
> -		endbyte = pos + written_buffered - 1;
> +		endbyte = pos + written_buffered - written - 1;
>  		err = do_sync_file_range(file, pos, endbyte,
>  					 SYNC_FILE_RANGE_WAIT_BEFORE|
>  					 SYNC_FILE_RANGE_WRITE|
>  					 SYNC_FILE_RANGE_WAIT_AFTER);
>  		if (err == 0) {
> -			written += written_buffered;
> +			written = written_buffered;
>  			invalidate_mapping_pages(mapping,
>  						 pos >> PAGE_CACHE_SHIFT,
>  						 endbyte >> PAGE_CACHE_SHIFT);
> _

This passes my tests and the Oracle tests that triggered the problem in the
first place.  Thanks!

Acked-by: Jeff Moyer <jmoyer@redhat.com>
