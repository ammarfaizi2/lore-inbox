Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262736AbVDAOgh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262736AbVDAOgh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 09:36:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262745AbVDAOgf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 09:36:35 -0500
Received: from phoenix.infradead.org ([81.187.226.98]:21259 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261661AbVDAOga (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 09:36:30 -0500
Date: Fri, 1 Apr 2005 15:36:23 +0100 (BST)
From: "Artem B. Bityuckiy" <dedekind@infradead.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
cc: dwmw2@infradead.org, linux-kernel@vger.kernel.org,
       linux-crypto@vger.kernel.org
Subject: Re: [RFC] CryptoAPI & Compression
In-Reply-To: <E1DGxa7-0000GH-00@gondolin.me.apana.org.au>
Message-ID: <Pine.LNX.4.58.0504011534460.9305@phoenix.infradead.org>
References: <E1DGxa7-0000GH-00@gondolin.me.apana.org.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dedekind@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Herbert,

> For the default zlib parameters (which crypto/deflate.c does not use)
> the maximum overhead is 5 bytes every 16KB plus 6 bytes.  So for input
> streams less than 16KB the figure of 12 bytes is correct.  However,
> in general the overhead needs to grow proportionally to the number of
> blocks in the input.

I've explored the issue a bit. According RFC-1950 and RFC-1951, zlib 
stream is:

2bytes zstream header, block1, block2, ... 4bytes adler32.
Each block has one 1-byte "end-of-block" marker and a prefix of max len = 
1 byte.

In our code we do zlib_deflate(stream, Z_SYNC_FLUSH), so we always flush 
the output. So the final zlib_deflate(stream, Z_FINISH) requires 1 byte 
for the EOB marker and 4 bytes for adler32 (5 bytes total). Thats all. If 
we compress a huge buffer, then we still need to output those 5 bytes as 
well. I.e, the overhead of each block *is not accumulated* ! I even need 
to make the reserved space less then 12 bytes!

Anyway, don't apply that patch please, I'll send a new one.

--
Best Regards,
Artem B. Bityuckiy,
St.-Petersburg, Russia.
