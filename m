Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261620AbVGaFOH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261620AbVGaFOH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 01:14:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261626AbVGaFOH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 01:14:07 -0400
Received: from [203.171.93.254] ([203.171.93.254]:4061 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S261620AbVGaFOF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 01:14:05 -0400
Subject: Re: [PATCH] Fix cryptoapi deflate not handling PAGE_SIZE chunks.
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050731034010.GA5564@gondor.apana.org.au>
References: <1121657195.13487.36.camel@localhost>
	 <20050731034010.GA5564@gondor.apana.org.au>
Content-Type: text/plain
Organization: Cycades
Message-Id: <1122786842.4351.8.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Sun, 31 Jul 2005 15:14:02 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Sun, 2005-07-31 at 13:40, Herbert Xu wrote:
> On Mon, Jul 18, 2005 at 01:26:35PM +1000, Nigel Cunningham wrote:
> > 
> > Here's a resend of a patch I'm using in Suspend2's new cryptoapi
> > support, which is needed for us to successfully compress pages using
> > deflate. It's along the lines of the existing fix in the decompression
> > code.
> >
> > diff -ruNp 190-cryptoapi-deflate.patch-old/crypto/deflate.c 190-cryptoapi-deflate.patch-new/crypto/deflate.c
> > --- 190-cryptoapi-deflate.patch-old/crypto/deflate.c	2005-06-20 11:46:49.000000000 +1000
> > +++ 190-cryptoapi-deflate.patch-new/crypto/deflate.c	2005-07-04 23:14:20.000000000 +1000
> > @@ -143,8 +143,15 @@ static int deflate_compress(void *ctx, c
> >  
> >  	ret = zlib_deflate(stream, Z_FINISH);
> >  	if (ret != Z_STREAM_END) {
> > -		ret = -EINVAL;
> > -		goto out;
> > +	    	if (!(ret == Z_OK && !stream->avail_in && !stream->avail_out)) {
> > +			ret = -EINVAL;
> > +			goto out;
> > +		} else {
> > +			u8 zerostuff = 0;
> > +			stream->next_out = &zerostuff;
> > +			stream->avail_out = 1; 
> > +			ret = zlib_deflate(stream, Z_FINISH);
> > +		}
> >  	}
> >  	ret = 0;
> >  	*dlen = stream->total_out;
> 
> Hi Nigel, I need a bit more information about this patch.
> Do you have a specific input stream that requires a fix like
> this?

Yes, Suspend2 if the user selects deflate as their compressor. The
output data will be PAGE_SIZE chunks, but deflate sometimes thinks it
has an extra byte to give us back.

I agree that it's ugly and don't recall using it when I had gzip support
in an earlier version of Suspend2. Are you thinking there might be a
better way? If so, I can dig out the old (non crypto api) code.

Regards,

Nigel
-- 
Evolution.
Enumerate the requirements.
Consider the interdependencies.
Calculate the probabilities.

