Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261678AbVCYQIb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261678AbVCYQIb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 11:08:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261683AbVCYQIa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 11:08:30 -0500
Received: from [213.170.72.194] ([213.170.72.194]:59076 "EHLO
	shelob.oktetlabs.ru") by vger.kernel.org with ESMTP id S261678AbVCYQIY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 11:08:24 -0500
Subject: [RFC] CryptoAPI & Compression
From: "Artem B. Bityuckiy" <dedekind@infradead.org>
Reply-To: dedekind@infradead.org
To: herbert@gondor.apana.org.au
Cc: dwmw2@infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: MTD
Date: Fri, 25 Mar 2005 19:08:20 +0300
Message-Id: <1111766900.4566.20.camel@sauron.oktetlabs.ru>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Herbert and others,

I'm working on cleaning-up the JFFS3 compression stuff. JFFS3 contains a
number of compressors which actually shouldn't be there as they are
platform-independent and generic. So we want to move them to the generic
part of the Linux kernel instead of storing them in fs/jffs2/. And we
were going to use CryptoAPI to access the compressors.

But I've hit on a problem - CryptoAPI's compression method isn't
flexible enough for us.

CryptoAPI's compress method is:

int crypto_compress(struct crypto_tfm *tfm,
                    const u8 *src, unsigned int slen,
                    u8 *dst, unsigned int *dlen);

*src - input data;
slen - input data length;
*dst - output data;
*dlen - on input - output buffer length, on output - the length of the
compressed data;

The crypto_compress() API call either compresses all the input data or
returns error.

In JFFS2 we need something more flexible. Te following is what we want:

int crypto_compress_ext(struct crypto_tfm *tfm,
                    const u8 *src, unsigned int *slen,
                    u8 *dst, unsigned int *dlen);

*src - input data;
*slen - on input - input data length, on output - the amount of data
that were actually compressed.
*dst - output data;
*dlen - on input - output buffer length, on output - the length of the
compressed data;

This would allow us (and we really need this) to provide a large input
data buffer, a small output data buffer and to ask the compressor to
compress as much input data as it can to fit (in the compressed form) to
the output buffer. To put it differently, we often have a large input,
and several smalloutput buffers, and we want to compress the input data
to them.

I offer to extend the CryptoAPI and add an "extended compress" API call
with the above mentioned capabilities. We might as well just change the
crypto_compress() and all its users.

Alternatively, we may create some kind of "Compression API" but I don't
like this idea...

Comments?

-- 
Best Regards,
Artem B. Bityuckiy,
St.-Petersburg, Russia.

