Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932100AbWF0GBD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932100AbWF0GBD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 02:01:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932104AbWF0GBC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 02:01:02 -0400
Received: from rhun.apana.org.au ([64.62.148.172]:10761 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S932100AbWF0GBA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 02:01:00 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: nigel@suspend2.net
Subject: Re: [Suspend2][ 0/2] Cryptoapi deflate fix.
Cc: rjw@sisk.pl, linux-kernel@vger.kernel.org
Organization: Core
In-Reply-To: <200606270852.54153.nigel@suspend2.net>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.6.17-rc4 (i686))
Message-Id: <E1Fv6cg-000617-00@gondolin.me.apana.org.au>
Date: Tue, 27 Jun 2006 16:00:30 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nigel Cunningham <nigel@suspend2.net> wrote:
> 
> Sorry for the bad choice of heading. I have posted this before and emailed it 
> direct to Herbert, but he (rightly) doesn't see the need while suspend2 isn't 
> merged.

Hmm, I don't recall ever telling you that.

I searched through my mail archive here is what I said to you last year
on these two patches.  As far as I can see I don't have a reply from you
on either subject.  So if you could reply to my questions below then I
can consider your patches again.

1. Deflate fix:

> > Hi Nigel, I need a bit more information about this patch.
> > Do you have a specific input stream that requires a fix like
> > this?
> 
> Yes, Suspend2 if the user selects deflate as their compressor. The
> output data will be PAGE_SIZE chunks, but deflate sometimes thinks it
> has an extra byte to give us back.

Are you saying that you're feeding it PAGE_SIZE chunks and it's
giving you back something bigger than a page? That is expected
since the nature of compression in general is that not everything
is compressible.  Data streams which are not compressible will
end up bigger than what you start with.

What would be a bug is if you feed it something that's
deflateBound^-1(PAGE_SIZE) bytes long and it spits back
something that's longer than a page.

> I agree that it's ugly and don't recall using it when I had gzip support
> in an earlier version of Suspend2. Are you thinking there might be a
> better way? If so, I can dig out the old (non crypto api) code.

Well if you could give me a snippet of code that actually uses this
stuff to compress pages then I might have a better idea of what it's
trying to do.

2. LZF:

> +static int lzf_compress_init(void *context)
> +{
> +     struct lzf_ctx *ctx = (struct lzf_ctx *)context;
> +
> +     /* Get LZF ready to go */
> +     ctx->hbuf = vmalloc_32((1 << hlog) * sizeof(char *));

Any reason why vmalloc can't be used?

> +     /* Allocate local buffer */
> +     ctx->local_buffer = (char *)get_zeroed_page(GFP_ATOMIC);

> +     /* Allocate page buffer */
> +     ctx->page_buffer = (char *)get_zeroed_page(GFP_ATOMIC);

Where are these two buffers used anyway?

> +     if (!ctx->page_buffer) {
> +             free_page((unsigned long)ctx->local_buffer);
> +             lzf_compress_exit(ctx);

This is a double-free of local_buffer.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
