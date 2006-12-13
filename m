Return-Path: <linux-kernel-owner+w=401wt.eu-S964904AbWLMM0h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964904AbWLMM0h (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 07:26:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964906AbWLMM0h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 07:26:37 -0500
Received: from pat.uio.no ([129.240.10.15]:58535 "EHLO pat.uio.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964904AbWLMM0g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 07:26:36 -0500
Subject: Re: [PATCH] nfs: fix NR_FILE_DIRTY underflow
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1166011958.32332.97.camel@twins>
References: <1166011958.32332.97.camel@twins>
Content-Type: text/plain
Date: Wed, 13 Dec 2006 07:26:21 -0500
Message-Id: <1166012781.5695.18.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.33, required 12,
	autolearn=disabled, AWL 1.53, RCVD_IN_SORBS_DUL 0.14,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-12-13 at 13:12 +0100, Peter Zijlstra wrote:
> Still testing this patch, but it looks good so far.
> 
> ---
> Just setting PG_dirty can cause NR_FILE_DIRTY to underflow
> which is bad (TM).
> 
> Use set_page_dirty() which will do the right thing.

Actually, I'd prefer to have it do the right thing by getting rid of
that call to test_clear_page_dirty() inside
invalidate_inode_pages2_range(). That is causing loss of data integrity,
and is what is causing us to have to hack NFS in the first place.

Cheers
  Trond


> Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
> ---
>  fs/nfs/file.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: linux-2.6-git2/fs/nfs/file.c
> ===================================================================
> --- linux-2.6-git2.orig/fs/nfs/file.c	2006-12-13 12:54:55.000000000 +0100
> +++ linux-2.6-git2/fs/nfs/file.c	2006-12-13 12:55:12.000000000 +0100
> @@ -321,7 +321,7 @@ static int nfs_release_page(struct page 
>  	if (!(gfp & __GFP_FS))
>  		return 0;
>  	/* Hack... Force nfs_wb_page() to write out the page */
> -	SetPageDirty(page);
> +	set_page_dirty(page);
>  	return !nfs_wb_page(page->mapping->host, page);
>  }
>  
> 
> 

