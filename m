Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266514AbUBETCU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 14:02:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266510AbUBETAU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 14:00:20 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:47066 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S266506AbUBES76 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 13:59:58 -0500
Content-Type: text/plain; charset=US-ASCII
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>, Daniel McNeil <daniel@osdl.org>
Subject: Re: [PATCH 2.6.2-rc3-mm1] DIO read race fix
Date: Thu, 5 Feb 2004 10:53:01 -0800
User-Agent: KMail/1.4.1
Cc: janetmor@us.ibm.com, linux-aio@kvack.org, linux-kernel@vger.kernel.org,
       suparna@in.ibm.com
References: <3FCD4B66.8090905@us.ibm.com> <1075945198.7182.46.camel@ibm-c.pdx.osdl.net> <20040204213336.354d8103.akpm@osdl.org>
In-Reply-To: <20040204213336.354d8103.akpm@osdl.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200402051053.01775.pbadari@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

I see uninitialized data  with this patch :(
I patched it manullay, so I might have missed something.
I will double check and let you know, if I patched incorrectly.


FYI.

Thanks,
Badari

On Wednesday 04 February 2004 09:33 pm, Andrew Morton wrote:

> Fix a race which was identified by Daniel McNeil <daniel@osdl.org>
>
> If a buffer_head is under I/O due to JBD's ordered data writeout (which
> uses ll_rw_block()) then either filemap_fdatawrite() or filemap_fdatawait()
> need to wait on the buffer's existing I/O.
>
> Presently neither will do so, because __block_write_full_page() will not
> actually submit any I/O and will hence not mark the page as being under
> writeback.
>
> The best-performing fix would be to somehow mark the page as being under
> writeback and defer waiting for the ll_rw_block-initiated I/O until
> filemap_fdatawait()-time.  But this is hard, because in
> __block_write_full_page() we do not have control of the buffer_head's
> end_io handler.  Possibly we could make JBD call into
> end_buffer_async_write(), but that gets nasty.
>
> This patch makes __block_write_full_page() wait for any buffer_head I/O to
> complete before inspecting the buffer_head state.  It only does this in the
> case where __block_write_full_page() was called for a "data-integrity"
> write: (wbc->sync_mode != WB_SYNC_NONE).
>
> Probably it doesn't matter, because kjournald is currently submitting (or
> has already submitted) all dirty buffers anyway.
>
>
>
> ---
>
>  fs/buffer.c |   29 +++++++++++++++--------------
>  1 files changed, 15 insertions(+), 14 deletions(-)
>
> diff -puN fs/buffer.c~O_DIRECT-ll_rw_block-vs-block_write_full_page-fix
> fs/buffer.c ---
> 25/fs/buffer.c~O_DIRECT-ll_rw_block-vs-block_write_full_page-fix	2004-02-04
> 20:38:30.000000000 -0800 +++ 25-akpm/fs/buffer.c	2004-02-04
> 20:40:19.000000000 -0800
> @@ -1810,23 +1810,24 @@ static int __block_write_full_page(struc
>
>  	do {
>  		get_bh(bh);
> -		if (buffer_mapped(bh) && buffer_dirty(bh)) {
> -			if (wbc->sync_mode != WB_SYNC_NONE) {
> -				lock_buffer(bh);
> -			} else {
> -				if (test_set_buffer_locked(bh)) {
> +		if (!buffer_mapped(bh))
> +			continue;
> +		if (wbc->sync_mode != WB_SYNC_NONE) {
> +			lock_buffer(bh);
> +		} else {
> +			if (test_set_buffer_locked(bh)) {
> +				if (buffer_dirty(bh))
>  					__set_page_dirty_nobuffers(page);
> -					continue;
> -				}
> -			}
> -			if (test_clear_buffer_dirty(bh)) {
> -				if (!buffer_uptodate(bh))
> -					buffer_error();
> -				mark_buffer_async_write(bh);
> -			} else {
> -				unlock_buffer(bh);
> +				continue;
>  			}
>  		}
> +		if (test_clear_buffer_dirty(bh)) {
> +			if (!buffer_uptodate(bh))
> +				buffer_error();
> +			mark_buffer_async_write(bh);
> +		} else {
> +			unlock_buffer(bh);
> +		}
>  	} while ((bh = bh->b_this_page) != head);
>
>  	BUG_ON(PageWriteback(page));
>
> _

