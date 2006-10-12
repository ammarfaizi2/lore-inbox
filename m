Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422752AbWJLDeB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422752AbWJLDeB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 23:34:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161367AbWJLDeA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 23:34:00 -0400
Received: from mx1.suse.de ([195.135.220.2]:33477 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1161366AbWJLDeA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 23:34:00 -0400
Date: Thu, 12 Oct 2006 05:33:58 +0200
From: Nick Piggin <npiggin@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Linux Memory Management <linux-mm@kvack.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch 2/5] mm: fault vs invalidate/truncate race fix
Message-ID: <20061012033358.GC22558@wotan.suse.de>
References: <20061010121314.19693.75503.sendpatchset@linux.site> <20061010121332.19693.37204.sendpatchset@linux.site> <20061010213843.4478ddfc.akpm@osdl.org> <452C838A.70806@yahoo.com.au> <20061010230042.3d4e4df1.akpm@osdl.org> <Pine.LNX.4.64.0610110916540.3952@g5.osdl.org> <20061011165717.GB5259@wotan.suse.de> <Pine.LNX.4.64.0610111007000.3952@g5.osdl.org> <20061011172120.GC5259@wotan.suse.de> <Pine.LNX.4.64.0610111031020.3952@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0610111031020.3952@g5.osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2006 at 10:38:31AM -0700, Linus Torvalds wrote:
> 
> 
> On Wed, 11 Oct 2006, Nick Piggin wrote:
> > 
> > I mean filemap_nopage does *two* synchronous reads when finding a !uptodate
> > page. This is despite the comment saying that it retries once on error.
> 
> Ahh. 
> 
> Yes, now that you point to the actual code, that does look ugly.
> 
> I think it's related to the
> 
> 	ClearPageError(page);
> 
> thing, and probably related to that function being rather old and having 
> gone through several re-organizations. I suspect we used to fall through 
> to the error handling code regardless of whether we did the read ourselves 
> etc.

Yeah, it may have even been a mismerge at some point in time.

> Are you saying that something like this would be preferable?

I think so, it is neater and clearer. I actually didn't even bother relocking
and checking the page again on readpage error so got rid of quite a bit of
code.

> 
> 		Linus
> 
> ---
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 3464b68..e5ecf42 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -1496,6 +1496,8 @@ page_not_uptodate:
>  		goto success;
>  	}
>  
> +	/* Clear any potential old errors, and try to read.. */
> +	ClearPageError(page);
>  	error = mapping->a_ops->readpage(file, page);
>  	if (!error) {
>  		wait_on_page_locked(page);
> @@ -1526,21 +1528,12 @@ page_not_uptodate:
>  		unlock_page(page);
>  		goto success;
>  	}
> -	ClearPageError(page);
> -	error = mapping->a_ops->readpage(file, page);
> -	if (!error) {
> -		wait_on_page_locked(page);
> -		if (PageUptodate(page))
> -			goto success;
> -	} else if (error == AOP_TRUNCATED_PAGE) {
> -		page_cache_release(page);
> -		goto retry_find;
> -	}
>  
>  	/*
>  	 * Things didn't work out. Return zero to tell the
>  	 * mm layer so, possibly freeing the page cache page first.
>  	 */
> +	unlock_page(page);
>  	shrink_readahead_size_eio(file, ra);
>  	page_cache_release(page);
>  	return NOPAGE_SIGBUS;
