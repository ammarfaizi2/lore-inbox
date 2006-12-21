Return-Path: <linux-kernel-owner+w=401wt.eu-S1161149AbWLUChG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161149AbWLUChG (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 21:37:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161155AbWLUChG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 21:37:06 -0500
Received: from pat.uio.no ([129.240.10.15]:44079 "EHLO pat.uio.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161149AbWLUChE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 21:37:04 -0500
Subject: Re: [PATCH] mm: fix page_mkclean_one (was: 2.6.19 file content
	corruption on ext3)
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Linus Torvalds <torvalds@osdl.org>, Martin Michlmayr <tbm@cyrius.com>,
       Hugh Dickins <hugh@veritas.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Arjan van de Ven <arjan@infradead.org>,
       Andrei Popa <andrei.popa@i-neo.ro>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Florian Weimer <fw@deneb.enyo.de>,
       Marc Haber <mh+linux-kernel@zugschlus.de>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Heiko Carstens <heiko.carstens@de.ibm.com>,
       Arnd Bergmann <arnd.bergmann@de.ibm.com>, gordonfarquharson@gmail.com
In-Reply-To: <1166652901.30008.1.camel@twins>
References: <Pine.LNX.4.64.0612181151010.3479@woody.osdl.org>
	 <1166571749.10372.178.camel@twins>
	 <Pine.LNX.4.64.0612191609410.6766@woody.osdl.org>
	 <1166605296.10372.191.camel@twins>
	 <1166607554.3365.1354.camel@laptopd505.fenrus.org>
	 <1166614001.10372.205.camel@twins>
	 <Pine.LNX.4.64.0612201237280.28787@blonde.wat.veritas.com>
	 <1166622979.10372.224.camel@twins>
	 <20061220170323.GA12989@deprecation.cyrius.com>
	 <Pine.LNX.4.64.0612200928090.6766@woody.osdl.org>
	 <20061220175309.GT30106@deprecation.cyrius.com>
	 <Pine.LNX.4.64.0612201043170.6766@woody.osdl.org>
	 <Pine.LNX.4.64.0612201139280.3576@woody.osdl.org>
	 <1166652901.30008.1.camel@twins>
Content-Type: text/plain
Date: Wed, 20 Dec 2006 21:36:38 -0500
Message-Id: <1166668598.5909.38.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-5.0, required=12.0, autolearn=no, UIO_MAIL_IS_INTERNAL=-5)
X-UiO-SPAM-Test: UIO-GREYLIST 69.242.210.120 spam_score -49 maxlevel 200 minaction 2 bait 0 blacklist 0 greylist 1 ratelimit 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-12-20 at 23:15 +0100, Peter Zijlstra wrote:
> I think this is also needed:

NAK

invalidate_inode_pages2() should _not_ be pretending that dirty pages
are clean. This patch is incorrect both for the NFS usage and for the
directIO usage.

In the latter case, if someone has the page mmapped, resulting in the
page getting marked as dirty _after_ a directIO write, then it would be
wrong to discard that data. Only dirty data from _before_ the directIO
write should needs to be discarded (and that is achieved by unmapping,
then cleaning the page prior to the directIO call)...

For the NFS case, the race is a bit more tricky, since you have the
"unstable write" case which means that the page is neither marked as
dirty, nor is entirely clean ('cos we don't know that the server has
committed the data to permanent storage yet).

Cheers
  Trond

> ---
>  mm/truncate.c |    7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> Index: linux-2.6/mm/truncate.c
> ===================================================================
> --- linux-2.6.orig/mm/truncate.c
> +++ linux-2.6/mm/truncate.c
> @@ -320,19 +320,14 @@ invalidate_complete_page2(struct address
>  	if (PagePrivate(page) && !try_to_release_page(page, GFP_KERNEL))
>  		return 0;
>  
> +	cancel_dirty_page(page, PAGE_CACHE_SIZE);
>  	lock_page_ref_irq(page);
> -	if (PageDirty(page))
> -		goto failed;
> -
>  	BUG_ON(PagePrivate(page));
>  	__remove_from_page_cache(page);
>  	unlock_page_ref_irq(page);
>  	ClearPageUptodate(page);
>  	page_cache_release(page);	/* pagecache ref */
>  	return 1;
> -failed:
> -	unlock_page_ref_irq(page);
> -	return 0;
>  }
>  
>  /**
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

