Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030692AbWKOQrF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030692AbWKOQrF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 11:47:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030691AbWKOQrF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 11:47:05 -0500
Received: from smtp.osdl.org ([65.172.181.4]:58496 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030693AbWKOQrB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 11:47:01 -0500
Date: Wed, 15 Nov 2006 08:46:41 -0800
From: Andrew Morton <akpm@osdl.org>
To: Trond Myklebust <Trond.Myklebust@netapp.com>
Cc: Charles Edward Lever <chucklever@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Yet another borken page_count() check in
 invalidate_inode_pages2()....
Message-Id: <20061115084641.827494be.akpm@osdl.org>
In-Reply-To: <1163596689.5691.40.camel@lade.trondhjem.org>
References: <1163568819.5645.8.camel@lade.trondhjem.org>
	<1163596689.5691.40.camel@lade.trondhjem.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Nov 2006 08:18:09 -0500
Trond Myklebust <Trond.Myklebust@netapp.com> wrote:

> The following patch allows try_to_release_page() to wait on page writeback
> instead of failing if the user specified __GFP_WAIT.
> 
> The reason is that when running NetApp's simulated I/O tool (sio_ntap) on
> the NFS client, I can currently reliably trigger the WARN_ON() in
> invalidate_inode_pages2().
> Whereas we do wait on page_writeback in invalidate_inode_pages2_range(), we
> do so before we unmap the page. There is still a race which will cause the
> call to try_to_release_page() to fail the test for PageWriteback(page).
> 
> Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>
> ---
> 
>  mm/filemap.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 7b84dc8..d37f77b 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -2445,7 +2445,9 @@ int try_to_release_page(struct page *pag
>  	struct address_space * const mapping = page->mapping;
>  
>  	BUG_ON(!PageLocked(page));
> -	if (PageWriteback(page))
> +	if (gfp_mask & __GFP_WAIT)
> +		wait_on_page_writeback(page);
> +	else if (PageWriteback(page))
>  		return 0;
>  
>  	if (mapping && mapping->a_ops->releasepage)

The change probably makes sense.  Need to think about that a bit more and
review callers..

But I don't see how it can change invalidate_inode_pages2().  What we
would effectively have is: 

invalidate_inode_pages2_range()
{
	lock_page(page);
	wait_on_page_writeback(page);

	...

				
	wait_on_page_writeback(page);

but nobody could have started another writeback after the "..." because they
couldn't have got the lock_page(), and lock_page() is required for
->writepage()?


