Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030382AbWEKRnq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030382AbWEKRnq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 13:43:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030397AbWEKRnp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 13:43:45 -0400
Received: from smtp.osdl.org ([65.172.181.4]:32414 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030382AbWEKRnp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 13:43:45 -0400
Date: Thu, 11 May 2006 10:40:38 -0700
From: Andrew Morton <akpm@osdl.org>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, steved@redhat.com, trond.myklebust@fys.uio.no,
       aviro@redhat.com, linux-fsdevel@vger.kernel.org,
       linux-cachefs@redhat.com, nfsv4@linux-nfs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/14] FS-Cache: Release page->private in failed
 readahead [try #8]
Message-Id: <20060511104038.4ecad038.akpm@osdl.org>
In-Reply-To: <20060510160148.9058.81776.stgit@warthog.cambridge.redhat.com>
References: <20060510160111.9058.55026.stgit@warthog.cambridge.redhat.com>
	<20060510160148.9058.81776.stgit@warthog.cambridge.redhat.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:
>
> The attached patch causes read_cache_pages() to release page-private data on a
> page for which add_to_page_cache() fails or the filler function fails. This
> permits pages with caching references associated with them to be cleaned up.
> 

> ---
> 
>  mm/readahead.c |   16 ++++++++++++++++
>  1 files changed, 16 insertions(+), 0 deletions(-)
> 
> diff --git a/mm/readahead.c b/mm/readahead.c
> index 0f142a4..82deb7f 100644
> --- a/mm/readahead.c
> +++ b/mm/readahead.c
> @@ -141,6 +141,12 @@ int read_cache_pages(struct address_spac
>  		page = list_to_page(pages);
>  		list_del(&page->lru);
>  		if (add_to_page_cache(page, mapping, page->index, GFP_KERNEL)) {
> +			if (PagePrivate(page) && mapping->a_ops->releasepage) {
> +				page->mapping = mapping;
> +				mapping->a_ops->releasepage(page, GFP_KERNEL);
> +				page->mapping = NULL;
> +			}
> +				

That seems a bit hacky, really.  It'd be better to use
try_to_release_page().  It keeps stuff in one place, and what happens if
the filesystem decided to not implement ->releasepage() because it knows
that try_to_release_page() will default to try_to_free_buffers()?

The above code is identical to the below code, so a new helper function
would be appropriate.

>  			page_cache_release(page);
>  			continue;
>  		}
> @@ -153,6 +159,16 @@ int read_cache_pages(struct address_spac
>  
>  				victim = list_to_page(pages);
>  				list_del(&victim->lru);
> +
> +				if (PagePrivate(victim) &&
> +				    mapping->a_ops->releasepage
> +				    ) {
> +					victim->mapping = mapping;
> +					mapping->a_ops->releasepage(
> +						victim, GFP_KERNEL);
> +					victim->mapping = NULL;
> +				}

aaaarrrghhh.  David, _why_ do you insist on junk like this when you know
what the coding style is and you've repeatedly been asked to follow it?  I
mean, how hard is it?  How many similar uglies are hiding in this patchset?
(greps.  53 of them).  Ho hum.

I think the above will be called against an unlocked page, in which case
the ->releasepage() implementation might choose to go BUG, or something.
I suppose locking the page here will suffice.

But it all seems a bit abusive of what ->releasepage() is supposed to do.

add_to_page_cache() won't set PagePrivate() anyway, so what point is there
in the first hunk?

For the second hunk, is it not possible to do this cleanup in the callback
function?

If read_cache_pages() needs this treatment, shouldn't we also do it in
read_pages()?  And in mpage_readpages()?

Again, as this appears to be some special treatment for cachefs wouldn't it
be better to keep this special handling within cachefs?
