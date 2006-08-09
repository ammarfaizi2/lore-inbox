Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965099AbWHII74@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965099AbWHII74 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 04:59:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965106AbWHII74
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 04:59:56 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:58026 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965099AbWHII7z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 04:59:55 -0400
Date: Wed, 9 Aug 2006 09:59:46 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Alexander Zarochentsev <zam@namesys.com>
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       reiserfs-dev@namesys.com, linux-kernel@vger.kernel.org
Subject: Re: partial reiser4 review comments
Message-ID: <20060809085946.GA6177@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Alexander Zarochentsev <zam@namesys.com>,
	Andrew Morton <akpm@osdl.org>, reiserfs-dev@namesys.com,
	linux-kernel@vger.kernel.org
References: <20060803001741.4ee9ff72.akpm@osdl.org> <20060803142644.GC20405@infradead.org> <200608061838.35004.zam@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608061838.35004.zam@namesys.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 06, 2006 at 06:38:34PM +0400, Alexander Zarochentsev wrote:
> > > - reiser4_readpages() shouldn't need to clean up the remaining
> > > pages on *pages.  read_cache_pages() does that now.
> >
> > Without looking at the code I remember someone from the Namesys
> > people told me they could use plain mpage_readpages now.  Anything
> > still blocking using that function?
> 
> reiser4 tries to reduce number of tree lookups. better, if there would 
> be one tree lookup for one readpages call.

Right now mpage_redpages does one get_block per extent.  I think it's
pretty messy do do one block allocator call that can return multiple
extents because that leads into a lot of complexity for a rather
questionable gain.(XFS on IRIX does that)

> 
> what we are currently doing in a not-yet-submitted patch (below), i 
> don't see how it can be done by mpage_readpages.
> 
> +struct uf_readpages_context {
> +	lock_handle lh;
> +	coord_t coord;
> +};

I must admit that standalone code snipplet doesn't really tell me a lot.
Do you mean the possibility to pass around a filesystem-defined structure
to multiple allocator calls?  I'm pretty sure can add that, I though it
would be useful multiple times in the past but always found ways around
it.

> BTW, read_cache_page() and mpage_readpages are similar, I guess the 
> second can be rewritten using the first one, no?

Do you mean read_cache_page() or read_cache_pages() ?

(Yeah, it really bad that we have two functions sounding the same but doing
thing quite differently..)

read_cache_pages() could probably be folded into mpages_readpages by allowing
it to give an additional readpage callback similar to how mpage_writepages
can either do real direct to bio or be used as an interator over writepages
calls.

read_cache_page() is quite different from read_cache_pages() and
mpages_readpages in that it is synchronous and waits for the read to complete
before returning.
