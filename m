Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945957AbWJSBm0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945957AbWJSBm0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 21:42:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945958AbWJSBm0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 21:42:26 -0400
Received: from agminet01.oracle.com ([141.146.126.228]:37477 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1945957AbWJSBmZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 21:42:25 -0400
Date: Wed, 18 Oct 2006 18:42:09 -0700
From: Mark Fasheh <mark.fasheh@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: nickpiggin@yahoo.com.au, npiggin@suse.de, akpm@osdl.org
Subject: Re: + fs-prepare_write-fixes.patch added to -mm tree
Message-ID: <20061019014209.GA10128@ca-server1.us.oracle.com>
Reply-To: Mark Fasheh <mark.fasheh@oracle.com>
References: <200610182150.k9ILoLNk019702@shell0.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200610182150.k9ILoLNk019702@shell0.pdx.osdl.net>
Organization: Oracle Corporation
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

On Wed, Oct 18, 2006 at 02:50:21PM -0700, akpm@osdl.org wrote:
> Some prepare/commit_write implementations have possible pre-existing bugs,
> possible data leaks (by setting uptodate too early) and data corruption (by
> not reading in non-modified parts of a !uptodate page).
> 
> Others are (also) broken when commit_write passes in a 0 length commit with
> a !uptodate page (a change caused by buffered write deadlock fix patch).
> 
> Fix filesystems as best we can.  GFS2, OCFS2, Reiserfs, JFFS are nontrivial
> and are likely broken.  All others at least need a glance.
I would have liked a CC on this patch, considering that ypu might have just
broken ocfs2 :) I wouldn't have even seen the patch had I not been looking
through my mm-commits mailbox for an unrelated patch.


>    commit_write: If prepare_write succeeds, new data will be copied
> -        into the page and then commit_write will be called.  It will
> -        typically update the size of the file (if appropriate) and
> -        mark the inode as dirty, and do any other related housekeeping
> -        operations.  It should avoid returning an error if possible -
> -        errors should have been handled by prepare_write.
> +        into the page and then commit_write will be called. commit_write may
> +	be called with a range that is smaller than that passed in to
> +	prepare_write, it could even be zero. If the page is not uptodate,
> +	the range will *only* be zero or the full length that was passed to
> +	prepare_write, if it is zero, the page should not be marked uptodate
> +	(success should still be returned, if possible -- the write will be
> +	retried).
Doesn't this scheme have the potential to leave dirty data in holes? If a
file system does it's allocation for a hole in the middle of a file (so no
i_size update) in ->prepare_write(), but then in ->commit_write() it's not
allowed to write out the page, or add it to a transaction (in the case of
ext3/ocfs2 ordered writes), we might commit the allocation tree changes
without writing data to the actual disk region that the allocation covers. A
subsequent read would then return whatever junk was on disk.


> diff -puN fs/ext3/inode.c~fs-prepare_write-fixes fs/ext3/inode.c
> --- a/fs/ext3/inode.c~fs-prepare_write-fixes
> +++ a/fs/ext3/inode.c
> @@ -1214,21 +1214,24 @@ static int ext3_ordered_commit_write(str
>  	struct inode *inode = page->mapping->host;
>  	int ret = 0, ret2;
>  
> -	ret = walk_page_buffers(handle, page_buffers(page),
> -		from, to, NULL, ext3_journal_dirty_data);
> +	if (to - from > 0) {
> +		ret = walk_page_buffers(handle, page_buffers(page),
> +			from, to, NULL, ext3_journal_dirty_data);
I think this perhaps illustrates my worry. If we don't add all the page
buffers to the transaction which cover a hole that was filled in
->prepare_write(), we'll commit at the bottom of ext3_ordered_commit_write()
without having covered the entire range which we allocated for.


What probably needs to happen is one of two things:

a) The file system rolls back the allocation

b) We somehow write zero's to the part of the region skipped before
   ->commit_write() returns.

Thanks,
	--Mark

--
Mark Fasheh
Senior Software Developer, Oracle
mark.fasheh@oracle.com
